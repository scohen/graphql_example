import { shallowMount } from '@vue/test-utils'
import AuthLayout from '@/components/auth-layout'

describe('auth-layout.vue', () => {
  it('renders the header slot', () => {
    const slots = {
      header: '<span>Hello There</span>'
    }
    const wrapper = shallowMount(AuthLayout, { slots })
    expect(wrapper.find('h1').text()).toBe('Hello There')
  })

  it('renders the default slot', () => {
    const slots = {
      default: '<div>Content Goes Here</div>'
    }
    const wrapper = shallowMount(AuthLayout, { slots })
    expect(wrapper.find('div.box').text()).toBe('Content Goes Here')
  })

  it('renders correctly', () => {
    const slots = {
      header: '<span>Hello There</span>',
      default: '<div>Content Goes Here</div>'
    }
    const wrapper = shallowMount(AuthLayout, { slots })
    expect(wrapper.html()).toMatchSnapshot()
  })
})
