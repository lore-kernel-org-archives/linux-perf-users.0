Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85CF3B3BF4
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386475; cv=none; b=H388px08Q9n0NBFPwIrglWAcLXhA96zMJ3ARDiwsxNChzIVwn0rbPmriSBbTXIYAgkKEDBc6M7UWtBUIyKxkYkt1+dFXsoidOv0wwHeyzTCDHlnkxRCS8LxvI1+RGA9wtxIgyl54AuFBC9MjDVIW4Uyz4Ey0FRw+SxlbTMPKepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386475; c=relaxed/simple;
	bh=O5J0qEgGEmt0Dd4UjYMSNxVKXAIxlDnLKc3hLUhulDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J+2/08P1dYJn5nYbOVLe4U19bV0EmuhevwWsR7R62e4qoYdWj5x/b3SYL/cxLslxHliuT76ivfHCrHFAipd6YmsrJA+cfoDtLX9ho8upLdWjqsCsLAfoeSd8+9Gu0S+/hUwv/Kya2RH41OkB2FlEw5qDhg0zKlMFbjLpVUgJ2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFgDafvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFgDafvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A441F00893;
	Tue,  2 Jun 2026 07:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386473;
	bh=qhaCyZAOzZZ8593W+r67btHmNFvdIpN8VG9BKaJgik0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NFgDafvcvhwV+xdFl0cWqDa/9ATxq8wXdy5mlLWyryWFucYo549hPiXvSNeWIlp2v
	 fEmtVvjhPvSe4vtauc2MJedlC57eeim+YkoeBDdsBmELQbOBSmq7NGKNCjBow51rlu
	 KR9gwgF1q/gMPTMS80GxaIO59OxPHXR7VZTokTFG/6D7V+8oyImH6KtAFkt4VWq66/
	 OUKHrz05bTo94RH8m8vOH05MKeWfbJm2EUjhm2fpg5wS/XaxbO8p5/wcrQqf42rGZa
	 JmgmawSwhyg3ZVNCt38LwkL5Y8KxE37Ze/M2j8/PejaLJCaxT5lWVeUMh3FKTnqd0Y
	 UhQRviw8Qhlog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf test: Refactor parallel poll loop to drain all
 pipes simultaneously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602073132.2653307-9-irogers@google.com>
References: <20260602073132.2653307-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 07:47:52 +0000
Message-Id: <20260602074753.59A441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Ignoring file descriptor 0 prevents capturing test output and ca=
uses resource leaks.
- [Medium] Using `sigprocmask()` in a multi-threaded application is undefin=
ed behavior according to POSIX.

Pre-existing issues:
- [High] Incomplete async-signal-safety mitigation leaves the heap vulnerab=
le to deadlocks on `siglongjmp`.
- [High] Calling `waitpid` on pid -1 reaps arbitrary child processes if `fo=
rk` fails.
--

commit 2522220ee0e19bb1625cae967792e0223c0e6d7d
Author: Ian Rogers <irogers@google.com>

perf test: Refactor parallel poll loop to drain all pipes simultaneously

This commit refactors the perf test suite to poll and drain output
pipes from all running children simultaneously. It aims to prevent
tests from blocking on full pipe buffers during parallel execution.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 06507066213b1..dccd5d733272c 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -488,16 +496,241 @@ static void finish_test(struct child_test **child_=
tests, int running_test, int c
>  	}
>  	/* Clean up child process. */
>  	ret =3D finish_command(&child_test->process);

[Severity: High]
This is a pre-existing issue, but I noticed something about how failed
commands are handled in this cleanup path.

In start_test(), child->process.pid is initialized to -1. If start_command()
fails to fork, the pid remains -1 and an error is returned.

The __cmd_test() function catches this error, jumps to err_out, and calls
finish_test() on all initialized children. finish_test() then calls
finish_command(), which invokes waitpid().

Because the pid is still -1, does waitpid(-1, ...) wait for any child
process in the process group, potentially stealing the exit status of other
parallel tests or unrelated processes?

