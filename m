Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC0C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3FE96103D
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbhHaSsJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239481AbhHaSsI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 14:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37BF161008;
        Tue, 31 Aug 2021 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630435633;
        bh=iT/iIdNBsTbGiFre6zz9wX0FMEwGiJRBo2nVuhGFLaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mktDBhAO3/B5cmfypfEMomXqZX+lfO17FLVMw0r2aC6emyMFXQaxwJcErh4djdmsw
         upV+1TEuS+2cKvpyefH4tk8kN7iY06HKsUNayutcm/xrShONgV2qO3NXEHNFrqX0NO
         LAATfSaDO/cmqOQuXWTeJEXGOT9/rIKAX37a7Jw/tYhXGZB6SQJ0ZGL0QTaL+mIyZY
         AHt/Dy+Fnx+ppqA4V8+1c503hwM+Vj1DZQoUyZeNqj1E6FGYMeYIUhJ54RetrLYj78
         8NH7FK8sC8xbL854MXORHmN3AOw5mgH0syLTWfHShflq4eCbuxRCz8wowf9ZtNghN+
         9RDfWfJrSt+8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BBE1C400FE; Tue, 31 Aug 2021 15:47:10 -0300 (-03)
Date:   Tue, 31 Aug 2021 15:47:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 02/37] libperf cpumap: improve max function
Message-ID: <YS55LhhuABId0ag7@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <fb79f02e7b86ea8044d563adb1e9890c906f982f.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb79f02e7b86ea8044d563adb1e9890c906f982f.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:08AM +0200, Riccardo Mancini escreveu:
> >From commit 7074674e7338863e ("perf cpumap: Maintain cpumaps ordered and
> without dups"), perf_cpu_map elements are sorted in ascending order.
> 
> This patch improves the perf_cpu_map__max function by returning the last
> element.
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/lib/perf/cpumap.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index fb633272be3aaed9..80e03b2f0c60cce7 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -284,14 +284,10 @@ int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
>  
>  int perf_cpu_map__max(struct perf_cpu_map *map)
>  {
> -	int i, max = -1;
> -
> -	for (i = 0; i < map->nr; i++) {
> -		if (map->map[i] > max)
> -			max = map->map[i];
> -	}
> -
> -	return max;
> +	if (map->nr > 0)
> +		return map->map[map->nr-1];
> +	else
> +		return -1;

Applying, but adding spaces around the '-',

Thanks.

- Arnaldo
