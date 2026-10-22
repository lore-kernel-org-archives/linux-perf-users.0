Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704100;
	b=c6RCDPugRisLmAxOeJezjrI+q7tws4MX59gpHVUNeXmpv7Gu8j57EvMZD7VK7jDpQIZM
	 KuZqdcNaALcGGcKGFAjP39MzfxDfqfkREoAGtHzg7kq/Dz2/gHIkkad5NlzXVjUSSDzUM
	 RcYvwe6C3BwMyMuL8CkuYz4/K7oGDRY9Igeu9J8mo37K7fnTAw+GAgHCJuxxnAMm+BVaT
	 t0AHMc5hvDtkZBJDGE5ypNSohLwHN5I6x+ya+5JpRs5bqAM6PD1ooNOe+CTLScr5jVXUG
	 pvWhdcg1Yn4maGqdWY5f782fINfuHfv3LCBk9FGtZR8iAvrFgPGAgn+Kjv0yh74I/Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CUMJcCbhwubLaePuvMUKkYob1l1bXJ1oxDip9b1IKBM=;
	b=Gk7J9KRjZm2yMoj2U8RLlkvWXKhIQeexMdssBCilQ5wkxW91JlX8gGDZuGT3QegSIAZ/
	 llE19wbxDhNtqVKkFvHycZ1+am2G2NSq8N+jElI8TodnQdbn89ibQNCMe+iN0Bl820eh2
	 9M4nqgKI8OoAzhl+YKT8CeBWNELrz1N7FW2a7cFyMTZEGK6vzuxzz13BASF44yV56YSN1
	 FHWxlKJesOJiNGN+gUA+3a4HJ5Oh5TtZ9Z/mdeRNJn7XiitayZyyX4sschVTxf5NYX53m
	 fc2d7iM7UUTtPbQJbRTDCw+f8xeNDhgzjM/zUvs75PjU59J97mXKTjrAFcK8WGUU+SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3tANx4u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEF606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3tANx4u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFC91F01828;
	Thu, 22 Oct 2026 21:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792704100;
	bh=CUMJcCbhwubLaePuvMUKkYob1l1bXJ1oxDip9b1IKBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B3tANx4uL8IBv4iPAvHZrVh7EkGuuJeWlRa6YX5TdczURu/fXP3DK9o/Xd8WadXzM
	 I/DZRlb7wTwWoEjKO2qxqClN6/OBPxzE+sd79AGehq0ij/wx0OhumfjPnnikz8I5d7
	 zIhgVjsCmNFYiPkl+AtD5rV+q+3oEXkHCc8R7djr24WhDAteL6mRTzDAeD7k7EPKlK
	 8c/EAiQFzhvPOVzH07GGtoUY87YbtchBV6BSexma/s8QrA/qQGQapGg7xmDZeh6SUV
	 Vx3bGh2b/z2nUswy0vWh84X2C7AXcPNwk/umjeCCbqeVbr//U0neJ9IrG3JhSJwM3j
	 PVLnPFI21xWHQ==
Message-ID: <sashiko-outbox-182058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] perf test: Add per-test timeout support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022210753.1851597-2-irogers@google.com>
References: <20261012234724.721224-1-irogers@google.com>
 <20261022210753.1851597-1-irogers@google.com>
 <20261022210753.1851597-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 21:21:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: pipe drained before kill_timed_out_group() kills subp=
rocesses
--

commit 9387c80164e94087cba7cfddba4fff510a8fabe3
Author: Ian Rogers <irogers@google.com>

perf test: Add per-test timeout support

This commit adds per-test timeout support to perf test, defaulting to 120
seconds and configurable via -t/--timeout. Forked test children are placed =
in
their own process groups so timed-out tests and their subprocesses can be
terminated and reported as timeouts in the test summary and JUnit output.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 880eece0bc123..b870ca0bd8262 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -815,6 +893,106 @@ static void print_test_failure_snippet(FILE *fp, co=
nst char *buf)
>  	free(line_lens);
>  }
> =20

[ ... ]

> +static void kill_timed_out_group(struct child_test *child)
> +{
> +	if (!child->timed_out || child->process.finished || child->process.pid =
<=3D 0)
> +		return;
> +
> +	pr_debug3("Sending SIGKILL to remaining processes of timed out test %d.=
%d (pgid %d)\n",
> +		  child->suite_num + 1, child->test_case_num + 1, child->process.pid);
> +	kill(-child->process.pid, SIGKILL);
> +}