> +	child_test->process.pid =3D 0;
> +	if (child_test->err_output.len > 0) {
> +		struct strbuf merged =3D STRBUF_INIT;
> +
> +		if (child_test->err_output.buf)
> +			strbuf_addstr_safe(&merged, child_test->err_output.buf);
> +		if (err_output.buf)
> +			strbuf_addstr_safe(&merged, err_output.buf);
> +		strbuf_release(&err_output);
> +		err_output =3D merged;
>  	}
[ ... ]
> +static int strbuf_addstr_safe(struct strbuf *sb, const char *s)
> +{
> +	sigset_t set, oldset;
> +	int ret;
> +
> +	sigemptyset(&set);
> +	sigaddset(&set, SIGINT);
> +	sigaddset(&set, SIGTERM);
> +	sigprocmask(SIG_BLOCK, &set, &oldset);

[Severity: Medium]
Since perf is linked with pthreads and employs multi-threading, does
sigprocmask() result in unspecified behavior according to POSIX?

Would it be safer to use pthread_sigmask() here to guarantee correct signal
masking across threads?

> +	ret =3D strbuf_addstr(sb, s);
> +	sigprocmask(SIG_SETMASK, &oldset, NULL);
> +	return ret;
> +}
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
> +	global_pfds =3D calloc(num_tests, sizeof(*pfds));

[Severity: High]
This isn't a bug introduced by this patch, but the test harness uses a
signal handler (cmd_test_sig_handler) that triggers siglongjmp() on SIGINT
or SIGTERM.

If a signal interrupts a heap allocation or deallocation, the libc malloc
lock is left permanently held. The cleanup path err_out then calls
finish_test(), which allocates memory, causing a guaranteed deadlock.

While strbuf_addstr_safe() aims to mitigate this, the newly added heap
operations in finish_tests_parallel() like calloc(), zfree(), and
strbuf_release() remain unprotected. Additionally, the pre-existing
strbuf_addstr() call inside the poll loop of finish_test() was not updated
to use the new safe wrapper.

Is there a way we can ensure these allocations don't deadlock if a signal
arrives during execution?

> +	global_pfd_indices =3D calloc(num_tests, sizeof(*pfd_indices));
> +	pfds =3D global_pfds;
> +	pfd_indices =3D global_pfd_indices;
> +	if (!pfds || !pfd_indices) {
> +		free(pfds);
> +		free(pfd_indices);
> +		global_pfds =3D NULL;
> +		global_pfd_indices =3D NULL;
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < num_tests; i++) {
> +		struct child_test *child =3D child_tests[i];
> +
> +		if (!child)
> +			continue;
> +		strbuf_init(&child->err_output, 0);
> +		if (child->process.err > 0)

[Severity: Medium]
If the perf test is run in an environment with standard input closed,
pipe() can legitimately return file descriptor 0 for the read end.

Does checking > 0 instead of >=3D 0 incorrectly treat this valid file
descriptor as invalid, causing the harness to silently fail to poll or
drain it?

> +			fcntl(child->process.err, F_SETFL, O_NONBLOCK);
> +	}
[ ... ]
> +			if (child->process.err > 0) {
> +				pfds[num_pfds].fd =3D child->process.err;
> +				pfds[num_pfds].events =3D POLLIN | POLLERR | POLLHUP | POLLNVAL;
> +				pfd_indices[num_pfds] =3D i;
> +				num_pfds++;
> +			}

[Severity: Medium]
As mentioned above, if child->process.err happens to be 0, it will also
be skipped here, meaning the output will be dropped entirely.

[ ... ]
> +		for (i =3D next_to_print; i < num_tests; i++) {
> +			struct child_test *child =3D child_tests[i];
> +
> +			if (!child || child->done)
> +				continue;
> +
> +			if (check_if_command_finished(&child->process)) {
> +				if (child->process.err > 0) {

[Severity: Medium]
And similarly, skipping file descriptor 0 here would cause a resource leak
since close() will be bypassed.

> +					drain_child_process_err(child);
> +					close(child->process.err);
> +					child->process.err =3D -1;
> +				}
> +				child->result =3D finish_command(&child->process);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602073132.2653=
307-9-irogers@google.com?part=3D1
