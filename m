From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH] perf hists: Do column alignment on the format
 iterator
Date: Fri, 12 Feb 2016 12:50:22 -0300
Message-ID: <20160212155022.GA2916@kernel.org>
References: <20160211202718.GD32168@kernel.org>
 <20160212125622.GB16190@krava.redhat.com>
 <20160212132637.GL32168@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160212132637.GL32168@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Feb 12, 2016 at 10:26:37AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 12, 2016 at 01:56:22PM +0100, Jiri Olsa escreveu:
> > On Thu, Feb 11, 2016 at 05:27:18PM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > SNIP
> > 
> > >  		int column = 0;
> > >  
> > >  		hist_browser__gotorc(browser, row, 0);
> > >  
> > >  		hists__for_each_format(browser->hists, fmt) {
> > > +			struct perf_hpp hpp = {
> > > +				.buf	= s,
> > > +				.size	= sizeof(s),
> > > +				.ptr	= &arg,
> > > +			};
> > > +
> > >  			if (perf_hpp__should_skip(fmt, entry->hists) ||
> > >  			    column++ < browser->b.horiz_scroll)
> > >  				continue;
> > > @@ -1122,8 +1123,9 @@ static int hist_browser__show_entry(struct hist_browser *browser,
> > >  			if (fmt->color) {
> > >  				width -= fmt->color(fmt, &hpp, entry);
> > >  			} else {
> > > -				width -= fmt->entry(fmt, &hpp, entry);
> > > +				hist_entry__snprintf_alignment(entry, &hpp, fmt, fmt->entry(fmt, &hpp, entry));
> > >  				ui_browser__printf(&browser->b, "%s", s);
> > > +				width -= hpp.buf - s;
> > 
> > how's the 'color' case handled?
> 
> Right, I'll move it to after the branch.

A bit more involved, since fmt->color() does the ui_browser__ calls, as
it involves setting up ui_browser color related calls, etc, so I have
this on top, testing now:

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index af608d5da17d..1819771243f9 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1061,7 +1061,6 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 				    struct hist_entry *entry,
 				    unsigned short row)
 {
-	char s[256];
 	int printed = 0;
 	int width = browser->b.width;
 	char folded_sign = ' ';
@@ -1091,6 +1090,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 		hist_browser__gotorc(browser, row, 0);
 
 		hists__for_each_format(browser->hists, fmt) {
+			char s[2048];
 			struct perf_hpp hpp = {
 				.buf	= s,
 				.size	= sizeof(s),
@@ -1121,12 +1121,18 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 			}
 
 			if (fmt->color) {
-				width -= fmt->color(fmt, &hpp, entry);
+				int ret = fmt->color(fmt, &hpp, entry);
+				hist_entry__snprintf_alignment(entry, &hpp, fmt, ret);
+				/*
+				 * fmt->color() already used ui_browser to
+				 * print the non alignment bits, skip it (+ret):
+				 */
+				ui_browser__printf(&browser->b, "%s", s + ret);
 			} else {
 				hist_entry__snprintf_alignment(entry, &hpp, fmt, fmt->entry(fmt, &hpp, entry));
 				ui_browser__printf(&browser->b, "%s", s);
-				width -= hpp.buf - s;
 			}
+			width -= hpp.buf - s;
 		}
 
 		/* The scroll bar isn't being used */
