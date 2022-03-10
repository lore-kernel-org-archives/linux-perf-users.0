Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BEDC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Mar 2022 08:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiCJIyN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCJIyM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Mar 2022 03:54:12 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B6213702C
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Mar 2022 00:53:11 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u3so6793858ljd.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Mar 2022 00:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jD3qAmHEHOnZBOlSRoVT4fbyHPWkJJFfAb9rrNATrd8=;
        b=hmvsaf3fkX8FWufHIYru+XRkYddPr6duj1rIBnMgzWn0yXN7Ntfs+EsS8yOz0B8Q7f
         9HPzW5V7V6V5/RYCxdsun9Q15Age9QD8fCgjEsdU92/zyV1tKgzf2Uky+tryWQpgTZFb
         sZOWyJsPjf0yUZbTUJr3bvZn7w/8glNtxCdK0bAouaw4Zx1UYPFCwpuyGUv+N295Vx70
         O/qAjOzCMChSHyCvnznF/DvNhtOm4/HW2R3pBDko7y/V3d1inPH8XI5UkZjgpW6sxE3n
         F85KF7G3KEXaGTQ9RK4Ghxx20XOYyFRwoTAebKPlDff+GtVC+DehM0YfJTRByCGc5oXZ
         RduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jD3qAmHEHOnZBOlSRoVT4fbyHPWkJJFfAb9rrNATrd8=;
        b=EOgwERYpdaMiGnXYsuTOxy+VLurM83hcxeExDICCesvK6ilsI1e8nCoxHu0LpuBhF+
         IBI9T4hoskVeBACwpXH4e3sFgadAVB2gA4uxb73nBtSCJazUnGWwP1UQqLKFJJZzq5fA
         ug7VL1piftzSILzsKuXebYvX5Px0MTAYnCSBLsrkkOJJBhoifUdae9QgFt+5PPS3t6Rk
         MIo1sZ94hdm446vzFiYMAq9dCcu9Bn8lF0lwU82UUHJcfkiyAs8lO6QjnMFiLUI15C24
         wQOfa91TwvfUp5HPNbx/VAF7JwDzS3wGeVXh+RvXfIDjus5Y0Ff6pnnXnAy1HfURxgj4
         errA==
X-Gm-Message-State: AOAM530yFWPzj6qdXvB+JoHVd7+q6NlfGqJPvuig/z4LwVDZhfAU8sT0
        CS7zC/eAv3NABNchFWNIpVp5auS9W5kMBseXyzEm6DwRGFA=
X-Google-Smtp-Source: ABdhPJwfq4YMtyaCiFkI5YS1rtS5MId7CiqrGT4QVVocDd25aeWPgN8PB/pv30mREFjDy3qHQzDGUtEaUS1LyBGXIGc=
X-Received: by 2002:a05:651c:1051:b0:247:ea0d:a57c with SMTP id
 x17-20020a05651c105100b00247ea0da57cmr2246474ljm.204.1646902389582; Thu, 10
 Mar 2022 00:53:09 -0800 (PST)
MIME-Version: 1.0
References: <DM5PR15MB17390661547DEAA8C397A540F0069@DM5PR15MB1739.namprd15.prod.outlook.com>
 <9b4749a8-f3f3-e2e6-b1d3-8b23d946e10a@arm.com> <DM5PR15MB1739AC36558E0ED388735AB6F00A9@DM5PR15MB1739.namprd15.prod.outlook.com>
 <d34c1b48-e39b-e533-84be-5811f789ee73@arm.com> <DM5PR15MB17393E601961B046B638B923F00A9@DM5PR15MB1739.namprd15.prod.outlook.com>
