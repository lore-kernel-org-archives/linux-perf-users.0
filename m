Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2802C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09CD6128B
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhGMPMy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbhGMPMx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 11:12:53 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A3C0613DD
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jul 2021 08:10:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id a2so21882093pgi.6
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jul 2021 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PEphENIqEyKhL/8vOm7zNFilpyK8f33jXcN4DaEjc2E=;
        b=EXAEe4csOT80SdiCKNgHT46eobGgV+YDBtIe6/u3Xo/HmTQzWh9Jnlvm9qir8OwFn+
         4tpn2xXg9AtU3lQdLMQ/VlqUUoIFOjOd1Wdw5pm++nZ5RhbW9EST/nrGI193qtA1yqnz
         mCMEdYx94mnWQuORAMH6hOKXzJ3TnLWpgSxL8zcYLNGGEHFYYkZ+eh4EbE5SXWdhy4nD
         4c16wHM+TmuYQjW6nZu0T3y0bfOH63x1sKzwqraybKWRJSHsxi2NDvme9u6DvFBcmV8u
         n25GWTLim5sa/vfKX7CsQCR29vK9mXLEWP8eBIuu8nyG9lFOikQp3/XX+yDJaxtQyzwu
         Hggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PEphENIqEyKhL/8vOm7zNFilpyK8f33jXcN4DaEjc2E=;
        b=Yd0UneYgTP3c/hBt0PvNBFSHCTx/ydUIwGJbJ49NrMJbLXpZ49uP6zPNRCIvgntLM9
         GAp0MKHouaK2uyyUMCgbKQMyyKYfJrBVYAJ5ro06FsU6vT9JGPuhc7y9uNKYLObHfQSd
         9HY69gKfPdzbfLQaMAQEJA8+1uHD2RKF8zR4Eqnyq5QxAXLUcrPrPenJZOkXIX9eRYMr
         XstJZXRyLfOtkhkwOyqzOvY5RfXzZEmZLNDmz621eRvfWuvt2Z93qFN1JHn9klbVwcfk
         0oh0vaG8UZ8epaZajZkwNXdxMnTOxFz5UuTrCpAl5Aa3E4oYTQhwGlCWf28k/BxLO2Z8
         HEww==
X-Gm-Message-State: AOAM531TC5x7gLhhIbF4wHpuYcEQJrPM150NepEiM2DS/6SVsJIBgtLs
        ZLCHINHVB9GxRiMM6CaYmRVdww==
X-Google-Smtp-Source: ABdhPJzxFp96daVLCaza1b6Bd52oFmsqwsvCs3ZrC4i9Nzy9ONwlsC6juBrZAzz92R+zlcRktGcHVQ==
X-Received: by 2002:a63:f712:: with SMTP id x18mr4689666pgh.389.1626189003407;
        Tue, 13 Jul 2021 08:10:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id b19sm17409447pjh.29.2021.07.13.08.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:10:02 -0700 (PDT)
Date:   Tue, 13 Jul 2021 23:09:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
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
Subject: Re: [PATCH v4 10/11] perf env: Set flag for kernel is 64-bit mode
Message-ID: <20210713150953.GC748506@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-11-leo.yan@linaro.org>
 <YOyGi9Zdrio7OmBX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOyGi9Zdrio7OmBX@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo, Adrian,

On Mon, Jul 12, 2021 at 03:14:35PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jul 11, 2021 at 06:41:04PM +0800, Leo Yan escreveu:
> > It's useful to know that the kernel is running in 32-bit or 64-bit
> > mode.  E.g. We can decide if perf tool is running in compat mode
> > from this info.
> > 
> > This patch adds a global variable "kernel_is_64_bit", it's initialized
> > when a session setups environment, its value is decided by checking the
> > architecture string.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/env.c | 17 ++++++++++++++++-
> >  tools/perf/util/env.h |  1 +
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index ebc5e9ad35db..345635a2e842 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -11,6 +11,7 @@
> >  #include <stdlib.h>
> >  #include <string.h>
> >  
> > +int kernel_is_64_bit;
> >  struct perf_env perf_env;
> 
> Why can't this be in 'struct perf_env'?

Good question.  I considered to add it in struct perf_env but finally
I used this way; the reason is this variable "kernel_is_64_bit" is only
used during recording phase for AUX ring buffer, and don't use it for
report.  So seems to me it's over complexity to add a new field and
just wander if it's necessary to save this field as new feature in the
perf header.

Combining the comment from Adrian in another email, I think it's good
to add a new field "compat_mode" in the struct perf_env, and this field
will be initialized in build-record.c.  Currently we don't need to save
this value into the perf file, if later we need to use this value for
decoding phase, then we can add a new feature item to save "compat_mode"
into the perf file's header.

If you have any different idea, please let me know.  Thanks!

Leo
