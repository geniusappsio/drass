process.env.VUE_APP_VERSION = process.env.npm_package_version;

module.exports = {
    productionSourceMap: false,
    outputDir: './dist/',
    assetsDir: 'public',
    publicPath: '',
    // eslint-disable-next-line no-undef
    pages: {"home":{"entry":"src/_front/main.js","template":"public/front.html","filename":"./home/index.html","lang":"pt","cacheVersion":8,"meta":[{"name":"twitter:card","content":"summary"},{"property":"og:type","content":"website"},{"name":"robots","content":"index, follow"}],"scripts":{"head":"\n","body":"\n"},"baseTag":{"href":"/","target":"_self"},"alternateLinks":[{"rel":"alternate","hreflang":"x-default","href":"https://56aca1bf-492b-4b16-9710-39fc9cb9d709.weweb-preview.io/home/"},{"rel":"alternate","hreflang":"pt","href":"https://56aca1bf-492b-4b16-9710-39fc9cb9d709.weweb-preview.io/home/"}],"chunks":["chunk-vendors","chunk-common","home"]},"teste":{"entry":"src/_front/main.js","template":"public/front.html","filename":"./teste/index.html","lang":"pt","cacheVersion":8,"meta":[{"name":"twitter:card","content":"summary"},{"property":"og:type","content":"website"},{"name":"robots","content":"index, follow"}],"scripts":{"head":"\n","body":"\n"},"baseTag":{"href":"/","target":"_self"},"alternateLinks":[{"rel":"alternate","hreflang":"x-default","href":"https://56aca1bf-492b-4b16-9710-39fc9cb9d709.weweb-preview.io/teste/"},{"rel":"alternate","hreflang":"pt","href":"https://56aca1bf-492b-4b16-9710-39fc9cb9d709.weweb-preview.io/teste/"}],"chunks":["chunk-vendors","chunk-common","teste"]},"index":{"entry":"src/_front/main.js","template":"public/front.html","filename":"./index.html","lang":"pt","cacheVersion":8,"meta":[{"name":"twitter:card","content":"summary"},{"property":"og:type","content":"website"},{"name":"robots","content":"index, follow"}],"scripts":{"head":"\n","body":"\n"},"baseTag":{"href":"/","target":"_self"},"alternateLinks":[{"rel":"alternate","hreflang":"x-default","href":"https://56aca1bf-492b-4b16-9710-39fc9cb9d709.weweb-preview.io/"},{"rel":"alternate","hreflang":"pt","href":"https://56aca1bf-492b-4b16-9710-39fc9cb9d709.weweb-preview.io/"}],"chunks":["chunk-vendors","chunk-common","index"]}},
    configureWebpack: config => {
        config.module.rules.push({
            test: /\.mjs$/,
            include: /node_modules/,
            type: 'javascript/auto',
        });
        config.performance = {
            hints: false,
        };
    },
};
