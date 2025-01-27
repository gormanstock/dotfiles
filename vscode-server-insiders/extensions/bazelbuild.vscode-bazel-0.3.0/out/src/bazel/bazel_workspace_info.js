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
const vscode = require("vscode");
const bazellib_1 = require("./bazellib");
/**
 * Represents the Bazel workspace path containing a document as well as its
 * containing VS Code workspace folder, if there is one.
 */
class BazelWorkspaceInfo {
    /**
     * Initializes a new workspace info object.
     *
     * @param bazelWorkspacePath The closest directory to a document that contains
     *     a Bazel WORKSPACE file.
     * @param workspaceFolder An object representing the VS Code workspace folder
     *     that contains a document, or {@code undefined} if the file does not
     *     belong to a workspace folder (for example, a standalone file loaded
     *     into the editor).
     */
    constructor(bazelWorkspacePath, workspaceFolder) {
        this.bazelWorkspacePath = bazelWorkspacePath;
        this.workspaceFolder = workspaceFolder;
    }
    /**
     * Returns the VS Code and Bazel workspace info for the given text document.
     *
     * If the file is not in a Bazel workspace, this function returns
     * {@code undefined}.
     *
     * @param document The {@code vscode.TextDocument} whose workspace info should
     *     be retrieved.
     */
    static fromDocument(document) {
        const uri = document.uri;
        const bazelWorkspace = bazellib_1.getBazelWorkspaceFolder(uri.fsPath);
        if (bazelWorkspace) {
            const vscodeWorkspace = vscode.workspace.getWorkspaceFolder(uri);
            return new BazelWorkspaceInfo(bazelWorkspace, vscodeWorkspace);
        }
        return undefined;
    }
    /**
     * Returns the VS Code and Bazel workspace info for the given VS Code
     * workspace folder.
     *
     * If the workspace folder is not a subdirectory in (or is not itself) a Bazel
     * workspace, this function returns {@code undefined}.
     *
     * @param workspaceFolder The {@code vscode.WorkspaceFolder} whose workspace
     *     info should be retrieved.
     */
    static fromWorkspaceFolder(workspaceFolder) {
        const bazelWorkspace = bazellib_1.getBazelWorkspaceFolder(workspaceFolder.uri.fsPath);
        if (bazelWorkspace) {
            return new BazelWorkspaceInfo(bazelWorkspace, workspaceFolder);
        }
        return undefined;
    }
}
exports.BazelWorkspaceInfo = BazelWorkspaceInfo;
//# sourceMappingURL=bazel_workspace_info.js.map