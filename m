Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582847;
	b=0mihs6JaoHqVPelchY56wL2hZFBgBxAOGuU/xfFj4GRIOF8H5wVaf4GGKH0lQaVag4bP
	 wkwbrg1GWj1BgyPtYGNg00qvGOQvaerpDgX8I7xCICMNVkBGvKUXjEm3Vkm1CAgct7HCC
	 OHXOxYsRkV8YNek/YceNyqSkWaNCEAFLQxzCbaZw1AGpP24V8ZuZEHuF8MGirlhQpv8JW
	 oTsqrdspXEhCjSL1jJ7/Scyp+aDk4UsyGA25W5uJS7MFBjvWJ97s22cZyGvDODlA1MVlK
	 LkxCCKDFGqqb7nLCutXDzfWSJzo5g0WzTNMCzoogBETcXLyEJWwLEVe4TTDGpbACPCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=o2n9zXpemfaapcRpR3NS7kpIdbxR/8EYIps0VmkExD4=;
	b=5jvoW3izfX/VHHdWq5JeUwzLux82pgrMWMAdsTpOgxY/M4VL1fqC9l8YdvWNO+xCDvLk
	 hoeGS/CY4c1tlKtCQPekdthOYYsfq4tGZefm3sgJtmus4onLS2kHycmrnF+vu7lk+HiNU
	 JAjmVgJVos+1WcHI9lf0Ps2Gu2/sEJC8cZqb25q07NpVcmIRjaDFBpQdIP9CPVb6/jGLd
	 i0T3MAGHy/5bHCnBOsPt4a1QYw9Lxsg31pvA16r4qHuPK14HO9n7FxvuQ06GRq8J+esdr
	 mCRSs7FP1NYAcn8/73XYnu+fujAHv7wJujpF/v+tivE2uQzpunPCddKy+YBDOEVJFQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Kj8rGICG;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB714606A32D
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 05:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB714606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Kj8rGICG
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so8323978eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 21:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795582846; x=1796187646; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2n9zXpemfaapcRpR3NS7kpIdbxR/8EYIps0VmkExD4=;
        b=Kj8rGICGMCYtUqY6VO/vZhHB9PHGm3p/3FG/kFNXN6v4uziuJ0ZyXiStvM7kVBlsuR
         WGoQb4r5HG5JddBUeSxSHSeN06g0TOH8+fTT+Am76O/G7HKz+quILgtLvc3ufXmeSRxq
         kW/T6BzFDRyWd1a60PL1q4CgeTDRbxHVaRZuZ6VIR91bKQbxH/Ohklw7xcQDNrkNrqGK
         BbMhBcQ0kvsSwE394jAfO4FVEetDNh7EQngF999B+dS0g95VKb3v8/MczYOqp3gD8Rcz
         sby2X00YDf1Kuf7Vi/K0x8YeKNqS9MTYF/2Wp4xL5gdLDUUvHkXj8Za242rm0HwgIk6S
         w0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582846; x=1796187646;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2n9zXpemfaapcRpR3NS7kpIdbxR/8EYIps0VmkExD4=;
        b=m7wjV6hbULv8PDbXErpfTyBBdMFWeLkt5VCiV3900X2pNVE4FDgFIFsx5MOKCj7/ET
         pM9ZFtiO0XiUE7iwIqp3Haxfnw5sFNQ0B2kTkXQzmA0ukvr/GlwrYwhcQzHzmUS4YanY
         mo9LtHqkzQPJkZ8sX6xZrEW2OhVn+s9iet8ES0LxspKEcpWQkkgrLn5XS+8Paej+th2m
         UHcmyp3OUBhftZRlMd7PEAaKgGiaufjnL6N+bVCfwJiNEYv6O/eCGDLFcjsq5Yg83YyT
         ogJs/ox3a8m6fcqhJXf538xXJWkpTleoLlJsfwScuF0l3OT9oQk7uixfK3MK0VqpFCnN
         pmBw==
X-Forwarded-Encrypted: i=1; AL+hErFUWW4YlABzBdHx4+k/ne4K5MbuVJa6MnWQ+GSIxVL6cLTAdfnEwZQIlPZCUk3sJX391rYMXIHy9Hwjx519yah7@vger.kernel.org
X-Gm-Message-State: APuU4Z8E3MMcbA1iUiS0qNP8BBfVgvgPtX/WEXJIHvvgaPmC5Dy74f2W
	TBrWlgvK0NaOeYzl4oBEIkTr13TYfZhtyaaFnap46L1wkoOpUpTYPE/n4/kZ6bcXCsGSlibVRyT
	GlvPSE+VeYA==
