Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B78200B82;
	Thu, 17 Oct 2024 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207735; cv=none; b=gXzzMweS3PAjJCLG9+QsGufLY4d04XPy6bdbFBuU5C0/qUVMuuqehGmSfsjSeV9/ZhLf/pmMALvziv203DoDCpv6A6Ah72fjxyK1Cul0n5lvETSWcHBSOImsNJ0ksUvrrAIw/bKb+cgvrFqRf2aQ1VGE0jKcfpT1aIur8zc3sK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207735; c=relaxed/simple;
	bh=J59mHR3ILM/XpHOd/yqSXKjGLugTrHZhosExYlVWXRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrM0Z1pj8qiDXzjHX5mgOmg3uSEQtPe6w93wETgz6GrMkIlB796NVn0p7id3BfqaqwYW/VrCVyeikkfaDOAitvQzDxUREbikXjnzXlOv13cGdaTq+E+gwDZxJQrIFmLVf6XuUq+vY8WFxr7jCfgZcfIN+IP7FpK6Jn0H2AH2qF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRQO28Rk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRQO28Rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DEFC4CEC3;
	Thu, 17 Oct 2024 23:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729207734;
	bh=J59mHR3ILM/XpHOd/yqSXKjGLugTrHZhosExYlVWXRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRQO28RkTPPaS33CWgt1A0opxoL8Bp1n+Vd0aGXDpx+3duYXmo66pzMvRFvhrAhAk
	 5s9ClbxNI5dG9vHbQDOrp1JZfvH3xJEhQBlh7F4AduMx6iRQ6IoKMtQxF4C6ePnfqG
	 Ut+7/sZufbI3mYrBvSylzBXc+jDb5DpLp0X45rCM5v75DVm4aEob0DlnqTO8M59Z7i
	 5I3EoPYbfZMeBC7mXD9/B/c0PdGoUUlkywdrRlydo4rL8ZkXA2PSbKsID1T+iCZQhk
	 MXCbSIAjjymHuV7Cv3vi0o/nKyMARQW0fjp5/Q7+DYVuf0Qurhof90CxGNerKtLk/P
	 4csXl0a1dAtlQ==
Date: Thu, 17 Oct 2024 16:28:52 -0700
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
Message-ID: <ZxGdtB-jQCptIiui@google.com>
References: <20241011220354.756798-1-irogers@google.com>
 <ZxBQ6Z2dvxmQ9Vi0@google.com>
 <CAP-5=fUpYZWGU_vDrDekwJu-n-Dw-aymaFsbohnZtqjYG1rDRw@mail.gmail.com>
 <CAP-5=fXaiZS3sUctP9K=h5cgaL1dFsuWbhhJFfM4=Avg+xduPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXaiZS3sUctP9K=h5cgaL1dFsuWbhhJFfM4=Avg+xduPw@mail.gmail.com>

