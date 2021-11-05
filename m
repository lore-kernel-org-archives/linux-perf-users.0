Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAA0C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DB0611EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhKERMg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhKERMf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 13:12:35 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF0C061205
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Nov 2021 10:09:55 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o4-20020a17090a3d4400b001a66f10df6cso2353301pjf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Nov 2021 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RySmPG49vcw0F/Z+rgX9gmuaClVMv8kjlOiNuEozZJ4=;
        b=VVu6RZgFYveEs46tLCUiirdTZjxEHiBbiyLYiLCqQFH2VAlbZ2IlDqjT+DJXKFixmJ
         +Aa6v9MToIk8ehqobKxVWF3bQLIZUs3VB1VT4McgO7UTfvWyIznPf1ANqR8DfzwGpzcN
         CHwa+emXh2Dq62GWjUa2S9LJfwOsFDM318xPKm7Fhm/M902FFAx+vGH/V/O6FAB8ABzV
         GV4eleRPDxDDqQQCyqL+Eh0YhlfLRy8l7vokPCd/SB/akC82QZeGWGim1ObhP9DRSaem
         6E/pysmgOguv10gL48QZxIITse/6A4Z8CVqljyY1Guo+DK41608+1P2ljg+c7nO4sBzD
         Sisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RySmPG49vcw0F/Z+rgX9gmuaClVMv8kjlOiNuEozZJ4=;
        b=3zCvPC/fo+YfJrEovSFgx3TeZJ31YDE6NPehyerxJm5CBE+Z9vnRzGcR0EpyZN35FO
         f49q97oRMiOLGQLonGQpzedr8slKADLrhnUjCmTDAwwrAiS/qGKu6+vAu78ZuCB0deWp
         1VOyHQOHHnzUDlujPVmhZK+d3kzjIq8zUPewMwn4ZuSPURFtV4152PGgPRHxwTKl3eyF
         wexDjqL9n7ESGv3W4JF4i5O0vhsVaOSE7AmjNpnisGef12kv9QafNDVuQdAiI37npexv
         gSBU3gG34k7DMIAoYjDA8nEPPGbNLzSoBqPHa+ftPALTRSWGyWwVxV+dwnzxJVJWUUkL
         kPAg==
X-Gm-Message-State: AOAM531cilGDFDEsN+Ri8ZSVBmRq49Rn1mjBQAyDNlz5dGPzPTo1t7PJ
        s6WqLH260p8ofoqPBww3T7MwuwIX+AJq
X-Google-Smtp-Source: ABdhPJwZiwyyIevDTF2Be0IlB09TjhROqay+ZqNaazNA+9EYZDh6TThysVuzark/xBULLqZyeA3bifr3L2eT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4cee:beb8:1744:5207])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2ab:b0:49f:997e:23e2 with SMTP id
 q11-20020a056a0002ab00b0049f997e23e2mr6941992pfs.22.1636132194654; Fri, 05
 Nov 2021 10:09:54 -0700 (PDT)
Date:   Fri,  5 Nov 2021 10:09:39 -0700
In-Reply-To: <20211105170943.3479315-1-irogers@google.com>
Message-Id: <20211105170943.3479315-4-irogers@google.com>
Mime-Version: 1.0
References: <20211105170943.3479315-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 3/7] perf cputopo: Match die_siblings to topology ABI name
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
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
        Changbin Du <changbin.du@intel.com>,
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
index 212512b9feb0..65ec250f3619 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -616,15 +616,15 @@ static int write_cpu_topology(struct feat_fd *ff,
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
2.34.0.rc0.344.g81b53c2807-goog

