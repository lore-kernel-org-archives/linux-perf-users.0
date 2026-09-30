Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412193C3F51
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751108; cv=none; b=D1jdb58fgtTKUEGWxgVoHzOkNTxL6DZ+Jmao96HZuvBXdMGRce3PGY+FIwmfEugaRsxHQ+PdQVvMSDkcgs6AVRVChj5TE5j376V/KXEWKASQZimSPZ4F9/+gqkuLy6cB80NDgc6yb4bkFXKlzNjdsl7iKcVYLLG9iSS9N3h2pCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751108; c=relaxed/simple;
	bh=XeNYQKV/yHapcSaaZdZW2ZwTgb5Q7IMZ/Ftht3crZb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=crLQ0PPbexoLTgd6peByNuGvPeLPh/iErgtNwxc7TRobCZe31YjYu10OKW5fTcnTOqnIj8dee6GK8/D9eFiOdoimGa595o6jiUs204bkTFecQhfTyltrCZuhfGJ3O4gRC9+DrmYpGC12B+bHbhjApcRr5o/DOcobSuyJXpSXmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMqQRH+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMqQRH+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B611F000FF;
	Wed, 30 Sep 2026 06:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751103;
	bh=MaumJlhb3Tz2QWpGVvU1We2NPc4ymVXh+bVjYWMB8p0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMqQRH+gRN/qjcTOKv8kiflLl3S3yq4HG2rvkS9s6XgYLW3OxJ3VB1+QkMPHgYyeo
	 dIZQidbxLcTzb18BAVdT9b5ioJFgQIQaoD2lJV4UyH1DJdWnTKGyZXIau/aJ1aqyLY
	 Xp61bdS9+IqV+a6w3ilQKFIBDKi9XoKelzzXg76CFch5FTl7JHWUj6xpEkAVqnwySV
	 YOXXwvEzHcPeQBdT1RXOAsWNf7byj2GOCVi+YbmURyEhh7fSSlmcek+36mzHGdjz0i
	 t9sXHg9qF8DeeVtxkDYmmbq3LI3g9xFT3UpJC2EIQBcmSfRRy0Ndego+m2ncZe1vUS
	 jVCEba3S+o4zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/8] selftests/breakpoints: extend riscv test for
 ptrace hw break/watchpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930063919.608911-5-himanshu.chauhan@oss.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
 <20260930063919.608911-5-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:51:43 +0000
Message-Id: <20260930065143.94B611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] selftests: missing _exit(0) causes child to execute parent test lo=
gic
- [High] selftests: test failures are silently ignored causing false positi=
ve passes
- [Medium] selftests: orphaned stopped child processes on test error paths
- [Medium] selftests: unhandled SIGALRM causes abrupt test termination leav=
ing orphaned tracees
- [Low] selftests: hardware breakpoint readback lacks programmatic assertio=
ns
- [Low] selftests: commit message claims removal of code not present in diff
- [Low] selftests: size parameter in set_watchpoint is ignored
--

commit dad9f82e0eab9aaebe66d40b3104c52fdbe939dc
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

selftests/breakpoints: extend riscv test for ptrace hw break/watchpoints

This commit extends the RISC-V breakpoint selftests to cover the new
ptrace-based hardware breakpoint and watchpoint support. It exercises
both the PTRACE_GETREGSET/SETREGSET and PTRACE_GETHBPREGS/SETHBPREGS
interfaces.

> Also drop a leftover #if 0 block duplicating the HWDEBUG_* control
> field macros already defined in uapi/asm/ptrace.h.

[Severity: Low]
This isn't a bug in the code, but does the provided patch actually
include this removal? Looking at the diff, it doesn't seem to contain
any modifications removing an #if 0 block, so the patch contents might
have desynced from the commit message.

> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c =
b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
> index 0649940b709e0..13d6b3ff1b6ee 100644
> --- a/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
[ ... ]
> +static int do_bp_child(void (*bp_func)(void))
> +{
> +	if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) !=3D 0) {
> +		ksft_print_msg(
> +			       "ptrace(PTRACE_TRACEME) failed: %s\n",
> +			       strerror(errno));
> +		_exit(1);
> +	}
> +
> +	if (raise(SIGSTOP) !=3D 0) {
> +		ksft_print_msg(
> +			       "raise(SIGSTOP) failed: %s\n", strerror(errno));
> +		_exit(1);
> +	}
> +
> +	bp_func();
> +}

