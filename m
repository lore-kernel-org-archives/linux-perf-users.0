Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63222F25F8;
	Tue,  3 Feb 2026 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086872; cv=none; b=cqq1ZoqAKh8pKJEwZPNhIvSpGR1XFq1uRLxltECNpj+OmDQXEOQM5yoA6/UQWhUaiehBNxE0LMFkRignS4PO9Y1mlV0bGesyDBfRxkS0vA/wQ53FhdiLZ77SiYpnsIeTfn484k0z80Sh1bnuJ4uiTJrbriWIMXa4rBBHwNilGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086872; c=relaxed/simple;
	bh=3MWDqfAiOl05f1xqVVZA4n5IjZ6LdE0DQsZtDWx3Bds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fA2g4PIxKcKvNsCsBty3Fgv/EUBx0ghBdS7XAi283GFwfQxyKjBDupzNd32OEOfT/dg8g1r81TC3JBBPoUoJLQ9526qHevIHKQgTe6XBnD1J3xGMJ8r4ziUsF+CCvNnQimiVh7erZQJSoFjVkKUT2lcO134bJ/Y2EjTgoApi4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLRlQ+l3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLRlQ+l3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770086871; x=1801622871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3MWDqfAiOl05f1xqVVZA4n5IjZ6LdE0DQsZtDWx3Bds=;
  b=BLRlQ+l3EdzLTsKuoZDwc10ayQIURVPKNMUjZii/NQT/oxAdI7+e8dsC
   XjdaFi6OSUwDORNcodeONECJKb/NIMniGqe+xVzzhVcUUS78F9eNOfeDL
   MHfH+OjP95a8lQ2sv0uEPB55AVDvxskESx83j/Wn8VUO3Z4MlOhVb8QaA
   1PbrtXJ5FPwyaWtt6+SosbuR3KyEklpYaxWlC9jFB/VrcehqKwCbf+DwX
   W8VQA1Rl/9du4n7ZrzSUN94+UeGXbRn/rByQQrglWCUu3+40wJ4lEhYrH
   pREOlR/Owy8j1qOgCpmL3bDabD0WsyDig2mOXZGDL83AHi4MDEYIaOz/5
   w==;
X-CSE-ConnectionGUID: rozIVrMGRwelFqI/al/neg==
X-CSE-MsgGUID: cNePsXRdQ5uQNqyn/E7leQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71152111"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71152111"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 18:47:50 -0800
X-CSE-ConnectionGUID: CwdI2bP1SrK5HF7IKM+DFA==
X-CSE-MsgGUID: ZoAomjiAQAu1YwAmfa/Q/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="208991699"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2026 18:47:43 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 0/4] Perf tools: perf-regs bug fix and optimization
Date: Tue,  3 Feb 2026 10:43:52 +0800
Message-Id: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
 v2 -> v3:
  * Fix the abort issue for "-I" or "--user-regs" options. (Patch 1/4)
  * Address Ian's comments.

 v1 -> v2:
  * Fixing "PERF_REG_EXTENDED_MASK" redefinition building error by
    changing the "asm/perf_regs.h" header path to relative UAPI path.
    (Patch 1/3)
  * Spliting xxx_reg_mask() and xxx_sdt_arg_parse_op() conversion into 2
    patches.

This patch-set remove the below three architecture specific __weak
functions and converted them into the general architecture specific
functions which are dispatched base on "em_machine".

uint64_t arch__intr_reg_mask(void);
uint64_t arch__user_reg_mask(void);
int arch_sdt_arg_parse_op(char *old_op, char **new_op);

The advantage of this conversion is that these architectural functions
can be called even for a different architecture with host instead of
only called on the host architecture.

Although the converted functions shown below can be called on any
architecture, currently they are still only called for the host
architecture (EM_HOST).

int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op);
uint64_t perf_intr_reg_mask(uint16_t e_machine);
uint64_t perf_user_reg_mask(uint16_t e_machine);

Tests:
  * This patch-set is only tested on x86 platforms. No issues are found
    for both intr-regs and user-regs options.
  * Tests on other architectures are welcomed and appreciated.

