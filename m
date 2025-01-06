Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F96088F;
	Mon,  6 Jan 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164951; cv=none; b=d3ANAvaw56hiEKJTmskEb2gJApPtHYoMcE7PhrTSGIZgIt3Ig577PYjJZf5qR6T7VHRdm9qDkd/Nw0RbvAsIvPwRkGKjajoYB+8l5+8oYksxObLXYZe4DtJTiwFsi+Yep3VjwERjeGB14c+WdCyD29z+k9AMenVPtkbBc3f0epA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164951; c=relaxed/simple;
	bh=UM6582/aEwucZspCyFUMRY9WesEXLdSRNsOYAXasNLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqZcpnv5eBs66Dtt00Onor6MCNBvWAjOUavB+AU8fv90O/OX9xBmfpjztmy9iiDKnjDS0TKCnckRI3SlSJSbOlhn3MhEjDW9ERIgrBpV3anag/PlAsRTeZCAd3BzzPR62iWbfChhbTjeSHEK2mwszdQWvoN/63h19r79tyfb9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B5691AC1;
	Mon,  6 Jan 2025 04:02:57 -0800 (PST)
Received: from e128066.arm.com (unknown [10.57.93.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF2EC3F673;
	Mon,  6 Jan 2025 04:02:24 -0800 (PST)
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
Subject: [PATCH v2 1/5] perf: Allow periodic events to alternate between two sample periods
Date: Mon,  6 Jan 2025 12:01:52 +0000
Message-Id: <20250106120156.227273-2-mark.barnett@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250106120156.227273-1-mark.barnett@arm.com>
References: <20250106120156.227273-1-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Gainey <ben.gainey@arm.com>

This change modifies perf_event_attr to add a second, alternative
sample period field, and modifies the core perf overflow handling
such that when specified an event will alternate between two sample
periods.

Currently, perf does not provide a  mechanism for decoupling the period
over which counters are counted from the period between samples. This is
problematic for building a tool to measure per-function metrics derived
from a sampled counter group. Ideally such a tool wants a very small
sample window in order to correctly attribute the metrics to a given
function, but prefers a larger sample period that provides representative
coverage without excessive probe effect, triggering throttling, or
generating excessive amounts of data.

By alternating between a long and short sample_period and subsequently
discarding the long samples, tools may decouple the period between
samples that the tool cares about from the window of time over which
interesting counts are collected.

It is expected that typically tools would use this feature with the
cycles or instructions events as an approximation for time, but no
restrictions are applied to which events this can be applied to.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
Signed-off-by: Mark Barnett <mark.barnett@arm.com>
---
 include/linux/perf_event.h      |  5 +++++
 include/uapi/linux/perf_event.h |  3 +++
 kernel/events/core.c            | 37 ++++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index cb99ec8c9e96..cbb332f4e19c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -276,6 +276,11 @@ struct hw_perf_event {
 	 */
 	u64				freq_time_stamp;
 	u64				freq_count_stamp;
+
+	/*
+	 * Indicates that the alternative sample period is used
+	 */
+	bool				using_alt_sample_period;
 #endif
 };
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 0524d541d4e3..499a8673df8e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -379,6 +379,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	144	/* add: alt_sample_period */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -531,6 +532,8 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	__u64	alt_sample_period;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..7e339d12363a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4178,6 +4178,8 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	s64 period, sample_period;
 	s64 delta;
 
+	WARN_ON_ONCE(hwc->using_alt_sample_period);
+
 	period = perf_calculate_period(event, nsec, count);
 
 	delta = (s64)(period - hwc->sample_period);
@@ -9850,6 +9852,7 @@ static int __perf_event_overflow(struct perf_event *event,
 				 int throttle, struct perf_sample_data *data,
 				 struct pt_regs *regs)
 {
+	struct hw_perf_event *hwc = &event->hw;
 	int events = atomic_read(&event->event_limit);
 	int ret = 0;
 
@@ -9869,6 +9872,18 @@ static int __perf_event_overflow(struct perf_event *event,
 	    !bpf_overflow_handler(event, data, regs))
 		goto out;
 
+	/*
+	 * Swap the sample period to the alternative period
+	 */
+	if (event->attr.alt_sample_period) {
+		bool using_alt = hwc->using_alt_sample_period;
+		u64 sample_period = (using_alt ? event->attr.sample_period
+					       : event->attr.alt_sample_period);
+
+		hwc->sample_period = sample_period;
+		hwc->using_alt_sample_period = !using_alt;
+	}
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -12291,9 +12306,19 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (attr->freq && attr->sample_freq)
 		hwc->sample_period = 1;
 	hwc->last_period = hwc->sample_period;
-
 	local64_set(&hwc->period_left, hwc->sample_period);
 
+	if (attr->alt_sample_period) {
+		hwc->sample_period = attr->alt_sample_period;
+		hwc->using_alt_sample_period = true;
+	}
+
+	/*
+	 * alt_sample_period cannot be used with freq
+	 */
+	if (attr->freq && attr->alt_sample_period)
+		goto err_ns;
+
 	/*
 	 * We do not support PERF_SAMPLE_READ on inherited events unless
 	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
@@ -12763,9 +12788,19 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (attr.freq) {
 		if (attr.sample_freq > sysctl_perf_event_sample_rate)
 			return -EINVAL;
+		if (attr.alt_sample_period)
+			return -EINVAL;
 	} else {
 		if (attr.sample_period & (1ULL << 63))
 			return -EINVAL;
+		if (attr.alt_sample_period) {
+			if (!attr.sample_period)
+				return -EINVAL;
+			if (attr.alt_sample_period & (1ULL << 63))
+				return -EINVAL;
+			if (attr.alt_sample_period == attr.sample_period)
+				attr.alt_sample_period = 0;
+		}
 	}
 
 	/* Only privileged users can get physical addresses */
-- 
2.43.0

