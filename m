Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0326CC43460
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 May 2021 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CFD61106
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 May 2021 13:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhEFNdR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 May 2021 09:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234106AbhEFNdR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 May 2021 09:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620307938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QR+VFmQanOLc8acTpLhJwPk0qO2xnMjuAmazbsWfrfM=;
        b=T5vm+RD0wyqS1jIBtIvV8ATg6dukK2ag6CD0D1shQceGpSxJ3A6XNMfk26zDgkpjA0mVQT
        fjsDURUVvIPSbUgtz3IoB4BkeQ/nbDmjLLPL7+Hl/swGAy0FFFB88G6AXGSjUT/8aCNJtS
        fbCvZJCYDfAOl+ZvBsObKUNRRSJl51Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-IolX54RbOXWn1jr5JnHCtg-1; Thu, 06 May 2021 09:32:15 -0400
X-MC-Unique: IolX54RbOXWn1jr5JnHCtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 829B41926DA6;
        Thu,  6 May 2021 13:32:13 +0000 (UTC)
Received: from krava (unknown [10.40.193.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1EFB861F55;
        Thu,  6 May 2021 13:32:10 +0000 (UTC)
Date:   Thu, 6 May 2021 15:32:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Dmitry Koshelev <karaghiozis@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Fix swapping of cpu_map and stat_config records
Message-ID: <YJPv2u6NBuYX9FUX@krava>
References: <20210506131244.13328-1-karaghiozis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506131244.13328-1-karaghiozis@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 06, 2021 at 01:11:49PM +0000, Dmitry Koshelev wrote:
> 'data' field in perf_record_cpu_map_data struct is 16-bit
> wide and so should be swapped using bswap_16().
> 
> 'nr' field in perf_record_stat_config struct should be
> swapped before being used for size calculation.
> 
> Signed-off-by: Dmitry Koshelev <karaghiozis@gmail.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/session.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index a12cf4f0e97a..106b3d60881a 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -904,7 +904,7 @@ static void perf_event__cpu_map_swap(union perf_event *event,
>  	struct perf_record_record_cpu_map *mask;
>  	unsigned i;
>  
> -	data->type = bswap_64(data->type);
> +	data->type = bswap_16(data->type);
>  
>  	switch (data->type) {
>  	case PERF_CPU_MAP__CPUS:
> @@ -937,7 +937,7 @@ static void perf_event__stat_config_swap(union perf_event *event,
>  {
>  	u64 size;
>  
> -	size  = event->stat_config.nr * sizeof(event->stat_config.data[0]);
> +	size  = bswap_64(event->stat_config.nr) * sizeof(event->stat_config.data[0]);
>  	size += 1; /* nr item itself */
>  	mem_bswap_64(&event->stat_config.nr, size);
>  }
> -- 
> 2.25.1
> 

