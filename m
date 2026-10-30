Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373205;
	b=I8tnDg9VN9oqgQnvPGbjNumVyzinGmovdtEgveLqyKfpbCpJJ83lC3jB9zA1c9SDBSqM
	 WHsMgOKrMyd2CQHAUQ01ZYq+u6dpcfhzY1IdogyZiZWhCmffavssK7Kw8euxJs67gYXQa
	 Myn6AmBDDYqBbCjC1xDQ9lMi27tJuTz3/89mgzcZfiY3vGAi1sSD++s05qTkveLzzz7qb
	 s9+vuREJ2yw3RH5xCa/8NgCCYEAx6PpFmxSq4+o6iXnTARQJe387Lsowbjcva0y17111s
	 Jrp628o9HyGU1omdRa+QDCTfEdIOxaV1KdwFjDdQruHrGJDTuCsQSIgJXFiC7ttFMbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373205;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=amrurVyFz2qCQ2dJYaGk9kdX43uV5l+FEryyxcl8RBk=;
	b=S6noJEYpY3/OB4rQFWdMFVEY+1BG5JSOd4ZE1hql56V7SVCm7v6krPyUxYORF1NOH9Bb
	 38tRfOcmWKIouLkxuajyM/uABknai9Pm3yqnttn0hKDtfKFuBVRr866D/hmWs8BHKTyNh
	 6U6tV9mFvhiHDOerlywh7lNhgJtMHvaJmD5VGeuRO/8FQNKTO/0uay9Ksa7nBlS0ginjy
	 LsLRzW+8g9s9iaksk1BG06Gq6ofy3e6SSgcxGlfgVyqc4Ba0ENTquEOOmJHPgodpn6K7b
	 4iwsZ7lX8+VJhPmUrXEMcNC625oJpyC6YqCCmwIuubuvK0h9+24TbZhyHJKo9LYUbNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cb8IPV1h;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D1606A339;
	Fri, 30 Oct 2026 15:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC6D1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cb8IPV1h
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C285B1682;
	Fri, 30 Oct 2026 08:13:20 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6B273F59E;
	Fri, 30 Oct 2026 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373203; bh=qeA/v2pMKzG/IbdRRS3JspucVQmdahAGmUNM4jKeLyo=;
	h=From:Subject:Date:To:Cc:From;
	b=cb8IPV1hgg9U3uyK91HR0vfS3u9SbLLTxRTeXO6YRV+Xr9yvlXNbSRlRMdM4QIY/Z
	 adkxP/5HqcOrQF3/nk87kHAcKbA0jmUqLbj9aJDOe7RrUkHYgtbsPu/7oM6hyP9716
	 Q3/x0cso9/Kn5yMXlcmTXHpCzHJ3/leIlc+mdgk0=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 00/14] perf cs-etm: Fix bogus branch samples on
 exceptions
Date: Fri, 30 Oct 2026 15:13:07 +0000
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAO05GoC/43NQQ6DIBAF0KsY1qUBFKhd9R5NQxCHShrBgCFtj
 HcvunHXdPkn/79ZUILoIKFrtaAI2SUXfAn1qUJm0P4J2PUlI0aYIJLWeIJolUkK5lFZ91Y+eDX
 rF3jMu6aXVta2oYDKfopQCrt9f5Q8uDSH+NlfZbpd/1EzxQQ3XNBStEa09qbjeDZhRJuZ2eG07
 KfDiiN0dzFEat5wfjjrun4B4iqZDAgBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=5599;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=qeA/v2pMKzG/IbdRRS3JspucVQmdahAGmUNM4jKeLyo=;
 b=oJjOMo4x7HvO/AK9R91zwmP2939QV8ql9fGB8T+x6kAZ49lUuasj1fonVXH3gI0nInUZu9AY2
 27LfBgkJYQ8AfGxYMxP1twDAZk0hsMNAiWkfA5E4WdZJLEQck4BeaPB
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
Changes in v3:
- Introduced the pref_ret_addr/end_addr union (James).
- Clarified zero-size A32/A64 exception handling and why T32 retains
  per-address instruction decoding (James).
- Retreed missing exception pairs for up to three recordings,
  then fail instead of skipping (James).
- Shorten the IRQ workload (James).
- Fix FIFO argument quoting and remove redundant ShellCheck source
  directives (James).
- Checked instruction length before copying bytes into sample->insn
  (Sashiko).
- Retried MRS checks when instruction page faults may match the opcode
  filter (Sashiko).
- Rebased onto the updated perf tree and collect review tags.
- Link to v2: https://lore.kernel.org/r/20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com

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
 .../perf/tests/shell/coresight/abort_entry_exit.sh |  32 +++
 tools/perf/tests/shell/coresight/irq_entry_exit.sh |  36 +++
 .../tests/shell/coresight/syscall_entry_exit.sh    |  32 +++
 .../perf/tests/shell/coresight/trap_entry_exit.sh  |  39 ++++
 tools/perf/tests/shell/lib/coresight_exception.sh  | 164 ++++++++++++++
 tools/perf/tests/tests.h                           |   3 +
 tools/perf/tests/thread-stack.c                    | 106 +++++++++
 tools/perf/tests/workloads/Build                   |   4 +
 tools/perf/tests/workloads/branch_not_taken_loop.c |  33 +++
 tools/perf/tests/workloads/page_fault_loop.c       |  37 ++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    | 106 ++++++---
 tools/perf/util/cs-etm.c                           | 246 +++++++++++----------
 tools/perf/util/cs-etm.h                           |   6 +-
 tools/perf/util/intel-pt.c                         |   7 +
 tools/perf/util/sample.c                           |   1 +
 tools/perf/util/sample.h                           |   5 +
 tools/perf/util/thread-stack.c                     |   5 +-
 19 files changed, 714 insertions(+), 152 deletions(-)
---
base-commit: 4626d370ae89b8af4d46a45372b269f926ec662d
change-id: 20260713-perf_cs_etm_fix_non_taken-5b4d7f73f41e

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

