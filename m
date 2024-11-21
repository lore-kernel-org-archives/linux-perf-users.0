Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D5B1CD202;
	Thu, 21 Nov 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184426; cv=none; b=LD/SrYJw4K+4fHFhS6efl0UYPj+6w2HbPK0k7sZn+MVBkFWuOaYP3M6u2JkwDRBY5TDzzAVp5oYsncAA8Pj3/grfQv9ut8AASYNzDiaLtsAN84QoYU+M7uCqpaaPhLz6QRuuCChjKxU64LqWiCO0K3Ebqi9bVNTE9a086nJUvRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184426; c=relaxed/simple;
	bh=wET4jVx2tdalfskgRlTBrhP5cfdwuvk8NCiNoM2i+Uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mec+IWymKtogHJr5rDR05Up2TumdidaEsCHCuXhSSFWotlQd8sA1t/7tMze8pSBxLLV4OE0uhUpHSY5GAlAbkvP6GmnY5x0hQyY4KQakrkLCfWTNjZqGEASxsGaYVZhHyi9lyZX5Zxff+tQKOmG/2r2CiTfjbD4USX+iK0BmBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvDkP70XHz6L74P;
	Thu, 21 Nov 2024 18:19:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CBE59140A86;
	Thu, 21 Nov 2024 18:20:21 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 11:20:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linuxarm@huawei.com>, <tongtiangen@huawei.com>, Yicong Yang
	<yangyicong@huawei.com>, Niyas Sait <niyas.sait@huawei.com>,
	<ajayjoshi@micron.com>, Vandana Salve <vsalve@micron.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Gregory Price <gourry@gourry.net>, Huang
 Ying <ying.huang@intel.com>
Subject: [RFC PATCH 3/4] perf: Add support for CXL Hotness Monitoring Units (CHMU)
Date: Thu, 21 Nov 2024 10:18:44 +0000
Message-ID: <20241121101845.1815660-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

Based closely on existing support for hisi_ptt.
Provides basic record and report --dump-raw-traces support.

Example output.  With a counter_width of 16 (0x10) the least significant
4 bytes are the counter value and the unit index is bits 16-63.
Here all units are over the threshold and the indexes are 0,1,2 etc.

. ... CXL_HMU data: size 33512 bytes
Header 0: units: 29c counter_width 10
Header 1 : deadbeef
0000000000000283
0000000000010364
0000000000020366
000000000003033c
0000000000040343
00000000000502ff
000000000006030d
000000000007031a

Note this is definitely RFC quality code. Before merging should reduce
the code duplication that already exists and this code makes sorse.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/perf/arch/arm/util/auxtrace.c |  58 +++++
 tools/perf/arch/x86/util/auxtrace.c |  76 ++++++
 tools/perf/util/Build               |   1 +
 tools/perf/util/auxtrace.c          |   4 +
 tools/perf/util/auxtrace.h          |   1 +
 tools/perf/util/cxl-hmu.c           | 367 ++++++++++++++++++++++++++++
 tools/perf/util/cxl-hmu.h           |  18 ++
 7 files changed, 525 insertions(+)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 3b8eca0ffb17..07ff41800808 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -18,6 +18,7 @@
 #include "cs-etm.h"
 #include "arm-spe.h"
 #include "hisi-ptt.h"
+#include "cxl-hmu.h"
 
 static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 {
@@ -99,6 +100,49 @@ static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
 	return hisi_ptt_pmus;
 }
 
