Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589558;
	b=KGwmTSirPP2savfApV8tTdTiNPBTYIbMDtj2JL+MZsferBSRAQYRQrXMa75koooMpK9W
	 T1L/UYSUf5BZKSEDVMjKq3iF56MtZAv9sq0rvFwnKmdUE/EqEbmHYKSLFnlivfctBQdKh
	 ENg2QQoAcKFj8fgiJpPxiCuLCgsldzHXauOSg50VYV56fgf/qfmeIVw4NW40HN1oZxzoK
	 8Mmwa3uM6C4tubzHbP94OKUFltfga58YqSS0sJ23RVMjI95tNYsPWnJHVjEO92blWzvN+
	 2MsLWVVJYV1sYuTOBx/Vi1+pg273v12kkhKjw++ajwi+3JItEbjkKDrqLFgX0AVaQtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VllZCRxHXhASSEzD2uBJCOFg8Pw9CGUf0z7UKEmqyFo=;
	b=yd30qWlMKfW2TF7tQhHQjcfdvbIMqAAnbiuLMRpKtCRiAKvPJQJ2lG1tE98C1Xwj+F3k
	 j+aGCanK7qyPmqrK65J4aHN0PYrbee8ekNn0T4ljMzazLfhy6MHUJnHDlXyyUo8o2q1w/
	 Cjw2HfYKAWZI0rSBJvuaijpLCvGB93EHMyWfY2UkOufx7QCI9LQXsGq1s8jWl4uUGuMog
	 5NsSnizAC/1bRRm2yaWu3MLYFqN8aLz21uWnGD2GAANF7unlam3Llg9CliPUmaM/0eX/c
	 SQOZsC3NZJMv586euV22dga3bCWvEhATy/NQC8e7sEFmb/8WZ1tqKU3SstFvjB1wb8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MmshmYh1;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23E606A333
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 06:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A23E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MmshmYh1
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-386c3309469so1592124eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795589557; x=1796194357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VllZCRxHXhASSEzD2uBJCOFg8Pw9CGUf0z7UKEmqyFo=;
        b=MmshmYh1hAIOA+J04Lu+c5vbeI0PuHfZqgxj/BT4XRSqA1POAgdDy6zbnVBO6mKwC3
         shXR2hm1T9ziy9HwmX3ox0nKIdXhGvzosXPiELNFVJZWLecGiOjFQ6HY5MKfbuvA5/bn
         ebyf8ums2ldlg3UX8iQwFa+KYwzZENsgBAcOCITrbZ4zsrXCyzfuaDOxDDbU55Mh5WBB
         RPJLs5o561rb/yzRSi8Y4fePKvhUDh20NEvUFJQ4Q9fvWV99yIoDMGRN6G/5kNaxAHa0
         tFhfSYDY7TuyrwyYmyKfbOEz7wEnO3FaR2rKbQdH6n6ehmu8m+JKQTHyarjRqO/3V66g
         icqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589557; x=1796194357;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VllZCRxHXhASSEzD2uBJCOFg8Pw9CGUf0z7UKEmqyFo=;
        b=aricYK69gr+TxF8+hIGVooLEU7TzsO5xFRkPlk4Fw7OHhNVwAjo4LsRZbr0cSYqJBe
         WdJQmW11XNVacqO6HK3JUJELh7AlcE/wEyTrjQPX1OXZhoBR43eKRDmvhHo2cDA9gNlM
         1nELvTAfUYvDJJJ3A42SlnxrmqjVL4av343angjqhw3JKmAkE4A9NnkCDU07779lkgFu
         FO1AvwJn2q//lKmohFQEP8oFudDjO743QnKUFfufl4plq2N2noOeQ48c8hqY7Qfjcke8
         OqOMca/6xCEEBqKlO4IVtdVyJdfzdhZcDCCS4HyRCu2AcMgkA9N5s0PFI9rrdh7KTNtm
         GNzQ==
X-Forwarded-Encrypted: i=1; AL+hErGGS8rvshQrhYXvoOys7Bc6YolyoLQf1MrlYtDNqnveNvOIek8NeMYLX5yqdQdfcfVNinsqg1GZG5jx+rcORVwV@vger.kernel.org
X-Gm-Message-State: APuU4Z+wn/aBTYpeyBIneXDqoZiOOT5EKiaMGWjlxCxRn7VNEiYAvWrL
	2O9mGQX4GwDYvvwACqGDWP0QXt1rcy++1YAdoPQKb0nHj8qlvR0YOuMg7aNGrXkFYjWJMDx5+s5
	VkmZPPbjIdw==
