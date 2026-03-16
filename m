Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549313396E9;
	Mon, 16 Mar 2026 05:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773637971; cv=none; b=Y7caw1o12Gc+ZKMh6ym88qZ/JwR2SsLZmGkuJmTq0LoXC48KHJha3mS+84uSH5tz6NIu4UL587YWOLVYZPza6Y0weNBc49HqmyOXw1wrqtp1DbYoObgfqhBUkuFHSAhWK7nuuUxpul2UPRauI7opEW+jL7q1omJdmNPNIvjd8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773637971; c=relaxed/simple;
	bh=IKMdcMgH+u2bjuAiJri0Q8fmMQlZhYYXZh93E5g++hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NOzC+YcHfezYDr1DMMH2LJdGUTIY3x9UZM/v5URZzZ89R5vGiypDZBA1TVgHxq4duaqmbf7CwBGs6XMM9AJuAgVWJC+9CZgNdfRBZFQxeSX8tA7NM+fdmBLVml5lZ5qSW+QiGuPJAMsR/Tz+8yO2CpVS8hGY8ItxSOmTmZeWXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOTQYk4O; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOTQYk4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773637970; x=1805173970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKMdcMgH+u2bjuAiJri0Q8fmMQlZhYYXZh93E5g++hY=;
  b=NOTQYk4OV1YN+Ts/6y7GM89BV1Fk4GhgRu+1MdCRbQPT2EllJCYHUgcF
   leFWBNY0OX7PbcaIRcqKsMdwkwJKAbGqQeSRh7lPCcUPoLLFWPslULbOf
   HPKYbIK8z4Qm0G8qmzAEyYGa8X2pAth0YDhqUyEFU51vtnRPEZEW0icTP
   5UjcyfmXspx8d1SY8UarlTG25W+UGlNfDGEyUeEEHSHrWgfEZ5FDvIXGw
   su7TZVnNB0sX9qh9AQTR1A6aq5HFIzar+ueY7oDu4W/qHaaikdjtViI6/
   HsmKyiqEjf6LDJO1lOCh01jJJL0Y8F0b/AoQvQVaXyXX4o6UD1Ir/Plgz
   A==;
X-CSE-ConnectionGUID: jJ1o9wpOSre+UVvlp0dM5w==
X-CSE-MsgGUID: Pgt/wH4lTOWYP0FqfHsh0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="86003463"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="86003463"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 22:12:50 -0700
X-CSE-ConnectionGUID: v7jb1GZHSKywycg/194Kyg==
X-CSE-MsgGUID: 0ctDSsNUTTOvsw+4s85pjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226262462"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 15 Mar 2026 22:12:47 -0700
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
Subject: [Patch v2 2/2] perf/x86: Update cap_user_rdpmc base on rdpmc user disable state
Date: Mon, 16 Mar 2026 13:08:38 +0800
Message-Id: <20260316050838.3624051-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316050838.3624051-1-dapeng1.mi@linux.intel.com>
References: <20260316050838.3624051-1-dapeng1.mi@linux.intel.com>
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
---
 
v2: Add is_x86_pmu() check before checking if rdpmc user disable feature
is supported.

v1: https://lore.kernel.org/all/20260311075201.2951073-2-dapeng1.mi@linux.intel.com/

 arch/x86/events/core.c       | 3 +++
 arch/x86/events/perf_event.h | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 66b1a873c395..34eda8813716 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2794,6 +2794,9 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_rdpmc =
 		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
+	if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
+	    event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
+		userpg->cap_user_rdpmc = 0;
 	userpg->pmc_width = x86_pmu.cntval_bits;
 
 	if (!using_native_sched_clock() || !sched_clock_stable())
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 025f67726ecc..307361b106d2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1351,8 +1351,9 @@ static inline u64 x86_pmu_get_event_config(struct perf_event *event)
 
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

