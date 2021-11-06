Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C138CC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B5D6112D
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhKFTy1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhKFTy0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Nov 2021 15:54:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0B7160FC3;
        Sat,  6 Nov 2021 19:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636228305;
        bh=t35dqCporb6l1Hvqc9QMrCIDcT/NqtO6bPxLBhFw+I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYk0ZVmCxeIc/VzJ0Hk2VUQ7Odf4H+y3viYxMe0IQMMvfTfr5m2eSr/HUhIOOq9Yn
         S2ee+sxZa8zZ+4ANUtcegB7eGERdGQTXIeAkwgQi7yJiKWH1nXigC1TMnjT6JwUT73
         O+7yL2YL4YRNApHVpGkJGC2bHF9VZf+21u8/GubKUA7ncafEKKnO6NF5llOBjXUHrB
         LdwQY/vPhlqM7vYdY+Ju9lxCOa4xc5cfweszUc4zWYVhK/IqZQd+N/l8jGik14+YRn
         UWgx10oNq6ses775k+Bw33siE0KOe/ZaeES3olsMasq9iOn0IEGr26cqXp+8b8XU0s
         XDWjivTHKjmtw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 954A3410A1; Sat,  6 Nov 2021 16:51:42 -0300 (-03)
Date:   Sat, 6 Nov 2021 16:51:42 -0300
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
Subject: Re: [PATCH] perf metric: Fix memory leaks.
Message-ID: <YYbczk5svUYrbIhQ@kernel.org>
References: <20211105164657.3476647-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105164657.3476647-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Nov 05, 2021 at 09:46:57AM -0700, Ian Rogers escreveu:
> Certain error paths may leak memory as caught by address sanitizer.
> Ensure this is cleaned up to make sure address/leak sanitizer is happy.
> 
> Fixes: 5ecd5a0c7d1c ("perf metrics: Modify setup and deduplication")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4917e9704765..734d2ce94825 100644
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
> @@ -1352,6 +1353,14 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
>  	*out_evlist = parsed_evlist;
>  	parsed_evlist = NULL;
>  err_out:
> +	/*
> +	 * Errors are generally cleaned up by printing, but parsing may succeed
> +	 * with intermediate unused errors being recorded.
> +	 */
> +	free(parse_error.str);
> +	free(parse_error.help);
> +	free(parse_error.first_str);
> +	free(parse_error.first_help);

Can't this be in a parse_events__free_errors() routine?

- Arnaldo

>  	evlist__delete(parsed_evlist);
>  	strbuf_release(&events);
>  	return ret;
> @@ -1481,8 +1490,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
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
