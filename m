Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57473E40F3
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186416; cv=none; b=TQRujx/YCZWV2GtsFnRC0rkjqZrS6SDqKyUFDTbhURhZXYXSaO/rIyg0C4j+ZuHD4CnY82VExFvLwHHpfNBbFTa75zjC9xT3VGZFI+4YUt6xTicDiSdU2azgWdwzk4w7X5AzHEFDi+/RuahKNdzRWQ7uLpPGZWzGbC4CU6q5Ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186416; c=relaxed/simple;
	bh=4iEJ74PTzSV5ehnivoqssmI1l3R+k8zBdDjBD9qwpME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WfnlFyTZG5g7qigEMofGHXIUGWgs8ZM/x9q8XaqaWVkyAujAYPiHZbKxQRtLrQVyb202x/iTlXoPDs0on+HZQIXzZk32iywaddbSUYyd7E0HJt2ttTA/VbvYmjTruoYLMbAZFZRhGsBAxw+wgM5RmvTAKTu2K6zRiopu+dwzvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjilt9Mu; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjilt9Mu"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso445467eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792186408; x=1792791208; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdC7FM8a43uLxJYu7bHvMe468X73gPFpxy1YrCBJi0w=;
        b=tjilt9MuA42XZGwJsJsJdNEtgRO1wpxuD5Zk9qXaesr4lWl3sflbHH5BT/JHHcQ8pU
         B/0U/J5nZ1aRXhmwmZiFH1YV2V8TIltVNnN5BoQZwKg2aPpCV5OhZFlANeIit5zw7JdW
         9WRXG18kVe/FU8FGrrMaGWclsQN0hm/rD/njTnjmn0NWXRYh6JzMSDd1g4sODYOEQXQd
         OQOFaeLj6vvLEd8bHVDSJ0dCOeOsb7nIwsHhSd1InpzXRYYHDdNiUnQqICChej9JfVCY
         AfgjY6ajvzLwf1g9vuocnNkCr8U68Rgr5S/fahjr/XVjjTJzTV7+hUgHNetySg+AxCZS
         EcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186408; x=1792791208;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KdC7FM8a43uLxJYu7bHvMe468X73gPFpxy1YrCBJi0w=;
        b=H3e4RquY7MNQnqFuqFE3QcVUJkit12vz4yJqfh62LwiIN33a50NUi3/JlpeD8hUlVE
         rd2mZrRquSpbCxYLdftwkWBuWIwzaM4mQbiIU+uwWx3U7g5GcS91rVV0enWP9kcADBvJ
         sIPgAEbkp9dmcYWpp8QBaNHaRnr8wO6HChqTATyibcGX7CpbsoyN7fzgT0LrhQ56aWhP
         AmeZ15iL3IW+u6OJmJGJZu0oTDrNFUjAgE+juhHLZGeevpFqkbcAhzBB7CSxFHwV5DpG
         Tw6z/CG9JCPjI8bg75Goj9eLA8WA00/spBmtf11NT6a6+Yl8I7vRx98wY0/k4I4SP+2R
         bNjg==
X-Gm-Message-State: AFq9FYJFzgVJgS3SGvK9lSuyoIXz70NzgElb9oM9nqKAXgZ8V68fuj5p
	daUEm+mJMrtZrtBrb//jSM1/CVmwHhJve6e1Np4hH9ffIzOogJFiwiqYVlvVl57mApkyZ8IQJaD
	Hrxx3axGtNQ==
X-Received: from dybmt8.prod.google.com ([2002:a05:7300:d588:b0:351:4a2a:1ece])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6197:20b0:351:4d2d:af26
 with SMTP id 5a478bee46e88-3619f1fca55mr1427186eec.2.1792186404881; Fri, 16
 Oct 2026 14:33:24 -0700 (PDT)
Date: Fri, 16 Oct 2026 14:32:57 -0700
In-Reply-To: <20261016213258.945737-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016213258.945737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016213258.945737-2-irogers@google.com>
Subject: [RFC PATCH v1 1/2] perf pmus: Add PMU environment loading and live
 capability probing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add helpers to reconstruct PMU lists and capabilities from perf_env
headers (for perf.data files), expose duplicate uncore PMU scanning and
mem-events formatting helpers, and add perf_pmu__probe() to actively
probe live PMU capabilities via perf_event_open().

Probed capabilities stored in struct perf_pmu::probed include counting,
sampling, and branch_stack modes, precise_ip levels and measured branch
instruction skid, supported perf_event_sample_format flags, user and
interrupt sampling registers, memory profiling events and sample types,
privilege exclusion modifiers, leader sampling, software event grouping,
auto-counter reload, AUX actions (start_paused, pause, resume,
aux_sample), user-space counter reading (rdpmc) and PMC width, and
rotating event group size limits.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mem-events.c |   14 +-
 tools/perf/util/mem-events.h |    3 +
 tools/perf/util/pmu.c        | 1976 +++++++++++++++++++++++++++++++++-
 tools/perf/util/pmu.h        |  135 ++-
 tools/perf/util/pmus.c       |  221 +++-
 tools/perf/util/pmus.h       |    4 +
 6 files changed, 2342 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0cdcb47647bd..eb2a4973e385 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -79,12 +79,12 @@ int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu)
 	return num;
 }
 
-static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
-					     char *buf, size_t buf_size)
+const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
+				      char *buf, size_t buf_size)
 {
 	struct perf_mem_event *e;
 
-	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
+	if (i >= PERF_MEM_EVENTS__MAX || !pmu || !pmu->mem_events)
 		return NULL;
 
 	e = &pmu->mem_events[i];
@@ -193,13 +193,13 @@ static bool perf_pmu__mem_events_supported(const char *mnt, struct perf_pmu *pmu
 	return !stat(path, &st);
 }
 
-static int __perf_pmu__mem_events_init(struct perf_pmu *pmu)
+int perf_pmu__mem_events_init_pmu(struct perf_pmu *pmu)
 {
 	const char *mnt = sysfs__mount();
 	bool found = false;
 	int j;
 
-	if (!mnt)
+	if (!mnt || !pmu || !pmu->mem_events)
 		return -ENOENT;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
@@ -209,7 +209,7 @@ static int __perf_pmu__mem_events_init(struct perf_pmu *pmu)
 		 * If the event entry isn't valid, skip initialization
 		 * and "e->supported" will keep false.
 		 */
-		if (!e->tag)
+		if (!e || !e->tag)
 			continue;
 
 		e->supported |= perf_pmu__mem_events_supported(mnt, pmu, e);
@@ -225,7 +225,7 @@ int perf_pmu__mem_events_init(void)
 	struct perf_pmu *pmu = NULL;
 
 	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
-		if (__perf_pmu__mem_events_init(pmu))
+		if (perf_pmu__mem_events_init_pmu(pmu))
 			return -ENOENT;
 	}
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 38b14c03392c..64517ca053d3 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -31,7 +31,10 @@ extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
 extern bool perf_mem_record[PERF_MEM_EVENTS__MAX];
 
 int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
+int perf_pmu__mem_events_init_pmu(struct perf_pmu *pmu);
 int perf_pmu__mem_events_init(void);
+const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
+				      char *buf, size_t buf_size);
 
 struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i);
 struct perf_pmu *perf_mem_events_find_pmu(void);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 01753d5c69d1..0d1c5ba7d426 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -38,7 +38,22 @@
 #include "strbuf.h"
 #include "fncache.h"
 #include "util/evsel_config.h"
+#include "cloexec.h"
+#include "dwarf-regs.h"
+#include "evlist.h"
+#include "mem-events.h"
+#include "mmap.h"
+#include "perf_regs.h"
+#include "rlimit.h"
+#include "util/sample.h"
+#include "../perf-sys.h"
+#include <linux/hw_breakpoint.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sched.h>
 #include <regex.h>
+#include <elf.h>
+#include <link.h>
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
@@ -2139,7 +2154,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	size_t nr;
 
 	if (perf_pmu__is_tracepoint(pmu))
-		return tp_pmu__num_events(pmu);
+		return pmu->sysfs_aliases_loaded ? 0 : tp_pmu__num_events(pmu);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__num_events(pmu);
 	if (perf_pmu__is_drm(pmu))
@@ -2275,7 +2290,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	size_t size_rem;
 
 	if (perf_pmu__is_tracepoint(pmu))
-		return tp_pmu__for_each_event(pmu, state, cb);
+		return pmu->sysfs_aliases_loaded ? 0 : tp_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_drm(pmu))
@@ -2564,6 +2579,37 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
 	return -ENOMEM;
 }
 
+int perf_pmu__add_cap(struct perf_pmu *pmu, const char *name, const char *value)
+{
+	struct perf_pmu_caps *caps;
+
+	if (!pmu || !name || !value)
+		return -EINVAL;
+	if (perf_pmu__get_cap(pmu, name))
+		return 0;
+
+	caps = zalloc(sizeof(*caps));
+	if (!caps)
+		return -ENOMEM;
+
+	caps->name = strdup(name);
+	if (!caps->name) {
+		free(caps);
+		return -ENOMEM;
+	}
+	caps->value = strdup(value);
+	if (!caps->value) {
+		zfree(&caps->name);
+		free(caps);
+		return -ENOMEM;
+	}
+	list_add_tail(&caps->list, &pmu->caps);
+	pmu->nr_caps++;
+	if (!strcmp(name, "max_precise"))
+		pmu->max_precise = atoi(value);
+	return 0;
+}
+
 static void perf_pmu__del_caps(struct perf_pmu *pmu)
 {
 	struct perf_pmu_caps *caps, *tmp;
@@ -2798,9 +2844,1935 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->name);
 	zfree(&pmu->alias_name);
 	zfree(&pmu->id);
+	zfree(&pmu->probed.probe_event);
 	free(pmu);
 }
 
