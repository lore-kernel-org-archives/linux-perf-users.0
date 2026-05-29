Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D03B635A;
	Fri, 29 May 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043419; cv=none; b=HHum699xLDu9OmN3PuTpEcfdmTeaqNTukcwq5DV4WGfmlQcMLja11lA2sg1RJZRwF9KkH9z0H8QZrINaDM30WRpUFfHm2/UGjQWgH0QTul4j2BWV5C7o8hYCwL+He6e3woFfkPHDn9QTNfGtTy51AAJ+WU867ZpJ6ZMZqfw+iXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043419; c=relaxed/simple;
	bh=ds7PgcE/5xf54LWyKZi47Zso7X5MaKGnDbPU3TZ4H4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gGaJ2voFPrQchpPIY0Dd0Zibnr/pQwShIujgdhcCN8XD15DS23nyEwEjox5+LtUoZgRad8dLDZM/jI4OKYyCMmp78vzboARO425CjOHkYsoov8TF7m+q8fQjBbU8doicJwqLqVDphKWHTlw0Nt2VaQVVDd6CtEMLyl2llcltrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5wpRgA5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5wpRgA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780043415; x=1811579415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ds7PgcE/5xf54LWyKZi47Zso7X5MaKGnDbPU3TZ4H4s=;
  b=k5wpRgA5hOCDI7LPhJHK8px66z1po1dGaa+jAVmmN1TxR2xNh0TbPfeJ
   XKbC20JBUgcTaoNWvUK5GguZv8+H6ZbsPQavsUx4axpxFF/lwdWv4eIw2
   bV47wwei/88t0SEbE66tYQKf53HY1xJmY69SVkASK0RCqnIkXeI9ZEZye
   Bcd0dsyxqcyx0/280SSUtpu6OlJiWshIwQOJt0Pc5ExEsOyPNybZeCar0
   bnMaqh42q7dUqWiRHYvx1xaFzocCzIzx/T5lJUGjlualKUA0qPYuhGytu
   NVYutMEozrOsBKMaw+/ERjMceNRpTrNcnxKTDv5gvKOoPyi4ZdraDzMEl
   g==;
X-CSE-ConnectionGUID: QfNTvxTyTr+735KbK08YOg==
X-CSE-MsgGUID: FSNUhCMmQ2G/KRD6z8EY9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81076310"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81076310"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:30:14 -0700
X-CSE-ConnectionGUID: h4dMMB5FQBukQlr04EkuSw==
X-CSE-MsgGUID: PIjsa0uRQ96pvjm/YTSsiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="247734773"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa005.jf.intel.com with ESMTP; 29 May 2026 01:30:09 -0700
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
Subject: [Patch v8 0/5] Perf tools: Support eGPRs/SSP/SIMD registers sampling
Date: Fri, 29 May 2026 16:24:46 +0800
Message-Id: <20260529082451.591783-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v7: https://lore.kernel.org/all/20260324005706.3778057-1-dapeng1.mi@linux.intel.com/
v6: https://lore.kernel.org/all/20260209083514.2225115-1-dapeng1.mi@linux.intel.com/
v5: https://lore.kernel.org/all/20251203065500.2597594-1-dapeng1.mi@linux.intel.com/
v4: https://lore.kernel.org/all/20250925061213.178796-1-dapeng1.mi@linux.intel.com/
v3: https://lore.kernel.org/lkml/20250815213435.1702022-1-kan.liang@linux.intel.com/
v2: https://lore.kernel.org/lkml/20250626195610.405379-1-kan.liang@linux.intel.com/
v1: https://lore.kernel.org/lkml/20250613134943.3186517-1-kan.liang@linux.intel.com/

Ref:
[1] Kernel patches of supporting eGPRs/SSP/SIMD registers sampling:
https://lore.kernel.org/all/20260529075645.580362-1-dapeng1.mi@linux.intel.com/


Dapeng Mi (5):
  perf headers: Sync perf_event.h/perf_regs.h with the kernel headers
  perf regs: Support x86 eGPRs/SSP sampling
  perf regs: Support x86 SIMD registers sampling
  perf regs: Enable dumping of SIMD registers
  perf dwarf-regs: Add SIMD/eGPRs support for x86 DWARF registers

 tools/arch/x86/include/uapi/asm/perf_regs.h   |  51 +++
 tools/include/uapi/linux/perf_event.h         |  49 ++-
 tools/perf/Documentation/perf-record.txt      |  10 +-
 tools/perf/builtin-inject.c                   |   7 +
 tools/perf/builtin-script.c                   |   2 +-
 .../util/dwarf-regs-arch/dwarf-regs-x86.c     | 138 +++++-
 tools/perf/util/dwarf-regs.c                  |   7 +-
 tools/perf/util/evsel.c                       | 104 ++++-
 tools/perf/util/header.c                      |   3 +-
 tools/perf/util/include/dwarf-regs.h          |   7 +-
 tools/perf/util/intel-pt.c                    |   1 +
 tools/perf/util/parse-regs-options.c          | 184 +++++++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 416 +++++++++++++++++-
 tools/perf/util/perf_event_attr_fprintf.c     |   6 +
 tools/perf/util/perf_regs.c                   |  84 +++-
 tools/perf/util/perf_regs.h                   |  21 +-
 tools/perf/util/record.h                      |   7 +
 tools/perf/util/sample.h                      |   5 +
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/session.c                     |  91 +++-
 tools/perf/util/synthetic-events.c            |  28 ++
 tools/perf/util/unwind-libdw.c                |   6 +-
 22 files changed, 1143 insertions(+), 86 deletions(-)

-- 
2.34.1

