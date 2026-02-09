Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191131812C;
	Mon,  9 Feb 2026 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626347; cv=none; b=H/+urXLpo8qyR1xYsRL2EAk9OfZW7u+1imt68OBTE/uSM0ml2VL0KyOYuzdv19SvZGmzpdmOtQUkC6mVyw/q0rJFtWnMK/VlpScP3ITMDMgjMTb/M5N8ew6CNGWZM5wtB3sFQsS1eL236/XadMmgIx/zvwcq8wkRh6FMJwopSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626347; c=relaxed/simple;
	bh=l83SpEYGbz+gG1EE3f6jrYySXMD8MNJ2So7CHsS5HFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2bRcelGS+LI6RQbORHNEmFNDlIqRKWbHs2jz14z/E/4WlYzWqLMcgmwdTSKNw8JvWhUXvC0SSB9CkXs4eubm9WPe3RRW+f+ziIKXbybfj8YQEoKehK3ydlWNadNAnIdKbWtizO2ZaHCZajd+BFvtYhIiuwzBvzdgy1hoEoWLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVop+3/V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVop+3/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770626347; x=1802162347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l83SpEYGbz+gG1EE3f6jrYySXMD8MNJ2So7CHsS5HFg=;
  b=MVop+3/V+xPOncDUK2KfLNLj1lARchaXkhmRdHd3JgtJB66rJJd22gQI
   aVjglqyX81+c03T6ZU2022ZSP0SfDjA8jEOtD6sz8u24+84JT/HvtqlN/
   f+ZoOcMNiSZQokvikH/sOvKz+hC4N0Kfb5W+hJ0gdUXYATGvrr0/4Nk14
   TTsfq5WaMrcFf4sMvWvrrL2+2AUCaxlGzkw3ea9NjhKiZa3r6g7x+lo6A
   5RlvP4w7avpDwBDMnm4/pyezQkDga7XNRFKh3a93WT47QwRZysiArONm2
   E/G1DDJ8grcDi+Vlg1Qvqy4uJYFE/MfDLdUnTLNfOGCgePNVQN40+LxOa
   g==;
X-CSE-ConnectionGUID: DhKGh/MdTH6exCwiW+A08Q==
X-CSE-MsgGUID: l2BnmD28Ra61sxnaACPjfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75580699"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75580699"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:39:07 -0800
X-CSE-ConnectionGUID: ZJSCpHGXR8CzqYC5LwtulQ==
X-CSE-MsgGUID: kJYyaQ0TTPyM9suUYqQiVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211582187"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 00:39:04 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 0/4] Perf tools: Support eGPRs/SSP/SIMD registers sampling
Date: Mon,  9 Feb 2026 16:35:10 +0800
Message-Id: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set adds sampling support for x86 eGPRs/SSP/SIMD registers in
perf tools base on the corresponding sampling support for eGPRs/SSP/SIMD
registers in kernel[1]. In previous version, these perf-tools patches
are integrated as a whole patch-set with the kernel patches, but it's
split and posted to an independent perf-tools patch-set for convenient
review.

Changes since v5:
- Split the sampling support for eGPRs/SSP registers and SIMD registers
  into 2 patches.
- Address Ian's comments including,
  * Convert the architecture dependent functions into regular
    architectural independent functions, like whatperf_reg_name() does.
  * Refine the functions name to represent what the functions really do.
  * Add comments for some key functions arguments.
  * Misc enhancements.

History:
v5: https://lore.kernel.org/all/20251203065500.2597594-1-dapeng1.mi@linux.intel.com/
v4: https://lore.kernel.org/all/20250925061213.178796-1-dapeng1.mi@linux.intel.com/
v3: https://lore.kernel.org/lkml/20250815213435.1702022-1-kan.liang@linux.intel.com/
v2: https://lore.kernel.org/lkml/20250626195610.405379-1-kan.liang@linux.intel.com/
v1: https://lore.kernel.org/lkml/20250613134943.3186517-1-kan.liang@linux.intel.com/

Ref:
[1] Kernel patches of supporting eGPRs/SSP/SIMD registers sampling:
https://lore.kernel.org/all/20260209072047.2180332-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (2):
  perf regs: Support x86 eGPRs/SSP sampling
  perf regs: Support x86 SIMD registers sampling

Kan Liang (2):
  perf headers: Sync with the kernel headers
  perf regs: Enable dumping of SIMD registers

 tools/arch/x86/include/uapi/asm/perf_regs.h   |  49 +++
 tools/include/uapi/linux/perf_event.h         |  45 +-
 tools/perf/builtin-script.c                   |   2 +-
 tools/perf/util/evsel.c                       |  53 ++-
 tools/perf/util/parse-regs-options.c          | 168 ++++++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 412 +++++++++++++++++-
 tools/perf/util/perf_event_attr_fprintf.c     |   6 +
 tools/perf/util/perf_regs.c                   |  86 +++-
 tools/perf/util/perf_regs.h                   |  21 +-
 tools/perf/util/record.h                      |   6 +
 tools/perf/util/sample.h                      |  10 +
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/session.c                     |  86 +++-
 13 files changed, 888 insertions(+), 58 deletions(-)


base-commit: 335047109d7d488bf5ad32a4076e1a011994cd0e
-- 
2.34.1

