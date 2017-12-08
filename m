From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] perf evsel: Enable ignore_missing_thread for pid
 option
Date: Fri, 8 Dec 2017 12:54:53 +0100
Message-ID: <20171208115453.GA7889@krava>
References: <1512654213-45400-1-git-send-email-zhangmengting@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbdLHLy4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Dec 2017 06:54:56 -0500
Content-Disposition: inline
In-Reply-To: <1512654213-45400-1-git-send-email-zhangmengting@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mengting Zhang <zhangmengting@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@redhat.com, huawei.libin@huawei.com, wangnan0@huawei.com, cj.chengjian@huawei.com

On Thu, Dec 07, 2017 at 09:43:33PM +0800, Mengting Zhang wrote:

SNIP

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f894893..d0ef889 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1592,10 +1592,43 @@ static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
>  	return fprintf(fp, "  %-32s %s\n", name, val);
>  }
>  
> +static void perf_evsel__remove_fd(struct perf_evsel *pos,
> +				  int nr_cpus, int nr_threads,
> +				  int thread_idx)
> +{
> +	for (int cpu = 0; cpu < nr_cpus; cpu++)
> +		for (int thread = thread_idx; thread < nr_threads - 1; thread++)
> +			FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
> +}
> +
> +static int perf_evlist__update_fds(struct perf_evsel *evsel,
> +				   int nr_cpus, int cpu_idx,
> +				   int nr_threads, int thread_idx)

we use '__' to delimit the object, so you'd need to call this
function with perf_evlist as a first argument

I think 'update_fds' name would be ok

> +{
> +	struct perf_evsel *pos;
> +	struct perf_evlist *evlist = evsel->evlist;
> +
> +	if (cpu_idx >= nr_cpus || thread_idx >= nr_threads)
> +		return -EINVAL;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		nr_cpus = pos != evsel ? nr_cpus : cpu_idx;
> +
> +		perf_evsel__remove_fd(pos, nr_cpus, nr_threads, thread_idx);
> +

could you please add comment in here explaining why we
don't iterate whole list.. it's clear now, but in future
after more changes in here could be pita ;-)

> +		if (pos == evsel)
> +			break;
> +	}
> +	return 0;
> +}
> +
>  static bool ignore_missing_thread(struct perf_evsel *evsel,
> +				  int nr_cpus, int cpu,
>  				  struct thread_map *threads,
>  				  int thread, int err)
>  {
> +	pid_t ignore_pid = thread_map__pid(threads, thread);
> +
>  	if (!evsel->ignore_missing_thread)
>  		return false;
>  
> @@ -1611,11 +1644,17 @@ static bool ignore_missing_thread(struct perf_evsel *evsel,
>  	if (threads->nr == 1)
>  		return false;
>  
> +	/* We should remove fd for missing_thread first
> +	 * because thread_map__remove() will decrease threads->nr.
> +	 */

there's some guide for the multiline comment style,
I think you should put it like:

	/* 
	 * We should remove fd for missing_thread first
	 * because thread_map__remove() will decrease threads->nr.
	 */

thanks,
jirka
