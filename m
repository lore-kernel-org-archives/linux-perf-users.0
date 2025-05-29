Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D61C84A5;
	Thu, 29 May 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748550074; cv=none; b=YmcMtki1l9AlnF4sZDPSlvsLDgbOoafU+0S9nbEDExcy+HHv6LoSAtYIFVMV93go67rZOkQzwq1NBRMfECRFgu3nVqoD9/v7vierRoWNYZWxi6FB9Uyg2/fcD8VDfkAD7A3nm12fEYDA5WxVo6D5LmCXsEjh11jouXO/JVSORRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748550074; c=relaxed/simple;
	bh=Mxkyc1Eweteaq/me/D0tLLsof/Zblogn+F+qt26BKzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2YRij9b5OZ70uQJH9w3tdMHVzCiYfHIxhzjjhEbjJQtg6pEfSwmOepU/n4CVz6aGUeJ+lJTK/CrnOf6iTIPZQjsF6SwfO0vIb7l8OlQgO985E53lsEiSLYzMtyZqsmIDuoUrisZhLGEAbIErlr+dHdfvJ9FztJir39DeXSgbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9o3AUg1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9o3AUg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE00AC4CEE7;
	Thu, 29 May 2025 20:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748550073;
	bh=Mxkyc1Eweteaq/me/D0tLLsof/Zblogn+F+qt26BKzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9o3AUg1ACr4xLOh9Ev/AQAcKyemTSlCNMVJCtiEBPHPdO7gRfj4Xf5BOYzOHgUix
	 mpNDIlrOy7Q6g7Dg3h/tKgSPxWU97XUaiRwdokNqrYprVVU3uj6AIamqKCd64xTtL1
	 Te5y7XwDNtWINXpzGLfZ2ZTozbQluUB/kOoPuGXg5JQ64HRM9vu361viGe87AhmnU7
	 QGiR8HXdmzHl4FmtrN5E9HKsUVfYd40RtZwObBUs5vON8ztSZHQLFuWMPD+uGbDovd
	 95TUkwX0tgX5VGmO6aHjoOAKEI60QvlUJzCE3W1mepnI1/PuPPNkvTzelDBlupLfC3
	 X9MhyS125bj1Q==
Date: Thu, 29 May 2025 17:21:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf debug: Add function symbols to dump_stack
Message-ID: <aDjBtuxyumBrn70B@x1>
References: <20250529052322.381947-1-irogers@google.com>
 <20250529052322.381947-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250529052322.381947-2-irogers@google.com>

On Wed, May 28, 2025 at 10:23:22PM -0700, Ian Rogers wrote:
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

So you are testing it with:

root@number:~# perf test PERF_RECORD 
  8: PERF_RECORD_* events & perf_sample fields                       : Running (1 active)
^C
Signal (2) while running tests.
Terminating tests with the same signal
Internal test harness failure. Completing any started tests:
  8: PERF_RECORD_* events & perf_sample fields                       : Skip (permissions)
root@number:~# 

?

I built it with DEBUG=1 and without, and with your patch, following your
example output, I'm not being able to reproduce.

Tried it as well with:

⬢ [acme@toolbx perf-tools-next]$ cat segv.patch 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8b30c6f16a9eeac1..e55d86f1097d6d79 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -402,6 +402,8 @@ static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
 {
 	struct rb_node *n;
 
+	*(int *)NULL = 0;
+
 	if (symbols == NULL)
 		return NULL;
 
⬢ [acme@toolbx perf-tools-next]$ patch -p1 < segv.patch 
patching file tools/perf/util/symbol.c
⬢ [acme@toolbx perf-tools-next]$ m
rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace/__pycache__/Core.cpython-313.pyc': Permission denied
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  INSTALL libapi_headers
  INSTALL libsymbol_headers
  INSTALL libbpf_headers
  CC      /tmp/build/perf-tools-next/util/symbol.o
  LD      /tmp/build/perf-tools-next/util/perf-util-in.o
  LD      /tmp/build/perf-tools-next/perf-util-in.o
  AR      /tmp/build/perf-tools-next/libperf-util.a
  LINK    /tmp/build/perf-tools-next/perf
  GEN     /tmp/build/perf-tools-next/python/perf.cpython-313-x86_64-linux-gnu.so
  INSTALL binaries
  INSTALL tests
  INSTALL libperf-jvmti.so
  INSTALL libexec
  INSTALL perf-archive
  INSTALL perf-iostat
  INSTALL perl-scripts
  INSTALL python-scripts
  INSTALL dlfilters
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
 18: 'import perf' in python                                         : Ok
⬢ [acme@toolbx perf-tools-next]$ 

root@number:~# perf top
perf: Segmentation fault
-------- backtrace --------
Segmentation fault (core dumped)
root@number:~#

Tried also with this, but probably something else is at play:

root@number:~# perf probe -x ~/bin/perf dump_stack
Added new event:
  probe_perf:dump_stack (on dump_stack in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:dump_stack -aR sleep 1

root@number:~# 
root@number:~# perf trace -e probe_perf:dump_stack/max-stack=16/ perf top
perf: Segmentation fault
-------- backtrace --------
root@number:~#

Running perf trace on a separate terminal it also doesn't catch
dump_stack being called (that probe point).

root@number:~# perf top --stdio
   PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cycles:P],  (all, 32 CPUs)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

perf: Segmentation fault
Segmentation fault (core dumped)
root@number:~#

root@number:~# nm ~/bin/perf | grep dump_stack
0000000000637eaa T __dump_stack
00000000006380fa T dump_stack
000000000063816b T sighandler_dump_stack
root@number:~#

⬢ [acme@toolbx perf-tools-next]$ rpm -q glibc
glibc-2.41-5.fc42.x86_64
root@number:~# uname -a
Linux number 6.14.8-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 22 19:26:02 UTC 2025 x86_64 GNU/Linux
root@number:~# 

What am I missing?

- Arnaldo
 
> ____ unexpected signal (2) ____
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
> v2: Fix NO_BACKTRACE=1 build (Arnaldo)
> ---
>  tools/perf/tests/builtin-test.c | 15 +++++++-
>  tools/perf/ui/tui/setup.c       |  2 +-
>  tools/perf/util/debug.c         | 68 +++++++++++++++++++++++++++------
>  tools/perf/util/debug.h         |  1 +
>  4 files changed, 73 insertions(+), 13 deletions(-)
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
> index f9ef7d045c92..0c7c6a9e158b 100644
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
> @@ -298,21 +305,60 @@ void perf_debug_setup(void)
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
> +#ifdef HAVE_BACKTRACE_SUPPORT
> +	if (!machine || !thread) {
> +		/*
> +		 * Backtrace functions are async signal safe. Fall back on them
> +		 * if machine/thread creation fails.
> +		 */
> +		backtrace_symbols_fd(stackdump, stackdump_size, fileno(file));
> +		machine__delete(machine);
> +		return;
> +	}
> +#endif
> +
> +	for (size_t i = 0; i < stackdump_size; i++) {
> +		struct addr_location al;
> +		u64 addr = (u64)stackdump[i];
> +		bool printed = false;
> +
> +		addr_location__init(&al);
> +		if (thread && thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al)) {
> +			al.sym = map__find_symbol(al.map, al.addr);
> +			if (al.sym) {
> +				fprintf(file, "    #%zd %p in %s ", i, stackdump[i], al.sym->name);
> +				printed = true;
> +			}
> +		}
> +		if (!printed)
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
> 2.49.0.1204.g71687c7c1d-goog
> 
