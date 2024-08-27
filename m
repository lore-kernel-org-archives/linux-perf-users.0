Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FFE1D1727;
	Tue, 27 Aug 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777083; cv=none; b=gmIZtkyq8V/TEbEwitCv9Q6Jj+AW3AGAaBRFMFpQz0RqQem8eyJUWqi1+6myVy6sc5b6Tt5ND1zFuEjvvcavpvYGivmH7A3e/4Q5BhvZO3Ht6bHKZrcYBJcEePx1SKdkCcrwkinXHpGnBTxEn6vibuCiQpZIT/GCuoEXWwE/c5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777083; c=relaxed/simple;
	bh=l1JGFFDFVWyGZ/pXbU+H47O56cooDiA6y9O/p4GX/vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNMix9CQ0boCI8WlWzDc6pthlNKq8sEFzzuei3I/gZm/LfPyDPjy4vO2k8JnXls/I/DrH6V1R6liJ67wq2G1QBmuYHf+QS/ZmCSJ+wF8l7NIhzgZvaHaQaCA0AVtLN/Qr4ZpWkf66K3B6IEt5OIX4qPDMGDmiH22iyBHys1JKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FC1F11FB;
	Tue, 27 Aug 2024 09:45:06 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 422B63F762;
	Tue, 27 Aug 2024 09:44:38 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 3/9] perf auxtrace arm: Introduce find_auxtrace_pmus_by_name()
Date: Tue, 27 Aug 2024 17:44:11 +0100
Message-Id: <20240827164417.3309560-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827164417.3309560-1-leo.yan@arm.com>
References: <20240827164417.3309560-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm auxtrace searches the opened PMU events for Arm SPE and Hisilicon
HTT. The current approach is to first iterate all PMU devices under the
sysfs folder and then match the PMU event on the evlist.

Since the evlist has sufficient info for the PMU name and corresponding
PMU pointer, it is no need to browse the PMU devices from sysfs nodes.
Alternatively, by traversing the evlist and comparing prefixes for PMU
names, we can directly gather the PMU pointers and save them into an
array. Following the idea, this patch introduces a new function
find_auxtrace_pmus_by_name().

find_auxtrace_pmus_by_name() returns a PMU pointer array or NULL if no
any PMU is found. This simplifies the auxtrace_record__init() function,
as the PMU array pointers are for found PMU events. The local variables
'found_{etm|spe|ptt}' and relevant code are redundant, so remove them.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 158 ++++++++--------------------
 1 file changed, 41 insertions(+), 117 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 74630d2d81dc..2fca16659858 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -7,6 +7,7 @@
 #include <dirent.h>
 #include <stdbool.h>
 #include <linux/coresight-pmu.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <api/fs/fs.h>
 
@@ -19,144 +20,66 @@
 #include "arm-spe.h"
 #include "hisi-ptt.h"
 
-static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
+static struct perf_pmu **
+find_auxtrace_pmus_by_name(struct evlist *evlist, const char *name, int *nr_pmu)
 {
-	struct perf_pmu **arm_spe_pmus = NULL;
-	int ret, i, nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-	/* arm_spe_xxxxxxxxx\0 */
-	char arm_spe_pmu_name[sizeof(ARM_SPE_PMU_NAME) + 10];
-
-	arm_spe_pmus = zalloc(sizeof(struct perf_pmu *) * nr_cpus);
-	if (!arm_spe_pmus) {
-		pr_err("spes alloc failed\n");
-		*err = -ENOMEM;
-		return NULL;
-	}
-
-	for (i = 0; i < nr_cpus; i++) {
-		ret = sprintf(arm_spe_pmu_name, "%s%d", ARM_SPE_PMU_NAME, i);
-		if (ret < 0) {
-			pr_err("sprintf failed\n");
-			*err = -ENOMEM;
-			return NULL;
-		}
+	struct perf_pmu **pmus = NULL;
+	struct evsel *evsel;
+	int i = 0, nr = 0;
 
-		arm_spe_pmus[*nr_spes] = perf_pmus__find(arm_spe_pmu_name);
-		if (arm_spe_pmus[*nr_spes]) {
-			pr_debug2("%s %d: arm_spe_pmu %d type %d name %s\n",
-				 __func__, __LINE__, *nr_spes,
-				 arm_spe_pmus[*nr_spes]->type,
-				 arm_spe_pmus[*nr_spes]->name);
-			(*nr_spes)++;
-		}
-	}
+	assert(name);
+	assert(nr_pmu);
 
-	return arm_spe_pmus;
-}
+	*nr_pmu = 0;
 
