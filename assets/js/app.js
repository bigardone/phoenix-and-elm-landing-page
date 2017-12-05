import Elm from './elm/main';

window.onloadCallback = () => {
  const formContainer = document.querySelector('#form_container');
  if (formContainer) {
    const app = Elm.Main.embed(formContainer);
    let recaptcha;

    app.ports.initRecaptcha.subscribe(id => {
      window.requestAnimationFrame(() => {
        recaptcha = grecaptcha.render(id, {
          hl: 'en',
          sitekey: '6LcjgjsUAAAAAHIY0kC1fz24mSnB_uinM8k6U1K-',
          callback: result => {
            app.ports.setRecaptchaToken.send(result);
          },
        });
      });
    });

    app.ports.resetRecaptcha.subscribe(() => {
      grecaptcha.reset(recaptcha);
    });
  }
};
