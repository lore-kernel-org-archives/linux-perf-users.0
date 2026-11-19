Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090122;
	b=hPmPOV7B6pieoiaECXDVwNOKgv2ar1K8RPIbsWoK0dHk+1+0lgWD3cNeFu1Nc3Y9fYwO
	 wRep0aeyDIWDVOlxA28yUAAdtDwWoq2PM96q5Vr07G2JO4XmFBfG14F/oiUo65hSJUPD+
	 EzO36U9+bhKhzWlMb9r72z0GsS6ZeIZnBCOZbLAL1o2CeY/srq7qfMu0eABmrbiubh2eJ
	 nBJzxxjhsOPjjfdoig2UUOy+FK0EnYUngLHth8mAYqdxYwFv5Nys3ndVqcQcIzq3c3l8m
	 Vhauh91nMBD/o2BC23Jy2iwCukpphg2lQC7u22MWWzYqsENnEWSQAS6f/sNBkTEH82w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WWskCPZ2qp7Bin6yuG4dtbjBxJQcsOaKjOtM7K0zIBM=;
	b=qnRGFNbISbMALinV91nKmRlQNI4q7WPgIQdhUYUP7gltILzzary1YVw7YOGfy0Ls7b5S
	 mfNmSBusHZSPZOlnlK/gxFm1uIw69zmJe0rmAuOtKdBGFhJyusuFaXxAU61hosmgaFkOC
	 niskDW4KUzYblzhF41hkKoCGNwqkvWlu4O+XHzVKHolvlcvz8uSUp5Qw+csD+n7uVe3e5
	 bRTeukQtxhiKc0QTaRJKwpVgGwd30jqOQnXGPWBFl3IbbEEfrVhLAXNHvOBKlrzFOKtrj
	 j4i/wTeaxbuIKI3tihRsAIUMmsELSWGMXvaR5iisqqLrPOKpinkkYFua9QKADVfasPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WS9dwoS+;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC26606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AC26606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WS9dwoS+
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-381d542bc29so3953053eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1795090121; x=1795694921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWskCPZ2qp7Bin6yuG4dtbjBxJQcsOaKjOtM7K0zIBM=;
        b=WS9dwoS+CxeUqbiHVzc1DuOmyYQrRzY7VDXsg+EEEHOWabU6poN6GRI0zRMlOD6prz
         n2oJ2R78vmEVBUI/ccE7aRYxoeeHuEiAwxh/HyZ50xZhdoAFYP5j35ci4S4lhJm1dJyF
         mEq2sTfRVGH6MyaTIAlvB5DSc0xkfwZhjlGIVQyek+9FC7SVhYJBqJxe8y4pfR2J2cVu
         I3x3XOcuiIAflms1hUgqsDTke1CaA0URzhiTLen9J6UQfHClaUymEjOGF2+NKPRaWZMl
         qxHmUNS0//Auen3anvNr950nrkHwfl/ngEVZIyGVnyYjv89smSHsD39CJDb5qrdCQMDg
         Vb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090121; x=1795694921;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWskCPZ2qp7Bin6yuG4dtbjBxJQcsOaKjOtM7K0zIBM=;
        b=bYSp8YFb0BqUmzPtrz18BPYQDnByi9XVmtvhgEzRPXejwFNP0sfI2Jxd0Si+l/O0on
         zRuKjNzYcq3OotJonLrp0p2qzBvBKXJs6zDOCkcPetY1UTY8EWYW/AoId3H8FqGRkMhO
         TJtugV9A2rjrBgpcMFzD3q5rbffmPHPvwy5PHwvrNLWcnA/vb/jGAc6/7GaidL/99phN
         3nnRwVsYJ+N8HUZLBm157rH+6r9Mdc8tPeWnV5lqI4zWFFFEjHdhbyTpr8Lydu/lX2yZ
         IG3CTOCjJHoP9V+qIRBxKMXbrh8bDiDOe0PN1MXiIQOooFU7CkFuTpgTkA/Hzg0P8Pvr
         ECGQ==
