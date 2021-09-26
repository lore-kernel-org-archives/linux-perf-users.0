Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93981C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 21:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A8960F70
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 21:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhIZVN7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 26 Sep 2021 17:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhIZVN7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 26 Sep 2021 17:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632690742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oTs7zwS2QXAnnsmmd+Pil13HIG5rYgAh/iri/slOgj4=;
        b=Zb1rBvjv2z0VByv3b0aAea0WibPaAhY6W1v5T5c9BR/qjWIELFuZ5YpDVTorh6mWGwvWBh
        T7S6/TPFjR6DY7ldjG09M7kaZBI2NhYJibcG849cZN46IZzCsXFJ7zptAmPFZTmDaYD4G3
        taW7LD/1RcVSa2XHcg2LSlcUkpAPT3c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-15qclxgQPCaI6-gZ5VJxPg-1; Sun, 26 Sep 2021 17:12:21 -0400
X-MC-Unique: 15qclxgQPCaI6-gZ5VJxPg-1
Received: by mail-ed1-f70.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so15524367edy.14
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Sep 2021 14:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTs7zwS2QXAnnsmmd+Pil13HIG5rYgAh/iri/slOgj4=;
        b=1DbrqGgUVbv60IOZKkRiFbv0bi7bxsS9/RK8U/bJvHNE3CwgbNVn7Qzp/D7vK9bm1g
         xnTWGAUR/KWZFH1bWuvZfffvmY/vhidSQItY6Q60pIALEhP1n8iDF/ZfplKG+KjYuNaG
         cEW1u2FwEbWubrjPLPfrz6cYgLr+2ZPADg6JQY7bqVsJRdim/rTWvEGuN5sgJsnnbtbI
         oyrnpgTxApib24lbaw+s13+BoqqK4OUBjRRBCMJNEO0oBcVSzshNKuSkrGYIcnU4p5Zb
         ab4QFXT1yzM86Jhc2hyyaQpUzr/dKOdA7wh4qm5zUypkzDB4e/K+AlhpXVOhaBWd77BZ
         cl3Q==
X-Gm-Message-State: AOAM532giPBZqaTcm8vJbGzfGJ0ljyMtAl2L3GBkpJQeJ8Ks2sBee27Z
        EkFrWgiRFuKI6S7PAeFQqMPjIzBVoNuqlOSkPjyjztl1jA1oHJcEavxyZAbSCU437cRncL22gDX
        IKEQSzDpN/re1rMM24ekt8P6w1Sz+OQ==
X-Received: by 2002:a50:e041:: with SMTP id g1mr14706547edl.4.1632690739731;
        Sun, 26 Sep 2021 14:12:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7qdAFDMCvXRUwRxhal00rkDxsBjS41mQJYyBEZZpvTTBIpGFJkMG8kXzAvBkgn1743NjZ2w==
X-Received: by 2002:a50:e041:: with SMTP id g1mr14706534edl.4.1632690739579;
        Sun, 26 Sep 2021 14:12:19 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id m12sm9150271edr.24.2021.09.26.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 14:12:19 -0700 (PDT)
Date:   Sun, 26 Sep 2021 23:12:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Subject: Re: [RFC PATCH 3/5] perf test: Make each test/suite its own struct.
Message-ID: <YVDiMDoD2dr312KY@krava>
References: <20210922081959.390059-1-irogers@google.com>
 <20210922081959.390059-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922081959.390059-4-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 22, 2021 at 01:19:56AM -0700, Ian Rogers wrote:
> By switching to an array of pointers to tests (later to be suites)
> the definition of the tests can be moved to the file containing the
> tests.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm/include/arch-tests.h     |   2 +-
>  tools/perf/arch/arm/tests/arch-tests.c       |  21 +-
>  tools/perf/arch/arm64/include/arch-tests.h   |   2 +-
>  tools/perf/arch/arm64/tests/arch-tests.c     |  15 +-
>  tools/perf/arch/powerpc/include/arch-tests.h |   2 +-
>  tools/perf/arch/powerpc/tests/arch-tests.c   |  15 +-
>  tools/perf/arch/x86/include/arch-tests.h     |   2 +-
>  tools/perf/arch/x86/tests/arch-tests.c       |  47 ++--
>  tools/perf/tests/builtin-test.c              | 273 ++++++++++++-------
>  tools/perf/tests/tests.h                     |   6 +
>  10 files changed, 220 insertions(+), 165 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
> index c62538052404..37039e80f18b 100644
> --- a/tools/perf/arch/arm/include/arch-tests.h
> +++ b/tools/perf/arch/arm/include/arch-tests.h
> @@ -2,6 +2,6 @@
>  #ifndef ARCH_TESTS_H
>  #define ARCH_TESTS_H
>  
> -extern struct test arch_tests[];
> +extern struct test *arch_tests[];
>  
>  #endif
> diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
> index 6848101a855f..4374b0293177 100644
> --- a/tools/perf/arch/arm/tests/arch-tests.c
> +++ b/tools/perf/arch/arm/tests/arch-tests.c
> @@ -3,18 +3,15 @@
>  #include "tests/tests.h"
>  #include "arch-tests.h"
>  
> -struct test arch_tests[] = {
>  #ifdef HAVE_DWARF_UNWIND_SUPPORT
> -	{
> -		.desc = "DWARF unwind",
> -		.func = test__dwarf_unwind,
> -	},
> +DEFINE_SUITE("DWARF unwind", dwarf_unwind);

why not having this and other in here DEFINE_SUITE in
tests/dwarf-unwind.c ? it seems to get compiled in only
for supported arch

jirka

>  #endif
> -	{
> -		.desc = "Vectors page",
> -		.func = test__vectors_page,
> -	},
> -	{
> -		.func = NULL,
> -	},
> +DEFINE_SUITE("Vectors page", vectors_page);
> +
> +struct test *arch_tests[] = {
> +#ifdef HAVE_DWARF_UNWIND_SUPPORT
> +	&dwarf_unwind,
> +#endif
> +	&vectors_pages,
> +	NULL,
>  };

SNIP

