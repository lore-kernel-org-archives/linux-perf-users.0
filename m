Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4202E1EFC;
	Wed, 14 Oct 2026 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013609; cv=none; b=GvjM2Fb+Rxbm0PwRwrbljEuZhe9Vna6YacA61L8CxBhKgASDPrKyu+CI0KoBF0bgyoO8Y2IUU8mrfCrIrNXvsl1l2UCTefjZMRQ2qtrd8TuEsEqm/KxdHRINKWpw76yUUJBgtIsPgX0jui6/VZiJtGes/qBmfprKGD4h7Md/egw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013609; c=relaxed/simple;
	bh=7qitaDb+PxyT87NJxkcNRt3wlkLZdPPpODSRKZVNP18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E++0h+/OQWYPwjpYBMAk7jL6hep0cxVxrYswu1ofl0JLwbOKciXvwGmvA5U8fVHlkZyUffPUheVHBzudI/TKEc0XDN4UA9Xs9eWm/gT6Rlv2sgKtxA7TEKWC9RhanE/egI7ZUjXxOCt24Ar7mbfsmXkdvRXI+/2ngYBJsXKhmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Trp1dUvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Trp1dUvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664111F000C4;
	Wed, 14 Oct 2026 21:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792013608;
	bh=/Cy8UU3OkSyaj3xWNtdcQ5g7leSKBeFbGOC12lh6KEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Trp1dUvgIMoMz9aJO7k4RQW2Krtt4WxNegW8TkoNa36bL6ZS1NkTpsswtbUdnJINT
	 0tVhYUHL8GeSTf7FWUt1V6yXuH7NfKPFmpyQdqY7V5cRtGxi407Thk1aAesBdGF7mZ
	 d3odP3EQZf+2roA9tnJUrS7++NdLVu5eoKr8dNpJ3327T/s/+n0HJuuNn5NzQT0//d
	 3LfpuGdLKw6FuqeZVWsV/ujquBfL6DoW6dRpquzjQIct1VFZP67333N9R1qG+kO+c2
	 AxcJpHYrSklmnb8OJ8WBpo5+jO/81c9f20vvCXi1w2rCPFU+S3d+xcZd8YBBm1XOka
	 YQdPQp+VR2t6A==
Date: Wed, 14 Oct 2026 14:33:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, 9erthalion6@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 0/3] perf test: Per-test timeouts, JUnit XML
 compliance, and snippet improvements
Message-ID: <as_1Jr1h4qFF_2Jj@google.com>
References: <20260929025345.88829-1-irogers@google.com>
 <20261012234724.721224-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012234724.721224-1-irogers@google.com>

On Mon, Oct 12, 2026 at 04:47:21PM -0700, Ian Rogers wrote:
> This series adds per-test timeout support to 'perf test', improves JUnit
> XML output to validate against strict JUnit schemas, and refines the
> verbose=1 failure snippet output when tests fail with a signal or time
> out:
> 
> 1. Add a per-test timeout (default 60s, configurable via '-t'/'--timeout',
>    0 to disable, disabled with '-F'/'--dont-fork'). Forked tests run in
>    their own process groups and the existing polling loops in
>    finish_test() and finish_tests_parallel() check elapsed runtimes,
>    sending SIGTERM on timeout and escalating to SIGKILL after 1 second.
>    Timed out tests are reported as 'TIMEOUT!', listed in the summary,
>    and recorded as '<error message="TIMEOUT" type="timeout">' in JUnit
>    XML output.
> 
> 2. Update 'perf test -j' output to validate cleanly against both the
>    Apache Ant/Windy Road JUnit schema (JUnit.xsd) and the Jenkins
>    xUnit/Maven Surefire schema (junit-10.xsd), including required
>    '<testsuite>' attributes, '<properties>' from uname, '<system-out/>'
>    and '<system-err/>', self-closing tags, apostrophe escaping, and
>    UTF-8/XML 1.0 codepoint validation.
> 
> 3. Improve verbose=1 failure snippet selection in
>    print_test_failure_snippet() to skip blank and stack trace lines
>    when selecting context and scanning backwards from the end of the
>    log, and prioritize the test output line immediately preceding
>    '---- unexpected signal' so trailing test progress is shown instead
>    of outermost stack frames.
> 
> v4:
>  - Drop the ITIMER_REAL timer and SIGALRM handler in patch 1, relying on
>    the existing 10ms/100ms polling loops in finish_test() and
>    finish_tests_parallel() to detect timeouts.
>  - Only fall back to kill(pid, sig) when kill(-pid, sig) fails, and
>    ignore SIGTERM/SIGINT while waiting for subprocesses in
>    run_test_child().
>  - Add patch 3 to avoid stack trace noise in verbose=1 failure snippets.
> 
> v3:
>  - Block SIGINT/SIGTERM while a test process may be reaped and until its
>    pid is cleared, and skip already reaped tests in the signal path.
> 
> v2:
>  - Reset SIGALRM to SIG_DFL in the forked test child.
>  - Replace the blocking waitpid(-1) loop with a bounded, non-blocking
>    wait that only runs when interrupted by SIGTERM/SIGINT.
>  - Ensure the SIGKILL escalation reaches the whole process group before
>    the zombie is reaped.
>  - Factor out timespec_diff_secs() and TEST_KILL_GRACE_SECS.
> 
> Ian Rogers (3):
>   perf test: Add per-test timeout support
>   perf test: Improve JUnit XML schema compliance and completeness
>   perf test: Avoid stack trace noise in verbose=1 failure snippets

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-test.txt |  12 +-
>  tools/perf/tests/builtin-test.c        | 668 +++++++++++++++++++------
>  tools/perf/tests/tests.h               |   7 +-
>  3 files changed, 543 insertions(+), 144 deletions(-)
> 
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 
