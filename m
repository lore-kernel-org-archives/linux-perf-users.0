Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA64C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Oct 2022 15:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJNPX3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJNPXN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Oct 2022 11:23:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30906F70B3
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2022 08:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65FF1B82362
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2022 15:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7E6C433C1;
        Fri, 14 Oct 2022 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665760935;
        bh=I9x8qC882p0JFX9cKwzcy66ZvQdWvTCjRABKjKhxjMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QB73Xqe8d1fJTHv9mlRCQnJ4sc/kVYW23Ut72cYVfgIRvWia2c6aEAf9wJ+VJu+gL
         aXAd7oRWvphfZUaNQmTu+1i/OPNa4Qj1Xon0xBHP56VgGT50XvIX0+0DuWJSEnHgbv
         2wgNQLVqLio6ZFHX36X9JmXlWUBy4X1jH0Wd00OSOmZ8G8aZpEiGuwjkoR7gb6YkTh
         Ri0iQRnzYY2i2Zpk5yJ+SzqG+mOTBPmmITwdpMNbW9+3zL9cD8Y7BtnN+mVVrKJYIF
         OmUypxb/b8S/WKIsqmPNpbIJ19lLgUlocGHKc4mvdEj3VAsyKAZpL8GOffy5Ikn93k
         lrMUAAAZlhjuA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CCD804062C; Fri, 14 Oct 2022 12:22:12 -0300 (-03)
Date:   Fri, 14 Oct 2022 12:22:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf list: Fix title message
Message-ID: <Y0l+pNuWrIZVt3ZI@kernel.org>
References: <20221004192634.998984-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004192634.998984-1-ak@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Oct 04, 2022 at 12:26:34PM -0700, Andi Kleen escreveu:
> perf list metricgroups
> 
> gives
> 
> List of pre-defined events (to be used in -e):
> 
> Metric Groups:
> 
> Backend
> Bad
> BadSpec
> 
> But that's incorrect of course because metric groups or metrics can only
> be specified with -M. So fix the message to say -e or -M

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 744dd3520584..58e1ec1654ef 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -60,7 +60,7 @@ int cmd_list(int argc, const char **argv)
>  	setup_pager();
>  
>  	if (!raw_dump && pager_in_use())
> -		printf("\nList of pre-defined events (to be used in -e):\n\n");
> +		printf("\nList of pre-defined events (to be used in -e or -M):\n\n");
>  
>  	if (hybrid_type) {
>  		pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_type);
> -- 
> 2.37.2

-- 

- Arnaldo
