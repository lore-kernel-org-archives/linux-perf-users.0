Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144362E8E1D;
	Fri, 20 Jun 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750450987; cv=none; b=BqLYTBghcn/Lhmngux7s+cNwv+edxvmPxGOhJl3yL5QcLJYAEnG6Xc1dYKlm+/auxdMM27GX9+b2MsyHUHG9cDHKaUDI+cwrO9FGyL8azGdFduf6O5G7dQEHziCggn1KqhQwF9w6w99bnsWvpdHZK2QRH3kQoIcOzavQ9Q+41RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750450987; c=relaxed/simple;
	bh=xQt7jUNQ+jESbD6JRt2kJr1MVEcQ6cRayAxKiKBD8c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0pUWhFxp//PMalt5xOBmHkuQrZv6aid/Y6ZMPBiZ4IS7IzIguAPUTG+J8iPK2P4wPEqxJUt4Bmwdwg0EW7gxCEdUcCscqliefwZQufMpDP6+F5ZEK2uerrJM4vXwcPoe1DhzbT5Sp/nypEPGXF4ba/oDIF2f+78Pb/In0TEO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfpRamic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfpRamic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5A0C4CEE3;
	Fri, 20 Jun 2025 20:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750450986;
	bh=xQt7jUNQ+jESbD6JRt2kJr1MVEcQ6cRayAxKiKBD8c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfpRamicirXVWkyA9VhWVwQVlkufg85XNdsy2cWrr44lzUBIe00Z/Na/EQ6iQcif1
	 QQkYkcIqI3rgYljlkxWXQPCPTfAHErVc6x6MFeZs1x4XBab/OiMix+LczfvQaxHN3P
	 efKKJJSAExJvA0WIKXW0Ga5k8Lm6mzy9N918ACc9Xr1Hli0MrHYfvpqtuLEJApF6CJ
	 R/VYlbhZvt/B94osCJW3PmELwq3YnfywosqGG7upBQWhzUrQXwNkXjZ5UrOgynuzch
	 o0rKYknEiV/NEnaEnvczuSbBj0unZtYUTmjUun958sZU3fW9jVvWoU8R/UC1kW2TsK
	 qIeB1LQAyn/fA==
Date: Fri, 20 Jun 2025 13:23:04 -0700
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
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf debug: Add function symbols to dump_stack
Message-ID: <aFXDKO-aLWzA3M2H@google.com>
References: <20250611221521.722045-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611221521.722045-1-irogers@google.com>

