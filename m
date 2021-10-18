Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7288C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F8F608FB
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhJRNxJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 09:53:09 -0400
Received: from foss.arm.com ([217.140.110.172]:38336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233166AbhJRNvH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Oct 2021 09:51:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ACAC113E;
        Mon, 18 Oct 2021 06:48:56 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.27.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2381A3F73D;
        Mon, 18 Oct 2021 06:48:55 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     denik@chromium.org, James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf tools: Check vmlinux/kallsyms arguments in all tools
Date:   Mon, 18 Oct 2021 14:48:42 +0100
Message-Id: <20211018134844.2627174-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211018134844.2627174-1-james.clark@arm.com>
References: <20211018134844.2627174-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Only perf report checked the validity of these arguments so apply the
same check to all tools that read them for consistency.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-annotate.c | 4 ++++
 tools/perf/builtin-c2c.c      | 4 ++++
 tools/perf/builtin-probe.c    | 5 +++++
 tools/perf/builtin-record.c   | 4 ++++
 tools/perf/builtin-sched.c    | 4 ++++
 tools/perf/builtin-script.c   | 3 +++
 tools/perf/builtin-top.c      | 4 ++++
 7 files changed, 28 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 05eb098cb0e3..490bb9b8cf17 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -591,6 +591,10 @@ int cmd_annotate(int argc, const char **argv)
 		return ret;
 	}
 
+	ret = symbol__validate_sym_arguments();
+	if (ret)
+		return ret;
+
 	if (quiet)
 		perf_quiet_option();
 
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a192014fa52b..b5c67ef73862 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2768,6 +2768,10 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (c2c.stats_only)
 		c2c.use_stdio = true;
 
+	err = symbol__validate_sym_arguments();
+	if (err)
+		goto out;
+
 	if (!input_name || !strlen(input_name))
 		input_name = "perf.data";
 
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index e1dd51f2874b..c31627af75d4 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -21,6 +21,7 @@
 #include "util/build-id.h"
 #include "util/strlist.h"
 #include "util/strfilter.h"
+#include "util/symbol.h"
 #include "util/symbol_conf.h"
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
@@ -629,6 +630,10 @@ __cmd_probe(int argc, const char **argv)
 		params.command = 'a';
 	}
 
+	ret = symbol__validate_sym_arguments();
+	if (ret)
+		return ret;
+
 	if (params.quiet) {
 		if (verbose != 0) {
 			pr_err("  Error: -v and -q are exclusive.\n");
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 41bb884f5a74..9aff49915148 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2712,6 +2712,10 @@ int cmd_record(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	err = symbol__validate_sym_arguments();
+	if (err)
+		return err;
+
 	/* Make system wide (-a) the default target. */
 	if (!argc && target__none(&rec->opts.target))
 		rec->opts.target.system_wide = true;
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 635a6b5a9ec9..4527f632ebe4 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3538,6 +3538,7 @@ int cmd_sched(int argc, const char **argv)
 		.fork_event	    = replay_fork_event,
 	};
 	unsigned int i;
+	int ret;
 
 	for (i = 0; i < ARRAY_SIZE(sched.curr_pid); i++)
 		sched.curr_pid[i] = -1;
@@ -3598,6 +3599,9 @@ int cmd_sched(int argc, const char **argv)
 				parse_options_usage(NULL, timehist_options, "n", true);
 			return -EINVAL;
 		}
+		ret = symbol__validate_sym_arguments();
+		if (ret)
+			return ret;
 
 		return perf_sched__timehist(&sched);
 	} else {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6211d0b84b7a..53f8f7b408be 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3836,6 +3836,9 @@ int cmd_script(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	if (symbol__validate_sym_arguments())
+		return -1;
+
 	if (argc > 1 && !strncmp(argv[0], "rec", strlen("rec"))) {
 		rec_script_path = get_script_path(argv[1], RECORD_SUFFIX);
 		if (!rec_script_path)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 020c4f110c10..1fc390f136dd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1618,6 +1618,10 @@ int cmd_top(int argc, const char **argv)
 	if (argc)
 		usage_with_options(top_usage, options);
 
+	status = symbol__validate_sym_arguments();
+	if (status)
+		goto out_delete_evlist;
+
 	if (annotate_check_args(&top.annotation_opts) < 0)
 		goto out_delete_evlist;
 
-- 
2.28.0

