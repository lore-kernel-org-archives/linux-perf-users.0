Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0030ACF6
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128936; cv=none; b=D7dGKYV8WtNzSDR890e75VLB9ZV1Q+ETMQAYHV4qm2bpEGyVw+vr5eB4c+h9s0EqBi3FmjGnAiDf9HQwOc5RHZxoOkKrlCmnY3lUkwAuercx7i30sMeGolEERrav5XbjctSrYmqGZLuc2FYQs2Frnpp+gAuqIGyRc2g8TnY85A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128936; c=relaxed/simple;
	bh=XJ9obYSWtY4qthMuIzrbSVIGHV8ERc0eSptJiFIpbKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lg4sW8cucaID6oAiEMCW8WphNgYuZOZmUhHSCV7BOiYZaLjGLeWgrKeMKOTkeQZuNlexRIgKvz9datKQWB7SPIdqAUogD8qVNC7+rQ2LzJZR3WBFLeObwjUUxXluXAaCTw3Gd5vm0UWrtK/uD4pIeCsByxbHzvCnReR+xJiLthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b6zkASsm; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="b6zkASsm"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so9655655ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789128933; x=1789733733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HtKZQct/qW4J5I+VejgYdZtvYsRIM1Drv1Z+7+Cq5s8=;
        b=b6zkASsm1xdPyXO6AQcyGj2ywQ9HKib9At15Bx1cjbX7TN54adMWQ6VhcgqUxM9Y4Y
         1mKZz11WAkSIwFnlQyDDxTABF/uaU7idf2lLYHq2cfSUE0Cy0yvd4Q7dpIOuMuhVoGTc
         eYM44xt2HY0B5PYep3KW3/DVr35HrHkpQPwYmBaBAgXl0ubowo67XRX+K4fto2e1PaNG
         UL8YWfnLClw3WY5Rx9yMIx+IFxdGVx9zlTuX3foTJYxH4Tq8iLpaN7GgfnBvXQhbfhlu
         VhZbKb1Jwrmj3yHytwc62SvMpEZwOtq1rbaKGPEYejtZvIXMtyzrsgGbWJsODEoXY9mS
         6u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789128933; x=1789733733;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HtKZQct/qW4J5I+VejgYdZtvYsRIM1Drv1Z+7+Cq5s8=;
        b=dfhupf03yISLUCgslJ1zjGxuTRhPLV59FmXzvjBLQFC+b5kQMHO6O9hOSYwNZ7Jc8y
         4wGbD+KyOuRnTUvyC1qcL5EVCVBisBc70e09A3orqXTKk6b/bgVXfUdrJjWs8v32yS8e
         IyLeobjYIszhZAe1Mao+jwCY79sVyeX0aiWm02Rpoax+p7KhcIwcbQ00ymqAUbcyMSCG
         OA3I8fUaWVd9j/Se4ArwF6KxiYeXFb1pzrh03FzcFE3OinfHppYlinYRxPpD0H+grrTe
         l53+2HMWA5kU2CCYnGrHeoD1LJacd6yV6YOefHegenAWT4MUKmWp9VBlaCxRh+cDCi+w
         f2Ww==
X-Forwarded-Encrypted: i=1; AKwUvBwDpUh0f5iidmbZyDy+UAbDVw6HyD8xyAZ8g/RfCOAGyZdrbW5Xx5/gFzuXR51MtrIrkKKk+WFLwr4BJjaTJ9zf@vger.kernel.org
X-Gm-Message-State: AFuF++lZbLelqkM/ZO2Hku8MSiMOLjOlYirvVGm31ZfAM27GyonfyKie
	dg11IhYuE/fXygMpt8THRepD0BgfXhH7jB8AQuos3A+5iXeB55nU0hXxZLJi/cC2Cto=
