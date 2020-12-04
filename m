Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A05C197BF
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Dec 2020 00:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACC222513
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Dec 2020 00:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502015AbgLDAHp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 19:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502004AbgLDAHp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Dec 2020 19:07:45 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1714BC061A51
        for <linux-perf-users@vger.kernel.org>; Thu,  3 Dec 2020 16:07:05 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id o9so2438555pfd.10
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Dec 2020 16:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hElgmtc7PJJLc48EH95WqE542tCHlShsoybOtFUxsPM=;
        b=lZ1RIYdPTNItbLd+7kmC26xGvAXxapbVxIV85XTGaDAwmkHGv59dhrOUF33yNnPU9P
         LZ08gTv+1Y2UKsDHaTUNJYEuu9/RhEN/z6NnGh8Mezk6ycSIX4znSoQkOJXccOCz7Ovp
         0Z47ogkC5n9V5UGHLCHcEj9x21Y4PmW3niD2rzxy7rZfOXcEzz9wrIR5T6+3T/nzJuHq
         qlkbSEIUE4YedxF0dE0BKkjjyz/NIVsvBKB/uW0QgQVkAEw9WUaDBSOlYw5bEx6xBUnf
         QlOwAxZpwAvmBhbItk9YeLIiHGyFxbUhA8daBgZX6qpfaPmJNhTJnyButIxM4DHuwqx4
         ZRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hElgmtc7PJJLc48EH95WqE542tCHlShsoybOtFUxsPM=;
        b=RPHzU0iK5X/r3E6RG35Y8LzJpWgrkU2GSrCEEA4jkYVTQ/rS2s/B24HVJDjb1K0Blb
         XYCkYipkWN7BAubISQccCm2KAtMW7v2eaOu74W1GvOHKBEQ2TjxVV/yevbjKLdfqvhpP
         +DEvkYWS9HIkPGLzIgoBBoHJGgZHoeOEPHg0gLVGquyJNHJRDvrvHI3eZOidAV+QkeKe
         DD9mwiB5bKOuraPX67e8tmmUUl0hjYC4h6lfh0fpNapjui8LONPAws0dbeIzAm36vQOE
         M7hkWxokwFrKqd8FWS52/Uq44ryLrm4lr/6c624CR1tZdE/+xoNc6hpYjxGkvmO7rWSN
         IEMg==
X-Gm-Message-State: AOAM5315hzi6BlBcc4WmDijO2p64v2e7U67sZarWkOxe8EO7XFHO2NZk
        bdxFC0UhjxqF6Ty6c4O0pntitw==
X-Google-Smtp-Source: ABdhPJxq4b+0dAEDAWHo5J7YWwonfoA44bfJmj1hGhExnewdvVXSqfrPlp5xT3XC+ZU6WRbehtTbMg==
X-Received: by 2002:aa7:9315:0:b029:18b:6372:d43e with SMTP id 21-20020aa793150000b029018b6372d43emr1288827pfj.2.1607040424574;
        Thu, 03 Dec 2020 16:07:04 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s189sm2725013pfb.60.2020.12.03.16.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 16:07:03 -0800 (PST)
Date:   Thu, 3 Dec 2020 17:07:01 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Al Grant <al.grant@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Message-ID: <20201204000701.GA1403545@xps15>
References: <20201130162454.28255-1-james.clark@arm.com>
 <20201130164650.GA25187@willie-the-truck>
 <20201201041040.GC28939@leoy-ThinkPad-X240s>
 <20201201230935.GD28496@willie-the-truck>
 <20201203063941.GE28939@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203063941.GE28939@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Dec 03, 2020 at 02:39:41PM +0800, Leo Yan wrote:
> Hi Will,
> 
> [ + Mathieu ]
> 
> On Tue, Dec 01, 2020 at 11:09:36PM +0000, Will Deacon wrote:
> > On Tue, Dec 01, 2020 at 12:10:40PM +0800, Leo Yan wrote:
> > > On Mon, Nov 30, 2020 at 04:46:51PM +0000, Will Deacon wrote:
> > > > On Mon, Nov 30, 2020 at 06:24:54PM +0200, James Clark wrote:
> > > > > Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
> > > > > This flag is required to get PID data in the SPE trace. Without
> > > > > it the perf tool will report 0 for PID which isn't very useful,
> > > > > especially when doing system wide profiling or profiling
> > > > > applications that fork.
> > > > 
> > > > Can perf not figure out the pid some other way? (e.g. by tracing context
> > > > switches and correlating that with the SPE data?).
> > > 
> > > For perf 'per-thread' mode, we can use context switch trace event as
> > > assisted info to select thread context.  But for "system wide" mode and
> > > "snapshot" mode in perf tool, since the trace data is continuous, I
> > > think we cannot use context switch trace event to correlate the SPE
> > > trace data.
> > 
> > Is there no way to correlate them with something like CNTVCT?
> 
> Good point.  Yes, we can convert CNTVCT to system time; I read the
> code in the perf's intel-pt.c and found the timestamp is used to
> correlate the auxtrace heap.  I think it's better to dig more for
> detailed implementation.
> 
> > > > Also, how does this work with pid namespaces?
> > > 
> > > Here we are studying the implemetation of Intel-PT and Arm CoreSight.
> > > 
> > > The context ID is stored into the hardware trace data when record;
> > > afterwards when perf tool decodes the trace data and detects the
> > > packet for context ID, it will select the machine's thread context in
> > > perf [1].  Since the perf tool gathers all the threads infomation in
> > > perf data file, based on the context ID, it can find the corresponding
> > > thread pointer with function machine__find_thread() [2].
> > > 
> > > Since your question is for "pid namespace", to be honest, I don't know
> > > how perf tool to handle any confliction for differrent processes share
> > > the same PID, and I am not sure if you are asking CGroup related stuff
> > > or not.  If this cannot answer your question, please let me know.
> > 
> > My point was that the pid value written to CONTEXTIDR is a global pid
> > and does not take namespacing into account. If perf is run inside a pid
> > namespace, it will therefore not work.

Will is correct.  That is why coresight doesn't allow contextID tracing if the
request is made from inside a PID namespace.  But that is only from the sysfs
interface.  From perf the guard wasn't put in place, probably because CPU
wide trace scenarios were not implemented yet.   

> 
> Understand now.
> 
> The perf events PERF_RECORD_ITRACE_START/PERF_RECORD_SWITCH/
> PERF_RECORD_SWITCH_CPU_WIDE can be used to set pid/tid in perf.  So this
> would be a safe way for perf tool running in pid namespace.
> 

Remember that the events you are referring to above are all processed in the
perf tools where there is no way to go from pid to vpid.  And to preempt any
hope, there is no way to "switch" the pid for the vpid in the trace stream.
That is all done in hardware.

I think the easiest solution is to simply avoid using contextIDs when PID
namespaces are involved.

> Loop in Mathieu, this is a common issue for both Arm SPE and CoreSight
> (IIRC, though CoreSight's timestamp is not strictly attaching to Arm arch
> timer counter, the trend is to unify this for using arch timer
> counter).
> 
> I think James could continue to upstream a new patch by following your
> suggestion for enabling PID_IN_CONTEXTIDR, eventually, it's a feature
> for Arm SPE to record CONTEXTIDR in its packet.
> 
> Your questions inspired me, thanks!
> 
> Leo
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
