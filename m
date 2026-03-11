Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3813B47D7;
	Wed, 11 Mar 2026 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215772; cv=none; b=NRp2wvzcRf2vTEQt46pceHk9WRD5qZSBjME4WzU2kK2GPCByy0TuUTrARBKVAQiGDSZWx9Gqa/vl3pJu9d33Ix304RcobVIyXrEoF0rKbo9dWWzPscUpjsBGXTramkslLWsOUdVdEm+veyuT987u3nQQQXtABXtioLiULy8StVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215772; c=relaxed/simple;
	bh=5tJw/N/Q4TfAKMwbURztKDMvsFfpdCgyjfGiBO4m4XE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCAbh/225Zi4/p3tfXZGXFDeOXas3Nv+KRT75fJtdDXYFpBeYhLfUeYyDA/7nbKlXUPkiXl/+Eg1f05ga85Jut2KF5rVpqov0RK4WgzL9nrDcyOEcM9pv9gQDRi9+DfxdZZOhkul021zpxLj6ZrO5PWf0BbY1Hmyw3AWCfC6gNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GItixpSO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GItixpSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773215769; x=1804751769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5tJw/N/Q4TfAKMwbURztKDMvsFfpdCgyjfGiBO4m4XE=;
  b=GItixpSOEA5jfwmSvSJIc+lCrdetUWap5KQVf6oMnsYT/o1LBQjsNZNN
   26RE5Qb3Hi/FrIO9FIzLYpqb/u0qvm8o/yO0Fz7cz4Ye8Hwaup5V+GOCQ
   dN2Y9cRXsVw/G2m682bu7tQQKf/ZhcKd6EbxO7owXsUahQLrcZXtvxXyM
   KCWcUxnaiS0kPoUa3RYd6LZVgTCDc9BgvK7/6JRRE08U2E4AjcXjJ6gon
   tetPgODnjPDurUmL3RUosk4uKcPqYgeE97WeixzlHoqyf+Ue7ELF/PvpO
   X57AvKUS3nGICR6VG4mDka2wESWpf9zTdaHs1dJBON1y2kZ95KMz50hTK
   A==;
X-CSE-ConnectionGUID: NtZzrELIQV64745ccXnSoQ==
X-CSE-MsgGUID: wxlSLaPUREmkTDpnvJWnig==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73298913"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="73298913"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 00:56:08 -0700
X-CSE-ConnectionGUID: rdEoMP+xTMG2BjSYin8Fkw==
X-CSE-MsgGUID: 6PfwFjJRSbWjRgj2zyGoNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225081266"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 11 Mar 2026 00:56:04 -0700
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
Subject: [PATCH 2/2] perf/x86: Update cap_user_rdpmc base on rdpmc user disable state
Date: Wed, 11 Mar 2026 15:52:01 +0800
Message-Id: <20260311075201.2951073-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075201.2951073-1-dapeng1.mi@linux.intel.com>
References: <20260311075201.2951073-1-dapeng1.mi@linux.intel.com>
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

Fixes: 59af95e028d4 ("perf/x86/intel: Add support for rdpmc user disable feature")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7ef2e..0266a11d7ec9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2807,6 +2807,9 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_rdpmc =
 		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
+	if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
+	    event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
+		userpg->cap_user_rdpmc = 0;
 	userpg->pmc_width = x86_pmu.cntval_bits;
 
 	if (!using_native_sched_clock() || !sched_clock_stable())
-- 
2.34.1

