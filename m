From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf/tools : remove default system_wide in sched record
Date: Tue, 24 Oct 2017 10:46:44 -0300
Message-ID: <20171024134644.GF7045@kernel.org>
References: <1508831134-151993-1-git-send-email-cj.chengjian@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508831134-151993-1-git-send-email-cj.chengjian@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng Jian <cj.chengjian@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, xiexiuqi@huawei.com, huawei.libin@huawei.com, zhangmengting@huawei.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Oct 24, 2017 at 03:45:34PM +0800, Cheng Jian escreveu:
> When running perf sched record, there is a bug.
> 
> It's system_wide when we specify a command line.

Humm, isn't this because if you trace just a workload you will miss the
sched-in events?

Perhaps with PERF_RECORD_SWITCH we can solve that... I.e. still get the
sched-in events while tracing just one workload, not requiring
system_wide like it is the case now, right?

- Arnaldo
 
> $ perf sched record ls
> $ perf script
>          swapper     0 [001] 1312209.826144:
> sched:sched_wakeup: crash:21979 [120] success=1 CPU:001
>          swapper     0 [001] 1312209.826148:
> sched:sched_switch: swapper/1:0 [120] R ==> crash:21979 [120]
>            crash 21979 [001] 1312209.826151:
> sched:sched_stat_runtime: comm=crash pid=21979
> runtime=8161 [ns] vruntime=1591295759555 [ns]
>            crash 21979 [001] 1312209.826185:
> sched:sched_switch: crash:21979 [120] S ==> swapper/1:0 [120]
>               ls 148873 [169] 1312209.826818:
> sched:sched_stat_runtime: comm=ls pid=148873
> runtime=999532 [ns] vruntime=8099789362030 [ns]
>             perf 148872 [109] 1312209.826818:
> sched:sched_stat_runtime: comm=perf pid=148872
> runtime=1001606 [ns] vruntime=7794318690006 [ns]
> 
> This is because '-a'(system_wide) is set in record_args.
> so just remove it.
> 
> After :
> 	  swapper     0 [109] 1313349.767284:
> sched:sched_wakeup: comm=perf pid=149865 prio=120 success=1 target_cpu=109
>               ls 149865 [133] 1313349.769066: sched:sched_stat_runtime:
> comm=ls pid=149865 runtime=1001167 [ns] vruntime=7871277236086 [ns]
>               ls 149865 [133] 1313349.770062:
> sched:sched_stat_runtime: comm=ls pid=149865
> runtime=998985 [ns] vruntime=7871278235071 [ns]
>               ls 149865 [133] 1313349.770731:
> sched:sched_wakeup: comm=kworker/133:2 pid=137042
> prio=120 success=1 target_cpu=133
> 
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> Signed-off-by: Zhang MengTing <zhangmengting@huawei.com>
> ---
>  tools/perf/builtin-sched.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 322b4de..47b79fc 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3248,7 +3248,6 @@ static int __cmd_record(int argc, const char **argv)
>  	const char **rec_argv;
>  	const char * const record_args[] = {
>  		"record",
> -		"-a",
>  		"-R",
>  		"-m", "1024",
>  		"-c", "1",
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
