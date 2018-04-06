From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
Date: Fri, 6 Apr 2018 14:41:01 +0200
Message-ID: <20180406124101.paxuoeueyycas5lw@gmail.com>
References: <20180406112439.21685-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180406112439.21685-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, Namhyung Kim <namhyung@kernel.org>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Wang Nan <wangnan0@huawei.com>
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
> The following changes since commit d1e7e602cd64cf61f87dbf30df07c24df9eb1d99:
> 
>   perf/x86/intel: Move regs->flags EXACT bit init (2018-04-05 09:28:40 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.17-20180406
> 
> for you to fetch changes up to 01f97511f13cbf2ba3d23b2bffa06258dc81e283:
> 
>   tools headers uapi: Synchronize i915_drm.h (2018-04-05 14:48:51 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Show group details on the title line in the annotate browser
>   and 'perf annotate --stdio2' output, so that the per-event
>   columns can have headers (Arnaldo Carvalho de Melo)
> 
> - Fixup vertical line separating metrics from instructions and
>   cleaning unused lines at the bottom, both in the annotate TUI
>   browser (Arnaldo Carvalho de Melo)
> 
> - Remove duplicated 'samples' in lost samples warning in
>   'perf report' (Arnaldo Carvalho de Melo)
> 
> - Synchronize i915_drm.h, silencing the perf build process,
>   automagically adding support for the new DRM_I915_QUERY
>   ioctl (Arnaldo Carvalho de Melo)
> 
> - Make auxtrace_queues__add_buffer() allocate struct buffer,
>   from a patchkit already applied (Adrian Hunter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf auxtrace: Make auxtrace_queues__add_buffer() allocate struct buffer
> 
> Arnaldo Carvalho de Melo (5):
>       perf annotate: Show group details on the title line
>       perf annotate browser: Fixup vertical line separating metrics from instructions
>       perf ui browser: Fixup cleaning unused lines at the bottom
>       perf report: Remove duplicated 'samples' in lost samples warning
>       tools headers uapi: Synchronize i915_drm.h
> 
>  tools/include/uapi/drm/i915_drm.h | 112 ++++++++++++++++++++++++++++++++++++--
>  tools/perf/ui/browser.c           |   4 +-
>  tools/perf/ui/browsers/annotate.c |   2 +-
>  tools/perf/util/annotate.c        |   7 ++-
>  tools/perf/util/auxtrace.c        |  54 ++++++++----------
>  tools/perf/util/session.c         |   2 +-
>  6 files changed, 141 insertions(+), 40 deletions(-)

Pulled, thanks a lot Arnaldo!

Thanks,

	Ingo
