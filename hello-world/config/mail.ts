/**
 * Config source: https://git.io/JvgAf
 *
 * Feel free to let us know via PR, if you find something broken in this contract
 * file.
 */


import Env from '@ioc:Adonis/Core/Env'
import { mailConfig } from '@adonisjs/mail/build/config'

export default mailConfig({
  mailer: 'mailgun',
  mailers: {
    mailgun: {
      driver: 'mailgun',
      baseUrl: 'https://api.mailgun.net/v3',
      key: Env.get('MAILGUN_API_KEY'),
      domain: Env.get('MAILGUN_DOMAIN'),
    },

    smtp: {
      driver: 'smtp',
      host: Env.get('SMTP_HOST') as string,
      port: Env.get('SMTP_PORT') as string,
    },
  },
})
