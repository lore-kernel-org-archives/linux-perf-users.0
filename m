Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DCC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A0D6124D
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhKKAYM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhKKAYL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:11 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BCCC061205
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:21 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p12-20020a17090b010c00b001a65bfe8054so1931832pjz.8
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tSJF4NgxE0FiE6ZCyL+zeBWSot2mi/NQBEc61OonFLQ=;
        b=KjyGmRcEotKJVBhuBH+oK7aHfYPkZ3Okq7KmAmjZRgYIcAnkuoE3NFqcwj22aNQKSV
         xlf3eXklS9z7RCzx8m3ez8KpX38isSamCNRTQQ+ceVsQqAmjGinfg5Yws7PZ2gqUq0iE
         cIARjgc0+RgANe6H2TVnOFVyZ69xuJF93k6qBYvpIMI1WsI5xPfqwIP06RafdzwrRiJg
         m7CuRyRIHNujyv9GIs32/cKQozHmq1c9YnBEuiHyMsB7PabzkRo5B/FhHeRXMzV7WlaJ
         uIdR+t6hziIUSfIQQJ+6Jmh2KqHEDihRVYsFvlrgeLfcG5WTr02GixC+vL/0ui0q01Uy
         UQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tSJF4NgxE0FiE6ZCyL+zeBWSot2mi/NQBEc61OonFLQ=;
        b=oGwypd4aUvUp4mWv79eveZ8nZcHqt5IeQJozz8zCSK0FwDIqRSp29J/QpvP/I0TEr/
         /tSax8tb1+s/M/9jbKGkOpnSWaikWgqnr6mYdnH6bFIkWlICFsr62Fxx8Z2bFKePggmh
         6BoAm0Z2iqVcGTEbWrLwoKk/cVT1V6HH0XzjA1SKh5dIm0Lp40eU5FstM6QfPIrpr4ro
         eIzlvAEFG83TkpsUNWEqJ4uD0ZBZch1cycZKgN6iqw/srVuO2VoLLNbYAMDnpGbcwTdC
         2EjL9+X9uDdmRRkblb7Z2UFC+8EWIMjAMbYem7ona+fE4VNMMopDch/JuD5yfr4KS97o
         z41A==
X-Gm-Message-State: AOAM531eUUTQIS0ezqzpFdnqNCh+jjMbJe5Zvm8D8x2HuWgGqdz99bbo
        ++t3oX+0Ag2SaR9zOchCKV/hL7kB96rz
X-Google-Smtp-Source: ABdhPJyjh9M8fFIg1iomIj6W/Q3pdtxnw6KiAB6A6/Z6ZHiG1xFogUAZYuaYWYJkutYelZlEI54wumCCATNb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a63:8143:: with SMTP id
 t64mr1898528pgd.43.1636590080980; Wed, 10 Nov 2021 16:21:20 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:04 -0800
In-Reply-To: <20211111002109.194172-1-irogers@google.com>
Message-Id: <20211111002109.194172-4-irogers@google.com>
Mime-Version: 1.0
References: <20211111002109.194172-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 3/8] perf cputopo: Match die_siblings to topology ABI name
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The topology name for die_siblings is die_cpus_list, use this for
consistency and add documentation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cputopo.c | 26 ++++++++++++--------------
 tools/perf/util/cputopo.h | 11 +++++++++--
 tools/perf/util/header.c  |  8 ++++----
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index f72a7de19e02..420aeda16fbb 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -18,7 +18,7 @@
 	"%s/devices/system/cpu/cpu%d/topology/package_cpus_list"
 #define PACKAGE_CPUS_FMT_OLD \
 	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
-#define DIE_SIB_FMT \
+#define DIE_CPUS_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
 #define THRD_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
@@ -73,10 +73,10 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	ret = 0;
 
 try_dies:
-	if (!tp->die_siblings)
+	if (!tp->die_cpus_list)
 		goto try_threads;
 
