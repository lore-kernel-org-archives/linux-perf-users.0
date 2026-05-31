Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C28C1F
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205992; cv=none; b=cLYdiDaTJliXVQLldxSTpp2auLKDDYHEhxxj0y7dKDhxp7pUGnl7UkQ8/RlMuX5NiIFbWoHfzoj4xcwpu/k46olDHtWZdThf6pq6TBG1uDGmLonxlqZcZCmC2Xfk1mhllEYpVVeJ5vRtZYHUZ9fiDwp21kT/5OgXFPvsnfGVv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205992; c=relaxed/simple;
	bh=3vDl9DXmfRNUnQjkd3/G92QNxnvwMqnbgGmDDsielCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTkWyjOyRdkj+13vZefB846918sYSOKtCGVeypPiffncuoX3pzTntmR8IM6vEIEoz5u0ptJg3KoAHMofnalV5JqW41pXcWCVO30fZqv5z/6b7kjumCzeZ953WJwn0nzkEnjekeIfCM0mRwHFmYrh6z+CuH1CfTLXRN/KUArDgpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuy1XU51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuy1XU51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EE11F00893;
	Sun, 31 May 2026 05:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780205991;
	bh=YsU5RzO0EkdG7kGvFizrDGzl/2tMaRkcbfibm8ca6Q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cuy1XU510uPwoc/PUXt9L6v5PdUX6po1xhqvnUYlLzP+Mby/WR5BA3JjE3rauxwNB
	 nFyaKVL2js4uAUrCaMpNOAo0LX1RPEFCwmZ6QgEYDzjwRQ5Nxs+0+Lj/zRJf6f/8Gb
	 V4IaQa7fW4fIYcHgCOcduIFCA2KC11qHWGwaS0d3eyniMKPjO2stzppuEYRKvRlVO0
	 SFBiYxDQv6jX6wpoYvznOh03fPdLWDZIob4wy4bHu6FyUGeZBddX3RaacNkfzVBjqv
	 /SUhOJoDn62nl+vpoieuMbHbOYQ+FsedaKU0RMdjcl365REq4G7h3NNFXa9Wd9bR03
	 IZGCIKE5vBPHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/14] perf test: Refactor parallel poll loop to
 drain all pipes simultaneously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-7-irogers@google.com>
References: <20260531052740.796087-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:39:50 +0000
Message-Id: <20260531053950.A2EE11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Fallback check `kill(pid, 0)` returns 0 for zombie processes, pote=
ntially causing an infinite hang.
- [Medium] Memory leak of strbuf and loss of buffered stderr logs during si=
gnal-triggered error cleanup.
- [Medium] Memory leak of `pfds` and `pfd_indices` arrays when parallel tes=
ts are interrupted by a signal.
--

commit fccb0af730a7fbaeb380e0ecba12b05cbeda0d6f
Author: Ian Rogers <irogers@google.com>

perf test: Refactor parallel poll loop to drain all pipes simultaneously

This patch implements finish_tests_parallel() to poll and drain output pipes
from all running children simultaneously. Reaping occurs out of order as
children finish, while final result printing remains strictly in order, spe=
eding
up parallel test execution.

> diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-comman=
d.c
> index b7510f83209a0..4f8ec001b9486 100644
> --- a/tools/lib/subcmd/run-command.c
> +++ b/tools/lib/subcmd/run-command.c
> @@ -241,8 +241,18 @@ int check_if_command_finished(struct child_process *=
cmd)
>  	sprintf(filename, "/proc/%u/status", cmd->pid);
>  	status_file =3D fopen(filename, "r");
>  	if (status_file =3D=3D NULL) {
> -		/* Open failed assume finish_command was called. */
> -		return true;
> +		/*
> +		 * fopen() can fail with ENOENT if the process has been reaped.
> +		 * It can also fail with EMFILE/ENFILE if RLIMIT_NOFILE is reached,
> +		 * or with EINTR/ENOMEM. Use kill(pid, 0) as a robust fallback
> +		 * to distinguish between active processes and dead ones without
> +		 * consuming file descriptors.
> +		 */
> +		if (errno =3D=3D ENOENT)
> +			return 1;
> +		if (kill(cmd->pid, 0) =3D=3D -1 && errno =3D=3D ESRCH)
> +			return 1;
> +		return 0;

[Severity: High]
Can this cause an infinite hang if a process becomes a zombie?

If fopen("/proc/<pid>/status", "r") fails persistently (e.g. due to EACCES),
this fallback uses kill(cmd->pid, 0). However, kill() returns 0 for zombie
processes since they still exist in the process table.=20

If this happens, check_if_command_finished() incorrectly returns 0. Over in
finish_tests_parallel(), the parent loop will see POLLHUP, close the child's
pipe, but because check_if_command_finished() still returns 0, finish_comma=
nd()
is never called to reap the zombie.

With num_pfds at 0 and running_count > 0, does the parent enter an infinite
usleep(10 * 1000) loop?

>  	}
>  	while (fgets(status_line, sizeof(status_line), status_file) !=3D NULL) {
>  		char *p;

[ ... ]

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 2ccb52a776ccb..87c6a67beb10e 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -509,6 +512,192 @@ static void finish_test(struct child_test **child_t=
ests, int running_test, int c
>  	zfree(&child_tests[running_test]);

[Severity: Medium]
Does this legacy cleanup path leak the newly added strbuf?

If a signal interrupts the test, siglongjmp() transfers control to the err_=
out
label in __cmd_test(), which calls finish_test() to clean up. finish_test()
uses zfree(&child_tests[running_test]) but doesn't call strbuf_release() on
child->err_output.

Since child->err_output is dynamically allocated in finish_tests_parallel(),
does this leak the internal buffer and lose any buffered stderr logs during
signal-triggered cleanup?

>  }
> =20
> +static void drain_child_process_err(struct child_test *child)
> +{
[ ... ]
> +static int finish_tests_parallel(struct child_test **child_tests, size_t=
 num_tests, int width)
> +{
> +	size_t next_to_print =3D 0;
> +	struct pollfd *pfds;
> +	size_t *pfd_indices;
> +	size_t num_pfds =3D 0;
> +	int last_running =3D -1;
> +	size_t i;
> +	int last_suite_printed =3D -1;
> +
> +	pfds =3D calloc(num_tests, sizeof(*pfds));
> +	pfd_indices =3D calloc(num_tests, sizeof(*pfd_indices));

[Severity: Medium]
Will these allocations leak if a signal is received?

If a signal like SIGINT is received during the polling loop,
cmd_test_sig_handler() invokes siglongjmp() to jump back to __cmd_test().
This abruptly unwinds the stack, completely bypassing the free(pfds) and
free(pfd_indices) calls at the end of this function.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D6
