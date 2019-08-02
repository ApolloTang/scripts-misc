#!/usr/bin/env node

/**
 * This script reinstall node package and thus upgrade to the latest npm package
 *
 * ::: Ref :::
 * https://stackabuse.com/reading-and-writing-json-files-with-node-js/
 * https://medium.com/@the_teacher/yarn-upgrade-does-not-update-package-json-solution-9cd6122e6c6c
 * https://www.diigo.com/user/gofish?query=npm-update
 *

'use strict';

const fs = require('fs');
const exec = require('child_process').exec;


fs.readFile('package.json', (err, data) => {
    if (err) throw err;
    let packageContent = JSON.parse(data);
    const devDependencies = Object.keys(packageContent.devDependencies)
    const dependencies = Object.keys(packageContent.dependencies)
    const devDependenciesString =  devDependencies.join(' ');
    const dependenciesString =  dependencies.join(' ');

    const devDepComand = `yarn add -D ${devDependenciesString}`
    console.log(devDepComand);
    exec(devDepComand,
        (error, stdout, stderr) => {
            console.log(`stdout: ${stdout}`);
            console.log(`stderr: ${stderr}`);
            if (error !== null) {
                console.log(`exec error: ${error}`);
            }

        const depComand = `yarn add ${dependenciesString}`

        console.log(depComand);
        exec(depComand ,
            (error, stdout, stderr) => {
                console.log(`stdout: ${stdout}`);
                console.log(`stderr: ${stderr}`);
                if (error !== null) {
                    console.log(`exec error: ${error}`);
                }
        });
    });
});
