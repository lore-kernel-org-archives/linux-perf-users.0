Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588503DC87B;
	Mon,  1 Jun 2026 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333807; cv=none; b=bD/ZNDSK8JEQym4uaVvYaTrQmRmYLQRHq6mqzVCGvPixHA/ir65OLE1TxqFVUn2yqriEky7f2zz4WEmdI1NQqW5yBIKD9CwxrXb2gk+cgvIaPklHHm0zsRfA+8JN1dQF7NJT7MSNAcabwOgc70PYd9rdan063g+4n+5p7troMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333807; c=relaxed/simple;
	bh=CWL1rtq9pVwepFgxU82PQCZiZFBXKjMZtNBPVpXoa2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjaUvHNR/vv4tPRoaWM7M6X7Ks8C3iMXdTJSxGVwVqGqM0AR1DxX/yILAnK7ANk4id38av0WVTmT+d4SwtDRPR59QN/ZwNFPPuAg3XkzjNj4g7rDFy4Q2sk2pTsUkqzhmowE3bm53RPsKUIIFs6wc+/This7X3W5SpcphRy21B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGB1eFUz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGB1eFUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780333807; x=1811869807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CWL1rtq9pVwepFgxU82PQCZiZFBXKjMZtNBPVpXoa2A=;
  b=TGB1eFUz+LQGE1dOFci5qu5yDBYIID/ZyWkYb9SqPE5WOvmK0bQy2Ebs
   T9eqwpnlj7ki+n71kPXUINkVrzJEUIusHEirJ4RiC0jYVgGwUG1fj/Ngk
   thfw2yMd4LKeQuTezVDPkXGIN6ZPpcYcV1YJlLsmFvq4ZarriKExG3PGd
   C7C5Q4r8HRQibXlSwM5MqhhZGK8KtOQeI+E9BRottO8wBmYpOIqOdAG4s
   mmCZiIgNr9VKnCEQzDUD/ZkLh3Ah2rcu4kSdiPUYa0GrCI5/3XGJ4CpIz
   ARlOAHX9r4vU0sN1oHnTkwOQUho97dNuzUUmCu27kxtOymfGZglODjF9f
   A==;
X-CSE-ConnectionGUID: tHHzCuQcQEi9iWyRqNq8Ww==
X-CSE-MsgGUID: 2S4Oft8rRdWdWN2xKpR9uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98516968"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98516968"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:06 -0700
X-CSE-ConnectionGUID: c5aaYsOWRCGKca10yQyaSQ==
X-CSE-MsgGUID: a1xSJbemS0+QM5oikBrPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242584993"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:05 -0700
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
Subject: [PATCH v2 0/8] perf/x86/intel/uncore: PMU setup robustness fixes
Date: Mon,  1 Jun 2026 10:01:06 -0700
Message-ID: <20260601170114.173359-1-zide.chen@intel.com>
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

V2 changes:
- Add new patch 1 to fix PCI PMU cleanup issues (Sashiko)
- Keep pmu->activeboxes naming and semantics to avoid potential refcnt
  leaks in the uncore_pci_remove() path. To accomplish this, make the
  PMU broken flag sticky and decrement pmu->activeboxes on active box
  only.
- Update commit messages and changelogs according.

V1: https://lore.kernel.org/lkml/20260512233048.9577-1-zide.chen@intel.com/
Sashiko's review: https://sashiko.dev/#/patchset/20260512233048.9577-1-zide.chen@intel.com

Zide Chen (8):
  perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure
  perf/x86/intel/uncore: Fix refcnt and other cleanups
  perf/x86/intel/uncore: Let init_box() callback report failures
  perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails
  perf/x86/intel/uncore: Factor out box setup code
  perf/x86/intel/uncore: Introduce PMU flags and broken state
  perf/x86/intel/uncore: Fix uncore_box ref/unref ordering on CPU
    hotplug
  perf/x86/intel/uncore: Implement lazy setup for MSR/MMIO PMU

 arch/x86/events/intel/uncore.c           | 222 +++++++++++------------
 arch/x86/events/intel/uncore.h           |  39 +++-
 arch/x86/events/intel/uncore_discovery.c |  21 ++-
 arch/x86/events/intel/uncore_discovery.h |   6 +-
 arch/x86/events/intel/uncore_nhmex.c     |   3 +-
 arch/x86/events/intel/uncore_snb.c       |  82 ++++++---
 arch/x86/events/intel/uncore_snbep.c     |  77 +++++---
 7 files changed, 254 insertions(+), 196 deletions(-)

-- 
2.54.0

