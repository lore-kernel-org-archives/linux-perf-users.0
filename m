Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1104BC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD19C610E5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 14:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbhJHObO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 10:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhJHObJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 10:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 143D460EB6;
        Fri,  8 Oct 2021 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633703354;
        bh=8okn7WP++OasUoqVVEB1PJg6oI3Q18MMY20pDXxku2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XelR3LJXFLSXs7lgpCH8wyXJ/sZ7T24II38jHjkrAi3W37jkBXIK0VhPJ9BtWtRge
         bxBW3lHLheFQckuVxTfmnQYkoY9UFrZ51cXbofV7E5vEAXUOnaOzPeU5+1oOqvBLOU
         r82S7JJJ3JNSDoR/5zI9u+nPGk7Lvlh5P1tQCfqJCXGAgj6VtH4gDd8VrLVavFqT2W
         NjYuvC/eq4LpwX09kMHqjd/RSoGkogbetKJPd1DJbAHvwybn2CjxUd/2+higVD4xQ1
         MBHKUnYKvpwnRv69AjzrSevsvU1aWUgeQ28Gp0ZsewP5dz/gOqOaFD77hllbFyLbnL
         /uXsDmbLr+9pA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D994A410A1; Fri,  8 Oct 2021 11:29:10 -0300 (-03)
Date:   Fri, 8 Oct 2021 11:29:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/37] libperf cpumap: improve idx function
Message-ID: <YWBVtjS4qdnWKpK4@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <f1543c15797169c21e8b205a4a6751159180580d.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1543c15797169c21e8b205a4a6751159180580d.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:07AM +0200, Riccardo Mancini escreveu:
> >From commit 7074674e7338863e ("perf cpumap: Maintain cpumaps ordered
> and without dups"), perf_cpu_map elements are sorted in ascending order.
> 
> This patch improves the perf_cpu_map__idx function by using a binary
> search.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/lib/perf/cpumap.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index ca0215047c326af4..fb633272be3aaed9 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -265,11 +265,18 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
>  
>  int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
>  {
> -	int i;
> +	int low = 0, high = cpus->nr, idx, cpu_at_idx;
>  
> -	for (i = 0; i < cpus->nr; ++i) {
> -		if (cpus->map[i] == cpu)
> -			return i;
> +	while (low < high) {
> +		idx = (low + high) / 2;
> +		cpu_at_idx = cpus->map[idx];
> +
> +		if (cpu_at_idx == cpu)
> +			return idx;
> +		else if (cpu_at_idx > cpu)
> +			high = idx;
> +		else
> +			low = idx+1;
>  	}
>  
>  	return -1;
> -- 
> 2.31.1

-- 

- Arnaldo
