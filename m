Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7777DC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E21B6103D
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbhHaSrc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239280AbhHaSrb (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 14:47:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 825176056B;
        Tue, 31 Aug 2021 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630435595;
        bh=kTXrNmPAOjCCJ87XuzHaMszrCV1Jfzu38Ezem81EJ/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6qXQvPARkrHm3Ca+RTu4DzO5nw5PbL2A+/CBzgbRuIPi8sW9f3Q/rXP3Ni6Wkbyp
         7++7YQ7jipWuNR2QgTxgUqVLlaQ9Ugv2u19BH+MV8f+7KI8FAR+YJAjp3aPGUklydD
         NM6ZP2wkxs53iin29VnoLs1fa68pX1RfJ0QXwDxy44wPB55NPi4B26CvHQEVYkECP9
         2wwt+4qkKBK465ZImQ4XcagvMzZGToTpyxLGY49xWfJQ4J1oOfdU5s7Ha+VygSmUEj
         0hcfuczwqtrPJmF5BNwCv934yh1CiBNPfGVM17b1+FoYNwQBfN98Xc9hTwre9wO2eD
         NaqIsWJxYIllA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EF4384007E; Tue, 31 Aug 2021 15:46:32 -0300 (-03)
Date:   Tue, 31 Aug 2021 15:46:32 -0300
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
Message-ID: <YS55COgKH5CRsYE0@kernel.org>
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

Why not use bsearch()?  See 'man bsearch' and look at the example.

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
