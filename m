Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB23D7D8E
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988643; cv=none; b=Of2ARwL/13HsSzonnkXfiB47yLybTa52gW4qw3xEd7DWYSeAjGt7hMln6zr2CRGKq8EMr3c8Fh5dnp6jUSnKE5A1BGQfarCpHHiM+oPjjPGPY3enLgYDKV1ZH9ZvUxzxGt8DNjXXXKQEvFYPIP99qYnALvqW0PCxJo6+WjqVzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988643; c=relaxed/simple;
	bh=1PGpEDrzurIHI+jAtpK/VX0KBp9y3k9Nsn8PwpB08fE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S1LPpWB/3jp/aqOzlcwYxdEbTM5pQIsAW62Yow4Stir3bQQBEqDNIYiSTZlBWVbGeCutNa8cLAE8J7W7XlmKtkJdlPMNVGqVKAd38G8TC6rcyAa9ge5rciT/u5orMZHpjpWbTwAjKcpZ+BIW3r3KyD7y4GkZ1b1F+ufj+K7O1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KzAKinDt; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzAKinDt"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1382674ba2eso2474719c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988639; x=1781593439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AH49z2F9guGh4D5fao4VeFAwMh21j+YxTxcmPzMbU+8=;
        b=KzAKinDtErA7Q7eios5qPf/Ck8XYAc9zi9h+ueZHauyAE5KSJ58nmJ2075F48Eld/z
         eYKrpL6IV4VEcQiaHW67bwXZDBPmS+txKqEA+6STtdSBHaCeshvxHEl6hDC3k4KS7F6I
         +KybanrPylnuvfPm7dn/xBsqj4fMkHeEJN3kzPuQVZVJoePdRBGEJvYvG3oeq2lNpofD
         DPEGNDRATiArTbmRX3cMsA3DN3Coaz/KpQ+qVNTEOzFPC32/DCQC1EULfhqorMwdDSjq
         6JBjmFFQO0EFQ20JbUxq6DSNi4t4/0O40zyYl44v+fAjHTvBwyQl21pnUM+vQUr0uoPI
         O/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988639; x=1781593439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AH49z2F9guGh4D5fao4VeFAwMh21j+YxTxcmPzMbU+8=;
        b=remUyOiPIWwQunfZy9qKSO6rWykBvgDcTVT6FkBXIkemmUYeOp8TWeOIxnbl4QBZn5
         Zrhe1oCF+/8LK88M7MMur/OqPwQSn1n6ZLz/6QoxchH62thjjPEvnpENCc1Jwfucazg3
         fO7we6PkSC4RiJHv1ZP/SvolnFAso/fQoXBjdKUoqWuPECwlxNVyXuwddl73VUHEKye3
         FLqZ+jOxiIpQsd4B4WHrqarqDDwJ7v4x5ZiS2/CWr/P6P8hG1GjEQ6TlMFN25KkfN6qT
         Er9CqfIO1Dspjvc+hl6EdTlSxWZpWXJUniQCHmMopMMmibyNjEnC/vSgGt/2yLHr9XlX
         Mkqw==
X-Forwarded-Encrypted: i=1; AFNElJ9ICQnK00IY3jpzhHjkiZ7VXFlzr0ceEuSVCorJWzSk0yZfhTXJ7A0CK3ve/uxTW/YudUPEyyn/28qdAxgmkfRn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+2jqimx8bolx6r7VcTP2HtUooy+1jaZNGSSmzWZ9FBzF/c5g
	cL3rj+34Y8BcwivPwOk2AbHP6RDMWBc6i/AYZN+1w1xVjPBrK3ewHLr3sVGNIgsakaKg3GoMYMt
	VcnjKSDbjqA==
