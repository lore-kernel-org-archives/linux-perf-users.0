Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F41F4710;
	Tue, 21 Jan 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472964; cv=none; b=TLkDUKZK+LcYaOxRVw0osYZdADcdjhWGs52xXWcMPDwoKDqsIvoPOTKY7H+1N/2P8oy0lqRyADeCwtm9iBOZ2xcdwNnS7wzxgbyq9Er3CQjIiSTI0KmddtWZZow1OOZx2MAAXrpwDSZad71nrYTjD0XTh2HKaZNrcn6R4ol50Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472964; c=relaxed/simple;
	bh=RQ/ab6SNH5kv9/xM3b/eFmsq5/ZGi1LUXmlPZVYyuDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adpafCUFzlIDCZ/pW+U6ypO9ljSQyJlFgI+sPtbz4GpfFeAgUKTXRImasrcWlkKa5+b1VeUM6u7hWSiqFa9ciSr89Xe6LSbJk50rHgCyrreq2gs5IQo2UGsvyWQ4INa3v1KkWf8BrUgJo7eVmOfM8yOoSOOFt8sLZXZ9zEOYdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EeljIlBs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EeljIlBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737472962; x=1769008962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RQ/ab6SNH5kv9/xM3b/eFmsq5/ZGi1LUXmlPZVYyuDo=;
  b=EeljIlBsemr0TCa62p8Q+K6FpyI/DPzg4JxWRj9Vo1wlg6XG3FDH4309
   Qn9vYOc6Y0GB0CsL2m/dXCxKTiJ57rWLLj0Xa/5kua39+S8hoN/JX194H
   y0LAoYJ6qZKtQIHvIIBDJWy4ZjgYl/UyaAw190ESrBIlLNFbpxUv1q0pq
   q+G3PsD6BOxltffY34cLLWZRyRgp6b6mkrGHyGP46zQ4IQlU9zVsqzQM6
   P2LezqAD1vac1Trfsm35SYBzKdn4k60fzTvGpN1qxy+slKGUiJjJcdJDN
   HQWloHXb6ML6nQIKhyh2q2phBeeruB/0+6BtGWzW7ofN8G+GrbXBdzJiF
   Q==;
X-CSE-ConnectionGUID: YemJuuhORlKMtxJHom+WRQ==
X-CSE-MsgGUID: sL0FKfD6Qra+m/kta70Dzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37161462"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="37161462"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:22:38 -0800
X-CSE-ConnectionGUID: BbbBldBNRkCLNMoCuZJGYA==
X-CSE-MsgGUID: PNdDRjGiQrGNrFKV2fm/bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111925747"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 21 Jan 2025 07:22:38 -0800
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
Subject: [PATCH V10 3/4] perf: Avoid the read if the count is already updated
Date: Tue, 21 Jan 2025 07:23:02 -0800
Message-Id: <20250121152303.3128733-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250121152303.3128733-1-kan.liang@linux.intel.com>
References: <20250121152303.3128733-1-kan.liang@linux.intel.com>
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

No changes since V9

 include/linux/perf_event.h  |  8 +++++++-
 kernel/events/core.c        | 33 ++++++++++++++++-----------------
 kernel/events/ring_buffer.c |  1 +
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8333f132f4a9..2d07bc1193f3 100644
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
index b2bc67791f84..f91ba29048ce 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1191,6 +1191,12 @@ static void perf_assert_pmu_disabled(struct pmu *pmu)
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
@@ -3473,8 +3479,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	perf_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -4618,15 +4623,8 @@ static void __perf_event_read(void *info)
 
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
 
@@ -7400,9 +7398,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	if ((leader != event) && !handle->skip_read)
+		perf_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader, self);
 	if (read_format & PERF_FORMAT_ID)
@@ -7415,9 +7412,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		if ((sub != event) && !handle->skip_read)
+			perf_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub, self);
 		if (read_format & PERF_FORMAT_ID)
@@ -7476,6 +7472,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 {
 	u64 sample_type = data->type;
 
+	if (data->sample_flags & PERF_SAMPLE_READ)
+		handle->skip_read = 1;
+
 	perf_output_put(handle, *header);
 
 	if (sample_type & PERF_SAMPLE_IDENTIFIER)
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4f46f688d0d4..9b49ecca693e 100644
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

