Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928D8C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7579A61108
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhKERMo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhKERMh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 13:12:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE7C061208
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Nov 2021 10:09:57 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id m74-20020a633f4d000000b0029fed7e61f9so6106520pga.16
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Nov 2021 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DFvspK0sZoQnfT2NtkfygDOHHbIWgKCLKibbR7PUgCI=;
        b=EpCBpAWsY7s4tK6jXDDWcj1tWMqbd5OLjgamD/Vtx9rbdBUhbeQWJJnE8K2JFjExhL
         NuEq2VDI8X++bBjn3RgTPyU/ae6kfVqbpbC0cGDebcNu2cz1dfClhmWAGjWkj3/GDuGW
         1kTakVM+rOxB9JahCpyfBj9AANJ5uFvx1nFgxRpBzbwo+LHMwxHSrAu7Cj+Ugg+WeR5J
         WIfqPy6gH9eNoeYfHTwUVc+Kq40nFbSFbrD67L+bjDU0lo2jY35QLx5ewf2hGG2v+/3f
         nXxaEdInP6fcPDGuAd4Dfbs0bv6sNs9FQUtdOtZHcnq4NIPBh8NjyWOvJlhDHhtILgsi
         dG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DFvspK0sZoQnfT2NtkfygDOHHbIWgKCLKibbR7PUgCI=;
        b=BJgazm49K+ik2/pSGQVxOWu1rNIOPCWpAtHB3Kb0yfvcfCnj/uoQeA8YKNZMcuoJKo
         tOV4f+g86+TZW1zyaEtDzoTcBBDpOdXlDoTZTrwfs7fLcB3jutd+j5qtzBtY2dgENe1i
         0HrVzqH9ARjbOgVhxKBhQxDqcw/5szA+oS5UWYqC4CIi7dBL8/hDbvNM2As8f76T1g4d
         2lhsjlJxJB0tAqe3QqkNyQb0zkcAsPrRGPH3PncQLSuLz5pl1SC5W3SSruA2hJ2O+6Gi
         33z9dMlJ2QsmqqsSZgQ0BnunAU0Cbv5FAeVqn8Tjt75T3iYVB2b+PKDphp1LfdwVcGwR
         rsGw==
X-Gm-Message-State: AOAM531Z6iuDbS/hrwC/i1ksiaI35JXwXLrGfRcpNY74mAfLQNho9H33
        AldfyifMqgkjrkcRf21FDVM+nNBjOoTV
X-Google-Smtp-Source: ABdhPJzZsO9SFzUc8xS8zTBYmHP2+lXlt13+Q4GpZSoDp3tr2TnvuapA1Ha53MRldrr8G+5yV3YxXb39I45C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4cee:beb8:1744:5207])
 (user=irogers job=sendgmr) by 2002:a17:902:c115:b0:142:2441:aa23 with SMTP id
 21-20020a170902c11500b001422441aa23mr15804062pli.16.1636132196822; Fri, 05
 Nov 2021 10:09:56 -0700 (PDT)
Date:   Fri,  5 Nov 2021 10:09:40 -0700
In-Reply-To: <20211105170943.3479315-1-irogers@google.com>
Message-Id: <20211105170943.3479315-5-irogers@google.com>
Mime-Version: 1.0
References: <20211105170943.3479315-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 4/7] perf cputopo: Match thread_siblings to topology ABI name
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

The topology name for thread_siblings is core_cpus_list, use this for
consistency and add documentation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cputopo.c | 26 +++++++++++++-------------
 tools/perf/util/cputopo.h | 11 +++++++++--
 tools/perf/util/header.c  |  6 +++---
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 420aeda16fbb..51b429c86f98 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -20,10 +20,10 @@
 	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
 #define DIE_CPUS_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
-#define THRD_SIB_FMT \
-	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
-#define THRD_SIB_FMT_NEW \
+#define CORE_CPUS_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/core_cpus_list"
+#define CORE_CPUS_FMT_OLD \
+	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
 #define NODE_ONLINE_FMT \
 	"%s/devices/system/node/online"
 #define NODE_MEMINFO_FMT \
