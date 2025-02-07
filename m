Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35D1EB1BA;
	Fri,  7 Feb 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942110; cv=none; b=mBbd9wc4TebJL0WTQAKuOqSKqCd3SvL1yJ8Q2aSt1aMWs2Dm/iuo5nKNGp8IDPym+i8IGhATeZUXsqVnbylr4AIk/q/vq8kSw2qTNmDfj0uQesHYOLC7hOlfkrkrVYLK7MS4g3M+zFKr9yoSvC4wvHdA5UxdhyL4LfSjTxjBmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942110; c=relaxed/simple;
	bh=GDvYfrwJg6xhYEviS7QdZmI6UsPNPpB1aJnYGm6S3sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WmJl2WFG86+ii3Ky3TueHhIviwOcLhxaYpAb4RM84uU6A8IO0Kk9hBTuFn87y7+lSZaQeDQm/ZCvfv20cG2gG4kXKvCvoFke4e8ca/e5DOVb0bNFgvEdTfQGu35IDEu4YUeP1HjLccb/9lW+1wAVujTMVvBLTdNe80RnQTf2Ges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6wSvLaD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6wSvLaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738942109; x=1770478109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GDvYfrwJg6xhYEviS7QdZmI6UsPNPpB1aJnYGm6S3sc=;
  b=B6wSvLaDl4vOq/OJuF1RpvQNL0hcSWMRb7kOp02FwbYxG2yDGQ296uFH
   CXyThFZ8+/JiM+VL1bFOxdB5ms5Vt/bUz6YaZxon3s38/fXlMeJvSjnOA
   WzNHiEezGMeBn1OA1klLCWqndIkM/nSF8etifrylHexQw6ny9lYyr1FDZ
   vzpduAGu/a3U9wvL2h93AqDOazOHVtb1pHDPK8NY+fTmIaNEqy5mrDqP1
   ljiJ9HqMUo49lFkr4I2lLUk74rV8BstB8IiJhLkcxDGeEaZDBELJvvokG
   jOI6OtLQE6Ywejg1JzQFUadxffWtgWFTV6IK/8X38InQi/b8643PvFgrX
   w==;
X-CSE-ConnectionGUID: MmMshfyETbKEfVC/MTxN/g==
X-CSE-MsgGUID: yq9l2Mm9QVW/WyUGuKPhQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39702315"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39702315"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:28:28 -0800
X-CSE-ConnectionGUID: EASXZdtFScKmoBX9hvwXow==
X-CSE-MsgGUID: f+zV0DLaQsa/hRDw6RXbpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116161825"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 07 Feb 2025 07:28:28 -0800
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf tool_pmu: Add skip check in tool_pmu__event_to_str()
Date: Fri,  7 Feb 2025 07:28:44 -0800
Message-Id: <20250207152844.302167-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Some topdown related metrics may fail on hybrid machines.

 $perf stat -M tma_frontend_bound
 Cannot resolve IDs for tma_frontend_bound:
 cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (8 * cpu_atom@CPU_CLK_UNHALTED.CORE@)

In the find_tool_events(), the tool_pmu__event_to_str() is used to
compare the tool_events. It only checks the event name, no PMU or arch.
So the tool_events[TOOL_PMU__EVENT_SLOTS] is set to true, because the
p-core Topdown metrics has "slots" event.
The tool_events is shared. So when parsing the e-core metrics, the
"slots" is automatically added.

The "slots" event as a tool event should only be available on arm64. It
has a different meaning on X86. The tool_pmu__skip_event() intends
handle the case. Apply it for tool_pmu__event_to_str() as well.

There is a lack of sanity check in the expr__get_id(). Add the check.

Closes: https://lore.kernel.org/lkml/608077bc-4139-4a97-8dc4-7997177d95c4@linux.intel.com/
Fixes: 069057239a67 ("perf tool_pmu: Move expr literals to tool_pmu")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/expr.c     | 2 ++
 tools/perf/util/tool_pmu.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c221dcce6666..6413537442aa 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -215,6 +215,8 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data)
 {
+	if (!ctx || !id)
+		return -1;
 	return hashmap__find(ctx->ids, id, data) ? 0 : -1;
 }
 
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 4fb097578479..3a68debe7143 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -62,7 +62,8 @@ int tool_pmu__num_skip_events(void)
 
 const char *tool_pmu__event_to_str(enum tool_pmu_event ev)
 {
-	if (ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX)
+	if ((ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX) &&
+	    !tool_pmu__skip_event(tool_pmu__event_names[ev]))
 		return tool_pmu__event_names[ev];
 
 	return NULL;
-- 
2.38.1