X-Gm-Gg: AYBFou2nuGbQvhypanA6um/gH0Ij6ynYVuaeT++BKOsDXJ4y616sDmLTivuZ4iUtb6I
	wvbAe94JTuwjIm9Z961qLy95o2Uv6esWjz9eq5NF5BuWiKcvbittrnpS1HfPYUKMXSmP/Uj6GuA
	KAUz7HfqFlwQG4/HlUM2XYi1bNVdjnYaT84V1qQmQxAFo3AvI60OZlULBRN9l6EtGbGqpIZNiiI
	y8fOXQWTnpodtU6JgblwLi7greC4iV4PNL6eQT9o2tQWXRZHydbJTEDyP9xJVEKXNwDCWOczAjF
	cEHgeNB9faK8CO5aAIAYfBbvtK3mT2eGve/I5XiA31UyNLUmWl8AEv0tCHw1t69c9WmrxgzDrf/
	GkRG4NhiYRmoNy3BnvRev2yeI4avcpd4KdEvPEYb29S1gRYU9Z5d1sxYICKmhOOriKWEUxRy+ji
	fJ9lVfYVsKvJPo5chfDieAyd0dxigFeaFNvkolZpBYuH6biRNPT9rqgNeMsIZGlNmEaVeSlRe4E
	ifxebybA/qtGk810A18Ua5ERBEuhn4YyXsKWtjY4opAacBmngX1
X-Received: by 2002:a17:90b:1d44:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39d9c234a8emr6774079a91.13.1789128931521;
        Fri, 11 Sep 2026 05:15:31 -0700 (PDT)
