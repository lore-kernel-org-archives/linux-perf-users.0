Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E1468C1B;
	Mon, 28 Sep 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581890; cv=none; b=HnRjmnURr4U7jRDbimV3EVcWzB+VwdQQSpBKqSd8L2gfNOH4FSEtBVpl5gmfPwNBXJHUZZDv3cjR3YoyWBj0DXh7ywvJjoZofktis19YiapozS+vhZKF6YWmUsHBqBe5WVab6ltN1la+R5Iom6GWN8Fqx/qfPO86ivxsE/3uGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581890; c=relaxed/simple;
	bh=9mMxMy/W548eqOty8etxmi7s5A1WgX23GlmvlU5b6aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFTezr78M4YPX0M2FjeANp9VJtjH2McqxeJZjYceDNNeYgKnfvOSzaekYvY3PUcN/N8K3FGVJplkhUZ2+yQoL95CUyruEz1VbwdWb2JsqvlQboH2lKrGqVExVbUkD2BSKUpCeDrD74skJGiVWCDaKz30ARF4mLRdDTgTqTGRcvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxhwXqjb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxhwXqjb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581888; x=1822117888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9mMxMy/W548eqOty8etxmi7s5A1WgX23GlmvlU5b6aM=;
  b=kxhwXqjbGzPwnUyMOJpgu0SSrRPxbEpRJkfR6XB+LsgACWw68EwwEIqI
   bi8+blI5wMN9pUxhpIaDF/jVdt39RhxGIoPHqwLf/0EHyMg2+CLYgF5hZ
   EyMh+HNbwR+qXQlvUFevZB1OQerEgm/PMtvzsbUUTIPs8yIkVoDo7Os0m
   hg3GNsjirRz/Zy44FzOTFXcT21BmBzBpfFnh92bAtJJNVK7u+z1Gm7T/O
   7I9aNUCxBT7GoiTYtOEbn8HIcaEwU049mhTKxwh2EMmR3qh4oNn2/a+qt
   1Ji+D0g2idi1TKXQQrpBGuXRHuVYh+UQtSlJylaEDq0srBNf4SaBQh/oE
   Q==;
X-CSE-ConnectionGUID: M2XqYkfBTVuAdlYjX7seIg==
X-CSE-MsgGUID: /qNWiNAFRY+ZHdUVOHcdgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141513"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141513"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:51:28 -0700
X-CSE-ConnectionGUID: xVxiL8hnQxmSsE4cfxbD2A==
X-CSE-MsgGUID: 3r5hGCsuQ+2n8JhUBVjzOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275025081"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:51:25 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 15/15] perf/x86/intel: Allow Topdown metrics with a non-leader slots event
Date: Mon, 28 Sep 2026 15:43:09 +0800
Message-Id: <20260928074309.898043-16-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Topdown metric events currently require the slots event to be the group
leader. That is unnecessarily strict. For metric counting, it is
sufficient that a valid slots event exists in the same group, regardless
of whether it is the leader.

Relax the validation in intel_pmu_hw_config() to accept a slots sibling
and validate metric constraints against that slots event. This enables
leader sampling for groups such as:

-e '{cycles:p,slots,topdown-retiring}:S'

Keep the existing ordering rule: the slots event must appear before all
metric events. Group validation is incremental, and intel_pmu_hw_config()
cannot determine whether the current event is the last event in the
group.

Also set the slots event with PERF_EV_CAP_RELIED_ON and metric events
with PERF_EV_CAP_RELIANT so that detaching the slots event will place
the dependent metric events into the ERROR state if slots event is not
the group leader.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 37 +++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6cc1462c9c82..9025f29f625d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5300,30 +5300,53 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 		if (is_available_metric_event(event)) {
 			struct perf_event *leader = event->group_leader;
+			struct perf_event *slots = NULL;
+			struct perf_event *sibling;
 
 			/* The metric events don't support sampling. */
 			if (is_sampling_event(event))
 				return -EINVAL;
 
-			/* The metric events require a slots group leader. */
-			if (!is_slots_event(leader))
+			/*
+			 * intel_pmu_hw_config() cannot tell whether the current
+			 * event is the last one in the group. Require the slots
+			 * event to appear before all metric events.
+			 */
+			if (is_slots_event(leader)) {
+				slots = leader;
+			} else if (leader->nr_siblings) {
+				for_each_sibling_event(sibling, leader) {
+					if (is_slots_event(sibling)) {
+						slots = sibling;
+						break;
+					}
+				}
+			}
+
+			/* The metric events require a slots event. */
+			if (!slots)
 				return -EINVAL;
 
 			/*
-			 * The leader/SLOTS must not be a sampling event for
+			 * The slots event must not be a sampling event for
 			 * metric use; hardware requires it starts at 0 when used
 			 * in conjunction with MSR_PERF_METRICS.
 			 */
-			if (is_sampling_event(leader))
+			if (is_sampling_event(slots))
 				return -EINVAL;
 
-			event->event_caps |= PERF_EV_CAP_SIBLING;
+			if (slots == leader) {
+				event->event_caps |= PERF_EV_CAP_SIBLING;
+			} else {
+				slots->event_caps |= PERF_EV_CAP_RELIED_ON;
+				event->event_caps |= PERF_EV_CAP_RELIANT;
+			}
 			/*
 			 * Only once we have a METRICs sibling do we
 			 * need TopDown magic.
 			 */
-			leader->hw.flags |= PERF_X86_EVENT_TOPDOWN;
-			event->hw.flags  |= PERF_X86_EVENT_TOPDOWN;
+			slots->hw.flags |= PERF_X86_EVENT_TOPDOWN;
+			event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
 		}
 	}
 
-- 
2.34.1