History:
  v1: https://lore.kernel.org/all/20260123090938.2222960-1-dapeng1.mi@linux.intel.com/
  v2: https://lore.kernel.org/all/20260127070259.2720468-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (4):
  perf regs: Fix abort for "-I" or "--user-regs" options
  perf arch: Update arch headers to use relative UAPI paths
  perf regs: Remove __weak attributive arch__xxx_reg_mask() functions
  perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function

 tools/perf/arch/arm/include/perf_regs.h       |   2 +-
 tools/perf/arch/arm/util/Build                |   2 -
 tools/perf/arch/arm/util/perf_regs.c          |  13 -
 tools/perf/arch/arm64/include/perf_regs.h     |   2 +-
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/perf_regs.c        | 141 ---------
 tools/perf/arch/csky/Build                    |   1 -
 tools/perf/arch/csky/include/perf_regs.h      |   2 +-
 tools/perf/arch/csky/util/Build               |   1 -
 tools/perf/arch/csky/util/perf_regs.c         |  13 -
 tools/perf/arch/loongarch/include/perf_regs.h |   2 +-
 tools/perf/arch/loongarch/util/Build          |   1 -
 tools/perf/arch/loongarch/util/perf_regs.c    |  13 -
 tools/perf/arch/mips/include/perf_regs.h      |   2 +-
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/perf_regs.c         |  13 -
 tools/perf/arch/powerpc/include/perf_regs.h   |   2 +-
 tools/perf/arch/powerpc/util/Build            |   1 -
 tools/perf/arch/powerpc/util/perf_regs.c      | 172 -----------
 tools/perf/arch/riscv/include/perf_regs.h     |   9 +-
 tools/perf/arch/riscv/util/Build              |   1 -
 tools/perf/arch/riscv/util/perf_regs.c        |  13 -
 tools/perf/arch/s390/include/perf_regs.h      |   2 +-
 tools/perf/arch/s390/util/Build               |   1 -
 tools/perf/arch/s390/util/perf_regs.c         |  13 -
 tools/perf/arch/x86/include/perf_regs.h       |   2 +-
 tools/perf/arch/x86/util/Build                |   1 -
 tools/perf/arch/x86/util/perf_regs.c          | 283 ------------------
 tools/perf/util/evsel.c                       |   4 +-
 tools/perf/util/parse-regs-options.c          |  13 +-
 .../util/perf-regs-arch/perf_regs_aarch64.c   | 139 ++++++++-
 .../perf/util/perf-regs-arch/perf_regs_arm.c  |   7 +-
 .../perf/util/perf-regs-arch/perf_regs_csky.c |   7 +-
 .../util/perf-regs-arch/perf_regs_loongarch.c |   7 +-
 .../perf/util/perf-regs-arch/perf_regs_mips.c |   7 +-
 .../util/perf-regs-arch/perf_regs_powerpc.c   | 183 ++++++++++-
 .../util/perf-regs-arch/perf_regs_riscv.c     |   7 +-
 .../perf/util/perf-regs-arch/perf_regs_s390.c |   7 +-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 281 ++++++++++++++++-
 tools/perf/util/perf_regs.c                   | 109 ++++++-
 tools/perf/util/perf_regs.h                   |  27 +-
 tools/perf/util/probe-file.c                  |   3 +-
 42 files changed, 787 insertions(+), 724 deletions(-)
 delete mode 100644 tools/perf/arch/arm/util/perf_regs.c
 delete mode 100644 tools/perf/arch/arm64/util/perf_regs.c
 delete mode 100644 tools/perf/arch/csky/Build
 delete mode 100644 tools/perf/arch/csky/util/Build
 delete mode 100644 tools/perf/arch/csky/util/perf_regs.c
 delete mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
 delete mode 100644 tools/perf/arch/mips/util/perf_regs.c
 delete mode 100644 tools/perf/arch/powerpc/util/perf_regs.c
 delete mode 100644 tools/perf/arch/riscv/util/perf_regs.c
 delete mode 100644 tools/perf/arch/s390/util/perf_regs.c
 delete mode 100644 tools/perf/arch/x86/util/perf_regs.c

-- 
2.34.1

