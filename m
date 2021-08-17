Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC4C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 05:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01B660EBD
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 05:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhHQFVt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 01:21:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:50476 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237825AbhHQFVs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 01:21:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="215996579"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="215996579"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 22:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="462255102"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2021 22:21:11 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        rickyman7@gmail.com, john.garry@huawei.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 1/2] perf pmu: Add PMU alias support
Date:   Tue, 17 Aug 2021 13:19:32 +0800
Message-Id: <20210817051933.16978-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210817051933.16978-1-yao.jin@linux.intel.com>
References: <20210817051933.16978-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A perf uncore PMU may have two PMU names, a real name and an alias. The
alias is exported at /sys/bus/event_source/devices/uncore_*/alias.
The perf tool should support the alias as well.

Add alias_name in the struct perf_pmu to store the alias. For the PMU
which doesn't have an alias. It's NULL.

Introduce two X86 specific functions to retrieve the real name and the
alias separately.

Only go through the sysfs to retrieve the mapping between the real name
and the alias once. The result is cached in a list, uncore_pmu_list.

Nothing changed for the other ARCHs.

With the patch, the perf tool can monitor the PMU with either the real
name or the alias.

Use the real name,
 $ perf stat -e uncore_cha_2/event=1/ -x,
   4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,

Use the alias,
 $ perf stat -e uncore_type_0_2/event=1/ -x,
   3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,

Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
v5:
 - Don't use strdup in pmu_find_real_name and pmu_find_alias_name.
   Just return name and keep the 'pmu->name = strdup(name);' in
   pmu_lookup.

 - Remove invalid comment for alias_name in struct perf_pmu.

v4:
 - Fix memory leaks in pmu_lookup.
 - Rebase to perf/core.

v3:
 - Use fgets to read alias string from sysfs.
 - Resource cleanup.

v2:
 - No change.

 tools/perf/arch/x86/util/pmu.c | 129 ++++++++++++++++++++++++++++++++-
 tools/perf/util/parse-events.y |   3 +-
 tools/perf/util/pmu.c          |  28 ++++++-
 tools/perf/util/pmu.h          |   5 ++
 4 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index d48d608517fd..7faa1c36b6ae 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -1,12 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
-
+#include <stdio.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <fcntl.h>
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
+#include <linux/zalloc.h>
+#include <api/fs/fs.h>
+#include <errno.h>
 
 #include "../../../util/intel-pt.h"
 #include "../../../util/intel-bts.h"
 #include "../../../util/pmu.h"
+#include "../../../util/fncache.h"
+
+#define TEMPLATE_ALIAS	"%s/bus/event_source/devices/%s/alias"
+
+struct perf_pmu_alias_name {
+	char *name;
+	char *alias;
+	struct list_head list;
+};
+
+static LIST_HEAD(pmu_alias_name_list);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
@@ -18,3 +35,113 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __mayb
 #endif
 	return NULL;
 }
