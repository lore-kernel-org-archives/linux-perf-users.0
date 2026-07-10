Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314172E7394;
	Fri, 10 Jul 2026 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666653; cv=none; b=S3v2cMSyltoX9bh2/lBo0Yl03b7FEL0rJr8m3PRG35YksQpiFrDy1Gda+zN2/LjkTKCgKN8iZocdohJBniP2u8Snmu1gE6y2dNdpbpei7rmSBzvdiDfsCsFUeZBduI6OAk05sVosFcoZnSKb2WlAefN04hbfgAUC8kvH9GQ1qOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666653; c=relaxed/simple;
	bh=uZnoTJfE30td2XkES7GZp32oxMOVbViMTAWfJH9W6+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KfFjiYpm6M+hExTcna7MNnHKX8LjoBwkOVMTbZOaLzmW5ixM2fpcYkaM+102wfgppyXwj7GX8o4UErqRBZxGGJnkiwj1FpJVpA6rwy7TYBuPMwpyQNCtlMaaSnqAvoFSC0bm/VODe8B0+Qh4IFWERq4wjQNuRGHFHjQ2vMSTkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=av2h3T9E; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="av2h3T9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666652; x=1815202652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uZnoTJfE30td2XkES7GZp32oxMOVbViMTAWfJH9W6+0=;
  b=av2h3T9EwooLA9rTgFumNMfVqN8+ys9GgrE1GoOtd7Aj+hR1sAbk2EkY
   F0Kr3s8664+lrNqTlFgoGeV5oD/vyNI6aYAkMjURL4VvCek4pgSeifjOY
   HECYziPkauDeHGoeH+njuWM0KcS63ccSdL6Sc+ihYiIA3pPmRcDHopaKm
   65gW8M/M741e+THRJG6o9cqGP/0EPozDfHkXtebn6upkhJVWAmjknpuhx
   1zQv6Gt2YUbVIzm3G7b0Uiq8ILDl32vSXRjF6LGyHWI81nBrURDGNn7PQ
   0ZhKQiyUPrwf5bdtazHiYOAYQHULzTAF/kYBdcNfBUCywoPG7MkZ61bC2
   w==;
X-CSE-ConnectionGUID: nmWKWBs/RZGDs1krqOzLiw==
X-CSE-MsgGUID: vxqSddgYTv+2GjYYTgXV8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84554184"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84554184"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:57:31 -0700
X-CSE-ConnectionGUID: hfYuSsTTTq6cDqLRkwH3xQ==
X-CSE-MsgGUID: R03SBPRNSgm7e50dNRRt7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252159153"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2026 23:57:26 -0700
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
Subject: [PATCH 0/7] perf/x86: Miscellaneous PMU bug fixes and optimizations
Date: Fri, 10 Jul 2026 14:51:21 +0800
Message-Id: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes recently found x86 core PMU bugs. Most of bugs are
found by Sashiko in reviewing the "Support SIMD/eGPRs/SSP registers 
sampling for perf" patch-set, e.g.,
https://lore.kernel.org/all/20260706022123.480411F000E9@smtp.kernel.org/
https://lore.kernel.org/all/20260706021852.DE2ED1F000E9@smtp.kernel.org/

The last patch 7/7 optimizes ACR handling in match_prev_assignment() and
mitigate the performance overhead.

Tests:
Below test cases are run on Diamonds and Novalake. No issues are found.
- Perf stat test
  $ perf test 119
- Perf record tests 
  $ perf test 155
- Perf record LBR tests
  $ perf test 156

Dapeng Mi (7):
  perf/x86: Unregister PMI handler on PMU init failure
  perf/x86: Free hybrid state on PMU init failure
  perf/x86/intel: Clear cpuc->pmu on hybrid PMU init failure
  perf/x86/intel: Unwind cpuc state if PEBS buffer setup fails
  perf/x86: Remove stale fixed counter helper and fix hybrid PMU access
  perf/x86/intel: Fix intel_cap handling on hybrid PMUs
  perf/x86: Optimize ACR handling in match_prev_assignment()

 arch/x86/events/core.c       | 40 ++++++++++++++++++-------
 arch/x86/events/intel/core.c | 58 ++++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h | 11 ++-----
 3 files changed, 73 insertions(+), 36 deletions(-)


base-commit: edda9051e267b7390c7ce24b1b71434414ad156e
-- 
2.34.1

