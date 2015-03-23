From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Mon, 23 Mar 2015 09:27:08 +0900
Message-ID: <20150323002708.GB2782@sejong>
References: <20150319225858.GA16485@kernel.org>
 <CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com>
 <CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com>
 <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
 <20150320203922.GO16485@kernel.org>
 <20150320210709.GQ16485@kernel.org>
 <CABPqkBRjHMOzNL=vWqzTUNA_8FidDk=THBErj4c6Tj=6Yw+0hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo02.lge.com ([156.147.1.126]:36786 "EHLO
	lgeamrelo02.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbbCWAd4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 22 Mar 2015 20:33:56 -0400
Content-Disposition: inline
In-Reply-To: <CABPqkBRjHMOzNL=vWqzTUNA_8FidDk=THBErj4c6Tj=6Yw+0hg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Ingo Molnar <mingo@kernel.org>

Hi Stephane,

On Fri, Mar 20, 2015 at 02:12:30PM -0700, Stephane Eranian wrote:
> On Fri, Mar 20, 2015 at 2:07 PM, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > Em Fri, Mar 20, 2015 at 05:39:22PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Fri, Mar 20, 2015 at 10:15:53AM -0700, Stephane Eranian escreveu:
> >> > On Thu, Mar 19, 2015 at 5:39 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >> > > On Mar 19, 2015 9:34 PM, "Stephane Eranian" <eranian@google.com> wrote:
> >> > >> On Thu, Mar 19, 2015 at 3:58 PM, Arnaldo Carvalho de Melo
> >> > >> <acme@kernel.org> wrote:
> >> > >> >         This patch, together with what is in my perf/core branch, should
> >> > >> > implement that feature we talked about recently, i.e. to allow
> >> > >> > annotating entries in callchains, please take a look at see if you think
> >> > >> > it is ok,
> >
> >> > >> I tried on tip.git and a simple example. It does what I wanted.
> >> > >> I will try on more complex test cases.
> >> > >> Thanks for implementing this quickly.
> >
> >> > > Thanks for testing, please let us know if you have further suggestions,
> >
> >> > Ok, it does not work.
> >
> > Are you sure? I just tried, take a look at:
> >
> > http://vger.kernel.org/~acme/perf-report-annotate-callchain-entries-in-multiple-DSOs-in-the-same-hist_entry.png
> >
> > In there you will see that in the unmap_single_vma case there are
> > callchains that pass thru multiple DSOs in userspace (I used --call
> > dwarf in 'perf record') and those are marked as having
> > samples/annotation and when I go to those, pressing 'a' after moving the
> > cursor to it and it works as expected...
> >
> > Do you have some specific example I could try?
> >
> I tried on an example I cannot share.
> But I am guessing you could reproduce with a test which calls a libc
> or libm function
> heavily form multiple callers in the main program.
> Example:
>        -  pow()
>            50% foo() [main.c]
>            50% bar() [main.c]
> 
> If I move the cursor line to foo() and annotate foo() is shows me the
> code of pow().

Did you play with acme/perf/core not tip/perf/core?  I got same
problem but then I realize it's not the Arnaldo's tree.  When I
changed to acme/perf/core the problem disappeared. :)

But unfortunately I got this segfault instead..

  namhyung@sejong:perf$ perf report
  perf: Segmentation fault
  -------- backtrace --------
  perf[0x506e5b]
  /usr/lib/libc.so.6(+0x33540)[0x7fa3eb90a540]
  perf[0x47b39c]
  perf(disasm_line__free+0x58)[0x47c178]
  perf(symbol__tui_annotate+0x2f3)[0x4fe683]
  perf[0x503773]
  perf(perf_evlist__tui_browse_hists+0x94)[0x505b44]
  perf(cmd_report+0x18f0)[0x436890]
  perf[0x47a793]
  perf(main+0x60a)[0x427c7a]
  /usr/lib/libc.so.6(__libc_start_main+0xf0)[0x7fa3eb8f7800]
  perf(_start+0x29)[0x427d99]
  [0x0]

  namhyung@sejong:perf$ addr2line -e `which perf` 0x506e5b
  /home/namhyung/project/linux/tools/perf/ui/tui/setup.c:106
  namhyung@sejong:perf$ addr2line -e `which perf` 0x47b39c
  /home/namhyung/project/linux/tools/perf/util/annotate.c:33

Thanks,
Namhyung