[Severity: High]
Does this child process need to terminate with _exit(0) here? Since it
doesn't exit, when the child returns from bp_func(), it will break out
of the child context and begin executing the parent's logic in
run_ptrace_bp_test(). This causes the child to wrongly issue waitpid()
and ptrace() commands on itself.

[ ... ]
> +static bool set_watchpoint(pid_t pid, int size)
> +{
> +	uint8_t *addr =3D (uint8_t *)&var;
> +	unsigned int control =3D 0;
> +	struct user_hwdebug_state dreg_state;
> +	struct iovec iov;
> +
> +	/* Write watchpoint */
> +	control =3D (HW_BREAKPOINT_W << 14) & ((0x7 << 14));
> +	control |=3D (HW_BREAKPOINT_LEN_8 << 4) & ((0x1f << 4));

[Severity: Low]
Is it intentional that the size parameter passed to set_watchpoint() is
ignored here? The code hardcodes HW_BREAKPOINT_LEN_8 into the control bits,
unconditionally forcing the watchpoint size to 8 bytes regardless of the
caller's request.

[ ... ]
> +static int run_ptrace_wp_test(void)
> +{
[ ... ]
> +	if (!set_watchpoint(pid, 8))
> +		return false;
> +
> +	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
> +		ksft_print_msg(
> +			"ptrace(PTRACE_CONT) failed: %s\n",
> +			strerror(errno));
> +		return false;
> +	}

[Severity: Medium]
If the test returns false early here, does it leak the stopped child
process? The child process is already blocked in raise(SIGSTOP), and by
returning early, the test runner bypasses the kill(pid, SIGKILL) cleanup
block at the end of the function, which could leave orphaned tracees
consuming system resources.

> +
> +	alarm(3);
> +	wpid =3D waitpid(pid, &status, __WALL);

[Severity: Medium]
If waitpid() blocks for 3 seconds (e.g., if the child never hits the
breakpoint), will the resulting SIGALRM abruptly terminate the test
suite? Because no signal handler is registered for SIGALRM, the default
action would kill the test process outright, bypassing test framework
reporting and leaving any traced children orphaned.

[ ... ]
> +static bool set_hbpregs_watchpoint(pid_t pid)
> +{
[ ... ]
> +	/* Read back and verify */
> +	memset(&state, 0, sizeof(state));
> +	if (ptrace(PTRACE_GETHBPREGS, pid, 0, &state) !=3D 0) {
> +		ksft_print_msg(
> +			"ptrace(PTRACE_GETHBPREGS) failed: %s\n",
> +			strerror(errno));
> +		return false;
> +	}
> +
> +	ksft_print_msg(
> +		"[hbpregs] watchpoint readback: addr=3D0x%lx type=3D%lu len=3D%lu ctrl=
=3D%lu\n",
> +		state.addr, state.type, state.len, state.ctrl);
> +
> +	return true;
> +}

[Severity: Low]
Should there be a programmatic assertion to validate the readback state?
The code currently prints the state to stdout, but doesn't check if the
returned addr, type, len, and ctrl actually match what was written.
Without a check, regressions in breakpoint state persistence might go
unnoticed by automated tests.

[ ... ]
> +static void run_ptrace_tests(void)
> +{
> +	run_ptrace_bp_test();
> +	run_ptrace_wp_test();
> +}

[Severity: High]
Since run_ptrace_bp_test() and run_ptrace_wp_test() return boolean
success values, does run_ptrace_tests() need to propagate these
results? Dropping them here masks test failures.

> +
> +/*
> + * BREAKPOINT TEST USING PTRACE - END
> + */
> +
[ ... ]
> @@ -213,7 +760,10 @@ int main(int argc, char *argv[])
>  		return -1;
> =20
>  	if (wp_triggered)
> -		printf("Watchpoint test passed!\n");
> +		ksft_print_msg("[perf_event]: Watchpoint test passed!\n");
> +
> +	run_ptrace_tests();
> +	run_hbpregs_tests();
> =20
>  	return 0;
>  }

[Severity: High]
Does main() need to return a non-zero exit code if the new tests fail?
Currently it unconditionally returns 0 at the end of execution, which
means CI systems will report a successful pass even if the new ptrace or
hbpregs tests completely fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930063919.6089=
11-1-himanshu.chauhan@oss.qualcomm.com?part=3D4
