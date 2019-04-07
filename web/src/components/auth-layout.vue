<template functional>
  <section class="hero is-light is-fullheight">
    <div class="hero-body">
      <div class="container">
        <div class="columns is-centered">
          <div class="column is-6-tablet is-5-desktop is-4-widescreen">
            <h1 class="title has-text-centered">
              <slot name="header" />
            </h1>
            <slot name="notification" />
            <div class="box">
              <slot />
            </div>
            <slot name="footer" />
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
