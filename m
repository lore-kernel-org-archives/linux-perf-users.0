Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8B1D4326;
	Wed, 16 Oct 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122540; cv=none; b=KRcQ9yfpiktWv7GZO55pEBj0HPTFUrVV1f14HnEjS0wkZFUGQL0XXV59OOKdvbF+S9lhL3UEQa5+dkWaI2xqd3gi2Mh4C32OvjDViw35DguDjaW5UKy8dCaVNVRfJZM36g+ASskdJ153bltYF/fSAWXzEXKWNcxo40dDrOEWJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122540; c=relaxed/simple;
	bh=OTwOkoWmfTn4F0dH9iJsnedRplKiFkYwk4xyDcdIE8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOjTqBqVjhvYbBhbunsayuVLuVIhVGSg3wfSMx2DCMp1bw0EEKxhWbYlAUBYUUeOAviEdTaZK20IX8R1u3Wcx7fLp2luPCFFdRfL73tpLws2Iob2N7WMKvFpE8Y9Itn8V5ikIOCvOXjqvXepS9mUIEmXemJ2elJCOmV+m2QD5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs2FdFPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs2FdFPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059D4C4CEC5;
	Wed, 16 Oct 2024 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729122539;
	bh=OTwOkoWmfTn4F0dH9iJsnedRplKiFkYwk4xyDcdIE8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vs2FdFPi/ml057V1uZ/GMcyC8BPQpEXvAzu+LMqhPES4ha2Jz1BXFrWRuQXyZZ/4e
	 EmX5O/Qw24ZdDeCKxHpEljE3vV6EDsf7+mwbAPKpfyr5pBJK7Lw3kqD8U3r6SjYAK7
	 JnWRNhwNdtTRFqjjOgyv9FLWc3pnDsITCVRD/XEyAMbAiifCutrrZBLK6LP1keOC4O
	 ySymYpJtnYl3QieW3fQY0na+WXRdKjxFlGucvFYgU8Ff/bakQS4wy8F1rsxgFX+AJP
	 77+KqC7y7NSM1JmBoJ6J0BE2dLuCbtSFwKGzXSOSIgzpMYz2SJeCKjGmFIrD8gj5z1
	 aEHuwA4BBVe6w==
Date: Wed, 16 Oct 2024 16:48:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Run tests in parallel showing number of tests
 running
Message-ID: <ZxBQ6Z2dvxmQ9Vi0@google.com>
References: <20241011220354.756798-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011220354.756798-1-irogers@google.com>

On Fri, Oct 11, 2024 at 03:03:46PM -0700, Ian Rogers wrote:
> Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
> to read them for display. When running on a color terminal, display
> the number of running tests (1 if sequential). To avoid previous
> flicker, only delete and refresh the display line when it changes. An
> earlier version of this code is here:
> https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com/
> 
> Add a signal handler for perf tests so that unexpected signals are
> displayed and test clean up is possible.
> 
> In perf test add an "exclusive" flag that causes a test to be run with
> no other test. Set this flag manually for C tests and via a
> "(exclusive)" in the test description for shell tests. Add the flag to
> shell tests that may fail when run with other tests.
> 
> Change the perf test loop to run in two passes. For parallel
> execution, the first pass runs all tests that can be run in parallel
> then the 2nd runs remaining tests sequentially. This causes the
> "exclusive" tests to be run last and with test numbers moderately out
> of alignment.
> 
> Change the default to be to run tests in parallel. Running tests in
> parallel brings the execution time down to less than half.
> 
> v2: Fix inaccurate remaining counts when running specific
>     tests. Rename "remaining" to "active" to better reflect the
>     testing behavior. Move the exclusive flag to test cases and not
>     entire suites. Add more "(exclusive)" flags to test as
>     suggested-by James Clark. Remove "(exclusive)" flag from test
>     descriptions to keep the command line output more concise. Add
>     James Clark's tested-by.
> 
> Ian Rogers (8):
>   tools subcmd: Add non-waitpid check_if_command_finished()
>   perf test: Display number of active running tests
>   perf test: Reduce scope of parallel variable
>   perf test: Avoid list test blocking on writing to stdout
>   perf test: Tag parallel failing shell tests with "(exclusive)"
>   perf test: Add a signal handler around running a test
>   perf test: Run parallel tests in two passes
>   perf test: Make parallel testing the default

Nice work!  It looks much better now.

But I'm seeing more failures in parallel mode.  Maybe we want to
keep the default serial mode for a little more.

Thanks,
Namhyung

> 
>  tools/lib/subcmd/run-command.c                |  33 +++
>  tools/perf/tests/builtin-test.c               | 274 ++++++++++++------
>  .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
>  .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
>  .../coresight/thread_loop_check_tid_10.sh     |   2 +-
>  .../coresight/thread_loop_check_tid_2.sh      |   2 +-
>  .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
>  tools/perf/tests/shell/list.sh                |   5 +-
>  .../tests/shell/perftool-testsuite_report.sh  |   2 +-
>  tools/perf/tests/shell/record.sh              |   2 +-
>  tools/perf/tests/shell/record_lbr.sh          |   2 +-
>  tools/perf/tests/shell/record_offcpu.sh       |   2 +-
>  tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
>  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
>  .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
>  tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
>  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
>  tools/perf/tests/task-exit.c                  |   9 +-
>  tools/perf/tests/tests-scripts.c              |   7 +-
>  tools/perf/tests/tests.h                      |   9 +
>  tools/perf/util/color.h                       |   1 +
>  22 files changed, 258 insertions(+), 110 deletions(-)
> 
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 
