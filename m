From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 1/2] perf sched: move thread::shortname to
 thread_runtime
Date: Wed, 7 Mar 2018 11:44:41 +0900
Message-ID: <20180307024441.GA10527@danjae.aot.lge.com>
References: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
 <1520307457-23668-2-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520307457-23668-2-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: changbin.du@intel.com
Cc: acme@kernel.org, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Hi,

On Tue, Mar 06, 2018 at 11:37:36AM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> The thread::shortname only used by sched command, so move it
> to sched private structure.
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---

[SNIP]
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 40cfa36..14d44c3 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -26,7 +26,6 @@ struct thread {
>  	pid_t			ppid;
>  	int			cpu;
>  	refcount_t		refcnt;
> -	char			shortname[3];
>  	bool			comm_set;
>  	int			comm_len;
>  	bool			dead; /* if set thread has exited */

I also suggest to move the 'dead' field to pack two bools.

Thanks,
Namhyung
