From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/8] perf/urgent fixes
Date: Sat, 9 Feb 2019 13:15:05 +0100
Message-ID: <20190209121505.GA54650@gmail.com>
References: <20190205150708.9012-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, Michael Petlan <mpetlan@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Tony Jones <tonyj@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> Test results at the end of this message, as usual.
> 
> The following changes since commit 9dff0aa95a324e262ffb03f425d00e4751f3294e:
> 
>   perf/core: Don't WARN() for impossible ring-buffer sizes (2019-02-04 08:45:25 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.0-20190205
> 
> for you to fetch changes up to 8f2f350cbdb2c2fbff654cb778139144b48a59ba:
> 
>   perf script python: Add Python3 support to tests/attr.py (2019-02-05 10:31:08 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>     Fix handling of probe:vfs_getname when the probed routine is
>     inlined in multiple places, fixing the collection of the 'filename'
>     parameter in open syscalls.
> 
> perf test:
> 
>   Gustavo A. R. Silva:
> 
>     Fix bitwise operator usage in evsel-tp-sched test, which made tat
>     test always detect fields as signed.
> 
>   Jiri Olsa:
> 
>     Filter out hidden symbols from labels, added in systems where the
>     annobin plugin is used, such as RHEL8, which, if left in place make
>     the DWARF unwind 'perf test' to fail on PPC.
> 
>   Tony Jones:
> 
>     Fix 'perf_event_attr' tests when building with python3.
> 
> perf mem/c2c:
> 
>   Ravi Bangoria:
> 
>     Fix perf_mem_events on PowerPC.
> 
> tools headers UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>     Sync linux/in.h copy from the kernel sources, silencing a perf build warning.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf clang: Do not use 'return std::move(something)'
>       tools headers uapi: Sync linux/in.h copy from the kernel sources
>       perf symbols: Add fallback definitions for GELF_ST_VISIBILITY()
>       perf trace: Support multiple "vfs_getname" probes
> 
> Gustavo A. R. Silva (1):
>       perf tests evsel-tp-sched: Fix bitwise operator
> 
> Jiri Olsa (1):
>       perf symbols: Filter out hidden symbols from labels
> 
> Ravi Bangoria (1):
>       perf mem/c2c: Fix perf_mem_events to support powerpc
> 
> Tony Jones (1):
>       perf script python: Add Python3 support to tests/attr.py
> 
>  tools/include/uapi/linux/in.h             |  2 +-
>  tools/perf/Documentation/perf-c2c.txt     | 16 ++++++++++++----
>  tools/perf/Documentation/perf-mem.txt     |  2 +-
>  tools/perf/arch/powerpc/util/Build        |  1 +
>  tools/perf/arch/powerpc/util/mem-events.c | 11 +++++++++++
>  tools/perf/builtin-trace.c                | 25 +++++++++++++++++-------
>  tools/perf/tests/attr.py                  | 32 ++++++++++++++++++-------------
>  tools/perf/tests/evsel-tp-sched.c         |  2 +-
>  tools/perf/util/c++/clang.cpp             |  2 +-
>  tools/perf/util/mem-events.c              |  2 +-
>  tools/perf/util/symbol-elf.c              | 23 +++++++++++++++++++++-
>  11 files changed, 88 insertions(+), 30 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.c

Pulled, thanks a lot Arnaldo!

	Ingo
