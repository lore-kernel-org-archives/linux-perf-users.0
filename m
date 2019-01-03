From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/29] perf/core improvements and fixes
Date: Thu, 3 Jan 2019 14:07:07 +0100
Message-ID: <20190103130707.GA47648@gmail.com>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Colin King <colin.king@canonical.com>, Joe Mario <jmario@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?utf-8?Q?Ond=C5=99ej_Lyson=C4=9Bk?= <olysonek@redhat.com>, Stanislav Fomichev <sdf@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 883f4def8b77e6870ce42be279564cca0256c611:
> 
>   Merge tag 'perf-core-for-mingo-4.21-20181218' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-12-20 18:51:47 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20190103
> 
> for you to fetch changes up to b25756df5b28cd7b6e91200fc5012e7c76e8ec69:
> 
>   perf session: Add comment for perf_session__register_idle_thread() (2019-01-02 11:05:06 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf c2c:
> 
>   Jiri Olsa:
> 
>   - Change the default coalesce setup to from '--coalesce pid,iaddr' to just '--coalesce iaddr'.
> 
>   - Increase the HITM ratio limit for displayed cachelines.
> 
> perf script:
> 
>   Andi Kleen:
> 
>   - Fix LBR skid dump problems in brstackinsn.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Check if the raw_syscalls:sys_{enter,exit} are setup before setting tp filter.
> 
>   - Do not hardcode the size of the tracepoint common_ fields.
> 
>   - Beautify USBDEFFS_ ioctl commands.
> 
>   Colin Ian King:
> 
>   - Use correct SECCOMP prefix spelling, "SECOMP_*" -> "SECCOMP_*".
> 
> perf python:
> 
>   Jiri Olsa:
> 
>   - Do not force closing original perf descriptor in evlist.get_pollfd().
> 
> tools misc:
> 
>   Jiri Olsa:
> 
>   - Allow overriding CFLAGS and LDFLAGS.
> 
> perf build:
> 
>   Stanislav Fomichev:
> 
>   - Don't unconditionally link the libbfd feature test to -liberty and -lz
> 
> thread-stack:
> 
>   Adrian Hunter:
> 
>   - Fix processing for the idle task, having a stack per cpu.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (8):
>       perf thread-stack: Simplify some code in thread_stack__process()
>       perf thread-stack: Tidy thread_stack__bottom() usage
>       perf thread-stack: Avoid direct reference to the thread's stack
>       perf thread-stack: Allow for a thread stack array
>       perf thread-stack: Factor out thread_stack__init()
>       perf thread-stack: Allocate an array of thread stacks
>       perf thread-stack: Fix thread stack processing for the idle task
>       perf session: Add comment for perf_session__register_idle_thread()
> 
> Andi Kleen (1):
>       perf script: Fix LBR skid dump problems in brstackinsn
> 
> Arnaldo Carvalho de Melo (11):
>       perf trace: Check if the raw_syscalls:sys_{enter,exit} are setup before setting tp filter
>       perf beauty mmap: PROT_WRITE should come before PROT_EXEC
>       perf trace: Do not hardcode the size of the tracepoint common_ fields
>       perf trace: Rename thread_thread->paths to thread_trace->files
>       perf trace: Move the files table resizing to outside set_pathname()
>       perf trace: Store the major number for a file when storing its pathname
>       tools headers uapi: Grab a copy of usbdevice_fs.h
>       perf beauty ioctl: Add generator for USBDEVFS_ ioctl commands
>       perf trace: Wire up ioctl's USBDEBFS_ cmd table generator
>       perf trace beauty: Export function to get the files for a thread
>       perf trace beauty ioctl: Beautify USBDEVFS_ commands
> 
> Colin Ian King (1):
>       perf trace: Use correct SECCOMP prefix spelling, "SECOMP_*" -> "SECCOMP_*"
> 
> Jiri Olsa (7):
>       perf python: Do not force closing original perf descriptor in evlist.get_pollfd()
>       perf c2c: Change the default coalesce setup
>       perf c2c: Increase the HITM ratio limit for displayed cachelines
>       tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command
>       tools thermal tmon: Allow overriding CFLAGS assignments
>       tools power turbostat: Override CFLAGS assignments and add LDFLAGS to build command
>       tools gpio: Allow overriding CFLAGS
> 
> Stanislav Fomichev (1):
>       perf build: Don't unconditionally link the libbfd feature test to -liberty and -lz
> 
>  tools/build/Makefile.feature                       |   4 +-
>  tools/build/feature/Makefile                       |  10 +-
>  tools/gpio/Makefile                                |   2 +-
>  tools/include/uapi/linux/usbdevice_fs.h            | 201 ++++++++++++++++++
>  tools/perf/Makefile.config                         |  44 ++--
>  tools/perf/Makefile.perf                           |   8 +
>  tools/perf/builtin-c2c.c                           |   4 +-
>  tools/perf/builtin-script.c                        |  21 +-
>  tools/perf/builtin-trace.c                         | 142 +++++++++----
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/trace/beauty/beauty.h                   |   7 +
>  tools/perf/trace/beauty/ioctl.c                    |  22 ++
>  tools/perf/trace/beauty/mmap.c                     |   2 +-
>  tools/perf/trace/beauty/seccomp.c                  |   4 +-
>  tools/perf/trace/beauty/usbdevfs_ioctl.sh          |  19 ++
>  tools/perf/util/dump-insn.c                        |   8 +
>  tools/perf/util/dump-insn.h                        |   2 +
>  tools/perf/util/intel-bts.c                        |   4 +-
>  .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   8 +
>  tools/perf/util/intel-pt.c                         |   6 +-
>  tools/perf/util/python.c                           |   3 +-
>  tools/perf/util/session.c                          |   7 +
>  tools/perf/util/thread-stack.c                     | 227 +++++++++++++++------
>  tools/perf/util/thread-stack.h                     |   8 +-
>  tools/power/x86/turbostat/Makefile                 |   8 +-
>  tools/power/x86/x86_energy_perf_policy/Makefile    |   6 +-
>  tools/thermal/tmon/Makefile                        |   8 +-
>  27 files changed, 620 insertions(+), 166 deletions(-)
>  create mode 100644 tools/include/uapi/linux/usbdevice_fs.h
>  create mode 100755 tools/perf/trace/beauty/usbdevfs_ioctl.sh

Pulled, thanks a lot Arnaldo!

	Ingo