+static struct perf_pmu **find_all_cxl_hmu_pmus(int *nr_hmus, int *err)
+{
+	struct perf_pmu **cxl_hmu_pmus = NULL;
+	struct dirent *dent;
+	char path[PATH_MAX];
+	DIR *dir = NULL;
+	int idx = 0;
+
+	perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	dir = opendir(path);
+	if (!dir) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	while ((dent = readdir(dir))) {
+		if (strstr(dent->d_name, "cxl_hmu"))
+			(*nr_hmus)++;
+	}
+
+	if (!(*nr_hmus))
+		goto out;
+
+	cxl_hmu_pmus = zalloc(sizeof(struct perf_pmu *) * (*nr_hmus));
+	if (!cxl_hmu_pmus) {
+		*err = -ENOMEM;
+		goto out;
+	}
+
+	rewinddir(dir);
+	while ((dent = readdir(dir))) {
+		if (strstr(dent->d_name, "cxl_hmu") && idx < *nr_hmus) {
+			cxl_hmu_pmus[idx] = perf_pmus__find(dent->d_name);
+			if (cxl_hmu_pmus[idx])
+				idx++;
+		}
+	}
+
+out:
+	closedir(dir);
+	return cxl_hmu_pmus;
+}
+
 static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
 					   int pmu_nr, struct evsel *evsel)
 {
@@ -121,13 +165,16 @@ struct auxtrace_record
 	struct perf_pmu	*cs_etm_pmu = NULL;
 	struct perf_pmu **arm_spe_pmus = NULL;
 	struct perf_pmu **hisi_ptt_pmus = NULL;
+	struct perf_pmu **chmu_pmus = NULL;
 	struct evsel *evsel;
 	struct perf_pmu *found_etm = NULL;
 	struct perf_pmu *found_spe = NULL;
 	struct perf_pmu *found_ptt = NULL;
+	struct perf_pmu *found_chmu = NULL;
 	int auxtrace_event_cnt = 0;
 	int nr_spes = 0;
 	int nr_ptts = 0;
+	int nr_chmus = 0;
 
 	if (!evlist)
 		return NULL;
@@ -135,6 +182,7 @@ struct auxtrace_record
 	cs_etm_pmu = perf_pmus__find(CORESIGHT_ETM_PMU_NAME);
 	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
 	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
+	chmu_pmus = find_all_cxl_hmu_pmus(&nr_chmus, err);
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (cs_etm_pmu && !found_etm)
@@ -145,10 +193,14 @@ struct auxtrace_record
 
 		if (hisi_ptt_pmus && !found_ptt)
 			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
+
+		if (chmu_pmus && !found_chmu)
+			found_chmu = find_pmu_for_event(chmu_pmus, nr_chmus, evsel);
 	}
 
 	free(arm_spe_pmus);
 	free(hisi_ptt_pmus);
+	free(chmu_pmus);
 
 	if (found_etm)
 		auxtrace_event_cnt++;
@@ -159,6 +211,9 @@ struct auxtrace_record
 	if (found_ptt)
 		auxtrace_event_cnt++;
 
+	if (found_chmu)
+		auxtrace_event_cnt++;
+
 	if (auxtrace_event_cnt > 1) {
 		pr_err("Concurrent AUX trace operation not currently supported\n");
 		*err = -EOPNOTSUPP;
@@ -174,6 +229,9 @@ struct auxtrace_record
 
 	if (found_ptt)
 		return hisi_ptt_recording_init(err, found_ptt);
+
+	if (found_chmu)
+		return chmu_recording_init(err, found_chmu);
 #endif
 
 	/*
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 354780ff1605..30d84ce41394 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2013-2014, Intel Corporation.
  */
 
+#include <dirent.h>
 #include <errno.h>
 #include <stdbool.h>
 
@@ -14,6 +15,7 @@
 #include "../../../util/auxtrace.h"
 #include "../../../util/intel-pt.h"
 #include "../../../util/intel-bts.h"
+#include "../../../util/cxl-hmu.h"
 #include "../../../util/evlist.h"
 
 static
@@ -51,14 +53,88 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 	return NULL;
 }
 
