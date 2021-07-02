Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44481C11F68
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217656141D
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 18:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhGBSDZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jul 2021 14:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhGBSDY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jul 2021 14:03:24 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A58C061762
        for <linux-perf-users@vger.kernel.org>; Fri,  2 Jul 2021 11:00:51 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a6so12699113ioe.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jul 2021 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6i4AtMAfxuHj6dUewQkFdeehfEClu3wbewt0ov3ATOQ=;
        b=JmF+SaQBuRMGQiavh+g7rKja0ZXRGmsTRjsx2EZVCzGcOAmNPv01zOfniiBmTo+5Gk
         1S5JMwZCbLFTJxRx93vi0kQGuR/Mi3MHyfN1Z6/mSfgKE/5yrvrvPo4oqpLJQuhU4Ei/
         UCXSUZqd1KBSuSLsu8t1uiOHa0TnHvYrqxNc2QxXWdZsyYwb4Pm5JlASM9JHdtRjuo9C
         xc1eAYNZUuxtqfr3Ge1//WqpwPBlCzIH8Z8HnuE1ldOcdkjtyhw55leVHdZ8UJ4O/TKW
         IgLexSu974ENQVnpWnPuVzp1xl+rQjtzy59JuBsHjY8tF4XChUhwssfxIvNuV1X4390U
         z6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6i4AtMAfxuHj6dUewQkFdeehfEClu3wbewt0ov3ATOQ=;
        b=XRw0PhYXwJCd47TQ3Dspd0WuSVnnKDC0Xo2SdeQ+MycPbWCe4bdMHJVAn4k2uqnf7W
         Wk31V6FQhWTlAmg4wY9v8lG1eJiQG8BEZWc56Uhr8eONTjM9xwZWvzJHbnrqJajP2qh0
         FM61X2gOjeK7TDuk4dWmliRmcadKSggh0Z4AIOzFP2UWo3Wi4iSvWkCc15MQ0UKJuI7g
         DLINc77wqrV9SDTTl5v20eCvvH2THdB0SYOwRom0erCOz7E+wpVWKLKoJb73Ro8ZZnPE
         443GLQHLD/fJsuSmL7E8/z48RHQ2PhtWKp3z1LMJgUWo2A+ZKftqOstfgTVhuGNEr5VV
         pF+w==
X-Gm-Message-State: AOAM53297T0G9IiMCD8WokRfZIR9faj0aggQf7RUKzPl/hIIdunSyDbU
        1FLe1VfT+AJ26Ahu/UaM/HJM1rB9tO4cktKYOxq3vw==
X-Google-Smtp-Source: ABdhPJwMMptBIdAVrrH8g2/22L2pwo0JTFXqZiZP4iJ0c00iHWIMewwBWPicbdhGzNzpY0ftz8ej3XK0HzWTsNir7GU=
X-Received: by 2002:a05:6602:3403:: with SMTP id n3mr889257ioz.165.1625248851051;
 Fri, 02 Jul 2021 11:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210701093537.90759-1-leo.yan@linaro.org> <20210701093537.90759-3-leo.yan@linaro.org>
 <YN3sas8tWPfWjFqE@kernel.org> <20210702011018.GA251512@leoy-ThinkPad-X240s>
In-Reply-To: <20210702011018.GA251512@leoy-ThinkPad-X240s>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 2 Jul 2021 12:00:39 -0600
Message-ID: <CANLsYkyxaWUCFYWF2LzooYWqeAMq8P4UzxfPWGoYur3LxyD92A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf cs-etm: Remove callback cs_etm_find_snapshot()
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 1 Jul 2021 at 19:10, Leo Yan <leo.yan@linaro.org> wrote:
>
> On Thu, Jul 01, 2021 at 01:25:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jul 01, 2021 at 05:35:36PM +0800, Leo Yan escreveu:
> > > The callback cs_etm_find_snapshot() is invoked for snapshot mode, its
> > > main purpose is to find the correct AUX trace data and returns "head"
> > > and "old" (we can call "old" as "old head") to the caller, the caller
> > > __auxtrace_mmap__read() uses these two pointers to decide the AUX trace
> > > data size.
> > >
> > > This patch removes cs_etm_find_snapshot() with below reasons:
> > >
> > > - The first thing in cs_etm_find_snapshot() is to check if the head has
> > >   wrapped around, if it is not, directly bails out.  The checking is
> > >   pointless, this is because the "head" and "old" pointers both are
> > >   monotonical increasing so they never wrap around.
> > >
> > > - cs_etm_find_snapshot() adjusts the "head" and "old" pointers and
> > >   assumes the AUX ring buffer is fully filled with the hardware trace
> > >   data, so it always subtracts the difference "mm->len" from "head" to
> > >   get "old".  Let's imagine the snapshot is taken in very short
> > >   interval, the tracers only fill a small chunk of the trace data into
> > >   the AUX ring buffer, in this case, it's wrongly to copy the whole the
> > >   AUX ring buffer to perf file.
> > >
> > > - As the "head" and "old" pointers are monotonically increased, the
> > >   function __auxtrace_mmap__read() handles these two pointers properly.
> > >   It calculates the reminders for these two pointers, and the size is
> > >   clamped to be never more than "snapshot_size".  We can simply reply on
> > >   the function __auxtrace_mmap__read() to calculate the correct result
> > >   for data copying, it's not necessary to add Arm CoreSight specific
> > >   callback.
> >
> > Thanks, applied.
>
> Thanks a lot for picking up the patch, Arnaldo!
>
> Hi Mathieu, I supposed to get your review before merging; since
> Arnaldo moves quickly, if you want me to follow up anything relevant
> to this change, please let me know.  Thanks!

I was going to review this set next week.  But it is fine if Arnaldo
has picked it up since enough people have already looked at and tested
this code.

Thanks,
Mathieu

>
> Leo
