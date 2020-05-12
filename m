From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf record: Use an eventfd to wakeup when done
Date: Tue, 12 May 2020 11:12:21 -0300
Message-ID: <20200512141221.GL28888@kernel.org>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200512145930.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200512121232.GB3150977@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200512121232.GB3150977@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Anand K Mistry <amistry@google.com>, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, May 12, 2020 at 02:12:32PM +0200, Jiri Olsa escreveu:
> On Tue, May 12, 2020 at 02:59:36PM +1000, Anand K Mistry wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 1ab349abe90469..099ecaa66732a2 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -53,6 +53,7 @@
> >  #include <unistd.h>
> >  #include <sched.h>
> >  #include <signal.h>
> > +#include <sys/eventfd.h>
> >  #include <sys/mman.h>
> >  #include <sys/wait.h>
> >  #include <sys/types.h>
> > @@ -518,15 +519,28 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
> >  
> >  static volatile int signr = -1;
> >  static volatile int child_finished;
> > +static int done_fd = -1;
> >  
> >  static void sig_handler(int sig)
> >  {
> > +	u64 tmp = 1;
> >  	if (sig == SIGCHLD)
> >  		child_finished = 1;
> >  	else
> >  		signr = sig;
> >  
> >  	done = 1;
> > +
> > +	/*
> > +	 * It is possible for this signal handler to run after done is checked
> > +	 * in the main loop, but before the perf counter fds are polled. If this
> > +	 * happens, the poll() will continue to wait even though done is set,
> > +	 * and will only break out if either another signal is received, or the
> > +	 * counters are ready for read. To ensure the poll() doesn't sleep when
> > +	 * done is set, use an eventfd (done_fd) to wake up the poll().
> > +	 */
> > +	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> > +		pr_err("failed to signal wakeup fd\n");
> >  }
> >  
> >  static void sigsegv_handler(int sig)
> > @@ -1424,6 +1438,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >  	int fd;
> >  	float ratio = 0;
> >  
> > +	done_fd = eventfd(0, EFD_NONBLOCK);
> > +	if (done_fd < 0) {
> > +		pr_err("Failed to create wakeup eventfd, error: %m\n");
> > +		return -1;
> > +	}
> > +	err = evlist__add_pollfd(rec->evlist, done_fd);
> > +	if (err < 0) {
> > +		pr_err("Failed to add wakeup eventfd to poll list\n");
> > +		return -1;
> > +	}
> 
> sorry I did not notice before, but I think we also
> need to close done_fd descriptor on the exit path
> 
> also please change subject to PATCHv3 for the next version

Yeah, and, and don't take this as a requirement for this patch to be
processed, this can be made as a follow up patch by you or someone else
(me, maybe :)), that maybe tools/perf/builtin-top.c and
tools/perf/builtin-trace.c have the same issue?

Could you please take a look there as well?

- Arnaldo
 
> thanks,
> jirka
> 
> > +
> >  	atexit(record__sig_exit);
> >  	signal(SIGCHLD, sig_handler);
> >  	signal(SIGINT, sig_handler);
> > -- 
> > 2.26.2.645.ge9eca65c58-goog
> > 
> 

-- 

- Arnaldo
