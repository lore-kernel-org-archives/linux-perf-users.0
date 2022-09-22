Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0519AECAAD8
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 19:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiIVTzR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiIVTzJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 15:55:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA229B879
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 12:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5509B637CA
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 19:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A35BC433C1;
        Thu, 22 Sep 2022 19:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663876496;
        bh=49OUB7Fg3oQcqOEj1akcJMhWC2c6qH01oHzhP9zOW1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5YOWjkVaeYXmW1jD8hDyVsYqqbX7C4mjSbgdb4SfK1Qn7dHtaCQoQUjCJpwbOlY5
         23Y246+448LHLn/Rh1Ugox/BnMvw3RkxzxirGGLYd5bOavgvGdgfhpeft7/v6uHvFk
         20LUXNw5JH0gOsKCmNXRnzCN/L7TWsPr8zpaZcSP6MhTXR9bEObFM8KrlcGQGfl6EF
         26i0MVqlKFUJgb6xKSjCvauhpbNGRWInfMyAuBPf9YDMj/cRZA9pNoZQQaoqPZSVAY
         vaO/0Q35CM6mhPWSFSi6UBHvPxhZbRXp9Ml1jyzz8/QExIlOP4tNSfAcw8zIiYKSr6
         /wvdivOb4U2bg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C27D3403B0; Thu, 22 Sep 2022 20:54:53 +0100 (IST)
Date:   Thu, 22 Sep 2022 20:54:53 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf stat: Clean redundant if in process_evlist
Message-ID: <Yyy9jX5vlnUaDa/G@kernel.org>
References: <20220922141438.22487-1-shangxiaojing@huawei.com>
 <20220922141438.22487-5-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922141438.22487-5-shangxiaojing@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 22, 2022 at 10:14:38PM +0800, Shang XiaoJing escreveu:
> Since the first if statment is covered by the following one, clean up
> the first if statment.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  tools/perf/builtin-stat.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e10595f649bc..ccea5d1e053a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -899,8 +899,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
>  			counter = evlist_cpu_itr.evsel;
>  
> -			if (!counter->reset_group && !counter->errored)
> -				continue;
>  			if (!counter->reset_group)
>  				continue;

Ian, can you please take a look at this one? You added this in:

commit 472832d2c000b9611feaea66fe521055c3dbf17a
Author: Ian Rogers <irogers@google.com>
Date:   Tue Jan 4 22:13:37 2022 -0800

    perf evlist: Refactor evlist__for_each_cpu()

>  try_again_reset:
> -- 
> 2.17.1


- Arnaldo
