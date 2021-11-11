Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DF0C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362756103C
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhKKAYL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhKKAYH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:07 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F4BC061767
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:19 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id k22-20020a635a56000000b002df9863aa74so852692pgm.19
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VMP1wJJhoV3IR/KxczBDnsYApMPLt2vxQmnh1mjOCBg=;
        b=Zz2TNYwT7UGe/bDKEYw6Ywq2GXbZsAAXLKYY8a3ze/QGRka+ms/YJ8jyi/DuDI90QT
         g2KQkzj9pjJ62FDiCUg0RJ6D7LFbvQFMAFFSnitMwgz4uCHWP1PFcKp793/AIfQXIddg
         zxBiUooLZ8lpmF/T9t3wP4SBYnqsqvC9PpP7fiPzRui7pvzusRrExKFebt9QovsDGhZ0
         tSKNAeQXRoKL/lJhefvyUUHr5KJ/QZ/3u42iDPr3yX4qKohbihF8JpKTHn3QNt5el6EZ
         r2vwtmVTzHYiyFfvZzzlwVPquJfEzdqX0pAhYGTp4euWezOgWOYRBVm+upqTGY/vh4fh
         l1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VMP1wJJhoV3IR/KxczBDnsYApMPLt2vxQmnh1mjOCBg=;
        b=j3ifUSegWp0grJZMuLhLjzQjGqX3cAop/0agnfZsVO7vfa+1DoYnW5MQyKWL8J4664
         PfalfAjcZPLI7vClMnwVDQTS+Y21W8P5i62GbFJewOfGHD7Nvzl52/CzqM9wnHguOAyk
         BsujgfBGH3GymT8gNQE5gCFKRJF0CIelZe7wQKlRxdaEbUbVm2A6LeJt+Ke/wXs66qBJ
         84vTYDwzmzDqUhHUdLkruheCSFkgohAwed4MlcVcX5UUzP/vm3LnLj1gDYCEED+7eG7U
         tPl5ia44OnO+uo5/douY7iY6j9l6eUBtK8R1Cqdo8unAQBwwFLv9sBKHn8Gexzq3HK5T
         d2zA==
X-Gm-Message-State: AOAM530RJbnJa1HEsrugh1PJQfovr6qqGM/UIpdqg2TUmSfkYRGow9ez
        PUY8+TyYhC+NfRa2wEWhxlYBoOMypxOw
X-Google-Smtp-Source: ABdhPJza+l1Gzgnm9c/X4iVUbJIUblHkp8gd5+Ybjp/mJsT0tACZDwmXAIKTGq7nVqo1nZKHXXTKHnEpsVJk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a17:90b:390c:: with SMTP id
 ob12mr3585738pjb.212.1636590079139; Wed, 10 Nov 2021 16:21:19 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:03 -0800
In-Reply-To: <20211111002109.194172-1-irogers@google.com>
Message-Id: <20211111002109.194172-3-irogers@google.com>
Mime-Version: 1.0
References: <20211111002109.194172-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 2/8] perf cputopo: Update to use pakage_cpus
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

core_siblings_list is the deprecated topology name for
package_cpus_list, update the code to try the non-deprecated path first.
Adjust variable names to match topology name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cputopo.c | 26 ++++++++++++++++----------
 tools/perf/util/cputopo.h | 11 +++++++++--
 tools/perf/util/header.c  |  6 +++---
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index ec77e2a7b3ca..f72a7de19e02 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -14,7 +14,9 @@
 #include "env.h"
 #include "pmu-hybrid.h"
 
-#define CORE_SIB_FMT \
+#define PACKAGE_CPUS_FMT \
+	"%s/devices/system/cpu/cpu%d/topology/package_cpus_list"
+#define PACKAGE_CPUS_FMT_OLD \
 	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
 #define DIE_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
@@ -39,8 +41,12 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	u32 i = 0;
 	int ret = -1;
 
-	scnprintf(filename, MAXPATHLEN, CORE_SIB_FMT,
+	scnprintf(filename, MAXPATHLEN, PACKAGE_CPUS_FMT,
 		  sysfs__mountpoint(), cpu);
+	if (access(filename, F_OK) == -1) {
+		scnprintf(filename, MAXPATHLEN, PACKAGE_CPUS_FMT_OLD,
+			sysfs__mountpoint(), cpu);
+	}
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto try_dies;
@@ -54,13 +60,13 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	if (p)
 		*p = '\0';
 
-	for (i = 0; i < tp->core_sib; i++) {
-		if (!strcmp(buf, tp->core_siblings[i]))
+	for (i = 0; i < tp->package_cpus_lists; i++) {
+		if (!strcmp(buf, tp->package_cpus_list[i]))
 			break;
 	}
-	if (i == tp->core_sib) {
-		tp->core_siblings[i] = buf;
-		tp->core_sib++;
+	if (i == tp->package_cpus_lists) {
+		tp->package_cpus_list[i] = buf;
+		tp->package_cpus_lists++;
 		buf = NULL;
 		len = 0;
 	}
@@ -139,8 +145,8 @@ void cpu_topology__delete(struct cpu_topology *tp)
 	if (!tp)
 		return;
 
-	for (i = 0 ; i < tp->core_sib; i++)
-		zfree(&tp->core_siblings[i]);
+	for (i = 0 ; i < tp->package_cpus_lists; i++)
+		zfree(&tp->package_cpus_list[i]);
 
 	if (tp->die_sib) {
 		for (i = 0 ; i < tp->die_sib; i++)
@@ -205,7 +211,7 @@ struct cpu_topology *cpu_topology__new(void)
 
 	tp = addr;
 	addr += sizeof(*tp);
-	tp->core_siblings = addr;
+	tp->package_cpus_list = addr;
 	addr += sz;
 	if (has_die) {
 		tp->die_siblings = addr;
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index d9af97177068..4ec9cb192c3d 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -5,10 +5,17 @@
 #include <linux/types.h>
 
 struct cpu_topology {
-	u32	  core_sib;
+	/* The number of unique package_cpus_lists below. */
+	u32	  package_cpus_lists;
 	u32	  die_sib;
 	u32	  thread_sib;
-	char	**core_siblings;
+	/*
+	 * An array of strings where each string is unique and read from
+	 * /sys/devices/system/cpu/cpuX/topology/package_cpus_list. From the ABI
+	 * each of these is a human-readable list of CPUs sharing the same
+	 * physical_package_id. The format is like 0-3, 8-11, 14,17.
+	 */
+	const char **package_cpus_list;
 	char	**die_siblings;
 	char	**thread_siblings;
 };
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 56511db8fa03..4e89cd35345b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -583,12 +583,12 @@ static int write_cpu_topology(struct feat_fd *ff,
 	if (!tp)
 		return -1;
 
-	ret = do_write(ff, &tp->core_sib, sizeof(tp->core_sib));
+	ret = do_write(ff, &tp->package_cpus_lists, sizeof(tp->package_cpus_lists));
 	if (ret < 0)
 		goto done;
 
-	for (i = 0; i < tp->core_sib; i++) {
-		ret = do_write_string(ff, tp->core_siblings[i]);
+	for (i = 0; i < tp->package_cpus_lists; i++) {
+		ret = do_write_string(ff, tp->package_cpus_list[i]);
 		if (ret < 0)
 			goto done;
 	}
-- 
2.34.0.rc1.387.gb447b232ab-goog

