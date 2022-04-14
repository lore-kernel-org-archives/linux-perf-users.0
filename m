Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7222C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Apr 2022 01:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiDNBXb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbiDNBXa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 21:23:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0B150463;
        Wed, 13 Apr 2022 18:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F90CB8271B;
        Thu, 14 Apr 2022 01:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BBFC385A3;
        Thu, 14 Apr 2022 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649899260;
        bh=R03L3LDx0tIcm+BSCVo1s6eOzjl6+2OA8xlwc3fzCvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZItAT1Q+HPHZwPhbtTPEGOhnm8m9HDIXsWY1KcytYZ3U+Ue8jkdY7WJk99H8Ed9Cm
         NLCIueHCyjsLEBxRAmakIFrdyrN3jt6dEPB6qby82znZCvjInF5UiQ05ABZiM4SJKM
         H5eazO28HfvbHBDErCjj4kew6yAy4LBabfuwmdWOi5BlvVjrmdyJ/qh2CL4OVziHM5
         90vX6ruhaf1p2Jg1W5tirJbmOgNTkPPhN/T807gvFPO1J4vVkQ66UtKNu8AqAkyvum
         cBwW1jFDXpLhG9to57obHPERuEQRx0kKss80Hby76rsdhrDTyFs0qKCEllLlu3ZJR0
         fsAXzpRVQun4w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9614440407; Wed, 13 Apr 2022 22:20:56 -0300 (-03)
Date:   Wed, 13 Apr 2022 22:20:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     cgel.zte@gmail.com
Cc:     mingo@redhat.com, mark.rutland@arm.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, james.clark@arm.com,
        lv.ruyi@zte.com.cn, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] perf stat: fix error check return value of hashmap__new()
Message-ID: <Yld2+LwhYYe8XXmU@kernel.org>
References: <20220413093302.2538128-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413093302.2538128-1-lv.ruyi@zte.com.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Apr 13, 2022 at 09:33:02AM +0000, cgel.zte@gmail.com escreveu:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> hashmap__new() returns ERR_PTR(-ENOMEM) when it fails, so we should use
> IS_ERR() to check it in error handling path.

Thanks, applied.

- Arnaldo

 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  tools/perf/util/stat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index ee6f03481215..817a2de264b4 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> +#include <linux/err.h>
>  #include <inttypes.h>
>  #include <math.h>
>  #include <string.h>
> @@ -311,7 +312,7 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
>  
>  	if (!mask) {
>  		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
> -		if (!mask)
> +		if (IS_ERR(mask))
>  			return -ENOMEM;
>  
>  		counter->per_pkg_mask = mask;
> -- 
> 2.25.1

-- 

- Arnaldo
