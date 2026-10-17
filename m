Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3DB3DDAFA
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263308; cv=none; b=oYcRsOwoeO0l+wEsGxau2UdebAfRkOe4oolo9NSiVg+PVice7WZAHwX2xdlFR5/qleqJrsMFB6c+DuaEMQ6AAXFIhoXk+HY4s4J0XhlTxqhc0zX5AUZEKBZ77tEOvqXdFYy8WLD4DJ+wU7Ac0YkIaA0nDQb26n5oCPOww8ua7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263308; c=relaxed/simple;
	bh=d8ccj9wasrUpk6SrnlHGB47zakLtv+KxknX/3XaLWjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Le/wv67gNYgNUXNSSONy/VEt6ogAXr0srkKFmyCMIwoujseI3S0S6cHpPw1vgNYwrEVh+cYyqxH89qSTy7kLOYp1iXcKsp0f2J9Ua6gTEw5G4+VgJc9Xp+xfMKi7OSviG0NAq63xs8rGbYInKSXdfT7oDyouvVkSbNLzHcYDWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ditwdCph; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ditwdCph"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so3566265c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792263303; x=1792868103; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jzq4IMlcviYl43vBpDT6+ClQb90rxjT75S9ty1COlLY=;
        b=ditwdCphfvLuwf7AsnYnoa7cw/J3Pqc4YEmETH4eYbWwd3zArF/U5Sw3ebIHJuJKq4
         2bOvSUP+/B0ABJsRJuLd0rccfzFZ6VliPbTck7ZqUYfbhT2Bu8gBcAOGaTxQwS0MK3ic
         gLivYh5PYSQXUcpmcxdqBT2msQasjMIo2FMtJTzCu/tHsxdNPCpNGVMg9UYOnVGTebsk
         ihyiaZApFSvyiuBGNX2n3mq/OyrGOnr4n6oDYch+Jnc1wSKOr/wRAsH6d0zdY5QPi5y7
         orrNcyAOtjNK+opYOOuah2OB3wqEI5kSWlFlExB01zoJ4wI3Gc9X4oW/6wOa2d9+ZOxe
         bGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792263303; x=1792868103;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jzq4IMlcviYl43vBpDT6+ClQb90rxjT75S9ty1COlLY=;
        b=afSP9sBqETdl/YVhiqqvUd1UYJ9UQ3VcyZXcMEgMbTDjfPwNhIAQo7Pzwdgm1aXoD4
         pyG9+y2y5Rwtn8s263ZpttCZujVuh8KV8BpG4glMOVZFHBq8mk6bbmHxJNMJjKXcf+cE
         T2kCU57GrFRLcCZbxReXJ/Uch9NUIvrvBAgKX6OyZQzmRLJ9+Qg8IlK7R7fFQPgBMtKS
         vcDc5UX0XvWVaP1oTYeNbLGel22iQzdJv2L5RtYlXuo5Cqzz8aeZt6ykxot3yS5T+q7d
         gjfRhElTOYvXFlpiE0NGL4Hj0iF82WMesbXMnDKnzuWLXO0X6fiJu75EVyY9CeK+02YX
         pJNw==
X-Forwarded-Encrypted: i=1; AKwUvBx8bL0IAUhtdutOXJpHyFO20JxVdEoIZ9+0Uj6OrUHHDOUMKf8Z8tLh1ug48nbhkFbDlNA7B9SWgISF25XHD8UR@vger.kernel.org
X-Gm-Message-State: AFq9FYIvwEUED3tpF2ddZKfjSEkPFt49vTqwcQOXWBDPvvjpmeAvU4xn
	kuGhaMhl7nmpyvkHRLfIFTM8x60JKiziz6SzG3RN45jnZ/eS4vudSf2gYjR+MmMtxmb6KTW8Mw2
	XgWe+56uhow==
X-Received: from dleg20.prod.google.com ([2002:a05:701b:4314:b0:168:b4b9:d783])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f685:b0:158:7ea9:4a76
 with SMTP id a92af1059eb24-185120a8d0cmr6455576c88.16.1792263301972; Sat, 17
 Oct 2026 11:55:01 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:54:38 -0700
