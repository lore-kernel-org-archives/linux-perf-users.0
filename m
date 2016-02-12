From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH] perf hists: Do column alignment on the format
 iterator
Date: Fri, 12 Feb 2016 10:26:37 -0300
Message-ID: <20160212132637.GL32168@kernel.org>
References: <20160211202718.GD32168@kernel.org>
 <20160212125622.GB16190@krava.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33523 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbcBLN0l (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 12 Feb 2016 08:26:41 -0500
Content-Disposition: inline
In-Reply-To: <20160212125622.GB16190@krava.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Em Fri, Feb 12, 2016 at 01:56:22PM +0100, Jiri Olsa escreveu:
> On Thu, Feb 11, 2016 at 05:27:18PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> >  		int column = 0;
> >  
> >  		hist_browser__gotorc(browser, row, 0);
> >  
> >  		hists__for_each_format(browser->hists, fmt) {
> > +			struct perf_hpp hpp = {
> > +				.buf	= s,
> > +				.size	= sizeof(s),
> > +				.ptr	= &arg,
> > +			};
> > +
> >  			if (perf_hpp__should_skip(fmt, entry->hists) ||
> >  			    column++ < browser->b.horiz_scroll)
> >  				continue;
> > @@ -1122,8 +1123,9 @@ static int hist_browser__show_entry(struct hist_browser *browser,
> >  			if (fmt->color) {
> >  				width -= fmt->color(fmt, &hpp, entry);
> >  			} else {
> > -				width -= fmt->entry(fmt, &hpp, entry);
> > +				hist_entry__snprintf_alignment(entry, &hpp, fmt, fmt->entry(fmt, &hpp, entry));
> >  				ui_browser__printf(&browser->b, "%s", s);
> > +				width -= hpp.buf - s;
> 
> how's the 'color' case handled?

Right, I'll move it to after the branch.

- Arnaldo
