Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE092236FA
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645515; cv=none; b=mAUrq9Ya2XISGf0ZMia9cV+kkgSgmwTEZXqNmLkw3htUvgig7tEP2UWkhm0HPvgkQnXINRZICxdSRA9U8Xx/hboMh4bQFBfP7B5vdMAgrJA0FKwaCJcYonrwmZQJOkTKbU4GJyTHJ8SZd7HMRv5IZwEJ1l6Kql3pOK87Zt6wg7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645515; c=relaxed/simple;
	bh=IcVvTkqqOiLQ6nZ/lesk7Se8xm/g/KGx3EQSV8nAG60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zfk4pKxyeUkFTgLqB/zC2PxWqn6KM6WsiVf75FxyG5RsUCVVEXaWSxP/ttFhuhBsoq9fm88I0df2VPCnVp1+DE8xpiMf2p5gghqxxsBvGXtrvGocHpJ9Pi8wBofpsaMkBCQP+nSMDpbN0Oacz5YyPkct3/DBvvdj/Mvsjuz2+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kdm6j4O8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kdm6j4O8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6901F000FF;
	Tue, 29 Sep 2026 01:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790645513;
	bh=OqSLaYWK1ttuwa3Ku/2OXBV4c29e4W5yzeqb2yZxOlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kdm6j4O8aCGWL3MoETNhYp1fi9mjKmln8c1dzSS5sXoWQNECVzUkQ5wprVueirJ3O
	 oF2JcVXrqL2+0QEccHExDzdXaV22DxhXUxMo/8kt/xljN4bYXCDXKb7WXg+6A7DMet
	 3HSIIyjqLFlwKbkEy5h4cY8GB1gm6dSFNoJZwbEVRVmWU5xAKYih13C95oM9sFyt7U
	 nB0g6LRx0hYdueLDvEzuNHVlwfPGHdtzZaO30GopkEk2RyVoICWMj53mlW9ftWb5co
	 w0Niclg5XgKepaptMpv27gCs7pQkmfOUVFXF4zEtCOTAWu+xk1WXrptwLw0DQha9+p
	 brbjdBEUdcR8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf test: Add per-test timeout support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929011837.4157334-1-irogers@google.com>
References: <20260928210144.3925224-1-irogers@google.com>
 <20260929011837.4157334-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:31:53 +0000
Message-Id: <20260929013153.BD6901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: TOCTOU race in signal handler can kill unintended pro=
cess groups
--

commit e2e28e1fd08275414fa889f24a3483b8a0075cc0
Author: Ian Rogers <irogers@google.com>

perf test: Add per-test timeout support

When a test hangs in perf test, the entire test run hangs and makes it
difficult to inspect output from other tests. Add a new TEST_TIMEOUT result
category and a per-test timeout.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index d2f594921e25b..4ecbaf757095e 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -1096,7 +1254,10 @@ static int finish_tests_parallel(struct child_test=
 **child_tests, size_t num_tes
>  					close(child->process.err);
>  					child->process.err =3D -1;
>  				}
> +				kill_timed_out_group(child);
>  				child->result =3D finish_command(&child->process);
> +				if (child->timed_out)
> +					child->result =3D TEST_TIMEOUT;
>  				child->process.pid =3D 0;

[Severity: Medium]
Is there a TOCTOU race window here in finish_tests_parallel() before
child->process.pid is zeroed?

If check_if_command_finished() falls back to waitpid(..., WNOHANG) (e.g. wh=
en
/proc is unmounted) and reaps the child, finish_command() won't block.

If cmd_test_sig_handler is triggered via SIGINT or SIGTERM right after
finish_command() reaps the child but before child->process.pid is zeroed,
the asynchronous signal handler jumps back to __cmd_test() and executes
a kill on the stale PID.

[ ... ]
> @@ -1327,12 +1507,27 @@ static int __cmd_test(struct test_suite **suites,=
 int argc, const char *argv[],
>  			pr_debug3("Killing %d pid %d\n",
>  				  child_test->suite_num + 1,
>  				  child_test->process.pid);
> +			kill(-child_test->process.pid, err);
>  			kill(child_test->process.pid, err);
>  		}
>  		goto err_out;
>  	}

[Severity: Medium]
Can this escalation from kill(pid) to kill(-pid) in __cmd_test() turn the
single-process race into a full process group kill?

If the race window described above occurs, and a concurrent high-rate fork
workload wraps the PID space exactly to the newly reaped PID, this kill(-pi=
d)
command could wipe out an entire unrelated process group rather than just a
single reused PID.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929011837.4157=
334-1-irogers@google.com?part=3D1
