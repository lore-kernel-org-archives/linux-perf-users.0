Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260152;
	b=33vqB5dxvZUIbMCRdkPTD9bGbQzHO4KS1o2EFoP585I5q7w5X7/hLY01OZiNP83imIDi
	 zqWq5ySbdls931t59O9jGICJOQiS+ie7OGKrqqYmsL9sQQN/xIO9W1QM48ysR3qq/4SKs
	 qRH2v168omKZGaLK9v9hiA9FAbfcUUqgs65M0JrhByjDcaZhkE7Tpr8NQUhKvd56M5kii
	 gtc/miLairvh/ihWXoxjP08k1eXFDB1MljsHexROwH/sSHkcS8Bfd0V9At7UPSXNZMoH3
	 quXkuLIlojGf9Dcn+udttUjf9kKkSUezH6WHBjaf9IsMJMeh4i7bExtXty8YExpCDJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yCXScZRm5ovDoqUgmZ8kXGr4YYrkIHqreSHj5aUnKbo=;
	b=adgO2DuRV+PppLdeWtK/jLGqNO+N6YMzlKzOlvQ34tUxtrO5AEX/ZSO6kykpYt2VhAFT
	 5ZVC+N+N+LxDuBPGn3y9q9AeIRC2BjMhQtrIKKOBwSVJJV+jV+i/ZTHpk0vszXchBDd+Q
	 FBxJbctdauFd46AddXpFbftxC0askg72MQlUzEcn4TJ9OKDMjWr9c/bCrqF0ZSYGDQ0/k
	 CHmn/K5LcWU4ipFp6XNMJ1dOlUf3xFdQDF0bZ9E2din4b4jbh1Gc1S/vPVhKWbDnqYwfK
	 M3ti4esFPH+pVUTZ5lj2xgfJJ8uJ7jJms7mmP4+YJHGvP5i4UnB6t8pq+awFXAKqW+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Y96Daie7;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB7606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 07:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46AB7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Y96Daie7
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e934c6c20aso12704665ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793260150; x=1793864950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCXScZRm5ovDoqUgmZ8kXGr4YYrkIHqreSHj5aUnKbo=;
        b=Y96Daie76RdZMV790RR/5MY/zljmmD7kh5hy3GznOCG0sG0a4O9FBVdh0oAA/syBcG
         A8MeTHyK0fPWbx8sfFwuVBBE7hvj7tLKvvzzmr6E8u8xVc7PfWIcnqQsMyXNexUaZ0jo
         l5OmPHYvO7YQRADIeELvNvlruKfGxSkbXD+jUS6bb9e55viWNgkAKQfRwmQNL3HIUmvf
         77qH8FDZ//9BrhsKt//WoUG4zj0A5zACKWiRya8zurWDPSLpPysQoiCowfA2M9E2sBo0
         GReXsjh747NA1FB+UnbwuzekVudFbmZqCF4koKWOUq99PhVcEEKxBKjVGl5lnjCVF+kS
         kLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793260150; x=1793864950;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yCXScZRm5ovDoqUgmZ8kXGr4YYrkIHqreSHj5aUnKbo=;
        b=wzeAacPOkDQm/nHztpC9Qqd48hs10iVOnszg2932Upv770r2jr+k82i3zoiFTWuoCR
         r/zXEJFONXMfr/+Naoq7vBSXX+fPhty6o0IYI1M9UOJSt3OT+nVnXiGKyrHHibEiwZuB
         g7GSmE3f8dXGnfQAl2GtHS86Zov/EgnvhRhEzOiIUOJAir/7Bp9sxFe7p+iC8GRfrBV3
         9DweleFxH8sn0/Gp+408hwuiOFRFkc46wbs7Oo9+1mGPBZLyqUJIkLW7SE3LZ3+XlAgk
         N3XrqPbybzJYH3SpB1kKhatUngnFP9m0Qh+IORLMTXrpJJ8doxaL9R2Ysm79nzdCTGpY
         fyHg==
X-Forwarded-Encrypted: i=1; AKwUvBwRjfTCLX04UYZKKsl8ih7meuDI6duG8BX+EeKozIoKC4/8SLD56My2ZGdoleEqiOnQA3a8FtlPMbINiKUZnxhi@vger.kernel.org
X-Gm-Message-State: AFq9FYIlH6NWpLPGBUOn7Ah7TTACxSy8c6/ByM4BGYWVscJaxtlFe5AK
	kM8/WjdsdetpOgwcx9IkcMrSCteUUkOgEJqyeeK0ikDo1HfEcHSXPJiZGFIjA0C3lCo=