@@ -104,10 +104,10 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	ret = 0;
 
 try_threads:
-	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT_NEW,
+	scnprintf(filename, MAXPATHLEN, CORE_CPUS_FMT,
 		  sysfs__mountpoint(), cpu);
 	if (access(filename, F_OK) == -1) {
-		scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+		scnprintf(filename, MAXPATHLEN, CORE_CPUS_FMT_OLD,
 			  sysfs__mountpoint(), cpu);
 	}
 	fp = fopen(filename, "r");
@@ -121,13 +121,13 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	if (p)
 		*p = '\0';
 
-	for (i = 0; i < tp->thread_sib; i++) {
-		if (!strcmp(buf, tp->thread_siblings[i]))
+	for (i = 0; i < tp->core_cpus_lists; i++) {
+		if (!strcmp(buf, tp->core_cpus_list[i]))
 			break;
 	}
-	if (i == tp->thread_sib) {
-		tp->thread_siblings[i] = buf;
-		tp->thread_sib++;
+	if (i == tp->core_cpus_lists) {
+		tp->core_cpus_list[i] = buf;
+		tp->core_cpus_lists++;
 		buf = NULL;
 	}
 	ret = 0;
@@ -151,8 +151,8 @@ void cpu_topology__delete(struct cpu_topology *tp)
 	for (i = 0 ; i < tp->die_cpus_lists; i++)
 		zfree(&tp->die_cpus_list[i]);
 
-	for (i = 0 ; i < tp->thread_sib; i++)
-		zfree(&tp->thread_siblings[i]);
+	for (i = 0 ; i < tp->core_cpus_lists; i++)
+		zfree(&tp->core_cpus_list[i]);
 
 	free(tp);
 }
@@ -215,7 +215,7 @@ struct cpu_topology *cpu_topology__new(void)
 		tp->die_cpus_list = addr;
 		addr += sz;
 	}
-	tp->thread_siblings = addr;
+	tp->core_cpus_list = addr;
 
 	for (i = 0; i < nr; i++) {
 		if (!cpu_map__has(map, i))
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index a3e01c367853..854e18f9041e 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -9,7 +9,8 @@ struct cpu_topology {
 	u32	  package_cpus_lists;
 	/* The number of unique die_cpu_lists below. */
 	u32	  die_cpus_lists;
-	u32	  thread_sib;
+	/* The number of unique core_cpu_lists below. */
+	u32	  core_cpus_lists;
 	/*
 	 * An array of strings where each string is unique and read from
 	 * /sys/devices/system/cpu/cpuX/topology/package_cpus_list. From the ABI
@@ -24,7 +25,13 @@ struct cpu_topology {
 	 * The format is like 0-3, 8-11, 14,17.
 	 */
 	const char **die_cpus_list;
-	char	**thread_siblings;
+	/*
+	 * An array of string where each string is unique and from
+	 * /sys/devices/system/cpu/cpuX/topology/core_cpus_list. From the ABI
+	 * each of these is a human-readable list of CPUs within the same
+	 * core. The format is like 0-3, 8-11, 14,17.
+	 */
+	const char **core_cpus_list;
 };
 
 struct numa_topology_node {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 65ec250f3619..c18c5eaf6e23 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -591,12 +591,12 @@ static int write_cpu_topology(struct feat_fd *ff,
 		if (ret < 0)
 			goto done;
 	}
-	ret = do_write(ff, &tp->thread_sib, sizeof(tp->thread_sib));
+	ret = do_write(ff, &tp->core_cpus_lists, sizeof(tp->core_cpus_lists));
 	if (ret < 0)
 		goto done;
 
-	for (i = 0; i < tp->thread_sib; i++) {
-		ret = do_write_string(ff, tp->thread_siblings[i]);
+	for (i = 0; i < tp->core_cpus_lists; i++) {
+		ret = do_write_string(ff, tp->core_cpus_list[i]);
 		if (ret < 0)
 			break;
 	}
-- 
2.34.0.rc0.344.g81b53c2807-goog