On Wed, Jun 11, 2025 at 03:15:21PM -0700, Ian Rogers wrote:
> Symbolize stack traces by creating a live machine. Add this
> functionality to dump_stack and switch dump_stack users to use
> it. Switch TUI to use it. Add stack traces to the child test function
> which can be useful to diagnose blocked code.
> 
> Example output:
> ```
>   8: PERF_RECORD_* events & perf_sample fields                       : Running (1 active)
> ^C
> Signal (2) while running tests.
> Terminating tests with the same signal
> Internal test harness failure. Completing any started tests:
> :  8: PERF_RECORD_* events & perf_sample fields:
> 
> ---- unexpected signal (2) ----
>     #0 0x5590fb6209b6 in child_test_sig_handler builtin-test.c:243
>     #1 0x7f4a91e49e20 in __restore_rt libc_sigaction.c:0
>     #2 0x7f4a91ee4f33 in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:71
>     #3 0x7f4a91ef0333 in __nanosleep nanosleep.c:26
>     #4 0x7f4a91f01f68 in __sleep sleep.c:55
>     #5 0x5590fb638c63 in test__PERF_RECORD perf-record.c:295
>     #6 0x5590fb620b43 in run_test_child builtin-test.c:269
>     #7 0x5590fb5b83ab in start_command run-command.c:127
>     #8 0x5590fb621572 in start_test builtin-test.c:467
>     #9 0x5590fb621a47 in __cmd_test builtin-test.c:573
>     #10 0x5590fb6225ea in cmd_test builtin-test.c:775
>     #11 0x5590fb5a9099 in run_builtin perf.c:351
>     #12 0x5590fb5a9340 in handle_internal_command perf.c:404
>     #13 0x5590fb5a9499 in run_argv perf.c:451
>     #14 0x5590fb5a97e2 in main perf.c:558
>     #15 0x7f4a91e33d68 in __libc_start_call_main libc_start_call_main.h:74
>     #16 0x7f4a91e33e25 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>     #17 0x5590fb4fd6d1 in _start perf[436d1]
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 15 +++++++-
>  tools/perf/ui/tui/setup.c       |  2 +-
>  tools/perf/util/debug.c         | 64 +++++++++++++++++++++++++++------
>  tools/perf/util/debug.h         |  1 +
>  4 files changed, 69 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 45d3d8b3317a..80375ca39a37 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -6,6 +6,9 @@
>   */
>  #include <fcntl.h>
>  #include <errno.h>
> +#ifdef HAVE_BACKTRACE_SUPPORT
> +#include <execinfo.h>
> +#endif
>  #include <poll.h>
>  #include <unistd.h>
>  #include <setjmp.h>
> @@ -231,6 +234,16 @@ static jmp_buf run_test_jmp_buf;
>  
>  static void child_test_sig_handler(int sig)
>  {
> +#ifdef HAVE_BACKTRACE_SUPPORT
> +	void *stackdump[32];
> +	size_t stackdump_size;
> +#endif
> +
> +	fprintf(stderr, "\n---- unexpected signal (%d) ----\n", sig);
> +#ifdef HAVE_BACKTRACE_SUPPORT
> +	stackdump_size = backtrace(stackdump, ARRAY_SIZE(stackdump));
> +	__dump_stack(stderr, stackdump, stackdump_size);
> +#endif
>  	siglongjmp(run_test_jmp_buf, sig);
>  }
>  
> @@ -244,7 +257,7 @@ static int run_test_child(struct child_process *process)
>  
>  	err = sigsetjmp(run_test_jmp_buf, 1);
>  	if (err) {
> -		fprintf(stderr, "\n---- unexpected signal (%d) ----\n", err);
> +		/* Received signal. */
>  		err = err > 0 ? -err : -1;
>  		goto err_out;
>  	}
> diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> index 16c6eff4d241..022534eed68c 100644
> --- a/tools/perf/ui/tui/setup.c
> +++ b/tools/perf/ui/tui/setup.c
> @@ -108,7 +108,7 @@ static void ui__signal_backtrace(int sig)
>  
>  	printf("-------- backtrace --------\n");
>  	size = backtrace(stackdump, ARRAY_SIZE(stackdump));
> -	backtrace_symbols_fd(stackdump, size, STDOUT_FILENO);
> +	__dump_stack(stdout, stackdump, size);
>  
>  	exit(0);
>  }
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index f9ef7d045c92..8987ac250079 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -14,11 +14,18 @@
>  #ifdef HAVE_BACKTRACE_SUPPORT
>  #include <execinfo.h>
>  #endif
> +#include "addr_location.h"
>  #include "color.h"
> -#include "event.h"
>  #include "debug.h"
> +#include "event.h"
> +#include "machine.h"
> +#include "map.h"
>  #include "print_binary.h"
> +#include "srcline.h"
> +#include "symbol.h"
> +#include "synthetic-events.h"
>  #include "target.h"
> +#include "thread.h"
>  #include "trace-event.h"
>  #include "ui/helpline.h"
>  #include "ui/ui.h"
> @@ -298,21 +305,56 @@ void perf_debug_setup(void)
>  	libapi_set_print(pr_warning_wrapper, pr_warning_wrapper, pr_debug_wrapper);
>  }
>  
> +void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
> +{
> +	/* TODO: async safety. printf, malloc, etc. aren't safe inside a signal handler. */
> +	pid_t pid = getpid();
> +	struct machine *machine = machine__new_live(/*kernel_maps=*/false, pid);
> +	struct thread *thread = NULL;
> +
> +	if (machine)
> +		thread = machine__find_thread(machine, pid, pid);
> +
> +	if (!machine || !thread) {
> +		/*
> +		 * Backtrace functions are async signal safe. Fall back on them
> +		 * if machine/thread creation fails.
> +		 */
> +		backtrace_symbols_fd(stackdump, stackdump_size, fileno(file));
> +		machine__delete(machine);
> +		return;
> +	}
> +
> +	for (size_t i = 0; i < stackdump_size; i++) {
> +		struct addr_location al;
> +		u64 addr = (u64)stackdump[i];
> +
> +		addr_location__init(&al);
> +		if (!thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al))

It seems addr_location__exit(&al) is needed here.

Thanks,
Namhyung


> +			continue;
> +
> +		al.sym = map__find_symbol(al.map, al.addr);
> +		if (al.sym)
> +			fprintf(file, "    #%zd %p in %s ", i, stackdump[i], al.sym->name);
> +		else
> +			fprintf(file, "    #%zd %p ", i, stackdump[i]);
> +
> +		map__fprintf_srcline(al.map, al.addr, "", file);
> +		fprintf(file, "\n");
> +		addr_location__exit(&al);
> +	}
> +	thread__put(thread);
> +	machine__delete(machine);
> +}
> +
>  /* Obtain a backtrace and print it to stdout. */
>  #ifdef HAVE_BACKTRACE_SUPPORT
>  void dump_stack(void)
>  {
> -	void *array[16];
> -	size_t size = backtrace(array, ARRAY_SIZE(array));
> -	char **strings = backtrace_symbols(array, size);
> -	size_t i;
> -
> -	printf("Obtained %zd stack frames.\n", size);
> -
> -	for (i = 0; i < size; i++)
> -		printf("%s\n", strings[i]);
> +	void *stackdump[32];
> +	size_t size = backtrace(stackdump, ARRAY_SIZE(stackdump));
>  
> -	free(strings);
> +	__dump_stack(stdout, stackdump, size);
>  }
>  #else
>  void dump_stack(void) {}
> diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
> index a4026d1fd6a3..6b737e195ce1 100644
> --- a/tools/perf/util/debug.h
> +++ b/tools/perf/util/debug.h
> @@ -85,6 +85,7 @@ void debug_set_display_time(bool set);
>  void perf_debug_setup(void);
>  int perf_quiet_option(void);
>  
> +void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size);
>  void dump_stack(void);
>  void sighandler_dump_stack(int sig);
>  
> -- 
> 2.50.0.rc1.591.g9c95f17f64-goog
> 
