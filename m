Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ABFC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Feb 2022 16:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbiBBQtB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:49:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233543AbiBBQs7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Feb 2022 11:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643820538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJjyxYn1wTd8xO9J4GToYMwT/Nl1bg5AsTPN3RfpdR0=;
        b=Hox6d7Voe0XAMo9UpdssBKPXrvyaWsvNDGfHbcUpZ90uGeRDDy7QEQ5idHRWE/5XKYEWeY
        xeFQWhK5WvfVaFcCNptC5hjOzFl+PP9msm4zaKniK1hS7SzPyoprt9enLTRV7NFxbzZ0GJ
        jg/h/8zXiCxTOEnjc0aHHTq2dpSil04=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-D8IJQ3LyN7u1E92FjWdvTw-1; Wed, 02 Feb 2022 11:48:57 -0500
X-MC-Unique: D8IJQ3LyN7u1E92FjWdvTw-1
Received: by mail-ed1-f69.google.com with SMTP id i22-20020a50fd16000000b00405039f2c59so3855eds.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Feb 2022 08:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJjyxYn1wTd8xO9J4GToYMwT/Nl1bg5AsTPN3RfpdR0=;
        b=6cs4Umk+suVWaJYkINYarzs31mOE7xtlJNF5c2tnXlhh8hiY2se4tDOgI2Rc2DzeIH
         +mBGEkxL1wHn5Dc928TNuggg+NeiL+/4/FRQi4bwI16yQfV6eYUOkhiqcxH4bS7lFUX0
         H7TLAxdDcMTsJ8emsMWQFXxpZxPFKmpyO2RjxPEsPGY9dZzTg6wdUiIX6SAiOYRxuOJ1
         98pOls85qPdiEVYbu+evWCHvbEuJSbfDkoe78axVz2Tne/Ua23OSid4vwXXyOolh5Lb4
         n+A+/UyiyR7L+yJ4M5hliy8FPv5pltp9FtxqLCzoZuCOpiAYAlzutbiJPpB2j8kgHW2H
         zNFw==
X-Gm-Message-State: AOAM531oUCKRe8ce1eAIXSCbNjy68+rHSH7nHLYGoLFCTKtjmCK4Mv3B
        TKAaWbpGypbzHn48h43o7OngsLYd9BjKyTbU1I0fCrWZU9h9YK01YJXD32cTNK7qZ19NZRbI1Aa
        RbTEtDFHf//sRz2yLy9WfFslC3elx4g==
X-Received: by 2002:a17:907:b01:: with SMTP id h1mr25352474ejl.728.1643820536711;
        Wed, 02 Feb 2022 08:48:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuzxK3rbHrI/RFDzLiPF+CuNteefzuWL78m/BB7C75EYNairYemffxfaSWaNMiCZ1MrtmYHw==
X-Received: by 2002:a17:907:b01:: with SMTP id h1mr25352449ejl.728.1643820536461;
        Wed, 02 Feb 2022 08:48:56 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id hh13sm16037791ejb.89.2022.02.02.08.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 08:48:55 -0800 (PST)
Date:   Wed, 2 Feb 2022 17:48:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] libperf: Add arm64 support to perf_mmap__read_self()
Message-ID: <Yfq19vtuARvlBKsz@krava>
References: <20220201214056.702854-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201214056.702854-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 01, 2022 at 03:40:56PM -0600, Rob Herring wrote:
> Add the arm64 variants for read_perf_counter() and read_timestamp().
> Unfortunately the counter number is encoded into the instruction, so the
> code is a bit verbose to enumerate all possible counters.
> 
> Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Arm64 kernel support landed in 5.17, but the corresponding libperf 
> support didn't get picked up.
> 
> v9:
>  - Rebase on v5.17-rc
>  - Add Tested-by
> v8:
>  - Set attr.config1 to request user access on arm64
> v7:
>  - Move enabling of libperf user read test for arm64 to this patch
> ---
>  tools/lib/perf/mmap.c             | 98 +++++++++++++++++++++++++++++++
>  tools/lib/perf/tests/test-evsel.c |  5 +-
>  2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index f7ee07cb5818..0d1634cedf44 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -13,6 +13,7 @@
>  #include <internal/lib.h>
>  #include <linux/kernel.h>
>  #include <linux/math64.h>
> +#include <linux/stringify.h>
>  #include "internal.h"
>  
>  void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
> @@ -294,6 +295,103 @@ static u64 read_timestamp(void)
>  
>  	return low | ((u64)high) << 32;
>  }
> +#elif defined(__aarch64__)
> +#define read_sysreg(r) ({						\
> +	u64 __val;							\
> +	asm volatile("mrs %0, " __stringify(r) : "=r" (__val));		\
> +	__val;								\
> +})

