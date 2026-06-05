Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62637AA9C;
	Fri,  5 Jun 2026 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622225; cv=none; b=cHlbekGYj1Ns1WFh7iuY+DGqOQExxfQ3zDASwa21Qo8ZAxwa1KO3VNmgpoXcREI7aC1QxOyN529qC6stEEAi+HgHFWTv/c3MRoQfnShKe8QIx6wbDEXPlOgj7QjmFa7HJEES+yPmZvT/acqZovzcK7sP2fhKuVUnnDP3LJ/GiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622225; c=relaxed/simple;
	bh=CC2Kq79leFFZe4IlLmqlNstv/NPsgz24jysL+MZMAW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iv7FWsRH3s+DZPtxNrsioG8+qqFcBFlj7KyZPJJyNJs73kiyhXGV+MdOcaSXyiTFssKhCo73W2fmId8Wk7rHCen+GyBgStHUiHGpC3XpGzkKVHbpm7xO2Bteclo46DtEQyil6k6mQmoHklC8qCTQbmfE6TTeBsuHaEKrQFIOO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3iunk6u; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3iunk6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780622220; x=1812158220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CC2Kq79leFFZe4IlLmqlNstv/NPsgz24jysL+MZMAW4=;
  b=a3iunk6uDxSvHeYt2OTpi5DlnVlhCq/wSn0FNsTi2KQcmsShIOi9NRn4
   Ht/q9Csh0CZVFqJTe9KHQBrtBj34duf651nbs2Tkgm9X2Iu2yKvcOdd0T
   m1d8cqGri2zZlHlxmT2qIPaKi0YfSeCG1zHz8GMFU+vPhyodfu0LVr8R+
   Ym5E5e0yZhOvc8FTeP/SlgnWAsBYE3haD7ujTWgYJZCEpH3rBJKhL6I8k
   7S0Rbzs45YLCfQitmdubI3ZwLzHZOtE8viIkNFUZ5iW3tqIe0qvr5q0ZG
   REui0Ii2MKIVbtS2G9N5S7EJnSoo8ol7G5rXZG+Zj287A8h7v1CBjPt0r
   g==;
X-CSE-ConnectionGUID: yfc7S2lsTqW+zHnH9QJOgw==
X-CSE-MsgGUID: 233PCDIrSYa94kgeeM7b5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91772186"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="91772186"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 18:17:00 -0700
X-CSE-ConnectionGUID: 5/KWcsjPR0mPe2yVdrebWQ==
X-CSE-MsgGUID: +MHGYfW2SImCE5CoR4bhxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244817117"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2026 18:16:57 -0700
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
Subject: [PATCH 3/8] perf/x86: Update cap_user_rdpmc base on rdpmc user disable state
Date: Fri,  5 Jun 2026 09:11:31 +0800
Message-Id: <20260605011136.2043393-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After introducing the RDPMC user disable feature, user-space RDPMC may
return 0 instead of the actual event count. This creates an inconsistency
with cap_user_rdpmc, where cap_user_rdpmc is set, but user-space RDPMC
only returns 0.

To accurately represent the user-space RDPMC capability, update
cap_user_rdpmc based on the RDPMC user disable state. If RDPMC user
disable is enabled, cap_user_rdpmc is set to false, allowing user-space
programs to fall back to the read() syscall to obtain the real event
count.

Since arch_perf_update_userpage() could be called for software events,
enhance x86_pmu_has_rdpmc_user_disable() to only check the x86 PMUs.

Fixes: 59af95e028d4 ("perf/x86/intel: Add support for rdpmc user disable feature")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
---

Original patch link:
https://lore.kernel.org/all/20260316050838.3624051-2-dapeng1.mi@linux.intel.com/

 arch/x86/events/core.c       | 3 +++
 arch/x86/events/perf_event.h | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3bd0522afe6d..6cd95b8e31cb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2797,6 +2797,9 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_rdpmc =
 		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
+	if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
+	    event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
+		userpg->cap_user_rdpmc = 0;
 	userpg->pmc_width = x86_pmu.cntval_bits;
 
 	if (!using_native_sched_clock() || !sched_clock_stable())
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index dbb5c8e8a8ea..4003e2e0aa9c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1359,8 +1359,9 @@ static inline u64 x86_pmu_get_event_config(struct perf_event *event)
 
 static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
 {
-	return !!(hybrid(pmu, config_mask) &
-		 ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
+	return is_x86_pmu(pmu) &&
+	       (hybrid(pmu, config_mask) &
+		ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
 }
 
 extern struct event_constraint emptyconstraint;
-- 
2.34.1