X-Forwarded-Encrypted: i=1; AL+hErEkU1/kbXz2m+4BGCmbemZfEYWkjvYU+Vc8Be7eH60VW5AZVRAWHFfi7lVOs3qry5+sgo3mR5gx/46DD3zz05ht@vger.kernel.org
X-Gm-Message-State: APuU4Z+OcPgM/8p4Nk4o2gKo5ivSB8XGzK5KVidiEGHQh483bEleM9Oe
	zQ2lXCLiJ6pjap382GWBaRv4qSExOii3cELUkLehG0jFyFcUYvdHErU+o1mjFUkeMOA=
X-Gm-Gg: AZFdTZchja2/FQnO3MPqUuWfoF2tPevcUknkA5nTh3W/0zACARz7/dVfqotN1J2rhLX
	nfeqlzh9kQAbDHrXyU8+ckRXrVDy5vhqwYrgcbW7RTHGUaxObcTmZr7SKNVaz6UqMcMXPhguke9
	qsaqLMBAV8Zp/kifEMb0+gZ7Fpor1jmXiX+udtdJFRY2QZyWIx+sqCuyIKXibrxQldCdmGnc7AC
	1MTG4RC2vgnr0mZe6IsxAckx4h0EiSx0k5j4WIpJi882J06Jd8m6lFM6eVUbBWP0qUBx4gmKLCF
	64sX4mBRcEMjjGsguYCWPtCpKpzow6U7woxtjNIrUPiegAUEzChan80iv07Isa3sI9zK/05SFv/
	d6hEo7vnwocq5wMi6Ps1j4pWZt2EHqUAfcASV/lGMmDdDlsxcVXOwPGakl4d93BR5DRNjYOEopO
	qAmCkwIRGbraFgC1jgVqf+5qZgjVzheML5FUF8BfBtzdEWpp3BP4jVaZS8HtEiq4YcFqsHN05Ta
	M/QAQcZvoqhOCbyE2xYfjTmh1Tr+4t4DB/e9eD5AjNPAPaZ6jix9Xz1zmJfO9fw5eMcygn3KRyT
	RwWFKX2aelzrLQB+M0dQv0Sf/Pixgl0ezM9vHSysQPZkp8xFjtylwunVXYztFLGDKzOx7l3Xtwq
	qAyImkNM=
X-Received: by 2002:a05:7301:150b:b0:383:1b6f:bec6 with SMTP id 5a478bee46e88-3831b6fc25dmr3593117eec.36.1795090120634;
        Thu, 19 Nov 2026 04:08:40 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bc05cfsm17604650eec.26.2026.11.19.04.08.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 04:08:40 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	himanshu.chauhan@oss.qualcomm.com,
	conor@kernel.org,
	anup.patel@oss.qualcomm.com
Cc: clement.leger@linux.dev,
	cuiyunhui@bytedance.com,
	atish.patra@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	will@kernel.org,
	tglx@kernel.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	shuah@kernel.org,
	yuanzhu@bytedance.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangzhanpeng.jasper@bytedance.com
Subject: [PATCH v13 00/11] riscv: add SBI Supervisor Software Events support
Date: Thu, 19 Nov 2026 20:08:24 +0800
Message-ID: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This revision rebases v12 [7] onto riscv/for-next at 642fb67393c1
without changing the implementation. Clément Léger joins Himanshu
Chauhan and Zhanpeng Zhang as a co-maintainer of Linux SSE.

Why SSE
=======

RISC-V does not define an ordinary supervisor-mode non-maskable interrupt
(NMI). When Linux clears SIE, a normal supervisor interrupt remains pending
until interrupts are enabled again. That is appropriate for ordinary
interrupt handling, but leaves a blind spot for profiling and delays
notifications that need attention inside an interrupt-disabled region.

The SBI Supervisor Software Events (SSE) extension [2] provides a
firmware-to-supervisor event delivery interface that does not depend on
SIE. Linux registers an entry point, and firmware can transfer control to
it while ordinary supervisor interrupts are masked. After the handler
completes the event, firmware resumes the interrupted execution.