X-Received: from dybhv24.prod.google.com ([2002:a05:7301:2b18:b0:386:9f7a:4a32])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:78d:b0:385:bc4e:dbbf
 with SMTP id 5a478bee46e88-385bc4ee6c2mr16157619eec.37.1795589556599; Tue, 24
 Nov 2026 22:52:36 -0800 (PST)
Date: Tue, 24 Nov 2026 22:52:29 -0800
In-Reply-To: <80d983c5713537f5743b69e9b35ced1177e4732e.1795589380.git.irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <80d983c5713537f5743b69e9b35ced1177e4732e.1795589380.git.irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <254fb7a2a935c44c62654f3eaefbbc73e23b455b.1795589380.git.irogers@google.com>
Subject: [PATCH v3 2/2] perf test: Add filtered event enabled time tests to event-times
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend the "Event times" test suite (tools/perf/tests/event-times.c)
with subtests verifying that filtered-out events stay in
PERF_EVENT_STATE_ON and do not accrue bogus total_time_enabled:

- Task and CPU filtered event times: open a cpu-clock event targeting
  both the current thread and one CPU, verifying zero enabled/running
  time when enabled on a non-matching CPU (including the mmap userpage),
  matching enabled and running times on the target CPU, zero time
  accrued after migrating away, and matching times across fork()
  inheritance.
- Hybrid PMU filtered event times: on systems with multiple core PMUs
  (including >2 core types), iterate all core PMUs and verify per-task
  core PMU events accrue zero enabled time while running on CPUs
  belonging to any other core PMU.
- Multiplexed and group filtered event times: iterate core PMUs and
  verify flexible events and groups in PERF_EVENT_STATE_INACTIVE
  (including siblings promoted to group leader on leader close)
  transition back to PERF_EVENT_STATE_ON on context switch and accrue
  zero enabled time after migrating to a filtered-out CPU.

Reuse struct affinity from tools/perf/util/affinity.{c,h}, hardening
affinity__setup() to retry on EINVAL for large kernel cpumasks, adding
affinity__has_cpu(), and returning an error status from affinity__set().

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3:
  - Try PERF_TYPE_HARDWARE with PERF_COUNT_HW_CPU_CYCLES first on
    non-hybrid systems (perf_pmus__num_core_pmus() <= 1) in
    open_core_pmu_event() before falling back to raw PMU configs, as
    spotted by Sashiko on v2:
    https://lore.kernel.org/linux-perf-users/c41f98313862f6545863598dcde871cfb80aba59.1795582691.git.irogers@google.com/
  - Loop over candidate configs in open_core_pmu_event() and iterate all
    core PMUs via perf_pmus__scan_core() in the hybrid and multiplexing
    subtests to support hybrid machines with >2 CPU types.
---
 tools/perf/tests/event-times.c | 550 ++++++++++++++++++++++++++++++++-
 tools/perf/util/affinity.c     | 100 ++++--
 tools/perf/util/affinity.h     |   5 +-
 3 files changed, 620 insertions(+), 35 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 56dd37ca760e..92246c110767 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -1,18 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bitmap.h>
 #include <linux/compiler.h>
+#include <linux/perf_event.h>
 #include <linux/string.h>
 #include <errno.h>
 #include <inttypes.h>
+#include <stdlib.h>
 #include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <internal/lib.h>
 #include <perf/cpumap.h>
+#include "cloexec.h"
 #include "tests.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "debug.h"
 #include "parse-events.h"
+#include "pmu.h"
+#include "pmus.h"
 #include "thread_map.h"
 #include "target.h"
