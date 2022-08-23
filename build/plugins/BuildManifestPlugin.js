let fs = require('fs');
let path = require('path');

function BuildManifestPlugin(){

}

BuildManifestPlugin.prototype.apply = function(compiler){
    compiler.plugin('done', stats => {
        fs.writeFileSync(
            path.resolve('dist/manifest.json'),
            JSON.stringify(stats.toJson().assetsByChunkName)
        )
    });
};

module.exports = BuildManifestPlugin;
