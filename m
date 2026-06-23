Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB92BDC23;
	Tue, 23 Jun 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219763; cv=none; b=AL53SXkSqgZyU9Ub/C9S6odG45DYsX5Dqmsum0j32NUa79/NceIVU6gQmXshZaZqvNlO8r6EDrnXOHUJ8/ruIP+BPjLT/Go5XQhD+SC1VChFJcdi3bAxPtuLE+R4upu5ziWYVsm0uByVidW7Ew3cCwScRfMcg9ubikOphMXYefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219763; c=relaxed/simple;
	bh=hwjSxM3uxzDf28CFP1h1Hw1szG4yATblmPoKpz1TCK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fy1KvTce/tUtmatSaiP1W+zEgQlOqyus25QjMmccN7yUNI/9nMfeKAbe7VKbhS7uFkgzkyXmnRS8wTsP56XbTJQhpxakxQp+kg/99wRMcJNXoiEqrhaLGGvXwJx2d1eyw79sLvzNfH0scCxfE6A7t305wN0YN9PeadLmx/3AkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gq3zfF7r; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gq3zfF7r"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782219759; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EhqqbMTm4S0ZI5UEiS5qZmiEnmlwFTIr9bbjL1NKGzg=;
	b=gq3zfF7reDczda79i66tY5pbiX5BLaYVp0OeTmviY2dY8avgcSIP5qEIYS3Zamy8b1W6dNGPwADb7sE+ff7APcxuLoAsk2Willtm5GLayNVoeUsZt2uFaU3x731C5xJUFy8a/dtVEq/JbGv47fysAIgRpDSg2P2t8y3yKh+lMz4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X5UKIlL_1782219756;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X5UKIlL_1782219756 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 21:02:37 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/5] perf annotate: Add ARM64 data type profiling support
Date: Tue, 23 Jun 2026 21:02:29 +0800
Message-Id: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`perf test -v "perf data type profiling tests"` fails on ARM64:

    Basic Rust perf annotate test
    perf mem record -o /tmp/perf.data perf test -w code_with_type
    perf annotate --code-with-type -i /tmp/perf.data --stdio --percent-limit 1
    Basic annotate [Failed: missing target data type]

The root cause is that ARM64 lacks the instruction parsing infrastructure
required for data type profiling. Specifically:

  1. annotate_get_insn_location() cannot extract register numbers and
     memory offsets from ARM64 load/store instructions, because ARM64
     does not set objdump.register_char or objdump.memory_ref_char
     (unlike x86 which uses '%' and '(').

  2. arch_supports_insn_tracking() does not include ARM64, so
     find_data_type_block() cannot perform instruction-level type state
     tracking.

  3. init_type_state() has no ARM64 branch, leaving stack_reg as 0 (x0)
     after memset, which causes x0-based memory accesses to be
     misidentified as stack accesses.

As a result, perf annotate --code-with-type silently produces no type
annotations on ARM64, and the test grep for "# data-type: struct Buf"
fails.

This series adds ARM64 data type profiling support following the PowerPC
model: decode raw 32-bit instruction words rather than parsing objdump
text. ARM64's fixed-width encoding and trivial DWARF register mapping
(x0-x30 = DWARF 0-30) make this approach clean and robust.

Three classes of instructions are tracked for register state propagation:
  - ADRP: compute PC-relative page address for global variable resolution
  - ADD (immediate): combine with ADRP result to form full variable address
  - MOV (register): propagate type state between registers

This covers the common `adrp + add + ldr/str` pattern that ARM64
compilers emit for global variable access.

Known limitations:
  - The `adrp + ldr` pattern (with :lo12: folded into the load offset,
    without an intermediate ADD) is not yet handled. This requires
    extending check_matching_type() to resolve TSR_KIND_CONST with the
    load offset, which can be added incrementally.
  - Pointer chain tracking (load-from-memory propagating type to the
    destination register) is not implemented, matching PowerPC's current
    scope.

Testing:
  All four sub-tests in `perf test "perf data type profiling tests"`
  pass reliably on ARM64 (AArch64, SPE-capable hardware):
    - Basic/Pipe Rust: struct Buf (code_with_type workload)
    - Basic/Pipe C: struct buf (datasym workload, global variable)

Patch breakdown:
  1/5  Widen type_state_reg::imm_value from u32 to u64 (prerequisite
       for storing 64-bit addresses from ADRP)
  2/5  Add arch__is_arm64() detection, raw instruction parsing from
       objdump output, and enable show_asm_raw for ARM64
  3/5  Add get_arm64_regs() to extract registers and memory offsets
       from load/store instruction encodings (4 addressing modes)
  4/5  Wire up ARM64 in annotate_get_insn_location(),
       arch_supports_insn_tracking(), and init_type_state()
  5/5  Main patch: instruction classification, ADRP/ADD/MOV register
       state tracking, and architecture initialization

Shuai Xue (5):
  perf annotate-data: Widen type_state_reg::imm_value to u64
  perf disasm: Add ARM64 architecture detection and raw instruction
    parsing
  perf dwarf-regs: Add ARM64 register and offset extraction from raw
    instructions
  perf annotate: Wire up ARM64 data type profiling infrastructure
  perf annotate-arch: Add ARM64 data type profiling support

 .../perf/util/annotate-arch/annotate-arm64.c  | 333 ++++++++++++++++++
 tools/perf/util/annotate-arch/annotate-x86.c  |   2 +-
 tools/perf/util/annotate-data.c               |  18 +-
 tools/perf/util/annotate-data.h               |   2 +-
 tools/perf/util/annotate.c                    |  12 +-
 tools/perf/util/disasm.c                      |  64 ++++
 tools/perf/util/disasm.h                      |   2 +
 .../util/dwarf-regs-arch/dwarf-regs-arm64.c   | 125 +++++++
 tools/perf/util/include/dwarf-regs.h          |   7 +
 9 files changed, 558 insertions(+), 7 deletions(-)

-- 
2.51.2.612.gdc70283dfc