+#include "util/affinity.h"
+#include "../perf-sys.h"
 
 static int attach__enable_on_exec(struct evlist *evlist)
 {
@@ -239,4 +252,539 @@ static int test__event_times(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
-DEFINE_SUITE("Event times", event_times);
+static int find_two_allowed_cpus(const struct affinity *aff, int *cpu0, int *cpu1)
+{
+	unsigned long c0, c1;
+
+	c0 = find_first_bit(aff->orig_cpus, aff->cpu_set_bits);
+	if (c0 >= aff->cpu_set_bits)
+		return -1;
+
+	c1 = find_next_bit(aff->orig_cpus, aff->cpu_set_bits, c0 + 1);
+	if (c1 >= aff->cpu_set_bits)
+		return -1;
+
+	*cpu0 = (int)c0;
+	*cpu1 = (int)c1;
+	return 0;
+}
+
+static int first_allowed_pmu_cpu(const struct affinity *aff,
+				 const struct perf_pmu *pmu)
+{
+	struct perf_cpu cpu;
+	unsigned int idx;
+
+	if (!pmu || !pmu->cpus || perf_cpu_map__is_empty(pmu->cpus)) {
+		unsigned long c = find_first_bit(aff->orig_cpus, aff->cpu_set_bits);
+
+		return c < aff->cpu_set_bits ? (int)c : -1;
+	}
+
+	perf_cpu_map__for_each_cpu(cpu, idx, pmu->cpus) {
+		if (affinity__has_cpu(aff, cpu.cpu))
+			return cpu.cpu;
+	}
+	return -1;
+}
+
+static uint64_t mono_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
+}
+
+static void burn_user_ms(unsigned int ms)
+{
+	uint64_t end = mono_ns() + (uint64_t)ms * 1000000ULL;
+
+	while (mono_ns() < end) {
+		for (int i = 0; i < 10000; i++)
+			asm volatile("" : "+r"(i) :: "memory");
+	}
+}
+
+struct read_times {
+	uint64_t val;
+	uint64_t ena;
+	uint64_t run;
+};
+
+static int read_times(int fd, struct read_times *rt)
+{
+	return read(fd, rt, sizeof(*rt)) == (ssize_t)sizeof(*rt) ? 0 : -1;
+}
+
+static int open_core_pmu_event(const struct perf_pmu *pmu, pid_t pid, int cpu,
+			       int group_fd, bool disabled)
+{
+	struct {
+		__u32 type;
+		__u64 config;
+	} candidates[3];
+	unsigned long flags = perf_event_open_cloexec_flag();
+	int nr_candidates = 0;
+
+	if (perf_pmus__num_core_pmus() <= 1) {
+		candidates[nr_candidates].type = PERF_TYPE_HARDWARE;
+		candidates[nr_candidates].config = PERF_COUNT_HW_CPU_CYCLES;
+		nr_candidates++;
+	} else if (perf_pmus__supports_extended_type()) {
+		candidates[nr_candidates].type = PERF_TYPE_HARDWARE;
+		candidates[nr_candidates].config =
+			((__u64)pmu->type << PERF_PMU_TYPE_SHIFT) |
+			PERF_COUNT_HW_CPU_CYCLES;
+		nr_candidates++;
+	}
+	candidates[nr_candidates].type = pmu->type;
+	candidates[nr_candidates].config = 0x3c;
+	nr_candidates++;
+	candidates[nr_candidates].type = pmu->type;
+	candidates[nr_candidates].config = 0;
+	nr_candidates++;
+
+	for (int i = 0; i < nr_candidates; i++) {
+		struct perf_event_attr attr = {
+			.type = candidates[i].type,
+			.size = sizeof(attr),
+			.config = candidates[i].config,
+			.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+				       PERF_FORMAT_TOTAL_TIME_RUNNING,
+			.disabled = disabled ? 1 : 0,
+			.exclude_kernel = 1,
+			.exclude_hv = 1,
+		};
+		int fd = sys_perf_event_open(&attr, pid, cpu, group_fd, flags);
+
+		if (fd >= 0)
+			return fd;
+	}
+	return -1;
+}
+
+/*
+ * Verify that an event opened on both a task and a specific CPU remains in
+ * PERF_EVENT_STATE_ON (accruing neither enabled nor running time) when enabled
+ * or scheduled on other CPUs, including across fork() inheritance.
+ */
+static int test__event_times_task_and_cpu(struct test_suite *test __maybe_unused,
+					  int subtest __maybe_unused)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_SOFTWARE,
+		.size = sizeof(attr),
+		.config = PERF_COUNT_SW_CPU_CLOCK,
+		.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+			       PERF_FORMAT_TOTAL_TIME_RUNNING,
+		.disabled = 1,
+		.inherit = 1,
+		.exclude_kernel = 1,
+		.exclude_hv = 1,
+	};
+	struct perf_event_mmap_page *up = MAP_FAILED;
+	struct read_times rt0, rt_before, rt_after, rt_child;
+	struct affinity aff = {};
+	int cpu0, cpu1, fd = -1, status = 0;
+	int ret = TEST_FAIL;
+	pid_t pid;
+
+	if (affinity__setup(&aff) < 0)
+		return TEST_SKIP;
+
+	if (find_two_allowed_cpus(&aff, &cpu0, &cpu1) < 0 ||
+	    affinity__set(&aff, cpu1) < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	fd = sys_perf_event_open(&attr, 0, cpu0, -1, perf_event_open_cloexec_flag());
+	if (fd < 0) {
+		ret = (errno == EACCES || errno == EPERM) ? TEST_SKIP : TEST_FAIL;
+		goto out;
+	}
+
+	up = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
+
+	/* Enable while running on non-matching cpu1: must stay in ON state. */
+	if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0) < 0)
+		goto out;
+
+	burn_user_ms(25);
+	if (read_times(fd, &rt0) < 0)
+		goto out;
+	if (rt0.ena != 0 || rt0.run != 0) {
+		pr_debug("FAILED: filtered CPU %d: ena=%" PRIu64 " run=%" PRIu64 "\n",
+			 cpu1, rt0.ena, rt0.run);
+		goto out;
+	}
+	if (up != MAP_FAILED && (up->time_enabled != 0 || up->time_running != 0)) {
+		pr_debug("FAILED: userpage accrued time while ON: ena=%llu run=%llu\n",
+			 (unsigned long long)up->time_enabled,
+			 (unsigned long long)up->time_running);
+		goto out;
+	}
+
+	/* Run on matching cpu0: enabled and running time must match. */
+	if (affinity__set(&aff, cpu0) < 0)
+		goto out;
+	burn_user_ms(25);
+	if (read_times(fd, &rt0) < 0 || rt0.run == 0 || rt0.ena != rt0.run) {
+		pr_debug("FAILED: mismatch on matching CPU %d: ena=%" PRIu64 " run=%" PRIu64 "\n",
+			 cpu0, rt0.ena, rt0.run);
+		goto out;
+	}
+
+	/* Migrate back to cpu1: neither enabled nor running time may advance. */
+	if (affinity__set(&aff, cpu1) < 0 || read_times(fd, &rt_before) < 0)
+		goto out;
+	burn_user_ms(25);
+	if (read_times(fd, &rt_after) < 0)
+		goto out;
+	if (rt_after.ena != rt_before.ena || rt_after.run != rt_before.run ||
+	    rt_after.ena != rt_after.run) {
+		pr_debug("FAILED: CPU %d: %" PRIu64 "/%" PRIu64 " -> %" PRIu64 "/%" PRIu64 "\n",
+			 cpu1, rt_before.ena, rt_before.run, rt_after.ena, rt_after.run);
+		goto out;
+	}
+
+	/* Verify inherited child event also stays in ON state on cpu1. */
+	pid = fork();
+	if (pid < 0)
+		goto out;
+	if (pid == 0) {
+		if (affinity__set(&aff, cpu0) < 0)
+			_exit(1);
+		burn_user_ms(20);
+		if (affinity__set(&aff, cpu1) < 0)
+			_exit(1);
+		burn_user_ms(20);
+		_exit(0);
+	}
+	if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		goto out;
+
+	if (read_times(fd, &rt_child) < 0 ||
+	    rt_child.run <= rt_after.run || rt_child.ena != rt_child.run) {
+		pr_debug("FAILED: inherited task+CPU mismatch: ena=%" PRIu64 " run=%" PRIu64 "\n",
+			 rt_child.ena, rt_child.run);
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	if (up != MAP_FAILED)
+		munmap(up, page_size);
+	if (fd >= 0)
+		close(fd);
+	affinity__cleanup(&aff);
+	return ret;
+}
+
+/*
+ * On hybrid / heterogeneous systems (>1 core PMU, including >2 CPU types),
+ * iterate all core PMUs and verify per-task events on each core PMU do not
+ * accrue enabled time while the task executes on CPUs belonging to any other
+ * core PMU.
+ */
+static int test__event_times_hybrid(struct test_suite *test __maybe_unused,
+				    int subtest __maybe_unused)
+{
+	struct hybrid_pmu_entry {
+		const struct perf_pmu *pmu;
+		int cpu;
+		int fd;
+	} *entries = NULL;
+	struct read_times *before = NULL, *after = NULL;
+	struct perf_pmu *pmu = NULL;
+	struct affinity aff = {};
+	int max_pmus = perf_pmus__num_core_pmus();
+	int nr_pmus = 0, checked_pairs = 0;
+	int ret = TEST_FAIL;
+
+	if (max_pmus <= 1)
+		return TEST_SKIP;
+
+	if (affinity__setup(&aff) < 0)
+		return TEST_SKIP;
+
+	entries = calloc(max_pmus, sizeof(*entries));
+	if (entries) {
+		for (int i = 0; i < max_pmus; i++)
+			entries[i].fd = -1;
+	}
+	before = calloc(max_pmus, sizeof(*before));
+	after = calloc(max_pmus, sizeof(*after));
+	if (!entries || !before || !after)
+		goto out;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL && nr_pmus < max_pmus) {
+		int c;
+
+		if (!pmu->cpus || perf_cpu_map__is_empty(pmu->cpus))
+			continue;
+		c = first_allowed_pmu_cpu(&aff, pmu);
+		if (c < 0)
+			continue;
+		entries[nr_pmus].pmu = pmu;
+		entries[nr_pmus].cpu = c;
+		nr_pmus++;
+	}
+
+	if (nr_pmus < 2 || affinity__set(&aff, entries[0].cpu) < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	for (int i = 0; i < nr_pmus; i++) {
+		entries[i].fd = open_core_pmu_event(entries[i].pmu, 0, -1, -1, true);
+		if (entries[i].fd < 0) {
+			ret = TEST_SKIP;
+			goto out;
+		}
+	}
+
+	for (int i = 0; i < nr_pmus; i++) {
+		if (ioctl(entries[i].fd, PERF_EVENT_IOC_ENABLE, 0) < 0)
+			goto out;
+	}
+
+	for (int i = 0; i < nr_pmus; i++) {
+		struct perf_cpu pc = { .cpu = entries[i].cpu };
+
+		if (affinity__set(&aff, entries[i].cpu) < 0)
+			goto out;
+
+		for (int j = 0; j < nr_pmus; j++) {
+			if (read_times(entries[j].fd, &before[j]) < 0)
+				goto out;
+		}
+
+		if (i == 0) {
+			for (int j = 1; j < nr_pmus; j++) {
+				if (!perf_cpu_map__has(entries[j].pmu->cpus, pc) &&
+				    (before[j].ena != 0 || before[j].run != 0)) {
+					pr_debug("FAILED: %s accrued time before running\n",
+						 entries[j].pmu->name);
+					goto out;
+				}
+			}
+		}
+
+		burn_user_ms(25);
+
+		for (int j = 0; j < nr_pmus; j++) {
+			if (read_times(entries[j].fd, &after[j]) < 0)
+				goto out;
+		}
+
+		if (after[i].ena <= before[i].ena) {
+			pr_debug("FAILED: %s accrued 0 time on CPU %d\n",
+				 entries[i].pmu->name, entries[i].cpu);
+			goto out;
+		}
+
+		for (int j = 0; j < nr_pmus; j++) {
+			if (j == i || perf_cpu_map__has(entries[j].pmu->cpus, pc))
+				continue;
+			checked_pairs++;
+			if (after[j].ena != before[j].ena ||
+			    after[j].run != before[j].run) {
+				pr_debug("FAILED: on %s CPU %d, %s ena %" PRIu64 "->%" PRIu64 "\n",
+					 entries[i].pmu->name, entries[i].cpu,
+					 entries[j].pmu->name, before[j].ena, after[j].ena);
+				goto out;
+			}
+		}
+	}
+
+	ret = checked_pairs > 0 ? TEST_OK : TEST_SKIP;
+out:
+	if (entries) {
+		for (int i = 0; i < nr_pmus; i++) {
+			if (entries[i].fd >= 0)
+				close(entries[i].fd);
+		}
+		free(entries);
+	}
+	free(before);
+	free(after);
+	affinity__cleanup(&aff);
+	return ret;
+}
+
+static int test_one_pmu_mux_migration(const struct perf_pmu *pmu,
+				      struct affinity *aff)
+{
+	enum { NR_FLEX = 12, NR_CHECK = 14 };
+	struct read_times before[NR_CHECK], after[NR_CHECK];
+	int flex_fds[NR_FLEX];
+	int leader_fd = -1, sib_fd = -1, dis_sib_fd = -1;
+	int cpu0 = -1, cpu1 = -1, ev_cpu = -1;
+	unsigned long c;
+	int ret = TEST_FAIL;
+
+	for (int i = 0; i < NR_FLEX; i++)
+		flex_fds[i] = -1;
+
+	cpu0 = first_allowed_pmu_cpu(aff, pmu);
+	if (cpu0 < 0)
+		return TEST_SKIP;
+
+	if (perf_pmus__num_core_pmus() > 1 && pmu->cpus &&
+	    !perf_cpu_map__is_empty(pmu->cpus)) {
+		for_each_set_bit(c, aff->orig_cpus, aff->cpu_set_bits) {
+			struct perf_cpu pc = { .cpu = (int)c };
+
+			if (!perf_cpu_map__has(pmu->cpus, pc)) {
+				cpu1 = (int)c;
+				break;
+			}
+		}
+		ev_cpu = -1;
+	} else {
+		for_each_set_bit(c, aff->orig_cpus, aff->cpu_set_bits) {
+			if ((int)c != cpu0) {
+				cpu1 = (int)c;
+				break;
+			}
+		}
+		ev_cpu = cpu0;
+	}
+
+	if (cpu1 < 0 || affinity__set(aff, cpu0) < 0)
+		return TEST_SKIP;
+
+	for (int i = 0; i < NR_FLEX; i++) {
+		flex_fds[i] = open_core_pmu_event(pmu, 0, ev_cpu, -1, false);
+		if (flex_fds[i] < 0) {
+			ret = TEST_SKIP;
+			goto out;
+		}
+	}
+
+	leader_fd = open_core_pmu_event(pmu, 0, ev_cpu, -1, false);
+	if (leader_fd < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+	sib_fd = open_core_pmu_event(pmu, 0, ev_cpu, leader_fd, false);
+	dis_sib_fd = open_core_pmu_event(pmu, 0, ev_cpu, leader_fd, true);
+	if (sib_fd < 0 || dis_sib_fd < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	if (ioctl(dis_sib_fd, PERF_EVENT_IOC_ENABLE, 0) < 0)
+		goto out;
+
+	burn_user_ms(30);
+
+	/* Detach leader while group may be INACTIVE to exercise sibling promotion. */
+	close(leader_fd);
+	leader_fd = -1;
+	burn_user_ms(10);
+
+	if (affinity__set(aff, cpu1) < 0)
+		goto out;
+
+	for (int i = 0; i < NR_FLEX; i++) {
+		if (read_times(flex_fds[i], &before[i]) < 0)
+			goto out;
+	}
+	if (read_times(sib_fd, &before[NR_FLEX]) < 0 ||
+	    read_times(dis_sib_fd, &before[NR_FLEX + 1]) < 0)
+		goto out;
+
+	burn_user_ms(20);
+
+	for (int i = 0; i < NR_FLEX; i++) {
+		if (read_times(flex_fds[i], &after[i]) < 0)
+			goto out;
+	}
+	if (read_times(sib_fd, &after[NR_FLEX]) < 0 ||
+	    read_times(dis_sib_fd, &after[NR_FLEX + 1]) < 0)
+		goto out;
+
+	for (int i = 0; i < NR_CHECK; i++) {
+		if (before[i].ena == 0) {
+			pr_debug("FAILED: %s event %d accrued 0 enabled time on CPU %d\n",
+				 pmu->name, i, cpu0);
+			goto out;
+		}
+		if (after[i].ena != before[i].ena || after[i].run != before[i].run) {
+			pr_debug("FAILED: %s event %d CPU %d: %" PRIu64 " -> %" PRIu64 "\n",
+				 pmu->name, i, cpu1, before[i].ena, after[i].ena);
+			goto out;
+		}
+	}
+
+	ret = TEST_OK;
+out:
+	for (int i = 0; i < NR_FLEX; i++) {
+		if (flex_fds[i] >= 0)
+			close(flex_fds[i]);
+	}
+	if (leader_fd >= 0)
+		close(leader_fd);
+	if (sib_fd >= 0)
+		close(sib_fd);
+	if (dis_sib_fd >= 0)
+		close(dis_sib_fd);
+	return ret;
+}
+
+/*
+ * Verify that flexible events and groups in PERF_EVENT_STATE_INACTIVE (on
+ * epc->flexible_inactive), including promoted group siblings after leader
+ * close, transition back to PERF_EVENT_STATE_ON on sched_out and do not accrue
+ * enabled time after migrating to a filtered-out CPU across all core PMUs.
+ */
+static int test__event_times_mux_migration(struct test_suite *test __maybe_unused,
+					   int subtest __maybe_unused)
+{
+	struct perf_pmu *pmu = NULL;
+	struct affinity aff = {};
+	int tested = 0;
+	int ret = TEST_SKIP;
+
+	if (affinity__setup(&aff) < 0)
+		return TEST_SKIP;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		int err = test_one_pmu_mux_migration(pmu, &aff);
+
+		if (err == TEST_FAIL) {
+			ret = TEST_FAIL;
+			goto out;
+		}
+		if (err == TEST_OK)
+			tested++;
+	}
+
+	if (tested > 0)
+		ret = TEST_OK;
+out:
+	affinity__cleanup(&aff);
+	return ret;
+}
+
+static struct test_case tests__event_times[] = {
+	TEST_CASE("Basic event times", event_times),
+	TEST_CASE_REASON("Task and CPU filtered event times",
+			 event_times_task_and_cpu,
+			 "permissions or <2 allowed CPUs"),
+	TEST_CASE_REASON("Hybrid PMU filtered event times",
+			 event_times_hybrid,
+			 "not hybrid or permissions"),
+	TEST_CASE_REASON("Multiplexed and group filtered event times",
+			 event_times_mux_migration,
+			 "no hardware PMU or <2 allowed CPUs"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__event_times = {
+	.desc = "Event times",
+	.test_cases = tests__event_times,
+};
diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
index 6c64b5f69a4e..e610eb959347 100644
--- a/tools/perf/util/affinity.c
+++ b/tools/perf/util/affinity.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Manage affinity to optimize IPIs inside the kernel perf API. */
 #define _GNU_SOURCE 1
+#include <errno.h>
 #include <sched.h>
 #include <stdlib.h>
 #include <linux/bitmap.h>
@@ -10,73 +11,98 @@
 #include "cpumap.h"
 #include "affinity.h"
 
-static int get_cpu_set_size(void)
+static size_t get_cpu_set_bits(void)
 {
-	int sz = cpu__max_cpu().cpu + 8 - 1;
+	int max_cpu = cpu__max_cpu().cpu;
+	size_t bits = max_cpu > 0 ? (size_t)max_cpu : 0;
+
 	/*
 	 * sched_getaffinity doesn't like masks smaller than the kernel.
-	 * Hopefully that's big enough.
+	 * Start at >= 4096 bits, aligned to BITS_PER_LONG so bitmap_zalloc()
+	 * matches the exact byte size passed to sched_{get,set}affinity().
 	 */
-	if (sz < 4096)
-		sz = 4096;
-	return sz / 8;
+	if (bits < 4096)
+		bits = 4096;
+	return BITS_TO_LONGS(bits) * BITS_PER_LONG;
 }
 
 int affinity__setup(struct affinity *a)
 {
-	int cpu_set_size = get_cpu_set_size();
+	size_t bits = get_cpu_set_bits();
 
-	a->orig_cpus = bitmap_zalloc(cpu_set_size * 8);
-	if (!a->orig_cpus)
-		return -1;
-	sched_getaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
-	a->sched_cpus = bitmap_zalloc(cpu_set_size * 8);
+	*a = (struct affinity){};
+	for (;;) {
+		unsigned long *orig = bitmap_zalloc(bits);
+
+		if (!orig)
+			return -1;
+		if (sched_getaffinity(0, bits / 8, (cpu_set_t *)orig) == 0) {
+			a->orig_cpus = orig;
+			break;
+		}
+		zfree(&orig);
+		if (errno != EINVAL || bits >= (1U << 20))
+			return -1;
+		bits <<= 1;
+	}
+
+	a->sched_cpus = bitmap_zalloc(bits);
 	if (!a->sched_cpus) {
 		zfree(&a->orig_cpus);
 		return -1;
 	}
-	bitmap_zero((unsigned long *)a->sched_cpus, cpu_set_size);
-	a->changed = false;
+	a->cpu_set_bits = bits;
 	return 0;
 }
 
+bool affinity__has_cpu(const struct affinity *a, int cpu)
+{
+	return a && a->orig_cpus && cpu >= 0 &&
+	       (size_t)cpu < a->cpu_set_bits && test_bit(cpu, a->orig_cpus);
+}
+
 /*
  * perf_event_open does an IPI internally to the target CPU.
  * It is more efficient to change perf's affinity to the target
  * CPU and then set up all events on that CPU, so we amortize
  * CPU communication.
  */
-void affinity__set(struct affinity *a, int cpu)
+int affinity__set(struct affinity *a, int cpu)
 {
-	int cpu_set_size = get_cpu_set_size();
+	int err;
 
 	/*
 	 * Return:
-	 * - if cpu is -1
+	 * - if cpu is < 0 (e.g. -1)
 	 * - restrict out of bound access to sched_cpus
 	 */
-	if (cpu == -1 || ((cpu >= (cpu_set_size * 8))))
-		return;
+	if (!a || !a->sched_cpus || cpu < 0 || (size_t)cpu >= a->cpu_set_bits)
+		return -1;
 
-	a->changed = true;
 	__set_bit(cpu, a->sched_cpus);
 	/*
-	 * We ignore errors because affinity is just an optimization.
-	 * This could happen for example with isolated CPUs or cpusets.
-	 * In this case the IPIs inside the kernel's perf API still work.
+	 * Callers such as evlist ignore errors because affinity is just an
+	 * optimization (for example with isolated CPUs or cpusets, where IPIs
+	 * inside the kernel's perf API still work), while tests may check the
+	 * return value.
 	 */
-	sched_setaffinity(0, cpu_set_size, (cpu_set_t *)a->sched_cpus);
+	err = sched_setaffinity(0, a->cpu_set_bits / 8, (cpu_set_t *)a->sched_cpus);
 	__clear_bit(cpu, a->sched_cpus);
+	if (err)
+		return -1;
+
+	a->changed = true;
+	return 0;
 }
 
 static void __affinity__cleanup(struct affinity *a)
 {
-	int cpu_set_size = get_cpu_set_size();
-
-	if (a->changed)
-		sched_setaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
+	if (a->changed && a->orig_cpus)
+		sched_setaffinity(0, a->cpu_set_bits / 8, (cpu_set_t *)a->orig_cpus);
 	zfree(&a->sched_cpus);
 	zfree(&a->orig_cpus);
+	a->cpu_set_bits = 0;
+	a->changed = false;
 }
 
 void affinity__cleanup(struct affinity *a)
@@ -87,17 +113,25 @@ void affinity__cleanup(struct affinity *a)
 
 void cpu_map__set_affinity(const struct perf_cpu_map *cpumap)
 {
-	int cpu_set_size = get_cpu_set_size();
-	unsigned long *cpuset = bitmap_zalloc(cpu_set_size * 8);
+	size_t bits = get_cpu_set_bits();
+	unsigned long *cpuset;
 	struct perf_cpu cpu;
 	unsigned int idx;
 
+	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, cpumap) {
+		if (cpu.cpu >= 0 && (size_t)cpu.cpu >= bits)
+			bits = BITS_TO_LONGS((size_t)cpu.cpu + 1) * BITS_PER_LONG;
+	}
+
+	cpuset = bitmap_zalloc(bits);
 	if (!cpuset)
 		return;
 
-	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, cpumap)
-		__set_bit(cpu.cpu, cpuset);
+	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, cpumap) {
+		if (cpu.cpu >= 0)
+			__set_bit(cpu.cpu, cpuset);
+	}
 
-	sched_setaffinity(0, cpu_set_size, (cpu_set_t *)cpuset);
+	sched_setaffinity(0, bits / 8, (cpu_set_t *)cpuset);
 	zfree(&cpuset);
 }
diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
index 7341194b2298..d21028e2465f 100644
--- a/tools/perf/util/affinity.h
+++ b/tools/perf/util/affinity.h
@@ -3,16 +3,19 @@
 #define PERF_AFFINITY_H 1
 
 #include <stdbool.h>
+#include <stddef.h>
 
 struct perf_cpu_map;
 struct affinity {
 	unsigned long *orig_cpus;
 	unsigned long *sched_cpus;
+	size_t cpu_set_bits;
 	bool changed;
 };
 
 void affinity__cleanup(struct affinity *a);
-void affinity__set(struct affinity *a, int cpu);
+bool affinity__has_cpu(const struct affinity *a, int cpu);
+int affinity__set(struct affinity *a, int cpu);
 int affinity__setup(struct affinity *a);
 void cpu_map__set_affinity(const struct perf_cpu_map *cpumap);
 
-- 
2.56.1.831.g720f3f5937-goog

