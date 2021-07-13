Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794DFC07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 09:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6135C60FF3
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 09:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhGMJfK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 05:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234884AbhGMJfK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 05:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626168740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUfa8peh4EProvCzGePhsPSlqxOJ32hePZg6qQ0HeAY=;
        b=B6AxOdHFw2bDxzbeXuAduEVJBgLwRbEiK61HZeijlH2Cd/7+E6FpSAXiWq0Up8mmShAAVr
        lb6syGcIVPXSbMqprKadZKYS0AGYoJOC2O4ZoAoNuknFLlny2STYKFyDiC9o5KjhOzKDo4
        N5Xr1Et/uZlPYzr0JasJLelGol0P+ZU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-AooILd8-MCqAEEI95gpUpQ-1; Tue, 13 Jul 2021 05:32:19 -0400
X-MC-Unique: AooILd8-MCqAEEI95gpUpQ-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so3323847wmj.8
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jul 2021 02:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PUfa8peh4EProvCzGePhsPSlqxOJ32hePZg6qQ0HeAY=;
        b=P/VbbtPnn0BmITmyup+z7cQlI65AYpfiJ08YjCeb4XFjauIs6UEz0bOtAEWagiCte4
         D9R6V2fZ55v+ieGpDqFoegHs0PZuibOaDXWwtwMNF03UEwyfcKTPNXppJItiJUfa2p3w
         18YrcK7yAAkIYXXDy/Hk3WIhTWIbr2oudhP7NhJMs9k822G7qVQfUcEZ0XOlzrZDVkh7
         K9Y1ArMLSiB+6nNmo6/T2YTakyy9gULE1YuZp/Z0o6V4Zp5eZjA5kUXfUNaTYySu35HY
         Sl8XIhHQOVB/EZ8Lwyz6odlmNUtjeRnQ+DzcGnhqakQ+5iyyrkayer0+WYOcFxL37QK+
         J3cg==
X-Gm-Message-State: AOAM531VERIjz1COb/SSUJgJYAWjLva/q14btyhbLY50AlIEc40lzcH4
        RlxweOYFwS7fCdG+REzxzsh1ztNEDRsWkAoFtmQeRIDNAqR4vl+6XMjIhZoTufRRtNqhGvrheF4
        FnL05hrS/wviHsXczKd6vraLpzmy5Uw==
X-Received: by 2002:a1c:2c43:: with SMTP id s64mr17979773wms.9.1626168737801;
        Tue, 13 Jul 2021 02:32:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMJurEW/0Q64xKOCxt5ctYrt4Wb7q6JeVABU+bbnF1ypD2SxX3hsknLvihnmJBpFjXE6U5Bg==
X-Received: by 2002:a1c:2c43:: with SMTP id s64mr17979756wms.9.1626168737628;
        Tue, 13 Jul 2021 02:32:17 -0700 (PDT)
Received: from krava ([5.171.209.239])
        by smtp.gmail.com with ESMTPSA id f13sm17510226wrt.86.2021.07.13.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:32:17 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:32:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: fix build error with LIBPFM4=1
Message-ID: <YO1dngCS/v0j3cAE@krava>
References: <20210713091907.1555560-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210713091907.1555560-1-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 11:19:07AM +0200, Heiko Carstens wrote:
> Fix build error with LIBPFM4=1:
>   CC      util/pfm.o
> util/pfm.c: In function ‘parse_libpfm_events_option’:
> util/pfm.c:102:30: error: ‘struct evsel’ has no member named ‘leader’
>   102 |                         evsel->leader = grp_leader;
>       |                              ^~
> 
> Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evsel::leader")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/pfm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index dd9ed56e0504..756295dedccc 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -99,7 +99,7 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
>  			grp_leader = evsel;
>  
>  		if (grp_evt > -1) {
> -			evsel->leader = grp_leader;
> +			evsel__set_leader(evsel, grp_leader);
>  			grp_leader->core.nr_members++;
>  			grp_evt++;
>  		}
> -- 
> 2.25.1
> 

