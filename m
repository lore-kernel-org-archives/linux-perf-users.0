Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6E3C2B8F;
	Tue, 26 May 2026 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830877; cv=none; b=c0RaXd/q3m928XKjuhZgXkv2+WoB2iYE5rqiF3XXSHCG1/+mtwR86CgJiyXxX71rXhlcdt2yC6x54pDQaBDE5rdSv3HL5QWViTPPeYf1PXrDvxXRVzVTXg/E2AMvlw6nq7tSXxTgqi/aPNgytAfh88rhb7WavN2+WybMlvKnEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830877; c=relaxed/simple;
	bh=dSHbHvZG3p7/g67zJ/H5Ga3AP9OeDKvrj5MYOEh4LXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4FUAjGqHACRIKCX7XUzMJJTaWWyAhe01aWRcFrcq8iK81vYF9pStFFPWXMWbyG54l3xj4OzWdCq/cgEctRzpLE3I7th0jSsupsO6zhvjD6ICD3n9Sv5JGPsL46jq2xkbSZr6ftYW9vTClpV7Lj2Qacn2cFOHIKHtHzYfqdKu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7HIBWGP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7HIBWGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779830875; x=1811366875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dSHbHvZG3p7/g67zJ/H5Ga3AP9OeDKvrj5MYOEh4LXM=;
  b=Q7HIBWGPtUtJ853nm6ckMza0+seXUEMGkfLVZUrA3X/5eLYpIjrBKRep
   Ofi+9/uAo5fKjmZCO/QVZGsdKxuY1GzN0gkeqwFBtom8l4mmRksKt0CtW
   q9poBtSwQ2gnWSOEbECFycXUITat0WZgFZBOF/jrfPV2nKLxt7V8rbO7q
   SOFTqxvjv7wSERFhks7k2ntCRWClwPp4El1KUKUKQIClh7AGT0jgrIrIa
   v03vxniOdETtpdxMUfwasnNHltAtSMu8aJpnbEJm/dkPllCFpkx1Ze42b
   EHjJMNLZ/Vkwjq8pdke3wOhBfJSEuBEKDbpW/xtRkRu6IJ5hPZS75BBZW
   w==;
X-CSE-ConnectionGUID: 66QQbhSpSJG662cm3J1dGw==
X-CSE-MsgGUID: gi5G4I4+Tpq1PYN73aajiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91764210"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="91764210"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:27:54 -0700
X-CSE-ConnectionGUID: /oedCxOyRGS6aKgHoguueg==
X-CSE-MsgGUID: MBiztqYGTR+c3X31G+tsJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="280158802"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:27:54 -0700
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
Subject: [PATCH V2 0/7] perf/x86/intel/uncore: Bug fixes and cleanups
Date: Tue, 26 May 2026 14:18:46 -0700
Message-ID: <20260526211846.121640-1-zide.chen@intel.com>
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

 arch/x86/events/intel/uncore.c           | 32 ++++++++++++++++++-
 arch/x86/events/intel/uncore.h           |  3 +-
 arch/x86/events/intel/uncore_discovery.c | 40 +++++++++++++++++-------
 arch/x86/events/intel/uncore_snb.c       |  7 -----
 arch/x86/events/intel/uncore_snbep.c     | 36 +++++++--------------
 5 files changed, 74 insertions(+), 44 deletions(-)

-- 
2.54.0