+
+static int setup_pmu_alias_list(void)
+{
+	char path[PATH_MAX];
+	DIR *dir;
+	struct dirent *dent;
+	const char *sysfs = sysfs__mountpoint();
+	struct perf_pmu_alias_name *pmu;
+	char buf[MAX_PMU_NAME_LEN];
+	FILE *file;
+	int ret = 0;
+
+	if (!sysfs)
+		return -1;
+
+	snprintf(path, PATH_MAX,
+		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
+
+	dir = opendir(path);
+	if (!dir)
+		return -1;
+
+	while ((dent = readdir(dir))) {
+		if (!strcmp(dent->d_name, ".") ||
+		    !strcmp(dent->d_name, ".."))
+			continue;
+
+		snprintf(path, PATH_MAX,
+			 TEMPLATE_ALIAS, sysfs, dent->d_name);
+
+		if (!file_available(path))
+			continue;
+
+		file = fopen(path, "r");
+		if (!file)
+			continue;
+
+		if (!fgets(buf, sizeof(buf), file)) {
+			fclose(file);
+			continue;
+		}
+
+		fclose(file);
+
+		pmu = zalloc(sizeof(*pmu));
+		if (!pmu) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		/* Remove the last '\n' */
+		buf[strlen(buf) - 1] = 0;
+
+		pmu->alias = strdup(buf);
+		if (!pmu->alias)
+			goto mem_err;
+
+		pmu->name = strdup(dent->d_name);
+		if (!pmu->name)
+			goto mem_err;
+
+		list_add_tail(&pmu->list, &pmu_alias_name_list);
+		continue;
+mem_err:
+		ret = -ENOMEM;
+		free(pmu->alias);
+		free(pmu->name);
+		free(pmu);
+		break;
+	}
+
+	closedir(dir);
+	return ret;
+}
+
+static char *__pmu_find_real_name(const char *name)
+{
+	struct perf_pmu_alias_name *pmu;
+
+	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
+		if (!strcmp(name, pmu->alias))
+			return pmu->name;
+	}
+
+	return (char *)name;
+}
+
+char *pmu_find_real_name(const char *name)
+{
+	static bool cached_list;
+
+	if (cached_list)
+		return __pmu_find_real_name(name);
+
+	setup_pmu_alias_list();
+	cached_list = true;
+
+	return __pmu_find_real_name(name);
+}
+
+char *pmu_find_alias_name(const char *name)
+{
+	struct perf_pmu_alias_name *pmu;
+
+	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
+		if (!strcmp(name, pmu->name))
+			return pmu->alias;
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 9321bd0e2f76..d94e48e1ff9b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -316,7 +316,8 @@ event_pmu_name opt_pmu_config
 			if (!strncmp(name, "uncore_", 7) &&
 			    strncmp($1, "uncore_", 7))
 				name += 7;
-			if (!perf_pmu__match(pattern, name, $1)) {
+			if (!perf_pmu__match(pattern, name, $1) ||
+			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6cdbee8a12e7..9df874155370 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -945,6 +945,18 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
+char * __weak
+pmu_find_real_name(const char *name)
+{
+	return (char *)name;
+}
+
+char * __weak
+pmu_find_alias_name(const char *name __maybe_unused)
+{
+	return NULL;
+}
+
 static int pmu_max_precise(const char *name)
 {
 	char path[PATH_MAX];
@@ -958,13 +970,15 @@ static int pmu_max_precise(const char *name)
 	return max_precise;
 }
 
-static struct perf_pmu *pmu_lookup(const char *name)
+static struct perf_pmu *pmu_lookup(const char *lookup_name)
 {
 	struct perf_pmu *pmu;
 	LIST_HEAD(format);
 	LIST_HEAD(aliases);
 	__u32 type;
+	char *name = pmu_find_real_name(lookup_name);
 	bool is_hybrid = perf_pmu__hybrid_mounted(name);
+	char *alias_name;
 
 	/*
 	 * Check pmu name for hybrid and the pmu may be invalid in sysfs
@@ -995,6 +1009,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
 
 	pmu->cpus = pmu_cpumask(name);
 	pmu->name = strdup(name);
+	alias_name = pmu_find_alias_name(name);
+	if (alias_name)
+		pmu->alias_name = strdup(alias_name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
 	if (pmu->is_uncore)
@@ -1023,9 +1040,11 @@ static struct perf_pmu *pmu_find(const char *name)
 {
 	struct perf_pmu *pmu;
 
-	list_for_each_entry(pmu, &pmus, list)
-		if (!strcmp(pmu->name, name))
+	list_for_each_entry(pmu, &pmus, list) {
+		if (!strcmp(pmu->name, name) ||
+		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
 			return pmu;
+	}
 
 	return NULL;
 }
@@ -1919,6 +1938,9 @@ bool perf_pmu__has_hybrid(void)
 
 int perf_pmu__match(char *pattern, char *name, char *tok)
 {
+	if (!name)
+		return -1;
+
 	if (fnmatch(pattern, name, 0))
 		return -1;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 033e8211c025..6b122f97acf3 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -21,6 +21,7 @@ enum {
 #define PERF_PMU_FORMAT_BITS 64
 #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
+#define MAX_PMU_NAME_LEN 128
 
 struct perf_event_attr;
 
@@ -32,6 +33,7 @@ struct perf_pmu_caps {
 
 struct perf_pmu {
 	char *name;
+	char *alias_name;
 	char *id;
 	__u32 type;
 	bool selectable;
@@ -136,4 +138,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 bool perf_pmu__has_hybrid(void);
 int perf_pmu__match(char *pattern, char *name, char *tok);
 
+char *pmu_find_real_name(const char *name);
+char *pmu_find_alias_name(const char *name);
+
 #endif /* __PMU_H */
-- 
2.17.1

