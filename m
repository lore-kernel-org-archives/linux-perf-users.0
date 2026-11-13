Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599773;
	b=H3sMEPbS4S0qU1vynvtt3Zw5gyk3cBEBrUgoO15rSBTRwek3KqQkS+rAhn2WZFe2Pud1
	 Q9YQXouoAExMORAWu6NkD1rseBkJs3InNM40p8Xy3LT53YaQKny7LjnOzbFfpTN6BIQ/B
	 fiSFzdb+WdXthaE79n0/2UnnD88r7iMwn/4eEk6XK55a5Agh3rxm896GgiD8vufVSw8MB
	 n2EqRRgcWb5mmqMGL0q/hnSUBvEcPjw489K3ctH9kR7X9pqfv5wC0iN9BzR2XH/tosNwq
	 zSBHAqzEmOUzTJ57ukjmhIb7h5A10WI27oI/b/BWaTnTbyuSHhSdXce6flEpWtaZmXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=hJAxDe7mM7xTV0HomaZEqY329cyh6oGW/sNFXeKjq88=;
	b=vbH9BnmmIAFy48xQZuOsdoP0s3vG8HAUTl6lyvK8+bjt1E3U7mRREPx5bz/O7U8vzn6L
	 fs3+osG507RBAwWK+UW1pitjMZW80LV3DSlE+cm8AaIrsTvlbaehyj+IsjUsB8qowq24p
	 vMZz/3kuYJHIJQXyLEgK5XbfsTBefyc/4cF35kopsO7PHXI6Z9DpzxwBfUSPOKx9WhZEt
	 5IusH8eTtkaHlnPCM2teOmmpW1tWzsv1Ly4KNe21on359SrcqaDp+51d6tSbSonuomLSY
	 3iAzKGxmcvjnvaA4ua+Q6o3MgZr7rONePMx0lVBJpMsWJspG8Hzn1dEE011SjefpO7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FQXIFIck;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E360A3827
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A77E360A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FQXIFIck
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-37628596fc9so2660446eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599772; x=1795204572; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJAxDe7mM7xTV0HomaZEqY329cyh6oGW/sNFXeKjq88=;
        b=FQXIFIckTF/Kp/VDxXYmKdP5VR+yMKcEkmNTb5llnZJjB2Czb01yc3cQn17MBpBGJ+
         srnhNLBmEi9iSGYraI1TZ9HgRlI6N2I3+lPlYBc1bNGQyhrlmGy9/obDmxQmldk3b45D
         TDK6MJwUxargChg4KxWrc9PWG0X68G7dMoB7KYBlfFaxKcW/tkYMfY680LKjY+Y/ibeM
         YvDeEzDJdF9PtBZ3atsxr/o/lQARZo8M3wGuu0Dnw68cVUDFWfQsenUg1svHOdImJWyf
         UkdWd76ARThSBxRt1i2O4RL7nytkiGtuuaN2AE5xSnXnmZWbh469qTxtevpRX03p0oub
         ftgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599772; x=1795204572;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJAxDe7mM7xTV0HomaZEqY329cyh6oGW/sNFXeKjq88=;
        b=rm6eb2iWihjksa50QGUjW3QI0LVgnjnr6MdVp70b0Irw+LlmShKO29ZZi5pmYVyeSW
         132h1AuFUbRPPxB/ofT3VuO9OxeIa+tH9eDB4qfujcAw/P7UOaojY178PPje4MPEpPsn
         SacDkiEhnDt1SaBcsmmdtwt2Faal9X5w3MzsMMQCFNL3biXz1iQm3OgnUgOUNdQUNM6Q
         UNH8vU0z2wgxt6rjWRr7nnOUXMg0APCjExptQEDPhIfLItinitmWNBCxvkxXCvgoRBAw
         VZb+/k0jfDrSbfAUp74+k9kbi3kKd0Tzp/bZcXocJCx9ImCGEkPl/o8Yc6brXqy2r/bn
         C+QQ==
X-Gm-Message-State: APuU4Z9q5uXs5e9tR0UD3PZXWC/nVvV8sbBqXkVF/sWZRLFvCnnXD6w3
	XPtjRQgqTjEJ4U4BQMXWcgwrvHkgC6Ilf7cpeggb7+pgqF4a2DCY5CTnq6dZWB5Z9XDjVrgQcpu
	e9jcqJc6PHw==
