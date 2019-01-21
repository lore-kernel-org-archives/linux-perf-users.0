From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
Date: Mon, 21 Jan 2019 19:34:37 +0100
Message-ID: <20190121183437.GB11396@krava>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org>
 <20190120181814.GB8591@krava>
 <20190121131336.GC3852@krava>
 <20190121141748.GC15707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121141748.GC15707@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jan 21, 2019 at 11:17:48AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 21, 2019 at 02:13:36PM +0100, Jiri Olsa escreveu:
> > On Sun, Jan 20, 2019 at 07:18:14PM +0100, Jiri Olsa wrote:
> > > On Thu, Jan 17, 2019 at 11:00:53AM -0300, Arnaldo Carvalho de Melo wrote:
> > > 
> > > SNIP
> > > 
> > > > --- a/tools/perf/util/python-ext-sources
> > > > +++ b/tools/perf/util/python-ext-sources
> > > > @@ -25,6 +25,7 @@ util/parse-branch-options.c
> > > >  util/rblist.c
> > > >  util/counts.c
> > > >  util/print_binary.c
> > > > +util/s390-sample-raw.c
> > > >  util/strlist.c
> > > >  util/trace-event.c
> > > >  ../lib/rbtree.c
> > > 
> > > hi,
> > > this change breaks the python module:
> > > 
> > >   >>> import perf
> > >   Traceback (most recent call last):
> > >     File "<stdin>", line 1, in <module>
> > >   ImportError: ./perf.so: undefined symbol: color_fprintf
> > > 
> > > changelog doesn't say anything about python related change
> > 
> > I made some chenages and movedthat raw sample code
> > under s390.. which cured the python module, but
> > I haven't tested it on s390.
> 
> Nope, I explicitely asked him to build that code for all arches, as we
> want to process s390 perf.data files on a x86 or arm or any other arch.
> 

aah, so this actualy works over the s390 perf archive data on x86 host?

I missed that in the original conversation, sry for noise

jirka

> I stumbled on this as well, I think the way to go is to get the
> color_fprintf bits in a separate object to avoid dragging more stuff to
> the perf binding set of objects and then add that to the python binding.
>  
> > Could you please check if code in here works for you:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/s390
> > 
> > if it works, I'll post it
> > 
> > thanks,
> > jirka
> 
> -- 
> 
> - Arnaldo
