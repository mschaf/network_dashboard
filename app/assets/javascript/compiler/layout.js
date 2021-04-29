up.compiler('[layout--show-menu]', (element) => {
  let layout = document.querySelector('.layout')

  element.addEventListener('click', () => {
     layout.classList.add('-menu-shown')
  })
})

up.compiler('[layout--hide-menu]', (element) => {
    let layout = document.querySelector('.layout')

    element.addEventListener('click', () => {
        layout.classList.remove('-menu-shown')
    })
})
up.compiler('[layout--toggle-menu]', (element) => {
    let layout = document.querySelector('.layout')

    element.addEventListener('click', () => {
        layout.classList.toggle('-menu-shown')
    })
})