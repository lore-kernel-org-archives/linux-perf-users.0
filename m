Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89114C64E8A
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 04:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195DD2073C
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 04:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccKTRsIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgLAELc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgLAELc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Nov 2020 23:11:32 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359ACC0613D2
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Nov 2020 20:10:46 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id u2so370834pls.10
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Nov 2020 20:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4gTVyUsOmP5LeMG5o202bTzO+J5xznjW1zTL9+SjzpM=;
        b=ccKTRsILPyGIyRAmLgvYi1tTd1l55bnvNt4V/z+IWYvqj3BF9ZW53bIWQu1aodcoht
         6m7aWm+AryLh4ygB9IFLU60mIPyXEiGoHijllyLUvPmYugLWE0W58fjLUiHeV1X8jOLx
         jTfNK9N59dVWw3aUavZnz/0OsXGFpJhhf3QH+JrNwavLqh4j0oCQ1shTxEFplZp+xuGG
         UuhLG7m81hAx6RxNKKdAm21hF+rQHztEB0Ube4E+a3aOh+sSykDlV1RtjQr7x8+6VvZH
         TtJuG7A0nZ/IKMdiLut6b+3g0SaFYUBggGOOJaojrq+7lOlGVNb5IzHPIWOMZJcqAkiz
         JYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4gTVyUsOmP5LeMG5o202bTzO+J5xznjW1zTL9+SjzpM=;
        b=SuBPWe2JGTUPanzOBCEdXWUHfEu1ec1uoQY/8XWyxbpNEg2xIdWErolbFct6MmD0xw
         IXYA6JUEzIs9uHNO9lOpqBpmy981LagUt/7BvhEd8+IA/5XURInf2KS93xQYTRS5ZYRq
         zyzxesMmGGAx/gTxRaMvuuV4dBOLg0IAEKFXI65w9Vl36QLtpcSVytaAgKBPJ8yduCYy
         hwIWQzE/0anZyPp5VNbYYtueSW6RIb3kRimBjOnK24WKnY1Bq7ujlyaWZd1ZfNVhytZK
         vwksSgGSECRb/bj7C/4H/hsv6N3SZJO+NLfvNmwswQJqQvX6qDsElkE7afh/q0H8nOrU
         Jyiw==
X-Gm-Message-State: AOAM532LOPOeGSxz8dUX7fr7pI41khnHHGG/kLzWex0L92LPNGuvJM/8
        8BoXwW26jsC13DaTMOwkBAHPcA==
X-Google-Smtp-Source: ABdhPJw+uQD2NPrArQVbwZL3xgyXl6S9NlkZouuzcjINWAa5igSSxyf7Ys7PRaEPwemWK91B8QPNPQ==
X-Received: by 2002:a17:902:a3c9:b029:d9:ec83:1e57 with SMTP id q9-20020a170902a3c9b02900d9ec831e57mr1211336plb.76.1606795845429;
        Mon, 30 Nov 2020 20:10:45 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id e1sm585443pfi.158.2020.11.30.20.10.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Nov 2020 20:10:44 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:10:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Al Grant <al.grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Message-ID: <20201201041040.GC28939@leoy-ThinkPad-X240s>
References: <20201130162454.28255-1-james.clark@arm.com>
 <20201130164650.GA25187@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130164650.GA25187@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Will,

On Mon, Nov 30, 2020 at 04:46:51PM +0000, Will Deacon wrote:
> On Mon, Nov 30, 2020 at 06:24:54PM +0200, James Clark wrote:
> > Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
> > This flag is required to get PID data in the SPE trace. Without
> > it the perf tool will report 0 for PID which isn't very useful,
> > especially when doing system wide profiling or profiling
> > applications that fork.
> 
> Can perf not figure out the pid some other way? (e.g. by tracing context
> switches and correlating that with the SPE data?).

For perf 'per-thread' mode, we can use context switch trace event as
assisted info to select thread context.  But for "system wide" mode and
"snapshot" mode in perf tool, since the trace data is continuous, I
think we cannot use context switch trace event to correlate the SPE
trace data.

> Also, how does this work with pid namespaces?

Here we are studying the implemetation of Intel-PT and Arm CoreSight.

The context ID is stored into the hardware trace data when record;
afterwards when perf tool decodes the trace data and detects the
packet for context ID, it will select the machine's thread context in
perf [1].  Since the perf tool gathers all the threads infomation in
perf data file, based on the context ID, it can find the corresponding
thread pointer with function machine__find_thread() [2].

Since your question is for "pid namespace", to be honest, I don't know
how perf tool to handle any confliction for differrent processes share
the same PID, and I am not sure if you are asking CGroup related stuff
or not.  If this cannot answer your question, please let me know.


Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c#n510
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/cs-etm.c#n1076

> 
> > There is a small performance overhead when enabling
> > PID_IN_CONTEXTIDR, but SPE itself is optional and not enabled by
> > default so the impact is minimised.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Al Grant <al.grant@arm.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  drivers/perf/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 130327ff0b0e..47ede46c3d57 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -125,6 +125,7 @@ config XGENE_PMU
> >  config ARM_SPE_PMU
> >  	tristate "Enable support for the ARMv8.2 Statistical Profiling Extension"
> >  	depends on ARM64
> > +	select PID_IN_CONTEXTIDR
> 
> Probably better to make PID_IN_CONTEXTIDR 'default y' if SPE is enabled,
> rather than selecting it directly. That way, at least people can turn it
> off if they don't want it.
> 
> Will
