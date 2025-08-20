Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475412C11C1;
	Wed, 20 Aug 2025 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657096; cv=none; b=Hx9IcX7PHGpAMM7hiXiE3GjmtbUpsyWdMKcGWNyFIIm0dqpmOJToEqcLT/GP8MJG1KUdH+VZ1yKYf7PB0rTpNIAzZXxaprhAQxb3QdrPJg5HHFOWnwnYjbYnzgB1oF6e8mHpKGdb8pjeZ8hLhWxYmgPOEiuzMzf1dzEZXpUFetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657096; c=relaxed/simple;
	bh=AIVkug2vJfK1kkjVROGHj3pbwPQGLM2oRGiF3Almj/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPVYku/rivQmvk6Xr8zh06vUZfaw2VblbRc1cuQyDOX2gpKtVRqLrRYM0h5sGvY1Si9z5ox4vnykpSBHhQcnxM1BeTCBBhASS37jrESd99saAWgXauCWKiCe936bkK7wdvyUV6WCc6UNkzHoTiyF4JI8T7926L+rEUtmx4K0xjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDezDFIf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDezDFIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755657095; x=1787193095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AIVkug2vJfK1kkjVROGHj3pbwPQGLM2oRGiF3Almj/Q=;
  b=PDezDFIfmLhbj26o8L0vh+kj6JUZNU1bU5y3BwpLcXQxVeuEmnAk58RM
   RvBfHU40p625ht7rKVcsjVOPpgTGJIExw3DfBlTr3e0usJv7cUhV6FByM
   /2YbpFJqQxBGpytpI7TI8q/aakg1mu1gAU/eB04YLGpuddYTPJMnjKow6
   rhBPBFJPJRorykJAZS6I7QLHz+XuuQvG6ViEgFraBOe7PuVa2CBjcmy6T
   Uamg5vlskt5/S21Azj24YXOwt69g/uHDkVJFd0RJpnuowLsYLeSCTqKp2
   Hzc49EK6mwswpfHM14d6Ly5n6coPJRBK4Vl6T5hrJIw7jJFn2g2T9xSjo
   Q==;
X-CSE-ConnectionGUID: O84Xy6h0RW2Z9PiP2OVW3A==
X-CSE-MsgGUID: sMvqzeSdRd+0kmZDr3g20Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57625434"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57625434"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 19:31:34 -0700
X-CSE-ConnectionGUID: xugsQn/+RiihOGkAUZ0y2g==
X-CSE-MsgGUID: 7iBbQKcnSQGBVNBvHEvI+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167628988"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2025 19:31:31 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 1/7] perf/x86/intel: Use early_initcall() to hook bts_init()
Date: Wed, 20 Aug 2025 10:30:26 +0800
Message-Id: <20250820023032.17128-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 'd971342d38bf ("perf/x86/intel: Decouple BTS
 initialization from PEBS initialization")' is introduced, x86_pmu.bts
would initialized in bts_init() which is hooked by arch_initcall().

Whereas init_hw_perf_events() is hooked by early_initcall(). Once the
core PMU is initialized, nmi watchdog initialization is called
immediately before bts_init() is called. It leads to the BTS buffer is
not really initialized since bts_init() is not called and x86_pmu.bts is
still false at that time. Worse, BTS buffer would never be initialized
then unless all core PMU events are freed and reserve_ds_buffers()
is called again.

Thus aligning with init_hw_perf_events(), use early_initcall() to hook
bts_init() to ensure x86_pmu.bts is initialized before nmi watchdog
initialization.

Fixes: d971342d38bf ("perf/x86/intel: Decouple BTS initialization from PEBS initialization")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 61da6b8a3d51..cbac54cb3a9e 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -643,4 +643,4 @@ static __init int bts_init(void)
 
 	return perf_pmu_register(&bts_pmu, "intel_bts", -1);
 }
-arch_initcall(bts_init);
+early_initcall(bts_init);
-- 
2.34.1

