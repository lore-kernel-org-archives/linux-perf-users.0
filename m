Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8AB4266B1;
	Thu, 11 Jun 2026 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194182; cv=none; b=VWLQfrtUiD3KbZjFti2wc/1Qk/RWi18zATod5BRNoHmln3nsDwkrl+KV9WAcluQBHMC/Hp3GHJV8EaB9NdDxWcRnMTG7r3Q/5uWEvaEizfP8J19+aWNpflZeuHoc6EQVLSE6b4NX5UdZR+3iu1aWTqXwixPg8hhViRvYH+/57GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194182; c=relaxed/simple;
	bh=vaWDWWcVLn6MZyYvuB4lN5WTwT09g4gPSBBMVuMEjRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1yUno0xEkow05hOLG/TYFkm+rkDMIJFQMAG+Kw0mzxXRGapicKr8wFvfJ5nsmN/jKm1RpOlcyg1vJu2pTntP1IYGxTrq4LzeIup7J4xCv8JSGmwZO1URyPLxjTqqWspfO7BKkmYUg0VYFF1ZqalhkmMNwclmtdaeml4ZQCAKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEk8+OHz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEk8+OHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781194182; x=1812730182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vaWDWWcVLn6MZyYvuB4lN5WTwT09g4gPSBBMVuMEjRw=;
  b=aEk8+OHze9jvI2fUD3V/p9tJ5dfwXdUJMfQwg0tgdiqMOl1iRwJWsjkN
   TEy+3l0ug9If9doQsDrLmPzVMWYpt7iyCgfb0QpnqE+Lc1Ju7HzKbiSiD
   Lq70YUQKMDNbHtjsBMQe93CQY9iF9w3k0MkLcNBDMvyuLUkwfa6MYvidA
   9/D0OLD6qrQrKNMX4xdyndKEGXuVyVVE5NCEo7gxfZln93WzZvVWGr/8/
   s0S8VnPzLQNhsyOb3N0Z5OPBzF6rUWZlfpG9jSGz0MWjr1Q5odi5yTlDF
   hxN+Rclp8MB0XWYV2faIU/h6jpyMVHcu3+jNmG9z4wwbKYAcuc4Arwqer
   w==;
X-CSE-ConnectionGUID: gZgLKW81Q2ei5rerujH9wA==
X-CSE-MsgGUID: Uc5NzY1IQQ+XCVg0JDfz3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81994979"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81994979"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:36 -0700
X-CSE-ConnectionGUID: FfNkKHtUQD6N6e82v7IN2A==
X-CSE-MsgGUID: 8YsHfld9RxWStxUbN/298Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246403598"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:36 -0700
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 4/8] perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails
Date: Thu, 11 Jun 2026 09:00:29 -0700
Message-ID: <20260611160033.66760-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611160033.66760-1-zide.chen@intel.com>
References: <20260611160033.66760-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uncore_event_cpu_online() returns -ENOMEM early when both the MSR and
MMIO box allocations fail.  This also aborts PCI uncore setup, even
though PCI PMUs are independent of the MSR/MMIO paths.

Remove the early return so PCI uncore setup always runs regardless
of whether MSR or MMIO box allocation succeeds.

Fixes: 3da04b8a00dd ("perf/x86/intel/uncore: Support MMIO type uncore blocks")
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3: Add Reviewed-by tag.
---
 arch/x86/events/intel/uncore.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 21c8ed1628cb..eae335df7634 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1636,8 +1636,6 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	die = topology_logical_die_id(cpu);
 	msr_ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
 	mmio_ret = uncore_box_ref(uncore_mmio_uncores, die, cpu);
-	if (msr_ret && mmio_ret)
-		return -ENOMEM;
 
 	/*
 	 * Check if there is an online cpu in the package
-- 
2.54.0

