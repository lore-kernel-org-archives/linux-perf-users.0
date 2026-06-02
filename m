Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B426FA7A;
	Tue,  2 Jun 2026 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412276; cv=none; b=CXoeLjNvCpDTubu4FUSlZ8AOF/l4NBVj14NocOQH1JG9saoU1PYlK50EDIi2luL9iYx6LJ/fHidiQwzn/1L20vZOnPINY4+ZvNTyc7TGqcfdYgvuQUBMe9u1kNFsqCEaTM1WRHOqsV/L2X0lC0q50DGSzzYmJcABKjDqS1jdr9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412276; c=relaxed/simple;
	bh=MiBW7CCsmRDVEIZUm0Q0llsZt3H87JfEvXiTJ/Ab1MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GacSBcv6A9UDY3KulZu62wh7vO3y3AKA+0X4qJ5uMhmNSgH7QlagPAcW5cleE6oj+HxYlURYbr0meG3zVHE0Q4i7PDaW+uTv8Brs4ktYYB3a8ku96RfgWzyABqyGlrE/FG1D9AApN6G1hGxynQKETb79PbFLBLLsR32LnoQT3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z19bFmEv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z19bFmEv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780412275; x=1811948275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MiBW7CCsmRDVEIZUm0Q0llsZt3H87JfEvXiTJ/Ab1MY=;
  b=Z19bFmEvg8UfSXipELHmQmf//B3IlzOCwmA8qadXIrX9kq7sndRZwgja
   EM/MnAJM989BT+lbFwgjpLTESXxoYRvEJcki890Izk9vn2arl1pYi+t1I
   gVQMwqbTI65/FcPLBLHgVx0uy3UMZKps3Rsm93D9b19BDSE7ZDbHeglOC
   vRx2IxCRy+nxjb4H2/AfOmrypqHTSvXSceSBCrbsHOf5T6Zh2v8IRaHuc
   /1YYXu0RV7dFqsQDpL0t3eQquSqKQfHut/HyWqW9wo+ZExNxZZ2BoYqgk
   lCQt/W1gppVtT1JrwKxbCen6Z/suZD4Er890T8mkUTp+wwFvfPfOdhjk2
   w==;
X-CSE-ConnectionGUID: 4J1YAaC5TACVLQ11d/MG+g==
X-CSE-MsgGUID: v+MQ0dBHTmqfl9mrH3C3xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103859975"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="103859975"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:54 -0700
X-CSE-ConnectionGUID: M6zRH6FJSxqFtjFfNwuiPw==
X-CSE-MsgGUID: fGR3lDQ6S8Sb4xv16NW4DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243095616"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:54 -0700
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
Subject: [PATCH V3 0/7] perf/x86/intel/uncore: Bug fixes and cleanups
Date: Tue,  2 Jun 2026 07:49:01 -0700
Message-ID: <20260602144908.263680-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes bug fixes and cleanups for the Intel uncore PMU
driver.

- Patch 1 fixes a theoretical bug in discovery unit lookup on multi-die
  systems.
- Patch 2 guards against an invalid box control address.
- Patch 3 fixes a PCI device refcount leak in UPI topology discovery.
- Patch 4 works around a hardware issue on Raptor Cove CPUs.
- Patches 5-7 implement a global MSR init callback for GNR/GRR/SRF/CWF
  uncore.

Changes in v3:
- Protect uncore_discovery_pci() with cpus_read_lock(). (Sashiko)
- Add Fixes tag for patch 4/7 and 7/7. 
- Add the missing '---' in patch 5.

Changes in v2:
- Add patch 2 to guard against invalid box control address (Sashiko)
- Remove WARN_ON_ONCE() from patch 1
- Move cpus_read_{lock,unlock}() out of uncore_die_to_cpu() (Sashiko)

Zide Chen (7):
  perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
  perf/x86/intel/uncore: Guard against invalid box control address
  perf/x86/intel/uncore: Fix PCI device refcount leak in UPI discovery
  perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
  perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
  perf/x86/intel/uncore: Fix uncore_die_to_cpu() for offline dies
  perf/x86/intel/uncore: Implement global init callback for GNR uncore

 arch/x86/events/intel/uncore.c           | 32 ++++++++++++++++-
 arch/x86/events/intel/uncore.h           |  3 +-
 arch/x86/events/intel/uncore_discovery.c | 46 ++++++++++++++++--------
 arch/x86/events/intel/uncore_snb.c       |  7 ----
 arch/x86/events/intel/uncore_snbep.c     | 36 +++++++------------
 5 files changed, 76 insertions(+), 48 deletions(-)

-- 
2.54.0

