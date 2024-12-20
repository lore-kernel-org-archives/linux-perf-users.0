Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F04217F44;
	Fri, 20 Dec 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705501; cv=none; b=e2tP0L1H/BOQmgT0k8/7WQ+Iw8h0/UD8LpMvd9dBRRMEd6GrkTW+WEhU3ryTwqlkM87GB49giPsVAI+ttB2mEAL0PIRl5Z0Lc+003KSnBM+9//cYafq+wPr82UUeW4kqS1xcvpoSJ6VRyI5zmjmzusNG8NeVPaOtu/ubku7FezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705501; c=relaxed/simple;
	bh=0y6WWVL96ac+PBFoT5j6qVsv9B6l3I1sOS3N2yeWU8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVLwomliGlBCk5n9auS3EOvnTz6UIi67G1UOQf+lUWagN82eUH+MNOGCZBXjXXtylkRKju0NzTlBxO3uKs1eULxSAVbq6uDv0Og13CVOx2rGJEEjnuoZoklW4UpTmcXvzb5rgEqH8kuYS+jR8vbuV0Ma62Q0MSmelvjbteVG/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5O9pdb4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5O9pdb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734705499; x=1766241499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0y6WWVL96ac+PBFoT5j6qVsv9B6l3I1sOS3N2yeWU8c=;
  b=C5O9pdb44j1rmuVedGnFELfCOUy9f1PJhNzufORhnb29fM7TmPRCW/pz
   RErrImsUoPluE0JWRT0Wuz3zZsjRmfLchydktyeyNamEBDz1hE7os1mYL
   Cm1wNX4Rdq7OtAQvWZkpBF6ebXY6CKbWCScXEujg6JfzWF45/5a7jaUdK
   rmojpx2QhDnKsjWucm0fPYsY4OW7WZbTEWUWGMHoO5doF4vuafmGFr/ua
   IV3r2K64ABwYTqiMpuW7IA5tnNUZirQJ1CtTHgg2Db6p+eQ/su+SRPVkw
   djvJacHMBxAPxtY2CxcJMyYrKdkkCB0Ve/I0+qMR+t88D9nd4FizqsLJR
   g==;
X-CSE-ConnectionGUID: RNMNsTRERbe4bCw07rRQjA==
X-CSE-MsgGUID: MLx7VvzZReyU71uY9/FGTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="38095661"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="38095661"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 06:38:17 -0800
X-CSE-ConnectionGUID: MU55N1ccT5awO+q0KRISwQ==
X-CSE-MsgGUID: LoKNmrSWRbCDZTi1HbomVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102650348"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 06:38:16 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 2/3] perf: Avoid the read if the count is already updated
Date: Fri, 20 Dec 2024 06:38:54 -0800
Message-Id: <20241220143855.1082718-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241220143855.1082718-1-kan.liang@linux.intel.com>
References: <20241220143855.1082718-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

The event may have been updated in the PMU-specific implementation,
e.g., Intel PEBS counters snapshotting. The common code should not
read and overwrite the value.

The PERF_SAMPLE_READ in the data->sample_type can be used to detect
whether the PMU-specific value is available. If yes, avoid the
pmu->read() in the common code. Add a new flag, skip_read, to track the
case.

Factor out a perf_pmu_read() to clean up the code.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

New patch from Peter Zijlstra.
- Use a flag to avoid the read.

 include/linux/perf_event.h  |  8 +++++++-
 kernel/events/core.c        | 33 ++++++++++++++++-----------------
 kernel/events/ring_buffer.c |  1 +
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 08445b149c2a..0e65afcf5295 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1062,7 +1062,13 @@ struct perf_output_handle {
 	struct perf_buffer		*rb;
 	unsigned long			wakeup;
 	unsigned long			size;
-	u64				aux_flags;
+	union {
+		u64			flags;		/* perf_output*() */
+		u64			aux_flags;	/* perf_aux_output*() */
+		struct {
+			u64		skip_read : 1;
+		};
+	};
 	union {
 		void			*addr;
 		unsigned long		head;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 684d631e78da..d717a7539b51 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1195,6 +1195,12 @@ static void perf_assert_pmu_disabled(struct pmu *pmu)
 	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
 }
 
+static inline void perf_pmu_read(struct perf_event *event)
+{
+	if (event->state == PERF_EVENT_STATE_ACTIVE)
+		event->pmu->read(event);
+}
+
 static void get_ctx(struct perf_event_context *ctx)
 {
 	refcount_inc(&ctx->refcount);
@@ -3477,8 +3483,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	perf_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -4629,15 +4634,8 @@ static void __perf_event_read(void *info)
 
 	pmu->read(event);
 
-	for_each_sibling_event(sub, event) {
-		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
-			/*
-			 * Use sibling's PMU rather than @event's since
-			 * sibling could be on different (eg: software) PMU.
-			 */
-			sub->pmu->read(sub);
-		}
-	}
+	for_each_sibling_event(sub, event)
+		perf_pmu_read(sub);
 
 	data->ret = pmu->commit_txn(pmu);
 
@@ -7445,9 +7443,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	if ((leader != event) && !handle->skip_read)
+		perf_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader, self);
 	if (read_format & PERF_FORMAT_ID)
@@ -7460,9 +7457,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		if ((sub != event) && !handle->skip_read)
+			perf_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub, self);
 		if (read_format & PERF_FORMAT_ID)
@@ -7521,6 +7517,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 {
 	u64 sample_type = data->type;
 
+	if (data->sample_flags & PERF_SAMPLE_READ)
+		handle->skip_read = 1;
+
 	perf_output_put(handle, *header);
 
 	if (sample_type & PERF_SAMPLE_IDENTIFIER)
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 180509132d4b..59a52b1a1f78 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -185,6 +185,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	handle->rb    = rb;
 	handle->event = event;
+	handle->flags = 0;
 
 	have_lost = local_read(&rb->lost);
 	if (unlikely(have_lost)) {
-- 
2.38.1

