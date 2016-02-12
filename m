From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCH] perf hists: Do column alignment on the format
 iterator
Date: Fri, 12 Feb 2016 13:57:56 +0100
Message-ID: <20160212125756.GC16190@krava.redhat.com>
References: <20160211202718.GD32168@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160211202718.GD32168@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 11, 2016 at 05:27:18PM -0300, Arnaldo Carvalho de Melo wrote:
> We were doing column alignment in the format function for each cell,
> returning a string padded with spaces so that when the next column is
> printed the cursor is at its column alignment.
> 
> This ends up needlessly printing trailing spaces, do it at the format
> iterator, that is where we know if it is needed, i.e. if there is more
> columns to be printed.
> 
> This eliminates the need for triming lines when doing a dump using 'P'
> in the TUI browser and also produces far saner results with things like
> piping 'perf report' to 'less'.
> 
> Right now only the formatters for sym->name and the 'locked' column
> (perf mem report), that are the ones that end up at the end of lines
> in the default 'perf report', 'perf top' and 'perf mem report' tools,
> the others will be done in a subsequent patch.
> 
> In the end the 'width' parameter for the formatters now mean, in
> 'printf' terms, the 'precision', where before it was the field 'width'.
> 
> Reported-by: Dave Jones <davej@codemonkey.org.uk>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: http://lkml.kernel.org/n/tip-s7iwl2gj23w92l6tibnrcqzr@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/ui/browsers/hists.c | 17 ++++++++++-------
>  tools/perf/ui/stdio/hist.c     |  1 +
>  tools/perf/util/hist.c         | 21 +++++++++++++++++++++
>  tools/perf/util/hist.h         |  5 +++++
>  tools/perf/util/sort.c         | 13 +++----------
>  5 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index a5a5390476ac..af608d5da17d 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -1086,16 +1086,17 @@ static int hist_browser__show_entry(struct hist_browser *browser,
>  			.folded_sign	= folded_sign,
>  			.current_entry	= current_entry,
>  		};
> -		struct perf_hpp hpp = {
> -			.buf		= s,
> -			.size		= sizeof(s),
> -			.ptr		= &arg,
> -		};

if you're moving this, you can move the 's' buffer as well

jirka