In-Reply-To: <20261017185442.2137623-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016213258.945737-1-irogers@google.com> <20261017185442.2137623-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017185442.2137623-6-irogers@google.com>
Subject: [RFC PATCH v2 5/9] perf pmu: Add perf_pmu__probe() for live
 capability probing
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, eranian@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add struct perf_pmu::probed and perf_pmu__probe() to actively probe live
PMU capabilities via perf_event_open(), including
counting/sampling/branch_stack modes, precise_ip levels, supported
perf_event_sample_format flags, privilege exclusion modifiers, execution
features (leader sampling, software grouping, auto-counter reload, AUX
pause/resume/sample), and event group size limits.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 1225 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  134 ++++-
 2 files changed, 1358 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cd8211f87291..83c8d6f392ba 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -9,6 +9,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <errno.h>
+#include <limits.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -38,7 +39,21 @@
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
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
@@ -2832,9 +2847,1219 @@ void perf_pmu__delete(struct perf_pmu *pmu)
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
+#if __SIZEOF_POINTER__ == 8
+	Elf64_Ehdr ehdr;
+#else
+	Elf32_Ehdr ehdr;
+#endif
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
+	    memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0) {
+		close(fd);
+		return false;
+	}
+
+	for (unsigned int i = 0; i < ehdr.e_phnum; i++) {
+#if __SIZEOF_POINTER__ == 8
+		Elf64_Phdr phdr;
+#else
+		Elf32_Phdr phdr;
+#endif
+		off_t pos = (off_t)ehdr.e_phoff + (off_t)i * ehdr.e_phentsize;
+
+		if (ehdr.e_phentsize < sizeof(phdr))
+			break;
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
+	if (pid == 0 && cpu >= 0 && cpu < CPU_SETSIZE) {
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
+			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_CGROUP |
+			PERF_SAMPLE_DATA_PAGE_SIZE | PERF_SAMPLE_CODE_PAGE_SIZE;
+	struct perf_event_attr b_attr = *base_attr;
+	int b_fd;
+
+	b_attr.disabled = 1;
+	b_attr.sample_period = base_attr->sample_period ?: 10000;
+	b_attr.sample_type = bulk_mask;
+	b_attr.sample_regs_user = reg_bit;
+	b_attr.sample_regs_intr = reg_bit;
+	b_attr.sample_stack_user = 64;
+	b_attr.exclude_callchain_kernel = b_attr.exclude_kernel;
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
+		case PERF_SAMPLE_CALLCHAIN:
+			attr.exclude_callchain_kernel = attr.exclude_kernel;
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
+	if (!pmu || pmu->from_env || pmu->probed.checked)
+		return;
+	if (perf_pmu__kind(pmu) != PERF_PMU_KIND_PE)
+		return;
+
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
+		pmu->probed.checked = true;
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
+	}
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
+		};
+		static const int gp_configs[] = {
+			PERF_COUNT_HW_BRANCH_INSTRUCTIONS,
+			PERF_COUNT_HW_BRANCH_MISSES,
+			PERF_COUNT_HW_CACHE_MISSES,
+			PERF_COUNT_HW_CACHE_REFERENCES,
+			PERF_COUNT_HW_BUS_CYCLES,
+			PERF_COUNT_HW_STALLED_CYCLES_FRONTEND,
+			PERF_COUNT_HW_STALLED_CYCLES_BACKEND,
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
+	pmu->probed.checked = true;
+}
+
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 {
 	struct hashmap_entry *entry;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index adb33a9fc94b..6da57b167d71 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -209,6 +209,138 @@ struct perf_pmu {
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
@@ -332,8 +464,8 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name);
 int perf_pmu__add_cap(struct perf_pmu *pmu, const char *name, const char *value);
-
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
+void perf_pmu__probe(struct perf_pmu *pmu);
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   const char *name, int config_num,
-- 
2.56.0.212.g129ede20d9-goog

