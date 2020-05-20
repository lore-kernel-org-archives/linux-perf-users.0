From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3] perf record: Use an eventfd to wakeup when done
Date: Wed, 20 May 2020 12:47:04 -0300
Message-ID: <20200520154704.GL32678@kernel.org>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200513113941.GK3158213@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200513113941.GK3158213@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Anand K Mistry <amistry@google.com>, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, May 13, 2020 at 01:39:41PM +0200, Jiri Olsa escreveu:
> On Wed, May 13, 2020 at 12:20:23PM +1000, Anand K Mistry wrote:
> > The setting and checking of 'done' contains a rare race where the signal
> > handler setting 'done' is run after checking to break the loop, but
> > before waiting in evlist__poll(). In this case, the main loop won't wake
> > up until either another signal is sent, or the perf data fd causes a
> > wake up.
> > 
> > The following simple script can trigger this condition (but you might
> > need to run it for several hours):
> > for ((i = 0; i >= 0; i++)) ; do
> >   echo "Loop $i"
> >   delay=$(echo "scale=4; 0.1 * $RANDOM/32768" | bc)
> >   ./perf record -- sleep 30000000 >/dev/null&
> >   pid=$!
> >   sleep $delay
> >   kill -TERM $pid
> >   echo "PID $pid"
> >   wait $pid
> > done
> > 
> > At some point, the loop will stall. Adding logging, even though perf has
> > received the SIGTERM and set 'done = 1', perf will remain sleeping until
> > a second signal is sent.
> > 
> > Signed-off-by: Anand K Mistry <amistry@google.com>
> > 
> > ---
> > 
> > Changes in v3:
> > - Move done_fd creation to below session initialisation
> > - Close done_fd on exit
> > - Log errno when write(done_fd) fails
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

I've made this dependent on HAVE_EVENTFD_SUPPORT, so that it continues
building on older systems,

- Arnaldo
