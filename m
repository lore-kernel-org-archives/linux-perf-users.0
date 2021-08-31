Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D5C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA3960234
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhHaT0A (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231952AbhHaT0A (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:26:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D26F61041;
        Tue, 31 Aug 2021 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630437904;
        bh=LfTYo29aM8dEHYTzt+wGMSKyqaEeeay0p+2H1UYZ30c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ib9VzZNveg+hsvzL/JD6x5/M7xGvAuvxiaLDW+1jn5cH2+jZnpQDMAZuSf9LfaNH/
         o4cQbgmANz+9SeYrQmA0/HUb9W/MUsJBN+AwTAme2tL9lWJoBzc22lq6/C501pR3MK
         r0pw3c2xAlfBLNCe//MLtNNTSe7FXVHHbpvWWWKpXMe89xdTFCECdumqfZUyfjavPZ
         I9Vl/Y9f7RpB1WRYG2MvuAn/8uKKMeFMb3PkxTrsgWFpZURNzQ80dJD7a4KBaNeYFd
         VWy5HobBZAqBuvFyAQg8F7yHKRkkFjCkMRXx3fVy68OTalDS3DU5sF8ni/lFls+S0M
         9ZOa6X5NDhowA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE65B4007E; Tue, 31 Aug 2021 16:25:01 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:25:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 14/37] perf evsel: remove retry_sample_id goto
 label
Message-ID: <YS6CDRKiZ7CpVZYD@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <340af0d03408d6621fd9c742e311db18b3585b3b.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340af0d03408d6621fd9c742e311db18b3585b3b.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:20AM +0200, Riccardo Mancini escreveu:
> As far as I can tell, there is no good reason, apart from optimization
> to have the retry_sample_id separate from fallback_missing_features.
> Probably, this label was added to avoid reapplying patches for missing
> features that had already been applied.
> However, missing features that have been added later have not used this
> optimization, always jumping to fallback_missing_features and reapplying
> all missing features.
> 
> This patch removes that label, replacing it with
> fallback_missing_features.

Fair enough, applied,

- Arnaldo
 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f61e5dd53f5d2859..7b4bb3229a16524e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1825,7 +1825,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		evsel->core.attr.bpf_event = 0;
>  	if (perf_missing_features.branch_hw_idx)
>  		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
> -retry_sample_id:
>  	if (perf_missing_features.sample_id_all)
>  		evsel->core.attr.sample_id_all = 0;
>  
> @@ -2006,7 +2005,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	} else if (!perf_missing_features.sample_id_all) {
>  		perf_missing_features.sample_id_all = true;
>  		pr_debug2_peo("switching off sample_id_all\n");
> -		goto retry_sample_id;
> +		goto fallback_missing_features;
>  	} else if (!perf_missing_features.lbr_flags &&
>  			(evsel->core.attr.branch_sample_type &
>  			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
> -- 
> 2.31.1

-- 

- Arnaldo