PMU overflow is the first client in this series. The same framework is
intended to support other clients, including high-priority RAS reports;
the RAS client implementation is separate from this series.

Delivery and implementation
===========================

For a hardware-triggered event, the flow is:

                   Linux kernel                  Firmware         Hardware
            interrupted    SSE handler            OpenSBI          source
              context           |                    |                |
                 |              |                    |                |
  1. setup       |              |-----register------->                |
                 |              |------enable-------->                |
  2. trigger     |              |                    <-----event------|
                 |              |          +-------------------+      |
  3. save        |              |          |   context save    |      |
                 |              |          +-------------------+      |
                 |              |                    |                |
                 |              |          +-------------------+      |
  4. inject      |              |          |   handler setup   |      |
                 |              |          +-------------------+      |
                 |              <-------mret---------|                |
                 |    +-------------------+          |                |
  5. handle      |    |  event handling   |          |                |
                 |    +-------------------+          |                |
  6. complete    |              |-----complete------->                |
                 |              |          +-------------------+      |
  7. restore     |              |          |  context restore  |      |
                 |              |          +-------------------+      |
  8. resume      <---------------mret----------------|                |
                 |              |                    |                |

Software-injected events do not need the hardware trigger. The diagram
shows a typical OpenSBI implementation of the firmware interface.

Linux enters on a dedicated event stack and establishes NMI context.
The entry wrapper reconstructs the interrupted pt_regs for the callback,
rather than treating the synthetic handler context as the sampled task.
It also preserves Linux-owned trap state, task stack metadata and the
temporary register slots used by ordinary exception entry.

Handlers must not sleep or rely on locks that the interrupted code may
hold. A nofault user access may still raise a synchronous exception: that
exception must return through its exception-table fixup without paging
memory in or opening an interrupt window. Preserving the interrupted
entry state across such nested exceptions is therefore essential.

The firmware driver provides a common client API for local and global
events. It tracks ownership across partial setup and teardown failures,
keeps callback resources alive while firmware may still reference them,
and integrates event handling with CPU hotplug, shutdown and kexec.

PMU overflow and perf
=====================

Ordinary PMU interrupts cannot sample an interrupt-disabled critical
section until Linux unmasks interrupts. The sample then often lands at
that boundary, obscuring the work that preceded it. SSE removes this
SIE-induced delivery delay. It does not promise zero skid or precise-event
sampling, but lets perf observe execution inside those critical sections.

No new perf command or perf.data format is required. The PMU driver
selects its delivery mechanism during setup. With PMU-SSE configured,
explicitly unsupported firmware or events can use ordinary interrupts;
other setup errors do not silently select that route. There is no runtime
SSE-to-IRQ transition after SSE has become active.

Kernel and user callchains use the interrupted context. Kernel unwinding
falls back to the interrupted PC where stack bounds cannot be established.
For DWARF sampling, perf copies the raw user stack with page faults
disabled and truncates it at an inaccessible address. This series uses inatomic
uaccess and exception-table fixup instead of fast-only GUP. The additional
address-space checks reject a missing mm or mismatched active page-table
root; they are not a complete equivalent of x86's nmi_uaccess_okay().

The PMU path retains throttling and stopped-event semantics. It restores
counters and userpage state before enabling an event after CPU power
management, and stops affected counters if an SSE operation fails.

Hardware observations
=====================

The following measurements were reported with v10. They illustrate the
delivery mechanism, not a new benchmark of this revision. The IRQ
and SSE comparisons used the same kernel source and perf binary on a
RISC-V server platform.

For perf bench sched pipe, the mean of three runs of three million
single-CPU operations was:

  rate       IRQ ops/s   SSE ops/s   delta   IRQ samples/s   SSE samples/s
  -F 99        337,707     339,555   +0.55%            98.0            98.6
  -F 999       338,352     338,289   -0.02%           995.7           998.0
  -F 5000      329,002     333,034   +1.23%          5001.7          5001.6