X-Received: from dlbvs11.prod.google.com ([2002:a05:7022:3f0b:b0:1a7:c918:186f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:286:20b0:17a:e684:b497
 with SMTP id a92af1059eb24-1b50308b459mr3479078c88.5.1794599771358; Fri, 13
 Nov 2026 11:56:11 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:48 -0800
In-Reply-To: <20261113195601.2872738-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195601.2872738-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195601.2872738-4-irogers@google.com>
Subject: [PATCH v2 03/16] perf pmu: Add perf_pmu__probe() for basic open,
 counting, and sampling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sysfs PMU metadata does not expose many runtime kernel and hardware
capabilities, such as whether a PMU supports counting vs interrupt-based
sampling or whether perf_event_open() succeeds under the current
privilege level.

Add struct perf_pmu::probed and perf_pmu__probe() to actively probe a
live PMU via perf_event_open() on a dedicated worker thread pinned to an
online CPU associated with the PMU. Select a representative probe event
for tracepoint, kprobe, uprobe, core, software, breakpoint, and uncore
PMUs, hold a keepalive fd for tracepoints to avoid repeated RCU
synchronize_rcu() delays on close, and record whether opening, counting
(sample_period == 0), and sampling (sample_period > 0) are supported.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 577 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  31 ++-
 2 files changed, 607 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6db7d7df9c26..be93ff8b9948 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -4,12 +4,18 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <linux/ctype.h>
+#include <linux/hw_breakpoint.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <elf.h>
 #include <errno.h>
+#include <limits.h>
 #include <stdbool.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -20,6 +26,8 @@
 #include <locale.h>
 #include <fnmatch.h>
 #include <math.h>
+#include <pthread.h>
+#include <sched.h>
 #include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
@@ -40,6 +48,14 @@
 #include "strbuf.h"
 #include "fncache.h"
 #include "util/evsel_config.h"
+#include "cloexec.h"
+#include "evlist.h"
+#include "mem-events.h"
+#include "mmap.h"
+#include "perf_regs.h"
+#include "rlimit.h"
+#include "util/sample.h"
+#include "../perf-sys.h"
 #include <regex.h>
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
@@ -2840,9 +2856,570 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->name);
 	zfree(&pmu->alias_name);
 	zfree(&pmu->id);
+	zfree(&pmu->probed.probe_event);
 	free(pmu);
 }
 
