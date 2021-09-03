Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5745C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0E4610CF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhICLj1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 07:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234758AbhICLj0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Sep 2021 07:39:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A88FF60EE3;
        Fri,  3 Sep 2021 11:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630669107;
        bh=UhlKxSCEI8k4mJaRIayyNBm2Q5cxn1YPwjvQPmAG6xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufm6PpzApdIk8wGk7C1wltYuh1D52U6QNagH9PWKDi/qZe3uwLAXl/lETpvDSdG+X
         fJGfTMLi4dWcJyTHgZEj39SklwEXMo7V0kge4752cARpIqXhok8q2VOfCF1TyrGzGF
         tkhCnSj01sJLItEsMPrZdP+2SMdmvrqxA0PjVyQAabhYfd5syl5NfeJ7OADZ/AKK2W
         X270vgDd1IW5Ubxq7AssFWF9cWkfd0yUIJqQ0ZPRCylr9hV9DyeRFuzuRqx/055V6s
         vK6iOOgmb5wX5RiJWptuhSrNOAyPOuuoWrd9hFiqfQ/VjtfrVAjcKufwSVYk2rr9yt
         j2O/wUeDTHr7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF78D4007E; Fri,  3 Sep 2021 08:38:23 -0300 (-03)
Date:   Fri, 3 Sep 2021 08:38:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, rickyman7@gmail.com,
        john.garry@huawei.com, Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v7 1/2] perf pmu: Add PMU alias support
Message-ID: <YTIJLyL4Ba7wuZqs@kernel.org>
References: <20210902065955.1299-1-yao.jin@linux.intel.com>
 <20210902065955.1299-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902065955.1299-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 02, 2021 at 02:59:54PM +0800, Jin Yao escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A perf uncore PMU may have two PMU names, a real name and an alias. The
> alias is exported at /sys/bus/event_source/devices/uncore_*/alias.
> The perf tool should support the alias as well.
> 
> Add alias_name in the struct perf_pmu to store the alias. For the PMU
> which doesn't have an alias. It's NULL.
> 
> Introduce two X86 specific functions to retrieve the real name and the
> alias separately.
> 
> Only go through the sysfs to retrieve the mapping between the real name
> and the alias once. The result is cached in a list, uncore_pmu_list.
> 
> Nothing changed for the other ARCHs.
> 
> With the patch, the perf tool can monitor the PMU with either the real
> name or the alias.
> 
> Use the real name,
>  $ perf stat -e uncore_cha_2/event=1/ -x,
>    4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,
> 
> Use the alias,
>  $ perf stat -e uncore_type_0_2/event=1/ -x,
>    3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,
> 
> Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
> Co-developed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
> v7:
>  - Create 'struct perf_pmu_alias_name' constructor/destructor.
>  - Return '-errno' if opendir() is failed.

Thanks for addressing those, I did a v8 here with the changes described
in my Committer notes below, please holler if you disagree.

commit 13d60ba0738b0532edab3e1492b2005d36ba0802
Author: Kan Liang <kan.liang@linux.intel.com>
Date:   Thu Sep 2 14:59:54 2021 +0800

    perf pmu: Add PMU alias support
    
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
    
    Committer notes:
    
    Rename 'struct perf_pmu_alias_name' to 'pmu_alias', the 'perf_' prefix
    should be used for libperf, things inside just tools/perf/ are being
    moved away from that prefix.
    
    Also 'pmu_alias' is shorter and reflects the abstraction.
    
    Also don't use 'pmu' as the name for variables for that type, we should
    use that for the 'struct perf_pmu' variables, avoiding confusion. Use
    'pmu_alias' for 'struct pmu_alias' variables.
    
    Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
    Co-developed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
    Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
    Reviewed-by: Andi Kleen <ak@linux.intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: John Garry <john.garry@huawei.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Riccardo Mancini <rickyman7@gmail.com>
    Link: http://lore.kernel.org/lkml/20210902065955.1299-2-yao.jin@linux.intel.com
    Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index d48d608517fd2732..74d69db1ea99df17 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -1,12 +1,30 @@
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
+struct pmu_alias {
+	char *name;
+	char *alias;
+	struct list_head list;
+};
+
+static LIST_HEAD(pmu_alias_name_list);
+static bool cached_list;
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
@@ -18,3 +36,138 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __mayb
 #endif
 	return NULL;
 }
