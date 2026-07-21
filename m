Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865A41DEEF;
	Tue, 21 Jul 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619229; cv=none; b=mrFXp2WMajckXqwHcbvAIprHOFljhydX8Hol9GYKnFll7CMCsarIClDvdRG1io1Tn+RjpmidABsfbxQtuxoU1q1HHnu/sD5Cw+LZvaxfpVxEc3emdu9TzvGEnAFJpyEkixj8Bjeds/+UqkSoqPXGaMXTympDx+OSE3ij1ixPW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619229; c=relaxed/simple;
	bh=sbSGpOIWEz8pBHIeFgeE0Fcb25MqGtH5uS5jlpAK9Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RTSTa7UbmhK10Bc74W5nUPy2b4tNRn7cW/JzqrlDmT98nI2uvq0AfAbU9eGwys3CdI0kQBJgGEJNNbz2NDYvKegSIPzMz6pbqHt0L5814tDNoSIlxOvuxZb9gXT2dumKBLCoi/BdI//TuU/HgBblhSVKAoqZDNc2Gi4IkVIdPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+GPedKF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+GPedKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784619227; x=1816155227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sbSGpOIWEz8pBHIeFgeE0Fcb25MqGtH5uS5jlpAK9Hc=;
  b=i+GPedKFVjnA3yhaQoGD7saT82qPEUMoPm0xrdLCDpPp9uPgyjfTg0hM
   MYmmKzm8x3WQ27SUX46PsEHup67mSkBzXxLEumSlLVj1hPH+l26+q3iny
   SloI1fzYq+BPlXjm1Qo/AferuhNgb8RIhs29F1tgrK0GHq7juxpjRIHvn
   JT5d/M0zosYWURvU99tDCDh9RvTT5TQZhQVhqFQvfPOZGMI5L4axUDsqE
   8uICtZJ2RVvc89pa1E221C63bv45rS/5Dt0bziEjNu/Eey2q9lcJANxbF
   jDlgHTArIq/ga6q3Roea5KVOsSOXKCo56QTolmSZu6HUdCctfkjXIoyMH
   w==;
X-CSE-ConnectionGUID: RCmi2Z/MSGeKLFnnsQ0qkA==
X-CSE-MsgGUID: FzpSwVU3SF6rhS24l/dSFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84190098"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="84190098"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:33:46 -0700
X-CSE-ConnectionGUID: 2P5CEDTHTVaFzleem2n2GA==
X-CSE-MsgGUID: ABdxM7pTRzC7HCGzcpLULg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="256484423"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa010.jf.intel.com with ESMTP; 21 Jul 2026 00:33:43 -0700
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
Subject: [Patch v10 00/10] Perf tools: Support eGPRs/SSP/SIMD registers sampling 
Date: Tue, 21 Jul 2026 15:26:57 +0800
Message-Id: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
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
https://lore.kernel.org/all/20260721062506.3745816-1-dapeng1.mi@linux.intel.com/

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
 tools/perf/util/evsel.c                       | 106 ++++-
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
 26 files changed, 1696 insertions(+), 110 deletions(-)


base-commit: e01c7bd5b1eece254bcbf282db066b12c4815d21
-- 
2.34.1

