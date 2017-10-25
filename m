From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/15] perf/core inlining improvements
Date: Wed, 25 Oct 2017 19:10:47 +0200
Message-ID: <20171025171047.hvskdv5t47zhstk6@gmail.com>
References: <20171025160013.11136-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46705 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbdJYRKw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 13:10:52 -0400
Content-Disposition: inline
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, this is Milian's v7 plus some fixes
> acked by Namhyung after some discussion among the three of us, I
> probably need to pick some more patches that are related to this area,
> but lets make some progress and merge this kit,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 9b7c85473cc2fa6fc4a7f87636ff2b69742b82b7:
> 
>   Merge tag 'perf-core-for-mingo-4.15-20171023' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-10-24 10:53:04 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20171025
> 
> for you to fetch changes up to d8a88dd243a170a226aba33e7c53704db2f82aa6:
> 
>   perf util: Enable handling of inlined frames by default (2017-10-25 10:50:47 -0300)
> 
> ----------------------------------------------------------------
> perf/core inline improvements:
> 
> From Milian's cover letter: (Milian Wolff)
> 
> This series of patches completely reworks the way inline frames are
> handled.  Instead of querying for the inline nodes on-demand in the
> individual tools, we now create proper callchain nodes for inlined
> frames. The advantages this approach brings are numerous:
> 
> - Less duplicated code in the individual browser
> 
> - Aggregated cost for inlined frames for the --children top-down list
> 
> - Various bug fixes that arose from querying for a srcline/symbol based on
>   the IP of a sample, which will always point to the last inlined frame
>   instead of the corresponding non-inlined frame
> 
> - Overall much better support for visualizing cost for heavily-inlined C++
>   code, which simply was confusing and unreliable before
> 
> - srcline honors the global setting as to whether full paths or basenames
>   should be shown
> 
> - Caches for inlined frames and srcline information, which allow us to
>   enable inline frame handling by default
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Milian Wolff (15):
>       perf report: Remove code to handle inline frames from browsers
>       perf callchain: Store srcline in callchain_cursor_node
>       perf callchain: Refactor inline_list to operate on symbols
>       perf callchain: Refactor inline_list to store srcline string directly
>       perf callchain: Create real callchain entries for inlined frames
>       perf report: Fall-back to function name comparison for -g srcline
>       perf callchain: Mark inlined frames in output by " (inlined)" suffix
>       perf script: Mark inlined frames and do not print DSO for them
>       perf callchain: Compare symbol name for inlined frames when matching
>       perf report: Compare symbol name for inlined frames when sorting
>       perf report: Properly handle branch count in match_chain()
>       perf report: Cache failed lookups of inlined frames
>       perf report: Cache srclines for callchain nodes
>       perf report: Use srcline from callchain for hist entries
>       perf util: Enable handling of inlined frames by default
> 
>  tools/perf/Documentation/perf-report.txt |   3 +-
>  tools/perf/Documentation/perf-script.txt |   3 +-
>  tools/perf/ui/browsers/hists.c           | 180 ++-------------------
>  tools/perf/ui/stdio/hist.c               |  77 +--------
>  tools/perf/util/callchain.c              | 174 +++++++++++---------
>  tools/perf/util/callchain.h              |   6 +-
>  tools/perf/util/dso.c                    |   7 +
>  tools/perf/util/dso.h                    |   2 +
>  tools/perf/util/event.c                  |   1 +
>  tools/perf/util/evsel_fprintf.c          |  37 +----
>  tools/perf/util/hist.c                   |   7 +-
>  tools/perf/util/machine.c                |  65 +++++++-
>  tools/perf/util/sort.c                   |   6 +
>  tools/perf/util/sort.h                   |   1 -
>  tools/perf/util/srcline.c                | 268 +++++++++++++++++++++++++------
>  tools/perf/util/srcline.h                |  26 ++-
>  tools/perf/util/symbol.c                 |   1 +
>  tools/perf/util/symbol.h                 |   2 +
>  18 files changed, 443 insertions(+), 423 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
