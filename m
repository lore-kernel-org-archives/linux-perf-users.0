From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 06/12] perf report/top: Add 'k' hotkey to zoom directly
 into the kernel map
Date: Fri, 20 Dec 2019 15:48:23 +0900
Message-ID: <CAM9d7ciL-Qnm5v3Tn1rsrNzW3mTWx5HY6W5XBU1MKnLQ7YBdkw@mail.gmail.com>
References: <20191217144828.2460-1-acme@kernel.org> <20191217144828.2460-7-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217144828.2460-7-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

On Tue, Dec 17, 2019 at 11:49 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> As a convenience, equivalent to pressing Enter in a line with a kernel
> symbol and then selecting "Zoom" into the kernel DSO.

We already have 'd' key for 'zoom into current dso'.
Do you really want 'k' for kernel specially?

>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-vbnlnrpyfvz9deqoobtc3dz7@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/ui/browsers/hists.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 8aba1aeea0eb..6dfdd8d5a743 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -18,7 +18,9 @@
>  #include "../../util/evlist.h"
>  #include "../../util/header.h"
>  #include "../../util/hist.h"
> +#include "../../util/machine.h"
>  #include "../../util/map.h"
> +#include "../../util/maps.h"
>  #include "../../util/symbol.h"
>  #include "../../util/map_symbol.h"
>  #include "../../util/branch.h"
> @@ -2566,7 +2568,7 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
>         if (!hists__has(browser->hists, dso) || map == NULL)
>                 return 0;
>
> -       if (asprintf(optstr, "Zoom %s %s DSO",
> +       if (asprintf(optstr, "Zoom %s %s DSO (use the 'k' hotkey to zoom directly into the kernel)",

Wouldn't it be better suggesting 'd' key instead?

Thanks
Namhyung


>                      browser->hists->dso_filter ? "out of" : "into",
>                      __map__is_kernel(map) ? "the Kernel" : map->dso->short_name) < 0)
>                 return 0;
> @@ -2936,6 +2938,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>         "E             Expand all callchains\n"                         \
>         "F             Toggle percentage of filtered entries\n"         \
>         "H             Display column headers\n"                        \
> +       "k             Zoom into the kernel map\n"                      \
>         "L             Change percent limit\n"                          \
>         "m             Display context menu\n"                          \
>         "S             Zoom into current Processor Socket\n"            \
> @@ -3033,6 +3036,10 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>                         actions->ms.map = map;
>                         do_zoom_dso(browser, actions);
>                         continue;
> +               case 'k':
> +                       if (browser->selection != NULL)
> +                               hists_browser__zoom_map(browser, browser->selection->maps->machine->vmlinux_map);
> +                       continue;
>                 case 'V':
>                         verbose = (verbose + 1) % 4;
>                         browser->show_dso = verbose > 0;
> --
> 2.21.0
>
