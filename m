Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BE17A2EA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273168; cv=none; b=NqUXaxVrG2l74IbI7pipeV0NGX4a4ehWpXYicyxr5OAKwCOY5l6rFY/FTkyQr/m6d4/aZVsuZZHSP+llWK3VyX9Og0PI7f+tzfBy82PCBleJGsNf8HSOVOVZtAHU/ep0eiF39SEMPrQ4XC9BoSDUWw1mFN9GNRs4/1Vz5BkO9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273168; c=relaxed/simple;
	bh=OF4EwuzzLbJHMkh5+Z+MKJ8wOf48gaAMnIQzFcIuJ0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VUPMnBQ11YDBjjUQKiOFQgylds9hBOezS70Jc9R0sUAnXkE5c0HGtfO1pdLKyJoHBGd4bXQQxslI0AVzkw7yDeTBUuShnWtdYlBsM2ZDxUlXhr5oEKSbWKhOuVitIhGPAmG71/Fp9HXTZyqdf6+tbYI1d7MwG4a4bw5aeTU6fWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeVMNY2V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeVMNY2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB4F1F00898;
	Mon,  1 Jun 2026 00:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780273166;
	bh=3r/iT8Kj6pm/bHOCGU5OCCcxO7nQBf3zrV4x3Hr+4pI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TeVMNY2V8Dpkgp/bmQ3r7DOrIlyyYD3ydxPUbFvEev/D4oO0N6jVpVwSswsOIILE/
	 GrWiJqXKMoxP7YJjkmtyO1zeGkL16OvF4bsbqviU51AaIOQ3DseuxsNbzRxi4wqB0z
	 aZKCCy4LrYc0K2Zairh3zkX3RFcRMmcwLEvs7o6eO696oRIj+6Py94MJ6ueqLvmvAl
	 LCoc8+7NP/M+MH0SSKbpSJtouycbsT6BmoKIH1DIdgZbDKCz8kIpjVWIZC9CksjsHi
	 GX1oU1SBmaFS4+vpAaCcJYSk+N24vZBoG6WbJx1tUhBqaPFSuGL5iff0rxZwvcE0pr
	 HUH0aYCC3W/5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] perf test: Refactor parallel poll loop to drain
 all pipes simultaneously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601000548.1195604-8-irogers@google.com>
References: <20260601000548.1195604-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 00:19:25 +0000
Message-Id: <20260601001925.DCB4F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Double-free vulnerability of `global_pfds` and `global_pfd_indices=
` via asynchronous signal handler interruption.
- [High] Heap corruption risk due to freeing an interrupted `strbuf` reallo=
cation during signal recovery.
- [Medium] Partially accumulated stderr output from test children is silent=
ly dropped during error recovery or test interruption.
--

commit 87845502f87dde054c91ccdd4d7201529645fceb
Author: Ian Rogers <irogers@google.com>

    perf test: Refactor parallel poll loop to drain all pipes simultaneously
   =20
    When running tests in parallel with verbose output (-v), child processes
    write to pipes. If a test produces significant output (e.G. Granite Rap=
ids
    metric parsing printing hundreds of lines), it fills the 64KB pipe buff=
er
    and blocks.
   =20
    Previously, the parent harness (finish_test) only polled the pipe of the
    current test waiting to be printed. Other children blocked indefinitely
    until the parent reached them, severely sequentializing execution.
   =20
    Address this by implementing finish_tests_parallel() to poll and drain
    output pipes from all running children simultaneously into per-child
    buffers. Reaping occurs out of order as children finish, while final
    result printing remains strictly in order.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 2ccb52a776ccb..9f71f11928c60 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -503,12 +509,205 @@ static void finish_test(struct child_test **child_=
tests, int running_test, int c
>  		fprintf(stderr, "%s", err_output.buf);
> =20
>  	strbuf_release(&err_output);
> +	strbuf_release(&child_test->err_output);

[Severity: Medium]
Will this silently drop partially accumulated output during error recovery?

If the test suite is interrupted (e.g., via SIGINT), the signal handler jum=
ps
to the err_out label in __cmd_test(), which attempts to gracefully reap all
started tests by invoking finish_test().

However, finish_test() uses a local strbuf err_output to collect only the
remaining output from the pipe. It then prints this local buffer and
unconditionally frees child_test->err_output without printing its contents.

This discards the output that was previously successfully collected by
finish_tests_parallel(), making it difficult to diagnose tests that were
running when the harness was interrupted.

>  	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=
=3D*/0);
>  	if (err > 0)
>  		close(err);
>  	zfree(&child_tests[running_test]);
>  }
> =20
> +static void drain_child_process_err(struct child_test *child)
> +{
> +	char buf[512];
> +	ssize_t len;
> +
> +	while ((len =3D read(child->process.err, buf, sizeof(buf) - 1)) > 0) {
> +		buf[len] =3D '\0';
> +		strbuf_addstr(&child->err_output, buf);

[Severity: High]
Is there a risk of heap corruption if a signal interrupts this reallocation?

The drain_child_process_err() function appends child process stderr to
child->err_output using strbuf_addstr(), which dynamically grows the buffer=
 by
invoking realloc().

If an asynchronous signal (e.g., SIGINT) arrives while the heap is actively
being modified inside realloc(), the signal handler's siglongjmp abruptly a=
borts
the process.

The recovery path then attempts to clean up memory in finish_test() by call=
ing
strbuf_release(&child_test->err_output), which invokes free() on the potent=
ially
corrupted heap state. This could deadlock the allocator or crash.

> +	}
> +}
> +
[ ... ]
> +		while (next_to_print < num_tests) {
> +			struct child_test *child =3D child_tests[next_to_print];
[ ... ]
> +			print_test_result(child->test, child->suite_num, child->test_case_num,
> +					  child->result, width, 0);
> +			strbuf_release(&child->err_output);
> +			child_tests[next_to_print] =3D NULL;
> +			zfree(&child);
> +			next_to_print++;
> +		}
> +	}
> +
> +	free(global_pfds);

[Severity: High]
Does this create a double-free vulnerability if a signal interrupts here?

The global variables global_pfds and global_pfd_indices are freed here, and
subsequently set to NULL. However, the test harness sets up an asynchronous
signal handler for SIGINT/SIGTERM which executes siglongjmp to jump back to
__cmd_test()'s error recovery path.

If a signal interrupts the execution exactly after free(global_pfds) but be=
fore
global_pfds =3D NULL, the signal handler unwinds the stack to __cmd_test(),
which then unconditionally executes free(global_pfds) in the err_out block.
Since the pointer hasn't been cleared yet, this causes a double free.

> +	free(global_pfd_indices);
> +	global_pfds =3D NULL;
> +	global_pfd_indices =3D NULL;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601000548.1195=
604-1-irogers@google.com?part=3D7