X-Received: from dleb2-n1.prod.google.com ([2002:a05:701b:4242:10b0:138:23e7:1c7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1a83:b0:138:e4:c44d
 with SMTP id a92af1059eb24-138067200f7mr8550206c88.25.1780988638938; Tue, 09
 Jun 2026 00:03:58 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:03:47 -0700
In-Reply-To: <20260609070348.541964-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070348.541964-3-irogers@google.com>
Subject: [PATCH v1 2/3] perf pmu: Implement tool-provided NVMe PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tomas Glozar <tglozar@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, German Gomez <german.gomez@arm.com>, 
	Anubhav Shelat <ashelat@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a tool-provided PMU for NVMe devices using libnvme. This PMU
exposes metrics from various NVMe logs (SMART, Endurance Group,
FDP, Error Information, and Zoned Namespaces) as perf events under
the 'nvme_nvmeX' PMUs.

Features:
- Generic configuration encoding (log type, size, and offset mapped
  inside the event config).
- Dynamic probing of supported log pages on /dev/nvmeX. Unsupported
  events are marked deprecated and hidden from 'perf list' by
  default.
- Correct interval delta tracking using baseline offset snapshots on
  evsel->priv.
- Proper conversion and scaling of properties like temperature (K
  to C).

Signed-off-by: Ian Rogers <irogers@google.com>
CONV=ca4c5d09-4ef8-405a-80bb-aa988020b436
TAG=agy
---
 tools/perf/util/Build      |   1 +
 tools/perf/util/evsel.c    |  11 +-
 tools/perf/util/nvme_pmu.c | 562 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/nvme_pmu.h | 112 ++++++++
 tools/perf/util/pmu.c      |  15 +
 tools/perf/util/pmu.h      |   8 +-
 tools/perf/util/pmus.c     |  26 +-
 7 files changed, 728 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/util/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b22cdc24082a..e28e99634178 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -20,6 +20,7 @@ perf-util-y += disasm.o
 perf-util-y += env.o
 perf-util-y += event.o
 perf-util-y += evlist.o
+perf-util-y += nvme_pmu.o
 perf-util-y += sideband_evlist.o
 perf-util-y += evsel.o
 perf-util-y += evsel_fprintf.o
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 34c03f47a913..8caa626af57a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -57,6 +57,7 @@
 #include "hashmap.h"
 #include "hist.h"
 #include "hwmon_pmu.h"
+#include "nvme_pmu.h"
 #include "intel-tpebs.h"
 #include "memswap.h"
 #include "off_cpu.h"
@@ -2207,6 +2208,8 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 
 	if (evsel__is_hwmon(evsel))
 		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
+	if (evsel__is_nvme(evsel))
+		return evsel__nvme_pmu_read(evsel, cpu_map_idx, thread);
 
 	if (evsel__is_drm(evsel))
 		return evsel__drm_pmu_read(evsel, cpu_map_idx, thread);
@@ -2947,8 +2950,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	}
 	if (evsel__is_hwmon(evsel)) {
 		err = evsel__hwmon_pmu_open(evsel, threads,
-					    start_cpu_map_idx,
-					    end_cpu_map_idx);
+					    start_cpu_map_idx, end_cpu_map_idx);
+		goto out;
+	}
+	if (evsel__is_nvme(evsel)) {
+		err = evsel__nvme_pmu_open(evsel, threads,
+					   start_cpu_map_idx, end_cpu_map_idx);
 		goto out;
 	}
 	if (evsel__is_drm(evsel)) {
diff --git a/tools/perf/util/nvme_pmu.c b/tools/perf/util/nvme_pmu.c
new file mode 100644
index 000000000000..17ba758aec59
--- /dev/null
+++ b/tools/perf/util/nvme_pmu.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "counts.h"
+#include "debug.h"
+#include "evsel.h"
+#include "hashmap.h"
+#include "nvme_pmu.h"
+#include "pmu.h"
+#include <internal/xyarray.h>
+#include <internal/threadmap.h>
+#include <perf/threadmap.h>
+#include <sys/types.h>
+#include <assert.h>
+#include <ctype.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <api/fs/fs.h>
+#include <api/io.h>
+#include <api/io_dir.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+
+#ifdef HAVE_LIBNVME_SUPPORT
+#include <libnvme.h>
+
+
+#define NVME_CONFIG(log, size, offset) \
+	(((uint64_t)(log) << 24) | ((uint64_t)(size) << 16) | (offset))
+
+enum nvme_log_type {
+	NVME_LOG_SMART = 0,
+	NVME_LOG_ENDURANCE = 1,
+	NVME_LOG_FDP = 2,
+	NVME_LOG_ERROR = 3,
+	NVME_LOG_ZNS = 4,
+};
+
+#define NVME_SMART(size, field) \
+	NVME_CONFIG(NVME_LOG_SMART, size, offsetof(struct nvme_smart_log, field))
+
+#define NVME_ENDURANCE(size, field) \
+	NVME_CONFIG(NVME_LOG_ENDURANCE, size, offsetof(struct nvme_endurance_group_log, field))
+
+#define NVME_FDP(size, field) \
+	NVME_CONFIG(NVME_LOG_FDP, size, offsetof(struct nvme_fdp_stats_log, field))
+
+#define NVME_ERROR(size, field) \
+	NVME_CONFIG(NVME_LOG_ERROR, size, offsetof(struct nvme_error_log_page, field))
+
+#define NVME_ZNS(size, field) \
+	NVME_CONFIG(NVME_LOG_ZNS, size, offsetof(struct nvme_zns_changed_zone_log, field))
+
+struct nvme_event {
+	const char *name;
+	const char *desc;
+	const char *scale_unit;
+	uint64_t config;
+};
+
+static const struct nvme_event nvme_events[] = {
+	{ "smart_data_units_read",
+	  "Data units read (in 1000s of 512-byte units)",
+	  "512000B", NVME_SMART(16, data_units_read) },
+	{ "smart_data_units_written",
+	  "Data units written (in 1000s of 512-byte units)",
+	  "512000B", NVME_SMART(16, data_units_written) },
+	{ "smart_host_read_commands", "Host read commands", NULL, NVME_SMART(16, host_reads) },
+	{ "smart_host_write_commands", "Host write commands", NULL, NVME_SMART(16, host_writes) },
+	{ "smart_ctrl_busy_time", "Controller busy time", "60s", NVME_SMART(16, ctrl_busy_time) },
+	{ "smart_power_cycles", "Power cycles", NULL, NVME_SMART(16, power_cycles) },
+	{ "smart_power_on_hours", "Power on hours", "1h", NVME_SMART(16, power_on_hours) },
+	{ "smart_unsafe_shutdowns", "Unsafe shutdowns", NULL, NVME_SMART(16, unsafe_shutdowns) },
+	{ "smart_media_errors", "Media errors", NULL, NVME_SMART(16, media_errors) },
+	{ "smart_num_err_log_entries",
+	  "Number of error log entries",
+	  NULL, NVME_SMART(16, num_err_log_entries) },
+	{ "smart_warning_temp_time",
+	  "Warning temperature time",
+	  "60s", NVME_SMART(4, warning_temp_time) },
+	{ "smart_crit_comp_time",
+	  "Critical composite temperature time",
+	  "60s", NVME_SMART(4, critical_comp_time) },
+	{ "smart_temperature", "Temperature", "0.001'C", NVME_SMART(2, temperature) },
+
+	{ "endurance_percent_used",
+	  "Endurance group percentage used",
+	  NULL, NVME_ENDURANCE(1, percent_used) },
+	{ "endurance_data_units_read",
+	  "Endurance group data units read",
+	  "512000B", NVME_ENDURANCE(16, data_units_read) },
+	{ "endurance_data_units_written",
+	  "Endurance group data units written",
+	  "512000B", NVME_ENDURANCE(16, data_units_written) },
+	{ "endurance_media_units_written",
+	  "Endurance group media units written",
+	  "512000B", NVME_ENDURANCE(16, media_units_written) },
+	{ "endurance_host_read_cmds",
+	  "Endurance group host read commands",
+	  NULL, NVME_ENDURANCE(16, host_read_cmds) },
+	{ "endurance_host_write_cmds",
+	  "Endurance group host write commands",
+	  NULL, NVME_ENDURANCE(16, host_write_cmds) },
+	{ "endurance_num_err_info_log_entries",
+	  "Endurance group number of error information log entries",
+	  NULL, NVME_ENDURANCE(16, num_err_info_log_entries) },
+
+	{ "fdp_hbmw", "FDP host bytes with metadata written", "1B", NVME_FDP(16, hbmw) },
+	{ "fdp_mbmw", "FDP media bytes with metadata written", "1B", NVME_FDP(16, mbmw) },
+	{ "fdp_mbe", "FDP media bytes erased", "1B", NVME_FDP(16, mbe) },
+
+	{ "error_count", "Error info log error count", NULL, NVME_ERROR(8, error_count) },
+
+	{ "zns_nrzid", "ZNS changed zone nrzid", NULL, NVME_ZNS(2, nrzid) },
+};
+
+
+struct nvme_pmu {
+	struct perf_pmu pmu;
+	char *dev_name;
+	bool support_checked;
+	bool log_supported[256];
+};
+
+
+bool perf_pmu__is_nvme(const struct perf_pmu *pmu)
+{
+	return pmu && pmu->type >= PERF_PMU_TYPE_NVME_START &&
+		pmu->type <= PERF_PMU_TYPE_NVME_END;
+}
+
+bool evsel__is_nvme(const struct evsel *evsel)
+{
+	return perf_pmu__is_nvme(evsel->pmu);
+}
+
+struct perf_pmu *nvme_pmu__new(struct list_head *pmus, const char *sysfs_name, const char *name)
+{
+	struct nvme_pmu *nvm;
+	char buf[64];
+	__u32 type;
+
+	/*
+	 * Usually sysfs_name is something like "nvme0".
+	 * We try to extract the number. If parsing fails, we use 0.
+	 */
+	type = PERF_PMU_TYPE_NVME_START + strtoul(sysfs_name + 4, NULL, 10);
+
+	if (type > PERF_PMU_TYPE_NVME_END) {
+		pr_err("Unable to encode NVMe type from %s in valid PMU type\n", sysfs_name);
+		return NULL;
+	}
+
+	snprintf(buf, sizeof(buf), "nvme_%s", name);
+
+	nvm = zalloc(sizeof(*nvm));
+	if (!nvm)
+		return NULL;
+
+	if (perf_pmu__init(&nvm->pmu, type, buf) != 0) {
+		free(nvm);
+		return NULL;
+	}
+
+	nvm->dev_name = strdup(sysfs_name);
+	if (!nvm->dev_name) {
+		perf_pmu__delete(&nvm->pmu);
+		return NULL;
+	}
+	nvm->pmu.alias_name = strdup(sysfs_name);
+	if (!nvm->pmu.alias_name) {
+		perf_pmu__delete(&nvm->pmu);
+		return NULL;
+	}
+	nvm->pmu.cpus = perf_cpu_map__new_int(0);
+	if (!nvm->pmu.cpus) {
+		perf_pmu__delete(&nvm->pmu);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&nvm->pmu.format);
+	INIT_LIST_HEAD(&nvm->pmu.caps);
+
+	list_add_tail(&nvm->pmu.list, pmus);
+	return &nvm->pmu;
+}
+
+void nvme_pmu__exit(struct perf_pmu *pmu)
+{
+	struct nvme_pmu *nvm = container_of(pmu, struct nvme_pmu, pmu);
+
+	zfree(&nvm->dev_name);
+}
+
+
+
+static void nvme_pmu__check_support(struct nvme_pmu *nvm)
+{
+	int fd;
+	char path[PATH_MAX];
+	struct nvme_smart_log smart_log;
+	struct nvme_endurance_group_log endurance_log;
+	struct nvme_fdp_stats_log fdp_log;
+	struct nvme_error_log_page error_log;
+	struct nvme_zns_changed_zone_log zns_log;
+
+	if (nvm->support_checked)
+		return;
+
+	nvm->support_checked = true;
+
+	/* Assume all supported if we can't test. */
+	memset(nvm->log_supported, 1, sizeof(nvm->log_supported));
+
+	snprintf(path, sizeof(path), "/dev/%s", nvm->dev_name);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return;
+
+	if (nvme_get_log_smart(fd, NVME_NSID_ALL, true, &smart_log) != 0)
+		nvm->log_supported[NVME_LOG_SMART] = false;
+
+	if (nvme_get_log_endurance_group(fd, 0, &endurance_log) != 0)
+		nvm->log_supported[NVME_LOG_ENDURANCE] = false;
+
+	if (nvme_get_log_fdp_stats(fd, 0, 0, sizeof(fdp_log), &fdp_log) != 0)
+		nvm->log_supported[NVME_LOG_FDP] = false;
+
+	if (nvme_get_log_error(fd, 1, true, &error_log) != 0)
+		nvm->log_supported[NVME_LOG_ERROR] = false;
+
+	if (nvme_get_log_zns_changed_zones(fd, NVME_NSID_ALL, true, &zns_log) != 0)
+		nvm->log_supported[NVME_LOG_ZNS] = false;
+
+	close(fd);
+}
+
+int nvme_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+{
+	struct nvme_pmu *nvm = container_of(pmu, struct nvme_pmu, pmu);
+	size_t i;
+
+	nvme_pmu__check_support(nvm);
+	for (i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+		const struct nvme_event *e = &nvme_events[i];
+		char alias_buf[64];
+		char desc_buf[256];
+		char encoding_buf[128];
+		struct pmu_event_info info = {
+			.pmu = pmu,
+			.name = e->name,
+			.alias = alias_buf,
+			.scale_unit = e->scale_unit,
+			.desc = desc_buf,
+			.long_desc = NULL,
+			.encoding_desc = encoding_buf,
+
+			.topic = "nvme",
+			.pmu_name = pmu->name,
+			.event_type_desc = "NVMe event",
+			.deprecated = !nvm->log_supported[(e->config >> 24) & 0xFF],
+		};
+
+		int ret;
+
+		snprintf(alias_buf, sizeof(alias_buf), "%s", e->name);
+		snprintf(desc_buf, sizeof(desc_buf), "%s", e->desc);
+		snprintf(encoding_buf, sizeof(encoding_buf),
+			 "%s/config=0x%lx/", pmu->name, e->config);
+
+		ret = cb(state, &info);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+size_t nvme_pmu__num_events(struct perf_pmu *pmu __maybe_unused)
+{
+	return ARRAY_SIZE(nvme_events);
+}
+
+bool nvme_pmu__have_event(struct perf_pmu *pmu __maybe_unused, const char *name)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+		if (!strcasecmp(name, nvme_events[i].name))
+			return true;
+	}
+	return false;
+}
+
+static int nvme_pmu__config_term(const struct nvme_pmu *nvm __maybe_unused,
+				 struct perf_event_attr *attr,
+				 struct parse_events_term *term,
+				 struct parse_events_error *err)
+{
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
+		size_t i;
+
+		for (i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+			if (!strcasecmp(term->config, nvme_events[i].name)) {
+				attr->config = nvme_events[i].config;
+				return 0;
+			}
+		}
+	}
+	if (err) {
+		char *err_str;
+
+		parse_events_error__handle(err, term->err_val,
+					asprintf(&err_str,
+						"unexpected nvme event term (%s) %s",
+						parse_events__term_type_str(term->type_term),
+						term->config) < 0
+					? strdup("unexpected nvme event term")
+					: err_str,
+					NULL);
+	}
+	return -EINVAL;
+}
+
+int nvme_pmu__config_terms(const struct perf_pmu *pmu,
+			   struct perf_event_attr *attr,
+			   struct parse_events_terms *terms,
+			   struct parse_events_error *err)
+{
+	struct nvme_pmu *nvm = container_of(pmu, struct nvme_pmu, pmu);
+	struct parse_events_term *term;
+
+	list_for_each_entry(term, &terms->terms, list) {
+		if (nvme_pmu__config_term(nvm, attr, term, err))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+int nvme_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
+			  struct parse_events_error *err)
+{
+	struct parse_events_term *term =
+		list_first_entry(&terms->terms, struct parse_events_term, list);
+
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
+		size_t i;
+
+		for (i = 0; i < ARRAY_SIZE(nvme_events); i++) {
+			if (!strcasecmp(term->config, nvme_events[i].name)) {
+				if (nvme_events[i].scale_unit) {
+					char *unit;
+
+					perf_pmu__convert_scale(nvme_events[i].scale_unit,
+								&unit, &info->scale);
+					info->unit = unit;
+				}
+				return 0;
+			}
+		}
+	}
+	if (err) {
+		char *err_str;
+
+		parse_events_error__handle(err, term->err_val,
+					asprintf(&err_str,
+						"unexpected nvme event term (%s) %s",
+						parse_events__term_type_str(term->type_term),
+						term->config) < 0
+					? strdup("unexpected nvme event term")
+					: err_str,
+					NULL);
+	}
+	return -EINVAL;
+}
+
+int perf_pmus__read_nvme_pmus(struct list_head *pmus)
+{
+	nvme_root_t r = nvme_scan(NULL);
+	nvme_host_t h;
+	nvme_subsystem_t s;
+	nvme_ctrl_t c;
+
+	if (!r)
+		return 0;
+
+	nvme_for_each_host(r, h) {
+		nvme_for_each_subsystem(h, s) {
+			nvme_subsystem_for_each_ctrl(s, c) {
+				nvme_pmu__new(pmus, nvme_ctrl_get_name(c), nvme_ctrl_get_name(c));
+			}
+		}
+	}
+	nvme_free_tree(r);
+	return 0;
+}
+
+
+static int nvme_pmu__read_val(int fd, uint64_t config, uint64_t *val)
+{
+	int log_type = (config >> 24) & 0xFF;
+	unsigned int size = (config >> 16) & 0xFF;
+	unsigned int offset = config & 0xFFFF;
+	uint8_t buf[4096];
+	uint8_t *p;
+
+	if (log_type == NVME_LOG_SMART) {
+		if (offset + size > sizeof(struct nvme_smart_log))
+			return -EINVAL;
+		if (nvme_get_log_smart(fd, NVME_NSID_ALL, true, (struct nvme_smart_log *)buf) != 0)
+			return -EINVAL;
+
+		if (offset == offsetof(struct nvme_smart_log, temperature)) {
+			uint64_t kelvin = ((struct nvme_smart_log *)buf)->temperature[0] |
+					  (((struct nvme_smart_log *)buf)->temperature[1] << 8);
+			*val = (kelvin * 1000) - 273150;
+			return 0;
+		}
+	} else if (log_type == NVME_LOG_ENDURANCE) {
+		if (offset + size > sizeof(struct nvme_endurance_group_log))
+			return -EINVAL;
+		if (nvme_get_log_endurance_group(fd, 0,
+				(struct nvme_endurance_group_log *)buf) != 0)
+			return -EINVAL;
+	} else if (log_type == NVME_LOG_FDP) {
+		if (offset + size > sizeof(struct nvme_fdp_stats_log))
+			return -EINVAL;
+		if (nvme_get_log_fdp_stats(fd, 0, 0, sizeof(struct nvme_fdp_stats_log), buf) != 0)
+			return -EINVAL;
+	} else if (log_type == NVME_LOG_ERROR) {
+		if (offset + size > sizeof(struct nvme_error_log_page))
+			return -EINVAL;
+		if (nvme_get_log_error(fd, 1, true, (struct nvme_error_log_page *)buf) != 0)
+			return -EINVAL;
+	} else if (log_type == NVME_LOG_ZNS) {
+		if (offset + size > sizeof(struct nvme_zns_changed_zone_log))
+			return -EINVAL;
+		if (nvme_get_log_zns_changed_zones(fd, NVME_NSID_ALL, true,
+				(struct nvme_zns_changed_zone_log *)buf) != 0)
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
+	p = buf + offset;
+	if (size == 16 || size == 8)
+		*val = le64_to_cpu(*(uint64_t *)p);
+	else if (size == 4)
+		*val = le32_to_cpu(*(uint32_t *)p);
+	else if (size == 2)
+		*val = le16_to_cpu(*(uint16_t *)p);
+	else if (size == 1)
+		*val = *(uint8_t *)p;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool nvme_pmu__is_gauge(uint64_t config)
+{
+	if (config == NVME_SMART(2, temperature) ||
+	    config == NVME_ENDURANCE(1, percent_used) ||
+	    config == NVME_ZNS(2, nrzid))
+		return true;
+	return false;
+}
+
+#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
+
+int evsel__nvme_pmu_open(struct evsel *evsel,
+			 struct perf_thread_map *threads,
+			 int start_cpu_map_idx, int end_cpu_map_idx)
+{
+	struct nvme_pmu *nvm = container_of(evsel->pmu, struct nvme_pmu, pmu);
+	int idx = 0, thread = 0, nthreads, err = 0;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "/dev/%s", nvm->dev_name);
+
+	nthreads = perf_thread_map__nr(threads);
+
+	if (!evsel->priv) {
+		int max_cpus = evsel->core.cpus ? perf_cpu_map__nr(evsel->core.cpus) : 1;
+
+		evsel->priv = xyarray__new(max_cpus, nthreads, sizeof(uint64_t));
+	}
+
+	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
+		for (thread = 0; thread < nthreads; thread++) {
+			int fd = open(path, O_RDONLY);
+
+			FD(evsel, idx, thread) = fd;
+			if (fd < 0) {
+				err = -errno;
+				goto out_close;
+			}
+			if (evsel->priv) {
+				uint64_t *initial_val = xyarray__entry(evsel->priv, idx, thread);
+
+				if (nvme_pmu__read_val(fd, evsel->core.attr.config, initial_val))
+					*initial_val = 0;
+			}
+		}
+	}
+	return 0;
+out_close:
+	if (err)
+		threads->err_thread = thread;
+
+	do {
+		while (--thread >= 0) {
+			if (FD(evsel, idx, thread) >= 0)
+				close(FD(evsel, idx, thread));
+			FD(evsel, idx, thread) = -1;
+		}
+		thread = nthreads;
+	} while (--idx >= 0);
+	return err;
+}
+
+int evsel__nvme_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	int fd;
+	struct perf_counts_values *count, *old_count = NULL;
+	uint64_t val = 0;
+	uint64_t *initial_val = NULL;
+
+	if (evsel->prev_raw_counts)
+		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
+
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+	fd = FD(evsel, cpu_map_idx, thread);
+
+	if (fd < 0 || nvme_pmu__read_val(fd, evsel->core.attr.config, &val)) {
+		count->lost++;
+		return -EINVAL;
+	}
+
+	if (evsel->priv)
+		initial_val = xyarray__entry(evsel->priv, cpu_map_idx, thread);
+
+	if (old_count) {
+		if (nvme_pmu__is_gauge(evsel->core.attr.config))
+			count->val = old_count->val + val;
+		else
+			count->val = val - (initial_val ? *initial_val : 0);
+		count->run = old_count->run + 1;
+		count->ena = old_count->ena + 1;
+	} else {
+		if (nvme_pmu__is_gauge(evsel->core.attr.config))
+			count->val = val;
+		else
+			count->val = val - (initial_val ? *initial_val : 0);
+		count->run++;
+		count->ena++;
+	}
+	return 0;
+}
+
+
+#endif
diff --git a/tools/perf/util/nvme_pmu.h b/tools/perf/util/nvme_pmu.h
new file mode 100644
index 000000000000..6d5d2bbe4167
--- /dev/null
+++ b/tools/perf/util/nvme_pmu.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __NVME_PMU_H
+#define __NVME_PMU_H
+
+#include "pmu.h"
+#include <stdbool.h>
+#include <errno.h>
+
+struct list_head;
+struct perf_thread_map;
+struct evsel;
+
+#ifdef HAVE_LIBNVME_SUPPORT
+struct perf_pmu *nvme_pmu__new(struct list_head *pmus, const char *sysfs_name, const char *name);
+void nvme_pmu__exit(struct perf_pmu *pmu);
+
+int nvme_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+size_t nvme_pmu__num_events(struct perf_pmu *pmu);
+bool nvme_pmu__have_event(struct perf_pmu *pmu, const char *name);
+int nvme_pmu__config_terms(const struct perf_pmu *pmu,
+			   struct perf_event_attr *attr,
+			   struct parse_events_terms *terms,
+			   struct parse_events_error *err);
+int nvme_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
+			  struct parse_events_error *err);
+
+bool perf_pmu__is_nvme(const struct perf_pmu *pmu);
+bool evsel__is_nvme(const struct evsel *evsel);
+
+int perf_pmus__read_nvme_pmus(struct list_head *pmus);
+
+int evsel__nvme_pmu_open(struct evsel *evsel,
+			 struct perf_thread_map *threads,
+			 int start_cpu_map_idx, int end_cpu_map_idx);
+int evsel__nvme_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
+#else
+static inline struct perf_pmu *nvme_pmu__new(struct list_head *pmus __maybe_unused,
+					     const char *sysfs_name __maybe_unused,
+					     const char *name __maybe_unused)
+{
+	return NULL;
+}
+
+static inline void nvme_pmu__exit(struct perf_pmu *pmu __maybe_unused)
+{
+}
+
+static inline int nvme_pmu__for_each_event(struct perf_pmu *pmu __maybe_unused,
+					   void *state __maybe_unused,
+					   pmu_event_callback cb __maybe_unused)
+{
+	return 0;
+}
+
+static inline size_t nvme_pmu__num_events(struct perf_pmu *pmu __maybe_unused)
+{
+	return 0;
+}
+
+static inline bool nvme_pmu__have_event(struct perf_pmu *pmu __maybe_unused,
+					const char *name __maybe_unused)
+{
+	return false;
+}
+
+static inline int nvme_pmu__config_terms(const struct perf_pmu *pmu __maybe_unused,
+					 struct perf_event_attr *attr __maybe_unused,
+					 struct parse_events_terms *terms __maybe_unused,
+					 struct parse_events_error *err __maybe_unused)
+{
+	return -EINVAL;
+}
+
+static inline int nvme_pmu__check_alias(struct parse_events_terms *terms __maybe_unused,
+					struct perf_pmu_info *info __maybe_unused,
+					struct parse_events_error *err __maybe_unused)
+{
+	return -EINVAL;
+}
+
+static inline bool perf_pmu__is_nvme(const struct perf_pmu *pmu __maybe_unused)
+{
+	return false;
+}
+
+static inline bool evsel__is_nvme(const struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
+static inline int perf_pmus__read_nvme_pmus(struct list_head *pmus __maybe_unused)
+{
+	return 0;
+}
+
+static inline int evsel__nvme_pmu_open(struct evsel *evsel __maybe_unused,
+				       struct perf_thread_map *threads __maybe_unused,
+				       int start_cpu_map_idx __maybe_unused,
+				       int end_cpu_map_idx __maybe_unused)
+{
+	return 0;
+}
+
+static inline int evsel__nvme_pmu_read(struct evsel *evsel __maybe_unused,
+				       int cpu_map_idx __maybe_unused,
+				       int thread __maybe_unused)
+{
+	return 0;
+}
+#endif
+
+#endif /* __NVME_PMU_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9994709ef12b..26ec19753644 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -22,6 +22,7 @@
 #include "pmu.h"
 #include "drm_pmu.h"
 #include "hwmon_pmu.h"
+#include "nvme_pmu.h"
 #include "pmus.h"
 #include "tool_pmu.h"
 #include "tp_pmu.h"
@@ -1687,6 +1688,8 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
 
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__config_terms(pmu, attr, terms, err);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__config_terms(pmu, attr, terms, err);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__config_terms(pmu, attr, terms, err);
 
@@ -1851,6 +1854,10 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		ret = hwmon_pmu__check_alias(head_terms, info, err);
 		goto out;
 	}
