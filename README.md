Miri Online
===========

Before next minor release bump:
 - Forgot password
 - Refine layout

Before next major release bump:
 - Able to log in, create character, see some amount of UI

## @todo

#### Research
 - Captcha, email verification or other bot / spam prevention
 - Clustering
 - Scale

#### Functionality (server side)
 - Add tests for email (cleanup code a bit) (move core to lib)
 - Add forgot password
 - Add better session longevity [PR](https://github.com/DaftMonk/generator-angular-fullstack/pull/444/files)
 - Start on character select
 - More specs (specifically for client)
 - Add created_at / updated_at to user model (created at default to now, updated at pre-save hook)
 - Add "showTutorials" flag to user model
 - Add more logging fields to user record (lastLoggedIn, currentLoggedIn, IP address logging, timestamps)
   - Add hooks to save to those fields

#### Client stuff
 - Add "Joyride" to tutorial users around the create character unless user has passed tutorials

#### Design (styles)
 - Add email template
 - Add welcome email
 - Color Scheme

#### Assets (images)
 - Parralax background for auth views
 - Logo
 - Font

#### Thoughts
 - Get e2e tests back in action ? (low priority)

#### Long Term
 - Add social signup / login (Twitter / Facebook / Google+)
 - Two factor auth for local (email, SMS)
 - Add "Receive News checkbox" to settings / signup (assuming we want to send news out)
 - Admin tools to limit logins to beta users


## Tools and Accounts
 - Email: Sendgrid
