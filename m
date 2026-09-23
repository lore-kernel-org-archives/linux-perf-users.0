Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D35326DD;
	Wed, 23 Sep 2026 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176918; cv=none; b=hEBCVFzo6RM/5clnYuwS6iBPLjnG9nqlC/vDeIkEw6cdXsc9ngLdGo0bffQ72xlt0JP4zgao4clL0gvaIzv7t6BnXbxf1jLv0wv9igennozDpsK16zUVMgijF3nOwP9d/SwzAxED6yulRrphwUm2xyqd0hC36nNrmZJo9b6Xf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176918; c=relaxed/simple;
	bh=q4wQshbRsvy+J1VU2g34zHA3uVa8ql1lQUzG7LhObpE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ivuZjgEthg+wXsf93nu4J1cMXk3d+67JlxwOSrfbOezvu1TgzcCdVteSqkSrrUQzpfU+zHv/MLouAI4cCg5KzRF2XOUkyw6yVFXY1px6tVqWWnJa9e/9wIV38pJkAr9EtC1qXFLEbmRfJGkpvKknt6LqDNcd9PHaL5GMxznedcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ldMw6Oba; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ldMw6Oba"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 311901570;
	Wed, 23 Sep 2026 08:21:52 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 747E83F86F;
	Wed, 23 Sep 2026 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176915; bh=q4wQshbRsvy+J1VU2g34zHA3uVa8ql1lQUzG7LhObpE=;
	h=From:Subject:Date:To:Cc:From;
	b=ldMw6ObaZkNim252CMXH80T8rPkG5uqOIR4vPh0+6XSZDISj/yrXpRW/lXO0998fK
	 2My5yiYmo8Fj0HRZ4MkibsV49FF9F4ipazXAto4puLO8Bw0fypppcDq/HBUgBPkBY/
	 T0Mww9YyM23rAId7ogL/0g8IoKPc4aA39kuUtdJw=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 00/14] perf cs-etm: Fix bogus branch samples on
 exceptions
Date: Wed, 23 Sep 2026 16:21:40 +0100
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITus2oC/42NUQqDMBBEryL73RSjUWm/eo8iIY2bGoqJbIK0S
 O7erSfo5xtm3uyQkDwmuFY7EG4++RgYmlMFdjbhicJPzNDUTV8PshUrktM2acyLdv6tQww6mxc
 G0T3UNLihdUoi8H4l5MLhvo/Ms0850ue42uQv/ce6SVEL1fWSi872F3cztJxtXGAspXwBSWSnF
 8AAAAA=
X-Change-ID: 20260713-perf_cs_etm_fix_non_taken-5b4d7f73f41e
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=4836;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=q4wQshbRsvy+J1VU2g34zHA3uVa8ql1lQUzG7LhObpE=;
 b=QT7KCbxiEKjtsKUFHVT5ecjWjDXdUlNaoADSTye8mZiwp2KuXUbFBzjfsGezh2M0/dK/3wiRb
 KNEvdFAgeDjAfGm1oqs+RbyirngztZn3s2CBeRRTQw48KV/TCu6M3zU
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

CoreSight currently models exception entry by changing the preceding
instruction range into a taken branch. This can give an IRQ the source
PC of an instruction that already retired and overwrite a real branch
immediately before the exception.

For an untaken B.LS followed by an IRQ, perf script currently reports:

  hw int  4000f8 => ffff800080010c80  b.ls #0x400118
  ...
  iret    ffff800080012284 => 4000fc  eret

The hardware trace supplies 0x4000fc as the preferred return address.
For an IRQ, this is the architectural resume PC (Arm ARM, R_VBQMV).
B.LS has retired, and the saved PC identifies the boundary before the
following MOV. Using this PC as the IRQ source reflects the
architectural state at exception entry:

  hw int  4000fc => ffff800080010c80  movz x2, #0x1796
  ...
  iret    ffff800080012284 => 4000fc  eret

The IRQ sample represents the transfer from this architectural execution
position to the handler. The series synthesizes exception entries from
exception packets, preserving the preceding branch and its outcome.

The supporting changes:

- Let decoders supply sample.ret_addr so later instruction fetching cannot
  change thread-stack return addresses. Apply this to Intel PT
  asynchronous samples as well.
- Prepare packet ISA and instruction-size handling and share sample
  synthesis helpers. Mark untaken branches and break history when
  instruction memory is unavailable.
- Add a thread-stack regression test and four AArch64 CoreSight tests.
  IRQs and page faults must resume at the entry PC; SVC and emulated MRS
  must resume four bytes later.

Based on the AI search and test on my x86 machine, this matches perf's
Intel PT handling of IRQs. Intel PT records the next instruction's IP in
the FUP packet, and Perf uses that IP as the interrupt sample's source.

This series is verified on Orion6 board with "perf test coresight".

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:

- Rework the fix around exception packets to preserve both exception
  entries and preceding branches.
- Add explicit return addresses and the Intel PT asynchronous-branch fix.
- Split out packet/synthesis preparation, record not-taken branches and
  handle unreadable instruction memory.
- Add thread-stack regression coverage and four CoreSight tests.
- Link to v1: https://lore.kernel.org/r/20260713-perf_cs_etm_fix_non_taken-v1-0-4561607fc69f@arm.com

---
Leo Yan (14):
      perf sample: Allow decoders to supply branch return addresses
      perf intel-pt: Preserve return addresses for asynchronous branches
      perf cs-etm: Break branch history when instruction memory is unavailable
      perf cs-etm: Centralize packet ISA initialization
      perf cs-etm: Use the recorded instruction size for A32 and A64
      perf cs-etm: Mark branches that were not taken
      perf cs-etm: Factor out final instruction sample synthesis
      perf cs-etm: Centralize branch sample synthesis checks
      perf cs-etm: Classify exception calls using the exception packet
      perf cs-etm: Synthesize exception entries separately from branches
      perf tests: Check CoreSight IRQ entry and exit
      perf tests: Check CoreSight syscall entry and exit
      perf tests: Check CoreSight abort entry and exit
      perf tests: Check CoreSight emulated instruction entry and exit

 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   3 +
 .../perf/tests/shell/coresight/abort_entry_exit.sh |  21 ++
 tools/perf/tests/shell/coresight/irq_entry_exit.sh |  37 ++++
 .../tests/shell/coresight/syscall_entry_exit.sh    |  21 ++
 .../perf/tests/shell/coresight/trap_entry_exit.sh  |  24 +++
 tools/perf/tests/shell/lib/coresight_exception.sh  | 165 +++++++++++++++
 tools/perf/tests/tests.h                           |   3 +
 tools/perf/tests/thread-stack.c                    | 106 ++++++++++
 tools/perf/tests/workloads/Build                   |   4 +
 tools/perf/tests/workloads/branch_not_taken_loop.c |  33 +++
 tools/perf/tests/workloads/page_fault_loop.c       |  37 ++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    | 106 +++++++---
 tools/perf/util/cs-etm.c                           | 222 ++++++++++-----------
 tools/perf/util/cs-etm.h                           |   2 +
 tools/perf/util/intel-pt.c                         |   7 +
 tools/perf/util/sample.c                           |   1 +
 tools/perf/util/sample.h                           |   5 +
 tools/perf/util/thread-stack.c                     |   5 +-
 19 files changed, 656 insertions(+), 147 deletions(-)
---
base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
change-id: 20260713-perf_cs_etm_fix_non_taken-5b4d7f73f41e

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

