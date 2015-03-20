From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Fri, 20 Mar 2015 18:07:09 -0300
Message-ID: <20150320210709.GQ16485@kernel.org>
References: <20150319225858.GA16485@kernel.org>
 <CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com>
 <CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com>
 <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
 <20150320203922.GO16485@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150320203922.GO16485@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephane Eranian <eranian@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 20, 2015 at 05:39:22PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 20, 2015 at 10:15:53AM -0700, Stephane Eranian escreveu:
> > On Thu, Mar 19, 2015 at 5:39 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > On Mar 19, 2015 9:34 PM, "Stephane Eranian" <eranian@google.com> wrote:
> > >> On Thu, Mar 19, 2015 at 3:58 PM, Arnaldo Carvalho de Melo
> > >> <acme@kernel.org> wrote:
> > >> >         This patch, together with what is in my perf/core branch, should
> > >> > implement that feature we talked about recently, i.e. to allow
> > >> > annotating entries in callchains, please take a look at see if you think
> > >> > it is ok,

> > >> I tried on tip.git and a simple example. It does what I wanted.
> > >> I will try on more complex test cases.
> > >> Thanks for implementing this quickly.

> > > Thanks for testing, please let us know if you have further suggestions,

> > Ok, it does not work.

Are you sure? I just tried, take a look at:

http://vger.kernel.org/~acme/perf-report-annotate-callchain-entries-in-multiple-DSOs-in-the-same-hist_entry.png

In there you will see that in the unmap_single_vma case there are
callchains that pass thru multiple DSOs in userspace (I used --call
dwarf in 'perf record') and those are marked as having
samples/annotation and when I go to those, pressing 'a' after moving the
cursor to it and it works as expected...

Do you have some specific example I could try?

- Arnaldo


> > I think it works as long as the caller you want to annotate is in the
> > same module.
> > But suppose, I am on malloc() (libc) and I want to see a caller of
> > malloc(), it will
> > propose 'annotate bar()', but will still show me the code of libc:malloc.
> > 
> > In my earlier test, everything worked because the callee and caller were in the
> > same module.
> > 
> > Could you fix this?
> 
> I thought that was covered because it deals with a "map_symbol" struct,
> where it finds both the symbol and the DSO where it came from, etc.
> 
> Checking that now...
> 
> 
> - Arnaldo
