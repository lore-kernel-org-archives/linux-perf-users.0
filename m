Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E841E32B9;
	Tue, 24 Jun 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787138; cv=none; b=LidTW+rM4AbcOXgLVePm7JX1L7Xv2BbldaCDtzAok3p6+ltXG/ngZz/jYng3G/Chqo+sIXduko7k7Hg6L7iMRolRo3OFceUnd3DjOIFtODAn+Rhm8ttyICzg2CSby/QhkRAyrd5iWMMFmyn3VwBPFZRC7yGbAexZVQ6Yk8M+Jqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787138; c=relaxed/simple;
	bh=pvZMlkbem7wbWBET0DLo6z9ZCBN6U4Fm4ZbkgXc9hKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtsKq7HQJVJzEBAP/YGcQ4RfnGWNV2VQ1wk/mF6WfE23M4iLgaSq0kInMJsQMoYy+cJaEoUBIQPejkg2dIN4r+cU4zkIIVP0hPZS3CL/R6pwgruV7Ezm1W8hDAMElm//o9QeqDtYGj4twX3dM4TKYF0+GxP7rb9oXRy9C7SuNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPaX1fn7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPaX1fn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4DEC4CEE3;
	Tue, 24 Jun 2025 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750787138;
	bh=pvZMlkbem7wbWBET0DLo6z9ZCBN6U4Fm4ZbkgXc9hKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPaX1fn7xZ8LeKu5zKWg0Fm5UmAUNnfY3d9CGZVP3RFBEn4eiO/2TtXY/0UG8KdC9
	 S1qFbv/M2ruP0BXP86ZoMttAGm8NFA7+L+Nbtc8VJIx9vT2eOur4BBSftB8yJAgO5n
	 N42XGgx0qo+oiSokaW8ew+RZEOsPY/fJT7PDvliT8wm2VTaxUVvi7muiz5NEEUzHf7
	 xKsNn72za9Slt9+2kGlScaNV6LEehQDXG+63+AOah3i+sXVCIWgOvr6FXgaP+BekEp
	 aDCILIQLaTv3aO/MlxkmdV0yEA+1ngCAtIUS7U33qGs+870r8WmZ7vH6jVRmwfcZlG
	 g7gVMogMQ2CkQ==
Date: Tue, 24 Jun 2025 10:45:36 -0700
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
Subject: Re: [PATCH v4 1/2] perf debug: Add function symbols to dump_stack
Message-ID: <aFrkQDcKpZilSOpj@google.com>
References: <20250623161930.1421216-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623161930.1421216-1-irogers@google.com>

Hi Ian,

