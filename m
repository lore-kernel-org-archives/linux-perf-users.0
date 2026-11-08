Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105701;
	b=YTH53bLhxf13owmMOl/yKipU8kyJMIfVvyS5F5BS8LOtBddoRlAbO60CLiFmqGzq4STU
	 gwBZrNcO1qPynep2rucrKFi7xQcb4usEw4dEDI2rHYRluhHnGyg7AFDbpeElpRvE860f4
	 PxWLdrM4vO8/a2ajyNdfBma51optnN/5dUca3lMQiIGbhf+QIvNF7f/miInO/a4Bw91kP
	 uDkh6UJ2ap/h0Y6Ijlaqbei5cWdOg9xpieBBOOSRg+L/CU7pjmFEVJuY5IBIpPmAINDcx
	 Yoo3Fn04lpL13f5JUSqaMPcwUjDMMsDWtnoBFRi319bc66xTP44pXLTt8bqi3sVVLAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105701;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lmpnz1vLHbJ3dPKz5BCelzlMiXmBar94uMPTctw9zZo=;
	b=kyWHECaLWgq71J+eOcOmM39FgOMYUYwC1XoUpzkgwlQ6GjuZKh0ZsfBXkdJ0MdGlNdy1
	 eD9/nFsUhZRuu+uze1GOkCPGiLMUofE2GTKkGbCXb6ZBc/D0fZ4R2EVae3Y0N+6zO+fQe
	 Hpd5VDRP+vBkdDJOSp9/Z1D6GMJXeECotwaghl2v6Pn+07XU3ekJfkqpZMUCxctWAJzmS
	 l4g1nnzqQXuEnckp8c/fF4rvQ8x9GJBsz7HD/0E/FcpPq2pYOns5i3sENSRF0e6jZRLO9
	 Oyz/5xf4NLb3lpz4+gxeRoLIuCdWdd9QsnIlGtcOzlReJPwQglD0Kmbb9Vx6emEmwjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0FhQcof;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7856606A31F
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0FhQcof
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907F21F008A2;
	Sun,  8 Nov 2026 02:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794105700;
	bh=lmpnz1vLHbJ3dPKz5BCelzlMiXmBar94uMPTctw9zZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I0FhQcofGHHdGJ/G6kk+fnZ+ROpBPN67ClIv5oVyRK4e0sz5IzajJ3Vxo+OEgxUpc
	 /0dzEfH4rACiY53T56j4zNN+l8411bFBO+KDTS5yjjhLVt5kyaTIQ9SA3cPSJmh4wn
	 iqaZH3BV+ewjlApJQyzajzK0oM7XQw82Uoh3Lw7dVn+z4CReU1bbtb+RhsOAVIcnzZ
	 0tKLGCFpEjW+6SmIANvGP1i+3USupxmK8lTZ4/ocGuxweLH+2r97ijqdblt81Yxkfg
	 2few6JyMU+Zb5gizCOloCqkmCuvlDnOh+w3Eo2GHOhMAK/kw79fffL71oeVFRqZdcV
	 251GbhvgrTlhA==
Message-ID: <sashiko-outbox-203526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/8] selftests/breakpoints: extend riscv test for
 ptrace hw break/watchpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>
Cc: "Alexandre Ghiti" <alex@ghiti.fr>, "Jesse Taube" <jtaubepe@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, "Shuah Khan" <shuah@kernel.org>, linux-mm@kvack.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261107023917.40606-6-himanshu.chauhan@oss.qualcomm.com>
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
 <20261107023917.40606-6-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 02:41:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [Medium] selftests/breakpoints: 8-byte write into unsigned long var on
  32-bit riscv
- [Medium] selftests/breakpoints: icount_branch_result modified only via
  raw asm symbol
- [Low] selftests/breakpoints: format string mismatch for __u64 in
  breakpoint_test_riscv
- [Low] selftests/breakpoints: missing kselftest TAP reporting, skip
  handling, and changelog mismatch
- [Low] selftests/breakpoints: commit message out of sync with diff
  changes
- [Low] selftests/breakpoints: icount_branch_result invisible to C
  optimizer
- [Low] selftests/breakpoints: close(gfd) before wait_event() in
  trigger_wp() and trigger_bp()
--

commit 91bb1409ac047eda69672c8b99664375baad647d
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

