Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92B276022;
	Tue, 16 Sep 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049454; cv=none; b=nsMVAwBAmq2HyhBbTmGP5fQWC7KB/6/j8YgOrEt870iOdLN8E8nXH+TsgqcIJxIDYBqWF/B8CJaMYHujblxIaOoFlqZ0slqOQ2ueS5VQfcltQ6gbSQDMyRw9sIgTfC8iWQdaeOBErV9RucUCgJe5VobQUcAlEgKHDsr/ZYUKVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049454; c=relaxed/simple;
	bh=oOCz4ZC/B3OEba2UZc9WhRkO6LSkANYZ35eQnGNQPRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ9C6upwsni/ZfE6FT6Wm+foJLAxAK9+93dBZJ6zhXJx9Vn5auS97q8DWOfe6258NR9UkS4N1OTttxOD5EPGkO1iu9UaDoqh3/X/I++4wBm5gCC3Ryza2f9LKOZOO0ONPeBPncxDEB7/eVlgTWQQX5W52lAMipjIkvAJHJrmMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEsjOtGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEsjOtGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02CFC4CEEB;
	Tue, 16 Sep 2025 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758049453;
	bh=oOCz4ZC/B3OEba2UZc9WhRkO6LSkANYZ35eQnGNQPRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEsjOtGg7HrAlew/LSmyJwGxMAOUtPHnwkwT4+Ahfr+XhqRGg3VXcrC/u0wfcCRnx
	 9Dq1JGWmBX5+doX0GLaRisNWXCss/hpmYQ9wYBa1qifiP9T7PVIOCDVCUT8Y0vwHAv
	 V7pc+btB81P5BsfVAHRNsamAkINUm5vPTUpLMi/f3YmpquqlO1KFrXF0fyWXA9Td+V
	 O1chmanXcIK274Izz7tBDZbeBsG5qGWe8tJQarCHxu5CvzviHwWVtgdqjNhHduQF3m
	 vn1bZcteVYkGwyNCDKm0YkYy+bWghYAMrKoG7XPu3YWD01eZ++cjCfuroV7pWg2+xN
	 8tk1RewYDrOuA==
Date: Tue, 16 Sep 2025 16:04:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/4] perf test: Don't leak workload gopipe in
 PERF_RECORD_*
Message-ID: <aMm0qUcdeDJmwuyI@x1>
References: <20250821221834.1312002-1-irogers@google.com>
 <20250821221834.1312002-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821221834.1312002-3-irogers@google.com>

