Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4B27D781;
	Fri, 16 May 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420163; cv=none; b=BzmhfP43iysd67cUOn9WsyalM7F8GAgumcJLtrFyNMLK3Z9IZWb++kf3Rz+ErGmz2HZgFjGFNgQb1GJGckE6EcFQPXvIJdiMQmkkhVOSvD9PoRLrZYbB5fvwu6rPmEC43UDeUuJOrXBPxFHcr0Be2Ic9gfkK/P+VXqqsL0vjPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420163; c=relaxed/simple;
	bh=aBznW+kb4PCda6hhX4PByAqMfcQG6U6QJyqTE4hQTSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sk8ArBPVc6Xb4X2QwshJhPih4ICuehlPbfmNTrxqbfMiw3MIkpv3o9FI9yu3TOcb9QwGLpQF5hRFnqk2B7kbNcy/W8KVcKe1AJq90Yg+jK/uRg9W7ro9frU1qFXf1C/DwN9fkQkIqONq63NRN5Bs8VF1t0mcdlbBVYG31fhkC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJ8uMbsf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJ8uMbsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420162; x=1778956162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBznW+kb4PCda6hhX4PByAqMfcQG6U6QJyqTE4hQTSk=;
  b=ZJ8uMbsfe1OXCII4eSBVoqNk8zRQLTOKsQVaAOJbombob2tAKf8yKlX2
   nDS1sXjlsJcQXZlswisqJj32oHyb3m70v9L0q7P9wQy6imrFwL4es/R0V
   qbms9xSMZG73BqHFLxE4cTaR7Qtnqp8GtChwT24/5P3JfjCjlyXkJ8Pii
   U/TNK1Ltq8fTmB4uQQfmiQvAvWUP9BEgk3nkSOdrZvZExBxmNxR87dDi3
   T6eQJ1qcF7AmLz9W532liiBJ/HIKRk/uk+r9K85PXqUuydQTmIZNjKJE8
   fHpWc36S+JIQ5dYTx08EJDPGyA3bLL2xI/9Mu7bE8OGusiA5VL6XA79Hc
   Q==;
X-CSE-ConnectionGUID: iZ+SjU3TT96Ze1MohHtLJQ==
X-CSE-MsgGUID: KfACV4j/S+ORLcg1bbzjdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328795"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328795"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:20 -0700
X-CSE-ConnectionGUID: WipQ0unySySNlA1LKuP6iA==
X-CSE-MsgGUID: 2715bz6/Tdqhu4zaYARP+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802596"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:19 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 01/16] perf: Clean up event in freq mode check
Date: Fri, 16 May 2025 11:28:38 -0700
Message-Id: <20250516182853.2610284-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250516182853.2610284-1-kan.liang@linux.intel.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Add a helper to check if an event is in freq mode to improve the
readability.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a84abc2b7f20..af78ec118e8f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2442,6 +2442,11 @@ event_filter_match(struct perf_event *event)
 	       perf_cgroup_match(event);
 }
 
+static inline bool is_event_in_freq_mode(struct perf_event *event)
+{
+	return event->attr.freq && event->attr.sample_freq;
+}
+
 static void
 event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 {
@@ -2479,7 +2484,7 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu--;
-	if (event->attr.freq && event->attr.sample_freq) {
+	if (is_event_in_freq_mode(event)) {
 		ctx->nr_freq--;
 		epc->nr_freq--;
 	}
@@ -2780,7 +2785,7 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu++;
-	if (event->attr.freq && event->attr.sample_freq) {
+	if (is_event_in_freq_mode(event)) {
 		ctx->nr_freq++;
 		epc->nr_freq++;
 	}
@@ -4391,11 +4396,11 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (hwc->interrupts == MAX_INTERRUPTS) {
 			hwc->interrupts = 0;
 			perf_log_throttle(event, 1);
-			if (!event->attr.freq || !event->attr.sample_freq)
+			if (!is_event_in_freq_mode(event))
 				event->pmu->start(event, 0);
 		}
 
-		if (!event->attr.freq || !event->attr.sample_freq)
+		if (!is_event_in_freq_mode(event))
 			continue;
 
 		/*
@@ -13129,7 +13134,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	hwc = &event->hw;
 	hwc->sample_period = attr->sample_period;
-	if (attr->freq && attr->sample_freq)
+	if (is_event_in_freq_mode(event))
 		hwc->sample_period = 1;
 	hwc->last_period = hwc->sample_period;
 
-- 
2.38.1

