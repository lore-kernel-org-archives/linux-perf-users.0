Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FBEC2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E081E61350
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhFVSSz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232349AbhFVSSy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 14:18:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 740C0611CE;
        Tue, 22 Jun 2021 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624385798;
        bh=JAMdsykgcT5RqLIM5MWPjgi0SQ1smTTJA7rx1s9zrgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwStD5ntrIEzoxIcbNrPccOuV7/lOR+56M3FzF5hHbc9gP9AERH+PYahVQ9JjOnr0
         g5IlVmhQr+xgEbHdQOdJu8Jn+C0dnatYnqbLZfFt4KnQ7148l6IGNd+75jxg4YM9dd
         6UIHyqzhxw1lnfPK6Kp2JPA98CoCjP7K5wHjsAVlFO/tD7A24tmiTXAQYbf+ger6MF
         1PpfpISN+tVeaXuy+uj2L7x2/041631pQdA3U3718CKaJ2ObbgUKGYBexANGxtKIdQ
         RjXvXim+ETavnwnpsX2x1IKBoqKNxlAKZ7DpVtJfdWolTcs6J//3faSv5PkfVstX5M
         1qvQO+SLqGvoQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B63B840B1A; Tue, 22 Jun 2021 15:16:35 -0300 (-03)
Date:   Tue, 22 Jun 2021 15:16:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 01/11] perf script: Move filter_cpu() earlier
Message-ID: <YNIpAzBWoY8n9Z1g@kernel.org>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
 <20210621150514.32159-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621150514.32159-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jun 21, 2021 at 06:05:04PM +0300, Adrian Hunter escreveu:
> Generally, it should be more efficient if filter_cpu() comes before
> machine__resolve() because filter_cpu() is much less code than
> machine__resolve().

Simple patch, I like it, applied.

- Arnaldo
 
> Example:
> 
>  $ perf record --sample-cpu -- make -C tools/perf >/dev/null
> 
> Before:
> 
>  $ perf stat -- perf script -C 0 >/dev/null
> 
>   Performance counter stats for 'perf script -C 0':
> 
>             116.94 msec task-clock                #    0.992 CPUs utilized
>                  2      context-switches          #   17.103 /sec
>                  0      cpu-migrations            #    0.000 /sec
>              8,187      page-faults               #   70.011 K/sec
>        478,351,812      cycles                    #    4.091 GHz
>        564,785,464      instructions              #    1.18  insn per cycle
>        114,341,105      branches                  #  977.789 M/sec
>          2,615,495      branch-misses             #    2.29% of all branches
> 
>        0.117840576 seconds time elapsed
> 
>        0.085040000 seconds user
>        0.032396000 seconds sys
> 
> After:
> 
>  $ perf stat -- perf script -C 0 >/dev/null
> 
>   Performance counter stats for 'perf script -C 0':
> 
>             107.45 msec task-clock                #    0.992 CPUs utilized
>                  3      context-switches          #   27.919 /sec
>                  0      cpu-migrations            #    0.000 /sec
>              7,964      page-faults               #   74.117 K/sec
>        438,417,260      cycles                    #    4.080 GHz
>        522,571,855      instructions              #    1.19  insn per cycle
>        105,187,488      branches                  #  978.921 M/sec
>          2,356,261      branch-misses             #    2.24% of all branches
> 
>        0.108282546 seconds time elapsed
> 
>        0.095935000 seconds user
>        0.011991000 seconds sys
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-script.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 57488d60b64a..08a2b5d51018 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2191,6 +2191,9 @@ static int process_sample_event(struct perf_tool *tool,
>  		return 0;
>  	}
>  
> +	if (filter_cpu(sample))
> +		return 0;
> +
>  	if (machine__resolve(machine, &al, sample) < 0) {
>  		pr_err("problem processing %d event, skipping it.\n",
>  		       event->header.type);
> @@ -2200,9 +2203,6 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (al.filtered)
>  		goto out_put;
>  
> -	if (filter_cpu(sample))
> -		goto out_put;
> -
>  	if (scripting_ops) {
>  		struct addr_location *addr_al_ptr = NULL;
>  		struct addr_location addr_al;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
