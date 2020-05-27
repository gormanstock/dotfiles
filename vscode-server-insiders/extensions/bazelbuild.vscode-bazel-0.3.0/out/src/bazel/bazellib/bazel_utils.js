"use strict";
// Copyright 2018 The Bazel Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs = require("fs");
const path = require("path");
const bazel_query_1 = require("./bazel_query");
/**
 * Get the targets in the build file
 *
 * @param bazelExecutable The path to the Bazel executable.
 * @param workspace The path to the workspace.
 * @param buildFile The path to the build file.
 * @returns A query result for targets in the build file.
 */
function getTargetsForBuildFile(bazelExecutable, workspace, buildFile) {
    return __awaiter(this, void 0, void 0, function* () {
        // Path to the BUILD file relative to the workspace.
        const relPathToDoc = path.relative(workspace, buildFile);
        // Strip away the name of the BUILD file from the relative path.
        let relDirWithDoc = path.dirname(relPathToDoc);
        // Strip away the "." if the BUILD file was in the same directory as the
        // workspace.
        if (relDirWithDoc === ".") {
            relDirWithDoc = "";
        }
        // Turn the relative path into a package label
        const pkg = `//${relDirWithDoc}`;
        const queryResult = yield new bazel_query_1.BazelQuery(bazelExecutable, workspace, `'kind(rule, ${pkg}:all)'`, []).queryTargets();
        return queryResult;
    });
}
exports.getTargetsForBuildFile = getTargetsForBuildFile;
/**
 * Search for the path to the directory that has the Bazel WORKSPACE file for
 * the given file.
 *
 * If multiple directories along the path to the file has files called
 * "WORKSPACE", the lowest path is returned.
 *
 * @param fsPath The path to a file in a Bazel workspace.
 * @returns The path to the directory with the Bazel WORKSPACE file if found,
 *     others undefined.
 */
function getBazelWorkspaceFolder(fsPath) {
    let dirname = fsPath;
    let iteration = 0;
    // Fail safe in case other file systems have a base dirname that doesn't
    // match the checks below. Having this failsafe guarantees that we don't
    // hang in an infinite loop.
    const maxIterations = 100;
    if (fs.statSync(fsPath).isFile()) {
        dirname = path.dirname(dirname);
    }
    do {
        const workspace = path.join(dirname, "WORKSPACE");
        try {
            fs.accessSync(workspace, fs.constants.F_OK);
            // WORKSPACE file is accessible. We have found the Bazel workspace
            // directory.
            return dirname;
        }
        catch (err) {
            // Intentionally do nothing; just try the next parent directory.
        }
        dirname = path.dirname(dirname);
    } while (++iteration < maxIterations && dirname !== "" && dirname !== "/");
    return undefined;
}
exports.getBazelWorkspaceFolder = getBazelWorkspaceFolder;
//# sourceMappingURL=bazel_utils.js.map