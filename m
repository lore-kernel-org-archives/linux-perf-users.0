Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972240;
	b=bmd3cBTJ066MralvcNPOL+BIRW/ZxhbH7HQ9xnUgqWobvmQI1DDhy6AL5ScPeYgtvjRl
	 CNNwXiizx9h4Ntx8X2W5dwMKXv0g7kswt2qBk3S7NGoAI6UgbL3HsNKhR6RJG0ihw6wws
	 7ZLOaHhEnJEV3Uxw59jvBjqVMa/ANQtJJxTW3SE4YidBb0TBop4ewRdLv0GPoM0qy8G5t
	 Wpy6O0zWuPCOK4QjOyoUvT+afAPau/aHFqzEs411j5jzfY+wRn3CRD4Ryy6W7Ti7omJ+3
	 KDslfMXxugiQHitp1zAZd6AXBscqBwAvvt9+p8KadSN6sFX93Yd5jXCxVEv2K+Pth4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972240;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8Yc210i/8dBzrn1MiuuAiF8rqLc8u8HZ5jY3l6HKw9I=;
	b=dhVnkhyYd/8/1pJ5DydlPbdti6+WxNo3q4GsLYwDRYiE0h23YrWRyYoOVb+K+0j1I5q6
	 wLAsmV9KNUhSZAvoqLHh+bzfQQDmYmUBq3RJkPkbgCA+7ofnylJQI7wDScbgp6HB0RFTk
	 qNkoiQOeqsyIbC2S0d60dnzv/Bc0djcRAbcV+OXnA9kcBipFToMw6By0Qwbg42rUR/Yl5
	 BzKoy1SRgAvKwdMbkEEiCCRRBmqDZlhV3W297/cypmb35WGI6dTqSzaDqZBCksYTlYnK/
	 HmcXtsVFhdlQ+YhkUIG796KoKJfjZmUbV6+pQ2Jq5djMAkGIUDDXwgNWZI+p0ctpC8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BB+ty/S2";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D1606A89F;
	Wed, 18 Nov 2026 03:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 269D1606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BB+ty/S2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972241; x=1826508241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GRqHksvwk5z6s+RQuOp9ezt3W45FUoynPqgif+pfGI8=;
  b=BB+ty/S2+L7WfEYUU6tZD6A6feW+VkoXktjGaZrlNz+xLSNwg60RAcwQ
   O+FQSeNGVI62AkFgI+D6y0L0eRYQBKJ5qhsCraiCn+NwSq9ryrsQ34F4i
   aT0P9JvwQkyvfoz3q2vSqD7h7r8lF4aorPTyHPkYS988I+9MMzgamrev8
   DPk1t0p9gNVlx9w/N1/fw4bqi1pMrnaTc9LJPTciyAfdbuaR7nQUKchc5
   CIXkqVTYGX7/LoFaI7hm06yNr+WXvoOT6JVfdMnVUjirIkUf9IFhIbz8E
   QwxCqIrg/zXbukqcDzA88rWfwgX6TmvKHmgYZEAYrvpSivmfHUzarYFrm
   A==;
X-CSE-ConnectionGUID: DjADtLuRQ7m+Esw8DqvDfA==
X-CSE-MsgGUID: e9ZVL1IDSUiaRBLKZrJnfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629954"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629954"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:00 -0800
X-CSE-ConnectionGUID: 2WGK4sAwRa64lIfftne3eA==
X-CSE-MsgGUID: 1r7fMtj7TJGorlTSTuLeZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894299"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:56 -0800
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
Subject: [Patch v7 15/24] perf/x86/intel: Set PERF_EV_CAP_SIBLING for pure branch counter events
Date: Wed, 18 Nov 2026 11:14:44 +0800
Message-Id: <20261118031453.1353625-16-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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

A pure branch counter event (i.e. an event which only applies
PERF_SAMPLE_BRANCH_COUNTERS without requiring the branch stack itself)
doesn't set up the LBR on its own. It relies on being grouped with a
normal branch event, which configures the LBR for it. Such an event
cannot work standalone.

Set the PERF_EV_CAP_SIBLING flag for pure branch counter events, so
that the generic perf core schedules them out once the group leader is
removed from the group.

Opportunistically refine the code style.

Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 84b134bb91ee..fd4de141ef28 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5130,10 +5130,17 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		 * require any branch stack setup.
 		 * Clear the bit to avoid unnecessary branch stack setup.
 		 */
-		if (0 == (event->attr.branch_sample_type &
-			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
-			    PERF_SAMPLE_BRANCH_COUNTERS)))
-			event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+		if (!(event->attr.branch_sample_type &
+		      ~(PERF_SAMPLE_BRANCH_PLM_ALL | PERF_SAMPLE_BRANCH_COUNTERS))) {
+			event->hw.flags &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+			/*
+			 * A pure branch counter event doesn't set up the LBR
+			 * itself. It must stay grouped with a normal branch
+			 * event which configures the LBR for it. Otherwise,
+			 * the LBR cannot be configured correctly.
+			 */
+			event->event_caps |= PERF_EV_CAP_SIBLING;
+		}
 
 		/*
 		 * Force the leader to be a LBR event. So LBRs can be reset
-- 
2.34.1