In-Reply-To: <DM5PR15MB17393E601961B046B638B923F00A9@DM5PR15MB1739.namprd15.prod.outlook.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 10 Mar 2022 00:52:58 -0800
Message-ID: <CAM9d7cjSX8DGDGFAG-_19j=nM4SSBuAF252ixRbuMu+DMENzPg@mail.gmail.com>
Subject: Re: What exactly does -F <freq> do?
To:     Douglas Graham <douglas.graham@ericsson.com>
Cc:     James Clark <james.clark@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Wed, Mar 9, 2022 at 4:56 PM Douglas Graham
<douglas.graham@ericsson.com> wrote:
>
> >> I am already using -a.
> >
> >In that case it does change some of my assumptions. But for this part of your message:
> >
> >    > A "perf stat sleep 1" on the system I'm interested in says:
> >
> >    >            1630370      cycles                    #    1.315 GHz
> >
> >    > As I understand it, the cycles event is used by default, so a 100 Hz sample frequency
> >    > should give the same results as a 13150000 cycles sample period.
> >
> > That command is not system wide or per-CPU which is what my assumption was based one
> > (it's per process mode). So it's not 1.6M cycles in 1 second, it's 1.6M cycles of when
> > the sleep process was actively launching and running, excluding the 1s of sleep. System
> > wide would be 'perf stat -a -- sleep 1'
>
> It could just be me, but I think perf is in dire need of more comprehensive documentation.
> Like, for example, how is that 1.315 GHz computed?  That's actually the number I was using
> to determine the sample period in cycles that should be equivalent to a 100Hz sample
> frequency but now I'm not sure I know where that number comes from or what it means, and
> the perf-stat man page is mum on the subject.  The complete output of that command on this
> quad core arm64 system is:
>
> ~# perf stat -- sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>               1.15 msec task-clock                #    0.001 CPUs utilized
>                  1      context-switches          #    0.872 K/sec
>                  0      cpu-migrations            #    0.000 K/sec
>                 44      page-faults               #    0.038 M/sec
>            1508958      cycles                    #    1.315 GHz
>             679359      instructions              #    0.45  insn per cycle
>              86111      branches                  #   75.059 M/sec
>              10291      branch-misses             #   11.95% of all branches
>
>        1.002371400 seconds time elapsed
>
>        0.002567000 seconds user
>        0.000000000 seconds sys
>
> If I divide the number of cycles by the total cpu usage, I get 1508958/0.002567 == 588 MHz,
> which is pretty far from 1.315 GHz. Where did 1.315 GHz come from?

I think it's cycles / task-clock.

>
> And if I run a CPU intensive program like stress, I get:
>
> # perf stat -- stress -c 1 --timeout 1
> stress-ng: info:  [9166] dispatching hogs: 1 cpu
> stress-ng: info:  [9166] successful run completed in 1.13s
>
>  Performance counter stats for 'stress -c 1 --timeout 1':
>
>            1135.88 msec task-clock                #    0.991 CPUs utilized
>                156      context-switches          #    0.137 K/sec
>                  0      cpu-migrations            #    0.000 K/sec
>               1253      page-faults               #    0.001 M/sec
>         1513809696      cycles                    #    1.333 GHz
>         1546722405      instructions              #    1.02  insn per cycle
>          175801202      branches                  #  154.772 M/sec
>            4725866      branch-misses             #    2.69% of all branches
>
>        1.146401500 seconds time elapsed
>
>        1.128040000 seconds user
>        0.009161000 seconds sys
>
> You're right that now I do see a lot more cycles, and also, dividing cycles by total CPU
> usage gives something pretty close to the 1.333 GHz reported in the comment:
>
>    1513809696/(1.128040 + 0.009161) = 1.331 GHz.
>
> The frequencies reported in these comments are quite close, so I guess they must mean
> something.  OTOH, they aren't identical, so I don't think they're just being read from some
> table somewhere. They must be being computed, but how?

cycles / task-clock = 1513809696 / 1.13588 = 1332719738

>
> And just for fun, here's what the same two runs (sleep and stress) look like with the -a option:
>
> # perf stat -a -- sleep 1
>
>  Performance counter stats for 'system wide':
>
>            4005.15 msec cpu-clock                 #    3.995 CPUs utilized
>               4945      context-switches          #    0.001 M/sec
>                 15      cpu-migrations            #    0.004 K/sec
>                  2      page-faults               #    0.000 K/sec
>           78745230      cycles                    #    0.020 GHz
>           37676196      instructions              #    0.48  insn per cycle
>            5155778      branches                  #    1.287 M/sec
>             749509      branch-misses             #   14.54% of all branches
>
>        1.002497310 seconds time elapsed
>
> # perf stat -a -- stress -c 1 --timeout 1
> stress-ng: info:  [9721] dispatching hogs: 1 cpu
> stress-ng: info:  [9721] successful run completed in 1.14s
>
>  Performance counter stats for 'system wide':
>
>            4598.27 msec cpu-clock                 #    3.991 CPUs utilized
>               7125      context-switches          #    0.002 M/sec
>                 14      cpu-migrations            #    0.003 K/sec
>               1133      page-faults               #    0.246 K/sec
>         1633500454      cycles                    #    0.355 GHz
>         1595921326      instructions              #    0.98  insn per cycle
>          182601726      branches                  #   39.711 M/sec
>            5607300      branch-misses             #    3.07% of all branches
>
>        1.152046320 seconds time elapsed
>
> Now the frequencies displayed in the comments are quite different both from each other, and
> from those displayed without -a.

For system-wide mode, it really depends on how much load
it has at the moment.

>
> I still have the feeling that I'm missing some important concept here. I'll keep trying
> to figure out what it is.

The sampling frequency can be inaccurate if the system is idle
or system load is fluctuating as it's not walltime based.

Thanks,
Namhyung
