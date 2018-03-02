From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RESEND PATCH] perf sched map: re-annotate shortname if thread
 comm changed
Date: Fri, 2 Mar 2018 23:47:32 +0900
Message-ID: <20180302144732.GA2471@danjae.aot.lge.com>
References: <1519386040-25874-1-git-send-email-changbin.du@intel.com>
 <20180302105254.234axj7b3nixakav@intel.com>
 <20180302113845.GC16348@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180302113845.GC16348@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Du, Changbin" <changbin.du@intel.com>, acme@kernel.org, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Hi,

On Fri, Mar 02, 2018 at 12:38:45PM +0100, Jiri Olsa wrote:
> On Fri, Mar 02, 2018 at 06:52:54PM +0800, Du, Changbin wrote:
> > Hello, any comment?
> 
> sry, overlooked this one
> 
> SNIP
> 
> > > diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> > > index 68b65b1..c660fe6 100644
> > > --- a/tools/perf/util/thread.c
> > > +++ b/tools/perf/util/thread.c
> > > @@ -212,6 +212,7 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
> > >  			unwind__flush_access(thread);
> > >  	}
> > >  
> > > +	thread->comm_changed = true;
> > >  	thread->comm_set = true;
> > >  
> > >  	return 0;
> > > diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> > > index 40cfa36..b9a328b 100644
> > > --- a/tools/perf/util/thread.h
> > > +++ b/tools/perf/util/thread.h
> > > @@ -27,6 +27,7 @@ struct thread {
> > >  	int			cpu;
> > >  	refcount_t		refcnt;
> > >  	char			shortname[3];
> > > +	bool			comm_changed;
> 
> I don't like that it's in struct thread and set by generic function,
> and just one command (sched) checks/sets it back.. I'd rather see it
> in thread::priv area..

100% agreed.


> on the other hand it's simple enough and looks
> like generic solution would be more tricky

What about adding perf_sched__process_comm() to set it in the
thread::priv?

Thanks,
Namhyung