X-Received: from dycnm7.prod.google.com ([2002:a05:7300:d187:b0:383:6d6a:6b7a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1505:b0:384:df31:6a07
 with SMTP id 5a478bee46e88-386a87efea0mr9725433eec.30.1795582845289; Tue, 24
 Nov 2026 21:00:45 -0800 (PST)
Date: Tue, 24 Nov 2026 21:00:40 -0800
In-Reply-To: <80d983c5713537f5743b69e9b35ced1177e4732e.1795582691.git.irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <80d983c5713537f5743b69e9b35ced1177e4732e.1795582691.git.irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <c41f98313862f6545863598dcde871cfb80aba59.1795582691.git.irogers@google.com>
Subject: [PATCH v2 2/2] perf test: Add filtered event enabled time tests to event-times
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
- Hybrid PMU filtered event times: on systems with multiple core PMUs,
  verify per-task core PMU events accrue zero enabled time while running
  on CPUs belonging to another core PMU.
- Multiplexed and group filtered event times: verify flexible events and
  groups in PERF_EVENT_STATE_INACTIVE (including siblings promoted to
  group leader on leader close) transition back to PERF_EVENT_STATE_ON
  on context switch and accrue zero enabled time after migrating to a
  filtered-out CPU.

Reuse struct affinity from tools/perf/util/affinity.{c,h}, hardening
affinity__setup() to retry on EINVAL for large kernel cpumasks, adding
affinity__has_cpu(), and returning an error status from affinity__set().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event-times.c | 485 ++++++++++++++++++++++++++++++++-
 tools/perf/util/affinity.c     | 100 ++++---
 tools/perf/util/affinity.h     |   5 +-
 3 files changed, 555 insertions(+), 35 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 56dd37ca760e..4c265f791852 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -1,18 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bitmap.h>
 #include <linux/compiler.h>
+#include <linux/perf_event.h>
 #include <linux/string.h>
 #include <errno.h>
 #include <inttypes.h>
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
@@ -239,4 +251,475 @@ static int test__event_times(struct test_suite *test __maybe_unused, int subtest
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
+	struct perf_event_attr attr = {
+		.size = sizeof(attr),
+		.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+			       PERF_FORMAT_TOTAL_TIME_RUNNING,
+		.disabled = disabled ? 1 : 0,
+		.exclude_kernel = 1,
+		.exclude_hv = 1,
+	};
+	unsigned long flags = perf_event_open_cloexec_flag();
+	int fd;
+
+	if (!pmu) {
+		attr.type = PERF_TYPE_HARDWARE;
+		attr.config = PERF_COUNT_HW_CPU_CYCLES;
+		return sys_perf_event_open(&attr, pid, cpu, group_fd, flags);
+	}
+
+	if (perf_pmus__supports_extended_type()) {
+		attr.type = PERF_TYPE_HARDWARE;
+		attr.config = ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT) |
+			      PERF_COUNT_HW_CPU_CYCLES;
+		fd = sys_perf_event_open(&attr, pid, cpu, group_fd, flags);
+		if (fd >= 0)
+			return fd;
+	}
+
+	attr.type = pmu->type;
+	attr.config = 0x3c;
+	fd = sys_perf_event_open(&attr, pid, cpu, group_fd, flags);
+	if (fd >= 0)
+		return fd;
+
+	attr.config = 0;
+	return sys_perf_event_open(&attr, pid, cpu, group_fd, flags);
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
+ * On hybrid / heterogeneous systems (>1 core PMU), verify per-task events on
+ * one core PMU do not accrue enabled time while the task executes on CPUs
+ * belonging to a different core PMU.
+ */
+static int test__event_times_hybrid(struct test_suite *test __maybe_unused,
+				    int subtest __maybe_unused)
+{
+	const struct perf_pmu *pmu = NULL, *pmu0 = NULL, *pmu1 = NULL;
+	struct read_times rt0, rt1, rt0_before, rt0_after;
+	struct affinity aff = {};
+	int cpu0 = -1, cpu1 = -1, fd0 = -1, fd1 = -1;
+	int ret = TEST_FAIL;
+
+	if (perf_pmus__num_core_pmus() <= 1)
+		return TEST_SKIP;
+
+	if (affinity__setup(&aff) < 0)
+		return TEST_SKIP;
+
+	while ((pmu = perf_pmus__scan_core((struct perf_pmu *)pmu)) != NULL) {
+		int c = first_allowed_pmu_cpu(&aff, pmu);
+		struct perf_cpu pc, pc0;
+
+		if (c < 0)
+			continue;
+		if (!pmu0) {
+			pmu0 = pmu;
+			cpu0 = c;
+			continue;
+		}
+		pc.cpu = c;
+		pc0.cpu = cpu0;
+		if (!perf_cpu_map__has(pmu0->cpus, pc) &&
+		    !perf_cpu_map__has(pmu->cpus, pc0)) {
+			pmu1 = pmu;
+			cpu1 = c;
+			break;
+		}
+	}
+
+	if (!pmu0 || !pmu1 || affinity__set(&aff, cpu0) < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	fd0 = open_core_pmu_event(pmu0, 0, -1, -1, true);
+	fd1 = open_core_pmu_event(pmu1, 0, -1, -1, true);
+	if (fd0 < 0 || fd1 < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	if (ioctl(fd0, PERF_EVENT_IOC_ENABLE, 0) < 0 ||
+	    ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0) < 0)
+		goto out;
+
+	burn_user_ms(30);
+	if (read_times(fd0, &rt0) < 0 || read_times(fd1, &rt1) < 0)
+		goto out;
+
+	if (rt0.ena == 0 || rt1.ena != 0 || rt1.run != 0) {
+		pr_debug("FAILED: on %s CPU %d: %s ena=%" PRIu64 " run=%" PRIu64
+			 ", %s ena=%" PRIu64 " run=%" PRIu64 "\n",
+			 pmu0->name, cpu0, pmu0->name, rt0.ena, rt0.run,
+			 pmu1->name, rt1.ena, rt1.run);
+		goto out;
+	}
+
+	if (affinity__set(&aff, cpu1) < 0 || read_times(fd0, &rt0_before) < 0)
+		goto out;
+
+	burn_user_ms(30);
+	if (read_times(fd0, &rt0_after) < 0 || read_times(fd1, &rt1) < 0)
+		goto out;
+
+	if (rt0_after.ena != rt0_before.ena || rt0_after.run != rt0_before.run ||
+	    rt1.ena == 0) {
+		pr_debug("FAILED: on %s CPU %d: %s ena %" PRIu64 "->%" PRIu64
+			 ", %s ena=%" PRIu64 "\n",
+			 pmu1->name, cpu1, pmu0->name, rt0_before.ena, rt0_after.ena,
+			 pmu1->name, rt1.ena);
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	if (fd0 >= 0)
+		close(fd0);
+	if (fd1 >= 0)
+		close(fd1);
+	affinity__cleanup(&aff);
+	return ret;
+}
+
+/*
+ * Verify that flexible events and groups in PERF_EVENT_STATE_INACTIVE (on
+ * epc->flexible_inactive), including promoted group siblings after leader
+ * close, transition back to PERF_EVENT_STATE_ON on sched_out and do not accrue
+ * enabled time after migrating to a filtered-out CPU.
+ */
+static int test__event_times_mux_migration(struct test_suite *test __maybe_unused,
+					   int subtest __maybe_unused)
+{
+	enum { NR_FLEX = 12, NR_CHECK = 14 };
+	const struct perf_pmu *pmu0 = perf_pmus__scan_core(NULL);
+	struct read_times before[NR_CHECK], after[NR_CHECK];
+	struct affinity aff = {};
+	int flex_fds[NR_FLEX];
+	int leader_fd = -1, sib_fd = -1, dis_sib_fd = -1;
+	int cpu0 = -1, cpu1 = -1, ev_cpu = -1;
+	unsigned long c;
+	int ret = TEST_FAIL;
+
+	for (int i = 0; i < NR_FLEX; i++)
+		flex_fds[i] = -1;
+
+	if (!pmu0 || affinity__setup(&aff) < 0)
+		return TEST_SKIP;
+
+	cpu0 = first_allowed_pmu_cpu(&aff, pmu0);
+	if (cpu0 < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	if (perf_pmus__num_core_pmus() > 1 && pmu0->cpus &&
+	    !perf_cpu_map__is_empty(pmu0->cpus)) {
+		for_each_set_bit(c, aff.orig_cpus, aff.cpu_set_bits) {
+			struct perf_cpu pc = { .cpu = (int)c };
+
+			if (!perf_cpu_map__has(pmu0->cpus, pc)) {
+				cpu1 = (int)c;
+				break;
+			}
+		}
+		ev_cpu = -1;
+	} else {
+		for_each_set_bit(c, aff.orig_cpus, aff.cpu_set_bits) {
+			if ((int)c != cpu0) {
+				cpu1 = (int)c;
+				break;
+			}
+		}
+		ev_cpu = cpu0;
+	}
+
+	if (cpu1 < 0 || affinity__set(&aff, cpu0) < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	for (int i = 0; i < NR_FLEX; i++) {
+		flex_fds[i] = open_core_pmu_event(pmu0, 0, ev_cpu, -1, false);
+		if (flex_fds[i] < 0) {
+			ret = TEST_SKIP;
+			goto out;
+		}
+	}
+
+	leader_fd = open_core_pmu_event(pmu0, 0, ev_cpu, -1, false);
+	if (leader_fd < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+	sib_fd = open_core_pmu_event(pmu0, 0, ev_cpu, leader_fd, false);
+	dis_sib_fd = open_core_pmu_event(pmu0, 0, ev_cpu, leader_fd, true);
+	if (sib_fd < 0 || dis_sib_fd < 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	if (ioctl(dis_sib_fd, PERF_EVENT_IOC_ENABLE, 0) < 0)
+		goto out;
+
+	burn_user_ms(50);
+
+	/* Detach leader while group may be INACTIVE to exercise sibling promotion. */
+	close(leader_fd);
+	leader_fd = -1;
+	burn_user_ms(10);
+
+	if (affinity__set(&aff, cpu1) < 0)
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
+	burn_user_ms(30);
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
+			pr_debug("FAILED: event %d accrued 0 enabled time on matching CPU %d\n",
+				 i, cpu0);
+			goto out;
+		}
+		if (after[i].ena != before[i].ena || after[i].run != before[i].run) {
+			pr_debug("FAILED: event %d filtered CPU %d: %" PRIu64 " -> %" PRIu64 "\n",
+				 i, cpu1, before[i].ena, after[i].ena);
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

