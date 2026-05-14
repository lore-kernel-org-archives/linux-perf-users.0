Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C59402BAF
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768862; cv=none; b=lqHPJ9sWHQSY0qOaEgu17MlbDHz7d1rGfqqBSUNfpA0yJeYtU1AJT5rQc4zvkdsb2vk/qyAi32JF1SxmE4EV+Bh/ObWsTpc3aLIKaOEtghIdCt9b506FWIRKX0eZW/yhyuGcsZIthDGUaUpGt6WIrPsiAylK71qTOPsMZJA4z5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768862; c=relaxed/simple;
	bh=eOSLD/WPloCoEPwKyeqSFV9zdb2ZQ812GBy82xn/3Q0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WRGwH9t65odyHnFTkfw1ff7nN5Sot6QTuG2bj569w1rajW2FKPiFhGh3sHWuobaTGTwJ8XxS5Wcb/le8TqVGuqE39JqJGJ6mXO3ahyzXAsx+9KbuMaYxNAVYFy6Fgt+AbnRvSDNRhNDhCCzoobchx2/qZcqkrNXG91oZve9by8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNl/ROHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNl/ROHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2ECC2BCC9;
	Thu, 14 May 2026 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778768862;
	bh=eOSLD/WPloCoEPwKyeqSFV9zdb2ZQ812GBy82xn/3Q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eNl/ROHgo1SS6BybeVe+UjU4JHsOkloVdckKLVX4VbYLY0LHWP3RwSJSENv+1bO9I
	 LaZN8S16+PvdSBc7tQGPvYjUJ+YC97Uqf0ap/t9TaBN2ISSA//4lqhikBcdvEG4PoP
	 /20AY3n/Z9x8FRFvnvuKnCdybWoOJIinUoF1RSXZcc3G4izQonZUZtfQJbEeTdmCvn
	 nVdedDGWJ/w9EcowL+2j/9TOhulVJvWtUK/ssxBmGxB6SEXedDJYDqpi1NH+Xwww+j
	 0FyuxHr2C/+2APcQNvkzyJxg385/jj95r83HVlCSkfs+qmkJ+S2OcQ2kbHEhnr60ix
	 jy/pqDaRHbGRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/14] perf test: Refactor parallel poll loop to
 drain all pipes simultaneously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513230450.529380-7-irogers@google.com>
References: <20260513230450.529380-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 14:27:41 +0000
Message-Id: <20260514142741.EC2ECC2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The parallel test harness enters a 100% CPU busy loop if a child=
 process closes its stderr pipe (reaching EOF) but continues executing.
- [Medium] If the test harness hits the open file limit (RLIMIT_NOFILE), it=
 enters an infinite deadlock unable to reap finished children.
- [Medium] The error and signal cleanup path in `__cmd_test` relies on the =
legacy `finish_test()` function, causing memory leaks and false failure rep=
orting.
- [Low] The patch introduces a malformed function declaration that breaks c=
ompilation (Syntax Error).
--

commit 5bdeb841dfa855250491399c245c42f015b0d82b
Author: Ian Rogers <irogers@google.com>

perf test: Refactor parallel poll loop to drain all pipes simultaneously

This commit refactors the perf test harness to poll and drain output pipes
from all running children simultaneously into per-child buffers. This preve=
nts
child processes from blocking indefinitely when their pipe buffers fill up.

> diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-comman=
d.c
> index b7510f83209a0..60e7df3673169 100644
> --- a/tools/lib/subcmd/run-command.c
> +++ b/tools/lib/subcmd/run-command.c
> @@ -241,8 +241,8 @@ int check_if_command_finished(struct child_process *c=
md)
>  	sprintf(filename, "/proc/%u/status", cmd->pid);
>  	status_file =3D fopen(filename, "r");
>  	if (status_file =3D=3D NULL) {
> -		/* Open failed assume finish_command was called. */
> -		return true;
> +		/* Open failed. Only assume finished if process no longer exists. */
> +		return errno =3D=3D ENOENT ? 1 : 0;
>  	}

If finish_tests_parallel() launches many tests concurrently and hits the op=
en
file limit (RLIMIT_NOFILE), fopen() will fail with EMFILE.

Since this now returns 0, the test is assumed to still be running. Could th=
is
lead to an infinite loop where tests are never marked as finished, and no f=
ile
descriptors are ever freed to break the deadlock?

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index a350db071674a..ad1b941731ca1 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -508,6 +511,187 @@ static void finish_test(struct child_test **child_t=
ests, int running_test, int c
>  	zfree(&child_tests[running_test]);
>  }
> =20
> +static int finish_tests_parallel(struct child_test **child_tests, size_t=
 num_tests, int width)
> +{
> +	size_t next_to_print =3D 0;
> +	struct pollfd *pfds;
> +	size_t *pfd_indices;
> +	size_t num_pfds =3D 0;
> +static void drain_child_process_err(struct child_test *child)

This appears to be a duplicate partial declaration of finish_tests_parallel=
()
left over from a merge or refactor. Does this syntax error break the build?

> +{
> +	char buf[512];
> +	ssize_t len;
> +
> +	while ((len =3D read(child->process.err, buf, sizeof(buf) - 1)) > 0) {
> +		buf[len] =3D '\0';
> +		strbuf_addstr(&child->err_output, buf);
> +	}
> +}
[ ... ]
> +		if (num_pfds =3D=3D 0) {
> +			if (running_count > 0)
> +				usleep(10 * 1000);
> +		} else {
> +			int pret =3D poll(pfds, num_pfds, 100);
> +
> +			if (pret > 0) {
> +				for (p =3D 0; p < num_pfds; p++) {
> +					if (pfds[p].revents) {
> +						size_t idx =3D pfd_indices[p];
> +						struct child_test *child =3D child_tests[idx];
> +
> +						drain_child_process_err(child);
> +					}
> +				}
> +			}
> +		}

If a child process closes its stderr pipe (reaching EOF) but continues
executing, poll() returns POLLHUP. drain_child_process_err() will read 0 by=
tes,
but it does not close child->process.err or set it to -1.

Will the next iteration add this open file descriptor back to the poll() ar=
ray,
causing poll() to return immediately and create a tight busy loop until the
child finally exits?

[ ... ]
> @@ -670,8 +854,9 @@ static int __cmd_test(struct test_suite **suites, int=
 argc, const char *argv[],
>  		}
>  		if (!sequential) {
>  			/* Parallel mode starts tests but doesn't finish them. Do that now. */
> -			for (size_t x =3D 0; x < num_tests; x++)
> -				finish_test(child_tests, x, num_tests, width);
> +			err =3D finish_tests_parallel(child_tests, num_tests, width);
> +			if (err)
> +				goto err_out;
>  		}
>  	}
>  err_out:

If finish_tests_parallel() encounters an error and jumps to err_out, the cl=
eanup
path loops over all children and calls the legacy finish_test() function.=20

Because finish_test() uses a local string buffer, it does not release the
dynamically allocated child->err_output populated by finish_tests_parallel(=
).
Does this leak memory?

Additionally, finish_test() unconditionally calls finish_command(). If a ch=
ild
was already reaped in finish_tests_parallel() (where child->done is true),
could this second call lead to ECHILD errors and corrupted test results?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513230450.5293=
80-1-irogers@google.com?part=3D6
