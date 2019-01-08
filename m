From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/16] perf/core improvements and fixes
Date: Tue, 8 Jan 2019 16:32:34 +0100
Message-ID: <20190108153234.GA110207@gmail.com>
References: <20190104183337.12771-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Ivan Krylov <krylov.r00t@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Mattias Jacobsson <2pi@mok.nu>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 2573be22e5b6f24a0cabc97715c808c47e29eaaf:
> 
>   Merge tag 'perf-core-for-mingo-4.21-20190103' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-01-03 14:05:16 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20190104
> 
> for you to fetch changes up to 03fa483821c0b4db7c2b1453d3332f397d82313f:
> 
>   perf test shell: Use a fallback to get the pathname in vfs_getname (2019-01-04 15:12:29 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf annotate:
> 
>   Ivan Krylov:
> 
>   - Pass filename to objdump via execl, fixing usage with filenames
>     with special characters.
> 
> perf report:
> 
>   Jin Yao:
> 
>      Fix wrong iteration count in --branch-history
> 
> perf stat:
> 
>   Jin Yao:
> 
>   - Fix endless wait for child process
> 
> perf test:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use a fallback to get the pathname in vfs_getname in
> 
> tools build:
> 
>   Jiri Olsa:
> 
>   - Allow overriding CFLAGS assignments.
> 
> Misc:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Syncronize UAPI headers
> 
>   Mattias Jacobsson:
> 
>   - Remove redundant va_end() in strbuf_addv()
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (10):
>       tools headers x86: Sync disabled-features.h
>       tools headers uapi: Sync prctl.h with the kernel sources
>       tools beauty: Make the prctl option table generator catch all PR_ options
>       tools headers uapi: Update i915_drm.h
>       tools headers uapi: Sync linux/in.h copy from the kernel sources
>       tools headers uapi: Sync linux/kvm.h with the kernel sources
>       tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources
>       tools headers x86: Sync asm/cpufeatures.h copy with the kernel sources
>       perf python: Make sure the python binding output directory is in place
>       perf test shell: Use a fallback to get the pathname in vfs_getname
> 
> Ivan Krylov (1):
>       perf annotate: Pass filename to objdump via execl
> 
> Jin Yao (2):
>       perf stat: Fix endless wait for child process
>       perf report: Fix wrong iteration count in --branch-history
> 
> Jiri Olsa (2):
>       tools thermal tmon: Use -O3 instead of -O1 if available
>       tools iio: Override CFLAGS assignments
> 
> Mattias Jacobsson (1):
>       perf strbuf: Remove redundant va_end() in strbuf_addv()
> 
>  tools/arch/x86/include/asm/cpufeatures.h        |  2 ++
>  tools/arch/x86/include/asm/disabled-features.h  |  8 ++++++-
>  tools/iio/Makefile                              |  2 +-
>  tools/include/uapi/asm-generic/unistd.h         |  4 +++-
>  tools/include/uapi/drm/i915_drm.h               |  8 +++++++
>  tools/include/uapi/linux/in.h                   | 10 +++++---
>  tools/include/uapi/linux/kvm.h                  | 19 +++++++++++++++
>  tools/include/uapi/linux/prctl.h                |  8 +++++++
>  tools/perf/Makefile.perf                        |  4 +++-
>  tools/perf/builtin-stat.c                       |  3 ++-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh |  3 ++-
>  tools/perf/trace/beauty/prctl_option.sh         |  2 +-
>  tools/perf/util/annotate.c                      |  8 +++----
>  tools/perf/util/callchain.c                     | 32 +++++++++++++++----------
>  tools/perf/util/callchain.h                     |  1 +
>  tools/perf/util/machine.c                       |  2 +-
>  tools/perf/util/strbuf.c                        |  1 -
>  tools/thermal/tmon/Makefile                     |  2 +-
>  18 files changed, 90 insertions(+), 29 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
