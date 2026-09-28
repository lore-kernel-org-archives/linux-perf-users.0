Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7384495ADD
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630096; cv=none; b=jcRC0dk7tBOjKM3ZulYkcDRCwKWn+F6Z0gF5J3rqQnCTq2fdU3QYzV1k0WrbbPAYYpStt7YI11Khk1aJRy8jrc2p/tdUa6yVV42KiDjrfCwH4XPO9fUQrT+6FN9rfRTIiAtT12SGO2cnrm0uuAj5P5YRaRwgEZfZxkU322IdYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630096; c=relaxed/simple;
	bh=sXz9h0Ce6QlAUGZanA2s4RKe6l4AxaOZK4NspK6gyuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lbd42Ih0sKD8fQOd5IRc/NSroV1/P1eCM7weTvGGKFhlnkYlIml2qKfkloDQePPAYQEPm693YkHX0qPh2bdJu6CoWEXX1efT7gcPt52Sv8dN1HuAahWau0We5LSLERpds1SQbMVS36cR+XdzghPWq8n1CXQpWgEaX3tfQXqFmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9ieUzko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9ieUzko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384301F000FF;
	Mon, 28 Sep 2026 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790630095;
	bh=V/1DsE1by44FmX/yaVNaXvAXshn6FT5osAlsKtC6jf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A9ieUzko8R3mumK+q+fDrA7C0WlAtE92ZetBvZZLqHPx5D8tLsO6RjgLA5bO+z2If
	 8+4vNS3Ojr2gRKRZA4Xg1YzEkDWQHbX0uWczdZOzgjBv2P8royxkpQb+J5hw3d7eka
	 p8IoAdpd1gByxkQs0a5Y5iNrA7TudkRfExAIFVrwDF7uHw1EbhNZzYBNaDWdRrGjG8
	 bUuPkmyEQJWfzUJcnGXejnF2VBWzli4GfnY1eZX6CSRzY2F2J6JsqDtPklpT5CXG+e
	 MX7wXIC0Kxx90p+hsYlD/H2yKA8W08watTHhJ9wVXjJuTY2V6alBA36yxaFzYvX31Q
	 ujaqR3HfSlTVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf test: Add per-test timeout support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928210144.3925224-1-irogers@google.com>
References: <20260928210144.3925224-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 21:14:54 +0000
Message-Id: <20260928211455.384301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf test: overly broad waitpid() condition hangs test suite on no=
rmal failures
- [Medium] perf test: child tests inherit SA_RESTART SIGALRM handler, break=
ing alarm()
- [Medium] perf test: SIGKILL escalation for timed-out process groups is ab=
orted prematurely
--

commit efae32fde876d5c28dcaff79950fdf6547005215
Author: Ian Rogers <irogers@google.com>

perf test: Add per-test timeout support

This commit adds a new per-test timeout to perf test, defaulting to 60
seconds. Tests are placed into separate process groups, and timeouts are
enforced using an ITIMER_REAL periodic timer that sends SIGTERM followed
by a SIGKILL escalation after 1 second.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -378,20 +395,31 @@ static int run_test_child(struct child_process *pro=
cess)
> =20
>  	check_leaks();
>  err_out:
> -	fflush(NULL);
>  	for (size_t i =3D 0; i < ARRAY_SIZE(signals); i++)
>  		signal(signals[i], SIG_DFL);

[Severity: Medium]
Does this omit SIGALRM from being reset to SIG_DFL?

Since the parent __cmd_test() sets up a no-op handler with SA_RESTART for
SIGALRM before forking, children will inherit that handler. Will builtin te=
sts
that rely on the default SIGALRM behavior (like using alarm() to prevent
internal hangs) fail to terminate because the no-op handler overrides it?

> +	if (err =3D=3D TEST_FAIL) {
> +		/*
> +		 * Wait for any spawned child processes (such as shell scripts
> +		 * running trap cleanup handlers on SIGTERM) to finish before
> +		 * exiting.
> +		 */
> +		while (waitpid(-1, NULL, 0) > 0 || errno =3D=3D EINTR)
> +			;
> +	}

[Severity: High]
Can this loop hang the test suite indefinitely on normal failures?

This condition catches all normal test failures (err =3D=3D TEST_FAIL), not=
 just
tests interrupted by a timeout SIGTERM. If a test spawns child processes and
fails normally, it will block on waitpid(-1) because the child processes we=
re
never signaled to exit.

Will this hang the entire test run until the global timeout triggers, or
deadlock completely if timeouts are disabled via the dont-fork path?

> +	fflush(NULL);
>  	return -err;
>  }
[ ... ]
> @@ -748,6 +792,47 @@ static void print_test_failure_snippet(FILE *fp, con=
st char *buf)
>  	free(line_lens);
>  }
> =20
> +static void cmd_test_alarm_handler(int sig __maybe_unused)
> +{
> +}
> +
> +static void check_child_timeout(struct child_test *child, const struct t=
imespec *now)
> +{
> +	double elapsed;
> +	pid_t pid;
> +
> +	if (!test_timeout || !child || child->done || child->process.finished)
> +		return;

[Severity: Medium]
Does returning early when child->done is true bypass the SIGKILL escalation?

If the immediate child process exits after receiving SIGTERM, the parent
marks the entire test case as done (setting child->done to true in
finish_tests_parallel).

Will checking child->done here completely bypass the 1-second timer and the
kill(-pid, SIGKILL) call for the broader process group, leaving any
subprocesses that ignored SIGTERM to leak?

> +
> +	pid =3D child->process.pid;
> +	if (pid <=3D 0)
> +		return;
> +
> +	if (!child->timed_out) {
> +		elapsed =3D (now->tv_sec - child->start_time.tv_sec) +
> +			  (now->tv_nsec - child->start_time.tv_nsec) / 1000000000.0;
> +		if (elapsed >=3D test_timeout) {
> +			child->timed_out =3D true;
> +			child->timeout_time =3D *now;
> +			pr_debug3("Timeout (%us) for test %d.%d (pid %d), sending SIGTERM\n",
> +				  test_timeout, child->suite_num + 1,
> +				  child->test_case_num + 1, pid);
> +			kill(-pid, SIGTERM);
> +			kill(pid, SIGTERM);
> +		}
> +	} else if (!child->sigkill_sent) {
> +		elapsed =3D (now->tv_sec - child->timeout_time.tv_sec) +
> +			  (now->tv_nsec - child->timeout_time.tv_nsec) / 1000000000.0;
> +		if (elapsed >=3D 1.0) {
> +			child->sigkill_sent =3D true;
> +			pr_debug3("Sending SIGKILL to timed out test %d.%d (pid %d)\n",
> +				  child->suite_num + 1, child->test_case_num + 1, pid);
> +			kill(-pid, SIGKILL);
> +			kill(pid, SIGKILL);
> +		}
> +	}
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928210144.3925=
224-1-irogers@google.com?part=3D1
