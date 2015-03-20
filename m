From: Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Fri, 20 Mar 2015 10:15:53 -0700
Message-ID: <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
References: <20150319225858.GA16485@kernel.org>
	<CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com>
	<CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hi,

On Thu, Mar 19, 2015 at 5:39 PM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> On Mar 19, 2015 9:34 PM, "Stephane Eranian" <eranian@google.com> wrote:
>>
>> Hi Arnaldo,
>>
>> On Thu, Mar 19, 2015 at 3:58 PM, Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>> >
>> > Hi Stephane,
>> >
>> >         This patch, together with what is in my perf/core branch, should
>> > implement that feature we talked about recently, i.e. to allow
>> > annotating entries in callchains, please take a look at see if you think
>> > it is ok,
>> >
>> I tried on tip.git and a simple example. It does what I wanted.
>> I will try on more complex test cases.
>> Thanks for implementing this quickly.
>
> Thanks for testing, please let us know if you have further suggestions,
>
Ok, it does not work.
I think it works as long as the caller you want to annotate is in the
same module.
But suppose, I am on malloc() (libc) and I want to see a caller of
malloc(), it will
propose 'annotate bar()', but will still show me the code of libc:malloc.

In my earlier test, everything worked because the callee and caller were in the
same module.

Could you fix this?


> - Arnaldo
>
> Sent from smartphone
>
>
>>
>> >
>> > - Arnaldo
>> >
>> >
>> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
>> > Subject: [PATCH 1/1] perf hists browser: Indicate which callchain
>> > entries are annotated
>> >
>> > Now that we can annotate entries in a callchain, show which ones have an
>> > associated symbol and samples, by adding a right arrow just before the
>> > symbol name when in verbose mode.
>> >
>> > To toggle verbose mode press 'V'.
>> >
>> > Cc: Adrian Hunter <adrian.hunter@intel.com>
>> > Cc: Borislav Petkov <bp@suse.de>
>> > Cc: David Ahern <dsahern@gmail.com>
>> > Cc: Don Zickus <dzickus@redhat.com>
>> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> > Cc: Jiri Olsa <jolsa@redhat.com>
>> > Cc: Mike Galbraith <efault@gmx.de>
>> > Cc: Namhyung Kim <namhyung@kernel.org>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Stephane Eranian <eranian@google.com>
>> > Link:
>> > http://lkml.kernel.org/n/tip-d2rf1p3h5gdp7hdl2gf2bozl@git.kernel.org
>> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> > ---
>> >  tools/perf/ui/browsers/hists.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/tools/perf/ui/browsers/hists.c
>> > b/tools/perf/ui/browsers/hists.c
>> > index cd7350aeb8e7..995b7a8596b1 100644
>> > --- a/tools/perf/ui/browsers/hists.c
>> > +++ b/tools/perf/ui/browsers/hists.c
>> > @@ -511,6 +511,7 @@ static void
>> > hist_browser__show_callchain_entry(struct hist_browser *browser,
>> >  {
>> >         int color, width;
>> >         char folded_sign = callchain_list__folded(chain);
>> > +       bool show_annotated = browser->show_dso && chain->ms.sym &&
>> > symbol__annotation(chain->ms.sym)->src;
>> >
>> >         color = HE_COLORSET_NORMAL;
>> >         width = browser->b.width - (offset + 2);
>> > @@ -523,7 +524,8 @@ static void
>> > hist_browser__show_callchain_entry(struct hist_browser *browser,
>> >         ui_browser__set_color(&browser->b, color);
>> >         hist_browser__gotorc(browser, row, 0);
>> >         slsmg_write_nstring(" ", offset);
>> > -       slsmg_printf("%c ", folded_sign);
>> > +       slsmg_printf("%c", folded_sign);
>> > +       ui_browser__write_graph(&browser->b, show_annotated ?
>> > SLSMG_RARROW_CHAR : ' ');
>> >         slsmg_write_nstring(str, width);
>> >  }
>> >
>> > --
>> > 1.9.3
>> >