On Thu, Aug 21, 2025 at 03:18:32PM -0700, Ian Rogers wrote:
> The test starts a workload and then opens events. If the events fail
> to open, for example because of perf_event_paranoid, the gopipe of the
> workload is leaked and the file descriptor leak check fails when the
> test exits. To avoid this cancel the workload when opening the events
> fails.
> 
> Before:
> ```
> $ perf test -vv 7
>   7: PERF_RECORD_* events & perf_sample fields:
> --- start ---

⬢ [acme@toolbx perf-tools-next]$ patch -p1 < b
patching file tools/perf/tests/perf-record.c
Hunk #1 succeeded at 130 (offset 15 lines).
Hunk #2 succeeded at 142 with fuzz 1 (offset 15 lines).
Hunk #3 succeeded at 154 (offset 15 lines).
Hunk #4 succeeded at 167 (offset 15 lines).
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ git log --oneline -5 tools/perf/tests/perf-record.c
576bd7a8c90c48e9 (x1/perf-tools-next, x1/HEAD, five/perf-tools-next, five/HEAD) perf tests record: Update testcase to fix usage of affinity for machines with #CPUs > 1K
b4c658d4d63d6149 perf target: Remove uid from target
dc6d2bc2d893a878 perf sample: Make user_regs and intr_regs optional
fd8d5a3b076c033f perf tests: Add missing event.h include
9823147da6c893d9 perf tools: Move 'struct perf_sample' to a separate header file to disentangle headers
⬢ [acme@toolbx perf-tools-next]$

Can you please check that it is still ok?

I processed the first in the series and now I'm going thru the other
two.

- Arnaldo

> test child forked, pid 1189568
> Using CPUID GenuineIntel-6-B7-1
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0xa00000000 (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
>   disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -13
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0xa00000000 (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
>   disabled                         1
>   exclude_kernel                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0x400000000 (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
>   disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -13
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0x400000000 (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
>   disabled                         1
>   exclude_kernel                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
> Attempt to add: software/cpu-clock/
> ..after resolving event: software/config=0/
> cpu-clock -> software/cpu-clock/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             1 (PERF_TYPE_SOFTWARE)
>   size                             136
>   config                           0x9 (PERF_COUNT_SW_DUMMY)
>   sample_type                      IP|TID|TIME|CPU
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   enable_on_exec                   1
>   task                             1
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
>   { wakeup_events, wakeup_watermark } 1
> ------------------------------------------------------------
> sys_perf_event_open: pid 1189569  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -13
> perf_evlist__open: Permission denied
> ---- end(-2) ----
> Leak of file descriptor 6 that opened: 'pipe:[14200347]'
> 
> ---- unexpected signal (6) ----
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
>     #0 0x565358f6666e in child_test_sig_handler builtin-test.c:311
>     #1 0x7f29ce849df0 in __restore_rt libc_sigaction.c:0
>     #2 0x7f29ce89e95c in __pthread_kill_implementation pthread_kill.c:44
>     #3 0x7f29ce849cc2 in raise raise.c:27
>     #4 0x7f29ce8324ac in abort abort.c:81
>     #5 0x565358f662d4 in check_leaks builtin-test.c:226
>     #6 0x565358f6682e in run_test_child builtin-test.c:344
>     #7 0x565358ef7121 in start_command run-command.c:128
>     #8 0x565358f67273 in start_test builtin-test.c:545
>     #9 0x565358f6771d in __cmd_test builtin-test.c:647
>     #10 0x565358f682bd in cmd_test builtin-test.c:849
>     #11 0x565358ee5ded in run_builtin perf.c:349
>     #12 0x565358ee6085 in handle_internal_command perf.c:401
>     #13 0x565358ee61de in run_argv perf.c:448
>     #14 0x565358ee6527 in main perf.c:555
>     #15 0x7f29ce833ca8 in __libc_start_call_main libc_start_call_main.h:74
>     #16 0x7f29ce833d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>     #17 0x565358e391c1 in _start perf[851c1]
>   7: PERF_RECORD_* events & perf_sample fields                       : FAILED!
> ```
> 
> After:
> ```
> $ perf test 7
>   7: PERF_RECORD_* events & perf_sample fields                       : Skip (permissions)
> ```
> 
> Fixes: 16d00fee7038 ("perf tests: Move test__PERF_RECORD into separate object")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/perf-record.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index 0b3c37e66871..8c79b5166a05 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -115,6 +115,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	if (err < 0) {
>  		pr_debug("sched__get_first_possible_cpu: %s\n",
>  			 str_error_r(errno, sbuf, sizeof(sbuf)));
> +		evlist__cancel_workload(evlist);
>  		goto out_delete_evlist;
>  	}
>  
> @@ -126,6 +127,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, &cpu_mask) < 0) {
>  		pr_debug("sched_setaffinity: %s\n",
>  			 str_error_r(errno, sbuf, sizeof(sbuf)));
> +		evlist__cancel_workload(evlist);
>  		goto out_delete_evlist;
>  	}
>  
> @@ -137,6 +139,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	if (err < 0) {
>  		pr_debug("perf_evlist__open: %s\n",
>  			 str_error_r(errno, sbuf, sizeof(sbuf)));
> +		evlist__cancel_workload(evlist);
>  		goto out_delete_evlist;
>  	}
>  
> @@ -149,6 +152,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	if (err < 0) {
>  		pr_debug("evlist__mmap: %s\n",
>  			 str_error_r(errno, sbuf, sizeof(sbuf)));
> +		evlist__cancel_workload(evlist);
>  		goto out_delete_evlist;
>  	}
>  
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
