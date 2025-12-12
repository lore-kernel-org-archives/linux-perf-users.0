Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBD30CDA2;
	Fri, 12 Dec 2025 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573639; cv=none; b=jg0ftxdZ/1eww0LBY2ZMN+DWH02i06NOX4Jl7lhdZt/+d6Ojj/AEgvfvBqOr3lofqHdZy2X4f5mF96l6Xc4R92zQ8QWdUa4Zu7gsL87gmFbGu1kBNkCteo0/HzWBuvxuwcl0EaMWjOQiUq75sAp+9uSmzrZktwxrTxK686jiNFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573639; c=relaxed/simple;
	bh=lu53LNdB5yeIB6GV9z0XXcgch1GfGp3SwAw6IHPthJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNE+Usxdn+HhzvtRhlnDt2UdGN5GZOe805/13NdjSm6+ezaN4mKuH2tMGVDk55dPLjbACb4HB+EXmHXAeOTYfFDg27SVgMoKVA71NMj845JrcifFFNunop4lV9Ew7AHCPVrDNWwe8ZBMXjTn2UTpJBDVyGfCFGFbjp3729T7Ej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRN8nX+i; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRN8nX+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765573639; x=1797109639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lu53LNdB5yeIB6GV9z0XXcgch1GfGp3SwAw6IHPthJE=;
  b=CRN8nX+iH3Mhe/rIeihXTgsPk41w4p5iU3AR+m0GTBJI0HOlPZ1in/4p
   KCJTgEV8qJ/G9PUSTPSQP4Ju71a1+9QHHccjqo/TW3mVBYwRcSBevfZqz
   qg25aMtr2+NTGRgxEKZNDjR9FsarVLz82l/+RO2UvhZvMXSRPmjjJUblA
   l6bFx/SgeGt7tKd+kw0rtiGBIqFBkWumIdDyq9zReAUC9X1mug5QYtTgZ
   kC2uCOZKpPdI2xnNcHxCHWEKHBDX9269j4PDxoHzl9tyZgEbbrd3oHCdd
   274NgnZ3Kb4MEeLOWjGHRR5A9liv4H/1PM6dk/+5QSqmEp9C89SMii1ym
   A==;
X-CSE-ConnectionGUID: VXsRh16uQIe3YCky61Ocug==
X-CSE-MsgGUID: g9MANTdQSGK72CoqZn4xtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67333564"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="67333564"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:17 -0800
X-CSE-ConnectionGUID: 5P/EzDf2SSCXe4OGTU/SOQ==
X-CSE-MsgGUID: DUrP2z2BRH+ZDaUyTbcgJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="202269516"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:16 -0800
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
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: [PATCH 0/7] Add Diamond Rapids uncore support
Date: Fri, 12 Dec 2025 13:00:00 -0800
Message-ID: <20251212210007.13986-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to Intel Sapphire Rapids, Diamond Rapids relies on discovery
tables for uncore enumeration.  Key differences and additions include:

- DMR may have two Integrated I/O and Memory Hub (IMH) dies, which are
  separate from the compute tile (CBB) dies.  Each CBB die and each IMH
  die has its own dedicated discovery table.

- Unlike prior CPUs that retrieve the global discovery table portal
  exclusively through either PCI or MSR, DMR uses PCI for IMH PMON
  discovery and MSR for CBB PMON discovery

- DMR introduces several new PMON types, including SCA, HAMVF, D2D_ULA,
  UBR, PCIE4, CRS, CPC, ITC, OTC, CMS, and PCIE6.

- Unlike SPR, IIO free-running counters in DMR are MMIO-based.

Zide Chen (7):
  perf/x86/intel/uncore: Add dual PCI/MSR discovery support
  perf/x86/intel/uncore: Add IMH PMON support for Diamond Rapids
  perf/x86/intel/uncore: Add CBB PMON support for Diamond Rapids
  perf/x86/intel/uncore: Add freerunning event descriptor helper macro
  perf/x86/intel/uncore: Support IIO free-running counters on DMR
  perf/x86/intel/uncore: Update DMR uncore constraints preliminarily
  perf pmu: Relax uncore wildcard matching to allow numeric suffix

 arch/x86/events/intel/uncore.c           |  39 +-
 arch/x86/events/intel/uncore.h           |   3 +
 arch/x86/events/intel/uncore_discovery.c |  42 +-
 arch/x86/events/intel/uncore_discovery.h |   6 +-
 arch/x86/events/intel/uncore_snbep.c     | 558 ++++++++++++++++++++---
 tools/perf/util/pmu.c                    |  14 +-
 6 files changed, 548 insertions(+), 114 deletions(-)

-- 
2.52.0

