Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E2C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146826127C
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhGMM7t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbhGMM7t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:59:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C58C0613DD;
        Tue, 13 Jul 2021 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HYg+Gfy1rzeXrpFBUcY0k1dwItUMLKZvkbcYt//5vGs=; b=Ub9SgGnQKmt3zkIyJReBe/qE5m
        Yd92oP9f5SvHwpnoK2HskVaKdko2ZDkimitSCSIYLaHIHWEzAMZ+aeOEJlzF1QdA4VHXq0RGp0mHH
        TIRTgUioV6gth7Ip8RTWYDudTwc/uRewtHzzhSD1Slw4WhFlrF/+DvBLxoseR+flZRovW/Vgqg252
        a5ShtUV1r4Zf8PNy3rABuMRHORrS/JLILcSTgSTZaZ58TclGfyfPVRB30ck9F/Bcw6cz7v1V2c7iO
        uceGGFmts7bMmDNuoJzbqYMsMZhjNFx0AjGzpezPP1oYxR2oWcSUFcoEyduUlQ28pBSnqVmqdqp4A
        lCPgpYbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3HxG-00171O-Nc; Tue, 13 Jul 2021 12:56:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 566F7987782; Tue, 13 Jul 2021 14:56:06 +0200 (CEST)
Date:   Tue, 13 Jul 2021 14:56:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
Subject: Re: [PATCH v4 03/11] coresight: tmc-etf: Add comment for store
 ordering
Message-ID: <20210713125606.GB4170@worktop.programming.kicks-ass.net>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711104105.505728-4-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jul 11, 2021 at 06:40:57PM +0800, Leo Yan wrote:
> AUX ring buffer is required to separate the data store and aux_head
> store, since the function CS_LOCK() has contained memory barrier mb(),
> mb() is a more conservative barrier than smp_wmb() on Arm32/Arm64, thus
> it's needless to add any explicit barrier anymore.
> 
> Add comment to make clear for the barrier usage for ETF.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 45b85edfc690..9a42ee689921 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -553,6 +553,12 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  	if (buf->snapshot)
>  		handle->head += to_read;
>  
> +	/*
> +	 * AUX ring buffer requires to use memory barrier to separate the trace
> +	 * data store and aux_head store, because CS_LOCK() contains mb() which
> +	 * gives more heavy barrier than smp_wmb(), it's not necessary to
> +	 * explicitly invoke any barrier.
> +	 */
>  	CS_LOCK(drvdata->base);

'more heavy' is not a correctness argument :-)

The argument to make here is that CS_LOCK() ensures completion /
visibility of the hardware buffer.
