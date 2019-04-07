<template>
  <auth-layout>
    <template slot="header">
      Sign in
    </template>

    <template
      v-if="notification.message"
      slot="notification"
    >
      <div
        :class="notification.colorClass"
        class="notification"
      >
        {{ notification.message }}
      </div>
    </template>

    <form @submit.prevent="onSubmit">
      <b-field
        label="Email address"
        label-for="email"
        :type="{ 'is-danger': errors.email }"
        :message="errors.email"
      >
        <b-input
          id="email"
          ref="email"
          v-model="form.email"
          type="email"
          icon="envelope"
          placeholder="Email address"
          :use-html5-validation="false"
          required
          autocomplete="email"
        />
      </b-field>

      <b-field
        label="Password"
        label-for="password"
        :type="{ 'is-danger': errors.password }"
        :message="errors.password"
      >
        <b-input
          id="password"
          ref="password"
          v-model="form.password"
          type="password"
          icon="lock"
          placeholder="********"
          :use-html5-validation="false"
          required
          autocomplete="current-password"
        />
      </b-field>

      <b-field>
        <p class="control">
          <button
            :class="{'is-loading': ui.isSubmitting}"
            class="button is-success is-fullwidth"
          >
            Sign in
          </button>
        </p>
      </b-field>
    </form>
  </auth-layout>
</template>
<script>
import { signIn } from '@/api/auth'

export default {
  metaInfo: {
    title: 'Sign in'
  },
  data () {
    return {
      form: {
        email: this.email,
        password: ''
      },
      notification: {
        message: ''
      },
      ui: {
        isSubmitting: false
      },
      errors: {
        email: '',
        password: ''
      }
    }
  },
  mounted () {
    this.$refs.email.focus()
  },
  methods: {
    async onSubmit () {
      this.errors.email = ''
      this.errors.password = ''

      this.ui.isSubmitting = true
      const data = await signIn(this.form.email, this.form.password)
      this.ui.isSubmitting = false

      if (data.errors) {
        for (let error of data.errors) {
          if (error.code === 'unknown_email') {
            this.errors.email += ' Unknown email address.'
          } else if (error.code === 'bad_password') {
            this.errors.password += ' Incorrect password.'
          } else {
            this.errors.email += ` Unexpected error. ${error.message}`
          }
        }
        return
      }

      this.$router.replace({ name: 'welcome' })
    }
  }
}
</script>
