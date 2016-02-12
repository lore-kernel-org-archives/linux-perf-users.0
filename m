From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCH] perf hists: Do column alignment on the format
 iterator
Date: Fri, 12 Feb 2016 13:56:22 +0100
Message-ID: <20160212125622.GB16190@krava.redhat.com>
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

SNIP

>  		int column = 0;
>  
>  		hist_browser__gotorc(browser, row, 0);
>  
>  		hists__for_each_format(browser->hists, fmt) {
> +			struct perf_hpp hpp = {
> +				.buf	= s,
> +				.size	= sizeof(s),
> +				.ptr	= &arg,
> +			};
> +
>  			if (perf_hpp__should_skip(fmt, entry->hists) ||
>  			    column++ < browser->b.horiz_scroll)
>  				continue;
> @@ -1122,8 +1123,9 @@ static int hist_browser__show_entry(struct hist_browser *browser,
>  			if (fmt->color) {
>  				width -= fmt->color(fmt, &hpp, entry);
>  			} else {
> -				width -= fmt->entry(fmt, &hpp, entry);
> +				hist_entry__snprintf_alignment(entry, &hpp, fmt, fmt->entry(fmt, &hpp, entry));
>  				ui_browser__printf(&browser->b, "%s", s);
> +				width -= hpp.buf - s;

how's the 'color' case handled?

jirka