-static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
-{
-	struct perf_pmu **hisi_ptt_pmus = NULL;
-	struct dirent *dent;
-	char path[PATH_MAX];
-	DIR *dir = NULL;
-	int idx = 0;
-
-	perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	dir = opendir(path);
-	if (!dir) {
-		pr_err("can't read directory '%s'\n", path);
-		*err = -EINVAL;
-		return NULL;
-	}
-
-	while ((dent = readdir(dir))) {
-		if (strstr(dent->d_name, HISI_PTT_PMU_NAME))
-			(*nr_ptts)++;
+	evlist__for_each_entry(evlist, evsel) {
+		if (strstarts(evsel->pmu_name, name))
+			nr++;
 	}
 
-	if (!(*nr_ptts))
-		goto out;
+	if (!nr)
+		return NULL;
 
-	hisi_ptt_pmus = zalloc(sizeof(struct perf_pmu *) * (*nr_ptts));
-	if (!hisi_ptt_pmus) {
-		pr_err("hisi_ptt alloc failed\n");
-		*err = -ENOMEM;
-		goto out;
+	pmus = zalloc(sizeof(struct perf_pmu *) * nr);
+	if (!pmus) {
+		pr_err("Failed to allocate PMU pointer arrary.\n");
+		return NULL;
 	}
 
-	rewinddir(dir);
-	while ((dent = readdir(dir))) {
-		if (strstr(dent->d_name, HISI_PTT_PMU_NAME) && idx < *nr_ptts) {
-			hisi_ptt_pmus[idx] = perf_pmus__find(dent->d_name);
-			if (hisi_ptt_pmus[idx])
-				idx++;
+	evlist__for_each_entry(evlist, evsel) {
+		if (strstarts(evsel->pmu_name, name)) {
+			pmus[i] = evsel->pmu;
+			i++;
 		}
 	}
 
-out:
-	closedir(dir);
-	return hisi_ptt_pmus;
-}
-
-static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
-					   int pmu_nr, struct evsel *evsel)
-{
-	int i;
-
-	if (!pmus)
-		return NULL;
-
-	for (i = 0; i < pmu_nr; i++) {
-		if (evsel->core.attr.type == pmus[i]->type)
-			return pmus[i];
-	}
-
-	return NULL;
+	*nr_pmu = nr;
+	return pmus;
 }
 
 struct auxtrace_record
 *auxtrace_record__init(struct evlist *evlist, int *err)
 {
-	struct perf_pmu	*cs_etm_pmu = NULL;
+	struct perf_pmu	**cs_etm_pmu = NULL;
 	struct perf_pmu **arm_spe_pmus = NULL;
 	struct perf_pmu **hisi_ptt_pmus = NULL;
-	struct evsel *evsel;
-	struct perf_pmu *found_etm = NULL;
-	struct perf_pmu *found_spe = NULL;
-	struct perf_pmu *found_ptt = NULL;
 	struct auxtrace_record *itr = NULL;
 	int auxtrace_event_cnt = 0;
-	int nr_spes = 0;
-	int nr_ptts = 0;
+	int nr_etm = 0;
+	int nr_spe = 0;
+	int nr_ptt = 0;
 
 	if (!evlist)
 		return NULL;
 
-	cs_etm_pmu = perf_pmus__find(CORESIGHT_ETM_PMU_NAME);
-	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
-	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (cs_etm_pmu && !found_etm)
-			found_etm = find_pmu_for_event(&cs_etm_pmu, 1, evsel);
-
-		if (arm_spe_pmus && !found_spe)
-			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
-
-		if (hisi_ptt_pmus && !found_ptt)
-			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
-	}
-
-	if (found_etm)
-		auxtrace_event_cnt++;
-
-	if (found_spe)
-		auxtrace_event_cnt++;
-
-	if (found_ptt)
-		auxtrace_event_cnt++;
+	cs_etm_pmu =
+		find_auxtrace_pmus_by_name(evlist, CORESIGHT_ETM_PMU_NAME, &nr_etm);
+	arm_spe_pmus =
+		find_auxtrace_pmus_by_name(evlist, ARM_SPE_PMU_NAME, &nr_spe);
+	hisi_ptt_pmus =
+		find_auxtrace_pmus_by_name(evlist, HISI_PTT_PMU_NAME, &nr_ptt);
 
+	auxtrace_event_cnt = !!nr_etm + !!nr_spe + !!nr_ptt;
 	if (!auxtrace_event_cnt) {
 		/*
 		 * Clear 'err' even if we haven't found an event - that way perf
@@ -172,18 +95,19 @@ struct auxtrace_record
 		goto out;
 	}
 
-	if (found_etm)
+	if (cs_etm_pmu)
 		itr = cs_etm_record_init(err);
 
 #if defined(__aarch64__)
-	if (found_spe)
-		itr = arm_spe_recording_init(err, found_spe);
+	if (arm_spe_pmus)
+		itr = arm_spe_recording_init(err, arm_spe_pmus[0]);
 
-	if (found_ptt)
-		itr = hisi_ptt_recording_init(err, found_ptt);
+	if (hisi_ptt_pmus)
+		itr = hisi_ptt_recording_init(err, hisi_ptt_pmus[0]);
 #endif
 
 out:
+	free(cs_etm_pmu);
 	free(arm_spe_pmus);
 	free(hisi_ptt_pmus);
 	return itr;
-- 
2.34.1

