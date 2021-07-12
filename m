Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F411EC07E99
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 10:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF611610CD
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 10:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhGLK5b (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jul 2021 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbhGLK53 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jul 2021 06:57:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89575C0613DD
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jul 2021 03:54:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 62so17839154pgf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jul 2021 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JA4gd/MMGfc1bOk2g+m+nyNDBErsTegW/6UjqqXM42A=;
        b=c0Kl1T0GIdx/YSFtCjVP0ifXWWNh6tWYOQmER2lnFRi+M5/BTGGUVeFI5SfSnC4EWR
         GslbvfVJP2ce4WA7Piflj2DDrpom0floUP6s6GdYABbKPWkTMUbfW/vctT/PheHaxlqj
         Y2HcFWqTh7ubkSm7m3VZ25uHBG9qmopsMKIO/1N1M2murbE9LEYgAukMYdeIawDeBl2s
         ECDUO038erxpjwNCfEu7k2k/TGnpgegN58upQSEpKg5HDl938IX0x3CMRT7chiWRVFQo
         KZYFmqSF7OxUVfminCutnphxr8nqClfP0CW+31WHqXvHMAi+Etb6mcwYwdm1sIkXai0/
         l+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JA4gd/MMGfc1bOk2g+m+nyNDBErsTegW/6UjqqXM42A=;
        b=Bg/J6UJhq02v4DqVDe5sgu27n1Ef04xVZfJZgR4sHQe3g0K9KAe7WziE2Hkc0Y7XKA
         Q+Xca1hhRnwA8tb1J6DSfrY3EmYqipaSa3jsoYCyediUIJTjryAL9lXbGWbI1UQETFxV
         clAf9jDz5oKOBLhf9YGITnkgaIWAny9cXdAoKsSDhN3JYwwIUG54yFOhE7287SGedKQE
         9wZoHzKSfc6QWBCwL+n6+9IgmDYRt90uDnjFVl/2zzgaRzTRoJiUlNzq3S8hCmYwTP1q
         tRlp3ZWRNQyw1iabFlxg6EZGg/ES5widj3VCq2znohsXwquPPlT4TI2y6EcQJohPy/sn
         5d8A==
X-Gm-Message-State: AOAM531UrYZtF3mzLDdGLGk5b7YhPoQVWoVa4cBOHW0vbjG39NO0oi0T
        yqA9iVjCaHowNQW2rcVc0WHA5A==
X-Google-Smtp-Source: ABdhPJzwlG37y5qH/zJqKUdv7VgIG/DkqI/nK6PluMVwdOragJNswNAZJdb3l/flnshAu013xAMcJA==
X-Received: by 2002:a63:43c4:: with SMTP id q187mr52510934pga.172.1626087279943;
        Mon, 12 Jul 2021 03:54:39 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id w16sm13265914pgi.41.2021.07.12.03.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 03:54:39 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:54:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 02/11] coresight: tmc-etr: Add barrier after updating
 AUX ring buffer
Message-ID: <20210712105431.GA704210@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-3-leo.yan@linaro.org>
 <f9734d69-b1f5-825c-f152-705626f4b256@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9734d69-b1f5-825c-f152-705626f4b256@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Suzuki,

On Mon, Jul 12, 2021 at 11:40:12AM +0100, Suzuki Kuruppassery Poulose wrote:
> On 11/07/2021 11:40, Leo Yan wrote:
> > Since a memory barrier is required between AUX trace data store and
> > aux_head store, and the AUX trace data is filled with memcpy(), it's
> > sufficient to use smp_wmb() so can ensure the trace data is visible
> > prior to updating aux_head.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > index acdb59e0e661..713205db15a1 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > @@ -1563,6 +1563,14 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
> >   	 */
> >   	if (etr_perf->snapshot)
> >   		handle->head += size;
> > +
> > +	/*
> > +	 * It requires the ordering between the AUX trace data and aux_head
> > +	 * store, below smp_wmb() ensures the AUX trace data is visible prior
> > +	 * to updating aux_head.
> > +	 */
> 
> Please could we reword this a bit, something like :
> 
> 	/*
> 	 * Ensure that the AUX trace data is visible before the aux_head
> 	 * is updated via perf_aux_output_end(), as expected by the
> 	 * perf ring buffer.
> 	 */

Will refine with this in next spin.  Thanks for review!

> > +	smp_wmb();
> > +
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
