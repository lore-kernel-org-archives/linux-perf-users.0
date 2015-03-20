From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Fri, 20 Mar 2015 14:21:15 -0300
Message-ID: <64EFCD56-C036-4236-B338-3947B99DA862@gmail.com>
References: <20150319225858.GA16485@kernel.org> <CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com> <CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com> <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
Reply-To: acme@kernel.org
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33480 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbCTRW0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Mar 2015 13:22:26 -0400
In-Reply-To: <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>



On March 20, 2015 2:15:53 PM GMT-03:00, Stephane Eranian <eranian@google.com> wrote:
>> Thanks for testing, please let us know if you have further
>suggestions,
>>
>Ok, it does not work.
>I think it works as long as the caller you want to annotate is in the
>same module.
>But suppose, I am on malloc() (libc) and I want to see a caller of
>malloc(), it will
>propose 'annotate bar()', but will still show me the code of
>libc:malloc.
>
>In my earlier test, everything worked because the callee and caller
>were in the
>same module.
>
>Could you fix this?

I'll try.


>
>
>> - Arnaldo
>>
>> Sent from smartphone
>>
>>
>>>
>>> >
>>> > - Arnaldo
>>> >
>>> >
>>> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> > Subject: [PATCH 1/1] perf hists browser: Indicate which callchain
>>> > entries are annotated
>>> >
>>> > Now that we can annotate entries in a callchain, show which ones
>have an
>>> > associated symbol and samples, by adding a right arrow just before
>the
>>> > symbol name when in verbose mode.
>>> >
>>> > To toggle verbose mode press 'V'.
>>> >
>>> > Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> > Cc: Borislav Petkov <bp@suse.de>
>>> > Cc: David Ahern <dsahern@gmail.com>
>>> > Cc: Don Zickus <dzickus@redhat.com>
>>> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
>>> > Cc: Jiri Olsa <jolsa@redhat.com>
>>> > Cc: Mike Galbraith <efault@gmx.de>
>>> > Cc: Namhyung Kim <namhyung@kernel.org>
>>> > Cc: Peter Zijlstra <peterz@infradead.org>
>>> > Cc: Stephane Eranian <eranian@google.com>
>>> > Link:
>>> >
>http://lkml.kernel.org/n/tip-d2rf1p3h5gdp7hdl2gf2bozl@git.kernel.org
>>> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> > ---
>>> >  tools/perf/ui/browsers/hists.c | 4 +++-
>>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>>> >
>>> > diff --git a/tools/perf/ui/browsers/hists.c
>>> > b/tools/perf/ui/browsers/hists.c
>>> > index cd7350aeb8e7..995b7a8596b1 100644
>>> > --- a/tools/perf/ui/browsers/hists.c
>>> > +++ b/tools/perf/ui/browsers/hists.c
>>> > @@ -511,6 +511,7 @@ static void
>>> > hist_browser__show_callchain_entry(struct hist_browser *browser,
>>> >  {
>>> >         int color, width;
>>> >         char folded_sign = callchain_list__folded(chain);
>>> > +       bool show_annotated = browser->show_dso && chain->ms.sym
>&&
>>> > symbol__annotation(chain->ms.sym)->src;
>>> >
>>> >         color = HE_COLORSET_NORMAL;
>>> >         width = browser->b.width - (offset + 2);
>>> > @@ -523,7 +524,8 @@ static void
>>> > hist_browser__show_callchain_entry(struct hist_browser *browser,
>>> >         ui_browser__set_color(&browser->b, color);
>>> >         hist_browser__gotorc(browser, row, 0);
>>> >         slsmg_write_nstring(" ", offset);
>>> > -       slsmg_printf("%c ", folded_sign);
>>> > +       slsmg_printf("%c", folded_sign);
>>> > +       ui_browser__write_graph(&browser->b, show_annotated ?
>>> > SLSMG_RARROW_CHAR : ' ');
>>> >         slsmg_write_nstring(str, width);
>>> >  }
>>> >
>>> > --
>>> > 1.9.3
>>> >

-- Arnaldo

Sent from smartphone.
