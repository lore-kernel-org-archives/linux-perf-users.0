From: Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Thu, 19 Mar 2015 17:34:13 -0700
Message-ID: <CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com>
References: <20150319225858.GA16485@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:32963 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbbCTAeO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 Mar 2015 20:34:14 -0400
Received: by obcxo2 with SMTP id xo2so67427717obc.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2015 17:34:14 -0700 (PDT)
In-Reply-To: <20150319225858.GA16485@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Thu, Mar 19, 2015 at 3:58 PM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi Stephane,
>
>         This patch, together with what is in my perf/core branch, should
> implement that feature we talked about recently, i.e. to allow
> annotating entries in callchains, please take a look at see if you think
> it is ok,
>
I tried on tip.git and a simple example. It does what I wanted.
I will try on more complex test cases.
Thanks for implementing this quickly.

>
> - Arnaldo
>
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Subject: [PATCH 1/1] perf hists browser: Indicate which callchain entries are annotated
>
> Now that we can annotate entries in a callchain, show which ones have an
> associated symbol and samples, by adding a right arrow just before the
> symbol name when in verbose mode.
>
> To toggle verbose mode press 'V'.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Don Zickus <dzickus@redhat.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/n/tip-d2rf1p3h5gdp7hdl2gf2bozl@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/ui/browsers/hists.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index cd7350aeb8e7..995b7a8596b1 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -511,6 +511,7 @@ static void hist_browser__show_callchain_entry(struct hist_browser *browser,
>  {
>         int color, width;
>         char folded_sign = callchain_list__folded(chain);
> +       bool show_annotated = browser->show_dso && chain->ms.sym && symbol__annotation(chain->ms.sym)->src;
>
>         color = HE_COLORSET_NORMAL;
>         width = browser->b.width - (offset + 2);
> @@ -523,7 +524,8 @@ static void hist_browser__show_callchain_entry(struct hist_browser *browser,
>         ui_browser__set_color(&browser->b, color);
>         hist_browser__gotorc(browser, row, 0);
>         slsmg_write_nstring(" ", offset);
> -       slsmg_printf("%c ", folded_sign);
> +       slsmg_printf("%c", folded_sign);
> +       ui_browser__write_graph(&browser->b, show_annotated ? SLSMG_RARROW_CHAR : ' ');
>         slsmg_write_nstring(str, width);
>  }
>
> --
> 1.9.3
>
