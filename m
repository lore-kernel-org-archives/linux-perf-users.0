Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA48CC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34B460EFE
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 13:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhJRNxJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 09:53:09 -0400
Received: from foss.arm.com ([217.140.110.172]:38328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233130AbhJRNvF (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Oct 2021 09:51:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36EB2106F;
        Mon, 18 Oct 2021 06:48:54 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.27.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B17393F73D;
        Mon, 18 Oct 2021 06:48:52 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     denik@chromium.org, James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf tools: Refactor out kernel symbol argument sanity checking
Date:   Mon, 18 Oct 2021 14:48:41 +0100
Message-Id: <20211018134844.2627174-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211018134844.2627174-1-james.clark@arm.com>
References: <20211018134844.2627174-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

User supplied values for vmlinux and kallsyms are checked before
continuing. Refactor this into a function so that it can be used
elsewhere.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-report.c | 13 ++-----------
 tools/perf/util/symbol.c    | 22 ++++++++++++++++++++++
 tools/perf/util/symbol.h    |  2 ++
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index a0316ce910db..8167ebfe776a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1378,18 +1378,9 @@ int cmd_report(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
-	if (symbol_conf.vmlinux_name &&
-	    access(symbol_conf.vmlinux_name, R_OK)) {
-		pr_err("Invalid file: %s\n", symbol_conf.vmlinux_name);
-		ret = -EINVAL;
-		goto exit;
-	}
-	if (symbol_conf.kallsyms_name &&
-	    access(symbol_conf.kallsyms_name, R_OK)) {
-		pr_err("Invalid file: %s\n", symbol_conf.kallsyms_name);
-		ret = -EINVAL;
+	ret = symbol__validate_sym_arguments();
+	if (ret)
 		goto exit;
-	}
 
 	if (report.inverted_callchain)
 		callchain_param.order = ORDER_CALLER;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0fc9a5410739..8fad1f0d41cb 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2630,3 +2630,25 @@ struct mem_info *mem_info__new(void)
 		refcount_set(&mi->refcnt, 1);
 	return mi;
 }
+
+/*
+ * Checks that user supplied symbol kernel files are accessible because
+ * the default mechanism for accessing elf files fails silently. i.e. if
+ * debug syms for a build ID aren't found perf carries on normally. When
+ * they are user supplied we should assume that the user doesn't want to
+ * silently fail.
+ */
+int symbol__validate_sym_arguments(void)
+{
+	if (symbol_conf.vmlinux_name &&
+	    access(symbol_conf.vmlinux_name, R_OK)) {
+		pr_err("Invalid file: %s\n", symbol_conf.vmlinux_name);
+		return -EINVAL;
+	}
+	if (symbol_conf.kallsyms_name &&
+	    access(symbol_conf.kallsyms_name, R_OK)) {
+		pr_err("Invalid file: %s\n", symbol_conf.kallsyms_name);
+		return -EINVAL;
+	}
+	return 0;
+}
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 954d6a049ee2..166196686f2e 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -286,4 +286,6 @@ static inline void __mem_info__zput(struct mem_info **mi)
 
 #define mem_info__zput(mi) __mem_info__zput(&mi)
 
+int symbol__validate_sym_arguments(void);
+
 #endif /* __PERF_SYMBOL */
-- 
2.28.0