if this works on arm I don't have problem, but aat some point
we shuld add arch directory and move it there ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> +
> +static u64 read_pmccntr(void)
> +{
> +	return read_sysreg(pmccntr_el0);
> +}
> +
> +#define PMEVCNTR_READ(idx)					\
> +	static u64 read_pmevcntr_##idx(void) {			\
> +		return read_sysreg(pmevcntr##idx##_el0);	\
> +	}
> +
> +PMEVCNTR_READ(0);
> +PMEVCNTR_READ(1);
> +PMEVCNTR_READ(2);
> +PMEVCNTR_READ(3);
> +PMEVCNTR_READ(4);
> +PMEVCNTR_READ(5);
> +PMEVCNTR_READ(6);
> +PMEVCNTR_READ(7);
> +PMEVCNTR_READ(8);
> +PMEVCNTR_READ(9);
> +PMEVCNTR_READ(10);
> +PMEVCNTR_READ(11);
> +PMEVCNTR_READ(12);
> +PMEVCNTR_READ(13);
> +PMEVCNTR_READ(14);
> +PMEVCNTR_READ(15);
> +PMEVCNTR_READ(16);
> +PMEVCNTR_READ(17);
> +PMEVCNTR_READ(18);
> +PMEVCNTR_READ(19);
> +PMEVCNTR_READ(20);
> +PMEVCNTR_READ(21);
> +PMEVCNTR_READ(22);
> +PMEVCNTR_READ(23);
> +PMEVCNTR_READ(24);
> +PMEVCNTR_READ(25);
> +PMEVCNTR_READ(26);
> +PMEVCNTR_READ(27);
> +PMEVCNTR_READ(28);
> +PMEVCNTR_READ(29);
> +PMEVCNTR_READ(30);
> +
> +/*
> + * Read a value direct from PMEVCNTR<idx>
> + */
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +	static u64 (* const read_f[])(void) = {
> +		read_pmevcntr_0,
> +		read_pmevcntr_1,
> +		read_pmevcntr_2,
> +		read_pmevcntr_3,
> +		read_pmevcntr_4,
> +		read_pmevcntr_5,
> +		read_pmevcntr_6,
> +		read_pmevcntr_7,
> +		read_pmevcntr_8,
> +		read_pmevcntr_9,
> +		read_pmevcntr_10,
> +		read_pmevcntr_11,
> +		read_pmevcntr_13,
> +		read_pmevcntr_12,
> +		read_pmevcntr_14,
> +		read_pmevcntr_15,
> +		read_pmevcntr_16,
> +		read_pmevcntr_17,
> +		read_pmevcntr_18,
> +		read_pmevcntr_19,
> +		read_pmevcntr_20,
> +		read_pmevcntr_21,
> +		read_pmevcntr_22,
> +		read_pmevcntr_23,
> +		read_pmevcntr_24,
> +		read_pmevcntr_25,
> +		read_pmevcntr_26,
> +		read_pmevcntr_27,
> +		read_pmevcntr_28,
> +		read_pmevcntr_29,
> +		read_pmevcntr_30,
> +		read_pmccntr
> +	};
> +
> +	if (counter < ARRAY_SIZE(read_f))
> +		return (read_f[counter])();
> +
> +	return 0;
> +}
> +
> +static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
> +
>  #else
>  static u64 read_perf_counter(unsigned int counter __maybe_unused) { return 0; }
>  static u64 read_timestamp(void) { return 0; }
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index 33ae9334861a..89be89afb24d 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -130,6 +130,9 @@ static int test_stat_user_read(int event)
>  	struct perf_event_attr attr = {
>  		.type	= PERF_TYPE_HARDWARE,
>  		.config	= event,
> +#ifdef __aarch64__
> +		.config1 = 0x2,		/* Request user access */
> +#endif
>  	};
>  	int err, i;
>  
> @@ -150,7 +153,7 @@ static int test_stat_user_read(int event)
>  	pc = perf_evsel__mmap_base(evsel, 0, 0);
>  	__T("failed to get mmapped address", pc);
>  
> -#if defined(__i386__) || defined(__x86_64__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
>  	__T("userspace counter access not supported", pc->cap_user_rdpmc);
>  	__T("userspace counter access not enabled", pc->index);
>  	__T("userspace counter width not set", pc->pmc_width >= 32);
> -- 
> 2.32.0
> 