On Mon, Jun 23, 2025 at 09:19:28AM -0700, Ian Rogers wrote:
> Symbolize stack traces by creating a live machine. Add this
> functionality to dump_stack and switch dump_stack users to use
> it. Switch TUI to use it. Add stack traces to the child test function
> which can be useful to diagnose blocked code.
> 
> Example output:
> ```
> $ perf test -vv PERF_RECORD_
> ...
>   7: PERF_RECORD_* events & perf_sample fields:
>   7: PERF_RECORD_* events & perf_sample fields                       : Running (1 active)
> ^C
> Signal (2) while running tests.
> Terminating tests with the same signal
> Internal test harness failure. Completing any started tests:
> :  7: PERF_RECORD_* events & perf_sample fields:
> 
> ---- unexpected signal (2) ----
>     #0 0x5628ad5570a3 in child_test_sig_handler builtin-test.c:0
>     #1 0x7f561de49df0 in __restore_rt libc_sigaction.c:0
>     #2 0x7f561de99687 in __internal_syscall_cancel cancellation.c:64
>     #3 0x7f561dee5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
>     #4 0x7f561def1393 in __nanosleep nanosleep.c:26
>     #5 0x7f561df02d68 in __sleep sleep.c:55
>     #6 0x5628ad5679ab in test__PERF_RECORD perf-record.c:0
>     #7 0x5628ad556fb0 in run_test_child builtin-test.c:0
>     #8 0x5628ad4f318d in start_command run-command.c:127
>     #9 0x5628ad557ef3 in __cmd_test builtin-test.c:0
>     #10 0x5628ad5585bf in cmd_test ??:0
>     #11 0x5628ad4e5bb0 in run_builtin perf.c:0
>     #12 0x5628ad4e5ecb in handle_internal_command perf.c:0
>     #13 0x5628ad461383 in main ??:0
>     #14 0x7f561de33ca8 in __libc_start_call_main libc_start_call_main.h:74
>     #15 0x7f561de33d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>     #16 0x5628ad4619d1 in _start ??:0
> 
> ---- unexpected signal (2) ----
>     #0 0x5628ad5570a3 in child_test_sig_handler builtin-test.c:0
>     #1 0x7f561de49df0 in __restore_rt libc_sigaction.c:0
>     #2 0x7f561dea3a14 in pthread_sigmask@GLIBC_2.2.5 pthread_sigmask.c:45
>     #3 0x7f561de49fd9 in __GI___sigprocmask sigprocmask.c:26
>     #4 0x7f561df2601b in __longjmp_chk longjmp.c:36
>     #5 0x5628ad5570c0 in print_test_result.isra.0 builtin-test.c:0
>     #6 0x7f561de49df0 in __restore_rt libc_sigaction.c:0
>     #7 0x7f561de99687 in __internal_syscall_cancel cancellation.c:64
>     #8 0x7f561dee5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
>     #9 0x7f561def1393 in __nanosleep nanosleep.c:26
>     #10 0x7f561df02d68 in __sleep sleep.c:55
>     #11 0x5628ad5679ab in test__PERF_RECORD perf-record.c:0
>     #12 0x5628ad556fb0 in run_test_child builtin-test.c:0
>     #13 0x5628ad4f318d in start_command run-command.c:127
>     #14 0x5628ad557ef3 in __cmd_test builtin-test.c:0
>     #15 0x5628ad5585bf in cmd_test ??:0
>     #16 0x5628ad4e5bb0 in run_builtin perf.c:0
>     #17 0x5628ad4e5ecb in handle_internal_command perf.c:0
>     #18 0x5628ad461383 in main ??:0
>     #19 0x7f561de33ca8 in __libc_start_call_main libc_start_call_main.h:74
>     #20 0x7f561de33d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>     #21 0x5628ad4619d1 in _start ??:0
>   7: PERF_RECORD_* events & perf_sample fields                       : Skip (permissions)
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Unfortunately it has some build errors so I had to remove it from the
tree.  I'll keep the patch 2/2 btw.

The NO_BACKTRACE=1 build caused a trouble like below.

    CC      /tmp/tmp.huqYLzBWIi/util/debug.o
  util/debug.c: In function '__dump_stack':
  util/debug.c:323:17: error: implicit declaration of function 'backtrace_symbols_fd' [-Wimplicit-function-declaration]
    323 |                 backtrace_symbols_fd(stackdump, stackdump_size, fileno(file));
        |                 ^~~~~~~~~~~~~~~~~~~~
  make[6]: *** [/usr/local/google/home/namhyung/project/linux/tools/build/Makefile.build:86: /tmp/tmp.huqYLzBWIi/util/debug.o] Error 1
  make[5]: *** [/usr/local/google/home/namhyung/project/linux/tools/build/Makefile.build:142: util] Error 2
  make[4]: *** [Makefile.perf:798: /tmp/tmp.huqYLzBWIi/perf-util-in.o] Error 2
  make[4]: *** Waiting for unfinished jobs....
  make[3]: *** [Makefile.perf:290: sub-make] Error 2
  make[2]: *** [Makefile:76: all] Error 2
  make[1]: *** [tests/make:341: make_no_backtrace_O] Error 1
  make: *** [Makefile:109: build-test] Error 2

And on 32-bit, it also shows:

    CC      /build/util/debug.o
  util/debug.c: In function '__dump_stack':
  util/debug.c:331:28: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
    331 |                 u64 addr = (u64)stackdump[i];
        |                            ^
  
  cc1: all warnings being treated as errors
  make[4]: *** [/linux/tools/build/Makefile.build:85: /build/util/debug.o] Error 1
  make[4]: *** Waiting for unfinished jobs....
  make[3]: *** [/linux/tools/build/Makefile.build:142: util] Error 2
  make[2]: *** [Makefile.perf:798: /build/perf-util-in.o] Error 2
  make[2]: *** Waiting for unfinished jobs....
  make[1]: *** [Makefile.perf:290: sub-make] Error 2
  make: *** [Makefile:76: all] Error 2

Thanks,
Namhyung

> ---
> v4: Additional addr_location__exit (Namhyung)
> v3: Rebase
> v2: Fix NO_BACKTRACE=1 build (Arnaldo)
> ---
>  tools/perf/tests/builtin-test.c | 15 +++++++-
>  tools/perf/ui/tui/setup.c       |  2 +-
>  tools/perf/util/debug.c         | 66 +++++++++++++++++++++++++++------
>  tools/perf/util/debug.h         |  1 +
>  4 files changed, 71 insertions(+), 13 deletions(-)
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
> index f9ef7d045c92..efc9d2c6448d 100644
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
> @@ -298,21 +305,58 @@ void perf_debug_setup(void)
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
> +		if (!thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al)) {
> +			addr_location__exit(&al);
> +			continue;
> +		}
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
> 2.50.0.rc2.761.g2dc52ea45b-goog
> 
