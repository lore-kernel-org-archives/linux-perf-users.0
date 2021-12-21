Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A6C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Dec 2021 08:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhLUI3t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Dec 2021 03:29:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235580AbhLUI3s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Dec 2021 03:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640075388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1W8wUPzbCrAk3S6JCr16h2JbAhwXYjogBXl0aWQ+aYA=;
        b=dHUyw7DZaPWihLfuqLyc0dZr1cFbew7sU4vqSP0Rncu3B7qiUB6gKb2HkUy87o2Ly2EIgn
        9KfQyshi4ztm0XAqV8RMarWFsMZrCt7WXLkbf8AjN+1gzc+L7lBybeFpCDFK98IQDYxLGC
        j9cTDUv4Da5J6u2lwvQsuRmWKEfyhTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-uo1mVwAhNJqsCvbLon6a4w-1; Tue, 21 Dec 2021 03:29:43 -0500
X-MC-Unique: uo1mVwAhNJqsCvbLon6a4w-1
Received: by mail-wm1-f72.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso916066wme.8
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Dec 2021 00:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1W8wUPzbCrAk3S6JCr16h2JbAhwXYjogBXl0aWQ+aYA=;
        b=KL5LLCfXNz51KKufk8an3qwnOIBtFNNQa7pLgkKE4Hw6uvX6coTh3xgLkWJDBGfKww
         oATUspGPK0b8sWqUEWbLqB9mxBSJ3vHFAgRS0HjbgTFxsltnGL7zjd6RjqNEk8wMRH+h
         +Ye2MHVKMq3GGDB3NBAyT0xDVqR4Lsgj9Lg2slhtvHVzJJhB+JQP731CxMGVoqQyKQQ6
         6h/dBBpj5FDHqVLRqPDzEVZ+dEaWCvbMl7nArW8nsZoKpntLyajGdWrce9SWgnLNfEft
         7RuNzWfJHCcq2B7UVrABg/ixXURN3oawtFzsmr85x6inEC5I6aVjkXoVS4wXGGGwlBj5
         RIuw==
X-Gm-Message-State: AOAM532GsrGQqKC7lnx5LEPzkWZs4+4jd503N+aoypPT9Y/DNBGlgENP
        y55pTsQ474iM8H6bX6+m4lWnfrQuX1Mu7WpIMaSWFsLbOm2fBVsGoIASPsZ4h1i0VouZo2HS8dX
        zwiOIri/V33fgRi8bVSLkbZVSpDV4FQ==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr1589681wru.397.1640075382632;
        Tue, 21 Dec 2021 00:29:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUJYDFM/617lziZE38H9pnQj4BM0jN9B5H2PlbUCKbwrgOCkxAXXoYFP0QilZjvohv3vUfaw==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr1589672wru.397.1640075382492;
        Tue, 21 Dec 2021 00:29:42 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id b2sm9895293wrd.35.2021.12.21.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 00:29:42 -0800 (PST)
Date:   Tue, 21 Dec 2021 09:29:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf expr: Fix return value of ids__new
Message-ID: <YcGQdFQ7tjdiFoJ5@krava>
References: <20211214011030.20200-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214011030.20200-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Dec 14, 2021 at 01:10:27AM +0000, Miaoqian Lin wrote:
> callers of ids__new() function only do NULL checking for the return
> value. ids__new() calles hashmap__new(), which may return
> ERR_PTR(-ENOMEM). Instead of changing the checking one-by-one.
> return NULL instead of ERR_PTR(-ENOMEM) to keep
> consistent.
> 
> ---
> Changes in v3:
> fix compilation error and add tags.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Tested-by: German Gomez <german.gomez@arm.com>
> Reviewed-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/expr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 1d532b9fed29..f225247acc01 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -12,6 +12,7 @@
>  #include "expr-bison.h"
>  #include "expr-flex.h"
>  #include "smt.h"
> +#include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include <ctype.h>
> @@ -65,7 +66,12 @@ static bool key_equal(const void *key1, const void *key2,
>  
>  struct hashmap *ids__new(void)
>  {
> -	return hashmap__new(key_hash, key_equal, NULL);
> +	struct hashmap *hash;
> +
> +	hash = hashmap__new(key_hash, key_equal, NULL);
> +	if (IS_ERR(hash))
> +		return NULL;
> +	return hash;
>  }
>  
>  void ids__free(struct hashmap *ids)
> -- 
> 2.17.1
> 

