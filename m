From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Date: Wed, 21 Nov 2018 15:58:28 +0100
Message-ID: <20181121145828.GA112176@gmail.com>
References: <20181121142505.27379-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181121142505.27379-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adam Lee <leeadamrobert@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, David Ahern <dsahern@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>, Namhyung Kim <namhyung@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Yongxin Liu <yongxin.liu@outlook.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, more to come as I process the backlog
> from being away for LPC.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 4d47d6407ac7b4b442a4e717488a3bb137398b6c:
> 
>   perf/x86/intel/uncore: Support CoffeeLake 8th CBOX (2018-11-12 05:03:26 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.20-20181121
> 
> for you to fetch changes up to a4243e1494532ab8fa679a4134153149a71fa331:
> 
>   perf tools beauty ioctl: Support new ISO7816 commands (2018-11-19 12:38:50 -0800)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Update kernel ABI headers, one of them lead to a small change in
>   the ioctl 'cmd' beautifier in 'perf trace' to support the new ISO7816
>   commands. (Arnaldo Carvalho de Melo)
> 
> - Restore proper cwd on return from mnt namespace (Jiri Olsa)
> 
> - Add feature check for the get_current_dir_name() function used in the
>   namespace fix from Jiri, that is not available in systems such as
>   Alpine Linux, which uses the  musl libc (Arnaldo Carvalho de Melo)
> 
> - Fix crash in 'perf record' when synthesizing the unit for events such
>   as 'cpu-clock' (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       tools build feature: Check if get_current_dir_name() is available
>       tools headers uapi: Synchronize i915_drm.h
>       tools arch x86: Update tools's copy of cpufeatures.h
>       tools uapi asm-generic: Synchronize ioctls.h
>       perf tools beauty ioctl: Support new ISO7816 commands
> 
> Jiri Olsa (2):
>       perf tools: Fix crash on synthesizing the unit
>       perf tools: Restore proper cwd on return from mnt namespace
> 
>  tools/arch/x86/include/asm/cpufeatures.h        |  2 ++
>  tools/build/Makefile.feature                    |  1 +
>  tools/build/feature/Makefile                    |  4 ++++
>  tools/build/feature/test-all.c                  |  5 +++++
>  tools/build/feature/test-get_current_dir_name.c | 10 ++++++++++
>  tools/include/uapi/asm-generic/ioctls.h         |  2 ++
>  tools/include/uapi/drm/i915_drm.h               | 22 ++++++++++++++++++++++
>  tools/perf/Makefile.config                      |  5 +++++
>  tools/perf/tests/attr/base-record               |  2 +-
>  tools/perf/trace/beauty/ioctl.c                 |  1 +
>  tools/perf/util/Build                           |  1 +
>  tools/perf/util/evsel.c                         |  2 +-
>  tools/perf/util/get_current_dir_name.c          | 18 ++++++++++++++++++
>  tools/perf/util/namespaces.c                    | 17 +++++++++++++++--
>  tools/perf/util/namespaces.h                    |  1 +
>  tools/perf/util/util.h                          |  4 ++++
>  16 files changed, 93 insertions(+), 4 deletions(-)
>  create mode 100644 tools/build/feature/test-get_current_dir_name.c
>  create mode 100644 tools/perf/util/get_current_dir_name.c

Pulled, thanks a lot Arnaldo!

	Ingo