+#define MAX_PROBE_GROUP_SIZE 64
+#define MAX_PROBE_CANDIDATES 16
+
+static unsigned long dummy_bp_var;
+
+static bool get_self_uprobe_target(char *exe_path, __u64 *out_offset)
+{
+	ElfW(Ehdr) ehdr;
+	int fd;
+	bool found = false;
+
+	if (!realpath("/proc/self/exe", exe_path))
+		return false;
+
+	fd = open(exe_path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return false;
+
+	if (pread(fd, &ehdr, sizeof(ehdr), 0) != sizeof(ehdr) ||
+	    memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 ||
+	    ehdr.e_phentsize < sizeof(ElfW(Phdr))) {
+		close(fd);
+		return false;
+	}
+
+	for (unsigned int i = 0; i < ehdr.e_phnum; i++) {
+		ElfW(Phdr) phdr;
+		off_t pos = (off_t)ehdr.e_phoff + (off_t)i * ehdr.e_phentsize;
+
+		if (pread(fd, &phdr, sizeof(phdr), pos) != sizeof(phdr))
+			break;
+		if (phdr.p_type != PT_LOAD || !(phdr.p_flags & PF_X))
+			continue;
+		if (ehdr.e_entry >= phdr.p_vaddr &&
+		    ehdr.e_entry < phdr.p_vaddr + phdr.p_filesz) {
+			*out_offset = phdr.p_offset + (ehdr.e_entry - phdr.p_vaddr);
+			found = true;
+			break;
+		}
+	}
+
+	close(fd);
+	return found;
+}
+
+struct probe_candidates {
+	char *names[MAX_PROBE_CANDIDATES];
+	size_t nr;
+};
+
+static void probe_candidates__add(struct probe_candidates *cands, const char *str)
+{
+	if (cands->nr >= MAX_PROBE_CANDIDATES || !str)
+		return;
+	for (size_t i = 0; i < cands->nr; i++) {
+		if (!strcmp(cands->names[i], str))
+			return;
+	}
+	cands->names[cands->nr] = strdup(str);
+	if (cands->names[cands->nr])
+		cands->nr++;
+}
+
+static void probe_candidates__exit(struct probe_candidates *cands)
+{
+	for (size_t i = 0; i < cands->nr; i++)
+		zfree(&cands->names[i]);
+	cands->nr = 0;
+}
+
+static int collect_probe_candidate_cb(void *vstate, struct pmu_event_info *info)
+{
+	struct probe_candidates *cands = vstate;
+	char buf[512];
+
+	if (info->deprecated)
+		return 0;
+	if (info->str && strstr(info->str, "=?"))
+		return 0;
+	if (!info->name)
+		return 0;
+
+	if (info->pmu && info->pmu->type == PERF_TYPE_TRACEPOINT) {
+		probe_candidates__add(cands, info->name);
+		return 1;
+	} else if (strchr(info->name, '/')) {
+		probe_candidates__add(cands, info->name);
+	} else if (info->pmu && info->pmu->name) {
+		snprintf(buf, sizeof(buf), "%s/%s/", info->pmu->name, info->name);
+		probe_candidates__add(cands, buf);
+	} else {
+		probe_candidates__add(cands, info->name);
+	}
+
+	return cands->nr >= MAX_PROBE_CANDIDATES ? 1 : 0;
+}
+
+static bool parse_candidate_attr(const char *event_str, struct perf_event_attr *attr)
+{
+	struct evlist *evlist;
+	struct parse_events_error err;
+	struct evsel *evsel;
+	int ret;
+
+	evlist = evlist__new();
+	if (!evlist)
+		return false;
+
+	parse_events_error__init(&err);
+	ret = __parse_events(evlist, event_str, /*pmu_filter=*/NULL,
+			     /*cputype_filter=*/false, &err, /*fake_pmu=*/false,
+			     /*warn_if_reordered=*/false, /*fake_tp=*/false);
+	parse_events_error__exit(&err);
+	if (ret || evlist__empty(evlist)) {
+		evlist__put(evlist);
+		return false;
+	}
+
+	evsel = evlist__first(evlist);
+	*attr = evsel->core.attr;
+	evlist__put(evlist);
+	return true;
+}
+
+static int select_probe_cpu(const struct perf_pmu *pmu)
+{
+	struct perf_cpu_map *online = perf_cpu_map__new_online_cpus();
+	int cpu = 0;
+
+	if (pmu->cpus && !perf_cpu_map__is_empty(pmu->cpus)) {
+		int nr = perf_cpu_map__nr(pmu->cpus);
+
+		cpu = perf_cpu_map__cpu(pmu->cpus, 0).cpu;
+		if (online) {
+			for (int i = 0; i < nr; i++) {
+				struct perf_cpu c = perf_cpu_map__cpu(pmu->cpus, i);
+
+				if (perf_cpu_map__has(online, c)) {
+					cpu = c.cpu;
+					break;
+				}
+			}
+		}
+	} else if (online && !perf_cpu_map__is_empty(online)) {
+		cpu = perf_cpu_map__cpu(online, 0).cpu;
+	}
+
+	perf_cpu_map__put(online);
+	return cpu >= 0 ? cpu : 0;
+}
+
+static bool try_open_attr_variants(struct perf_event_attr *attr,
+				   bool is_uncore, int pmu_cpu,
+				   unsigned long flags,
+				   pid_t *out_pid, int *out_cpu,
+				   int *last_err)
+{
+	pid_t pids[2];
+	size_t nr_pids = 2;
+
+	if (is_uncore) {
+		pids[0] = -1;
+		pids[1] = 0;
+	} else {
+		pids[0] = 0;
+		pids[1] = -1;
+	}
+
+	for (size_t p = 0; p < nr_pids; p++) {
+		pid_t pid = pids[p];
+
+		for (int samp = 0; samp < 2; samp++) {
+			for (int priv = 0; priv < 4; priv++) {
+				struct perf_event_attr try_attr = *attr;
+				int fd;
+
+				try_attr.size = sizeof(try_attr);
+				try_attr.disabled = 1;
+				try_attr.read_format = 0;
+				if (samp == 0) {
+					try_attr.sample_period = 0;
+					try_attr.freq = 0;
+					try_attr.sample_type = 0;
+				} else {
+					try_attr.sample_period = 10000;
+					try_attr.freq = 0;
+					try_attr.sample_type = PERF_SAMPLE_IP;
+				}
+
+				if (priv >= 1)
+					try_attr.exclude_kernel = 1;
+				if (priv >= 2)
+					try_attr.exclude_hv = 1;
+				if (priv >= 3)
+					try_attr.exclude_guest = 1;
+
+				fd = sys_perf_event_open(&try_attr, pid, pmu_cpu, -1, flags);
+				if (fd >= 0) {
+					close(fd);
+					*attr = try_attr;
+					*out_pid = pid;
+					*out_cpu = pmu_cpu;
+					return true;
+				}
+				if (*last_err == 0 || *last_err == ENOENT || *last_err == EINVAL)
+					*last_err = errno;
+			}
+		}
+	}
+	return false;
+}
+
+static bool check_group_active(int leader_fd, int last_fd)
+{
+	u64 before[3] = { 0, 0, 0 };
+	u64 after[3] = { 0, 0, 0 };
+	u64 f_before[3] = { 0, 0, 0 };
+	u64 f_after[3] = { 0, 0, 0 };
+	u64 delta_ena, delta_run;
+	bool check_follower = false;
+
+	if (read(leader_fd, before, sizeof(before)) != sizeof(before))
+		return false;
+
+	if (last_fd >= 0 && read(last_fd, f_before, sizeof(f_before)) == sizeof(f_before))
+		check_follower = true;
+
+	if (ioctl(leader_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP) < 0)
+		return false;
+
+	for (int spin = 0; spin < 20000; spin++)
+		barrier();
+
+	ioctl(leader_fd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
+
+	if (read(leader_fd, after, sizeof(after)) != sizeof(after))
+		return false;
+
+	if (check_follower && read(last_fd, f_after, sizeof(f_after)) != sizeof(f_after))
+		return false;
+
+	delta_ena = after[1] - before[1];
+	delta_run = after[2] - before[2];
+	if (delta_ena == 0 || delta_run != delta_ena)
+		return false;
+
+	if (check_follower) {
+		u64 f_delta_ena = f_after[1] - f_before[1];
+		u64 f_delta_run = f_after[2] - f_before[2];
+
+		if (f_delta_ena == 0 || f_delta_run != f_delta_ena)
+			return false;
+	}
+
+	return true;
+}
+
+static void probe_group_limits(const struct perf_event_attr *attrs, size_t nr_attrs,
+			       pid_t pid, int cpu, unsigned long flags,
+			       int *max_open, bool *open_capped,
+			       int *max_active, bool *active_capped)
+{
+	struct perf_event_attr leader_attr;
+	int leader_fd;
+	int fds[MAX_PROBE_GROUP_SIZE];
+	int nr_followers = 0;
+	bool has_time_read = true;
+	bool active_ok = true;
+	enum rlimit_action set_rlimit = NO_CHANGE;
+	cpu_set_t saved_affinity, probe_affinity;
+	bool affinity_changed = false;
+
+	*max_open = 0;
+	*open_capped = false;
+	*max_active = 0;
+	*active_capped = false;
+
+	if (!attrs || nr_attrs == 0)
+		return;
+
+	if (pid == 0 && cpu >= 0) {
+		CPU_ZERO(&saved_affinity);
+		if (sched_getaffinity(0, sizeof(saved_affinity), &saved_affinity) == 0) {
+			CPU_ZERO(&probe_affinity);
+			CPU_SET(cpu, &probe_affinity);
+			if (sched_setaffinity(0, sizeof(probe_affinity), &probe_affinity) == 0)
+				affinity_changed = true;
+		}
+	}
+
+	leader_attr = attrs[0];
+	leader_attr.disabled = 1;
+	leader_attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
+
+	leader_fd = sys_perf_event_open(&leader_attr, pid, cpu, -1, flags);
+	if (leader_fd < 0) {
+		leader_attr.read_format = 0;
+		has_time_read = false;
+		leader_fd = sys_perf_event_open(&leader_attr, pid, cpu, -1, flags);
+	}
+	if (leader_fd < 0)
+		goto out_affinity;
+
+	*max_open = 1;
+	if (has_time_read && check_group_active(leader_fd, -1))
+		*max_active = 1;
+	else
+		active_ok = false;
+
+	for (int count = 2; count <= MAX_PROBE_GROUP_SIZE; count++) {
+		struct perf_event_attr follower_attr = attrs[(count - 1) % nr_attrs];
+		int fd;
+
+		follower_attr.disabled = 0;
+		follower_attr.read_format = leader_attr.read_format;
+
+		fd = sys_perf_event_open(&follower_attr, pid, cpu, leader_fd, flags);
+		if (fd < 0 && errno == EMFILE && rlimit__increase_nofile(&set_rlimit))
+			fd = sys_perf_event_open(&follower_attr, pid, cpu, leader_fd, flags);
+		if (fd < 0 && follower_attr.read_format != 0) {
+			follower_attr.read_format = 0;
+			fd = sys_perf_event_open(&follower_attr, pid, cpu, leader_fd, flags);
+		}
+		if (fd < 0)
+			break;
+
+		fds[nr_followers++] = fd;
+		*max_open = count;
+		if (active_ok && has_time_read) {
+			if (check_group_active(leader_fd, fd))
+				*max_active = count;
+			else
+				active_ok = false;
+		}
+	}
+
+	if (*max_open >= MAX_PROBE_GROUP_SIZE)
+		*open_capped = true;
+	if (*max_active >= MAX_PROBE_GROUP_SIZE)
+		*active_capped = true;
+
+	for (int i = 0; i < nr_followers; i++)
+		close(fds[i]);
+	close(leader_fd);
+
+out_affinity:
+	if (affinity_changed)
+		sched_setaffinity(0, sizeof(saved_affinity), &saved_affinity);
+}
+
+enum probe_exclude_flag {
+	PROBE_EXCLUDE_USER,
+	PROBE_EXCLUDE_KERNEL,
+	PROBE_EXCLUDE_HV,
+	PROBE_EXCLUDE_IDLE,
+	PROBE_EXCLUDE_HOST,
+	PROBE_EXCLUDE_GUEST,
+};
+
+static bool test_exclude_flag(const struct perf_event_attr *base_attr,
+			      pid_t pid, int cpu, unsigned long flags,
+			      enum probe_exclude_flag which)
+{
+	struct perf_event_attr attr = *base_attr;
+	int fd;
+
+	switch (which) {
+	case PROBE_EXCLUDE_USER:
+		attr.exclude_user = 1;
+		break;
+	case PROBE_EXCLUDE_KERNEL:
+		attr.exclude_kernel = 1;
+		attr.exclude_user = 0;
+		break;
+	case PROBE_EXCLUDE_HV:
+		attr.exclude_hv = 1;
+		break;
+	case PROBE_EXCLUDE_IDLE:
+		attr.exclude_idle = 1;
+		break;
+	case PROBE_EXCLUDE_HOST:
+		attr.exclude_host = 1;
+		attr.exclude_guest = 0;
+		break;
+	case PROBE_EXCLUDE_GUEST:
+		attr.exclude_guest = 1;
+		attr.exclude_host = 0;
+		break;
+	default:
+		return false;
+	}
+
+	fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+	if (fd >= 0) {
+		close(fd);
+		return true;
+	}
+	if (which == PROBE_EXCLUDE_USER && attr.exclude_kernel == 1) {
+		attr.exclude_kernel = 0;
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			return true;
+		}
+	}
+	return false;
+}
+
+static void probe_sample_types(struct perf_pmu *pmu,
+			       const struct perf_event_attr *base_attr,
+			       pid_t pid, int cpu, unsigned long flags)
+{
+	u64 reg_bit = BIT_ULL(perf_arch_reg_ip(EM_HOST)) ?: 1ULL;
+	u64 bulk_mask = PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
+			PERF_SAMPLE_ADDR | PERF_SAMPLE_READ | PERF_SAMPLE_CALLCHAIN |
+			PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD |
+			PERF_SAMPLE_STREAM_ID | PERF_SAMPLE_RAW | PERF_SAMPLE_REGS_USER |
+			PERF_SAMPLE_STACK_USER | PERF_SAMPLE_WEIGHT | PERF_SAMPLE_DATA_SRC |
+			PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_TRANSACTION |
+			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_AUX | PERF_SAMPLE_CGROUP |
+			PERF_SAMPLE_DATA_PAGE_SIZE | PERF_SAMPLE_CODE_PAGE_SIZE |
+			PERF_SAMPLE_WEIGHT_STRUCT;
+	struct perf_event_attr b_attr = *base_attr;
+	int b_fd;
+
+	b_attr.disabled = 1;
+	b_attr.sample_period = base_attr->sample_period ?: 10000;
+	b_attr.sample_type = bulk_mask;
+	b_attr.sample_regs_user = reg_bit;
+	b_attr.sample_regs_intr = reg_bit;
+	b_attr.sample_stack_user = 64;
+	b_attr.inherit = 0;
+	b_fd = sys_perf_event_open(&b_attr, pid, cpu, -1, flags);
+	if (b_fd >= 0) {
+		close(b_fd);
+		pmu->probed.sample_types |= bulk_mask;
+	}
+
+	for (unsigned int shift = 0; (1ULL << shift) < PERF_SAMPLE_MAX; shift++) {
+		u64 bit = 1ULL << shift;
+		struct perf_event_attr attr = *base_attr;
+		int fd;
+
+		if (pmu->probed.sample_types & bit)
+			continue;
+
+		attr.disabled = 1;
+		attr.sample_period = base_attr->sample_period ?: 10000;
+		attr.sample_type = bit;
+
+		switch (bit) {
+		case PERF_SAMPLE_BRANCH_STACK:
+			attr.branch_sample_type = PERF_SAMPLE_BRANCH_ANY |
+				(attr.exclude_kernel ? PERF_SAMPLE_BRANCH_USER : 0);
+			break;
+		case PERF_SAMPLE_REGS_USER:
+			attr.sample_regs_user = reg_bit;
+			break;
+		case PERF_SAMPLE_REGS_INTR:
+			attr.sample_regs_intr = reg_bit;
+			break;
+		case PERF_SAMPLE_STACK_USER:
+			attr.sample_stack_user = 64;
+			break;
+		case PERF_SAMPLE_READ:
+			attr.inherit = 0;
+			break;
+		default:
+			break;
+		}
+
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		if (fd < 0 && bit == PERF_SAMPLE_BRANCH_STACK) {
+			attr.branch_sample_type = PERF_SAMPLE_BRANCH_ANY;
+			fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		}
+		if (fd < 0 && bit != PERF_SAMPLE_IP) {
+			attr.sample_type = PERF_SAMPLE_IP | bit;
+			fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		}
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.sample_types |= bit;
+		}
+	}
+
+	pmu->probed.can_branch_stack = !!(pmu->probed.sample_types & PERF_SAMPLE_BRANCH_STACK);
+	pmu->probed.can_callchain = !!(pmu->probed.sample_types & PERF_SAMPLE_CALLCHAIN);
+	pmu->probed.can_data_src = !!(pmu->probed.sample_types & PERF_SAMPLE_DATA_SRC);
+	pmu->probed.can_weight = !!(pmu->probed.sample_types & PERF_SAMPLE_WEIGHT);
+}
+
+static void probe_pmu_regs_one(const struct perf_pmu *pmu,
+			       const struct perf_event_attr *base_attr,
+			       pid_t pid, int cpu, unsigned long flags,
+			       int max_precise, bool intr,
+			       u64 *out_mask, int *out_abi,
+			       u64 *out_simd_mask, u64 *out_pred_mask)
+{
+	int dummy_abi = -1;
+	u64 gpr_mask = intr ? perf_intr_reg_mask(EM_HOST, &dummy_abi) :
+			      perf_user_reg_mask(EM_HOST, &dummy_abi);
+	u64 sample_type = intr ? PERF_SAMPLE_REGS_INTR : PERF_SAMPLE_REGS_USER;
+	u64 mask = 0;
+	int abi = 0;
+	struct perf_event_attr attr = *base_attr;
+	int fd;
+
+	attr.disabled = 1;
+	attr.sample_period = base_attr->sample_period ?: 10000;
+	attr.sample_type = sample_type;
+
+	if (gpr_mask) {
+		if (intr)
+			attr.sample_regs_intr = gpr_mask;
+		else
+			attr.sample_regs_user = gpr_mask;
+
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			mask |= gpr_mask;
+		} else {
+			for (int b = 0; b < 64; b++) {
+				if (!(gpr_mask & BIT_ULL(b)))
+					continue;
+				if (intr)
+					attr.sample_regs_intr = BIT_ULL(b);
+				else
+					attr.sample_regs_user = BIT_ULL(b);
+				fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+				if (fd >= 0) {
+					close(fd);
+					mask |= BIT_ULL(b);
+				}
+			}
+		}
+	}
+
+	if (perf_pmu__is_software(pmu)) {
+		*out_mask = mask;
+		*out_abi = abi;
+		return;
+	}
+
+	/*
+	 * Probe extended registers outside the base GPR mask. On x86, check
+	 * APX EGPRs (R16-R31, bits 24..39) and SSP (bit 40) with
+	 * sample_simd_regs_enabled=1 if the host supports SIMD ABI; otherwise
+	 * check legacy PEBS XMM registers (bits 32..63) which require
+	 * precise_ip > 0 on interrupt register sampling.
+	 */
+	if (EM_HOST == EM_X86_64 || EM_HOST == EM_386) {
+		int host_abi = 0;
+		u64 host_mask = intr ? perf_intr_reg_mask(EM_HOST, &host_abi) :
+				       perf_user_reg_mask(EM_HOST, &host_abi);
+
+		if ((host_abi & PERF_SAMPLE_REGS_ABI_SIMD) && (host_mask & ~gpr_mask)) {
+			u64 egpr_masks[] = { GENMASK_ULL(39, 24), BIT_ULL(40) };
+
+			for (size_t i = 0; i < ARRAY_SIZE(egpr_masks); i++) {
+				struct perf_event_attr e_attr = *base_attr;
+
+				e_attr.size = sizeof(e_attr);
+				e_attr.disabled = 1;
+				e_attr.sample_period = base_attr->sample_period ?: 10000;
+				e_attr.sample_type = sample_type;
+				e_attr.sample_simd_regs_enabled = 1;
+				if (intr)
+					e_attr.sample_regs_intr = egpr_masks[i];
+				else
+					e_attr.sample_regs_user = egpr_masks[i];
+
+				fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
+				if (fd < 0 && intr && max_precise > 0) {
+					e_attr.precise_ip = 1;
+					fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
+				}
+				if (fd >= 0) {
+					close(fd);
+					mask |= egpr_masks[i];
+					abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+				}
+			}
+		}
+	}
+
+	if (!(abi & PERF_SAMPLE_REGS_ABI_SIMD)) {
+		u64 ext_mask = GENMASK_ULL(63, 32) & ~gpr_mask;
+		struct perf_event_attr x_attr = *base_attr;
+		bool batch_ok = false;
+
+		x_attr.disabled = 1;
+		x_attr.sample_period = base_attr->sample_period ?: 10000;
+		x_attr.sample_type = sample_type;
+		if (intr && max_precise > 0)
+			x_attr.precise_ip = 1;
+
+		if (ext_mask) {
+			if (intr)
+				x_attr.sample_regs_intr = ext_mask;
+			else
+				x_attr.sample_regs_user = ext_mask;
+
+			fd = sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
+			if (fd >= 0) {
+				close(fd);
+				mask |= ext_mask;
+				batch_ok = true;
+			}
+		}
+
+		if (!batch_ok) {
+			for (int b = 0; b < 64; b++) {
+				const char *rname;
+
+				if (gpr_mask & BIT_ULL(b))
+					continue;
+				rname = perf_reg_name(b, EM_HOST, EF_HOST, 0);
+				if (!rname || !strcmp(rname, "unknown"))
+					continue;
+				if (intr)
+					x_attr.sample_regs_intr = BIT_ULL(b);
+				else
+					x_attr.sample_regs_user = BIT_ULL(b);
+				fd = sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
+				if (fd >= 0) {
+					close(fd);
+					mask |= BIT_ULL(b);
+				}
+			}
+		}
+	}
+
+	for (int is_pred = 0; is_pred <= 1; is_pred++) {
+		bool pred = is_pred != 0;
+		u64 class_mask = intr ?
+			perf_intr_simd_reg_class_mask(EM_HOST, pred) :
+			perf_user_simd_reg_class_mask(EM_HOST, pred);
+		u64 supported_classes = 0;
+
+		for (int reg_c = 0; reg_c < 64; reg_c++) {
+			struct perf_event_attr s_attr = *base_attr;
+			u16 qwords = 0;
+			u64 bitmap;
+
+			if (!(class_mask & BIT_ULL(reg_c)))
+				continue;
+			bitmap = intr ?
+				perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+								       &qwords, pred) :
+				perf_user_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+								       &qwords, pred);
+			if (!bitmap || !qwords)
+				continue;
+
+			s_attr.size = sizeof(s_attr);
+			s_attr.disabled = 1;
+			s_attr.sample_period = base_attr->sample_period ?: 10000;
+			s_attr.sample_type = sample_type;
+			s_attr.sample_simd_regs_enabled = 1;
+			if (pred) {
+				s_attr.sample_simd_pred_reg_qwords = qwords;
+				if (intr)
+					s_attr.sample_simd_pred_reg_intr = bitmap;
+				else
+					s_attr.sample_simd_pred_reg_user = bitmap;
+			} else {
+				s_attr.sample_simd_vec_reg_qwords = qwords;
+				if (intr)
+					s_attr.sample_simd_vec_reg_intr = bitmap;
+				else
+					s_attr.sample_simd_vec_reg_user = bitmap;
+			}
+
+			fd = sys_perf_event_open(&s_attr, pid, cpu, -1, flags);
+			if (fd < 0 && intr && max_precise > 0) {
+				s_attr.precise_ip = 1;
+				fd = sys_perf_event_open(&s_attr, pid, cpu, -1, flags);
+			}
+			if (fd >= 0) {
+				close(fd);
+				supported_classes |= BIT_ULL(reg_c);
+			}
+		}
+
+		if (pred)
+			*out_pred_mask = supported_classes;
+		else
+			*out_simd_mask = supported_classes;
+	}
+
+	*out_mask = mask;
+	*out_abi = abi;
+}
+
+static bool try_open_mem_evlist(struct evlist *evlist,
+				const struct perf_event_attr *base_attr,
+				pid_t pid, int cpu, unsigned long flags,
+				int precise_ip, u64 sample_type)
+{
+	int fds[16];
+	size_t nr_fds = 0;
+	int leader_fd = -1;
+	struct evsel *evsel;
+	bool ok = true;
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct perf_event_attr attr = evsel->core.attr;
+		int fd;
+
+		if (nr_fds >= ARRAY_SIZE(fds)) {
+			ok = false;
+			break;
+		}
+
+		attr.disabled = (leader_fd < 0) ? 1 : 0;
+		attr.sample_period = attr.sample_period ?: 10000;
+		attr.sample_type = sample_type;
+		attr.exclude_user = base_attr->exclude_user;
+		attr.exclude_kernel = base_attr->exclude_kernel;
+		attr.exclude_hv = base_attr->exclude_hv;
+		attr.exclude_idle = base_attr->exclude_idle;
+		attr.exclude_host = base_attr->exclude_host;
+		attr.exclude_guest = base_attr->exclude_guest;
+		if (evsel->precise_max || precise_ip > 0)
+			attr.precise_ip = precise_ip;
+
+		fd = sys_perf_event_open(&attr, pid, cpu, leader_fd, flags);
+		if (fd < 0) {
+			ok = false;
+			break;
+		}
+		if (leader_fd < 0)
+			leader_fd = fd;
+		fds[nr_fds++] = fd;
+	}
+
+	for (size_t i = nr_fds; i > 0; i--)
+		close(fds[i - 1]);
+
+	return ok && nr_fds > 0;
+}
+
+static void probe_mem_events(struct perf_pmu *pmu,
+			     const struct perf_event_attr *base_attr,
+			     pid_t pid, int cpu, unsigned long flags)
+{
+	static const u64 extra_mem_stypes[] = {
+		PERF_SAMPLE_WEIGHT,
+		PERF_SAMPLE_WEIGHT_STRUCT,
+		PERF_SAMPLE_PHYS_ADDR,
+		PERF_SAMPLE_DATA_PAGE_SIZE,
+		PERF_SAMPLE_TRANSACTION,
+	};
+
+	if (!pmu->mem_events)
+		return;
+
+	perf_pmu__mem_events_init_pmu(pmu);
+
+	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+		struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
+		const char *s;
+		char buf[256];
+		struct evlist *evlist;
+		struct parse_events_error err;
+		struct evsel *first;
+		int max_p, min_p, working_p = -1;
+		u64 base_stype = PERF_SAMPLE_IP | PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC;
+		int ret;
+
+		if (!e || !e->tag || !e->supported)
+			continue;
+
+		s = perf_pmu__mem_events_name(pmu, j, buf, sizeof(buf));
+		if (!s)
+			continue;
+
+		evlist = evlist__new();
+		if (!evlist)
+			continue;
+
+		parse_events_error__init(&err);
+		ret = __parse_events(evlist, s, /*pmu_filter=*/NULL,
+				     /*cputype_filter=*/false, &err, /*fake_pmu=*/false,
+				     /*warn_if_reordered=*/false, /*fake_tp=*/false);
+		parse_events_error__exit(&err);
+		if (ret || evlist__empty(evlist)) {
+			evlist__put(evlist);
+			continue;
+		}
+
+		first = evlist__first(evlist);
+		if (first->precise_max) {
+			max_p = pmu->probed.max_precise > 0 ? pmu->probed.max_precise : 3;
+			min_p = 1;
+		} else {
+			max_p = first->core.attr.precise_ip;
+			min_p = first->core.attr.precise_ip;
+		}
+
+		for (int p = max_p; p >= min_p; p--) {
+			if (try_open_mem_evlist(evlist, base_attr, pid, cpu,
+						flags, p, base_stype)) {
+				working_p = p;
+				break;
+			}
+		}
+
+		if (working_p >= 0) {
+			pmu->probed.mem_events_mask |= (1u << j);
+			pmu->probed.mem_sample_types |= PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC;
+
+			for (size_t k = 0; k < ARRAY_SIZE(extra_mem_stypes); k++) {
+				u64 st = base_stype | extra_mem_stypes[k];
+
+				if (try_open_mem_evlist(evlist, base_attr, pid, cpu,
+							flags, working_p, st)) {
+					pmu->probed.mem_sample_types |= extra_mem_stypes[k];
+				}
+			}
+		}
+
+		evlist__put(evlist);
+	}
+}
+
+static void probe_mmap_caps(struct perf_pmu *pmu,
+			    const struct perf_event_attr *base_attr,
+			    int pmu_cpu, pid_t pid, int cpu,
+			    unsigned long flags)
+{
+	struct perf_event_attr attr = *base_attr;
+	struct perf_event_mmap_page *pc;
+	long page_sz = sysconf(_SC_PAGESIZE);
+	cpu_set_t old_mask, mask;
+	bool affinity_changed = false;
+	bool has_rdpmc_cap = false;
+	int events_fd;
+	int fd = -1;
+
+	pmu->probed.rdpmc_sysfs = -1;
+
+	if (page_sz <= 0)
+		page_sz = 4096;
+
+	events_fd = perf_pmu__event_source_devices_fd();
+	if (events_fd >= 0) {
+		int pmu_dirfd = openat(events_fd, pmu->name, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+
+		if (pmu_dirfd >= 0) {
+			if (faccessat(pmu_dirfd, "rdpmc", F_OK, 0) == 0) {
+				int rfd;
+
+				has_rdpmc_cap = true;
+				rfd = openat(pmu_dirfd, "rdpmc", O_RDONLY | O_CLOEXEC);
+				if (rfd >= 0) {
+					char rbuf[16];
+					ssize_t n = read(rfd, rbuf, sizeof(rbuf) - 1);
+
+					if (n > 0) {
+						rbuf[n] = '\0';
+						pmu->probed.rdpmc_sysfs = atoi(rbuf);
+					}
+					close(rfd);
+				}
+			}
+			close(pmu_dirfd);
+		}
+		close(events_fd);
+	}
+
+	if (pmu_cpu >= 0 && pmu_cpu < CPU_SETSIZE &&
+	    sched_getaffinity(0, sizeof(old_mask), &old_mask) == 0) {
+		CPU_ZERO(&mask);
+		CPU_SET(pmu_cpu, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask) == 0)
+			affinity_changed = true;
+	}
+
+	attr.disabled = 0;
+
+	/*
+	 * On architectures such as arm64, user-space counter reading must be
+	 * explicitly requested via format/rdpmc (config1:1).
+	 */
+	if (perf_pmu__has_format(pmu, "rdpmc")) {
+		struct perf_event_attr r_attr = attr;
+		int uval;
+
+		has_rdpmc_cap = true;
+		if (pmu->probed.rdpmc_sysfs < 0 &&
+		    sysctl__read_int("kernel/perf_user_access", &uval) == 0)
+			pmu->probed.rdpmc_sysfs = uval;
+
+		r_attr.config1 |= 0x2;
+		fd = sys_perf_event_open(&r_attr, 0, -1, -1, flags);
+	}
+
+	if (fd < 0 && !pmu->is_uncore)
+		fd = sys_perf_event_open(&attr, 0, -1, -1, flags);
+	if (fd < 0)
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+
+	if (fd >= 0) {
+		pc = mmap(NULL, page_sz, PROT_READ, MAP_SHARED, fd, 0);
+		if (pc != MAP_FAILED) {
+			if (has_rdpmc_cap || pc->cap_user_rdpmc) {
+				pmu->probed.rdpmc_available = true;
+				pmu->probed.pmc_width = pc->pmc_width;
+			}
+			if (pc->cap_user_rdpmc && pc->index != 0) {
+				struct perf_mmap map = { .base = pc };
+				struct perf_counts_values start = { .val = 0 };
+				struct perf_counts_values end = { .val = 0 };
+
+				pmu->probed.can_user_rdpmc = true;
+				if (perf_mmap__read_self(&map, &start) == 0) {
+					for (int spin = 0; spin < 10000; spin++)
+						barrier();
+					if (perf_mmap__read_self(&map, &end) == 0 &&
+					    end.val >= start.val && end.val > 0)
+						pmu->probed.rdpmc_works = true;
+				}
+			}
+			pmu->probed.can_user_time = !!pc->cap_user_time;
+			pmu->probed.can_user_time_zero = !!pc->cap_user_time_zero;
+			pmu->probed.can_user_time_short = !!pc->cap_user_time_short;
+			munmap(pc, page_sz);
+		}
+		close(fd);
+	}
+
+	if (affinity_changed)
+		sched_setaffinity(0, sizeof(old_mask), &old_mask);
+}
+
+static bool run_skid_branch_loop(u64 iters, uintptr_t *out_s_ip,
+				 uintptr_t *out_b_ip, uintptr_t *out_e_ip,
+				 int *out_insn_sz, int *out_nop_cnt)
+{
+#if defined(__x86_64__)
+	uintptr_t s_ip, b_ip, e_ip;
+
+	asm volatile(
+		"lea 1f(%%rip), %[s_ip]\n\t"
+		"lea 2f(%%rip), %[b_ip]\n\t"
+		"lea 3f(%%rip), %[e_ip]\n\t"
+		".balign 64\n"
+		"1:\n\t"
+		".rept 8192\n\t"
+		"nop\n\t"
+		".endr\n\t"
+		"dec %[cnt]\n\t"
+		"2:\n\t"
+		"jnz 1b\n"
+		"3:\n\t"
+		: [cnt] "+r" (iters),
+		  [s_ip] "=&r" (s_ip),
+		  [b_ip] "=&r" (b_ip),
+		  [e_ip] "=&r" (e_ip)
+		:
+		: "cc", "memory"
+	);
+	*out_s_ip = s_ip;
+	*out_b_ip = b_ip;
+	*out_e_ip = e_ip;
+	*out_insn_sz = 1;
+	*out_nop_cnt = 8192;
+	return true;
+#elif defined(__aarch64__)
+	uintptr_t s_ip, b_ip, e_ip;
+
+	asm volatile(
+		"adr %[s_ip], 1f\n\t"
+		"adr %[b_ip], 2f\n\t"
+		"adr %[e_ip], 3f\n\t"
+		".balign 64\n"
+		"1:\n\t"
+		".rept 8192\n\t"
+		"nop\n\t"
+		".endr\n\t"
+		"subs %[cnt], %[cnt], #1\n\t"
+		"2:\n\t"
+		"b.ne 1b\n"
+		"3:\n\t"
+		: [cnt] "+r" (iters),
+		  [s_ip] "=&r" (s_ip),
+		  [b_ip] "=&r" (b_ip),
+		  [e_ip] "=&r" (e_ip)
+		:
+		: "cc", "memory"
+	);
+	*out_s_ip = s_ip;
+	*out_b_ip = b_ip;
+	*out_e_ip = e_ip;
+	*out_insn_sz = 4;
+	*out_nop_cnt = 8192;
+	return true;
+#elif defined(__riscv)
+	uintptr_t s_ip, b_ip, e_ip;
+
+	asm volatile(
+		".option push\n\t"
+		".option norvc\n\t"
+		"la %[s_ip], 1f\n\t"
+		"la %[b_ip], 2f\n\t"
+		"la %[e_ip], 3f\n\t"
+		".balign 64\n"
+		"1:\n\t"
+		".rept 1000\n\t"
+		"nop\n\t"
+		".endr\n\t"
+		"addi %[cnt], %[cnt], -1\n\t"
+		"2:\n\t"
+		"bnez %[cnt], 1b\n"
+		"3:\n\t"
+		".option pop\n\t"
+		: [cnt] "+r" (iters),
+		  [s_ip] "=&r" (s_ip),
+		  [b_ip] "=&r" (b_ip),
+		  [e_ip] "=&r" (e_ip)
+		:
+		: "memory"
+	);
+	*out_s_ip = s_ip;
+	*out_b_ip = b_ip;
+	*out_e_ip = e_ip;
+	*out_insn_sz = 4;
+	*out_nop_cnt = 1000;
+	return true;
+#else
+	(void)iters;
+	*out_s_ip = 0;
+	*out_b_ip = 0;
+	*out_e_ip = 0;
+	*out_insn_sz = 0;
+	*out_nop_cnt = 0;
+	return false;
+#endif
+}
+
+static void probe_pmu_skid(struct perf_pmu *pmu,
+			   const struct perf_event_attr *base_attr,
+			   int pmu_cpu, unsigned long flags)
+{
+	struct perf_event_attr br_attr;
+	char br_buf[256];
+	long page_sz = sysconf(_SC_PAGESIZE);
+	size_t data_sz, mmap_sz;
+	cpu_set_t old_mask, mask;
+	bool affinity_changed = false;
+
+	if (!pmu->is_core || !pmu->probed.can_sample)
+		return;
+
+	if (page_sz <= 0)
+		page_sz = 4096;
+	data_sz = 4 * (size_t)page_sz;
+	mmap_sz = (size_t)page_sz + data_sz;
+
+	memset(&br_attr, 0, sizeof(br_attr));
+	snprintf(br_buf, sizeof(br_buf), "%s/branches/", pmu->name);
+	if (!parse_candidate_attr(br_buf, &br_attr)) {
+		br_attr.type = PERF_TYPE_HARDWARE;
+		br_attr.size = base_attr->size;
+		br_attr.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS;
+		if (perf_pmus__supports_extended_type())
+			br_attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+	}
+	br_attr.exclude_user = base_attr->exclude_user;
+	br_attr.exclude_kernel = 1;
+	br_attr.exclude_hv = 1;
+	br_attr.exclude_idle = base_attr->exclude_idle;
+	br_attr.exclude_host = base_attr->exclude_host;
+	br_attr.exclude_guest = base_attr->exclude_guest;
+
+	if (pmu_cpu >= 0 && pmu_cpu < CPU_SETSIZE &&
+	    sched_getaffinity(0, sizeof(old_mask), &old_mask) == 0) {
+		CPU_ZERO(&mask);
+		CPU_SET(pmu_cpu, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask) == 0)
+			affinity_changed = true;
+	}
+
+	for (int lvl = 0; lvl <= 3; lvl++) {
+		struct perf_event_attr attr = br_attr;
+		struct perf_event_mmap_page *pc;
+		uintptr_t s_ip = 0, b_ip = 0, e_ip = 0;
+		int insn_sz = 0, nop_cnt = 0;
+		void *ring;
+		u8 *data;
+		u64 head, tail = 0;
+		int samples = 0, exact = 0;
+		int min_skid = 999999, max_skid = 0;
+		long sum_skid = 0;
+		int fd;
+
+		if (lvl > 0 && !(pmu->probed.precise_mask & (1u << lvl)))
+			continue;
+
+		attr.disabled = 1;
+		attr.sample_period = 251;
+		attr.sample_type = PERF_SAMPLE_IP;
+		attr.precise_ip = lvl;
+
+		fd = sys_perf_event_open(&attr, 0, -1, -1, flags);
+		if (fd < 0 && lvl > 0 && attr.exclude_kernel && attr.config2 == 0) {
+			attr.config2 = 1;
+			fd = sys_perf_event_open(&attr, 0, -1, -1, flags);
+		}
+		if (fd < 0)
+			continue;
+
+		ring = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		if (ring == MAP_FAILED) {
+			close(fd);
+			continue;
+		}
+
+		ioctl(fd, PERF_EVENT_IOC_RESET, 0);
+		ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+		if (!run_skid_branch_loop(8000, &s_ip, &b_ip, &e_ip,
+					  &insn_sz, &nop_cnt)) {
+			ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+			munmap(ring, mmap_sz);
+			close(fd);
+			break;
+		}
+		ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+
+		pc = ring;
+		head = READ_ONCE(pc->data_head);
+		/* Ensure data_head is read before reading ring buffer contents. */
+		rmb();
+		if (head > data_sz)
+			head = data_sz;
+		data = (u8 *)ring + page_sz;
+
+		while (tail + sizeof(struct perf_event_header) <= head) {
+			struct perf_event_header *hdr =
+				(struct perf_event_header *)(data + tail);
+
+			if (hdr->size == 0 || tail + hdr->size > head)
+				break;
+			if (hdr->type == PERF_RECORD_SAMPLE &&
+			    hdr->size >= sizeof(*hdr) + sizeof(u64)) {
+				u64 ip = *(u64 *)((u8 *)hdr + sizeof(*hdr));
+				uintptr_t uip = (uintptr_t)ip;
+
+				if (uip >= s_ip && uip <= e_ip && insn_sz > 0) {
+					int skid;
+
+					if (uip == b_ip) {
+						skid = 0;
+					} else if (uip >= s_ip && uip < b_ip) {
+						long off = (long)(uip - s_ip) / insn_sz;
+
+						skid = (off < nop_cnt) ?
+						       (int)(off + 1) : (nop_cnt + 1);
+					} else {
+						skid = 1;
+					}
+
+					samples++;
+					if (hdr->misc & PERF_RECORD_MISC_EXACT_IP)
+						exact++;
+					if (skid < min_skid)
+						min_skid = skid;
+					if (skid > max_skid)
+						max_skid = skid;
+					sum_skid += skid;
+				}
+			}
+			tail += hdr->size;
+		}
+
+		if (samples > 0) {
+			pmu->probed.skid[lvl].measured = true;
+			pmu->probed.skid[lvl].samples = samples;
+			pmu->probed.skid[lvl].exact_samples = exact;
+			pmu->probed.skid[lvl].min_skid = min_skid;
+			pmu->probed.skid[lvl].max_skid = max_skid;
+			pmu->probed.skid[lvl].avg_skid = (double)sum_skid / samples;
+		}
+
+		munmap(ring, mmap_sz);
+		close(fd);
+	}
+
+	if (affinity_changed)
+		sched_setaffinity(0, sizeof(old_mask), &old_mask);
+}
+
+void perf_pmu__probe(struct perf_pmu *pmu)
+{
+	struct probe_candidates cands = { .nr = 0 };
+	struct perf_event_attr base_attr;
+	struct perf_event_attr group_attrs[MAX_PROBE_GROUP_SIZE];
+	char uprobe_exe_path[PATH_MAX];
+	__u64 uprobe_offset = 0;
+	size_t nr_group_attrs = 0;
+	unsigned long flags = perf_event_open_cloexec_flag();
+	int keepalive_fd = -1;
+	int pmu_cpu;
+	pid_t pid = 0;
+	int cpu = 0;
+	int last_err = 0;
+	bool found = false;
+
+	if (!pmu || pmu->probed.checked)
+		return;
+	if (perf_pmu__kind(pmu) != PERF_PMU_KIND_PE)
+		return;
+
+	pmu->probed.checked = true;
+	pmu_cpu = select_probe_cpu(pmu);
+
+	if (pmu->type == PERF_TYPE_TRACEPOINT) {
+		static const struct {
+			const char *sys;
+			const char *name;
+		} fast_tps[] = {
+			{ "sched", "sched_switch" },
+			{ "raw_syscalls", "sys_enter" },
+			{ "irq", "irq_handler_entry" },
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(fast_tps); i++) {
+			int tp_id = tp_pmu__id(fast_tps[i].sys, fast_tps[i].name);
+
+			if (tp_id >= 0) {
+				memset(&base_attr, 0, sizeof(base_attr));
+				base_attr.type = PERF_TYPE_TRACEPOINT;
+				base_attr.config = tp_id;
+				if (try_open_attr_variants(&base_attr, false, pmu_cpu,
+							   flags, &pid, &cpu, &last_err)) {
+					char tp_buf[128];
+
+					snprintf(tp_buf, sizeof(tp_buf), "%s:%s",
+						 fast_tps[i].sys, fast_tps[i].name);
+					pmu->probed.probe_event = strdup(tp_buf);
+					found = true;
+					break;
+				}
+			}
+		}
+		if (!found) {
+			perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/false,
+						 &cands, collect_probe_candidate_cb);
+		}
+	} else if (pmu->name && !strcmp(pmu->name, "kprobe")) {
+		static const char * const kprobe_funcs[] = {
+			"vfs_read",
+			"schedule",
+			"do_sys_openat2",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(kprobe_funcs); i++) {
+			memset(&base_attr, 0, sizeof(base_attr));
+			base_attr.type = pmu->type;
+			base_attr.size = sizeof(base_attr);
+			base_attr.kprobe_func = (uintptr_t)kprobe_funcs[i];
+			base_attr.probe_offset = 0;
+			if (try_open_attr_variants(&base_attr, false, pmu_cpu,
+						   flags, &pid, &cpu, &last_err)) {
+				char kp_buf[128];
+
+				snprintf(kp_buf, sizeof(kp_buf), "kprobe:%s",
+					 kprobe_funcs[i]);
+				pmu->probed.probe_event = strdup(kp_buf);
+				found = true;
+				break;
+			}
+		}
+	} else if (pmu->name && !strcmp(pmu->name, "uprobe")) {
+		if (get_self_uprobe_target(uprobe_exe_path, &uprobe_offset)) {
+			memset(&base_attr, 0, sizeof(base_attr));
+			base_attr.type = pmu->type;
+			base_attr.size = sizeof(base_attr);
+			base_attr.uprobe_path = (uintptr_t)uprobe_exe_path;
+			base_attr.probe_offset = uprobe_offset;
+			if (try_open_attr_variants(&base_attr, false, pmu_cpu,
+						   flags, &pid, &cpu, &last_err)) {
+				const char *slash = strrchr(uprobe_exe_path, '/');
+				const char *bname = slash ? slash + 1 : uprobe_exe_path;
+
+				if (asprintf(&pmu->probed.probe_event, "uprobe:%s+0x%llx",
+					     bname, (unsigned long long)uprobe_offset) < 0)
+					pmu->probed.probe_event = NULL;
+				found = true;
+			}
+		}
+	} else if (pmu->is_core) {
+		static const char * const core_events[] = {
+			"cycles",
+			"instructions",
+			"branches",
+			"branch-misses",
+			"cache-misses",
+			"cache-references",
+			"bus-cycles",
+			"ref-cycles",
+		};
+		char buf[256];
+
+		for (size_t i = 0; i < ARRAY_SIZE(core_events); i++) {
+			snprintf(buf, sizeof(buf), "%s/%s/", pmu->name, core_events[i]);
+			probe_candidates__add(&cands, buf);
+		}
+		perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/false,
+					 &cands, collect_probe_candidate_cb);
+	} else if (pmu->type == PERF_TYPE_SOFTWARE) {
+		static const char * const sw_events[] = {
+			"software/cpu-clock/",
+			"software/task-clock/",
+			"software/page-faults/",
+			"software/context-switches/",
+			"software/cpu-migrations/",
+			"software/minor-faults/",
+			"software/major-faults/",
+			"software/dummy/",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(sw_events); i++)
+			probe_candidates__add(&cands, sw_events[i]);
+	} else if (pmu->type != PERF_TYPE_BREAKPOINT) {
+		if (pmu->selectable) {
+			char buf[256];
+
+			if (perf_pmu__has_format(pmu, "swfilt")) {
+				snprintf(buf, sizeof(buf), "%s/swfilt=1/", pmu->name);
+				probe_candidates__add(&cands, buf);
+			}
+			snprintf(buf, sizeof(buf), "%s//", pmu->name);
+			probe_candidates__add(&cands, buf);
+		}
+		perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/false,
+					 &cands, collect_probe_candidate_cb);
+	}
+
+	for (size_t i = 0; !found && i < cands.nr; i++) {
+		memset(&base_attr, 0, sizeof(base_attr));
+		if (!parse_candidate_attr(cands.names[i], &base_attr))
+			continue;
+
+		if (try_open_attr_variants(&base_attr, pmu->is_uncore, pmu_cpu,
+					   flags, &pid, &cpu, &last_err)) {
+			pmu->probed.probe_event = strdup(cands.names[i]);
+			found = true;
+			break;
+		}
+	}
+
+	if (!found && pmu->is_core) {
+		memset(&base_attr, 0, sizeof(base_attr));
+		base_attr.type = PERF_TYPE_HARDWARE;
+		base_attr.config = PERF_COUNT_HW_CPU_CYCLES;
+		if (perf_pmus__supports_extended_type())
+			base_attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+		if (try_open_attr_variants(&base_attr, false, pmu_cpu,
+					   flags, &pid, &cpu, &last_err)) {
+			pmu->probed.probe_event = strdup("cycles");
+			found = true;
+		}
+	}
+
+	if (!found && pmu->type == PERF_TYPE_BREAKPOINT) {
+		memset(&base_attr, 0, sizeof(base_attr));
+		base_attr.type = PERF_TYPE_BREAKPOINT;
+		base_attr.bp_addr = (unsigned long)&dummy_bp_var;
+		base_attr.bp_type = HW_BREAKPOINT_W;
+		base_attr.bp_len = HW_BREAKPOINT_LEN_4;
+		if (try_open_attr_variants(&base_attr, false, pmu_cpu,
+					   flags, &pid, &cpu, &last_err)) {
+			pmu->probed.probe_event = strdup("mem:<addr>:w");
+			found = true;
+		}
+	}
+
+	if (!found && cands.nr == 0) {
+		memset(&base_attr, 0, sizeof(base_attr));
+		base_attr.type = pmu->type;
+		base_attr.size = sizeof(base_attr);
+		if (pmu->perf_event_attr_init_default)
+			pmu->perf_event_attr_init_default(pmu, &base_attr);
+		if (try_open_attr_variants(&base_attr, pmu->is_uncore, pmu_cpu,
+					   flags, &pid, &cpu, &last_err)) {
+			char buf[256];
+
+			snprintf(buf, sizeof(buf), "%s//", pmu->name);
+			pmu->probed.probe_event = strdup(buf);
+			found = true;
+		}
+	}
+
+	if (!found) {
+		probe_candidates__exit(&cands);
+		pmu->probed.open_supported = false;
+		pmu->probed.open_err = last_err ?: ENOENT;
+		return;
+	}
+
+	pmu->probed.open_supported = true;
+
+	/*
+	 * For tracepoint events, closing the last fd for a tracepoint triggers
+	 * tracepoint_synchronize_unregister() (an RCU grace period) in the
+	 * kernel. Hold one disabled fd open across the probe sequence so
+	 * tp_event->perf_refcount stays >= 1 and each probe open/close is
+	 * instantaneous.
+	 */
+	if (pmu->type == PERF_TYPE_TRACEPOINT) {
+		struct perf_event_attr ka_attr = base_attr;
+
+		ka_attr.disabled = 1;
+		keepalive_fd = sys_perf_event_open(&ka_attr, pid, cpu, -1, flags);
+	}
+
+	group_attrs[nr_group_attrs++] = base_attr;
+
+	for (size_t i = 0; pmu->type != PERF_TYPE_TRACEPOINT &&
+	     i < cands.nr && nr_group_attrs < MAX_PROBE_GROUP_SIZE; i++) {
+		struct perf_event_attr cand_attr;
+		int fd;
+		bool dup = false;
+
+		memset(&cand_attr, 0, sizeof(cand_attr));
+		if (!parse_candidate_attr(cands.names[i], &cand_attr))
+			continue;
+
+		cand_attr.sample_period = base_attr.sample_period;
+		cand_attr.freq = base_attr.freq;
+		cand_attr.sample_type = base_attr.sample_type;
+		cand_attr.exclude_user = base_attr.exclude_user;
+		cand_attr.exclude_kernel = base_attr.exclude_kernel;
+		cand_attr.exclude_hv = base_attr.exclude_hv;
+		cand_attr.exclude_idle = base_attr.exclude_idle;
+		cand_attr.exclude_host = base_attr.exclude_host;
+		cand_attr.exclude_guest = base_attr.exclude_guest;
+		cand_attr.disabled = 1;
+
+		for (size_t j = 0; j < nr_group_attrs; j++) {
+			if (group_attrs[j].type == cand_attr.type &&
+			    group_attrs[j].config == cand_attr.config &&
+			    group_attrs[j].config1 == cand_attr.config1 &&
+			    group_attrs[j].config2 == cand_attr.config2) {
+				dup = true;
+				break;
+			}
+		}
+		if (dup)
+			continue;
+
+		fd = sys_perf_event_open(&cand_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			group_attrs[nr_group_attrs++] = cand_attr;
+		}
+	}
+
+	probe_candidates__exit(&cands);
+
+	/* 1. Counting vs Sampling support */
+	if (base_attr.sample_period == 0) {
+		struct perf_event_attr samp_attr = base_attr;
+		int fd;
+
+		pmu->probed.can_count = true;
+		samp_attr.sample_period = 10000;
+		samp_attr.sample_type = PERF_SAMPLE_IP;
+		fd = sys_perf_event_open(&samp_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_sample = true;
+		}
+	} else {
+		pmu->probed.can_count = false;
+		pmu->probed.can_sample = true;
+	}
+
+	/* 2. All enum perf_event_sample_format types */
+	if (pmu->probed.can_sample)
+		probe_sample_types(pmu, &base_attr, pid, cpu, flags);
+
+	/*
+	 * 3. Precise sampling support (:p, :pp, :ppp).
+	 * PMUs that do not validate attr.precise_ip (such as software,
+	 * breakpoint, or intel_pt) silently accept precise_ip > 0 even when
+	 * sample_period == 0. A PMU that genuinely implements precise_ip
+	 * either rejects precise_ip > 0 on non-sampling events or is a
+	 * sampling-only PMU (such as AMD ibs_op).
+	 * Note: On AMD, core events like cycles:P are forwarded to IBS and
+	 * support higher precision than advertised in sysfs caps/max_precise.
+	 */
+	if (pmu->probed.can_sample && !pmu->auxtrace) {
+		bool ignores_precise_ip = false;
+
+		if (pmu->probed.can_count) {
+			struct perf_event_attr c_attr = base_attr;
+			int fd;
+
+			c_attr.sample_period = 0;
+			c_attr.freq = 0;
+			c_attr.sample_type = 0;
+			c_attr.precise_ip = 1;
+			fd = sys_perf_event_open(&c_attr, pid, cpu, -1, flags);
+			if (fd >= 0) {
+				close(fd);
+				ignores_precise_ip = true;
+			}
+		}
+
+		if (!ignores_precise_ip) {
+			for (int level = 1; level <= 3; level++) {
+				struct perf_event_attr p_attr = base_attr;
+				int fd;
+
+				p_attr.sample_period = 10000;
+				p_attr.sample_type = PERF_SAMPLE_IP;
+				p_attr.precise_ip = level;
+				fd = sys_perf_event_open(&p_attr, pid, cpu, -1, flags);
+				if (fd < 0 && p_attr.exclude_kernel && p_attr.config2 == 0) {
+					p_attr.config2 = 1;
+					fd = sys_perf_event_open(&p_attr, pid, cpu, -1, flags);
+				}
+				if (fd >= 0) {
+					close(fd);
+					pmu->probed.precise_mask |= (1u << level);
+					pmu->probed.max_precise = level;
+				}
+			}
+		}
+
+		probe_pmu_skid(pmu, &base_attr, pmu_cpu, flags);
+	}
+
+	/* 3b. User and interrupt register sampling masks */
+	if (pmu->probed.sample_types & PERF_SAMPLE_REGS_USER) {
+		probe_pmu_regs_one(pmu, &base_attr, pid, cpu, flags,
+				   pmu->probed.max_precise, /*intr=*/false,
+				   &pmu->probed.user_regs_mask,
+				   &pmu->probed.user_regs_abi,
+				   &pmu->probed.user_simd_mask,
+				   &pmu->probed.user_pred_mask);
+	}
+	if (pmu->probed.sample_types & PERF_SAMPLE_REGS_INTR) {
+		probe_pmu_regs_one(pmu, &base_attr, pid, cpu, flags,
+				   pmu->probed.max_precise, /*intr=*/true,
+				   &pmu->probed.intr_regs_mask,
+				   &pmu->probed.intr_regs_abi,
+				   &pmu->probed.intr_simd_mask,
+				   &pmu->probed.intr_pred_mask);
+	}
+
+	/* 3c. Memory event types and memory sample formats */
+	probe_mem_events(pmu, &base_attr, pid, cpu, flags);
+
+	/* 4. Privilege / exclusion modifiers */
+	pmu->probed.exclude_user =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_USER);
+	pmu->probed.exclude_kernel =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_KERNEL);
+	pmu->probed.exclude_hv =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_HV);
+	pmu->probed.exclude_idle =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_IDLE);
+	pmu->probed.exclude_host =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_HOST);
+	pmu->probed.exclude_guest =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_GUEST);
+
+	/* 5. Execution features */
+	if (pmu->probed.can_sample) {
+		struct perf_event_attr l_attr = base_attr;
+		struct perf_event_attr f_attr = nr_group_attrs > 1 ? group_attrs[1] : base_attr;
+		int l_fd;
+
+		l_attr.disabled = 1;
+		l_attr.sample_period = 10000;
+		l_attr.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_READ;
+		l_attr.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
+
+		f_attr.disabled = 0;
+		f_attr.sample_period = 0;
+		f_attr.sample_type = 0;
+		f_attr.read_format = 0;
+
+		l_fd = sys_perf_event_open(&l_attr, pid, cpu, -1, flags);
+		if (l_fd >= 0) {
+			int f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+
+			if (f_fd >= 0) {
+				if (ioctl(l_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP) >= 0)
+					pmu->probed.can_leader_sampling = true;
+				ioctl(l_fd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
+				close(f_fd);
+			}
+			close(l_fd);
+		}
+	}
+
+	{
+		struct perf_event_attr l_attr = base_attr;
+		int l_fd;
+
+		l_attr.disabled = 1;
+		l_fd = sys_perf_event_open(&l_attr, pid, cpu, -1, flags);
+		if (l_fd >= 0) {
+			struct perf_event_attr sw_attr;
+			int sw_fd;
+
+			memset(&sw_attr, 0, sizeof(sw_attr));
+			sw_attr.type = PERF_TYPE_SOFTWARE;
+			sw_attr.size = sizeof(sw_attr);
+			sw_attr.config = PERF_COUNT_SW_DUMMY;
+			sw_attr.disabled = 0;
+			sw_attr.exclude_user = base_attr.exclude_user;
+			sw_attr.exclude_kernel = base_attr.exclude_kernel;
+			sw_attr.exclude_hv = base_attr.exclude_hv;
+			sw_attr.exclude_idle = base_attr.exclude_idle;
+			sw_attr.exclude_host = base_attr.exclude_host;
+			sw_attr.exclude_guest = base_attr.exclude_guest;
+
+			sw_fd = sys_perf_event_open(&sw_attr, pid, cpu, l_fd, flags);
+			if (sw_fd < 0) {
+				sw_attr.config = PERF_COUNT_SW_CPU_CLOCK;
+				sw_fd = sys_perf_event_open(&sw_attr, pid, cpu, l_fd, flags);
+			}
+			if (sw_fd >= 0) {
+				pmu->probed.can_sw_grouping = true;
+				close(sw_fd);
+			}
+			close(l_fd);
+		}
+	}
+
+	{
+		struct perf_event_attr inh_attr = base_attr;
+		int fd;
+
+		inh_attr.disabled = 1;
+		inh_attr.inherit = 1;
+		fd = sys_perf_event_open(&inh_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_inherit = true;
+		}
+	}
+
+	if (pmu->probed.can_sample) {
+		struct perf_event_attr freq_attr = base_attr;
+		int fd;
+
+		freq_attr.disabled = 1;
+		freq_attr.freq = 1;
+		freq_attr.sample_freq = 4000;
+		freq_attr.sample_type = PERF_SAMPLE_IP;
+		fd = sys_perf_event_open(&freq_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_freq = true;
+		}
+	}
+
+	if (pmu->probed.can_sample) {
+		struct perf_event_attr wb_attr = base_attr;
+		int fd;
+
+		wb_attr.disabled = 1;
+		wb_attr.sample_period = 10000;
+		wb_attr.sample_type = PERF_SAMPLE_IP;
+		wb_attr.write_backward = 1;
+		fd = sys_perf_event_open(&wb_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_write_backward = true;
+		}
+	}
+
+	{
+		struct perf_event_attr pin_attr = base_attr;
+		int fd;
+
+		pin_attr.disabled = 1;
+		pin_attr.pinned = 1;
+		fd = sys_perf_event_open(&pin_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_pinned = true;
+		}
+	}
+
+	{
+		struct perf_event_attr exc_attr = base_attr;
+		int fd;
+
+		exc_attr.disabled = 1;
+		exc_attr.exclusive = 1;
+		fd = sys_perf_event_open(&exc_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_exclusive = true;
+		}
+	}
+
+	{
+		struct perf_event_attr lost_attr = base_attr;
+		int fd;
+
+		lost_attr.disabled = 1;
+		lost_attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+					PERF_FORMAT_TOTAL_TIME_RUNNING |
+					PERF_FORMAT_LOST;
+		fd = sys_perf_event_open(&lost_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_format_lost = true;
+		}
+	}
+
+	/* 5b. User-space mmap capabilities (rdpmc, user_time, pmc_width) */
+	probe_mmap_caps(pmu, &base_attr, pmu_cpu, pid, cpu, flags);
+
+	/* 5c. Auto-counter reload (acr_mask / ratio-to-prev) */
+	if (pmu->probed.can_sample && perf_pmu__has_format(pmu, "acr_mask")) {
+		struct perf_event_attr l_attr = base_attr;
+		struct perf_event_attr f_attr = nr_group_attrs > 1 ? group_attrs[1] : base_attr;
+		int l_fd;
+
+		l_attr.disabled = 1;
+		l_attr.freq = 0;
+		l_attr.sample_period = 200000;
+		l_attr.sample_type = PERF_SAMPLE_IP;
+		l_attr.config2 = 0x2;
+
+		f_attr.disabled = 0;
+		f_attr.freq = 0;
+		f_attr.sample_period = 100000;
+		f_attr.sample_type = PERF_SAMPLE_IP;
+		f_attr.config2 = 0x3;
+
+		l_fd = sys_perf_event_open(&l_attr, pid, cpu, -1, flags);
+		if (l_fd >= 0) {
+			int f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+
+			if (f_fd >= 0) {
+				if (ioctl(l_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP) >= 0)
+					pmu->probed.can_acr = true;
+				ioctl(l_fd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
+				close(f_fd);
+			}
+			close(l_fd);
+		}
+	}
+
+	/* 5d. AUX area event actions (start_paused, pause, resume, aux_sample) */
+	if (pmu->auxtrace) {
+		struct perf_event_attr a_attr = base_attr;
+		int l_fd;
+
+		a_attr.size = max_t(__u32, base_attr.size, PERF_ATTR_SIZE_VER8);
+		a_attr.disabled = 1;
+		a_attr.aux_start_paused = 1;
+		l_fd = sys_perf_event_open(&a_attr, pid, cpu, -1, flags);
+		if (l_fd >= 0) {
+			close(l_fd);
+			pmu->probed.can_aux_start_paused = true;
+		}
+
+		a_attr = base_attr;
+		a_attr.disabled = 1;
+		l_fd = sys_perf_event_open(&a_attr, pid, cpu, -1, flags);
+		if (l_fd >= 0) {
+			struct perf_event_attr f_attr;
+			int f_fd;
+
+			memset(&f_attr, 0, sizeof(f_attr));
+			f_attr.type = PERF_TYPE_SOFTWARE;
+			f_attr.size = max_t(__u32, base_attr.size, PERF_ATTR_SIZE_VER8);
+			f_attr.config = PERF_COUNT_SW_CPU_CLOCK;
+			f_attr.sample_period = 10000;
+			f_attr.sample_type = PERF_SAMPLE_IP;
+			f_attr.exclude_user = base_attr.exclude_user;
+			f_attr.exclude_kernel = base_attr.exclude_kernel;
+			f_attr.exclude_hv = base_attr.exclude_hv;
+			f_attr.exclude_idle = base_attr.exclude_idle;
+			f_attr.exclude_host = base_attr.exclude_host;
+			f_attr.exclude_guest = base_attr.exclude_guest;
+
+			f_attr.aux_pause = 1;
+			f_attr.aux_resume = 0;
+			f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+			if (f_fd >= 0) {
+				close(f_fd);
+				pmu->probed.can_aux_pause = true;
+			}
+
+			f_attr.aux_pause = 0;
+			f_attr.aux_resume = 1;
+			f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+			if (f_fd >= 0) {
+				close(f_fd);
+				pmu->probed.can_aux_resume = true;
+			}
+
+			f_attr.aux_resume = 0;
+			f_attr.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_AUX;
+			f_attr.aux_sample_size = 64;
+			f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+			if (f_fd >= 0) {
+				close(f_fd);
+				pmu->probed.can_aux_sample = true;
+			}
+
+			close(l_fd);
+		}
+	}
+
+	/* 6. Max event group size & max simultaneously active group size */
+	if (pmu->name && (!strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe"))) {
+		if (pmu->probed.can_leader_sampling || pmu->probed.can_sw_grouping) {
+			pmu->probed.max_group_size = MAX_PROBE_GROUP_SIZE;
+			pmu->probed.max_group_capped = true;
+			pmu->probed.max_active_group_size = MAX_PROBE_GROUP_SIZE;
+			pmu->probed.max_active_capped = true;
+		} else {
+			pmu->probed.max_group_size = 1;
+			pmu->probed.max_active_group_size = 1;
+		}
+	} else {
+		probe_group_limits(group_attrs, nr_group_attrs, pid, cpu, flags,
+				   &pmu->probed.max_group_size,
+				   &pmu->probed.max_group_capped,
+				   &pmu->probed.max_active_group_size,
+				   &pmu->probed.max_active_capped);
+	}
+
+	/*
+	 * On core PMUs, cycles/instructions may use fixed counters in addition
+	 * to general-purpose (GP) programmable counters. Probe a GP-only event
+	 * group rotating through distinct GP events to determine the GP limit.
+	 */
+	if (pmu->is_core) {
+		static const char * const gp_events[] = {
+			"branches",
+			"branch-misses",
+			"cache-misses",
+			"cache-references",
+			"bus-cycles",
+			"stalled-cycles-frontend",
+			"stalled-cycles-backend",
+			"ref-cycles",
+		};
+		static const int gp_configs[] = {
+			PERF_COUNT_HW_BRANCH_INSTRUCTIONS,
+			PERF_COUNT_HW_BRANCH_MISSES,
+			PERF_COUNT_HW_CACHE_MISSES,
+			PERF_COUNT_HW_CACHE_REFERENCES,
+			PERF_COUNT_HW_BUS_CYCLES,
+			PERF_COUNT_HW_STALLED_CYCLES_FRONTEND,
+			PERF_COUNT_HW_STALLED_CYCLES_BACKEND,
+			PERF_COUNT_HW_REF_CPU_CYCLES,
+		};
+		struct perf_event_attr gp_attrs[MAX_PROBE_GROUP_SIZE];
+		size_t nr_gp_attrs = 0;
+		pid_t gp_pid = pid;
+		int gp_cpu = cpu;
+		int gp_err = 0;
+
+		for (size_t i = 0;
+		     i < ARRAY_SIZE(gp_events) && nr_gp_attrs < MAX_PROBE_GROUP_SIZE; i++) {
+			char gp_buf[256];
+			struct perf_event_attr gp_attr;
+			bool parsed;
+
+			snprintf(gp_buf, sizeof(gp_buf), "%s/%s/", pmu->name, gp_events[i]);
+			memset(&gp_attr, 0, sizeof(gp_attr));
+			parsed = parse_candidate_attr(gp_buf, &gp_attr);
+			if (!parsed) {
+				gp_attr.type = PERF_TYPE_HARDWARE;
+				gp_attr.config = gp_configs[i];
+				if (perf_pmus__supports_extended_type())
+					gp_attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			}
+			gp_attr.sample_period = base_attr.sample_period;
+			gp_attr.freq = base_attr.freq;
+			gp_attr.sample_type = base_attr.sample_type;
+			gp_attr.exclude_user = base_attr.exclude_user;
+			gp_attr.exclude_kernel = base_attr.exclude_kernel;
+			gp_attr.exclude_hv = base_attr.exclude_hv;
+			gp_attr.exclude_idle = base_attr.exclude_idle;
+			gp_attr.exclude_host = base_attr.exclude_host;
+			gp_attr.exclude_guest = base_attr.exclude_guest;
+			gp_attr.disabled = 1;
+
+			if (nr_gp_attrs == 0) {
+				if (try_open_attr_variants(&gp_attr, false, pmu_cpu,
+							   flags, &gp_pid, &gp_cpu, &gp_err)) {
+					gp_attrs[nr_gp_attrs++] = gp_attr;
+				}
+			} else {
+				int fd = sys_perf_event_open(&gp_attr, gp_pid, gp_cpu, -1, flags);
+
+				if (fd >= 0) {
+					close(fd);
+					gp_attrs[nr_gp_attrs++] = gp_attr;
+				}
+			}
+		}
+
+		if (nr_gp_attrs > 0) {
+			probe_group_limits(gp_attrs, nr_gp_attrs, gp_pid, gp_cpu, flags,
+					   &pmu->probed.max_gp_group_size,
+					   &pmu->probed.max_gp_group_capped,
+					   &pmu->probed.max_active_gp_group_size,
+					   &pmu->probed.max_active_gp_capped);
+		}
+	}
+
+	if (keepalive_fd >= 0)
+		close(keepalive_fd);
+}
+
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 {
 	struct hashmap_entry *entry;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2c8916ad073e..fe8a90752396 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -207,6 +207,138 @@ struct perf_pmu {
 	 * @mem_events: List of the supported mem events
 	 */
 	struct perf_mem_event *mem_events;
+
+	/**
+	 * @probed: Capabilities discovered by probing perf_event_open() on live
+	 * systems.
+	 */
+	struct {
+		/** @checked: Has perf_pmu__probe() been run on this PMU? */
+		bool checked;
+		/** @open_supported: Could a probe event be opened on this PMU? */
+		bool open_supported;
+		/** @can_count: Supports counting (sample_period == 0). */
+		bool can_count;
+		/** @can_sample: Supports interrupt-based sampling (sample_period > 0). */
+		bool can_sample;
+		/** @can_branch_stack: Supports PERF_SAMPLE_BRANCH_STACK. */
+		bool can_branch_stack;
+		/** @can_leader_sampling: Supports group leader sampling (:S). */
+		bool can_leader_sampling;
+		/** @can_sw_grouping: Supports grouping software events with this PMU's events. */
+		bool can_sw_grouping;
+		/** @can_inherit: Supports perf_event_attr::inherit across child tasks. */
+		bool can_inherit;
+		/** @can_freq: Supports dynamic sample frequency (perf_event_attr::freq). */
+		bool can_freq;
+		/** @can_write_backward: Supports overwrite ring buffer (write_backward). */
+		bool can_write_backward;
+		/** @can_callchain: Supports PERF_SAMPLE_CALLCHAIN. */
+		bool can_callchain;
+		/** @can_data_src: Supports PERF_SAMPLE_DATA_SRC. */
+		bool can_data_src;
+		/** @can_weight: Supports PERF_SAMPLE_WEIGHT. */
+		bool can_weight;
+		/** @can_pinned: Supports perf_event_attr::pinned. */
+		bool can_pinned;
+		/** @can_exclusive: Supports perf_event_attr::exclusive. */
+		bool can_exclusive;
+		/** @can_format_lost: Supports PERF_FORMAT_LOST. */
+		bool can_format_lost;
+		/** @can_acr: Supports auto-counter reload (acr_mask / ratio-to-prev). */
+		bool can_acr;
+		/** @can_aux_start_paused: Supports aux_start_paused (PERF_PMU_CAP_AUX_PAUSE). */
+		bool can_aux_start_paused;
+		/** @can_aux_pause: Supports aux_pause action on group followers. */
+		bool can_aux_pause;
+		/** @can_aux_resume: Supports aux_resume action on group followers. */
+		bool can_aux_resume;
+		/** @can_aux_sample: Supports AUX area snapshot sampling (aux_sample_size). */
+		bool can_aux_sample;
+		/** @rdpmc_available: PMU supports user-space counter reading (rdpmc/mrs/csrr). */
+		bool rdpmc_available;
+		/** @can_user_rdpmc: User-space counter reading enabled (cap_user_rdpmc & index). */
+		bool can_user_rdpmc;
+		/** @rdpmc_works: User-space counter read instruction executed and worked. */
+		bool rdpmc_works;
+		/** @can_user_time: Supports user-space time conversion (cap_user_time). */
+		bool can_user_time;
+		/** @can_user_time_zero: Supports cap_user_time_zero in mmap page. */
+		bool can_user_time_zero;
+		/** @can_user_time_short: Supports cap_user_time_short in mmap page. */
+		bool can_user_time_short;
+		/** @exclude_user: Supports perf_event_attr::exclude_user. */
+		bool exclude_user;
+		/** @exclude_kernel: Supports perf_event_attr::exclude_kernel. */
+		bool exclude_kernel;
+		/** @exclude_hv: Supports perf_event_attr::exclude_hv. */
+		bool exclude_hv;
+		/** @exclude_idle: Supports perf_event_attr::exclude_idle. */
+		bool exclude_idle;
+		/** @exclude_host: Supports perf_event_attr::exclude_host. */
+		bool exclude_host;
+		/** @exclude_guest: Supports perf_event_attr::exclude_guest. */
+		bool exclude_guest;
+		/** @max_group_capped: Was max_group_size capped at probe limit? */
+		bool max_group_capped;
+		/** @max_active_capped: Was max_active_group_size capped at probe limit? */
+		bool max_active_capped;
+		/** @max_gp_group_capped: Was max_gp_group_size capped at probe limit? */
+		bool max_gp_group_capped;
+		/** @max_active_gp_capped: Was max_active_gp_group_size capped at probe limit? */
+		bool max_active_gp_capped;
+		/** @probe_event: Name of the event used to probe the PMU. */
+		char *probe_event;
+		/** @open_err: errno if open_supported is false. */
+		int open_err;
+		/** @max_precise: Maximum precise_ip level (0..3) supported. */
+		int max_precise;
+		/** @precise_mask: Bitmask of supported precise_ip levels (1..3). */
+		unsigned int precise_mask;
+		/** @max_group_size: Max events in a group accepted by perf_event_open(). */
+		int max_group_size;
+		/** @max_active_group_size: Max events in a group active simultaneously. */
+		int max_active_group_size;
+		/** @max_gp_group_size: Max GP events in a group accepted by perf_event_open(). */
+		int max_gp_group_size;
+		/** @max_active_gp_group_size: Max GP events in a group active simultaneously. */
+		int max_active_gp_group_size;
+		/** @user_regs_abi: ABI flags for user_regs_mask. */
+		int user_regs_abi;
+		/** @intr_regs_abi: ABI flags for intr_regs_mask. */
+		int intr_regs_abi;
+		/** @rdpmc_sysfs: Value from sysfs rdpmc or perf_user_access (-1 if unknown). */
+		int rdpmc_sysfs;
+		/** @mem_events_mask: Bitmask of memory event types verified by probing. */
+		unsigned int mem_events_mask;
+		/** @pmc_width: Bit-width of hardware counter for user-space rdpmc. */
+		u16 pmc_width;
+		/** @sample_types: Bitmask of supported enum perf_event_sample_format flags. */
+		u64 sample_types;
+		/** @mem_sample_types: Bitmask of memory sample formats verified on mem_events. */
+		u64 mem_sample_types;
+		/** @user_regs_mask: Bitmask of supported sample_regs_user registers. */
+		u64 user_regs_mask;
+		/** @intr_regs_mask: Bitmask of supported sample_regs_intr registers. */
+		u64 intr_regs_mask;
+		/** @user_simd_mask: Bitmask of supported user SIMD vector register classes. */
+		u64 user_simd_mask;
+		/** @user_pred_mask: Bitmask of supported user SIMD predicate register classes. */
+		u64 user_pred_mask;
+		/** @intr_simd_mask: Bitmask of supported intr SIMD vector register classes. */
+		u64 intr_simd_mask;
+		/** @intr_pred_mask: Bitmask of supported intr SIMD predicate register classes. */
+		u64 intr_pred_mask;
+		/** @skid: Measured branch instruction skid at precise_ip levels (0..3). */
+		struct {
+			bool measured;
+			int samples;
+			int exact_samples;
+			int min_skid;
+			int max_skid;
+			double avg_skid;
+		} skid[4];
+	} probed;
 };
 
 struct perf_pmu_info {
@@ -329,8 +461,9 @@ bool pmu_uncore_identifier_match(const char *compat, const char *id);
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name);
-
+int perf_pmu__add_cap(struct perf_pmu *pmu, const char *name, const char *value);
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
+void perf_pmu__probe(struct perf_pmu *pmu);
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   const char *name, int config_num,
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 1355b317f3ed..44f24e3a177a 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -7,13 +7,16 @@
 #include <subcmd/pager.h>
 #include <sys/types.h>
 #include <ctype.h>
+#include <errno.h>
 #include <pthread.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include "cpumap.h"
 #include "debug.h"
 #include "drm_pmu.h"
+#include "env.h"
 #include "evsel.h"
 #include "pmus.h"
 #include "pmu.h"
@@ -452,7 +455,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
 	return NULL;
 }
 
-static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
+struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
 	int last_pmu_name_len = 0;
@@ -489,6 +492,27 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 	return NULL;
 }
 
+size_t perf_pmu__num_duplicates(const struct perf_pmu *pmu)
+{
+	const struct perf_pmu *pos = pmu;
+	size_t base_len;
+	size_t count = 1;
+
+	if (!pmu || pmu->is_core)
+		return 1;
+
+	base_len = pmu_name_len_no_suffix(pmu->name ?: "");
+	list_for_each_entry_continue(pos, &other_pmus, list) {
+		size_t pos_len = pmu_name_len_no_suffix(pos->name ?: "");
+
+		if (pos_len != base_len ||
+		    strncmp(pmu->name ?: "", pos->name ?: "", base_len))
+			break;
+		count++;
+	}
+	return count;
+}
+
 struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat)
 {
 	if (!pmu) {
@@ -916,3 +940,198 @@ struct perf_pmu *perf_pmus__fake_pmu(void)
 
 	return &fake;
 }
+
+static bool env_is_pmu_core(const char *name, struct perf_env *env)
+{
+	if (!strcmp(name, "cpu") || !strcmp(name, "cpum_cf") ||
+	    !strcmp(name, "default_core") || strstarts(name, "cpu_") ||
+	    strstarts(name, "armv") ||
+	    (strstarts(name, "apple_") && strstr(name, "_pmu")))
+		return true;
+
+	if (env && env->hybrid_nodes) {
+		for (int i = 0; i < env->nr_hybrid_nodes; i++) {
+			const char *pmu_name = env->hybrid_nodes[i].pmu_name;
+
+			if (pmu_name && !strcmp(name, pmu_name))
+				return true;
+		}
+		return false;
+	}
+
+	if (!env || !strcmp(perf_env__arch(env), perf_env__arch(NULL)))
+		return is_pmu_core(name);
+
+	return false;
+}
+
+static struct perf_pmu *env_pmu_find_or_add(const char *name, __u32 type,
+					    struct perf_env *env,
+					    const struct pmu_events_table *core_table)
+{
+	struct perf_pmu *pmu = pmu_find(name);
+
+	if (pmu) {
+		if (pmu->type == PERF_PMU_TYPE_FAKE && type != PERF_PMU_TYPE_FAKE)
+			pmu->type = type;
+		return pmu;
+	}
+
+	pmu = zalloc(sizeof(*pmu));
+	if (!pmu)
+		return NULL;
+
+	if (perf_pmu__init(pmu, type, name) != 0) {
+		perf_pmu__delete(pmu);
+		return NULL;
+	}
+
+	pmu->sysfs_aliases_loaded = true;
+	pmu->caps_initialized = true;
+	pmu->max_precise = -1;
+	pmu->is_core = env_is_pmu_core(name, env);
+	pmu->is_uncore = strstarts(name, "uncore_");
+
+	if (!strcmp(name, "software") || !strcmp(name, "tool"))
+		pmu->events_table = perf_pmu__default_core_events_table();
+	else if (core_table && (pmu->is_core || pmu->is_uncore))
+		pmu->events_table = core_table;
+
+	list_add_tail(&pmu->list, pmu->is_core ? &core_pmus : &other_pmus);
+	return pmu;
+}
+
+static void env_pmu_add_caps_strings(struct perf_pmu *pmu, int nr_caps, char **caps)
+{
+	if (!pmu || nr_caps <= 0 || !caps)
+		return;
+
+	for (int i = 0; i < nr_caps; i++) {
+		const char *eq;
+
+		if (!caps[i])
+			continue;
+		eq = strchr(caps[i], '=');
+
+		if (eq) {
+			char *key = strndup(caps[i], eq - caps[i]);
+
+			if (key) {
+				perf_pmu__add_cap(pmu, key, eq + 1);
+				free(key);
+			}
+		} else {
+			perf_pmu__add_cap(pmu, caps[i], "");
+		}
+	}
+}
+
+int perf_pmus__read_from_env(struct perf_env *env)
+{
+	const struct pmu_events_table *core_table = NULL;
+	struct perf_pmu *pmu;
+
+	if (!env)
+		return -EINVAL;
+
+	perf_pmus__destroy();
+	read_pmu_types = PERF_TOOL_PMU_TYPE_ALL_MASK;
+
+	if (env->cpuid) {
+		char cpuid_str[128];
+		char vendor[32];
+		unsigned int family, model, step;
+		const char *cpuid = env->cpuid;
+
+		/*
+		 * x86 HEADER_CPUID stores "vendor,family,model,step" in decimal
+		 * while pmu-events tables match "vendor-family-HEXMODEL-HEXSTEP".
+		 */
+		if (sscanf(env->cpuid, "%31[^,],%u,%u,%u",
+			   vendor, &family, &model, &step) == 4) {
+			snprintf(cpuid_str, sizeof(cpuid_str), "%s-%u-%X-%X",
+				 vendor, family, model, step);
+			cpuid = cpuid_str;
+		}
+		core_table = find_core_events_table(perf_env__arch(env), cpuid);
+	}
+
+	/* 1. Populate from HEADER_PMU_MAPPINGS */
+	if (env->nr_pmu_mappings > 0 && env->pmu_mappings) {
+		char *str = env->pmu_mappings;
+
+		for (int i = 0; i < env->nr_pmu_mappings; i++) {
+			char *colon = NULL;
+			unsigned long type = strtoul(str, &colon, 0);
+
+			if (!colon || *colon != ':')
+				break;
+			str = colon + 1;
+			env_pmu_find_or_add(str, (__u32)type, env, core_table);
+			str += strlen(str) + 1;
+		}
+	}
+
+	/* 2. Populate/enrich from HEADER_HYBRID_TOPOLOGY */
+	for (int i = 0; i < env->nr_hybrid_nodes; i++) {
+		struct hybrid_node *hn = &env->hybrid_nodes[i];
+
+		if (!hn->pmu_name)
+			continue;
+		pmu = env_pmu_find_or_add(hn->pmu_name, PERF_PMU_TYPE_FAKE,
+					  env, core_table);
+		if (!pmu)
+			continue;
+		if (!pmu->is_core) {
+			pmu->is_core = true;
+			if (!pmu->events_table && core_table)
+				pmu->events_table = core_table;
+			list_move_tail(&pmu->list, &core_pmus);
+		}
+		if (hn->cpus && !pmu->cpus)
+			pmu->cpus = perf_cpu_map__new(hn->cpus);
+	}
+
+	/*
+	 * 3. Populate/enrich from HEADER_CPU_PMU_CAPS.
+	 * On hybrid systems HEADER_CPU_PMU_CAPS duplicates the first core PMU
+	 * while HEADER_PMU_CAPS has the per-PMU capabilities, so only create a
+	 * "cpu" PMU entry if no core PMUs exist yet.
+	 */
+	if (env->nr_cpu_pmu_caps > 0 && env->cpu_pmu_caps) {
+		pmu = pmu_find("cpu");
+		if (!pmu && list_empty(&core_pmus)) {
+			pmu = env_pmu_find_or_add("cpu", PERF_TYPE_RAW,
+						  env, core_table);
+		}
+		if (pmu)
+			env_pmu_add_caps_strings(pmu, env->nr_cpu_pmu_caps, env->cpu_pmu_caps);
+	}
+
+	/* 4. Populate/enrich from HEADER_PMU_CAPS */
+	for (int i = 0; i < env->nr_pmus_with_caps; i++) {
+		struct pmu_caps *pc = &env->pmu_caps[i];
+
+		if (!pc->pmu_name)
+			continue;
+		pmu = env_pmu_find_or_add(pc->pmu_name, PERF_PMU_TYPE_FAKE,
+					  env, core_table);
+		if (pmu)
+			env_pmu_add_caps_strings(pmu, pc->nr_caps, pc->caps);
+	}
+
+	/* 5. Set default core CPUs on non-hybrid systems */
+	if (env->nr_cpus_avail > 0 && env->nr_hybrid_nodes == 0) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "0-%d", env->nr_cpus_avail - 1);
+		list_for_each_entry(pmu, &core_pmus, list) {
+			if (!pmu->cpus)
+				pmu->cpus = perf_cpu_map__new(buf);
+		}
+	}
+
+	list_sort(NULL, &core_pmus, pmus_cmp);
+	list_sort(NULL, &other_pmus, pmus_cmp);
+	return 0;
+}
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 0d55edb3f2fc..f1402e50b5b9 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -6,6 +6,7 @@
 #include <stddef.h>
 
 struct perf_event_attr;
+struct perf_env;
 struct perf_pmu;
 struct print_callbacks;
 
@@ -14,16 +15,19 @@ size_t pmu_name_len_no_suffix(const char *str);
 int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
 
 void perf_pmus__destroy(void);
+int perf_pmus__read_from_env(struct perf_env *env);
 
 struct perf_pmu *perf_pmus__find(const char *name);
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
 struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
+struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
 struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
 struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat);
+size_t perf_pmu__num_duplicates(const struct perf_pmu *pmu);
 
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
-- 
2.56.0.212.g129ede20d9-goog

