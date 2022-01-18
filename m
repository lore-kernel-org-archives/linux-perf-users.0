Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDF7C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Jan 2022 11:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbiARLTw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiARLS7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083CEC06161C
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jan 2022 03:18:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q25so77886485edb.2
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jan 2022 03:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dXkKY9TV5jKPRQS8npjT2kmqtGeprtOApiCdkfgYiBA=;
        b=RaqI3KHqXcZqT1HWbCc0QERICwhfSItlAf6p615a9aV9FK4gtZloTjvE/aMk0xre//
         QG5neM7zOxKc0gFZcPnY6KDQ8EnpFbkN+BymjejeISvbcCjp+OMzu+vWfNkL9lEx8z09
         oMZNi53pbX0GAE2fgZ7eyihjD/lWTJBEvLyyuSs3ysA/HXTU3r16HTa13jXPTcxM+kq+
         5NjdSp5PP8U7O7pepfz+7rS0WGGyRbZpsYF4B1KDlzQ8Do/UgWjbcIKn2lXu+tCDNBoC
         U/tIm2ZqfKw5WmJ1K7IwJTCMydISJXfcRSBlv/r2mxpLy2Tv2yjiOxmqX4/TMP8LfzVJ
         t/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dXkKY9TV5jKPRQS8npjT2kmqtGeprtOApiCdkfgYiBA=;
        b=aYBdgmjYKSfc/MuBx7IbY3ZdRdeiGJXdrAhhU0aHrDnBzaZt8+anrhZekOx4r1CVB+
         JiGq4qayBbT80yKlBQ44bHvkJ89q7d4pW28dgO8WOfMnpeQe2qpDA9/dgcomoSkzXEhR
         4x40aRk/65FhmCTB2ZosFGKWCFvDkxDFc5AR+gxvdIIxCBU+2KMWMtzsIKVym/0TgK5x
         z8BiBh0KBmlVpe0iKrG0l7Kfg8hauMZzTFean0sBK1uH++kyoPiL5l6cMmzfQbdvVx/U
         bGEQxsDwkGXSOMZ79V6ow5AeDgBpzJPyICMyi3iodVKjZZKOLGPpEOBjVCNR294CzuuH
         tyNw==
X-Gm-Message-State: AOAM530oI1y0F+Ec8NaSoZ9CCk64jPpLL3oLrlxykJ2FJGepqKp9jgw2
        74bif97ckyTgpfS64x+Ykg+bvQ==
X-Google-Smtp-Source: ABdhPJxyP3fn57xchwb8RYb//nVXkLqwMxgKnviK20rQSEkF8U4GquITBii9dwbD2lb1qcYRUKGWzw==
X-Received: by 2002:a17:907:160c:: with SMTP id hb12mr9439119ejc.652.1642504736785;
        Tue, 18 Jan 2022 03:18:56 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.239])
        by smtp.gmail.com with ESMTPSA id h2sm5267548ejo.169.2022.01.18.03.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 03:18:56 -0800 (PST)
Date:   Tue, 18 Jan 2022 19:18:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Marco Elver <elver@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf test: Test 73 Sig_trap fails on s390
Message-ID: <20220118111849.GB98966@leoy-ThinkPad-X240s>
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
 <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <46d27f58-7732-3359-e0aa-090468a1cb22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d27f58-7732-3359-e0aa-090468a1cb22@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi John,

On Tue, Jan 18, 2022 at 10:20:37AM +0000, John Garry wrote:

[...]

> > static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> > {
> >          ...
> > 
> >          if (!BP_SIGNAL_IS_SUPPORTED) {
> >                  pr_debug("Test not supported on this architecture");
> >                  return TEST_SKIP;
> >          }
> > 
> >          ...
> > }
> > 
> > Since we have defined BP_SIGNAL_IS_SUPPORTED, I think we can reuse it at
> > here.
> 
> 
> Do you know any other architectures which would have this issue? Or a
> generic way to check for support?
> 
> It's better to not have to add to this list arch-by-arch..

Yeah, it's ugly to add archs one by one.  But I don't find an ABI can
be used to make decision if an arch supports signal handler for
breakpoint.  Usually, it's architecture specific operations for signal
handling, see the code [1]; simply to say, architecture needs to disable
single step when call signal handler and restore single step after
return from signal handler.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/signal.c#n830

> > > And fails on my x86 broadwell machine:
> > > 
> > > john@localhost:~/kernel-dev2/tools/perf> sudo ./perf test -v 73
> > > 73: Sigtrap                                                         :
> > > --- start ---
> > > test child forked, pid 22255
> > > FAILED sys_perf_event_open(): Argument list too long
> > > test child finished with -1
> > > ---- end ----
> > > Sigtrap: FAILED!
> > > john@localhost:~/kernel-dev2/tools/perf>
> > It is a bit suprise for the failure on x86, as I remembered x86 platform
> > can support signal handler with hw breakpoint.  And from the error
> > "Argument list too long", it should be a different issue from other
> > archs.
> 
> Yeah, I don't know what's going on here.

Seems to there have incompatible issue.
Maybe you could cleanup with "make clean" and then rebuild perf.

Thanks,
Leo
