Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489EE32470F;
	Tue,  9 Jun 2026 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981663; cv=none; b=YOok0WmXheFIUnkC8NYGz3hBhf0vLCewD+MEdn2pdV6BCQxTaaT2gQaFgy1gbPG4sCnbszU71Ia83fKnSTlJ76nP/2kWinx8hxZchF+ViQFsEDw9tSYMc+0dOWmSYCWrv86xMWZwS05a+rKI8Vt99p2oDQVECOaudO3kPbs8G6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981663; c=relaxed/simple;
	bh=eKUhzsiAoVrplYNWLjFcONwl4NgJzonE9MJBFaWWNFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uo9kVZ6kYsAd+jTsR5vMlT3OZ61NN3XEdCr7zB4IFrWWwYwH6UUg3qLEz+C8OdGR+YvKdxtjdvbVRSn/p2shmHJqnGioXGQkdy36kM7QY/S3GnmsqTMyQJ1WTIPlorYwdCLHtxovxM93GgmEZr57I1xX5fgmackwNEV+eYxLZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbWcjXKZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbWcjXKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981661; x=1812517661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eKUhzsiAoVrplYNWLjFcONwl4NgJzonE9MJBFaWWNFQ=;
  b=LbWcjXKZ3O++FX5/GVW8uJitEB6+BTCl7ZKp05onFPG3zpPNSeHfxAkK
   92eRq9dNpOCZWH/369915//GoKfcYGacEJsrIwDksnYoNdNZAhv1cdiFb
   eenHXjCKlUbPScn6oJGU+qZEspmxADHtjRwbCLEs+i9ZN5uSQMUXrppy5
   qf0mbOuaqASUSH9lJX75dFVSSNfz3Fhsq1CKNT12qdv7OfAAltb6nfjjT
   8RwB1CyNys+l5DuSMIK4MndDFtFD1ZdVvmsE4hXGrUMwcYUB6h+m97mj3
   J/bG0xckeJYbzw646A53FPmnCE/Jo6x8xsyKO+CyxCz5VMiUzYoZRoucB
   w==;
X-CSE-ConnectionGUID: IfnPFqD6TlqTy5/gEX5Rsw==
X-CSE-MsgGUID: 03duYCoEQXa5T7gqsjILeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81586138"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81586138"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:07:40 -0700
X-CSE-ConnectionGUID: qzDCyhmWTh2VIe6K++Re+Q==
X-CSE-MsgGUID: pi5LGiEmS22SI/D6wXpRrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283838894"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 22:07:36 -0700
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
Subject: [Patch v2 0/9] perf/x86: Miscellaneous PMU bug fixes
Date: Tue,  9 Jun 2026 13:02:13 +0800
Message-Id: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series groups several independent PMU fixes to simplify review and
backporting.

Changes:
v1 -> v2:
- Fallback to software branch type decoding if hardware decoding is not
  suppprted (Sashiko patch 4/9).
- Drop kernel IP for PERF_SAMPLE_IP if exclude_kernel attribute is
  required (Sashiko, patch 8/9).
- Add kernel access check when kernel callchains are requested
  (Sashiko, patch 9/9)
- Address Zide and Thomas's comments.
- Collect Reviewed-bys.

Patch layout:
- Patch 1/9: Fix anythread_deprecated being overwritten issue. 
- Patches 2-3/9: Fix the issue that cap_user_rdpmc is not updated
  correctly.
- Patch 4/9: Fallback to software branch type decoding if no hardware
  decoding.
- Patch 5/9: Fix a kernel address leakage issue in LBR stack.
- Patch 6/9: Fix the issue that the return value of
  intel_pmu_init_hybrid() is not valiated correctly.
- Patch 7/9: Fix a "unchecked MSR access error" on PEBS_ENABLE MSR.
- Patch 8/9: Prevent a theoretical kernel register data leak in sampling.
- Patch 9/9: Add kernel access check when kernel callchains are
  requested.

History:
v1: https://lore.kernel.org/all/20260605011136.2043393-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (8):
  perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
  perf/x86: Update cap_user_rdpmc base on rdpmc user disable state
  perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
  perf/x86/intel: Drop LBR entries whose privilege level mismatches
    br_sel
  perf/x86/intel: Validate return value of intel_pmu_init_hybrid()
  perf/x86/intel: Drop fixed-counter PEBS constraints for baseline PEBS
  perf/core: Fix kernel register info leak via hardware skid
  perf/core: Check kernel access when kernel callchains are requested

Ian Rogers (1):
  perf/x86: Introduce is_x86_pmu() helper

 arch/x86/events/core.c       | 19 +++-------------
 arch/x86/events/intel/core.c | 43 ++++++++++++++++++++++++------------
 arch/x86/events/intel/ds.c   | 13 -----------
 arch/x86/events/intel/lbr.c  | 15 ++++++++++---
 arch/x86/events/perf_event.h | 25 +++++++++++++++++----
 kernel/events/core.c         | 41 +++++++++++++++++++++++++++-------
 6 files changed, 98 insertions(+), 58 deletions(-)

-- 
2.34.1

