Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24037C912;
	Tue, 24 Mar 2026 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314081; cv=none; b=c7ZGmBdS6uoOzWo1jFHjfGUtj1NMk+i2CDvoytlJRv9n0O4wOtuhxPeES7jry0vTBP8+JKiNV4VxFULOWtcPFwn1IZavuhdxNZoRCZZCuRxc5cVp1jC2/f8nkoLzMAXIT0NIeogUi0BO8WRdOYXqGcBIGPJXCx7IZqupi+q9wgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314081; c=relaxed/simple;
	bh=1Ec/PR7WgD5ZfpB5MQnFxQ3/vzqebW9pYmbViEjrxZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jN41SkfH08MT+9i/Q7Du8rrXNSq/PQkVQqBIoFL1+uLlRWHaBqKMmzlLHMjAKM7DZm8Y7mOQ/awClDMj/r7ygMHxif1k2flTUS1XLnoEpzxRdyeO0L0pUn6e8n1t9m4iaCBsHJqJTkHAyB+q87q7tmeucCwz9uSyMN7h4qje0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fegGrr2M; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fegGrr2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774314080; x=1805850080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Ec/PR7WgD5ZfpB5MQnFxQ3/vzqebW9pYmbViEjrxZU=;
  b=fegGrr2MVAOqzLyF76MVGaScvDUPz9qtEnboSIe/GrFtsBq/CWUcNLU4
   5fepZeneT/BZC9O0PIUZItHsheEmNTOl/stnnH0issANvOW/vqVfBUw1+
   oDLEhmsWXb66Yqxl8GJYFULXl5WdX3zYOYT+xNXtabNw6vKtLj4vB+PHn
   z9WALUSTtj+d0F75izcv+HtzD/6NcCyD5AiPERKbZmgmN4aYoKmISCJ0u
   FHt1qqm/uw8O6fRvd0hvS8bVRDL08J+ZF6fBZ5xZp4ps7CIVNVGml4ZRe
   FyskX5cfd350lwb+sQoxIvC1/G9AzaQ6MBoKWC+D0gG8I6jkn1oa3DHlI
   g==;
X-CSE-ConnectionGUID: SC+755sXT/K9A1R04ZbyOg==
X-CSE-MsgGUID: l0rnF8ZVSb6bTkpEwyiQCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75441689"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75441689"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 18:01:19 -0700
X-CSE-ConnectionGUID: pyynnY4FRvi7R/GIPh+9qA==
X-CSE-MsgGUID: 95QEYumASFG8jOa8GsxdoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228263210"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 18:01:13 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 0/4] Perf tools: Support eGPRs/SSP/SIMD registers sampling
Date: Tue, 24 Mar 2026 08:57:02 +0800
Message-Id: <20260324005706.3778057-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v6:
- Address Ian's comments including,
  * Add more comments for newly added register indexes (patch 1/4).
  * Several minor enhancements in patch 4/4.
- Limit dwarf minimal regs to legacy GPRs (excluding APX eGPRs)
  (patch 2/4).

Changes since v5:
- Split the sampling support for eGPRs/SSP registers and SIMD registers
  into 2 patches.
- Address Ian's comments including,
  * Convert the architecture dependent functions into regular
    architectural independent functions, like whatperf_reg_name() does.
  * Refine the functions name to represent what the functions really do.
  * Add comments for some key functions arguments.
  * Misc enhancements.

This patch-set adds sampling support for x86 eGPRs/SSP/SIMD registers in
perf tools base on the corresponding sampling support for eGPRs/SSP/SIMD
registers in kernel[1]. In versions before v6, these perf-tools patches
are integrated as a whole patch-set with the kernel patches, but it's
split and posted to an independent perf-tools patch-set for convenient
review.

History:
v6: https://lore.kernel.org/all/20260209083514.2225115-1-dapeng1.mi@linux.intel.com/
v5: https://lore.kernel.org/all/20251203065500.2597594-1-dapeng1.mi@linux.intel.com/
v4: https://lore.kernel.org/all/20250925061213.178796-1-dapeng1.mi@linux.intel.com/
v3: https://lore.kernel.org/lkml/20250815213435.1702022-1-kan.liang@linux.intel.com/
v2: https://lore.kernel.org/lkml/20250626195610.405379-1-kan.liang@linux.intel.com/
v1: https://lore.kernel.org/lkml/20250613134943.3186517-1-kan.liang@linux.intel.com/

Ref:
[1] Kernel patches of supporting eGPRs/SSP/SIMD registers sampling:
https://lore.kernel.org/all/20260324004118.3772171-1-dapeng1.mi@linux.intel.com/


Dapeng Mi (2):
  perf regs: Support x86 eGPRs/SSP sampling
  perf regs: Support x86 SIMD registers sampling

Kan Liang (2):
  perf headers: Sync with the kernel headers
  perf regs: Enable dumping of SIMD registers

 tools/arch/x86/include/uapi/asm/perf_regs.h   |  51 +++
 tools/include/uapi/linux/perf_event.h         |  50 ++-
 tools/perf/builtin-script.c                   |   2 +-
 tools/perf/util/evsel.c                       |  70 ++-
 tools/perf/util/parse-regs-options.c          | 171 ++++++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 416 +++++++++++++++++-
 tools/perf/util/perf_event_attr_fprintf.c     |   6 +
 tools/perf/util/perf_regs.c                   |  84 +++-
 tools/perf/util/perf_regs.h                   |  21 +-
 tools/perf/util/record.h                      |   6 +
 tools/perf/util/sample.h                      |  10 +
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/session.c                     |  75 +++-
 13 files changed, 912 insertions(+), 52 deletions(-)


base-commit: ca76fb67ebdd5e1a30a242d06dc096fddd670734
-- 
2.34.1