These runs had no lost samples. Both routes reached the requested rates,
with workload throughput differing by at most 1.23% in this comparison.

The same workload makes the irq-off sampling bias visible. In the -F 999
IRQ profile, finish_task_switch() and _raw_spin_unlock_irqrestore()
accounted for 54.99% of samples. Sampling via SSE instead exposed work
inside the critical sections, including scheduling, locking and address
space switching. Leading entries from the two reports were:

  Ordinary PMU IRQ
  overhead   symbol
    36.63%   finish_task_switch.isra.0
    18.36%   _raw_spin_unlock_irqrestore
     7.66%   __internal_syscall_cancel
     7.55%   do_trap_ecall_u
     4.19%   mutex_lock
     3.64%   mutex_unlock
     3.06%   exit_to_user_mode_loop

  PMU-SSE
  overhead   symbol
     5.48%   __kprobes_text_end
     5.29%   __schedule
     5.10%   ret_from_exception
     4.71%   do_raw_spin_lock
     4.01%   do_trap_ecall_u
     3.99%   mutex_lock
     3.66%   switch_mm
     3.43%   mutex_unlock
     3.29%   exit_to_user_mode_loop
     3.28%   psi_group_change

Symbols are reproduced as reported by perf. This is a change in what the
profile can observe, not evidence that SSE made those functions faster.

Entry-state fix and validation
==============================

Himanshu identified that TASK_TI_A0/A1/A2 were not preserved across SSE
handling [3]. Ordinary RV64 exception entry temporarily stores registers
in these slots. If SSE interrupts that window and its handler takes a
nested exception, the nested entry can overwrite slots still needed by
the interrupted entry path. Patch 2 preserves and restores them alongside
the task's kernel and user stack pointers.

Hardware A/B testing confirmed that preserving these scratch slots fixes
the reproduced corruption, allowing the temporary GUP workaround to be
replaced with nofault uaccess.

Guest SSE delivery, guest callchains and hibernation are outside the scope
of this series.

Firmware requirements
=====================

Firmware must implement SSE and the local PMU event. PMU testing also
requires the OpenSBI fixes that preserve pending overflows across event
enablement [4] and clear stale SPV for non-virtualized events [5].

Changes in v13
==============

- Rebase onto riscv/for-next (642fb67393c1).
- P9: Add Clément Léger as an SSE co-maintainer.

The restriction on normal kexec from a crash kernel (patch 3) stays in
place because firmware may still hold the crashed kernel's SSE
registrations; narrowing the check is left to a follow-up.

Changes in v12
==============

Relative to Anup's v11 [1], on the same a5ae1bf65cee base:

- P2: Preserve TASK_TI_A0/A1/A2, fix per-CPU initialization preemption,
  and address the kernel test robot's unused-function warning.
- P3/P4: Clarify the kexec restriction and retain v10 RESEND's CPU-hotplug
  preemption guards.
- P5/P6: Order RV32 vmalloc synchronization before nofault fixup and add
  NMI-safe lockdep irqflags tracking.
- P7: Replace GUP with nofault uaccess.
- P8: Fix early-error counter STOP, ordinary IRQ CPU-PM ordering and IRQ
  cleanup tracking; carry Conor's Acked-by [6].
- P9: Split MAINTAINERS updates out; keep both selftests last.

Acknowledgements
================

The original feature patches were developed by Clément Léger and
Himanshu Chauhan. Thanks to Himanshu for identifying the missing scratch
slot preservation and reviewing the entry and lifecycle code; to Susheng
Yang for reporting the callchain failure and providing a reproducer; to
Conor Dooley for review and acknowledgements; and to Anup Patel, Paul
Walmsley and the kernel test robot for integration work and feedback.

