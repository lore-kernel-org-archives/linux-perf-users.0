Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249288;
	b=XvEsMCNYaps13JvXeMCbvq98KIixTsBQ/oe7F3X79nND1FnEabO3JQrAvyl6Ovx5XIp4
	 2xZTbyFipo5Oqcx0S3Ja8yVpvoMQJ7IwPfspU1WMxao4M8UlI6llJp8s+ApGQyQr+3ihE
	 8XxhO/tFfhZlXa9fDIoctVDBNHZpelpAbfyG+uWC6b9CTO/hRJPQ25rvMPXJMkklKa4+o
	 6PC6YGIRcrOqDzYkO3vfVpJ/Y8t/D0+ky0cSrhlaX6w4glinptlMPW80+eCdbpGVlhbJ5
	 qa8PUO3HNdNygjzxn9oFQuFWf9BKtPdR1W60m34B9ZMoUM+fSLtSAmVIP227yZRJq6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249288;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c7pLHp8/RTUVNwZZH/uVuN2t+N878GLQrRpVM4hU/7U=;
	b=Cip+j2XNfqt2bO0ZtoSSPoBqDZctKaFVtF4yxL4qtJ/5doVjXdcREJEWnf2REyP4j+TK
	 j6xtKjBrmBvCxIhKfbll05S9cPsvBKttQQTgXYmBCJ3KFPXY6ntOAi8EBP++/qYerLPZN
	 sOJgVRISyKGJ71ea9+8cuUHFuy/NX9eq16iuYciJLUlLrLz1jxj5Y333Ya76Lzhz1DzKg
	 OrNjMX3IvxDBRkoKDHQGpxNBcekr6NUEb9+8N2DPdq3ZlFbDom2fGP8ZehPqHAKlfnV1t
	 TqtDhKspDsB2mWjgRmxMMgoDUoxt/bO95FDfH9+uJmYJzuWy6grNVjMRGeokBzOsu/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJN4b8UI;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53D606A32E;
	Thu, 29 Oct 2026 04:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D53D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJN4b8UI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249288; x=1824785288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NK0CEZ9r+i2wpAjr0fEpVxp2LAsGVQeDD0ZR1gEBJWc=;
  b=KJN4b8UIzDuAuHgL5yPPOaS4gZJgIXm1iXBD6T5CI0aJa6T5z89xdMGY
   AJm7dTU7apcf8k4JmSGPvnb1jiE2w78VL2zjHQuL8vvTjzeCy2l8UTDAq
   9UwWV7hbYG3RYqxhYMHBQ9odeOycatV1Z3/EWyfLC5wkWB/ncftZ9U93c
   pGDAbcOBBCCE9JNlo3dflpDWS1t9Hb5KbjkKeAbNxgTdRxuwYpEopOu57
   lAS373UusOFKWbPAk5EOF1NOEJ0wkXq27sNoz1cRAtKEe8pyH+T2CukHB
   QSGIsB+QEGWt3tyPI8LCenjy78VtcDaxt389cmLDKTqONb7FF0xML6lZv
   A==;
X-CSE-ConnectionGUID: Wuw54DRjS/2Wy8iJ9hWwVA==
X-CSE-MsgGUID: abaBIshsSeqz7hAuHFGbww==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986369"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:48:08 -0700
X-CSE-ConnectionGUID: 29xET6B7TIy3PcJm0p0GZQ==
X-CSE-MsgGUID: l9lfFmB8Qhu6aKsejrEfAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420640"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:48:03 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v5 18/18] perf/core: Don't overwrite shared LBR stack depth
Date: Thu, 29 Oct 2026 12:39:14 +0800
Message-Id: <20261029043914.1395147-19-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_sample_save_brstack() currently clamps the shared LBR stack depth
to min(event->attr.sample_max_stack, brs->nr). This is unsafe because
the global LBR stack is shared across all LBR events, and a small
sample_max_stack from one event can shrink the depth for all others in
the same PMI.

As a result, later events may output a shorter LBR stack than requested
even when they do not require a small sample depth. Do not overwrite the
shared LBR stack depth in perf_sample_save_brstack(); instead, keep the
per-event limit in a local variable so each event is constrained
independently without mutating global state.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: c53e14f1ea4a ("perf: Extend per event callchain limit to branch stack")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 include/linux/perf_event.h | 13 ++++++++++---
 kernel/events/core.c       |  8 ++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7797ce207555..1188aace3335 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1424,12 +1424,19 @@ static inline bool has_branch_stack(struct perf_event *event)
 	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
 }
 
+static inline u64 max_lbr_stack_depth(struct perf_event *event,
+				      struct perf_branch_stack *brs)
+{
+	return min_t(u16, event->attr.sample_max_stack, brs->nr);
+}
+
 static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 					    struct perf_event *event,
 					    struct perf_branch_stack *brs,
 					    u64 *brs_cntr)
 {
 	int size = sizeof(u64); /* nr */
+	u64 lbr_nr;
 
 	if (!has_branch_stack(event))
 		return;
@@ -1439,9 +1446,9 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
 
-	brs->nr = min_t(u16, event->attr.sample_max_stack, brs->nr);
+	lbr_nr = max_lbr_stack_depth(event, brs);
 
-	size += brs->nr * sizeof(struct perf_branch_entry);
+	size += lbr_nr * sizeof(struct perf_branch_entry);
 
 	/*
 	 * The extension space for counters is appended after the
@@ -1449,7 +1456,7 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 	 * of events of each branch.
 	 */
 	if (brs_cntr)
-		size += brs->nr * sizeof(u64);
+		size += lbr_nr * sizeof(u64);
 
 	data->br_stack = brs;
 	data->br_stack_cntr = brs_cntr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index de05df65ab3d..ebc1cb417806 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8442,12 +8442,12 @@ void perf_output_sample(struct perf_output_handle *handle,
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		if (data->br_stack) {
+			u64 lbr_nr = max_lbr_stack_depth(event, data->br_stack);
 			size_t size;
 
-			size = data->br_stack->nr
-			     * sizeof(struct perf_branch_entry);
+			size = lbr_nr * sizeof(struct perf_branch_entry);
 
-			perf_output_put(handle, data->br_stack->nr);
+			perf_output_put(handle, lbr_nr);
 			if (branch_sample_hw_index(event))
 				perf_output_put(handle, data->br_stack->hw_idx);
 			perf_output_copy(handle, data->br_stack->entries, size);
@@ -8456,7 +8456,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 			 * right after the struct perf_branch_stack.
 			 */
 			if (data->br_stack_cntr) {
-				size = data->br_stack->nr * sizeof(u64);
+				size = lbr_nr * sizeof(u64);
 				perf_output_copy(handle, data->br_stack_cntr, size);
 			}
 		} else {
-- 
2.34.1

