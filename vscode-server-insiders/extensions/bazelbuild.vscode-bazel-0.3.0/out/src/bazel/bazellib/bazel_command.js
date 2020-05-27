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
Object.defineProperty(exports, "__esModule", { value: true });
/** Common functionality used to execute Bazel commands. */
class BazelCommand {
    /**
     * Initializes a new Bazel command instance.
     *
     * @param bazelExecutable The path to the Bazel executable.
     * @param workingDirectory The path to the directory from which Bazel will be
     *     spawned.
     * @param options Command line options that will be passed to Bazel (targets,
     *     query strings, flags, etc.).
     */
    constructor(bazelExecutable, workingDirectory, options = []) {
        this.bazelExecutable = bazelExecutable;
        this.workingDirectory = workingDirectory;
        this.options = options;
    }
    /** The command line string used to execute the query. */
    commandLine(additionalOptions = []) {
        let result = `${this.bazelExecutable} ${this.bazelCommand()}`;
        if (this.options.length > 0) {
            result += " ";
            result += this.options.join(" ");
        }
        if (additionalOptions.length > 0) {
            result += " ";
            result += additionalOptions.join(" ");
        }
        return result;
    }
}
exports.BazelCommand = BazelCommand;
//# sourceMappingURL=bazel_command.js.map