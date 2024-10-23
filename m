Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71454D599;
	Wed, 23 Oct 2024 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724234; cv=none; b=hk2rHv8EU92LrjZHWuUbFZXm7Xe97NP7eMVR0QFhJ8AXOLeE1Wfah3b0J0FVRiopCL0RyCn1Q7eN9o4wLRbociH07hxKTTNjCRWQ5zMXINz2DAy2PDAEGiXzt+pdnBeU45qbbBJJmG5DIC6G8I6C4x+/4GpwkFLSUArvofp9ybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724234; c=relaxed/simple;
	bh=v2QkCIqU8GCdpfjR3qsNEiGrKMT2MRsQMJlgtLNW8fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqjnJem/0CbjX3fkzqTmNWX2c4Ub/ctYiZo2v8uxSy/XLx4F2mRy0In8kVXngE+jGcVKmQ2bnPMXSky/YRx7zLu16anPKqsJ4g9112A22G6iQBlJuodOE04qDiT5AvQyXrx0eAPqC2Aypd+yfYhPmmOIbtBME8F5yst9fxFd7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCr++ZRx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCr++ZRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA33C4CEC6;
	Wed, 23 Oct 2024 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729724234;
	bh=v2QkCIqU8GCdpfjR3qsNEiGrKMT2MRsQMJlgtLNW8fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCr++ZRxC/3jA3oOAO53kISWC6u8L/P5EZUSEwbTTYfUOFnX2oJ3CuPhmHtfoUVs/
	 MKS3iHyEOJ+l7dNUhZBXfTHH5XviVvYL7ODLHVMa4AA0iD2U+HZzsGWLKUrzcDYbsj
	 E+S+wSuJZ4F8c8KHPJ+8S9gdqHoTX+iAkzeweccgK5jToFRNsokfn99Jtd5kPidVqq
	 sFSMQAEGYrmDybga81mpY2KxNEBSUpD1V1iPxBAF/jKfHrEsr0k603GJ6hT2FoG8Nv
	 tnAsKW+eLZ/yp9OA2FtW26wmbMm+mb7DMUHQXpVpmgV2RnQPxOA81wOo79q6XzHAjT
	 TM40Hqf0yZYjA==
Date: Wed, 23 Oct 2024 15:57:12 -0700
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
Subject: Re: [PATCH v3 0/9] Run tests in parallel showing number of tests
 running
Message-ID: <Zxl_SGGuIrYcmMA9@google.com>
References: <20241018054719.1004128-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>

On Thu, Oct 17, 2024 at 10:47:10PM -0700, Ian Rogers wrote:
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

Can you renumber the tests so that the numbers can be continuous?

Also, it doesn't apply to the current perf-tools-next, please rebase.

Thanks,
Namhyung

> 
> v3: Mark additional shell tests as "(exclusive)" to avoid issues with
>     shared resources suggested by Namhyung. Add dependent signal
>     handler change so that kill/ctrl-C don't leave lots of processes,
>     previously sent here:
>     https://lore.kernel.org/lkml/20241017052137.225514-1-irogers@google.com/
> 
> v2: Fix inaccurate remaining counts when running specific
>     tests. Rename "remaining" to "active" to better reflect the
>     testing behavior. Move the exclusive flag to test cases and not
>     entire suites. Add more "(exclusive)" flags to test as
>     suggested-by James Clark. Remove "(exclusive)" flag from test
>     descriptions to keep the command line output more concise. Add
>     James Clark's tested-by.
> 
> Ian Rogers (9):
>   tools subcmd: Add non-waitpid check_if_command_finished()
>   perf test: Display number of active running tests
>   perf test: Reduce scope of parallel variable
>   perf test: Avoid list test blocking on writing to stdout
>   perf test: Tag parallel failing shell tests with "(exclusive)"
>   perf test: Add a signal handler around running a test
>   perf test: Run parallel tests in two passes
>   perf test: Make parallel testing the default
>   perf test: Add a signal handler to kill forked child processes
> 
>  tools/lib/subcmd/run-command.c                |  33 ++
>  tools/perf/tests/builtin-test.c               | 304 ++++++++++++------
>  .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
>  .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
>  .../coresight/thread_loop_check_tid_10.sh     |   2 +-
>  .../coresight/thread_loop_check_tid_2.sh      |   2 +-
>  .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
>  tools/perf/tests/shell/list.sh                |   5 +-
>  .../tests/shell/perftool-testsuite_report.sh  |   2 +-
>  tools/perf/tests/shell/probe_vfs_getname.sh   |   2 +-
>  .../shell/record+script_probe_vfs_getname.sh  |   2 +-
>  tools/perf/tests/shell/record.sh              |   2 +-
>  tools/perf/tests/shell/record_lbr.sh          |   2 +-
>  tools/perf/tests/shell/record_offcpu.sh       |   2 +-
>  tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
>  tools/perf/tests/shell/stat_bpf_counters.sh   |   2 +-
>  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
>  .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
>  tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
>  tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
>  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
>  .../tests/shell/trace+probe_vfs_getname.sh    |   2 +-
>  tools/perf/tests/task-exit.c                  |   9 +-
>  tools/perf/tests/tests-scripts.c              |   7 +-
>  tools/perf/tests/tests.h                      |   9 +
>  tools/perf/util/color.h                       |   1 +
>  27 files changed, 293 insertions(+), 115 deletions(-)
> 
> -- 
> 2.47.0.105.g07ac214952-goog
> 