+static struct perf_pmu **find_all_cxl_hmu_pmus(int *nr_hmus, int *err)
+{
+	struct perf_pmu **cxl_hmu_pmus = NULL;
+	struct dirent *dent;
+	char path[PATH_MAX];
+	DIR *dir = NULL;
+	int idx = 0;
+
+	perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	dir = opendir(path);
+	if (!dir) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	while ((dent = readdir(dir))) {
+		if (strstr(dent->d_name, "cxl_hmu"))
+			(*nr_hmus)++;
+	}
+
+	if (!(*nr_hmus))
+		goto out;
+
+	cxl_hmu_pmus = zalloc(sizeof(struct perf_pmu *) * (*nr_hmus));
+	if (!cxl_hmu_pmus) {
+		*err = -ENOMEM;
+		goto out;
+	}
+
+	rewinddir(dir);
+	while ((dent = readdir(dir))) {
+		if (strstr(dent->d_name, "cxl_hmu") && idx < *nr_hmus) {
+			cxl_hmu_pmus[idx] = perf_pmus__find(dent->d_name);
+			if (cxl_hmu_pmus[idx])
+				idx++;
+		}
+	}
+
+out:
+	closedir(dir);
+	return cxl_hmu_pmus;
+}
+
+static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
+					   int pmu_nr, struct evsel *evsel)
+{
+	int i;
+
+	if (!pmus)
+		return NULL;
+
+	for (i = 0; i < pmu_nr; i++) {
+		if (evsel->core.attr.type == pmus[i]->type)
+			return pmus[i];
+	}
+
+	return NULL;
+}
+
 struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 					      int *err)
 {
 	char buffer[64];
 	int ret;
+	struct perf_pmu **chmu_pmus = NULL;
+	struct perf_pmu *found_chmu = NULL;
+	struct evsel *evsel;
+	int nr_chmus = 0;
 
 	*err = 0;
 
+	chmu_pmus = find_all_cxl_hmu_pmus(&nr_chmus, err);
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (chmu_pmus && !found_chmu)
+			found_chmu = find_pmu_for_event(chmu_pmus, nr_chmus, evsel);
+	}
+	free(chmu_pmus);
+
+	if (found_chmu)
+		return chmu_recording_init(err, found_chmu);
+
 	ret = get_cpuid(buffer, sizeof(buffer));
 	if (ret) {
 		*err = ret;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index dc616292b2dd..40c645fd0cb3 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -127,6 +127,7 @@ perf-util-$(CONFIG_AUXTRACE) += arm-spe.o
 perf-util-$(CONFIG_AUXTRACE) += arm-spe-decoder/
 perf-util-$(CONFIG_AUXTRACE) += hisi-ptt.o
 perf-util-$(CONFIG_AUXTRACE) += hisi-ptt-decoder/
+perf-util-$(CONFIG_AUXTRACE) += cxl-hmu.o
 perf-util-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ca8682966fae..0efc15732a03 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -53,6 +53,7 @@
 #include "intel-bts.h"
 #include "arm-spe.h"
 #include "hisi-ptt.h"
+#include "cxl-hmu.h"
 #include "s390-cpumsf.h"
 #include "util/mmap.h"
 
@@ -1333,6 +1334,9 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 	case PERF_AUXTRACE_HISI_PTT:
 		err = hisi_ptt_process_auxtrace_info(event, session);
 		break;
+	case PERF_AUXTRACE_CXL_HMU:
+		err = cxl_hmu_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a1895a4f530b..8a7a5b7dc2d6 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -49,6 +49,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_ARM_SPE,
 	PERF_AUXTRACE_S390_CPUMSF,
 	PERF_AUXTRACE_HISI_PTT,
+	PERF_AUXTRACE_CXL_HMU,
 };
 
 enum itrace_period_type {
diff --git a/tools/perf/util/cxl-hmu.c b/tools/perf/util/cxl-hmu.c
new file mode 100644
index 000000000000..31844f16e4f9
--- /dev/null
+++ b/tools/perf/util/cxl-hmu.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CXL HMU support
+ * Copyright (c) 2024 Huawei
+ *
+ * Based on:
+ * HiSilicon PCIe Trace and Tuning (PTT) support
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ */
+
+#include <byteswap.h>
+#include <endian.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/types.h>
+#include <linux/zalloc.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "auxtrace.h"
+#include "color.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "cxl-hmu.h"
+#include "machine.h"
+#include "record.h"
+#include "session.h"
+#include "tool.h"
+#include "tsc.h"
+#include <internal/lib.h>
+
+#define KiB(x) ((x) * 1024)
+#define MiB(x) ((x) * 1024 * 1024)
+
+struct chmu_recording {
+	struct auxtrace_record	itr;
+	struct perf_pmu *chmu_pmu;
+	struct evlist *evlist;
+};
+
+static size_t
+chmu_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+			struct evlist *evlist __maybe_unused)
+{
+	return CXL_HMU_AUXTRACE_PRIV_SIZE;
+}
+
+static int chmu_info_fill(struct auxtrace_record *itr,
+			      struct perf_session *session,
+			      struct perf_record_auxtrace_info *auxtrace_info,
+			      size_t priv_size)
+{
+	struct chmu_recording *pttr =
+			container_of(itr, struct chmu_recording, itr);
+	struct perf_pmu *chmu_pmu = pttr->chmu_pmu;
+
+	if (priv_size != CXL_HMU_AUXTRACE_PRIV_SIZE)
+		return -EINVAL;
+
+	if (!session->evlist->core.nr_mmaps)
+		return -EINVAL;
+
+	auxtrace_info->type = PERF_AUXTRACE_CXL_HMU;
+	auxtrace_info->priv[0] = chmu_pmu->type;
+
+	return 0;
+}
+
+static int chmu_set_auxtrace_mmap_page(struct record_opts *opts)
+{
+	bool privileged = perf_event_paranoid_check(-1);
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
+		if (privileged) {
+			opts->auxtrace_mmap_pages = MiB(16) / page_size;
+		} else {
+			opts->auxtrace_mmap_pages = KiB(128) / page_size;
+			if (opts->mmap_pages == UINT_MAX)
+				opts->mmap_pages = KiB(256) / page_size;
+		}
+	}
+
+	/* Validate auxtrace_mmap_pages */
+	if (opts->auxtrace_mmap_pages) {
+		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
+		size_t min_sz = KiB(8);
+
+		if (sz < min_sz || !is_power_of_2(sz)) {
+			pr_err("Invalid mmap size for CXL_HMU: must be at least %zuKiB and a power of 2\n",
+			       min_sz / 1024);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int chmu_recording_options(struct auxtrace_record *itr,
+				      struct evlist *evlist,
+				      struct record_opts *opts)
+{
+	struct chmu_recording *pttr =
+			container_of(itr, struct chmu_recording, itr);
+	struct perf_pmu *chmu_pmu = pttr->chmu_pmu;
+	struct evsel *evsel, *chmu_evsel = NULL;
+	struct evsel *tracking_evsel;
+	int err;
+
+	pttr->evlist = evlist;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type == chmu_pmu->type) {
+			if (chmu_evsel) {
+				pr_err("There may be only one cxl_hmu x event\n");
+				return -EINVAL;
+			}
+			evsel->core.attr.freq = 0;
+			evsel->core.attr.sample_period = 1;
+			evsel->needs_auxtrace_mmap = true;
+			chmu_evsel = evsel;
+			opts->full_auxtrace = true;
+		}
+	}
+
+	err = chmu_set_auxtrace_mmap_page(opts);
+	if (err)
+		return err;
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(evlist, chmu_evsel);
+	evsel__set_sample_bit(chmu_evsel, TIME);
+
+	/* Add dummy event to keep tracking */
+	err = parse_event(evlist, "dummy:u");
+	if (err)
+		return err;
+
+	tracking_evsel = evlist__last(evlist);
+	evlist__set_tracking_event(evlist, tracking_evsel);
+
+	tracking_evsel->core.attr.freq = 0;
+	tracking_evsel->core.attr.sample_period = 1;
+	evsel__set_sample_bit(tracking_evsel, TIME);
+
+	return 0;
+}
+
+static u64 chmu_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	return rdtsc();
+}
+
+static void chmu_recording_free(struct auxtrace_record *itr)
+{
+	struct chmu_recording *pttr =
+	  container_of(itr, struct chmu_recording, itr);
+
+	free(pttr);
+}
+
+struct auxtrace_record *chmu_recording_init(int *err,
+						struct perf_pmu *chmu_pmu)
+{
+	struct chmu_recording *pttr;
+
+	if (!chmu_pmu) {
+		*err = -ENODEV;
+		return NULL;
+	}
+
+	pttr = zalloc(sizeof(*pttr));
+	if (!pttr) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	pttr->chmu_pmu = chmu_pmu;
+	pttr->itr.recording_options = chmu_recording_options;
+	pttr->itr.info_priv_size = chmu_info_priv_size;
+	pttr->itr.info_fill = chmu_info_fill;
+	pttr->itr.free = chmu_recording_free;
+	pttr->itr.reference = chmu_reference;
+	pttr->itr.read_finish = auxtrace_record__read_finish;
+	pttr->itr.alignment = 0;
+
+	*err = 0;
+	return &pttr->itr;
+}
+
+struct cxl_hmu {
+	struct auxtrace auxtrace;
+	u32 auxtrace_type;
+	struct perf_session *session;
+	struct machine *machine;
+	u32 pmu_type;
+};
+
+struct cxl_hmu_queue {
+	struct cxl_hmu *hmu;
+	struct auxtrace_buffer *buffer;
+};
+
+static void cxl_hmu_dump(struct cxl_hmu *hmu __maybe_unused,
+			  unsigned char *buf, size_t len)
+{
+	const char *color = PERF_COLOR_BLUE;
+	size_t pos = 0;
+	size_t packet_offset = 0, hotlist_entries_in_packet;
+
+	len = round_down(len, 8);
+	color_fprintf(stdout, color, ". ... CXL_HMU data: size %zu bytes\n",
+		      len);
+
+	while (len > 0) {
+		if (!packet_offset) {
+			hotlist_entries_in_packet = ((uint64_t *)(buf + pos))[0] & 0xFFFF;
+			color_fprintf(stdout, PERF_COLOR_BLUE,
+				      "Header 0: units: %x counter_width %x\n",
+				      hotlist_entries_in_packet,
+				      (((uint64_t *)(buf + pos))[0] >> 16) & 0xFF);
+		} else if (packet_offset == 1) {
+			color_fprintf(stdout, PERF_COLOR_BLUE,
+				      "Header 1 : %lx\n", ((uint64_t *)(buf + pos))[0]);
+		} else {
+			color_fprintf(stdout, PERF_COLOR_BLUE,
+				      "%016lx\n", ((uint64_t *)(buf + pos))[0]);
+		}
+		pos += 8;
+		len -= 8;
+		packet_offset++;
+		if (packet_offset == hotlist_entries_in_packet + 2)
+			packet_offset = 0;
+	}
+}
+
+static void cxl_hmu_dump_event(struct cxl_hmu *hmu, unsigned char *buf,
+			       size_t len)
+{
+	printf(".\n");
+
+	cxl_hmu_dump(hmu, buf, len);
+}
+
+static int cxl_hmu_process_event(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused,
+				  struct perf_sample *sample __maybe_unused,
+				  const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int cxl_hmu_process_auxtrace_event(struct perf_session *session,
+					  union perf_event *event,
+					  const struct perf_tool *tool __maybe_unused)
+{
+	struct cxl_hmu *hmu = container_of(session->auxtrace, struct cxl_hmu,
+					    auxtrace);
+	int fd = perf_data__fd(session->data);
+	int size = event->auxtrace.size;
+	void *data = malloc(size);
+	off_t data_offset;
+	int err;
+
+	if (!data) {
+		printf("no data\n");
+		return -errno;
+	}
+
+	if (perf_data__is_pipe(session->data)) {
+		data_offset = 0;
+	} else {
+		data_offset = lseek(fd, 0, SEEK_CUR);
+		if (data_offset == -1) {
+			free(data);
+			printf("failed to seek\n");
+			return -errno;
+		}
+	}
+
+	err = readn(fd, data, size);
+	if (err != (ssize_t)size) {
+		free(data);
+		printf("failed to rread\n");
+		return -errno;
+	}
+
+	if (dump_trace)
+		cxl_hmu_dump_event(hmu, data, size);
+
+	free(data);
+	return 0;
+}
+
+static int cxl_hmu_flush(struct perf_session *session __maybe_unused,
+			 const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void cxl_hmu_free_events(struct perf_session *session __maybe_unused)
+{
+}
+
+static void cxl_hmu_free(struct perf_session *session)
+{
+	struct cxl_hmu *hmu = container_of(session->auxtrace, struct cxl_hmu,
+					    auxtrace);
+
+	session->auxtrace = NULL;
+	free(hmu);
+}
+
+static bool cxl_hmu_evsel_is_auxtrace(struct perf_session *session,
+				       struct evsel *evsel)
+{
+	struct cxl_hmu *hmu = container_of(session->auxtrace, struct cxl_hmu, auxtrace);
+
+	return evsel->core.attr.type == hmu->pmu_type;
+}
+
+static void cxl_hmu_print_info(__u64 type)
+{
+	if (!dump_trace)
+		return;
+
+	fprintf(stdout, "  PMU Type           %" PRId64 "\n", (s64) type);
+}
+
+int cxl_hmu_process_auxtrace_info(union perf_event *event,
+				   struct perf_session *session)
+{
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
+	struct cxl_hmu *hmu;
+
+	if (auxtrace_info->header.size < CXL_HMU_AUXTRACE_PRIV_SIZE +
+				sizeof(struct perf_record_auxtrace_info))
+		return -EINVAL;
+
+	hmu = zalloc(sizeof(*hmu));
+	if (!hmu)
+		return -ENOMEM;
+
+	hmu->session = session;
+	hmu->machine = &session->machines.host; /* No kvm support */
+	hmu->auxtrace_type = auxtrace_info->type;
+	hmu->pmu_type = auxtrace_info->priv[0];
+
+	hmu->auxtrace.process_event = cxl_hmu_process_event;
+	hmu->auxtrace.process_auxtrace_event = cxl_hmu_process_auxtrace_event;
+	hmu->auxtrace.flush_events = cxl_hmu_flush;
+	hmu->auxtrace.free_events = cxl_hmu_free_events;
+	hmu->auxtrace.free = cxl_hmu_free;
+	hmu->auxtrace.evsel_is_auxtrace = cxl_hmu_evsel_is_auxtrace;
+	session->auxtrace = &hmu->auxtrace;
+
+	cxl_hmu_print_info(auxtrace_info->priv[0]);
+
+	return 0;
+}
diff --git a/tools/perf/util/cxl-hmu.h b/tools/perf/util/cxl-hmu.h
new file mode 100644
index 000000000000..9b4d83219711
--- /dev/null
+++ b/tools/perf/util/cxl-hmu.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CXL Hotness Monitoring Unit Support
+ */
+
+#ifndef INCLUDE__PERF_CXL_HMU_H__
+#define INCLUDE__PERF_CXL_HMU_H__
+
+#define CXL_HMU_PMU_NAME		"cxl_hmu"
+#define CXL_HMU_AUXTRACE_PRIV_SIZE	sizeof(u64)
+
+struct auxtrace_record *chmu_recording_init(int *err,
+					       struct perf_pmu *cxl_hmu_pmu);
+
+int cxl_hmu_process_auxtrace_info(union perf_event *event,
+				   struct perf_session *session);
+
+#endif
-- 
2.43.0