+
+static void pmu_alias__delete(struct pmu_alias *pmu_alias)
+{
+	if (!pmu_alias)
+		return;
+
+	zfree(&pmu_alias->name);
+	zfree(&pmu_alias->alias);
+	free(pmu_alias);
+}
+
+static struct pmu_alias *pmu_alias__new(char *name, char *alias)
+{
+	struct pmu_alias *pmu_alias = zalloc(sizeof(*pmu_alias));
+
+	if (pmu_alias) {
+		pmu_alias->name = strdup(name);
+		if (!pmu_alias->name)
+			goto out_delete;
+
+		pmu_alias->alias = strdup(alias);
+		if (!pmu_alias->alias)
+			goto out_delete;
+	}
+	return pmu_alias;
+
+out_delete:
+	pmu_alias__delete(pmu_alias);
+	return NULL;
+}
+
+static int setup_pmu_alias_list(void)
+{
+	char path[PATH_MAX];
+	DIR *dir;
+	struct dirent *dent;
+	const char *sysfs = sysfs__mountpoint();
+	struct pmu_alias *pmu_alias;
+	char buf[MAX_PMU_NAME_LEN];
+	FILE *file;
+	int ret = -ENOMEM;
+
+	if (!sysfs)
+		return -1;
+
+	snprintf(path, PATH_MAX,
+		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
+
+	dir = opendir(path);
+	if (!dir)
+		return -errno;
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
+		/* Remove the last '\n' */
+		buf[strlen(buf) - 1] = 0;
+
+		pmu_alias = pmu_alias__new(dent->d_name, buf);
+		if (!pmu_alias)
+			goto close_dir;
+
+		list_add_tail(&pmu_alias->list, &pmu_alias_name_list);
+	}
+
+	ret = 0;
+
+close_dir:
+	closedir(dir);
+	return ret;
+}
+
+static char *__pmu_find_real_name(const char *name)
+{
+	struct pmu_alias *pmu_alias;
+
+	list_for_each_entry(pmu_alias, &pmu_alias_name_list, list) {
+		if (!strcmp(name, pmu_alias->alias))
+			return pmu_alias->name;
+	}
+
+	return (char *)name;
+}
+
+char *pmu_find_real_name(const char *name)
+{
+	if (cached_list)
+		return __pmu_find_real_name(name);
+
+	setup_pmu_alias_list();
+	cached_list = true;
+
+	return __pmu_find_real_name(name);
+}
+
+static char *__pmu_find_alias_name(const char *name)
+{
+	struct pmu_alias *pmu_alias;
+
+	list_for_each_entry(pmu_alias, &pmu_alias_name_list, list) {
+		if (!strcmp(name, pmu_alias->name))
+			return pmu_alias->alias;
+	}
+	return NULL;
+}
+
+char *pmu_find_alias_name(const char *name)
+{
+	if (cached_list)
+		return __pmu_find_alias_name(name);
+
+	setup_pmu_alias_list();
+	cached_list = true;
+
+	return __pmu_find_alias_name(name);
+}
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 9321bd0e2f76321a..d94e48e1ff9b22dd 100644
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
index 5f486ccb6fe67b58..bdabd62170d2cf1f 100644
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
@@ -995,6 +1009,16 @@ static struct perf_pmu *pmu_lookup(const char *name)
 
 	pmu->cpus = pmu_cpumask(name);
 	pmu->name = strdup(name);
+	if (!pmu->name)
+		goto err;
+
+	alias_name = pmu_find_alias_name(name);
+	if (alias_name) {
+		pmu->alias_name = strdup(alias_name);
+		if (!pmu->alias_name)
+			goto err;
+	}
+
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
 	if (pmu->is_uncore)
@@ -1017,15 +1041,22 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->default_config = perf_pmu__get_default_config(pmu);
 
 	return pmu;
+err:
+	if (pmu->name)
+		free(pmu->name);
+	free(pmu);
+	return NULL;
 }
 
 static struct perf_pmu *pmu_find(const char *name)
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
@@ -1919,6 +1950,9 @@ bool perf_pmu__has_hybrid(void)
 
 int perf_pmu__match(char *pattern, char *name, char *tok)
 {
+	if (!name)
+		return -1;
+
 	if (fnmatch(pattern, name, 0))
 		return -1;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5133bc45603492f7..394898b07fd9874b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -22,6 +22,7 @@ enum {
 #define PERF_PMU_FORMAT_BITS 64
 #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
+#define MAX_PMU_NAME_LEN 128
 
 struct perf_event_attr;
 
@@ -33,6 +34,7 @@ struct perf_pmu_caps {
 
 struct perf_pmu {
 	char *name;
+	char *alias_name;
 	char *id;
 	__u32 type;
 	bool selectable;
@@ -140,4 +142,7 @@ int perf_pmu__match(char *pattern, char *name, char *tok);
 int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 			 struct perf_cpu_map **mcpus_ptr,
 			 struct perf_cpu_map **ucpus_ptr);
+
+char *pmu_find_real_name(const char *name);
+char *pmu_find_alias_name(const char *name);
 #endif /* __PMU_H */
