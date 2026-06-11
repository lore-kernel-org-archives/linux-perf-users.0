Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719BE40BCD2;
	Thu, 11 Jun 2026 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194179; cv=none; b=ntgZjKbjp/Swjn7TSGnEyAgzL2JcLOsEhN6VVNf+yDvVBo8G2TF2xPe5PnrmGFUVeegEqw2UfpJ+sP8UTUbaPfaI3dDb2+gWDqss8Vr4qCLwHG936dIDvWzTMw9zAMA1ujuE6vDNZbWqBL8e2xvK8Mv0hVMLXB7mJFKB5FO1+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194179; c=relaxed/simple;
	bh=WFdZo5p0PFYwwfSxQG6g7SnKxMLInk68ZfsArdFh2Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkKYN1c1f8AsiaaPzI9ykgSlK0HkoWov9mZ9TJSkC9lOzNl/bPrY8RGY+w51zQd5g169V7i325PWRv9MaMS/md99ryaREtlM/hnDT3M2+v92DXBjQ2lhjukkD5ZYR21L5P2Sk1N7Q9k9bDHUTwha55xk8LHDQtyvA438XnXm0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODcWE3Ek; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODcWE3Ek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781194179; x=1812730179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WFdZo5p0PFYwwfSxQG6g7SnKxMLInk68ZfsArdFh2Ac=;
  b=ODcWE3EkCirHztmX0h0YFOyaeEbk07hbDErEOhWUna0KcdM/nWyMuVNb
   QkkbvQXI49GqR1UIMxzMvWKVkKrpX5lh+nXxnSxmtA7gORL14UEbgNwCm
   ppjgC4r494gHjb0btYq4uEATlMchbif+q6/EHv/QaDW41LKYhtaeW9oU2
   IUI/p+TcmqAjdBsRQ5tY7QLfdknLqzCoxTdKPPCVKvYTFUWsrYy+QID3P
   VkjGcAoT1pxoCA/KBVLYA/tJcEC+Qxf/gCKfwiETqxYe+Rks/XWnTfGrH
   djgiOL0Kycq09Sk2XG34ae9UGhbPFG90NzzY6tqs6TYkAA18HVXLiSxrm
   Q==;
X-CSE-ConnectionGUID: q/Fgwx0qQJGNcBej2fpzLA==
X-CSE-MsgGUID: VNDxZC+uRdOX6fiHNbhjBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81994957"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81994957"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:36 -0700
X-CSE-ConnectionGUID: nAw7bhIbQr6AS0biQkDSwQ==
X-CSE-MsgGUID: +2TdOfOLTcS7Xng08AGOkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246403586"
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
Subject: [PATCH v3 0/8] perf/x86/intel/uncore: PMU setup robustness fixes
Date: Thu, 11 Jun 2026 09:00:25 -0700
Message-ID: <20260611160033.66760-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes correctness issues in Intel uncore PMU setup:

- If all init_box() on a PMU fails, the PMU sysfs node may still exist,
  while perf events read zeros and silently report wrong data.
- If init_box() fails on only some dies, perf may return partial
  non-zero counts, which is harder to diagnose.
- CPU hotplug ref/unref ordering bugs can skip init_box() when the first
  CPU in a die comes online, and can call box_exit() prematurely when
  the second-to-last CPU goes offline.
- PCI PMU cleanup on setup failure has activeboxes leaks and potential
  NULL pointer dereference in error paths.

To address this, the series introduces a PMU broken state to track setup
failures and switches MSR/MMIO PMUs to lazy registration, matching
existing PCI behavior.

To avoid merge conflicts, this series should be applied after:
https://lore.kernel.org/lkml/20260527151154.130505-1-zide.chen@intel.com/
(textual conflict, no logical dependency)

Only cosmetic changes only in v3.

V3 changes:
- patch 2/8: Instead of removing atomic_inc(&box->refcnt) in PMU
  register, add the corresponding atomic_dec_return(&box->refcnt) in
  PMU unregister. (Dapeng)
- patch 6/8: Minor changes in code comments.
- patch 7/8: Minor changelog update. (Dapeng)
- Add Reviewed-by tags.

V2 changes:
- Add new patch 1 to fix PCI PMU cleanup issues (Sashiko)
- Keep pmu->activeboxes naming and semantics to avoid potential refcnt
  leaks in the uncore_pci_remove() path. To accomplish this, make the
  PMU broken flag sticky and decrement pmu->activeboxes on active box
  only.
- Update commit messages and changelogs according.

V2: https://lore.kernel.org/lkml/20260601170114.173359-1-zide.chen@intel.com/
V1: https://lore.kernel.org/lkml/20260512233048.9577-1-zide.chen@intel.com/
Sashiko's review: https://sashiko.dev/#/patchset/20260512233048.9577-1-zide.chen@intel.com

Zide Chen (8):
  perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure
  perf/x86/intel/uncore: Fix refcnt and other cleanups
  perf/x86/intel/uncore: Let init_box() callback report failures
  perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails
  perf/x86/intel/uncore: Factor out box setup code
  perf/x86/intel/uncore: Introduce PMU flags and broken state
  perf/x86/intel/uncore: Fix uncore_box ref/unref ordering
  perf/x86/intel/uncore: Implement lazy setup for MSR/MMIO PMUs

 arch/x86/events/intel/uncore.c           | 225 +++++++++++------------
 arch/x86/events/intel/uncore.h           |  39 +++-
 arch/x86/events/intel/uncore_discovery.c |  21 ++-
 arch/x86/events/intel/uncore_discovery.h |   6 +-
 arch/x86/events/intel/uncore_nhmex.c     |   3 +-
 arch/x86/events/intel/uncore_snb.c       |  82 ++++++---
 arch/x86/events/intel/uncore_snbep.c     |  77 +++++---
 7 files changed, 255 insertions(+), 198 deletions(-)

-- 
2.54.0