[ ... ]

> +static int reap_child_test(struct child_test *child)
> +{
> +	sigset_t oldset;
> +	int ret;
> +
> +	block_term_signals(&oldset);
> +	kill_timed_out_group(child);
> +	ret =3D finish_command(&child->process);
> +	child->process.pid =3D 0;
> +	sigprocmask(SIG_SETMASK, &oldset, NULL);
> +	return child->timed_out ? TEST_TIMEOUT : ret;
> +}
> +
>  static void finish_test(struct child_test **child_tests, int running_tes=
t, int child_test_num,
>  		int width)
>  {

[ ... ]

> @@ -904,11 +1088,15 @@ static void finish_test(struct child_test **child_=
tests, int running_test, int c
>  					err_done =3D false;
>  					buf[len] =3D '\0';
>  					strbuf_addstr_safe(&err_output, buf);
> +				} else if (pfds[0].revents & (POLLHUP | POLLERR | POLLNVAL)) {
> +					close(err);
> +					err =3D -1;
> +					child_test->process.err =3D -1;
>  				}
>  			}
>  		}
> -		if (err_done)
> -			err_done =3D check_if_command_finished(&child_test->process);
> +		if (err_done || child_test->timed_out)
> +			err_done =3D test_command_finished(child_test);
>  	}
>  	/* Drain any remaining data from the pipe. */
>  	if (err >=3D 0) {

[ ... ]

> @@ -925,8 +1113,7 @@ static void finish_test(struct child_test **child_te=
sts, int running_test, int c
>  		fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
>  	}
>  	/* Clean up child process. */
> -	ret =3D finish_command(&child_test->process);
> -	child_test->process.pid =3D 0;
> +	ret =3D reap_child_test(child_test);

[ ... ]

> @@ -1157,14 +1350,13 @@ static int finish_tests_parallel(struct child_tes=
t **child_tests, size_t num_tes
>  			if (!child || child->done)
>  				continue;
> =20
> -			if (check_if_command_finished(&child->process)) {
> +			if (test_command_finished(child)) {
>  				if (child->process.err >=3D 0) {
>  					drain_child_process_err(child);
>  					close(child->process.err);
>  					child->process.err =3D -1;
>  				}
> -				child->result =3D finish_command(&child->process);
> -				child->process.pid =3D 0;
> +				child->result =3D reap_child_test(child);
>  				clock_gettime(CLOCK_MONOTONIC, &child->end_time);
>  				child->done =3D true;
>  			}

[Severity: Medium]
In tools/perf/tests/builtin-test.c, when running with verbose >=3D 1 so chi=
ld
stdout and stderr are piped through process.err, both finish_test() and
finish_tests_parallel() drain the pipe in an unbounded read loop before
calling reap_child_test() -> kill_timed_out_group():

tools/perf/tests/builtin-test.c:finish_test() {
	...
		if (err_done || child_test->timed_out)
			err_done =3D test_command_finished(child_test);
	}
	/* Drain any remaining data from the pipe. */
	if (err >=3D 0) {
		char buf[512];
		ssize_t len;

		while ((len =3D read(err, buf, sizeof(buf) - 1)) > 0) {
			buf[len] =3D '\0';
			strbuf_addstr_safe(&err_output, buf);
		}
	}
	...
	ret =3D reap_child_test(child_test);
}

And in parallel mode:

tools/perf/tests/builtin-test.c:finish_tests_parallel() {
	...
	if (test_command_finished(child)) {
		if (child->process.err >=3D 0) {
			drain_child_process_err(child);
			close(child->process.err);
			child->process.err =3D -1;
		}
		child->result =3D reap_child_test(child);
	...
}

If a timed-out test's main child process exits after the initial termination
signal while a subprocess in its process group survives and continuously
writes to stdout or stderr, test_command_finished() returns true once the
main child becomes a zombie. However, kill_timed_out_group() has not yet be=
en
called to terminate the remaining process group members.

Could a noisy surviving subprocess keep feeding the pipe so that the read()
loop in finish_test() or drain_child_process_err() never sees -EAGAIN or
end-of-file, hanging the test runner and growing err_output without bound
before reap_child_test() can call kill_timed_out_group()? Should
kill_timed_out_group() be invoked before draining the pipe when a timed-out
child has finished?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022210753.1851=
597-1-irogers@google.com?part=3D1
