export default class Recaptcha extends HTMLElement {
  constructor() {
    const self = super();

    self._token = null;
    self._grecaptcha = null;

    return self;
  }

  set token(token) {
    this._token = token;

    if (this._grecaptcha !== null && token === null) grecaptcha.reset(this._grecaptcha);
  }

  get token() {
    return this._token;
  }

  connectedCallback() {
    this._grecaptcha = grecaptcha.render(this, {
      hl: 'en',
      sitekey: '6LdHSG8UAAAAAO-NxfnWj30tk8_O31eTvvyQUyJA',
      callback: (token) => {
        this._token = token;
        this.dispatchEvent(new CustomEvent('gotToken'));
      },
    });
  }
}