Received: from FJ7FR2JRQ3 ([2409:8a28:f48:3091:908c:b537:572a:4db0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm3178278eec.8.2026.09.11.05.15.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 05:15:30 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Conor Dooley <conor@kernel.org>,
	Anup Patel <anup@brainfault.org>
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuanzhu <yuanzhu@bytedance.com>,
	Yicong Yang <yang.yicong@picoheart.com>,
	Susheng Yang <yang.susheng@zte.com.cn>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v10 0/9] riscv: add SBI Supervisor Software Events support
Date: Fri, 11 Sep 2026 20:14:47 +0800
Message-ID: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RISC-V does not architecturally define a supervisor-mode non-maskable
interrupt (NMI). An interrupt that arrives while Linux has cleared SIE stays
pending and is not observed until interrupts are enabled again. That is
correct for ordinary interrupt handling, but some kernel work needs an
NMI-like notification that can run even inside an interrupt-disabled region:
sampling a PMU overflow at the instruction that caused it, or taking a
high-priority RAS report promptly, cannot wait for the next unmask boundary.

The SBI Supervisor Software Events (SSE) extension [1] fills this gap. It lets
Linux register handlers for events that the SBI implementation can deliver
ahead of ordinary traps and interrupts, giving RISC-V the NMI-like supervisor
notification mechanism it otherwise lacks.

SSE can carry several event sources: high-priority RAS reports, double traps,
and PMU overflow, with room for further standard and platform events. This
series focuses on PMU overflow, its first user. Delivering overflows through
SSE lets perf sample the code that was actually running while interrupts were
disabled, rather than the later point where execution reached an
interrupt-unmask boundary.

This series implements the Linux side of that interface: the architecture
entry machinery, a firmware driver that exposes SSE events to in-kernel
clients, PMU overflow delivery, and regression tests. Per-hart local events
and system-wide global events share one client API.

SSE delivery model
==================

Linux first registers a handler and an event stack with the SBI
implementation, then enables the event. When an event source is signalled, the
M-mode SBI implementation preempts Linux even in an interrupt-disabled region:
it saves the interrupted supervisor state and constructs an S-mode context
that enters the registered handler. Linux can now run its own handler, for
example to take a perf sample or process a RAS report, then completes the
event with another SBI call, allowing the interrupted context to resume.

The typical hardware-triggered delivery flow is (software-injected events skip
the hardware trigger):

       <--------- Linux kernel ----------->  <-- Firmware --->  <- Hardware ->
     interrupted context  SSE handler             OpenSBI          Hardware
              |                 |                    |                 |
[1] setup     |                 |-register & enable-->                 |
              |                 |                    |                 |
[2] trigger   |                 |                    <----trigger------|
              |                 |                    |                 |
[3] save      |                 |            +--------------+          |
              |                 |            | context save |          |
              |                 |            +--------------+          |
              |                 |                    |                 |
[4] inject    |                 |        +-----------------------+     |
              |                 |        | handler context setup |     |
              |                 |        +-----------------------+     |
              |                 <---inject (mret) ---|                 |
              |                 |                    |                 |
[5] handle    |        +----------------+            |                 |
              |        | event handling |            |                 |
              |        +----------------+            |                 |
              |                 |                    |                 |
[6] complete  |                 |-----complete------->                 |
              |                 |                    |                 |
[7] restore   |                 |           +-----------------+        |
              |                 |           | context restore |        |
              |                 |           +-----------------+        |
              |                 |                    |                 |
[8] resume    <------------resume (mret) ------------|                 |
              |                 |                    |                 |

The context used to enter the handler exists only for this handoff; it is not
the task context that the event interrupted. The architecture entry code joins
the two sides: it moves execution onto the event's dedicated stack and shadow
call stack, establishes the current task, and presents the interrupted
registers to the callback as a normal pt_regs. Clients can therefore operate
on the original interrupted context without depending on the firmware entry
details.

Linux implementation
====================

An SSE handler runs in NMI-like context: it must not sleep, must not take a
page fault, and may interrupt code that holds arbitrary locks or is partway
through kernel entry. The implementation is shaped by those constraints.

Because it is NMI-like, an SSE can arrive at any point where interrupts are
disabled, including while Linux is midway through exception entry, a task
switch, or a KVM guest transition, where the normal kernel entry state is only
partially established. The SSE entry wrapper (the architecture assembly that
runs before the client callback) copes with this: it preserves Linux-owned
stvec, hstatus, and task stack metadata across the handler and any nested
exception, and its earliest instructions, which run before the event stack and
current task are set up, are kept outside kprobe instrumentation.

The callback receives the interrupted registers as a pt_regs and is allowed to
edit them. On RISC-V a6 and a7 carry SBI call arguments and results, so a
callback that wants to influence an in-flight SBI call the event interrupted
edits them there. The entry wrapper copies just a6 and a7 from that pt_regs
back into the context handed to the completion SBI call, so the edit takes
effect when the interrupted code resumes; the rest of the interrupted state is
restored by firmware and left untouched.

The firmware driver maps the SBI event state machine onto kernel resource
ownership. A callback, stack, and attribute buffer stay alive until firmware
has removed every registration that can refer to them. Failed partial
operations remain tracked for later cleanup, an aborted CPU-offline operation
restores the requested event state, and shutdown and kexec mask SSE before
Linux stops servicing handlers.

PMU overflow and perf
=====================

The RISC-V SBI PMU driver delivers overflows through ordinary interrupts by
default. When firmware implements SSE and the local PMU-overflow event, the
driver routes overflows through SSE instead. The choice is made once at setup
and is not switched at runtime; an operational failure disables sampling
rather than risking two active routes for the same overflow.

This changes where perf can observe an overflow, not how applications use
perf. A normal PMU interrupt raised while S-mode interrupts are masked is
handled only once they are enabled again, so the resulting sample often points
at the unmask boundary rather than at the code that consumed the cycles. SSE
can enter Linux at the original point and remove that source of sampling bias.
No new perf option or perf.data format is introduced.

The entry code supplies the interrupted pt_regs needed for register samples
and for kernel and user callchains. DWARF callchains additionally require a
copy of the interrupted user stack. Since an SSE handler cannot take a normal
page fault, this series takes a temporary reference to the resident user pages
with fast-only GUP, copies them through their kernel mappings, and truncates
the sample at the first page that is not immediately available. The existing
in-atomic copy remains unchanged outside SSE context.

The PMU integration retains perf's throttling and stopped-event semantics. It
restarts only runnable counters and orders the CPU power-management callbacks
so that counters cannot resume after a hart has failed to restore its SSE
delivery path.

Hardware results
================

We measured this on a RISC-V server platform. The same kernel source
and perf binary were used for both routes; one delivered PMU overflows through
ordinary interrupts and the other through SSE. The table shows the mean of
three runs of three million single-CPU "perf bench sched pipe" operations. The
"ops/s" columns are workload throughput (higher is better, so they show the
profiling overhead); the "samples/s" columns are the sampling rate perf
actually achieved against the requested -F frequency:

  rate       IRQ ops/s   SSE ops/s   delta   IRQ samples/s   SSE samples/s
  -F 99        337,707     339,555   +0.55%            98.0            98.6
  -F 999       338,352     338,289   -0.02%           995.7           998.0
  -F 5000      329,002     333,034   +1.23%          5001.7          5001.6

There were no lost samples. Across these normal frequency settings, both
delivery modes reached the requested sample rate and workload throughput
differed by no more than 1.23%.

The "perf bench sched pipe" workload also shows why the delivery mechanism
matters to the resulting profile. Ordinary PMU interrupts cannot enter an
interrupt-disabled kernel critical section. Overflows raised there remain
pending until interrupts are enabled again. Samples consequently accumulate
at the enable boundary rather than at the code that consumed the cycles. In
the IRQ profile, finish_task_switch() and _raw_spin_unlock_irqrestore()
therefore accounted for 54.99% of all samples.

SSE can enter Linux while S-mode interrupts are disabled. The PMU-SSE
profile therefore samples inside those critical sections and exposes the
scheduler, locking, address-space switching, and wake-up paths doing the
actual work. The leading entries from the two -F 999 reports show the
difference.

With ordinary PMU interrupt delivery:

  overhead   symbol
    36.63%   finish_task_switch.isra.0
    18.36%   _raw_spin_unlock_irqrestore
     7.66%   __internal_syscall_cancel
     7.55%   do_trap_ecall_u
     4.19%   mutex_lock
     3.64%   mutex_unlock
     3.06%   exit_to_user_mode_loop

With PMU-SSE delivery:

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

The ordinary interrupt profile is dominated by two interrupt-enable
boundaries. With SSE, those two entries account for only 3.37%. The samples
are instead distributed across scheduler paths within the critical sections.

At perf's configured limit of 100,000 samples per second, both routes still
made progress without lost samples. In this deliberately saturated regime SSE
reduced workload throughput by 2.7% to 5.8%, which exposes the additional
firmware-entry cost and marks a practical upper boundary for sampling.
Thirty-second perf top runs at the same rate each processed about 3.1 million
samples with no loss, stalls, or kernel failures.

The DWARF callchain path gets dedicated coverage because it was the source of
the corruption this series fixes. On the same platform,
"perf record -a -g --call-graph dwarf,512 -F 999" layered on a concurrent
"hackbench -g25 -l600" -- the configuration that previously corrupted
spinlocks and mutexes under SSE -- now completes cleanly, with no lost
samples, lockups, RCU stalls, or faults, including a 431-iteration soak.
Patch 9 adds a regression test that drives the non-faulting user-stack copy
through the SSE handler with 32 concurrent samplers and checks perf's
truncation semantics.

Changes in v10
==============

V10 turns the earlier feature series into a path suitable for sustained perf
use. In particular, it:

  - reconstructs and publishes the interrupted context for perf register
    samples and kernel and user callchains;
  - preserves current, task stack metadata, stvec, hstatus, and shadow-call
    stack state across synthetic entry and nested exceptions;
  - prevents fault-disabled accesses from entering the generic RISC-V page
    fault path and provides a non-faulting SSE user-stack copy;
  - makes event lifetime and rollback explicit across partial firmware
    operations, CPU hotplug, shutdown, crash, and kexec;
  - closes PMU throttle, counter restart, CPU power-management, and cleanup
    races without adding a runtime SSE-to-IRQ transition; and
  - expands the framework stress coverage and adds a regression test for
    high-frequency DWARF user-stack sampling.

Changes in v9:
  - Rebased the original series onto RISC-V for-next.
  - Preserved Linux-owned trap, virtualization, and supervisor state across
    the synthetic SSE handler.
  - Added framework stress modes and updated MAINTAINERS.

Previous versions:
  v9:
    https://lore.kernel.org/r/cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com
  v8:
    https://lore.kernel.org/r/20251105082639.342973-1-cleger@rivosinc.com

How to test
===========

Enable the SSE framework and SSE overflow delivery:

  CONFIG_RISCV_SBI_SSE=y
  CONFIG_RISCV_PMU_SBI=y
  CONFIG_RISCV_PMU_SBI_SSE=y

PMU-SSE also requires two OpenSBI fixes:

  f30a54f3b3a0 ("lib: sbi: pmu: Remove MIP clearing from pmu_sse_enable()")
    [2], included since OpenSBI v1.7,
    which keeps an overflow pending while its SSE event is temporarily
    disabled; and
  35511bc6ee1c ("lib: sbi: sse: clear SPV for non-virtualized events") [3],
    not yet included in a tagged release,
    which stops a stale HSTATUS.SPV from being applied to a non-virtualized
    event.

Build tools/testing/selftests/riscv, then run:

  for stress in 0 1 2; do
          ./run_sse_test.sh stress=$stress || break
  done
  ./sse_perf_ustack

Useful perf regression workloads include:

  perf record -e cycles -a -- sleep 1
  perf top
  perf record -g -F 999 -- hackbench
  perf record --call-graph dwarf,8192 -F 999 -- hackbench
  perf record -a -C 3 -e cycles -F 999 -- \
          taskset -c 3 perf bench sched pipe -l 3000000

Limitations and follow-up work
==============================

This series does not yet deliver SSE events into a guest or unwind a guest
stack; a later KVM-SSE series will let the host receive an event from firmware
and inject the corresponding event into the guest.

Hibernation and crash kernels are unsupported: the current SBI interface
cannot reconstruct firmware registrations after an image is restored, and a
crash kernel cannot take over the registrations left by the crashed kernel, so
it leaves SSE masked.

[1] https://docs.riscv.org/reference/sbi/ext-sse.html
[2] https://github.com/riscv-software-src/opensbi/commit/f30a54f3b3a091c225a00476f4039bf399badd1f
[3] https://github.com/riscv-software-src/opensbi/commit/35511bc6ee1c9c17b6a89b44c52e2044bb51b979

Acknowledgements
================

The original five feature patches were developed by Clément Léger and
Himanshu Chauhan. Thanks to Susheng Yang for reporting the perf callchain
failure and for providing a workload that made it reproducible.

Sorry for keeping you waiting. Since v9 I spent a good deal of time hardening
the lifecycle and error paths and reproducing and analysing the bugs that only
show up in the callchain path, until the series finally passed both functional
and sustained stress testing on hardware. I am confident in v10, but, echoing
Clément, SSE is a genuinely complex feature: it adds a new NMI-like entry path
into the kernel to stand in for a hardware NMI. I would therefore welcome wider
community testing and feedback, especially under high-frequency delivery and
more complex handlers.

---

Clément Léger (5):
  riscv: add SBI SSE extension definitions
  riscv: add support for SBI Supervisor Software Events extension
  drivers: firmware: add riscv SSE support
  perf: RISC-V: add support for SSE event
  selftests/riscv: add SSE test module

Zhanpeng Zhang (4):
  riscv: sse: mask events during shutdown and kexec
  riscv: mm: avoid enabling interrupts for nofault page faults
  perf: RISC-V: support callchains with SSE delivery
  selftests/riscv: add perf user-stack SSE copy regression test

 Documentation/arch/riscv/index.rst            |    1 +
 Documentation/arch/riscv/pmu-sse.rst          |   55 +
 MAINTAINERS                                   |   22 +
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
 arch/riscv/kernel/perf_callchain.c            |  142 +++
 arch/riscv/kernel/reset.c                     |   18 +
 arch/riscv/kernel/sbi_sse.c                   |  246 ++++
 arch/riscv/kernel/sbi_sse_entry.S             |  226 +++
 arch/riscv/kernel/smp.c                       |   17 +
 arch/riscv/mm/fault.c                         |   11 +-
 drivers/firmware/Kconfig                      |    1 +
 drivers/firmware/Makefile                     |    1 +
 drivers/firmware/riscv/Kconfig                |   18 +
 drivers/firmware/riscv/Makefile               |    3 +
 drivers/firmware/riscv/riscv_sbi_sse.c        | 1223 +++++++++++++++++
 drivers/perf/Kconfig                          |   11 +
 drivers/perf/riscv_pmu.c                      |   14 +-
 drivers/perf/riscv_pmu_sbi.c                  |  544 ++++++--
 include/linux/cpuhotplug.h                    |    1 +
 include/linux/perf/riscv_pmu.h                |   20 +-
 include/linux/riscv_sbi_sse.h                 |   95 ++
 tools/testing/selftests/riscv/Makefile        |    2 +-
 tools/testing/selftests/riscv/sse/Makefile    |   10 +
 .../selftests/riscv/sse/module/Makefile       |   22 +
 .../riscv/sse/module/riscv_sse_test.c         | 1154 ++++++++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |   59 +
 .../selftests/riscv/sse/sse_perf_ustack.c     |  564 ++++++++
 36 files changed, 4596 insertions(+), 101 deletions(-)
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

base-commit: 77ae27fd98f3b548797c9f22c10ab5cf1c4ada53
--
2.50.1 (Apple Git-155)