X-Gm-Gg: AYBFou3jqlRl3RGAdKJMUgQ7hSk6b4LRvtm5ckQ+8vzEaBUPSJAD2KGnPzM4+mgVEku
	eUqfCj6UVY8Z2O/N0xDJR5dOCTcS+wqLRyM7RmKcvfZznGkkcHhuEA62MTOztWm3q8WUSC0vh+D
	R21isLb4CfXTEShCt3LkjdQdwBKo2AoglgUMAcKMExjE3PW7APcSVVHIIsYsrai60f8YhN5azXU
	iFi36Uk3YufPAFUZ2biOQA1QxWtfNOiuUjvgSExCVrQSngwK+6ujBZVcXTMo+Ux5D6qGtDiwRqv
	bk3sO4FZMobKtFjKhIGbWUJoUtlXarAmcxydq/+xChs6LVaYmziCCPyrXdFXxsZtkpEto03Nm+E
	B3ZSfWPeZ2d3yNaCn0EA4RgLcu17LLhiJASGk87gy6RzbVOrk9IeSk/4LaTSEphP5TV1jjtYgKM
	t4s82QqAhY3MkPTtd9Dr04Ef9JugTqcTcmrmPDPGNFSRZIVKdworq+0sPrrJXBbvWU1YIMp/M7U
	kj1aqlMEtdrjVmaP4IibXtST/W95CMv2K4lscw3l/Gvemed87YdE5xKWvYEJJ4ztsS97Ku+M67T
	j9cAZPls8QklHOPdt3aISlfTEmbZxBiPU7ioalRP+a3S1YhZHvdl8RJqR5ZUitxL+kEqFwGAgng
	7eKSeQOp9GWjAW/vbuN3iJXwBYGPmfg==
X-Received: by 2002:a17:902:f645:b0:2e9:5507:b532 with SMTP id d9443c01a7336-2eb00547963mr43569405ad.43.1793260150412;
        Thu, 29 Oct 2026 00:49:10 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bd60desm30598915ad.29.2026.10.29.00.48.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 00:49:09 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Conor Dooley <conor@kernel.org>,
	Anup Patel <anup.patel@oss.qualcomm.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Atish Patra <atish.patra@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	yuanzhu@bytedance.com,
	yang.yicong@picoheart.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v12 00/11] riscv: add SBI Supervisor Software Events support
Date: Thu, 29 Oct 2026 15:48:42 +0800
Message-ID: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
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

This revision follows Anup's v11 [1] and uses the same riscv/for-next
base, a5ae1bf65cee. It incorporates the entry-state fix identified by
Himanshu, replaces the temporary GUP workaround for perf user-stack
sampling, and brings together the outstanding preemption, fault-entry,
lockdep and PMU error-handling changes. Thanks to Anup for the rebase
and PMU testing, and to Paul for coordinating integration.

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
disabled and truncates it at an inaccessible address. V12 uses inatomic
uaccess and exception-table fixup instead of fast-only GUP. The additional
address-space checks reject a missing mm or mismatched active page-table
root; they are not a complete equivalent of x86's nmi_uaccess_okay().

The PMU path retains throttling and stopped-event semantics. It restores
counters and userpage state before enabling an event after CPU power
management, and stops affected counters if an SSE operation fails.

Hardware observations
=====================

The following measurements were reported with v10. They illustrate the
delivery mechanism, not a new benchmark of this v12 source tree. The IRQ
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

 Documentation/arch/riscv/index.rst                 |    1 +
 Documentation/arch/riscv/pmu-sse.rst               |   62 +
 MAINTAINERS                                        |   22 +
 arch/riscv/Kconfig                                 |    1 +
 arch/riscv/include/asm/asm.h                       |   14 +-
 arch/riscv/include/asm/perf_event.h                |   10 +
 arch/riscv/include/asm/sbi.h                       |   63 +
 arch/riscv/include/asm/scs.h                       |    7 +
 arch/riscv/include/asm/sse.h                       |   82 ++
 arch/riscv/include/asm/thread_info.h               |    1 +
 arch/riscv/kernel/Makefile                         |    1 +
 arch/riscv/kernel/asm-offsets.c                    |   14 +
 arch/riscv/kernel/entry.S                          |   14 +
 arch/riscv/kernel/machine_kexec.c                  |   11 +
 arch/riscv/kernel/perf_callchain.c                 |  140 +++
 arch/riscv/kernel/reset.c                          |   18 +
 arch/riscv/kernel/sbi_sse.c                        |  252 ++++
 arch/riscv/kernel/sbi_sse_entry.S                  |  237 ++++
 arch/riscv/kernel/smp.c                            |   17 +
 arch/riscv/mm/fault.c                              |   32 +-
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/riscv/Kconfig                     |   18 +
 drivers/firmware/riscv/Makefile                    |    3 +
 drivers/firmware/riscv/riscv_sbi_sse.c             | 1228 ++++++++++++++++++++
 drivers/perf/Kconfig                               |   11 +
 drivers/perf/riscv_pmu.c                           |   14 +-
 drivers/perf/riscv_pmu_sbi.c                       |  561 +++++++--
 include/linux/cpuhotplug.h                         |    1 +
 include/linux/perf/riscv_pmu.h                     |   20 +-
 include/linux/riscv_sbi_sse.h                      |   95 ++
 tools/testing/selftests/riscv/Makefile             |    2 +-
 tools/testing/selftests/riscv/sse/Makefile         |   10 +
 tools/testing/selftests/riscv/sse/module/Makefile  |   22 +
 .../selftests/riscv/sse/module/riscv_sse_test.c    | 1154 ++++++++++++++++++
 tools/testing/selftests/riscv/sse/run_sse_test.sh  |   59 +
 .../testing/selftests/riscv/sse/sse_perf_ustack.c  |  564 +++++++++
 37 files changed, 4656 insertions(+), 107 deletions(-)

base-commit: a5ae1bf65cee84bcc121d659e7e22a767853f5f5
-- 
2.50.1
