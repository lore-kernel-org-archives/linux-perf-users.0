Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E22F8BC0;
	Mon,  6 Jul 2026 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305648; cv=none; b=eIkRk4QOItMD519B6rxDHt71+ztSGcQQLdKxd6V2G8++MI8mik8sDjFU0cPKKFtd2EsrKmzE/JWmmX7w+Ek+t7GS6oRuFq057/BUXcTH2tGJ/SbQq8/fQt3E81yoIOjvbU1fjiqXM7xDrxYFDyed9Hqc0L5twEfbOs3PLjbYj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305648; c=relaxed/simple;
	bh=kBwgmFUjJhmSFEwQL+/71jlxQ2lUEEHpgrEuRn9wFDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DB2V2+9xZ4ZFNXWmA4ovBjYFm2uQsc2gwIYsjBZv7PdJkYn6Qf6dnxeyyl1h0xLOe79cDaIskJb9ANTTMignJCa5R5uddaawQfN6TtqJs6G+BqDDW7mJFSR6Vs35EGUURAU3ahL/DrjB87qUyYhEPWr1WC853aorW9t4xlKMUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKbfuMz7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKbfuMz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783305646; x=1814841646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kBwgmFUjJhmSFEwQL+/71jlxQ2lUEEHpgrEuRn9wFDM=;
  b=GKbfuMz7uBmlLmigbYiaKNpl7KKFYltyzX+ibOTX+n0I3bxRmIQCIlKR
   VEsAM0/9egzUlQhRgPTPs3PDRVBM7EHizfyIfh3z0XjnPLfh+GISI7DhZ
   HJpuiFMSbTY2g44YWJzybh1ikWRtdKQ+Q6gfpb2IEqkHnM8yx15gelzv1
   1/eqUOx871jPkmwiAdDUD78Tt6aCuZDAUI031YEwAHqqAgBjxmzM8G2KV
   h74bvh/GSi04VOaAif7Sda7ciKvmT2hPjRaweSeG81rtuMvYN0/LtE/xm
   lDMfCubjgSAd/efdxenFyq+XrrF399X6CzXdBldmXmaEHFe4Z5xjF7vKM
   Q==;
X-CSE-ConnectionGUID: WgYpkKCPQga23gs8gpwsbA==
X-CSE-MsgGUID: x/hMnPoNQ6CkOt5aO7uO2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87614020"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87614020"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:40:45 -0700
X-CSE-ConnectionGUID: pcthy03LSQK9Vr71M656nQ==
X-CSE-MsgGUID: 2wJTyNLZQE+OMZL0qmILPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253716681"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 05 Jul 2026 19:40:42 -0700
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
Subject: [Patch v9 00/10] Perf tools: Support eGPRs/SSP/SIMD registers sampling
Date: Mon,  6 Jul 2026 10:34:34 +0800
Message-Id: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch layout:
- Patches 1-2: Fix two bugs in DWARF register bounds checking and event
  attribute printing/swapping.
- Patches 3-4: Sync tools and perf headers with the kernel sources.
- Patches 5-8: Add SIMD/eGPR/SSP sampling and dump support.
- Patches 9-10: Add unit tests for SIMD/eGPR/SSP sampling.

Changes since v8:
- Patch 01/10: Fix incorrect DWARF register bounds checking.
- Patch 02/10: Add missing event attribute printing and swapping support
  (Sashiko).
- Patch 07/10: Remove dead code ([idx++]) in SIMD register dumping
  (Sashiko).
- Patch 08/10: Restore the original x86 libdw_frame_nregs value (17), as
  libdw still lacks x86 SIMD/eGPR support (Ian).
- Patch 09/10: Add x86 eGPR/SSP sampling unit tests (Ian).
- Patch 10/10: Add x86 SIMD register sampling unit tests (Ian).

