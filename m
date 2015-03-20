From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Fri, 20 Mar 2015 17:39:22 -0300
Message-ID: <20150320203922.GO16485@kernel.org>
References: <20150319225858.GA16485@kernel.org>
 <CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com>
 <CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com>
 <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41962 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbbCTUj1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Mar 2015 16:39:27 -0400
Content-Disposition: inline
In-Reply-To: <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>

Em Fri, Mar 20, 2015 at 10:15:53AM -0700, Stephane Eranian escreveu:
> Hi,
> 
> On Thu, Mar 19, 2015 at 5:39 PM, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > On Mar 19, 2015 9:34 PM, "Stephane Eranian" <eranian@google.com> wrote:
> >>
> >> Hi Arnaldo,
> >>
> >> On Thu, Mar 19, 2015 at 3:58 PM, Arnaldo Carvalho de Melo
> >> <acme@kernel.org> wrote:
> >> >
> >> > Hi Stephane,
> >> >
> >> >         This patch, together with what is in my perf/core branch, should
> >> > implement that feature we talked about recently, i.e. to allow
> >> > annotating entries in callchains, please take a look at see if you think
> >> > it is ok,
> >> >
> >> I tried on tip.git and a simple example. It does what I wanted.
> >> I will try on more complex test cases.
> >> Thanks for implementing this quickly.
> >
> > Thanks for testing, please let us know if you have further suggestions,
> >
> Ok, it does not work.
> I think it works as long as the caller you want to annotate is in the
> same module.
> But suppose, I am on malloc() (libc) and I want to see a caller of
> malloc(), it will
> propose 'annotate bar()', but will still show me the code of libc:malloc.
> 
> In my earlier test, everything worked because the callee and caller were in the
> same module.
> 
> Could you fix this?

I thought that was covered because it deals with a "map_symbol" struct,
where it finds both the symbol and the DSO where it came from, etc.

Checking that now...


- Arnaldo
