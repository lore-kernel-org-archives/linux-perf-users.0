Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA92EC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 21:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiCVV3A (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiCVV27 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 17:28:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7C33E15;
        Tue, 22 Mar 2022 14:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58B92B81DAB;
        Tue, 22 Mar 2022 21:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FF0C340EE;
        Tue, 22 Mar 2022 21:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647984449;
        bh=UX0xmFq4usmQEKiFHg46VS8myFZOIBtqWJtLtzftZuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvSlo/wSmmTUbyz0U6H3WzS8WRIXlihCiyncxZibMXc0LnwXR4carEhvv+6tgiz6D
         9hPS8INHiaTVQm9DsR6kyyPlLd71lT8Tk/tM6r6t5IS+Vhrqos5/5itsmvjrZqBwuS
         QIxoLelpCs7k/W/SZx7aNG+A3kNK13xivT0p5HkqDOpOKFdChTSuAXA0dbeOc8R7/L
         Qiu6JjktGDCVcwNuwBnRwxv8hz3NMgywznzLHdYKuz+1742NJmjfcIgjMqzYp9Y7Wp
         a9yRo4+RO6oJHic1eX077JiovOZ78azT1XiCRjUNCPSGWsjbRM1G6VQE1v8HDvA0OD
         JZT26/bYf2ccQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74E7B40407; Tue, 22 Mar 2022 18:27:26 -0300 (-03)
Date:   Tue, 22 Mar 2022 18:27:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf header: Fix spelling mistake "could't" -> "couldn't"
Message-ID: <Yjo/PvaJQSuQ5xKA@kernel.org>
References: <20220316232212.52820-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316232212.52820-1-colin.i.king@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Mar 16, 2022 at 11:22:11PM +0000, Colin Ian King escreveu:
> There is a spelling mistake in a pr_debug2 message. Fix it.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/perf/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 6da12e522edc..4a44a0740f43 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1335,7 +1335,7 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
>  
>  	dir = opendir(path);
>  	if (!dir) {
> -		pr_debug2("%s: could't read %s, does this arch have topology information?\n",
> +		pr_debug2("%s: couldn't read %s, does this arch have topology information?\n",
>  			  __func__, path);
>  		return -1;
>  	}
> -- 
> 2.35.1

-- 

- Arnaldo
