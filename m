From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf stat: Honour --timeout for forked workloads
Date: Wed, 15 Apr 2020 18:25:19 +0200
Message-ID: <20200415162519.GB284534@krava>
References: <20200415153803.GB20324@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200415153803.GB20324@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Konstantin Kharlamov <hi-angel@yandex.ru>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, yuzhoujian@didichuxing.com
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 15, 2020 at 12:38:03PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi guys,
> 
> 	Please take a look and give this your acks, Tested-by, etc.
> 
> Thanks,
> 
> - Arnaldo
> 
> ----
> 
> When --timeout is used and a workload is specified to be started by
> 'perf stat', i.e.
> 
>   $ perf stat --timeout 1000 sleep 1h
> 
> The --timeout wasn't being honoured, i.e. the workload, 'sleep 1h' in
> the above example, should be terminated after 1000ms, but it wasn't,
> 'perf stat' was waiting for it to finish.
> 
> Fix it by sending a SIGTERM when the timeout expires.
> 
> Now it works:
> 
>   # perf stat -e cycles --timeout 1234 sleep 1h
>   sleep: Terminated
> 
>    Performance counter stats for 'sleep 1h':
> 
>            1,066,692      cycles
> 
>          1.234314838 seconds time elapsed
> 
>          0.000750000 seconds user
>          0.000000000 seconds sys
> 
>   #
> 
> Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207243
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked/Tested-by: Jiri Olsa <jolsa@redhat.com>

cc-ing yuzhoujian, author of the --timeout

jirka

> ---
>  tools/perf/builtin-stat.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ec053dc1e35c..9207b6c45475 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -686,8 +686,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  					break;
>  			}
>  		}
> -		if (child_pid != -1)
> +		if (child_pid != -1) {
> +			if (timeout)
> +				kill(child_pid, SIGTERM);
>  			wait4(child_pid, &status, 0, &stat_config.ru_data);
> +		}
>  
>  		if (workload_exec_errno) {
>  			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
> -- 
> 2.25.2
> 
