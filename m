Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE3C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 14:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD5861051
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 14:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhHaO4F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:56:05 -0400
Received: from foss.arm.com ([217.140.110.172]:55680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237512AbhHaO4F (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 10:56:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D22AF6D;
        Tue, 31 Aug 2021 07:55:09 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.42.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58AFD3F5A1;
        Tue, 31 Aug 2021 07:55:08 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 1/3] perf tools: Refactor LLVM test warning for missing binary
Date:   Tue, 31 Aug 2021 15:54:59 +0100
Message-Id: <20210831145501.2135754-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The same warning is duplicated in two places so refactor it into a
single function "search_program_and_warn". This will be used a third
time in a later commit.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/llvm-utils.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index cbd9b268f168..cec9c16efb17 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -38,6 +38,8 @@ struct llvm_param llvm_param = {
 	.user_set_param = false,
 };
 
+static void version_notice(void);
+
 int perf_llvm_config(const char *var, const char *value)
 {
 	if (!strstarts(var, "llvm."))
@@ -108,6 +110,21 @@ search_program(const char *def, const char *name,
 	return ret;
 }
 
+static int search_program_and_warn(const char *def, const char *name,
+				   char *output)
+{
+	int ret = search_program(def, name, output);
+
+	if (ret) {
+		pr_err("ERROR:\tunable to find %s.\n"
+		       "Hint:\tTry to install latest clang/llvm to support BPF. Check your $PATH\n"
+		       "     \tand '%s-path' option in [llvm] section of ~/.perfconfig.\n",
+		       name, name);
+		version_notice();
+	}
+	return ret;
+}
+
 #define READ_SIZE	4096
 static int
 read_from_pipe(const char *cmd, void **p_buf, size_t *p_read_sz)
@@ -458,16 +475,10 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	if (!template)
 		template = CLANG_BPF_CMD_DEFAULT_TEMPLATE;
 
-	err = search_program(llvm_param.clang_path,
+	err = search_program_and_warn(llvm_param.clang_path,
 			     "clang", clang_path);
-	if (err) {
-		pr_err(
-"ERROR:\tunable to find clang.\n"
-"Hint:\tTry to install latest clang/llvm to support BPF. Check your $PATH\n"
-"     \tand 'clang-path' option in [llvm] section of ~/.perfconfig.\n");
-		version_notice();
+	if (err)
 		return -ENOENT;
-	}
 
 	/*
 	 * This is an optional work. Even it fail we can continue our
@@ -495,14 +506,9 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	force_set_env("WORKING_DIR", kbuild_dir ? : ".");
 
 	if (opts) {
-		err = search_program(llvm_param.llc_path, "llc", llc_path);
-		if (err) {
-			pr_err("ERROR:\tunable to find llc.\n"
-			       "Hint:\tTry to install latest clang/llvm to support BPF. Check your $PATH\n"
-			       "     \tand 'llc-path' option in [llvm] section of ~/.perfconfig.\n");
-			version_notice();
+		err = search_program_and_warn(llvm_param.llc_path, "llc", llc_path);
+		if (err)
 			goto errout;
-		}
 
 		err = -ENOMEM;
 		if (asprintf(&pipe_template, "%s -emit-llvm | %s -march=bpf %s -filetype=obj -o -",
-- 
2.28.0

