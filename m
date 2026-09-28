Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735D44F561;
	Mon, 28 Sep 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581839; cv=none; b=T54YXjr+u5nKGce7wePRZU8/FGkv4Qj/fqBCJExuMJrICCJygMU8k/mKjAu183nyfd0xYBn5pCIDxRh947i9ftesLR09YtsKy4m3k0DGofzWzxmcIwlZWgqsUpo7lSvYE6a3fyVXQ0cIHEhmErmCR5FZyPrVjg9XWLWF6Wp6oMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581839; c=relaxed/simple;
	bh=vEd8OwtcxH5HtM1IEhQe1qV+pc57GYMXfy8ABNf+aFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eocaL/xTjodcIcLmRnQhELOjQE14H7nDdpQBwk5dWZZ+f4QGibs6shPWlw0z7dNS325i5vUga6SIB6i6ua4CeQ+JyOYpHUAlUA5/nL8KXMR8mk+NSXVqteNVFsFtypVl76FUUneouqsKCV6wHNsnWOf+5MnklPqwzna5wkuSR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/HHMnBr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/HHMnBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581837; x=1822117837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vEd8OwtcxH5HtM1IEhQe1qV+pc57GYMXfy8ABNf+aFo=;
  b=O/HHMnBreYPBZ8FUTP8ieMX+0jAByQJyXiI87NzVz5A5XsEqKBE+0iXN
   4DcDXAmk0Q6cF9huqao/pJ3H0YJ3a7/ipJBcfIJ5GG/RmjN8+mZ1zfwSD
   uc+2DF8U3D3LRi2wQKkvPI9g4TMfcyoV7Y2mZsT4l2ajXZkKyZcvE52ln
   nhcSk4jLZt/g+6hysb27TUN3uxu0Hso5UzZfnp418HyYj0odEVMx7nZn9
   tkuJ/mOuxl8Cxssi6egQJH8yb1Jiris4kwXK3uW/qju8qcouNfIhNwLPH
   tswLpMbFFqBHJ4JOUJQf9uGr03ow6Npx0Z1XbTrmY2PI3VkfCZ6oh9qfn
   w==;
X-CSE-ConnectionGUID: oz8mZmivRTy7GzknXfY2hg==
X-CSE-MsgGUID: M4qB8fMAQ+WeVNDOd3bw1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141383"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141383"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:50:37 -0700
X-CSE-ConnectionGUID: 3dMwjgzxRLqAyZi8Lk7eIQ==
X-CSE-MsgGUID: Q86LTULORWC0q/qc3KMJcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024858"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:50:34 -0700
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
Subject: [PATCH 01/15] perf/x86/intel: Guard leader sibling walk on nr_siblings
Date: Mon, 28 Sep 2026 15:42:55 +0800
Message-Id: <20260928074309.898043-2-dapeng1.mi@linux.intel.com>
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

The leader event's ctx mutex is only held before calling
pmu->event_init() for sibling events, not for a newly-created group
leader.

Some paths in intel_pmu_hw_config() call for_each_sibling_event() on the
leader itself. At that point, leader->ctx is not yet initialized, so the
lockdep assertion in for_each_sibling_event() can trigger WARN_ON_ONCE(),
and the access to leader->ctx is unsafe.

This loop is unnecessary when the event is the group leader, because the
leader has no siblings yet. Guard the iteration with leader->nr_siblings
before calling for_each_sibling_event().

Also move setting PERF_X86_EVENT_BRANCH_COUNTERS to the end of the
branch-counter validation path so the flag is set only after all checks
succeed.

Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a34d674df59..65815d13ae3f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5046,11 +5046,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		leader = event->group_leader;
 		if (intel_set_branch_counter_constr(leader, &num))
 			return -EINVAL;
-		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
 
-		for_each_sibling_event(sibling, leader) {
-			if (intel_set_branch_counter_constr(sibling, &num))
-				return -EINVAL;
+		if (leader->nr_siblings) {
+			for_each_sibling_event(sibling, leader) {
+				if (intel_set_branch_counter_constr(sibling, &num))
+					return -EINVAL;
+			}
 		}
 
 		/* event isn't installed as a sibling yet. */
@@ -5069,7 +5070,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		if (0 == (event->attr.branch_sample_type &
 			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
 			    PERF_SAMPLE_BRANCH_COUNTERS)))
-			event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+			event->hw.flags &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
 
 		/*
 		 * Force the leader to be a LBR event. So LBRs can be reset
@@ -5077,6 +5078,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		 */
 		if (!intel_pmu_needs_branch_stack(leader))
 			return -EINVAL;
+
+		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
 	}
 
 	if (intel_pmu_needs_branch_stack(event)) {
-- 
2.34.1

