From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/9] perf/urgent fixes
Date: Wed, 13 Sep 2017 09:26:01 +0200
Message-ID: <20170913072601.k6v4wdfhz6mhjvce@gmail.com>
References: <20170912192438.1334-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38658 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdIMH0F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2017 03:26:05 -0400
Content-Disposition: inline
In-Reply-To: <20170912192438.1334-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	So here it is the fixes in perf-core-for-mingo-4.14-20170912, as
> requested, plus one last minute fix from Milian Wolff that helps with
> using perf as an AppImage[1].
> 
> - Arnaldo
> 
> [1] http://appimage.org/
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 770e96125515daf1c7bc179323f2e0d488dfe6ac:
> 
>   Merge tag 'perf-core-for-mingo-4.14-20170901' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-09-05 07:14:28 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.14-20170912
> 
> for you to fetch changes up to dfc9eec7716cc0a9f7eb743c703d74cd2d6085a0:
> 
>   perf stat: Wait for the correct child (2017-09-12 12:49:13 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix TUI progress bar when delta from new total from that of the
>   previous update is greater than the progress "step" (screen width
>   progress bar block))  (Jiri Olsa)
> 
> - Make tools/lib/api make DEBUG=1 build use -D_FORTIFY_SOURCE=2 not
>   to cripple debuginfo, just like tools/perf/ does (Jiri Olsa)
> 
> - Avoid leaking the 'perf.data' file to workloads started from the
>   'perf record' command line by using the O_CLOEXEC open flag (Jiri Olsa)
> 
> - Fix building when libunwind's 'unwind.h' file is present in the
>   include path, clashing with tools/perf/util/unwind.h (Milian Wolff)
> 
> - Check per .perfconfig section entry flag, not just per section (Taeung Song)
> 
> - Support running perf binaries with a dash in their name, needed to
>   run perf as an AppImage (Milian Wolff)
> 
> - Wait for the right child by using waitpid() when running workloads
>   from 'perf stat', also to fix using perf as an AppImage (Milian Wolff)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       tools include linux: Guard against redefinition of some macros
> 
> Jiri Olsa (4):
>       tools lib api: Fix make DEBUG=1 build
>       perf tools: Open perf.data with O_CLOEXEC flag
>       perf ui progress: Make sure we always define step value
>       perf ui progress: Fix progress update
> 
> Milian Wolff (3):
>       perf tests: Fix compile when libunwind's unwind.h is available
>       perf tools: Support running perf binaries with a dash in their name
>       perf stat: Wait for the correct child
> 
> Taeung Song (1):
>       perf config: Check not only section->from_system_config but also item's
> 
>  tools/include/linux/compiler-gcc.h |  9 ++++++---
>  tools/lib/api/Makefile             |  8 +++++++-
>  tools/perf/builtin-config.c        |  2 +-
>  tools/perf/builtin-stat.c          |  2 +-
>  tools/perf/perf.c                  | 14 ++++++++++----
>  tools/perf/tests/dwarf-unwind.c    |  2 +-
>  tools/perf/ui/progress.c           |  9 +++++++--
>  tools/perf/util/data.c             | 13 ++++++++++++-
>  8 files changed, 45 insertions(+), 14 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