> selftests/breakpoints: extend riscv test for ptrace hw break/watchpoints
>
> Cover the new ptrace-based hardware breakpoint/watchpoint support
> added for riscv: exercise the PTRACE_GETREGSET/SETREGSET regset path
> as well as the raw PTRACE_GETHBPREGS/SETHBPREGS interface, alongside
> the existing perf_event-based tests.
>
> Also drop a leftover #if 0 block duplicating the HWDEBUG_* control
> field macros already defined in uapi/asm/ptrace.h.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

[Severity: Low]
Is this commit message out of sync with the changes in the diff?  The parent
commit "riscv: Add breakpoint and watchpoint test for riscv" has no #if 0
block with duplicate HWDEBUG_* macros, while the new perf_event taken-branch
PC test (trigger_icount_branch()) and the close(gfd) fix in trigger_wp() are
not mentioned.

> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c =
b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
> index a8a94a788142d..b07f6770c380e 100644
> --- a/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c

[ ... ]

> +		if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_HW_WATCH, &iov) =3D=3D 0) {
> +			ksft_print_msg("ptrace(PTRACE_GETREGSET): Number of watchpoints: %u\n=
",
> +				       dreg_state.info);
> +			ksft_print_msg("ptrace(PTRACE_GETREGSET): addr: 0x%lx control: 0x%x\n=
",
> +				       dreg_state.dbg_regs[0].addr,
> +				       dreg_state.dbg_regs[0].control);
> +			if (!dreg_state.info ||
> +			    dreg_state.dbg_regs[0].addr !=3D (uintptr_t)addr ||
> +			    HWDEBUG_TYPE(dreg_state.dbg_regs[0].control) !=3D HW_BREAKPOINT_W=
 ||
> +			    HWDEBUG_SIZE(dreg_state.dbg_regs[0].control) !=3D size) {
> +				ksft_print_msg("Bad wp readback: info=3D%u addr=3D0x%lx ctrl=3D0x%x\=
n",
> +					       dreg_state.info,
> +					       dreg_state.dbg_regs[0].addr,
> +					       dreg_state.dbg_regs[0].control);
> +				return false;
> +			}

[Severity: Low]
Should these ksft_print_msg() calls use %llx and %llu instead of %lx and
%lu?  In arch/riscv/include/uapi/asm/ptrace.h,
struct user_hwdebug_state::dbg_regs[0].addr and
struct __riscv_hwdebug_state::{addr, type, len, ctrl} (printed in
set_hbpregs_watchpoint() and set_hbpregs_breakpoint()) are __u64, which is
unsigned long long on both 32-bit and 64-bit RISC-V, causing -Wformat
warnings and corrupting variadic argument reads on 32-bit RISC-V.

[ ... ]

> +static bool run_ptrace_wp_test(void)
> +{
> +	pid_t pid =3D fork();
> +	bool ret =3D false;
> +
> +	if (pid < 0) {
> +		ksft_print_msg("fork() failed: %s\n", strerror(errno));
> +		return false;
> +	}
> +
> +	if (pid =3D=3D 0)
> +		do_wp_child(&var, 8);
> +
> +	if (!wait_for_child_stop(pid, SIGSTOP, "ptrace watchpoint"))
> +		goto out;
> +
> +	if (!set_watchpoint(pid, 8))
> +		goto out;

[Severity: Medium]
Can do_wp_child(&var, 8) write past the end of var on 32-bit RISC-V?

var is declared as unsigned long (4 bytes on RV32), and
tools/testing/selftests/breakpoints/Makefile builds breakpoint_test_riscv f=
or
both riscv and riscv64.  Hardcoding 8 here and in set_hbpregs_watchpoint() /
run_hbpregs_wp_test() instead of sizeof(var) executes *(uint64_t *)addr =3D=
 47
in do_wp_child(), overflowing var in .bss and requesting HW_BREAKPOINT_LEN_8
on 32-bit kernels where only lengths up to 4 bytes are supported.

[ ... ]

> +static int icount_branch_result;
> +static unsigned long icount_branch_pc;

[ ... ]

> +static __attribute_noinline__ void run_icount_taken_branch(void)
> +{
> +	asm volatile(".option push\n"
> +		".option norvc\n"
> +		".globl icount_branch_insn\n"
> +		".globl icount_branch_fallthrough\n"
> +		".globl icount_branch_target\n"
> +		"li t0, 1\n"
> +		"li t1, 1\n"
> +		".balign 4\n"
> +		"icount_branch_insn:\n"
> +		"beq t0, t1, icount_branch_target\n"
> +		"icount_branch_fallthrough:\n"
> +		"la t2, icount_branch_result\n"
> +		"li t3, 2\n"
> +		"sw t3, 0(t2)\n"
> +		"j icount_branch_done\n"
> +		".balign 4\n"
> +		"icount_branch_target:\n"
> +		"la t2, icount_branch_result\n"
> +		"li t3, 1\n"
> +		"sw t3, 0(t2)\n"
> +		"icount_branch_done:\n"
> +		".option pop\n"
> +		:
> +		:
> +		: "t0", "t1", "t2", "t3", "memory");
> +}

[Severity: Low]
Can the compiler optimize away or constant-fold icount_branch_result when
building with optimizations enabled?  Because icount_branch_result is a
static variable whose address is never taken in C and that is only written =
via
a raw symbol name in the inline assembly rather than an asm output operand,
interprocedural optimization can fold reads of icount_branch_result to 0 and
elide the symbol from .bss.

[ ... ]

> +	if (icount_branch_result !=3D 1) {
> +		ksft_print_msg("Icount branch did not take the branch\n");
> +		return -1;
> +	}
> +
> +	if (icount_branch_pc !=3D (unsigned long)target_addr) {
> +		ksft_print_msg("Icount branch PC 0x%lx does not match target %p\n",
> +			       icount_branch_pc, target_addr);
> +		return -1;
> +	}

[Severity: Medium]
Does trigger_icount_branch() fail at this point in the series and prevent
run_ptrace_tests() and run_hbpregs_tests() from running?

Before the later commit "riscv: Add software supported single stepping with
mc/mc6 triggers" in this series, hw_breakpoint_handler() delivers the perf
breakpoint event at insn_addr without single-stepping to target_addr, so
icount_branch_pc !=3D (unsigned long)target_addr fails and main() returns -1
before reaching the new ptrace tests (in addition to icount_branch_result
being folded to 0 under -O1/-O2 unless marked volatile/__used or passed as =
an
asm operand).

[ ... ]

>  	ioctl(gfd, PERF_EVENT_IOC_ENABLE, 0);
>  	test_data =3D 0xdeadbeef;
>  	ioctl(gfd, PERF_EVENT_IOC_DISABLE, 0);
> =20
> +	close(gfd);
> +
>  	return 0;
>  }

[Severity: Low]
Can closing gfd in trigger_wp() (and trigger_bp()) before main() calls
wait_event() drop the perf fasync signal?

__perf_event_overflow() queues pending_irq via irq_work_queue() without
IRQ_WORK_HARD_IRQ, so on !CONFIG_SMP or CONFIG_PREEMPT_RT kernels kill_fasy=
nc()
is deferred until after the breakpoint trap returns to userspace:

trigger_wp()
  test_data =3D 0xdeadbeef
    <breakpoint trap>
      ...
        __perf_event_overflow()
          irq_work_queue(&event->pending_irq)
  close(gfd)
    __fput()
      perf_fasync(-1, ...)  <-- clears event->fasync before kill_fasync()
main()
  wait_event(&wp_mtx, "Watchpoint")  <-- times out after 5s

Closing gfd after wait_event() returns, as trigger_icount_branch() does,
avoids tearing down fasync while the signal is still pending.

[ ... ]

>  	if (wp_triggered)
> -		printf("Watchpoint test passed!\n");
> +		ksft_print_msg("[perf_event]: Watchpoint test passed!\n");
> +
> +	sem_init(&icount_branch_mtx, 0, 0);
> +	if (trigger_icount_branch() < 0)
> +		return -1;
> +
> +	if (!run_ptrace_tests())
> +		return -1;
> +	if (!run_hbpregs_tests())
> +		return -1;
> =20
>  	return 0;
>  }

[Severity: Low]
Should main() report results through the kselftest harness and skip when
hardware breakpoints are unsupported?

Although this patch includes kselftest.h and converts several prints to
ksft_print_msg(), main() never calls ksft_print_header(), ksft_set_plan(),
ksft_test_result_*(), or ksft_exit_*(), and exits with a bare return -1 (25=
5).
In addition, when set_watchpoint() or set_breakpoint() sees errno =3D=3D EI=
O ("not
supported") on platforms without hardware debug triggers, the test fails
instead of reporting a kselftest skip.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107023917.4060=
6-1-himanshu.chauhan@oss.qualcomm.com?part=3D5
