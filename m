From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCH] perf cgroup: simplify arguments if track multiple
 events for a cgroup
Date: Mon, 29 Jan 2018 11:39:26 +0100
Message-ID: <20180129103926.GA20848@krava>
References: <20180128053143.GA13597@localhost.didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeA2Kj3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Jan 2018 05:39:29 -0500
Content-Disposition: inline
In-Reply-To: <20180128053143.GA13597@localhost.didichuxing.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Sun, Jan 28, 2018 at 01:31:48PM +0800, weiping zhang wrote:
> if use -G with one cgroup and -e with multiple events, only the first
> event has correct cgroup setting, all events from the second will track
> system-wide events.
> 
> if user want track multiple events for a specific cgroup, user must give
> parameters like follow:
> $ perf stat -e e1 -e e2 -e e3 -G test,test,test
> this patch simplify this case, just type one cgroup, like following:
> $ perf stat -e e1 -e e2 -e e3 -G test
> 
> reproduce:
> $ mkdir -p /sys/fs/cgroup/perf_event/test
> $ perf stat -e cycles -e cache-misses  -a -I 1000 -G test
> 
> before:
>      1.001007226      <not counted>      cycles                    test
>      1.001007226              7,506      cache-misses
> 
> after:
>      1.000834097      <not counted>      cycles                    test
>      1.000834097      <not counted>      cache-misses              test
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  tools/perf/util/cgroup.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

please update the -G option documentation

> 
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index d9ffc1e..38aaeb2 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -154,9 +154,11 @@ int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
>  		  int unset __maybe_unused)
>  {
>  	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
> +	struct perf_evsel *counter;
> +	struct cgroup_sel *cgrp = NULL;
>  	const char *p, *e, *eos = str + strlen(str);
>  	char *s;
> -	int ret;
> +	int ret, i;
>  
>  	if (list_empty(&evlist->entries)) {
>  		fprintf(stderr, "must define events before cgroups\n");
> @@ -185,5 +187,18 @@ int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
>  			break;
>  		str = p+1;
>  	}
> +	/* for the case one cgroup combine to multiple events */
> +	i = 0;
> +	if (nr_cgroups == 1) {
> +		evlist__for_each_entry(evlist, counter) {
> +			if (i == 0)
> +				cgrp = counter->cgrp;

what if the only group is not defined for the first event? like  -G ,,krava

thanks,
jirka