On Thu, Oct 17, 2024 at 05:49:12AM -0700, Ian Rogers wrote:
> On Wed, Oct 16, 2024 at 5:28 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Oct 16, 2024 at 4:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Fri, Oct 11, 2024 at 03:03:46PM -0700, Ian Rogers wrote:
> > > > Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
> > > > to read them for display. When running on a color terminal, display
> > > > the number of running tests (1 if sequential). To avoid previous
> > > > flicker, only delete and refresh the display line when it changes. An
> > > > earlier version of this code is here:
> > > > https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com/
> > > >
> > > > Add a signal handler for perf tests so that unexpected signals are
> > > > displayed and test clean up is possible.
> > > >
> > > > In perf test add an "exclusive" flag that causes a test to be run with
> > > > no other test. Set this flag manually for C tests and via a
> > > > "(exclusive)" in the test description for shell tests. Add the flag to
> > > > shell tests that may fail when run with other tests.
> > > >
> > > > Change the perf test loop to run in two passes. For parallel
> > > > execution, the first pass runs all tests that can be run in parallel
> > > > then the 2nd runs remaining tests sequentially. This causes the
> > > > "exclusive" tests to be run last and with test numbers moderately out
> > > > of alignment.
> > > >
> > > > Change the default to be to run tests in parallel. Running tests in
> > > > parallel brings the execution time down to less than half.
> > > >
> > > > v2: Fix inaccurate remaining counts when running specific
> > > >     tests. Rename "remaining" to "active" to better reflect the
> > > >     testing behavior. Move the exclusive flag to test cases and not
> > > >     entire suites. Add more "(exclusive)" flags to test as
> > > >     suggested-by James Clark. Remove "(exclusive)" flag from test
> > > >     descriptions to keep the command line output more concise. Add
> > > >     James Clark's tested-by.
> > > >
> > > > Ian Rogers (8):
> > > >   tools subcmd: Add non-waitpid check_if_command_finished()
> > > >   perf test: Display number of active running tests
> > > >   perf test: Reduce scope of parallel variable
> > > >   perf test: Avoid list test blocking on writing to stdout
> > > >   perf test: Tag parallel failing shell tests with "(exclusive)"
> > > >   perf test: Add a signal handler around running a test
> > > >   perf test: Run parallel tests in two passes
> > > >   perf test: Make parallel testing the default
> > >
> > > Nice work!  It looks much better now.
> > >
> > > But I'm seeing more failures in parallel mode.  Maybe we want to
> > > keep the default serial mode for a little more.
> >
> > As you say, I think we should be conservative and mark all tests that
> > need to serial/sequential/exclusive with the exclusive tag. If you
> > tell me the failing tests I can add them to 'perf test: Tag parallel
> > failing shell tests with "(exclusive)"' as I did for James Clark with
> > the ARM tests. I'd prefer we did the tagging rather than not enabling
> > parallel testing as otherwise I may never learn which tests fail for
> > people when run in parallel.
> 
> With repeat testing, most often for me it was fine, I was able to get
> a flake on the probe plus vfs_getname tests like:
> ```
> $ sudo /tmp/perf/perf test vfs -v
> 91: Add vfs_getname probe to get syscall args filenames             : Ok
> --- start ---
> test child forked, pid 466904
> Failed to write event: File exists
>  Error: Failed to add events.
> ---- end(-1) ----
> 93: Use vfs_getname probe to get syscall args filenames             : FAILED!
> --- start ---
> test child forked, pid 466906
> Error: event "vfs_getname" already exists.
> Hint: Remove existing event by 'perf probe -d'
>       or force duplicates by 'perf probe -f'
>       or set 'force=yes' in BPF source.
>  Error: Failed to add events.
> ---- end(-1) ----
> 127: Check open filename arg using perf trace + vfs_getname          : FAILED!
> ```
> So I'll make those exclusive in v2 too. If you could let me know of others.

Mine is the below (other than the existing probe test failure).  I ran
them 3 times and picked one failed at least once.

   92: Add vfs_getname probe to get syscall args filenames             : FAILED!
   94: Use vfs_getname probe to get syscall args filenames             : FAILED!
  112: perf stat --bpf-counters test                                   : FAILED!
  121: Test data symbol                                                : FAILED!
  128: Check open filename arg using perf trace + vfs_getname          : FAILED!

Thanks,
Namhyung

> 
> > > >
> > > >  tools/lib/subcmd/run-command.c                |  33 +++
> > > >  tools/perf/tests/builtin-test.c               | 274 ++++++++++++------
> > > >  .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
> > > >  .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
> > > >  .../coresight/thread_loop_check_tid_10.sh     |   2 +-
> > > >  .../coresight/thread_loop_check_tid_2.sh      |   2 +-
> > > >  .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
> > > >  tools/perf/tests/shell/list.sh                |   5 +-
> > > >  .../tests/shell/perftool-testsuite_report.sh  |   2 +-
> > > >  tools/perf/tests/shell/record.sh              |   2 +-
> > > >  tools/perf/tests/shell/record_lbr.sh          |   2 +-
> > > >  tools/perf/tests/shell/record_offcpu.sh       |   2 +-
> > > >  tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
> > > >  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
> > > >  .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
> > > >  tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
> > > >  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
> > > >  .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
> > > >  tools/perf/tests/task-exit.c                  |   9 +-
> > > >  tools/perf/tests/tests-scripts.c              |   7 +-
> > > >  tools/perf/tests/tests.h                      |   9 +
> > > >  tools/perf/util/color.h                       |   1 +
> > > >  22 files changed, 258 insertions(+), 110 deletions(-)
> > > >
> > > > --
> > > > 2.47.0.rc1.288.g06298d1525-goog
> > > >
