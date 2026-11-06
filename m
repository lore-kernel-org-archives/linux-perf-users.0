Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940161;
	b=y/NDUOxxl1gGlEs5vJccVpTVoCsUKO/esZKZ/g3EU7qBl4cDEnLQUdQM/+wTsVcoiIL9
	 Xm81bu2KmCWh4JM58v+1Ux9d5DpeKrNrBOdikcIIcfsh5B9fuWS4ZvkGa86yC/vh1AsKz
	 iMmiULDD+nxZz0zlqBeOoTrm4im10REa9spVN7Bhvboq1VRGiD+C3foaQu5Iv/J4po7fy
	 XAwszDC0EZXq5j+rPv0J9FaZGRUV3PO6m3TMl2d6JFoyHdXVM7fc7qtINFpKOSFxmlFFB
	 TuNVOj+I9FKfZKrp8FED4GlcN0CpdcvgmpFnPBsV/zMU00Ef1ronNAf5Fw7vQgKoqeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940161;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1wKznn2+VS2RaWktBgchg2SLlYnjJYiuTLjuxGtjRUQ=;
	b=WFLOk7oGuRr47NFqH003p+vy8RLfFlElHUQVvK1f1WXQC5pcwlYzSggAwDsaVb4+Cdlb
	 bs/ZJFGNP1lrmItUc0gc4nxkbsakCMgvMXveuiKQN/HWh6SZQp7KomTjDprPwzb//pYcA
	 lZOtpc506gJixsbsN22mQgBpqt0UKHXm8DimdOoLZgylrdknsEHMcebLG+t9Fv6MexpOQ
	 WgWB+JSxE6srXsxY5DLHF9tNz5ESwfcPvyTBZAX9ritKiS2gqXBrD2rUOmAEVAsD6S76z
	 jkU+sL1hz30QaJdgiSHTvVIaAcqbRIPVekNCoz1Ll3QOXbGB0h1uSjU3AgP12TgBgHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="gF/3w554";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C0606D808;
	Fri,  6 Nov 2026 04:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 989C0606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gF/3w554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940161; x=1825476161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJj2nThP6vVwJTZdcv5q60wkfFZKfgBAd90ia4i3aPk=;
  b=gF/3w554hBQTwk5WT6dT2Hn++3H5uCTg0TKnMTcfIOMVvog3D8cQwVHG
   nVE+SAFcZpGCQQrVgTMgPKloToC7MDQ/J8YpCQhxnl2+NEcawA37+ORn1
   cSJAmTj/NmSAeMoGu3zyqhgiw4ggioGlmCBSiCP2oqIdXd8wFuXb8NIPU
   i1O8Yp/X7ran7Us4QNp1R8LYdlPsDSM26vpOfpx+o7RvN41O1meirG0HS
   6HBnZ6db2eS9vZWfON3Ho8BnusYQdIw60AwPTYidAbOpSiyO+7r6UT/wQ
   TjYDAXZ1qpOp2wPS7rerH5dAaXLa4bvggnmikXZo5q5tDDyd15QaWOv88
   Q==;
X-CSE-ConnectionGUID: ft1fwy51RLqFTny/ootg+w==
X-CSE-MsgGUID: mCZX3Q5hSgu29wiyAihA0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780973"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780973"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:42:12 -0800
X-CSE-ConnectionGUID: mwX46sHgTCm8RGrwtwCD/A==
X-CSE-MsgGUID: F8LhD+T7TUuzw1oi0VOy2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7223043"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:42:07 -0800
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
Subject: [Patch v6 20/20] perf/core: Don't overwrite shared LBR stack depth
Date: Fri,  6 Nov 2026 12:32:57 +0800
Message-Id: <20261106043257.842864-21-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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
index 19de3f1cbd6e..b9a4a821c7c6 100644
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
index 457d75ea7142..db2613c2e1a2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8462,12 +8462,12 @@ void perf_output_sample(struct perf_output_handle *handle,
 
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
@@ -8476,7 +8476,7 @@ void perf_output_sample(struct perf_output_handle *handle,
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

