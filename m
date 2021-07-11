Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B040C07E9B
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 07:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297B2613D0
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 07:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhGKHoO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhGKHoN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 03:44:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19B1C0613DD
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 00:41:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso8642486pjb.0
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q8/+BTIO+0DVvxXvk4fpCwXf7IRByU4eej4BjeNOtug=;
        b=qrz4z7kA6Ou/Lyvux2Y8zdF40Arf7XmZN7wMIpS+C8mtSr4Y24rWTQlgNgYfrjZK1+
         0kZtjgwnZYcDuugNCL2re2mWABM/E+GLfqkthdD5ugNR8/Lej1krvnMhv3xLhL8nWnh8
         hFosM2IhU9iqmEJILwECLMyj0pIZo0N/4zmx6cH2Np7m3O4XAwZBxvKVEJM62MtknFph
         ne4hLWm8XqC0welbdJ/KOB6RhfzjdUt65Xut+R9pUGBRd1Cmz9U1WWlA1boVVEUmePDy
         de1oPijbrWIpGCgSBzu28SzbmjeHio5seAw0JW6KMNsN19aN9JSmlpMXrCHlBL4zw6NA
         M+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q8/+BTIO+0DVvxXvk4fpCwXf7IRByU4eej4BjeNOtug=;
        b=NcD+k7VGR228OoXKY0KMwlBHB47HSSiQ3pao3irBcpbDOegG5CzSPgxXvU/IIgXbdA
         yBkA94jTmM/eWmhjZVrSjKSnPYFUMXMOzRtwXvT/r7699yFr3Em8fQyZVTJz2FWBy5Xd
         h/ofrynJg1DWwx4FxtdWqQkrwE2KOZwb6rGdz0cRsCalk6v+NH1J3+tuSpHckTkwlpvJ
         8ZdRmtGmJoH9tLn6KtM2N30LHegEuQ+CH0YtT0Zz/g3+rcetz7clBufq2Qi0SIsevINA
         A2XKwZ5YPe76neL4K5DQXu7hFbIYfaOaN63sxigYLohSfezXMXjUoXNdM77pPHX5UshT
         B+ow==
X-Gm-Message-State: AOAM532WUaTH031PNMVMxFqNc0t/L6IbtxWqXcoWKJvLGY9vHLIBLoRV
        03nTRs9uVCM+MeJ0Cn9F/ZyXIw==
X-Google-Smtp-Source: ABdhPJzfgXOWR9p6rkQjMKRFmSYi8Mz7YAFzPHFmVBKdJcybHkoPDKcRIl8Z0tqssMTkpoKAKsT8vA==
X-Received: by 2002:a17:902:dac5:b029:129:4882:6859 with SMTP id q5-20020a170902dac5b029012948826859mr38112659plx.37.1625989286344;
        Sun, 11 Jul 2021 00:41:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id q3sm12191896pfb.184.2021.07.11.00.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 00:41:25 -0700 (PDT)
Date:   Sun, 11 Jul 2021 15:41:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 05/10] perf auxtrace: Drop legacy __sync functions
Message-ID: <20210711074116.GC273828@leoy-ThinkPad-X240s>
References: <20210704071644.107397-1-leo.yan@linaro.org>
 <20210704071644.107397-6-leo.yan@linaro.org>
 <26efa59c-4bdd-b93a-7ab8-4bb270aaee93@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26efa59c-4bdd-b93a-7ab8-4bb270aaee93@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jul 10, 2021 at 03:34:24PM +0300, Adrian Hunter wrote:
> On 4/07/21 10:16 am, Leo Yan wrote:
> > The main purpose for using __sync built-in functions is to support
> > compat mode for 32-bit perf with 64-bit kernel.  But using these
> > built-in functions might cause couple potential issues.
> > 
> > Firstly, __sync functions originally support Intel Itanium processoer [1]
> > but it cannot promise to support all 32-bit archs.  Now these
> > functions have become the legacy functions.
> > 
> > As Peter also pointed out the logic issue in the function
> > auxtrace_mmap__write_tail(), it does a cmpxchg with 0 values to load
> > old_tail, and then executes a further cmpxchg with old_tail to write
> > the new tail.  If consider the aux_tail might be assigned to '0' in the
> > middle of loops, this can introduce mess for AUX buffer if the kernel
> > fetches the temporary value '0'.
> 
> That is not exactly true. The definition of __sync_*_compare_and_swap is
> "if the current value of *ptr is oldval, then write newval into *pt"
> so replacing zero with zero won't make any difference, but it will return
> the old value in any case.  Probably better to leave out that paragraph.

Okay, I admit the paragraph is not right, will drop it to avoid
confusion.  Thanks for review!

Leo
