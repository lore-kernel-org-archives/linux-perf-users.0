Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC6DC433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Feb 2021 12:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8514D64E3B
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Feb 2021 12:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhBJMFf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 07:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBJMEd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Feb 2021 07:04:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9623FC061574
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Feb 2021 04:03:52 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d26so1128819pfn.5
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Feb 2021 04:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MA62Id4xvlTd2MzFrmGX4Z33bCUmSIvf/5faUyJz8co=;
        b=ag7xEWDr1k9w0e2byUNqku+dVvYFDaUp0MgCFy6ZmZfRFvKSdqMg/hGThPcaalxW1b
         oGLpWD/F45oTUqy5/lCJjqArRn14QdCNneQhPdWUKChXmmeyFkYnG9VJGgiyP/b+THDe
         87Fy1StKXGQ6i04jJ2u3ZLQ7muck3VepZLzSGsxIjIJv3TgulfVSZdH0adOUZEU3k4N7
         BlOCHQoq1S60KOa9iTmoQlZrBuUyXhxhr+PaxUCVxMq4GHq0ruhqMSVzcbPzK/5PJpY5
         fDTzh2KiRVuIGPzxsb4Z37ss5ZyOFmsg0Dccl1KL9fg49gtiqfZhVugF5yLbbkphvCls
         RDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MA62Id4xvlTd2MzFrmGX4Z33bCUmSIvf/5faUyJz8co=;
        b=sGwUvy73/xDWKILwks0KZPTYG5AMUj1hIpWheQcO7FTh/aVlUUnujGx2/Gnrcg6Fpa
         ITL7HZX0XuOwybR4XtB7RHAsA6Vy4IlSXiuaRrYaF/RzdEMjK+uGRmbGN712etrajuEs
         JaiH2wVUCoIPEknpriGcrO6lgmyY4ygIxX5NL1FR8uq7kVBN07g9bZQC71sRtkshb25s
         wJTVm12EqTMVa8kgNPrBcEXbxmI5V5+/DbqNsvEu8WfirZkaMNgohh6B0iWeNrb4eeLS
         7/pTMmFI8b7r1b4M42glPuVsPHOC9aEi0jmwTcK1ag5jsIyITC+nU60n2ltz3ID4Rg7b
         6UMw==
X-Gm-Message-State: AOAM5329Mp0ACxUmy/VD2APnOLQJ86Iy8PcHwWQqPeiL3EN24lSUFdxP
        CBu+j8kRKzSjyhaMBeJvHRKA6A==
X-Google-Smtp-Source: ABdhPJwElRvUwrpiCjZadB6NI/AowooQkhirbHr8u+TJJJh4wPCy2xKy9RcwKBcewLQs/zb2Vf2tOQ==
X-Received: by 2002:a63:1c13:: with SMTP id c19mr2694048pgc.359.1612958631896;
        Wed, 10 Feb 2021 04:03:51 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.131.71.236])
        by smtp.gmail.com with ESMTPSA id j73sm2324218pfd.170.2021.02.10.04.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:03:51 -0800 (PST)
Date:   Wed, 10 Feb 2021 20:03:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 8/8] perf arm-spe: Set thread TID
Message-ID: <20210210120341.GD29117@leoy-ThinkPad-X240s>
References: <20210119144658.793-1-james.clark@arm.com>
 <20210119144658.793-8-james.clark@arm.com>
 <20210131120156.GB230721@leoy-ThinkPad-X240s>
 <cb7c6deb-e4a1-95fa-b0d2-e4405f644e63@arm.com>
 <20210204102734.GA4737@leoy-ThinkPad-X240s>
 <258ff186-7be0-7b83-fb29-e8223e780f73@arm.com>
 <6c5760aa-76aa-3a56-9a12-9f331b254173@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c5760aa-76aa-3a56-9a12-9f331b254173@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Wed, Feb 10, 2021 at 12:16:58PM +0200, James Clark wrote:
> 
> 
> On 09/02/2021 17:36, James Clark wrote:
> > 
> > 
> > On 04/02/2021 12:27, Leo Yan wrote:
> >> On Mon, Feb 01, 2021 at 07:40:45PM +0200, James Clark wrote:
> >>>
> >>> On 31/01/2021 14:01, Leo Yan wrote:
> >>>> Option 1: by merging patches 07/08 and 08/08, we can firstly support PID
> >>>> tracing for root namespace, and later we can extend to support PID
> >>>> tracing in container (and in VMs).
> >>>>
> >> Arm SPE has the problem for step2, due to the trace uses statistical
> >> approach, it doesn't trace the complete branch instructions, so it
> >> cannot promise to capture all branches for the symbol "__switch_to".
> >> If we only use the events PERF_RECORD_SWITCH /
> >> PERF_RECORD_SWITCH_CPU_WIDE, then it will lead to the coarse result
> >> for PID tracing.
> >>
> >> For this reason, seems to me it's pragmatic to use CONTEXTIDR for
> >> PID tracing at current stage, at least it can allow the root domain
> >> tracing works accurately.  But this will leave the issue for tracing
> >> PID in non root namespace, we need to figure out solution later.
> >>
> >> Hi Mark.R, Al, do you have any comments for this?
> > 
> > Hi Leo,
> > 
> > I spoke with Al and his suggestion is to clear the PID value if the event
> > was opened outside of the root namespace.
> > 
> > I think that's not a bad idea as it gets us PIDs in most cases but also
> > doesn't show any incorrect data. Do you know if it's possible to determine
> > that from a perf.data file? Unfortunately it doesn't seem to be possible
> > to disable CONTEXTIDR tracing when opening the event as it's compile time
> > only and can't be disabled dynamically.
> > 
> > James
> > 
> 
> I've had a think about it and I think we should do one of two things:

Thanks a lot for digging!

> #1) Remove the PID setting from the data source patchset. This will keep the
>     existing behaviour of using the PID of the first traced process only even
>     if there are forks. Later we can implement #2 or attempt to make it work
>     even in non root namespaces.

I agree.  Let's simplify the data source patch set; could you resend the
data source patch set so this can allow perf maintainer to easier follow
up (and merge) the patch series?  Thanks!

>     I'm not sure how this will impact your c2c patchset if you are relying on
>     the PID data Leo?

Yes, based on the experiment, if we want to extend "perf c2c" for
exhibit multi-threading info, then it depends on PID tracing.

> #2) Make a change in the SPE driver to add an option for disabling CONTEXTIDR.
>     We will disable this from userspace if the event is opened in a non root
>     namespace. So we will only show PID data if we know it's valid, otherwise
>     the existing behaviour of only using the first PID will remain.

Yeah, just a minor difference in my head.

Yes, we can use the kernel to export an extra PMU format, e.g. a new PMU format
"contextid", so the kernel provides a knob for userspace (this is similiar with
perf cs-etm :)).

I am just wandering if we can disable CONTEXTIDR tracing in the kernel side,
e.g. when the kernel detects if it's running on non root namespace, it should
not set bit SYS_PMSCR_EL1_CX_SHIFT; so if the tool in the userspace has
specified the PMU format "contextid" from non root namespace, the kernel should
report failure for without permission.

This seems to me, at least, we can have a sane solution for root
namespace.

Thanks,
Leo
