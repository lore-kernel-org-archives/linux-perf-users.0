Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484A374195;
	Fri, 17 Jul 2026 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275796; cv=none; b=XX4IqIMJW3JZQgAW2dZQn0V77sA3szWR7GCzGo2LGzwes/DH6hOWBt/ZtyXlEAI4Q2eRGa+rGALOk6WOOOIBEY5OuemYaMXflEBVt1+rzgMUWtEDadqpHBew8+xUBH1RdekHfGvRgyYis+wB2ORB2tqHy+xSjfLxg5N9G6Fplj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275796; c=relaxed/simple;
	bh=UsoviNLgCLj5sMDQH4SnQN9bu4OLeBLROGy+9+3GWi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j2C1qJjw0YbW79ByoQk6zKHXc0BFCB4+Sl7nElXgTOJEFMOmLDp7vY/l1dHYdVcEM0pqi80NJKoNDGxEw/nVIzHZA8X5jZ0pK1KZf6D+huzaVl8TRRo0/Q4FP16Agjq/jkMpmcobHrkEEf1QzYJDnQp+KWXDvUMTM+R+2l/4eZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOm+iJF9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOm+iJF9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275795; x=1815811795;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UsoviNLgCLj5sMDQH4SnQN9bu4OLeBLROGy+9+3GWi8=;
  b=XOm+iJF9uq6yov8WneeteDXf2PZtTJFagtoZ2t+m+TJFERNQZBgiOMoY
   q+yuDw3V2WO30ZRLcxl0Cn8HWLo+Pi8HWXphCqLsWTO1nfLg2wlIxpXnB
   zTV+b1xdbnMG7yn41yn7qej9eP26w8WZEZedvI8qKjRs4P73tBLE7dlVa
   r1jEuCdQKs+O8/rKAeJh1tTlt3MolWpI4DyvVYSoDlS/IZKFOeoWBAYA2
   V5XDMEbsUdxezdnUYyMBprcGhm+onZ2pjHcJubg+wiJNFvkRSf4e9ymXs
   GixK4HG8Y8Z8J1iYDGARmune5H0wh2TZXN5gmGFkOVz0ANwlG0IN5Gn9e
   g==;
X-CSE-ConnectionGUID: AamoAB2aRCu3YZxgEKD+Ig==
X-CSE-MsgGUID: tNsmPwvzTb2HRs9DW29Ygw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84065486"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84065486"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:09:54 -0700
X-CSE-ConnectionGUID: W6EE9194TGWRkB5ttJDWJg==
X-CSE-MsgGUID: jdC1UGFIQMyKXHcgqMmP+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="253315449"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2026 01:09:50 -0700
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
Subject: [Patch v3 0/8] perf/x86: Miscellaneous PMU bug fixes and optimizations 
Date: Fri, 17 Jul 2026 16:03:34 +0800
Message-Id: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
- Patch 6/8: Fix the typo in comments (Thomas).
- Patch 8/8: New patch which prevents drain_pebs() reentry.

Changes since v1:
- Patch 3/7: Ensure cpuc->pmu is not the static pmu before calling
  hybrid_pmu(cpuc->pmu) in intel_pmu_cpu_dead() (Sashiko).

This series fixes recently found x86 core PMU bugs. Most of bugs are
found by Sashiko in reviewing the "Support SIMD/eGPRs/SSP registers 
sampling for perf" patch-set, e.g.,
https://lore.kernel.org/all/20260706022123.480411F000E9@smtp.kernel.org/
https://lore.kernel.org/all/20260706021852.DE2ED1F000E9@smtp.kernel.org/

The patch 7/8 optimizes ACR handling in match_prev_assignment() and
mitigate the performance overhead.

The patch 8/8 enhances intel_pmu_drain_pebs_buffer() to prevent
drain_pebs() reentry.

Tests:
Below test cases are run on Diamonds and Novalake. No issues are found.
- Perf stat test
  $ perf test 119
- Perf record tests 
  $ perf test 155
- Perf record LBR tests
  $ perf test 156

History:
v2: https://lore.kernel.org/all/20260713082734.3162099-1-dapeng1.mi@linux.intel.com/ 
v1: https://lore.kernel.org/all/20260710065128.1799838-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (8):
  perf/x86: Unregister PMI handler on PMU init failure
  perf/x86: Free hybrid state on PMU init failure
  perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts
  perf/x86/intel: Unwind cpuc state if PEBS buffer setup fails
  perf/x86: Remove stale fixed counter helper and fix hybrid PMU access
  perf/x86/intel: Fix intel_cap handling on hybrid PMUs
  perf/x86: Optimize ACR handling in match_prev_assignment()
  perf/x86/intel: Prevent drain_pebs() reentry

 arch/x86/events/core.c       |  45 ++++++++++++----
 arch/x86/events/intel/core.c | 101 ++++++++++++++++++++++++++---------
 arch/x86/events/intel/ds.c   |   7 ---
 arch/x86/events/perf_event.h |  12 ++---
 4 files changed, 113 insertions(+), 52 deletions(-)


base-commit: edda9051e267b7390c7ce24b1b71434414ad156e
-- 
2.34.1

