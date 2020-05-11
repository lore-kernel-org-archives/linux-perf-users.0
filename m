From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf record: Use an eventfd to wakeup when done
Date: Mon, 11 May 2020 13:28:33 +0200
Message-ID: <20200511112833.GE2986380@krava>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand K Mistry <amistry@google.com>
Cc: linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Fri, May 08, 2020 at 02:56:43PM +1000, Anand K Mistry wrote:
> The setting and checking of 'done' contains a rare race where the signal
> handler setting 'done' is run after checking to break the loop, but
> before waiting in evlist__poll(). In this case, the main loop won't wake
> up until either another signal is sent, or the perf data fd causes a
> wake up.
> 
> The following simple script can trigger this condition (but you might
> need to run it for several hours):
> for ((i = 0; i >= 0; i++)) ; do
>   echo "Loop $i"
>   delay=$(echo "scale=4; 0.1 * $RANDOM/32768" | bc)
>   ./perf record -- sleep 30000000 >/dev/null&
>   pid=$!
>   sleep $delay
>   kill -TERM $pid
>   echo "PID $pid"
>   wait $pid
> done
> 
> At some point, the loop will stall. Adding logging, even though perf has
> received the SIGTERM and set 'done = 1', perf will remain sleeping until
> a second signal is sent.

so it's just few instructions in between the check and the evlist__poll

         if (done || draining)
               break;
         err = evlist__poll(rec->evlist, -1);

nice catch!

SNIP

> @@ -518,15 +519,19 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  
>  static volatile int signr = -1;
>  static volatile int child_finished;
> +static int done_fd = -1;
>  
>  static void sig_handler(int sig)
>  {
> +	u64 tmp = 1;
>  	if (sig == SIGCHLD)
>  		child_finished = 1;
>  	else
>  		signr = sig;
>  
>  	done = 1;

could you please put some explaining comment in here,
so we are not confused by this in few months ;-)

> +	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> +		pr_err("failed to signal wakeup fd\n");
>  }
>  
>  static void sigsegv_handler(int sig)
> @@ -1424,6 +1429,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	int fd;
>  	float ratio = 0;
>  
> +	done_fd = eventfd(0, EFD_NONBLOCK);
> +	evlist__add_pollfd(rec->evlist, done_fd);

both of those can fail, please check the return values

thanks,
jirka

> +
>  	atexit(record__sig_exit);
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGINT, sig_handler);
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 