Changes since v7:
- Address Sashiko's comments including,
  * documents are not update availably; SIMD registers bitmask may be
    overwritten by shorter mask; u16 type in sample meta-data break the
    cross-endian conversion, etc.
- Add SIMD/eGPRs/SSP support in dwarf-regs (Ian).
- Misc enhancements.

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
v8: https://lore.kernel.org/all/20260529082451.591783-1-dapeng1.mi@linux.intel.com/
v7: https://lore.kernel.org/all/20260324005706.3778057-1-dapeng1.mi@linux.intel.com/
v6: https://lore.kernel.org/all/20260209083514.2225115-1-dapeng1.mi@linux.intel.com/
v5: https://lore.kernel.org/all/20251203065500.2597594-1-dapeng1.mi@linux.intel.com/
v4: https://lore.kernel.org/all/20250925061213.178796-1-dapeng1.mi@linux.intel.com/
v3: https://lore.kernel.org/lkml/20250815213435.1702022-1-kan.liang@linux.intel.com/
v2: https://lore.kernel.org/lkml/20250626195610.405379-1-kan.liang@linux.intel.com/
v1: https://lore.kernel.org/lkml/20250613134943.3186517-1-kan.liang@linux.intel.com/

Ref:
[1] Kernel patches of supporting eGPRs/SSP/SIMD registers sampling:
https://lore.kernel.org/all/20260706015439.3040804-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (10):
  perf dwarf-regs: Fix DWARF register index bounds check
  perf util: Add missed fields in _attr__fprintf() and __attr_swap()
  tools headers: Sync x86 headers with kernel sources
  perf headers: Sync perf_event.h/perf_regs.h with the kernel headers
  perf regs: Support x86 eGPRs/SSP sampling
  perf regs: Support x86 SIMD registers sampling
  perf regs: Enable dumping of SIMD registers
  perf dwarf-regs: Add SIMD/eGPRs support for x86 DWARF registers
  perf tests: Add x86 eGPRs/SSP registers sampling test
  perf tests: Add SIMD registers sampling test

 tools/arch/x86/include/asm/msr-index.h        |   7 +
 tools/arch/x86/include/uapi/asm/perf_regs.h   |  53 +++
 tools/include/uapi/linux/perf_event.h         |  49 ++-
 tools/perf/Documentation/perf-record.txt      |  10 +-
 tools/perf/builtin-script.c                   |  93 +++-
 tools/perf/tests/shell/record.sh              | 257 +++++++++++
 .../util/dwarf-regs-arch/dwarf-regs-csky.c    |   2 +-
 .../util/dwarf-regs-arch/dwarf-regs-powerpc.c |   2 +-
 .../util/dwarf-regs-arch/dwarf-regs-s390.c    |   2 +-
 .../util/dwarf-regs-arch/dwarf-regs-x86.c     | 140 +++++-
 tools/perf/util/dwarf-regs.c                  |   9 +-
 tools/perf/util/evsel.c                       | 104 ++++-
 tools/perf/util/header.c                      |   3 +-
 tools/perf/util/include/dwarf-regs.h          |   7 +-
 tools/perf/util/parse-regs-options.c          | 186 +++++++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 416 +++++++++++++++++-
 tools/perf/util/perf_event_attr_fprintf.c     |  13 +
 tools/perf/util/perf_regs.c                   |  84 +++-
 tools/perf/util/perf_regs.h                   |  21 +-
 tools/perf/util/record.h                      |   7 +
 tools/perf/util/sample.h                      |   5 +
 .../scripting-engines/trace-event-python.c    | 127 +++++-
 tools/perf/util/session.c                     | 112 ++++-
 tools/perf/util/synthetic-events.c            |  38 ++
 tools/perf/util/unwind-libdw.c                |   6 +-
 25 files changed, 1643 insertions(+), 110 deletions(-)


base-commit: ca0e19074bd6afcb9c7b23aa474ca17238cdb241
-- 
2.34.1

