Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB84320B;
	Fri, 25 Oct 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874784; cv=none; b=XdcEO29pusqxw4IoHwqUAM42hBNSe12mK4Gjq6BDGzJ9ssStIus2yAwMN1Eb2B1cgsNQXfIn1+HQwZB0s4xghErCBYTIbavr7edi3HcPOS0Rn6fMrPB+szJJ5qeJfH6byBZKLgv9WTmbHFfm/uzMJ4MmPaGQjzHVKcsoJ6d6/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874784; c=relaxed/simple;
	bh=8dhg0mD8QTOXORuIIu5J9uE0TBP2PYczuhJ6uG5Fc9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/yoO/p9QKzyPvt5bNs3V54SYHod3pJSVjTWuhqn4WFrJxca9S/lySL8C4wxtQBEdD33uLHlPLUX/7g8LQyBbTHP/I0hN8pp7trBzqOhWisNGNuFqBJRWWaxFBDT/kgEyoxSmHBHgZg5cI5KlPpbexikaX8jSkKJnAkIRrtZP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFMAP8sm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFMAP8sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBF5C4CEC3;
	Fri, 25 Oct 2024 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729874784;
	bh=8dhg0mD8QTOXORuIIu5J9uE0TBP2PYczuhJ6uG5Fc9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFMAP8sm4YNFc3gqfzKZaf+xtba6VdI+VqMoKKnMUEQrHXQZSUjf/lgeoMENXw4rv
	 4OJXa/3TagS8FWcjvPGHg1zwMAS2rrpAkKsGXcmBiJAtYH2StYN70nuD7NYC7g07uw
	 PwkSV6nA0XGlUBDXcMuSQeOrk5i0MvikAFw4Z5bZNE1ShoD+4ACTTroE1go6dZy5vs
	 mSeFFcse7+WWUNQpmL3Ew7oFFeqDS7Iw72hNbbYBmRS0KKNURAtx55QvizL57Ljjob
	 jjLF0o0bD9oB4d4dXsBXPyzi/TzQj/7wv1HlLLLAfUUdKmkqzSaBAYbaoQzIAxgWh5
	 Yt6QeU84iZpxg==
Date: Fri, 25 Oct 2024 09:46:19 -0700
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
Subject: Re: [PATCH v4 00/10] Run tests in parallel showing number of tests
 running
Message-ID: <ZxvLW-DMFcM9_K71@google.com>
References: <20241024073324.1513433-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>

Hi Ian,

On Thu, Oct 24, 2024 at 12:33:14AM -0700, Ian Rogers wrote:
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

Thanks for the update, but I got a build error for this version.

  tests/builtin-test.c: In function '__cmd_test':                                 
  tests/builtin-test.c:479:6: error: variable 'width' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
    int width = 0;                                                                
        ^~~~~

Thanks,
Namhyung

> 
> v4: Add patch to sort exclusive tests last, this allows for increasing
>     test numbers as requested by Namhyung.
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
> Ian Rogers (10):
>   tools subcmd: Add non-waitpid check_if_command_finished()
>   perf test: Display number of active running tests
>   perf test: Reduce scope of parallel variable
>   perf test: Avoid list test blocking on writing to stdout
>   perf test: Tag parallel failing shell tests with "(exclusive)"
>   perf test: Add a signal handler around running a test
>   perf test: Run parallel tests in two passes
>   perf test: Make parallel testing the default
>   perf test: Add a signal handler to kill forked child processes
>   perf test: Sort tests placing exclusive tests last
> 
>  tools/lib/subcmd/run-command.c                |  33 ++
>  tools/perf/tests/builtin-test.c               | 405 ++++++++++++------
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
>  27 files changed, 365 insertions(+), 144 deletions(-)
> 
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
