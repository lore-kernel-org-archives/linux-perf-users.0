Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC4C63777
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Dec 2020 06:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47870206B6
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Dec 2020 06:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgLCGk3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCGk3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Dec 2020 01:40:29 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F85C061A4D
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Dec 2020 22:39:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s2so582480plr.9
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Dec 2020 22:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p90ZTrcODaMIh1PUcjXTtSOF3aHh5Iqv2c9lQCLd5uw=;
        b=mQlNuueE54XSMWq6SP8fFDIEQPOEDPETEey3dENLqhob4IP0rwSDaMWufXPbwQrTy5
         DfOrJG0MoN015zDuWdAoZ4n0MZyPwbYHfBWIKxRgyAUBU8n1e0wiQO1R+V7ZpQmTwAEx
         Dv4qJX6AA5LkzCGWlZJt2qIot4zzQBc8GU68zXp4UDW6ZK01adsFGAIjkUQMLlNpuBRr
         eO3/jXso0XELDb0aW38cbsWgQVhK175ctbxvqRBykQYaE45dzfpt/UoIGjViFAY404Dq
         XzE3KsYbpByBOeAmpCl4EtATdsHpDQQcly+6UBNE16+Jp/Q2yirUSTKopr+zqgNnwDY5
         cTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p90ZTrcODaMIh1PUcjXTtSOF3aHh5Iqv2c9lQCLd5uw=;
        b=pFGFk9RRnGXL6nPq5HUuKCoedWLc7OXqC5cBDLlK2Vgm/yxRuXI7fN8C0vIwRTThJX
         ZVdY2u/pywl1Vjpq1M42PyWzRJmLnOTI4vF5p/KQMZ9lqpJm8rD+Za0GkXWM65HmKz79
         mLk4frLP4h+n6tNsEdoxtq4Tx2o54XU1zvJ3PA9Hy5mEn/n63xJMLTQ6UXrZkACrWbW6
         OFV1y0aj99lBkW3RUf+VVCqjeXtQiHx8VEmreRs+4Wiz12ViJn6DyVmvkFw6/8hhim+s
         vsXIExLJKUg8UEacaR2sLcZeqjVQDpJDBwHLKLA8fXzkSP363aux8/fKYhJFDNWFFiJy
         sPjA==
X-Gm-Message-State: AOAM532dgOJL2s47y+0XMAoOXprS61+26F1RI0TQCrc4i/8jLT+4pQT8
        kSZb57iiXZP1aw9fGqh6aOtG5A==
X-Google-Smtp-Source: ABdhPJyOoElyxwiAEuD0omkoyT6H/99s9lIaMAXnW6c09Gjnn8aUkR6r+ju4a9dxwk4XRIAiskjs6A==
X-Received: by 2002:a17:902:b498:b029:da:84a7:be94 with SMTP id y24-20020a170902b498b02900da84a7be94mr1731127plr.52.1606977588537;
        Wed, 02 Dec 2020 22:39:48 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id j10sm306546pji.29.2020.12.02.22.39.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 22:39:47 -0800 (PST)
Date:   Thu, 3 Dec 2020 14:39:41 +0800
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
Message-ID: <20201203063941.GE28939@leoy-ThinkPad-X240s>
References: <20201130162454.28255-1-james.clark@arm.com>
 <20201130164650.GA25187@willie-the-truck>
 <20201201041040.GC28939@leoy-ThinkPad-X240s>
 <20201201230935.GD28496@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201230935.GD28496@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Will,

[ + Mathieu ]

On Tue, Dec 01, 2020 at 11:09:36PM +0000, Will Deacon wrote:
> On Tue, Dec 01, 2020 at 12:10:40PM +0800, Leo Yan wrote:
> > On Mon, Nov 30, 2020 at 04:46:51PM +0000, Will Deacon wrote:
> > > On Mon, Nov 30, 2020 at 06:24:54PM +0200, James Clark wrote:
> > > > Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
> > > > This flag is required to get PID data in the SPE trace. Without
> > > > it the perf tool will report 0 for PID which isn't very useful,
> > > > especially when doing system wide profiling or profiling
> > > > applications that fork.
> > > 
> > > Can perf not figure out the pid some other way? (e.g. by tracing context
> > > switches and correlating that with the SPE data?).
> > 
> > For perf 'per-thread' mode, we can use context switch trace event as
> > assisted info to select thread context.  But for "system wide" mode and
> > "snapshot" mode in perf tool, since the trace data is continuous, I
> > think we cannot use context switch trace event to correlate the SPE
> > trace data.
> 
> Is there no way to correlate them with something like CNTVCT?

Good point.  Yes, we can convert CNTVCT to system time; I read the
code in the perf's intel-pt.c and found the timestamp is used to
correlate the auxtrace heap.  I think it's better to dig more for
detailed implementation.

> > > Also, how does this work with pid namespaces?
> > 
> > Here we are studying the implemetation of Intel-PT and Arm CoreSight.
> > 
> > The context ID is stored into the hardware trace data when record;
> > afterwards when perf tool decodes the trace data and detects the
> > packet for context ID, it will select the machine's thread context in
> > perf [1].  Since the perf tool gathers all the threads infomation in
> > perf data file, based on the context ID, it can find the corresponding
> > thread pointer with function machine__find_thread() [2].
> > 
> > Since your question is for "pid namespace", to be honest, I don't know
> > how perf tool to handle any confliction for differrent processes share
> > the same PID, and I am not sure if you are asking CGroup related stuff
> > or not.  If this cannot answer your question, please let me know.
> 
> My point was that the pid value written to CONTEXTIDR is a global pid
> and does not take namespacing into account. If perf is run inside a pid
> namespace, it will therefore not work.

Understand now.

The perf events PERF_RECORD_ITRACE_START/PERF_RECORD_SWITCH/
PERF_RECORD_SWITCH_CPU_WIDE can be used to set pid/tid in perf.  So this
would be a safe way for perf tool running in pid namespace.

Loop in Mathieu, this is a common issue for both Arm SPE and CoreSight
(IIRC, though CoreSight's timestamp is not strictly attaching to Arm arch
timer counter, the trend is to unify this for using arch timer
counter).

I think James could continue to upstream a new patch by following your
suggestion for enabling PID_IN_CONTEXTIDR, eventually, it's a feature
for Arm SPE to record CONTEXTIDR in its packet.

Your questions inspired me, thanks!

Leo
