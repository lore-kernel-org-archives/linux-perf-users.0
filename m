Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1861423A99F;
	Tue,  8 Apr 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132584; cv=none; b=ZAB5zeWbW8+Jrlxi2aP2VYHzCQqD7Ah70GoY49WNY8MAEwgL+l2lxB9Ah5vMRxx/rrCNFg1IyBD+wxzwKweN2J5rjTRdc057q+nT4bYKi2mr8/v+Q3O4rW4G4kx30kjhsE8i+7qKNon7ZUlNYbXymk44GH7bWJqNLsKmA/aCjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132584; c=relaxed/simple;
	bh=HhiiV26Eyq2LUq6YKxY+qxDFYUBLI5AgAMAbAOeeP68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CIAcwAAAHm/bt3aIduSpZZoltpBhqYl6rOmbF6zhT5exoAt/Omu/zsKtU+2nrmmmUPb8ixxjFdmvy7SQE77ac+Dpmsi9GkmqkQBgvGe9V0zXhW3oGIe+rLquJ3pEJcdel83xRl6HitPakLtoelLDnclZBJ07tvREcV+VsBUoFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0062A1688;
	Tue,  8 Apr 2025 10:16:23 -0700 (PDT)
Received: from e128066.cambridge.arm.com (e128066.cambridge.arm.com [10.1.26.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7EA4F3F59E;
	Tue,  8 Apr 2025 10:16:18 -0700 (PDT)
From: mark.barnett@arm.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: ben.gainey@arm.com,
	deepak.surti@arm.com,
	ak@linux.intel.com,
	will@kernel.org,
	james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Barnett <mark.barnett@arm.com>
Subject: [PATCH v4 3/5] perf: Allow adding fixed random jitter to the sampling period
Date: Tue,  8 Apr 2025 18:15:28 +0100
Message-Id: <20250408171530.140858-4-mark.barnett@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408171530.140858-1-mark.barnett@arm.com>
References: <20250408171530.140858-1-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Gainey <ben.gainey@arm.com>

This change modifies the core perf overflow handler, adding some small
random jitter to each sample period when the high-frequency sample
period is in use. A new flag is added to perf_event_attr to opt into
this behaviour.

This change follows the discussion in [1], where it is recognized that it
may be possible for certain patterns of execution to end up with biased
results.

[1] https://lore.kernel.org/linux-perf-users/Zc24eLqZycmIg3d2@tassilo/

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
Signed-off-by: Mark Barnett <mark.barnett@arm.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index be006965054e..78a6fd14b412 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -233,6 +233,7 @@ struct hw_perf_event {
 
 #define PERF_SPS_HF_ON			0x00000001
 #define PERF_SPS_HF_SAMPLE		0x00000002
+#define PERF_SPS_HF_RAND		0x00000004
 	u32				sample_period_state;
 
 	/*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5752ac7408b1..bc6991a33048 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -56,6 +56,7 @@
 #include <linux/buildid.h>
 #include <linux/task_work.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/prandom.h>
 
 #include "internal.h"
 
@@ -472,6 +473,8 @@ static int perf_sample_period_ns __read_mostly	= DEFAULT_SAMPLE_PERIOD_NS;
 static int perf_sample_allowed_ns __read_mostly =
 	DEFAULT_SAMPLE_PERIOD_NS * DEFAULT_CPU_TIME_MAX_PERCENT / 100;
 
+static DEFINE_PER_CPU(struct rnd_state, sample_period_jitter_rnd);
+
 static void update_perf_cpu_limits(void)
 {
 	u64 tmp = perf_sample_period_ns;
@@ -10224,6 +10227,19 @@ static int __perf_event_overflow(struct perf_event *event,
 	 *
 	 * By ignoring the HF samples, we measure the actual period.
 	 */
+
+	/*
+	 * Apply optional jitter to the overall sample period
+	 */
+	if (hwc->sample_period_state & PERF_SPS_HF_RAND
+			&& !(hwc->sample_period_state & PERF_SPS_HF_SAMPLE)) {
+		struct rnd_state *state = &get_cpu_var(sample_period_jitter_rnd);
+		u64 rand_period = 1 << event->attr.hf_sample_rand;
+
+		sample_period -= rand_period / 2;
+		sample_period += prandom_u32_state(state) & (rand_period - 1);
+	}
+
 	if (hwc->sample_period_state & PERF_SPS_HF_ON) {
 		u64 hf_sample_period = event->attr.hf_sample_period;
 
@@ -12756,6 +12772,14 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (attr->hf_sample_period)
 		hwc->sample_period_state |= PERF_SPS_HF_ON;
 
+	if (attr->hf_sample_rand) {
+		/* high-frequency jitter is only valid with a high-freq period */
+		if (!attr->hf_sample_period)
+			return ERR_PTR(-EINVAL);
+
+		hwc->sample_period_state |= PERF_SPS_HF_RAND;
+	}
+
 	/*
 	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
 	 * events (they don't make sense as the cgroup will be different
@@ -14367,6 +14391,7 @@ static void __init perf_event_init_all_cpus(void)
 	zalloc_cpumask_var(&perf_online_pkg_mask, GFP_KERNEL);
 	zalloc_cpumask_var(&perf_online_sys_mask, GFP_KERNEL);
 
+	prandom_seed_full_state(&sample_period_jitter_rnd);
 
 	for_each_possible_cpu(cpu) {
 		swhash = &per_cpu(swevent_htable, cpu);
@@ -14384,6 +14409,7 @@ static void __init perf_event_init_all_cpus(void)
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 		cpuctx->heap_size = ARRAY_SIZE(cpuctx->heap_default);
 		cpuctx->heap = cpuctx->heap_default;
+
 	}
 }
 
-- 
2.43.0

