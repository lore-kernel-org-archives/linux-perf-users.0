Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34047AF6E
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708945; cv=none; b=Ff/Z374jCpECAO/UMyL8Gx21+HQtpJY1YN3HxeOYclGk7KhwSiiH/CtfR3CeO74Gfec727MMgQOYk+uYobCxKRuTcMQVjfO3phEwQftPsMeAWfG9z/LR5S6kB/VmpCQKypfRA5v0YCPvjG5KdIBhRinzgWurbNIid7L+GWURMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708945; c=relaxed/simple;
	bh=JOo1yQs2l2oRgfRijQoo9XYYyEbxCG2mUEAAAxSlfP0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fS68jr+SCNG+96dKMIRsmpPyLYAIXnHHK5ydyTs/szy4s4yj2u7jUb5Uv2yET9Yj24TzXb6sE0NkQ+reoDg4r+rw8sd+w6ijfaaZJWqr6l3fo8J/HtftRM41UhFM9dHxRQkxvpQngnF0B1e21lhnASxIaTvUSi9bAWCk3ybtGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iQ0ofOzv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iQ0ofOzv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C2FF3589;
	Wed, 17 Jun 2026 08:08:58 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4D183FAA1;
	Wed, 17 Jun 2026 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781708942; bh=JOo1yQs2l2oRgfRijQoo9XYYyEbxCG2mUEAAAxSlfP0=;
	h=From:Subject:Date:To:Cc:From;
	b=iQ0ofOzvbOVhcVqpirlRkRXs7g01HZPLzdN9N2ubgeyk3AYSkEIjAJGnL/1TYLNux
	 iYpnP2BQH2ofHEtZ/G4cTR+eqbLGGE/ZHOiyyaXBf5mE8q+uh25j/uKq7kGc55DNuB
	 iUvIMfJM5QzMB5QGiQB9rT4vCHhFPlha0AHMKDV8=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v10 0/9] perf cs-etm: Support thread stack and callchain
Date: Wed, 17 Jun 2026 16:08:51 +0100
Message-Id: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIO4MmoC/5XPTQrCMBAF4KtI1kaSNM2PK+8hUtJpogFtS1KDI
 r27qSC1q+LyDY9vZl4o2uBtRPvNCwWbfPRdmwMl2w2Ci2nPFvsmDxAjTJCSUVxzbMKtgliBuV5
 zx7dVvPd9F4YqUcyAGUkk1TUAykgfrPOPz4bjKeeLj0MXnp+FSUzTLy3W6CQwwU47rl1ZgG6aQ
 27voLuhCU5yxgRdvTPJjNHaSElACWbsElP/YSpjspCaq1JxZ80S07/Y+pt6elM50+iCAqfFjI3
 j+AaMBaVTsgEAAA==
X-Change-ID: 20260521-b4-arm_cs_callchain_support_v1-2c2a70719bcc
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>, 
 Leo Yan <leo.yan@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781708939; l=7923;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=JOo1yQs2l2oRgfRijQoo9XYYyEbxCG2mUEAAAxSlfP0=;
 b=oKNiolK2QcCI4lplGGgL0ZbIUkx0lFSHLwMmLU05h4Awqn6HHSnm9dGVY0f05/mpNdxiD7vlj
 t8D2P9CAdriB6NoQqB99kNcyT+caKmZjGUf2zwLx7II2Jy+bw+nbDkB
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series adds thread-stack and synthesized callchain support for Arm
CoreSight, which comes from older series [1] but heavily rewritten.

CS ETM previously kept last-branch state in a per-trace-queue buffer.
That effectively makes the state per CPU, while the call/return history
belongs to a thread. This series moves branch tracking to the common
thread-stack code.

The series records CoreSight branches with thread_stack__event(), uses
thread_stack__br_sample() for last branch entries, flushes thread stacks
after decoder resets.

A decoder reset between AUX trace buffers is treated as a global trace
discontinuity, so all thread stacks are flushed, so avoids carrying
stale call/return history across a trace discontinuity.

One limitation remains for instructions emulated by the kernel. In that
case the exception return address may not match the return address
stored in the thread stack, because after exception return can be one
instruction ahead. The stack can still recover when a later return
matches an upper caller. Given emulated instructions are not the common
target for performance callchain analysis. Supporting this would require
extending the common thread-stack path to accept both the real target
address and an adjusted address for stack matching, so this series
leaves that extra complexity out.

