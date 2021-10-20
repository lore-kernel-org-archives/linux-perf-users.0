Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D158EC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B309B610CB
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJTN0k (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhJTN0k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 09:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634736264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcpzAnNHjm23kN2uqigubTKcRaFFegqSoAGf8LIkgeI=;
        b=LYvq6Uo6SS2cSLT7123qDG9ir6RgNOIJbEOi5olTDINfWx+UF6cb70ZeA/IsiLGbS9ixuG
        TlLix5tebL4iYo4rm7PJDhh9zViRignbAKZrkPCoFf+A2nhbQEngkLr4JsruNuY3PIba6N
        dd5yQdo/zmKk8Lh1OpO5zpyjSluh4sU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-5hQ5x-fxN5KYv_Dt0h-KtA-1; Wed, 20 Oct 2021 09:24:23 -0400
X-MC-Unique: 5hQ5x-fxN5KYv_Dt0h-KtA-1
Received: by mail-ed1-f71.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso20968356edf.7
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 06:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GcpzAnNHjm23kN2uqigubTKcRaFFegqSoAGf8LIkgeI=;
        b=l5uRsXXKQsChPFlKZneKd3zJkx+ja/bJaAE3/2uQ6r3KqD9qP9J6vyGC5tSdC4Q/T6
         1KWNLl0r1MzZVZQt8/GfWf3XrrJXPuuO9GBGgBb/azkxOeaS3Ske6N4bh1+F+ZRXlBRL
         1TgdCNl5BR77vDoO0jmiLDuE6Tz6uD61MRFoRz2t59soNkmhTRuQwaiAtWBj28rCAcHX
         jVUpY3Ql5IkZGGpkmTPEbuluvsBsDlsVwDwK8YP3O92yKzvyiGQRxykZgL7YHJJjV38y
         msGyut2GT9eD9Ztu5m2KrPzh31fXe4Rw3q0GH/jafWJY40+4Nuxr5zSBAPa3ohYPWymW
         nOdg==
X-Gm-Message-State: AOAM5307PhaGRFGHT92T8pLr1f5B8vjyPXJW50piQD5jIxhsafYYHAPO
        xkUQReZyqs8inogTNyZV0jc+vlWMqnLLFaUj6+IYb7NrQEWI4EJvSppPXWlDYobavzexM3ozXPL
        pidGa4w5X8IeOf2o26iSmPgYyBLIRHQ==
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr62501162ede.169.1634736262084;
        Wed, 20 Oct 2021 06:24:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVW+LAoHPzviyKRL0KsI2xrRCoci0hduDBTl5iwSEDG3IMqePK/Z2vDw19wC+rX4UbPj8O5w==
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr62501139ede.169.1634736261861;
        Wed, 20 Oct 2021 06:24:21 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id d4sm1205734edk.78.2021.10.20.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:24:21 -0700 (PDT)
Date:   Wed, 20 Oct 2021 15:24:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Lexi Shao <shaolexi@huawei.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, qiuxi1@huawei.com, nixiaoming@huawei.com,
        wangbing6@huawei.com
Subject: Re: [PATCH] perf script: Show binary offsets for userspace addr
Message-ID: <YXAYg8N1vikCsOnU@krava>
References: <20211019072417.122576-1-shaolexi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019072417.122576-1-shaolexi@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Oct 19, 2021 at 03:24:17PM +0800, Lexi Shao wrote:
> Show binary offsets for userspace addr with map in perf script output
> with callchain.
> 
> In commit 19610184693c("perf script: Show virtual addresses instead of
> offsets"), the addr shown in perf script output with callchain is changed
> from binary offsets to virtual address to fix the incorrectness when
> displaying symbol offset.
> 
> This is inconvenient in scenario that the binary is stripped and
> symbol cannot be resolved. If someone wants to further resolve symbols for
> specific binaries later, he would need an extra step to translate virtual
> address to binary offset with mapping information recorded in perf.data,
> which can be difficult for people not familiar with perf.
> 
> This patch modifies function sample__fprintf_callchain to print binary
> offset for userspace addr with dsos, and virtual address otherwise. It
> does not affect symbol offset calculation so symoff remains correct.
> 
> Before applying this patch:
> test  1512    78.711307:     533129 cycles:
> 	aaaae0da07f4 [unknown] (/tmp/test)
> 	aaaae0da0704 [unknown] (/tmp/test)
> 	ffffbe9f7ef4 __libc_start_main+0xe4 (/lib64/libc-2.31.so)
> 
> After this patch:
> test  1519   111.330127:     406953 cycles:
> 	7f4 [unknown] (/tmp/test)
> 	704 [unknown] (/tmp/test)
> 	20ef4 __libc_start_main+0xe4 (/lib64/libc-2.31.so)
> 
> Fixes: 19610184693c("perf script: Show virtual addresses instead of offsets")
> 
> Signed-off-by: Lexi Shao <shaolexi@huawei.com>

makes sense to me

Acked-/Tested-by Jiri Olsa <jolsa@redhat.com>

should we have a way to display these callchain detail in perf report output as well?

thanks,
jirka

> ---
>  tools/perf/util/evsel_fprintf.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index bfedd7b23521..8c2ea8001329 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -11,6 +11,7 @@
>  #include "strlist.h"
>  #include "symbol.h"
>  #include "srcline.h"
> +#include "dso.h"
>  
>  static int comma_fprintf(FILE *fp, bool *first, const char *fmt, ...)
>  {
> @@ -144,12 +145,17 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			if (print_arrow && !first)
>  				printed += fprintf(fp, " <-");
>  
> -			if (print_ip)
> -				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
> -
>  			if (map)
>  				addr = map->map_ip(map, node->ip);
>  
> +			if (print_ip) {
> +				/* Show binary offset for userspace addr */
> +				if (map && !map->dso->kernel)
> +					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
> +				else
> +					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
> +			}
> +
>  			if (print_sym) {
>  				printed += fprintf(fp, " ");
>  				node_al.addr = addr;
> -- 
> 2.12.3
> 