+#define MAX_PROBE_CANDIDATES 16
+#define MAX_TRACEPOINT_PROBE_CANDIDATES 3
+
+static unsigned long dummy_bp_var;
+
+/*
+ * Resolve /proc/self/exe and compute the file offset of its ELF entry point
+ * so the uprobe PMU can be probed against the running perf binary.
+ */
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
+		/* ftrace internal tracepoints, like ftrace:function, can't be opened. */
+		if (strstarts(info->name, "ftrace:"))
+			return 0;
+		probe_candidates__add(cands, info->name);
+		/* Opening tracepoints is slow, try only a few. */
+		return cands->nr >= MAX_TRACEPOINT_PROBE_CANDIDATES ? 1 : 0;
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
+/*
+ * Pick an online CPU associated with @pmu (preferring one in the caller's
+ * CPU affinity mask) on which to run perf_event_open() probes.
+ */
+static int select_probe_cpu(const struct perf_pmu *pmu)
+{
+	struct perf_cpu_map *online = perf_cpu_map__new_online_cpus();
+	cpu_set_t aff;
+	bool have_aff;
+	int cpu = 0;
+
+	CPU_ZERO(&aff);
+	have_aff = sched_getaffinity(0, sizeof(aff), &aff) == 0;
+
+	if (pmu->cpus && !perf_cpu_map__is_empty(pmu->cpus)) {
+		int nr = perf_cpu_map__nr(pmu->cpus);
+		bool matched_online = false;
+
+		cpu = perf_cpu_map__cpu(pmu->cpus, 0).cpu;
+		if (online) {
+			for (int i = 0; i < nr; i++) {
+				struct perf_cpu c = perf_cpu_map__cpu(pmu->cpus, i);
+
+				if (!perf_cpu_map__has(online, c))
+					continue;
+				if (!matched_online) {
+					cpu = c.cpu;
+					matched_online = true;
+				}
+				if (have_aff && c.cpu >= 0 && c.cpu < CPU_SETSIZE &&
+				    CPU_ISSET(c.cpu, &aff)) {
+					cpu = c.cpu;
+					break;
+				}
+			}
+		}
+	} else if (online && !perf_cpu_map__is_empty(online)) {
+		int nr = perf_cpu_map__nr(online);
+
+		cpu = perf_cpu_map__cpu(online, 0).cpu;
+		if (have_aff) {
+			for (int i = 0; i < nr; i++) {
+				struct perf_cpu c = perf_cpu_map__cpu(online, i);
+
+				if (c.cpu >= 0 && c.cpu < CPU_SETSIZE &&
+				    CPU_ISSET(c.cpu, &aff)) {
+					cpu = c.cpu;
+					break;
+				}
+			}
+		}
+	}
+
+	perf_cpu_map__put(online);
+	return cpu >= 0 ? cpu : 0;
+}
+
+/*
+ * Try opening @attr across task/CPU target modes, counting/sampling modes,
+ * and privilege exclusion combinations until a working baseline configuration
+ * is found.
+ */
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
+static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
+{
+	struct probe_candidates cands = { .nr = 0 };
+	struct perf_event_attr base_attr;
+	char uprobe_exe_path[PATH_MAX];
+	__u64 uprobe_offset = 0;
+	unsigned long flags = perf_event_open_cloexec_flag();
+	int keepalive_fd = -1;
+	pid_t pid = 0;
+	int cpu = 0;
+	int last_err = 0;
+	bool found = false;
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
+			if (tp_id < 0) {
+				/* Record errors like EACCES reading tracefs. */
+				if (last_err == 0)
+					last_err = errno ?: ENOENT;
+			} else {
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
+		char buf[256];
+
+		/*
+		 * PMUs like AMD IBS without hardware privilege filtering need
+		 * swfilt=1 to open with exclude_kernel, as needed when probing
+		 * unprivileged. They aren't selectable and have no sysfs events.
+		 */
+		if (perf_pmu__has_format(pmu, "swfilt")) {
+			snprintf(buf, sizeof(buf), "%s/swfilt=1/", pmu->name);
+			probe_candidates__add(&cands, buf);
+		}
+		if (pmu->selectable) {
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
+		if (perf_pmus__host_supports_extended_type())
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
+	/*
+	 * Try an all zero config for PMUs without events. Tracepoint,
+	 * breakpoint, kprobe and uprobe PMUs need a config (or address) and
+	 * were handled above.
+	 */
+	if (!found && cands.nr == 0 && pmu->type != PERF_TYPE_TRACEPOINT &&
+	    pmu->type != PERF_TYPE_BREAKPOINT &&
+	    !(pmu->name && (!strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe")))) {
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
+	if (keepalive_fd >= 0)
+		close(keepalive_fd);
+	pmu->probed.checked = true;
+}
+
+struct probe_thread_args {
+	struct perf_pmu *pmu;
+	int pmu_cpu;
+};
+
+static void *perf_pmu__probe_thread(void *arg)
+{
+	struct probe_thread_args *args = arg;
+
+	if (args->pmu_cpu >= 0 && args->pmu_cpu < CPU_SETSIZE) {
+		cpu_set_t mask;
+
+		CPU_ZERO(&mask);
+		CPU_SET(args->pmu_cpu, &mask);
+		sched_setaffinity(0, sizeof(mask), &mask);
+	}
+	__perf_pmu__probe(args->pmu, args->pmu_cpu);
+	return NULL;
+}
+
+void perf_pmu__probe(struct perf_pmu *pmu)
+{
+	struct probe_thread_args args = {
+		.pmu = pmu,
+	};
+	pthread_t thread;
+
+	if (!pmu || pmu->from_env || pmu->probed.checked)
+		return;
+	if (perf_pmu__kind(pmu) != PERF_PMU_KIND_PE)
+		return;
+
+	args.pmu_cpu = select_probe_cpu(pmu);
+	if (pthread_create(&thread, NULL, perf_pmu__probe_thread, &args) == 0)
+		pthread_join(thread, NULL);
+	else
+		__perf_pmu__probe(pmu, args.pmu_cpu);
+}
+
 static bool pmu_config_equal(__u32 type, u64 a, u64 b)
 {
 	/* Ignore the extended PMU type in the upper bits of legacy encodings. */
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b556ec51fdeb..ddcd28b3cae5 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -212,6 +212,25 @@ struct perf_pmu {
 	 * @mem_events: List of the supported mem events
 	 */
 	struct perf_mem_event *mem_events;
+
+	/**
+	 * @probed: Capabilities discovered by probing perf_event_open() on live
+	 * systems.
+	 */
+	struct {
+		/** @probed.checked: Has perf_pmu__probe() been run on this PMU? */
+		bool checked;
+		/** @probed.open_supported: Could a probe event be opened on this PMU? */
+		bool open_supported;
+		/** @probed.can_count: Supports counting (sample_period == 0). */
+		bool can_count;
+		/** @probed.can_sample: Supports interrupt-based sampling (sample_period > 0). */
+		bool can_sample;
+		/** @probed.probe_event: Name of the event used to probe the PMU. */
+		char *probe_event;
+		/** @probed.open_err: errno if open_supported is false. */
+		int open_err;
+	} probed;
 };
 
 struct perf_pmu_info {
@@ -334,6 +353,7 @@ bool pmu_uncore_identifier_match(const char *compat, const char *id);
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name);
+
 /**
  * perf_pmu__add_cap() - Add a name/value capability entry to @pmu->caps.
  * @pmu: The PMU to add the capability to.
@@ -343,9 +363,18 @@ struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name);
  * Return: 0 on success, negative error code on failure.
  */
 int perf_pmu__add_cap(struct perf_pmu *pmu, const char *name, const char *value);
-
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
+/**
+ * perf_pmu__probe() - Actively probe live kernel/hardware capabilities for @pmu.
+ * @pmu: The PMU to probe via perf_event_open().
+ *
+ * Populates @pmu->probed with supported modes, sample formats, privilege
+ * exclusions, register masks, memory events, group limits, rdpmc, and skid.
+ * No-op if @pmu->probed.checked is already set or @pmu->from_env is true.
+ */
+void perf_pmu__probe(struct perf_pmu *pmu);
+
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   const char *name, int config_num,
 				   const char *config_name);
-- 
2.56.1.703.gf848ed807c-goog