The series has been tested on Orion6 board:

  perf test 136 -vvv
  136: CoreSight synthesized callchain:
  --- start ---
  test child forked, pid 3539
  ---- end(0) ----
  136: CoreSight synthesized callchain			: Ok

  perf script --itrace=g16i10il64

  callchain_test   17468 [005] 1031003.229943:         10 instructions:
              aaaac32507c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
              ffff90bd225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
              ffff90bd233c call_init+0x9c (inlined)
              ffff90bd233c __libc_start_main_impl+0x9c (inlined)
              aaaac3250670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)

  callchain_test   17468 [005] 1031003.229943:         10 instructions:
              aaaac3250774 do_svc+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              aaaac3250798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              aaaac32507b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              aaaac32507c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              ffff90bd225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
              ffff90bd233c call_init+0x9c (inlined)
              ffff90bd233c __libc_start_main_impl+0x9c (inlined)
              aaaac3250670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)

  callchain_test   17468 [005] 1031003.229944:         10 instructions:
          ffff800080010c20 vectors+0x420 ([kernel.kallsyms])
              aaaac3250784 do_svc+0x1c (/home/kernel/leoy/test_cs_callchain/callchain_test)
              aaaac3250798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              aaaac32507b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              aaaac32507c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              ffff90bd225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
              ffff90bd233c call_init+0x9c (inlined)
              ffff90bd233c __libc_start_main_impl+0x9c (inlined)
              aaaac3250670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)

Note, the test fails on Juno board which is caused by many discontinuity
packets (mainly caused by NO_SYNC elem). This is likely caused by the
FIFO overflow on the path.

[1] https://lore.kernel.org/linux-arm-kernel/20200220052701.7754-1-leo.yan@linaro.org/

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v10:
- Change to syscall(SYS_gettid) for build failure on x86 (James).
- Extracted sample thread stack into cs_etm__sample_branch_stack().
- Link to v9: https://lore.kernel.org/r/20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com

Changes in v9:
- Added patch 01 to fixed thread leak during trace queue init (sashiko).
- Added check in instruction and branch samples in
  cs_etm__add_stack_event() (sashiko).
- Released frontend_thread properly in cs_etm__context() (sashiko).
- Refined cs_etm__flush_all_stack() to use switch (sashiko).
- Gathered James' review tags.
- Rebased on the latest perf-tools-next.
- Link to v8: https://lore.kernel.org/r/20260611-b4-arm_cs_callchain_support_v1-v8-0-737948584fea@arm.com

Changes in v8:
- Updated test_arm_coresight_disasm.sh to pass "--itrace=b" and updated
  examples in arm-cs-trace-disasm.py (James).
- Removed static annotation in callchain workload and renamed functions
  with prefix "callchain_" to reduce naming conflict (James).
- For callchain test pre-condition check, removed the aarch64 check and
  added the root permission check (James).
- Resolved the shellcheck errors (James).
- Link to v7: https://lore.kernel.org/r/20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com

Changes in v7:
- Rebased on the latest perf-tools-next.
- Used struct_size() for allocation callchain struct (James).
- Added a helper cs_etm__packet_has_taken_branch() (James).
- Minor improvements for the callchain test (used record-ctl FIFO and
  reworked the validation callstack push / pop).
- Link to v6: https://lore.kernel.org/r/20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com

Changes in v6:
- Heavily rewrote the patches since restarted the work after 6 years.
- Changed to use the common thread-stack for branch stack and callchain
  management.
- Added a callchain test.
- Link to v5: https://lore.kernel.org/linux-arm-kernel/20200220052701.7754-1-leo.yan@linaro.org/

Changes in v5:
- Addressed Mike's suggestion for performance improvement for function
  cs_etm__instr_addr() for quick calculation for non T32;
- Removed the patch 'perf cs-etm: Synchronize instruction sample with
  the thread stack' (Mike);
- Fixed the issue for exception is taken for branch target address
  accessing, for the branch sample and stack thread handling, the
  related patches are 01, 02, 07;
- Fixed the stack thread handling for instruction emulation and single
  step with patches 08, 09.
- Link to v4: https://lore.kernel.org/linux-arm-kernel/20200203020716.31832-1-leo.yan@linaro.org/

---
Leo Yan (9):
      perf cs-etm: Fix thread leaks on trace queue init failure
      perf cs-etm: Filter synthesized branch samples
      perf cs-etm: Decode ETE exception packets
      perf cs-etm: Refactor instruction size handling
      perf cs-etm: Use thread-stack for last branch entries
      perf cs-etm: Flush thread stacks after decoder reset
      perf cs-etm: Support call indentation
      perf cs-etm: Synthesize callchains for instruction samples
      perf test: Add Arm CoreSight callchain test

 tools/perf/Documentation/perf-test.txt             |   6 +-
 tools/perf/scripts/python/arm-cs-trace-disasm.py   |   9 +-
 tools/perf/tests/builtin-test.c                    |   1 +
 tools/perf/tests/shell/coresight/callchain.sh      | 172 ++++++++++
 .../shell/coresight/test_arm_coresight_disasm.sh   |   4 +-
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/tests/workloads/Build                   |   2 +
 tools/perf/tests/workloads/callchain.c             |  33 ++
 tools/perf/util/cs-etm.c                           | 377 +++++++++++++--------
 9 files changed, 454 insertions(+), 151 deletions(-)
---
base-commit: 8c214ad8cb8d692c82c6466b8e88973dbfa8e064
change-id: 20260521-b4-arm_cs_callchain_support_v1-2c2a70719bcc

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

