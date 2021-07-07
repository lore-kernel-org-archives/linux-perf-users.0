Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767B8C07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B78E61CCB
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhGGRpv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhGGRpu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 13:45:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2200D61CC8;
        Wed,  7 Jul 2021 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625679790;
        bh=hd+YlzFsLb6/d/lU/DpcxgXWDZRboDxqk3+K2iuZQ2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sl+08+zSFaA02gl6tj0xFIYHgODbhKkuqKmATlDoEEyIyPQ/UprMr12cjPYLH1oQ+
         ee8IP0/y7m0sY+u2jKI81a8xvqYH/kI1hNyUEcdpi61Ygl/6XmXhciPeYqO1ZHA1ov
         IXzlCc1xYoEHFEJuLbT10Gp7MSZGpukjNjWUGS2NIHIoLOZcb6/GNc0ibEHQeHGgLW
         3wHKzYW3AMts8e1Wagv4BRv3sOycF4XFj8JEsJLYCDYhVkkpcOOyLvxrKAp6vbD0Eo
         0VmxseXgZz5C9lBI4l7L3vofWStlOtGmRod7pzm6szoz2CI8XEm59x3Ay6bflEhSN5
         S6dZW4ZeLLmeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C8C140B1A; Wed,  7 Jul 2021 14:43:07 -0300 (-03)
Date:   Wed, 7 Jul 2021 14:43:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 6/7] libperF: Add group support to perf_evsel__open
Message-ID: <YOXnq2yTVwklbrpO@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706151704.73662-7-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 06, 2021 at 05:17:03PM +0200, Jiri Olsa escreveu:
> Adding support to set group_fd in perf_evsel__open
> call and make it to follow the group setup.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/perf/evsel.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 3e6638d27c45..9ebf7122d476 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -17,6 +17,7 @@
>  #include <linux/string.h>
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
> +#include <asm/bug.h>
>  
>  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
>  		      int idx)
> @@ -76,6 +77,25 @@ sys_perf_event_open(struct perf_event_attr *attr,
>  	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
>  }
>  
> +static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread)
> +{
> +	struct perf_evsel *leader = evsel->leader;
> +	int fd;
> +
> +	if (evsel == leader)
> +		return -1;
> +
> +	/*
> +	 * Leader must be already processed/open,
> +	 * if not it's a bug.
> +	 */
> +	BUG_ON(!leader->fd);

Humm, having panics in library code looks ugly, why can't we just return
some errno and let the whatever is using the library to fail gracefully?

I applied the patches so far, will make them available at tmp.perf/core
now.

- Arnaldo

> +	fd = FD(leader, cpu, thread);
> +	BUG_ON(fd == -1);
> +	return fd;
> +}
> +
>  int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>  		     struct perf_thread_map *threads)
>  {
> @@ -111,11 +131,13 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>  
>  	for (cpu = 0; cpu < cpus->nr; cpu++) {
>  		for (thread = 0; thread < threads->nr; thread++) {
> -			int fd;
> +			int fd, group_fd;
> +
> +			group_fd = get_group_fd(evsel, cpu, thread);
>  
>  			fd = sys_perf_event_open(&evsel->attr,
>  						 threads->map[thread].pid,
> -						 cpus->map[cpu], -1, 0);
> +						 cpus->map[cpu], group_fd, 0);
>  
>  			if (fd < 0)
>  				return -errno;
> -- 
> 2.31.1
> 

-- 

- Arnaldo