[1] https://lore.kernel.org/r/20261028165531.940336-1-anup.patel@oss.qualcomm.com/
[2] https://docs.riscv.org/reference/sbi/ext-sse.html
[3] https://lore.kernel.org/r/as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.com/
[4] https://github.com/riscv-software-src/opensbi/commit/f30a54f3b3a091c225a00476f4039bf399badd1f
[5] https://github.com/riscv-software-src/opensbi/commit/35511bc6ee1c9c17b6a89b44c52e2044bb51b979
[6] https://lore.kernel.org/r/20261002-reach-cloning-f1594729dbe3@wendy/
[7] https://lore.kernel.org/r/20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com/

Clément Léger (5):
  riscv: add SBI SSE extension definitions
  riscv: add support for SBI Supervisor Software Events extension
  drivers: firmware: add riscv SSE support
  perf: RISC-V: add support for SSE event
  selftests/riscv: add SSE test module

Zhanpeng Zhang (6):
  riscv: sse: mask events during shutdown and kexec
  riscv: mm: avoid enabling interrupts for nofault page faults
  riscv: enable NMI-safe lockdep irqflags tracking
  perf: RISC-V: support callchains with SSE delivery
  MAINTAINERS: add RISC-V SSE maintainers and file coverage
  selftests/riscv: add perf user-stack SSE copy regression test

 Documentation/arch/riscv/index.rst            |    1 +
 Documentation/arch/riscv/pmu-sse.rst          |   62 +
 MAINTAINERS                                   |   23 +
 arch/riscv/Kconfig                            |    1 +
 arch/riscv/include/asm/asm.h                  |   14 +-
 arch/riscv/include/asm/perf_event.h           |   10 +
 arch/riscv/include/asm/sbi.h                  |   63 +
 arch/riscv/include/asm/scs.h                  |    7 +
 arch/riscv/include/asm/sse.h                  |   82 ++
 arch/riscv/include/asm/thread_info.h          |    1 +
 arch/riscv/kernel/Makefile                    |    1 +
 arch/riscv/kernel/asm-offsets.c               |   14 +
 arch/riscv/kernel/entry.S                     |   14 +
 arch/riscv/kernel/machine_kexec.c             |   11 +
 arch/riscv/kernel/perf_callchain.c            |  140 ++
 arch/riscv/kernel/reset.c                     |   18 +
 arch/riscv/kernel/sbi_sse.c                   |  252 ++++
 arch/riscv/kernel/sbi_sse_entry.S             |  237 ++++
 arch/riscv/kernel/smp.c                       |   17 +
 arch/riscv/mm/fault.c                         |   32 +-
 drivers/firmware/Kconfig                      |    1 +
 drivers/firmware/Makefile                     |    1 +
 drivers/firmware/riscv/Kconfig                |   18 +
 drivers/firmware/riscv/Makefile               |    3 +
 drivers/firmware/riscv/riscv_sbi_sse.c        | 1228 +++++++++++++++++
 drivers/perf/Kconfig                          |   11 +
 drivers/perf/riscv_pmu.c                      |   14 +-
 drivers/perf/riscv_pmu_sbi.c                  |  561 ++++++--
 include/linux/cpuhotplug.h                    |    1 +
 include/linux/perf/riscv_pmu.h                |   20 +-
 include/linux/riscv_sbi_sse.h                 |   95 ++
 tools/testing/selftests/riscv/Makefile        |    2 +-
 tools/testing/selftests/riscv/sse/Makefile    |   10 +
 .../selftests/riscv/sse/module/Makefile       |   22 +
 .../riscv/sse/module/riscv_sse_test.c         | 1154 ++++++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |   59 +
 .../selftests/riscv/sse/sse_perf_ustack.c     |  564 ++++++++
 37 files changed, 4657 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/arch/riscv/pmu-sse.rst
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sbi_sse.c
 create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
 create mode 100644 include/linux/riscv_sbi_sse.h
 create mode 100644 tools/testing/selftests/riscv/sse/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
 create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh
 create mode 100644 tools/testing/selftests/riscv/sse/sse_perf_ustack.c


base-commit: 642fb67393c148f45a635b3b5afefdbd27632ed0
-- 
2.50.1 (Apple Git-155)

