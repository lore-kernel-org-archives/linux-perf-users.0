Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821530B51D;
	Tue, 24 Mar 2026 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313162; cv=none; b=t/zRuz/pkDhKoAXq4WQnm6f1OMdhfJNRgP59VbjcfzbhxZ2+ezPGMPVb9RiRmefT+OMudxb4YSkElbG+rcOpWUMrb9orjVRbGgoVd8T/D8G+kxV0c/wpuMbx4DJyKdJy349sZiuB1J4jWD28TWsE3w9GkG0DyPOGXQkmFil7kP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313162; c=relaxed/simple;
	bh=nZdptApk2egtKxE0jTlQ4OhGVZIz8u+Eemv+BFkILIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wcvof6jnQoKkDKdpvX7TndARZ9qdquA7X8hvTvWi7S+eidDzEJ0Ipj67PHpnJC+dPvr3vouTIYV6n9+D5SvsRiQmycbaobuZ2Ggx5iYn+WDNm7ngdgIqOCymC9YU5SeW17T/pAzcVVMiLOVccv0zZsUpgQ1Wj+391rryk/BuyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQp28z9m; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQp28z9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313161; x=1805849161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZdptApk2egtKxE0jTlQ4OhGVZIz8u+Eemv+BFkILIo=;
  b=WQp28z9mHWYjEAJdB/uA6zU/UNDI3N9EM+s7v0Yj1z4IY5ePoObQAaN+
   OmAz5qNheOLX6gH1NjY+ljnS5QtX1cAd6E7aUO65PELYD50UhEK2bBKQW
   Z9V98CqUrmzHqFUFDDI4UEEbwsX6CM6NwKgc/K9qAOdJA/CzV4NlOrxzx
   cWv6VvK4gKrIIaPrXe4hQpBFRHFSS1sI4KhwBDuFmu7lnaej5N0VNaSuQ
   k09K45cX1nZ3IhOary3ljEt/oPViClORxX/EKISesJQLw+SKnWN23qwKk
   07usilet8jrtgKilNRrih+x8Don9DRwFucPPmceBicMFvpNFBQxLzQtOP
   A==;
X-CSE-ConnectionGUID: Y+TyXdzST3GT8HcRUtATGw==
X-CSE-MsgGUID: kNs6lyG4R5+zPIxtL/T/1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86396953"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86396953"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:00 -0700
X-CSE-ConnectionGUID: EEgbxxN/SxacT6MBoQsc+A==
X-CSE-MsgGUID: IZA98ioZTEKLPaqdBs1/YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322582"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:45:56 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [Patch v7 02/24] perf/x86/intel: Avoid PEBS event on fixed counters without extended PEBS
Date: Tue, 24 Mar 2026 08:40:56 +0800
Message-Id: <20260324004118.3772171-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the introduction of extended PEBS, PEBS supported only
general-purpose (GP) counters. In a virtual machine (VM) environment,
the PEBS_BASELINE bit in PERF_CAPABILITIES may not be set, but the PEBS
format could be indicated as 4 or higher. In such cases, PEBS events
might be scheduled to fixed counters, and writing the corresponding bits
into the PEBS_ENABLE MSR could cause a #GP fault.

To fix this issue, enhance intel_pebs_constraints() to avoid scheduling
PEBS events on fixed counters if extended PEBS is not supported.

Reported-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V2: Restrict PEBS events work on only GP counters if no PEBS-baseline
suggested instead of limiting cpuc->pebs_enabled to PEBS capable
counters in v1.

 arch/x86/events/intel/ds.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 5027afc97b65..49af127bff68 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1557,6 +1557,14 @@ struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 	if (pebs_constraints) {
 		for_each_event_constraint(c, pebs_constraints) {
 			if (constraint_match(c, event->hw.config)) {
+				/*
+				 * If fixed counters are suggested in the constraints,
+				 * but extended PEBS is not supported, empty constraint
+				 * should be returned.
+				 */
+				if ((c->idxmsk64 & ~PEBS_COUNTER_MASK) &&
+				    !(x86_pmu.flags & PMU_FL_PEBS_ALL))
+					break;
 				event->hw.flags |= c->flags;
 				return c;
 			}
-- 
2.34.1

