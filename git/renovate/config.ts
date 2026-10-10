import type { AllConfig } from 'renovate/dist/config/types';

const config: AllConfig = {
  internalHostAccess: 'block',
  platform: 'gitea',
  endpoint: 'http://server:3000',
  autodiscover: true,
  gitAuthor: 'Renovate Bot <bot@renovatebot.com>',
  optimizeForDisabled: true,
  hostRules: [
    {
      "hostType": "preset",
      "matchHost": "http://server:3000",
      "allowInternal": true
    }
  ]
};

export default config;
