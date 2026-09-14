Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEBC2F7445;
	Mon, 14 Sep 2026 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350462; cv=none; b=R9kPA9/RsfyUo2PyuoDrM1/eR1hGdEpCy/QB8c0F4T0WhbAjRApRoUTBGfSgggDdbJaJMz9QV99utagmSAnou3pCqaYDUbWzDKGDYP+1Ys3Xi9cUkM2MS8AUPMJnSF+C3w2Ua5dG3LVCW9qeOHvh+kq31m+RcrGhWpRNrUkNOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350462; c=relaxed/simple;
	bh=BIf5NyOpqtxJcK0D3YS75naKs2/t1FiAg8v+emN1H4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OvjXxfASkwEdX6ZD42mN0NtxOSeHnvftYsgWLL/9bPn7Y896/O8kzMDKOf9QaJqhwYg1g13PLVb2ruMct9C5XK7e4R9jDDVLQ0Y5vy0h19u+s+oDWmAXtdH/myOeFD/Da7YJOJ46f6F0KmWfGBs/hxesXGfli9y+TbjD44vZHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvlywWNB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvlywWNB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789350460; x=1820886460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BIf5NyOpqtxJcK0D3YS75naKs2/t1FiAg8v+emN1H4g=;
  b=KvlywWNBanVyHEOtR9LFcsAv9dNrWND7+8xJOArl6agshBbhYOjcxJTN
   /5BEFLATzZdD53DTxgP3QJy4RTYaTOmaqe39TPVHZwSzosb020TnL4L5I
   HCMu15GlPeGQHXyjUOTVHQKeOZp79h3m0pNhqFyTeQ9zXQ6LTlZ92Bpfw
   Q/bfMiYbRYCHSwrKFIS9SVxyqp/mCLYxgSK+TA9NoGWSdEnZ3oPeT5Eyl
   isno+gv+s2JnY7ppMpgCnUFXN8HogBugJdy0o6oE7FvfEC7c41h9hmnI7
   WxaHRN/JnOxU6TLX4n3dBNxXLBIk7W2kTx8/YNQ5oJPwmcVauWQkONlXI
   w==;
X-CSE-ConnectionGUID: elklhEwKTVqEP71huz0+4Q==
X-CSE-MsgGUID: jcgBiz8gT0qx9z0mLSa4eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93530594"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93530594"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:47:36 -0700
X-CSE-ConnectionGUID: lyAxTpjVTNyA6HkRC45Kpg==
X-CSE-MsgGUID: ztJ2CDL/ToKvVWSHbyy9VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276664146"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2026 18:47:33 -0700
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
Subject: [Patch v11 00/10] Perf tools: Support eGPRs/SSP/SIMD registers sampling 
Date: Mon, 14 Sep 2026 09:40:39 +0800
Message-Id: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
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

Changes since v10:
- Patch 05/10: Change evsel__is_hardware_event() to
  evsel__is_non_software_event() to avoid the issue that cpu_atom type
  events (type = 10) are recognized to software events incorrectly.
- Patch 09/10: Refine APX/SSP registers sampling test with
  perf_record_with_retry() (Sashiko).
- Patch 10/10: Refine SIMD registers sampling test with
  perf_record_with_retry() (Sashiko).

Changes since v9:
- Patch 05/10: Fix the issue that cpu-clock/task-clock fails to sample
  GPRs.
- Patch 06/10: Ensure sample_intr_{pred|vec}_regs and
  sample_user_{pred|vec}_regs to keep identical if both are set since
  they share sample_{pred|vec}_reg_qwords.

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
v10: https://lore.kernel.org/all/20260721072707.3787848-1-dapeng1.mi@linux.intel.com/
v9: https://lore.kernel.org/all/20260706023444.3067660-1-dapeng1.mi@linux.intel.com/
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
https://lore.kernel.org/all/20260824082731.1013973-1-dapeng1.mi@linux.intel.com/

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
 tools/include/uapi/linux/perf_event.h         |  49 +-
 tools/perf/Documentation/perf-record.txt      |  10 +-
 tools/perf/builtin-script.c                   |  93 +++-
 tools/perf/tests/shell/record.sh              | 257 +++++++++++
 .../util/dwarf-regs-arch/dwarf-regs-csky.c    |   2 +-
 .../util/dwarf-regs-arch/dwarf-regs-powerpc.c |   2 +-
 .../util/dwarf-regs-arch/dwarf-regs-s390.c    |   2 +-
 .../util/dwarf-regs-arch/dwarf-regs-x86.c     | 140 +++++-
 tools/perf/util/dwarf-regs.c                  |   9 +-
 tools/perf/util/evsel.c                       | 108 ++++-
 tools/perf/util/evsel.h                       |   7 +
 tools/perf/util/header.c                      |   3 +-
 tools/perf/util/include/dwarf-regs.h          |   7 +-
 tools/perf/util/parse-regs-options.c          | 210 ++++++++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 436 +++++++++++++++++-
 tools/perf/util/perf_event_attr_fprintf.c     |  13 +
 tools/perf/util/perf_regs.c                   |  84 +++-
 tools/perf/util/perf_regs.h                   |  21 +-
 tools/perf/util/record.h                      |   7 +
 tools/perf/util/sample.h                      |   5 +
 .../scripting-engines/trace-event-python.c    | 127 ++++-
 tools/perf/util/session.c                     | 112 ++++-
 tools/perf/util/synthetic-events.c            |  38 ++
 tools/perf/util/unwind-libdw.c                |   6 +-
 26 files changed, 1698 insertions(+), 110 deletions(-)

-- 
2.34.1

