Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E91C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 15:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD6E61374
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 15:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhKGPoP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 10:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234160AbhKGPoP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 10:44:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5BB66112D;
        Sun,  7 Nov 2021 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636299692;
        bh=wOTsiBoWaScfUAUeWMCNR6j5cNeqSxwLSPxET5zhUKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5tlxBLSw6XC0KCVEgg6feY05O6roMo44wU5O9dw6B31qECgM/RHlqVhBlpcusCma
         OczPbzQxKxti97/2KC1r9TbbpGSVD4fbmeQOHKC3O1U/4z081xl2TZTBVnGDvbwIJD
         Pk04XGb9+WUttWQsVPVFH1fP4zy0vJinz+5HuynQ3w5xjIrtl6dmbe64W2WGjtjBPh
         WuOhxpTKfEPSzBha1ENfWwgQoQLCD36sp5B8FZYFjd24YOiIMTWVa94jQ3aTSMSIwd
         ozNNMpQM8/SX7LTGAjvx4Un8oCqedauozSZ9jopacqg6893u7Bf3nLJuXDIuKRBamO
         4JBQoyDyfLpwQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DB377410A1; Sun,  7 Nov 2021 12:41:28 -0300 (-03)
Date:   Sun, 7 Nov 2021 12:41:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2 3/3] perf metric: Fix memory leaks.
Message-ID: <YYfzqLMiPpWlzVni@kernel.org>
References: <20211107090002.3784612-1-irogers@google.com>
 <20211107090002.3784612-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107090002.3784612-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Nov 07, 2021 at 01:00:02AM -0800, Ian Rogers escreveu:
> Certain error paths may leak memory as caught by address sanitizer.
> Ensure this is cleaned up to make sure address/leak sanitizer is happy.

Thanks, applied.

- Arnaldo

 
> Fixes: 5ecd5a0c7d1c ("perf metrics: Modify setup and deduplication")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 1b43cbc1961d..fffe02aae3ed 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -228,6 +228,7 @@ static void metric__free(struct metric *m)
>  	free(m->metric_refs);
>  	expr__ctx_free(m->pctx);
>  	free((char *)m->modifier);
> +	evlist__delete(m->evlist);
>  	free(m);
>  }
>  
> @@ -1482,8 +1483,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  	}
>  
>  
> -	if (combined_evlist)
> +	if (combined_evlist) {
>  		evlist__splice_list_tail(perf_evlist, &combined_evlist->core.entries);
> +		evlist__delete(combined_evlist);
> +	}
>  
>  	list_for_each_entry(m, &metric_list, nd) {
>  		if (m->evlist)
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog

-- 

- Arnaldo
