import Mail from '@ioc:Adonis/Addons/Mail'

await Mail.send((message) => {
  message
    .to('recipient@example.com')
    .from('sender@example.com')
    .subject('Hello from AdonisJS')
    .text('This is a test email sent from AdonisJS mailer provider.')
})
