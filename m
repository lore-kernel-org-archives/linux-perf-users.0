Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F019C48BE5
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Jun 2021 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC023613DA
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Jun 2021 18:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhFPSIE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Jun 2021 14:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbhFPSID (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Jun 2021 14:08:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE864613D8;
        Wed, 16 Jun 2021 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623866757;
        bh=zIihtJW0A4Iii4kqz2VVhtQTU6JCggG1ni/MMYKXYb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCOs/s0tmQ02fLtkLrFaTFY4AZXFfroIPR/IQn1DAo6UrMXIFKXnxsQycX5fBrtPG
         l/74eMfO1PFoawvDmsP3FTVIdsI5li6bk2SlQaAzkKwQziYD3haxCL4WZIC5c+euLy
         lDbJ9UyEQfdAZFFTzqDEy7A6MgJlu8dPJYVh+VovDjAHXx3vR0J36RwEIfeatU4/R1
         MwsMs+khsQpXEHDh+a1rX/yUgkNIyXpJ4fq4ztn3youS8YcgMDxE7H529R5K4KLrhk
         rJht/3RIL2zzt+8HIfi6MFTBv+eR4h2PC0n+S5f+CWTvkMjrJaVeYJo8b3K92f1MnI
         Mgi+Ai+t7r0Xw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EF1B140B1A; Wed, 16 Jun 2021 15:05:53 -0300 (-03)
Date:   Wed, 16 Jun 2021 15:05:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjinhao2@huawei.com
Subject: Re: [PATCH -next] perf tools: Remove duplicate #undef
Message-ID: <YMo9gSGaZAY82uPd@kernel.org>
References: <20210616120339.219807-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616120339.219807-1-lihuafei1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jun 16, 2021 at 08:03:39PM +0800, Li Huafei escreveu:
> Remove duplicate '#undef E'.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/util/mem-events.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index f93a852ad838..91e6d61fed46 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -24,8 +24,6 @@ static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
>  };
>  #undef E
>  
> -#undef E
> -
>  static char mem_loads_name[100];
>  static bool mem_loads_name__init;
>  
> -- 
> 2.17.1
> 

-- 

- Arnaldo
