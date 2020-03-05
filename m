From: Arnaldo Carvalho de MElo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 4/5] perf bench: Share some global variables to fix build
 with gcc 10
Date: Thu, 5 Mar 2020 12:16:09 -0300
Message-ID: <20200305151609.GE7895@kernel.org>
References: <20200303194827.6461-1-acme@kernel.org>
 <20200303194827.6461-5-acme@kernel.org>
 <bb1a3048a0f75d1fdf497c67d16a022cdd15c437.camel@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb1a3048a0f75d1fdf497c67d16a022cdd15c437.camel@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Mar 05, 2020 at 08:43:32AM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) escreveu:
> On Tue, 2020-03-03 at 16:48 -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> BTW there's also some div-by-zero bugs here if runtime is zero:
> 
> $ perf bench epoll wait --runtime=0
> # Running 'epoll/wait' benchmark:
> Run summary [PID 30859]: 7 threads monitoring on 64 file-descriptors for 0
> secs.
> 
> Floating point exception (core dumped)

Can you please submit a patch for that? 

I've applied the other 3 fixes you submitted, thanks for that!

- Arnaldo
 
> > diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-
> > wait.c
> > index 7af694437f4e..d1c5cb526b9f 100644
> > --- a/tools/perf/bench/epoll-wait.c
> > +++ b/tools/perf/bench/epoll-wait.c
> > 
> > @@ -519,7 +518,7 @@ int bench_epoll_wait(int argc, const char **argv)
> >  		qsort(worker, nthreads, sizeof(struct worker), cmpworker);
> >  
> >  	for (i = 0; i < nthreads; i++) {
> > -		unsigned long t = worker[i].ops/runtime.tv_sec;
> > +		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
> >  
> >  		update_stats(&throughput_stats, t);
> >  
> > diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-
> > hash.c
> > index 8ba0c3330a9a..21776862e940 100644
> > --- a/tools/perf/bench/futex-hash.c
> > +++ b/tools/perf/bench/futex-hash.c
> > 
> > @@ -204,7 +204,7 @@ int bench_futex_hash(int argc, const char **argv)
> >  	pthread_mutex_destroy(&thread_lock);
> >  
> >  	for (i = 0; i < nthreads; i++) {
> > -		unsigned long t = worker[i].ops/runtime.tv_sec;
> > +		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
> >  		update_stats(&throughput_stats, t);
> >  		if (!silent) {
> >  			if (nfutexes == 1)
> > diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-
> > lock-pi.c
> > index d0cae8125423..30d97121dc4f 100644
> > --- a/tools/perf/bench/futex-lock-pi.c
> > +++ b/tools/perf/bench/futex-lock-pi.c
> > 
> > @@ -211,7 +210,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
> >  	pthread_mutex_destroy(&thread_lock);
> >  
> >  	for (i = 0; i < nthreads; i++) {
> > -		unsigned long t = worker[i].ops/runtime.tv_sec;
> > +		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
> >  
> >  		update_stats(&throughput_stats, t);
> >  		if (!silent)
> 

-- 

- Arnaldo