-	scnprintf(filename, MAXPATHLEN, DIE_SIB_FMT,
+	scnprintf(filename, MAXPATHLEN, DIE_CPUS_FMT,
 		  sysfs__mountpoint(), cpu);
 	fp = fopen(filename, "r");
 	if (!fp)
@@ -91,13 +91,13 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	if (p)
 		*p = '\0';
 
-	for (i = 0; i < tp->die_sib; i++) {
-		if (!strcmp(buf, tp->die_siblings[i]))
+	for (i = 0; i < tp->die_cpus_lists; i++) {
+		if (!strcmp(buf, tp->die_cpus_list[i]))
 			break;
 	}
-	if (i == tp->die_sib) {
-		tp->die_siblings[i] = buf;
-		tp->die_sib++;
+	if (i == tp->die_cpus_lists) {
+		tp->die_cpus_list[i] = buf;
+		tp->die_cpus_lists++;
 		buf = NULL;
 		len = 0;
 	}
@@ -148,10 +148,8 @@ void cpu_topology__delete(struct cpu_topology *tp)
 	for (i = 0 ; i < tp->package_cpus_lists; i++)
 		zfree(&tp->package_cpus_list[i]);
 
-	if (tp->die_sib) {
-		for (i = 0 ; i < tp->die_sib; i++)
-			zfree(&tp->die_siblings[i]);
-	}
+	for (i = 0 ; i < tp->die_cpus_lists; i++)
+		zfree(&tp->die_cpus_list[i]);
 
 	for (i = 0 ; i < tp->thread_sib; i++)
 		zfree(&tp->thread_siblings[i]);
@@ -170,7 +168,7 @@ static bool has_die_topology(void)
 	if (strncmp(uts.machine, "x86_64", 6))
 		return false;
 
-	scnprintf(filename, MAXPATHLEN, DIE_SIB_FMT,
+	scnprintf(filename, MAXPATHLEN, DIE_CPUS_FMT,
 		  sysfs__mountpoint(), 0);
 	if (access(filename, F_OK) == -1)
 		return false;
@@ -214,7 +212,7 @@ struct cpu_topology *cpu_topology__new(void)
 	tp->package_cpus_list = addr;
 	addr += sz;
 	if (has_die) {
-		tp->die_siblings = addr;
+		tp->die_cpus_list = addr;
 		addr += sz;
 	}
 	tp->thread_siblings = addr;
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 4ec9cb192c3d..a3e01c367853 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -7,7 +7,8 @@
 struct cpu_topology {
 	/* The number of unique package_cpus_lists below. */
 	u32	  package_cpus_lists;
-	u32	  die_sib;
+	/* The number of unique die_cpu_lists below. */
+	u32	  die_cpus_lists;
 	u32	  thread_sib;
 	/*
 	 * An array of strings where each string is unique and read from
@@ -16,7 +17,13 @@ struct cpu_topology {
 	 * physical_package_id. The format is like 0-3, 8-11, 14,17.
 	 */
 	const char **package_cpus_list;
-	char	**die_siblings;
+	/*
+	 * An array of string where each string is unique and from
+	 * /sys/devices/system/cpu/cpuX/topology/die_cpus_list. From the ABI
+	 * each of these is a human-readable list of CPUs within the same die.
+	 * The format is like 0-3, 8-11, 14,17.
+	 */
+	const char **die_cpus_list;
 	char	**thread_siblings;
 };
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4e89cd35345b..e2ba261d1583 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -617,15 +617,15 @@ static int write_cpu_topology(struct feat_fd *ff,
 			return ret;
 	}
 
-	if (!tp->die_sib)
+	if (!tp->die_cpus_lists)
 		goto done;
 
-	ret = do_write(ff, &tp->die_sib, sizeof(tp->die_sib));
+	ret = do_write(ff, &tp->die_cpus_lists, sizeof(tp->die_cpus_lists));
 	if (ret < 0)
 		goto done;
 
-	for (i = 0; i < tp->die_sib; i++) {
-		ret = do_write_string(ff, tp->die_siblings[i]);
+	for (i = 0; i < tp->die_cpus_lists; i++) {
+		ret = do_write_string(ff, tp->die_cpus_list[i]);
 		if (ret < 0)
 			goto done;
 	}
-- 
2.34.0.rc1.387.gb447b232ab-goog