+	if (perf_pmu__is_nvme(pmu)) {
+		ret = nvme_pmu__check_alias(head_terms, info, err);
+		goto out;
+	}
 	if (perf_pmu__is_drm(pmu)) {
 		ret = drm_pmu__check_alias(pmu, head_terms, info, err);
 		goto out;
@@ -2071,6 +2078,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return tp_pmu__have_event(pmu, name);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__have_event(pmu, name);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__have_event(pmu, name);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__have_event(pmu, name);
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
@@ -2092,6 +2101,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 		return tp_pmu__num_events(pmu);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__num_events(pmu);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__num_events(pmu);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__num_events(pmu);
 
@@ -2223,6 +2234,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		return tp_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__for_each_event(pmu, state, cb);
+	if (perf_pmu__is_nvme(pmu))
+		return nvme_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__for_each_event(pmu, state, cb);
 
@@ -2714,6 +2727,8 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 
 	if (perf_pmu__is_hwmon(pmu))
 		hwmon_pmu__exit(pmu);
+	if (perf_pmu__is_nvme(pmu))
+		nvme_pmu__exit(pmu);
 	else if (perf_pmu__is_drm(pmu))
 		drm_pmu__exit(pmu);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 0d9f3c57e8e8..0fe47dd429e8 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -45,6 +45,8 @@ enum pmu_kind {
 	PERF_PMU_KIND_DRM,
 	/* A perf tool provided HWMON PMU. */
 	PERF_PMU_KIND_HWMON,
+	/* A perf tool provided NVME PMU. */
+	PERF_PMU_KIND_NVME,
 	/* Perf tool provided PMU for tool events like time. */
 	PERF_PMU_KIND_TOOL,
 	/* A testing PMU kind. */
@@ -53,7 +55,9 @@ enum pmu_kind {
 
 enum {
 	PERF_PMU_TYPE_PE_START    = 0,
-	PERF_PMU_TYPE_PE_END      = 0xFFFDFFFF,
+	PERF_PMU_TYPE_PE_END      = 0xFFFCFFFF,
+	PERF_PMU_TYPE_NVME_START  = 0xFFFD0000,
+	PERF_PMU_TYPE_NVME_END    = 0xFFFDFFFF,
 	PERF_PMU_TYPE_DRM_START   = 0xFFFE0000,
 	PERF_PMU_TYPE_DRM_END     = 0xFFFEFFFF,
 	PERF_PMU_TYPE_HWMON_START = 0xFFFF0000,
@@ -363,6 +367,8 @@ static inline enum pmu_kind perf_pmu__kind(const struct perf_pmu *pmu)
 	type = pmu->type;
 	if (type <= PERF_PMU_TYPE_PE_END)
 		return PERF_PMU_KIND_PE;
+	if (type <= PERF_PMU_TYPE_NVME_END)
+		return PERF_PMU_KIND_NVME;
 	if (type <= PERF_PMU_TYPE_DRM_END)
 		return PERF_PMU_KIND_DRM;
 	if (type <= PERF_PMU_TYPE_HWMON_END)
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 5e3f571450fe..83777f941e9a 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -17,6 +17,7 @@
 #include "pmus.h"
 #include "pmu.h"
 #include "hwmon_pmu.h"
+#include "nvme_pmu.h"
 #include "tool_pmu.h"
 #include "print-events.h"
 #include "strbuf.h"
@@ -44,18 +45,21 @@ enum perf_tool_pmu_type {
 	PERF_TOOL_PMU_TYPE_PE_OTHER,
 	PERF_TOOL_PMU_TYPE_TOOL,
 	PERF_TOOL_PMU_TYPE_HWMON,
+	PERF_TOOL_PMU_TYPE_NVME,
 	PERF_TOOL_PMU_TYPE_DRM,
 
 #define PERF_TOOL_PMU_TYPE_PE_CORE_MASK (1 << PERF_TOOL_PMU_TYPE_PE_CORE)
 #define PERF_TOOL_PMU_TYPE_PE_OTHER_MASK (1 << PERF_TOOL_PMU_TYPE_PE_OTHER)
 #define PERF_TOOL_PMU_TYPE_TOOL_MASK (1 << PERF_TOOL_PMU_TYPE_TOOL)
 #define PERF_TOOL_PMU_TYPE_HWMON_MASK (1 << PERF_TOOL_PMU_TYPE_HWMON)
+#define PERF_TOOL_PMU_TYPE_NVME_MASK (1 << PERF_TOOL_PMU_TYPE_NVME)
 #define PERF_TOOL_PMU_TYPE_DRM_MASK (1 << PERF_TOOL_PMU_TYPE_DRM)
 
 #define PERF_TOOL_PMU_TYPE_ALL_MASK (PERF_TOOL_PMU_TYPE_PE_CORE_MASK |	\
 					PERF_TOOL_PMU_TYPE_PE_OTHER_MASK | \
 					PERF_TOOL_PMU_TYPE_TOOL_MASK |	\
 					PERF_TOOL_PMU_TYPE_HWMON_MASK | \
+					PERF_TOOL_PMU_TYPE_NVME_MASK | \
 					PERF_TOOL_PMU_TYPE_DRM_MASK)
 };
 static unsigned int read_pmu_types;
@@ -175,12 +179,15 @@ struct perf_pmu *perf_pmus__find(const char *name)
 		return pmu;
 
 	/* Looking up an individual perf event PMU failed, check if a tool PMU should be read. */
-	if (!strncmp(name, "hwmon_", 6))
-		to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
-	else if (!strncmp(name, "drm_", 4))
+	if (!strncmp(name, "hwmon_", 6)) {
+		to_read_pmus = PERF_TOOL_PMU_TYPE_HWMON_MASK;
+	} else if (!strncmp(name, "nvme_", 5)) {
+		to_read_pmus = PERF_TOOL_PMU_TYPE_NVME_MASK;
+	} else if (!strncmp(name, "drm_", 4)) {
 		to_read_pmus |= PERF_TOOL_PMU_TYPE_DRM_MASK;
-	else if (!strcmp(name, "tool"))
+	} else if (!strcmp(name, "tool")) {
 		to_read_pmus |= PERF_TOOL_PMU_TYPE_TOOL_MASK;
+	}
 
 	if (to_read_pmus) {
 		pmu_read_sysfs(to_read_pmus);
@@ -279,6 +286,10 @@ static void pmu_read_sysfs(unsigned int to_read_types)
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)
 		perf_pmus__read_hwmon_pmus(&other_pmus);
 
+	if ((to_read_types & PERF_TOOL_PMU_TYPE_NVME_MASK) != 0 &&
+	    (read_pmu_types & PERF_TOOL_PMU_TYPE_NVME_MASK) == 0)
+		perf_pmus__read_nvme_pmus(&other_pmus);
+
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_DRM_MASK) != 0 &&
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_DRM_MASK) == 0)
 		perf_pmus__read_drm_pmus(&other_pmus);
@@ -387,6 +398,10 @@ struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *eve
 		if (strlen(event) > 4 && strncmp("drm-", event, 4) == 0)
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_DRM_MASK;
 
+		/* Could the event be an nvme event? */
+		if (nvme_pmu__have_event(NULL, event))
+			to_read_pmus |= PERF_TOOL_PMU_TYPE_NVME_MASK;
+
 		pmu_read_sysfs(to_read_pmus);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	}
@@ -424,11 +439,14 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
 		 */
 		if (strisglob(wildcard)) {
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK |
+				PERF_TOOL_PMU_TYPE_NVME_MASK |
 				PERF_TOOL_PMU_TYPE_DRM_MASK;
 		} else if (strlen(wildcard) >= 4 && strncmp("drm_", wildcard, 4) == 0) {
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_DRM_MASK;
 		} else if (strlen(wildcard) >= 5 && strncmp("hwmon", wildcard, 5) == 0) {
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
+		} else if (strlen(wildcard) >= 4 && strncmp("nvme", wildcard, 4) == 0) {
+			to_read_pmus |= PERF_TOOL_PMU_TYPE_NVME_MASK;
 		}
 
 		pmu_read_sysfs(to_read_pmus);
-- 
2.54.0.1064.gd145956f57-goog

