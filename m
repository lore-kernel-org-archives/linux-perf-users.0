Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614E266B67;
	Tue, 27 Jan 2026 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497593; cv=none; b=YvMXAXmEAH5YsX7AccDXuZB0nblNQGn9ZkkdJtPzJ9+nvnBFGToR74HbNcWJ9eqedBK+ICMr2JCPyDvgfZsLMUm2iHb81JWdYTsBIVTtgS191kGgT/3y+q9sf79xwGslCybO1Ufo6fnuvIN+wkMD6dUKIRuRd/pJ9+Rna2LKaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497593; c=relaxed/simple;
	bh=ACZftaD9x/8kasD2JGn/3hsCxktEdhw4iX+XDtFVowE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YiV/NPbp1EveGFlIAALiluS+e3le+Oet6zPALpxkIiiVuP2ocmpbWs/6gn8FY5tg8729inmgIaGv1k/Zk68VfCZB8itt1gneL7aqvy8JS/aJIULHoYexiH2HnCGeo1G0XX1j5uxB9qi8IFBoTZWNqR/PJn6qzSGJuJbizg5h778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abGaF53O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abGaF53O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769497591; x=1801033591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ACZftaD9x/8kasD2JGn/3hsCxktEdhw4iX+XDtFVowE=;
  b=abGaF53OsKbBT0zWgO9SpCpSkXRcCYesvk6lQcNhZa/SlmMkSACT8yXI
   /6LrXlQAo2RNEHHV9iEDvfdsCpHgtibR4hWStfuNI4Fxk1s5ilLthPWPn
   Y9Q8iu4K45uwZS0TMb2niClJKcN/9EvTUnK7nTw9NyucpW8jChd5VvbFv
   9KEiPAUkXSKOzQj6wrt9BNWyz01NzkhH3qv6b35I/V2p1E7jOGu9hSPIH
   tQH2AnWYzeF4SFKvTafSxi4CPsP48tPk/K+WYUDwc8cBGLvYfbmfJMt5+
   wUmARsVWBCK/a61uN5mpCe/0SGJqQAUeCGckcvZ9OQPc4K+dVS1Qz16Z6
   A==;
X-CSE-ConnectionGUID: ZhtlIfC/QKCa6pUedcJOUQ==
X-CSE-MsgGUID: Vflqmj0vSEGPeejZP0NMJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70742977"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70742977"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 23:06:29 -0800
X-CSE-ConnectionGUID: VmYqbMMUSaqYTGZ/i+axQQ==
X-CSE-MsgGUID: rVsPGBUkRDOElYJt+COD9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="208331249"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 26 Jan 2026 23:06:24 -0800
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
Subject: [Patch v2 0/3] Perf tools: remove arch-specific __weak
Date: Tue, 27 Jan 2026 15:02:56 +0800
Message-Id: <20260127070259.2720468-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

No functional changes are intended in this patch-set.

Please notice this patchset depends on Ian's two patchset,
[1] https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.com/
[2] https://lore.kernel.org/all/20260121021735.3625244-1-irogers@google.com/

Tests:
  * This patch-set is only tested on x86 platforms. No issues are found
    for both intr-regs and user-regs options.
  * Tests on other architectures are welcomed and appreciated.

Changes:
 v1 -> v2:
  * Fixing "PERF_REG_EXTENDED_MASK" redefinition building error by
    changing the "asm/perf_regs.h" header path to relative UAPI path.
    (Patch 1/3)
  * Spliting xxx_reg_mask() and xxx_sdt_arg_parse_op() conversion into 2
    patches.

History:
  v1: https://lore.kernel.org/all/20260123090938.2222960-1-dapeng1.mi@linux.intel.com/


Dapeng Mi (3):
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
 tools/perf/arch/csky/include/perf_regs.h      |   1 +
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
 tools/perf/util/parse-regs-options.c          |   2 +-
 .../util/perf-regs-arch/perf_regs_aarch64.c   | 137 ++++++++-
 .../perf/util/perf-regs-arch/perf_regs_arm.c  |   7 +-
 .../perf/util/perf-regs-arch/perf_regs_csky.c |   7 +-
 .../util/perf-regs-arch/perf_regs_loongarch.c |   7 +-
 .../perf/util/perf-regs-arch/perf_regs_mips.c |   7 +-
 .../util/perf-regs-arch/perf_regs_powerpc.c   | 176 ++++++++++-
 .../util/perf-regs-arch/perf_regs_riscv.c     |   7 +-
 .../perf/util/perf-regs-arch/perf_regs_s390.c |   7 +-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 281 ++++++++++++++++-
 tools/perf/util/perf_regs.c                   | 103 ++++++-
 tools/perf/util/perf_regs.h                   |  27 +-
 tools/perf/util/probe-file.c                  |   3 +-
 42 files changed, 767 insertions(+), 717 deletions(-)
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

