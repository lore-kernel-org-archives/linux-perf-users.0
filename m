Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC5FC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Feb 2022 01:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiBRB6w (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Feb 2022 20:58:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiBRB6v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Feb 2022 20:58:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9230F1BBF66
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Feb 2022 17:58:36 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so7169861pjm.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Feb 2022 17:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZDSkUfp9toni5mt9GhqILhie8mR19f4SRKJDHSNLJMQ=;
        b=egfIW48oBvJ/rLtSDNSipUVlWRgNK8wpWktEAmc/Pz+571EuPH93FuvLqvVMByQ5db
         HxtZ13ltXoICHbkwOBttZaBYSeCuox2CL3P4RAqZvDgpbPpaFuIF8QcVfmp9p+Y4VQpc
         mzA0G2mDcmnDkdl51jrsYO9slg6f8xE9971Xjsbuy4/LKM55y/CrCEgq2tbneTD/xBeK
         3lC2cASpiz/4y7xNjRZljYqX0sfxnLI5TUGW/8WBeVgqCZoMhU1ieMHZSNWxYpx/+TzN
         St8Bj0xwfe32lJ1e+goTg/5mMQlIuZ4oZj8OJMq3iXzKrs2n9g7/mu280HPU3j2r6lV5
         0Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZDSkUfp9toni5mt9GhqILhie8mR19f4SRKJDHSNLJMQ=;
        b=yXHdabSlGoxwc1HLExGTq+2CnNkjIU78Sj96O5z9AYS9ZZFEingPiTFMXfYRQNh9yV
         LWGRx5VZblVuDUzb5ofVsvPe+wMR9Mi+ncgK0Tzsdlsw8nD0SKAm2PA9HJfd4TIqxmFJ
         evkqHionHeuxyH2vIK29c196JYAhFXmTr+YKLx+nelE0AsZLmAXEp5esJPSEDPfArpE+
         PXlWk2j2VLv9MNgC5CDO5JOGxZPsA4Na0AoFYUqPsghEix/I6w2pLVSz4cPg4PhHO9UN
         PBJlblm8uQLVOOeo9gLSU5pCqkQenuYjnuHv8cDvdTIA1PKzo9xsQlKpL1SVgFAtnnuQ
         z22g==
X-Gm-Message-State: AOAM532pSPnAk+GmJHQD2jwXRDLakzqEpNuLRDHyvWCFAs/iY7k3vc0S
        5I2xTW5XWNl42gZYkzfq+aqrdA==
X-Google-Smtp-Source: ABdhPJy2k7pnPPA0dR19XFlkrV9I2LgB9Fmjp0AzFRXaw08FvPFHy9T2UllkCBD/Je9vr200hAGEwA==
X-Received: by 2002:a17:90b:250f:b0:1b8:f257:c39 with SMTP id ns15-20020a17090b250f00b001b8f2570c39mr5924833pjb.135.1645149515932;
        Thu, 17 Feb 2022 17:58:35 -0800 (PST)
Received: from leoy-ThinkPad-X240s (104.225.159.78.16clouds.com. [104.225.159.78])
        by smtp.gmail.com with ESMTPSA id t15sm8956290pgu.13.2022.02.17.17.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 17:58:35 -0800 (PST)
Date:   Fri, 18 Feb 2022 09:58:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Marco Elver <elver@google.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, dvyukov@google.com,
        will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, irogers@google.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test: Skip Sigtrap test for arm+aarch64
Message-ID: <20220218015828.GA925833@leoy-ThinkPad-X240s>
References: <1645114959-119064-1-git-send-email-john.garry@huawei.com>
 <CANpmjNOO6yxF+xXoatR==uvSaEwsWyZ=n7ExEM_=OJaDYBCeSw@mail.gmail.com>
 <f7782f09-7f12-b957-a1b2-d0673ec1304c@huawei.com>
 <CANpmjNOO-fsU7PP_PqeT53_N=xmNruiT3mvE0e1y=EtKJUfFGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOO-fsU7PP_PqeT53_N=xmNruiT3mvE0e1y=EtKJUfFGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Feb 17, 2022 at 06:40:45PM +0100, Marco Elver wrote:
> On Thu, 17 Feb 2022 at 18:34, John Garry <john.garry@huawei.com> wrote:
> [...]
> > >> -#if defined(__powerpc__) || defined(__s390x__)
> > >> +#if defined(__powerpc__) || defined(__s390x__) || \
> > >> +       defined(__arm__) || defined(__aarch64__)
> > >>   #define BP_ACCOUNT_IS_SUPPORTED 0
> > >>   #else
> > >>   #define BP_ACCOUNT_IS_SUPPORTED 1
> > >
> > > This is now equivalent to BP_SIGNAL_IS_SUPPORTED
> > > tools/perf/tests/tests.h -- and different from the original
> > > BP_ACCOUNT_IS_SUPPORTED (and makes me wonder why
> > > BP_SIGNAL_IS_SUPPORTED wasn't just used from the beginning). Perhaps
> > > just use BP_SIGNAL_IS_SUPPORTED.
> > >
> >
> > We currently have BP_ACCOUNT_IS_SUPPORTED defined now in 2x locations:
> >
> > tests/sigtrap.c
> > tests/bp_account.c
> >
> > bp_account works for arm64, and we don't want to skip that test. So, as
> > long as the macro meaning is appropriate, we can reuse
> > BP_SIGNAL_IS_SUPPORTED for sigtrap.c
> 
> BP_ACCOUNT seems to say something about the "breakpoint accounting /
> measuring" test. BP_SIGNAL is about the tests that want to use
> breakpoints to generate signals.

More general speaking, I think "BP_ACCOUNT_IS_SUPPORTED = 1" means an
architecture can support breakpoint with perf_event.

"BP_SIGNAL_IS_SUPPORTED = 1" means an architecture can support
breakpoint to generate signals with using perf_event.  So
"BP_SIGNAL_IS_SUPPORTED = 1" is subset of "BP_ACCOUNT_IS_SUPPORTED = 1".

> So it's very much appropriate to use BP_SIGNAL here if, as we have
> discovered regardless how they're generated in response to
> breakpoints, are broken on arm/arm64. On the day arm/arm64 decides to
> fix signals, I'm assuming all tests being skipped with
> BP_SIGNAL_IS_SUPPORTED can be re-enabled (or so we hope).

Yeah, I agree that BP_SIGNAL_IS_SUPPORTED is better choice for sigtrap.c.

Thanks,
Leo
