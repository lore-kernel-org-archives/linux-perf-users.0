Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71433C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D855610D2
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 12:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhKKMp4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 07:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhKKMp4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 07:45:56 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D1AC061766
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 04:43:07 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id q17so5634205plr.11
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=USmt7anIX2PGWTer7zUxYY8feegDwUP1c/up9xPpWxQ=;
        b=EV7cgYZzVbRJqEkWsNadZUif+UZxU2GpYogF9EHqzIXFbNQMV1fbnXo0aNC2CEk/Zc
         JQa8SHrgnN9l+GejMu0tLcIRL+P5eTtfip1eAbX+VxE5S1sLOIo5wCKSO7AzboFR8LY1
         e2HicZy+kn/B9YxEjDbemf6+WZKncJHwLWIJO6+gv3Ch7GmDlDDOKSiE8JBIWneeMUPk
         CpZ0SeRNn44CddAC9GPjPMV9pvM6xWM01UuzboVvUKxEWWwAo51zX4icFdeqnwf4BiJK
         cSoCrJSXD8M1KAZmljromnbmXaekELJTrwrU70ULoXLrsulpJRQcOrJNk+i9pgbfagfl
         FTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=USmt7anIX2PGWTer7zUxYY8feegDwUP1c/up9xPpWxQ=;
        b=zJLMkmt7LdBwBoHojckOcu1N4KgWZ3GjPz65jpHgAGLzqLXQBtMjEeC6khXB/vPfRf
         YMqqzjf6YU/uJEHkBlgmqztFlruH1WTyIir2SGIJHEXTXTyBJXX7vIjde4VWiHplMWoZ
         dxKICxsVWHE2uAeQVS0AHld29f9HxzIbZ6k2eKTu1lopzBP6+naZn7AuLK7jLfRay6Vx
         z6USBijTmBibUNW3zOQ+f1Bf94oKfUM9apMR6vqiHz8Bu/0xbq9d3s8gZ6befVPRjfuT
         benyg2RGNUyydn4ZczNHt9qEAWqzZVv6toWYoyrg9SqGOZPPbvs7GHeGn1KHM2eIU40v
         5+hA==
X-Gm-Message-State: AOAM532ydhgauV8xn4AkGjxv+WvM21c8I5mEfBGb7709KkOanS7LYSSp
        lewGMLKqc7F5gRuykzpu4ERA8Q==
X-Google-Smtp-Source: ABdhPJy7hrsMSt+vPE9iMVSb0pdsSDnMMkt91nNIT+76HeRNO/Dd8x46k3CwmJaSmj+JwZhALbwwcA==
X-Received: by 2002:a17:90b:380e:: with SMTP id mq14mr26585493pjb.74.1636634586974;
        Thu, 11 Nov 2021 04:43:06 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id j7sm8888551pjf.41.2021.11.11.04.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 04:43:06 -0800 (PST)
Date:   Thu, 11 Nov 2021 20:42:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] perf arm-spe: Support hardware-based PID tracing
Message-ID: <20211111124257.GB106654@leoy-ThinkPad-X240s>
References: <20211109115020.31623-1-german.gomez@arm.com>
 <20211109115020.31623-5-german.gomez@arm.com>
 <CAM9d7cg7Lp49xOc3BOhM4O9fqs7i+v6cNd=eaKWjDbREiE3Pvg@mail.gmail.com>
 <20211111074148.GC102075@leoy-ThinkPad-X240s>
 <CAM9d7cjW_=hDkHVWchNFDyqZXbbBwMb224hbZTMsCe34MLL-4Q@mail.gmail.com>
 <20211111083002.GA106401@leoy-ThinkPad-X240s>
 <5c0e255b-e140-d157-7dfd-b27a43e128c9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0e255b-e140-d157-7dfd-b27a43e128c9@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 11, 2021 at 12:23:08PM +0000, German Gomez wrote:
> On 11/11/2021 08:30, Leo Yan wrote:
> > On Wed, Nov 10, 2021 at 11:59:05PM -0800, Namhyung Kim wrote:

[...]

> >>>>> +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
> >>>>> +{
> >>>>> +       struct arm_spe *spe = speq->spe;
> >>>>> +       int err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
> >>>>
> >>>> I think we should pass -1 as pid as we don't know the real pid.
> >>>>
> >>> AFAICT, I observe one case for machine__set_current_tid() returning error
> >>> is 'speq->cpu' is -1 (this is the case for per-thread tracing).  In
> >>> this case, if pass '-1' for pid/tid, it still will return failure.
> >>>
> >>> So here should return the error as it is.  Am I missing anything?
> >>
> >> I'm not saying about the error.  It's about thread status.
> >> In the machine__set_current_tid(), it calls
> >> machine__findnew_thread() with given pid and tid.
> >>
> >> I suspect it can set pid to a wrong value if the thread has
> >> no pid value at the moment.
> >
> > Here we should avoid to write pid '-1' with
> > machine__set_current_tid().
> 
> If the kernel is writing the tids to the contextidr, isn't it wrong to
> assume tid == pid when decoding the context packets here? I haven't
> observed any impact in the built-in commands though, so there must be
> something I'm not seeing.

Okay, let me correct myself :)

I checked Intel-pt's implementation, I understand now that we need to 
distinguish the cases for pid/tid from context switch event and only tid
from SPE context packet.

Since the context switch event contains the correct pid and tid
values, we should set both of them, see Intel-PT's implementation [1].

As Namhyung pointed, we need to set pid as '-1' when we only know the
tid value from SPE context packet; see [2].

So we should use the same with Intel-pt.

Sorry for I didn't really understand well Namhyung's suggestion and
thanks you both pointed out the issue.

Leo

P.s. an offline topic is we should send a patch to fix cs-etm issue
as well [3].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/intel-pt.c#n2920
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/intel-pt.c#n2215
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/cs-etm.c#n1121
