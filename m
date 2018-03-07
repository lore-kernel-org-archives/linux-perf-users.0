From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/9] perf/urgent fixes
Date: Wed, 7 Mar 2018 09:22:58 +0100
Message-ID: <20180307082258.ldhidzjvdekhhi5g@gmail.com>
References: <20180306172343.16546-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180306172343.16546-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, David Ahern <dsahern@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>, Ilya Pronin <ipronin@twitter.com>, Jin Yao <yao.jin@intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Sangwon Hong <qpakzk@gmail.com>, stable@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, Wang Nan <wangnan0@huawei.>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 58bdf601c2de6071d0386a7a6fa707bd04761c47:
> 
>   Merge branch 'i2c/for-current-fixed' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2018-03-03 14:55:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.16-20180306
> 
> for you to fetch changes up to 8f2c9efabe1ed212b88ce1c5cf5e768385c9222e:
> 
>   perf record: Combine some auxtrace initialization into a single function (2018-03-06 12:03:39 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Be more robust when drawing arrows in the annotation TUI, avoiding a
>   segfault when jump instructions have as a target addresses in functions
>   other that the one currently being annotated. The full fix will come in
>   the following days, when jumping to other functions will work as call
>   instructions (Arnaldo Carvalho de Melo)
> 
> - Prevent auxtrace_queues__process_index() from queuing AUX area data for
>   decoding when the --no-itrace option has been used (Adrian Hunter)
> 
> - Sync copy of kvm UAPI headers and x86's cpufeatures.h (Arnaldo Carvalho de Melo)
> 
> - Fix 'perf stat' CVS output format for non-supported counters (Ilya Pronin)
> 
> - Fix crash in 'perf record|perf report' pipe mode (Jiri Olsa)
> 
> - Fix annoying 'perf top' overwrite fallback message on older kernels (Kan Liang)
> 
> - Fix the usage on the 'perf kallsyms' man page (Sangwon Hong)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> The following changes since commit 317660940fd9dddd3201c2f92e25c27902c753fa:
> 
>   perf/x86/intel/uncore: Fix Skylake UPI event format (2018-03-04 09:59:00 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.16-20180306
> 
> for you to fetch changes up to de19e5c3c51fdb1ff20d0f61d099db902ff7494b:
> 
>   perf tools: Fix trigger class trigger_on() (2018-03-06 11:31:14 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Be more robust when drawing arrows in the annotation TUI, avoiding a
>   segfault when jump instructions have as a target addresses in functions
>   other that the one currently being annotated. The full fix will come in
>   the following days, when jumping to other functions will work as call
>   instructions (Arnaldo Carvalho de Melo)
> 
> - Prevent auxtrace_queues__process_index() from queuing AUX area data for
>   decoding when the --no-itrace option has been used (Adrian Hunter)
> 
> - Sync copy of kvm UAPI headers and x86's cpufeatures.h (Arnaldo Carvalho de Melo)
> 
> - Fix 'perf stat' CSV output format for non-supported counters (Ilya Pronin)
> 
> - Fix crash in 'perf record|perf report' pipe mode (Jiri Olsa)
> 
> - Fix annoying 'perf top' overwrite fallback message on older kernels (Kan Liang)
> 
> - Fix the usage on the 'perf kallsyms' man page (Sangwon Hong)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf auxtrace: Prevent decoding when --no-itrace
>       perf tools: Fix trigger class trigger_on()
> 
> Arnaldo Carvalho de Melo (3):
>       perf annotate browser: Be more robust when drawing jump arrows
>       tools headers: Sync copy of kvm UAPI headers
>       tools headers: Sync x86's cpufeatures.h
> 
> Ilya Pronin (1):
>       perf stat: Fix CVS output format for non-supported counters
> 
> Jiri Olsa (1):
>       perf record: Fix crash in pipe mode
> 
> Kan Liang (1):
>       perf top: Fix annoying fallback message on older kernels
> 
> Sangwon Hong (1):
>       perf kallsyms: Fix the usage on the man page
> 
>  tools/arch/x86/include/asm/cpufeatures.h   |  1 +
>  tools/include/uapi/linux/kvm.h             |  2 ++
>  tools/perf/Documentation/perf-kallsyms.txt |  2 +-
>  tools/perf/builtin-record.c                |  9 +++++++++
>  tools/perf/builtin-stat.c                  |  2 +-
>  tools/perf/builtin-top.c                   |  2 +-
>  tools/perf/perf.h                          |  1 +
>  tools/perf/ui/browsers/annotate.c          | 25 +++++++++++++++++++++++++
>  tools/perf/util/auxtrace.c                 | 15 +++++++++------
>  tools/perf/util/record.c                   |  8 ++++++--
>  tools/perf/util/trigger.h                  |  9 +++++----
>  11 files changed, 61 insertions(+), 15 deletions(-)

Pulled, thanks a lot Arnaldo!

Note that there's a new, minor conflict between perf/core and perf/urgent - I 
resolved it and merged perf/urgent into perf/core, please double check my 
resolution.

	Ingo
