Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD84C43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 17:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbiFORM5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiFORM4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 13:12:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7137523163
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 10:12:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c21so16274508wrb.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2e/1LSZYAT68MJ3L2CCgpie2RwrLKmQnEWSqIezga84=;
        b=iM3lVGdoDqa1Q6Bd5bG/hYhkBaG6m14TRBGnMKncBv7HTTYJVLxzAOgQck5MQVSwpK
         Wb5UuMmirpFhkiASjTajxmaSRzZbh88Uiv2oLsr1ekmlkr6IzlHQuQmav65wQaOmHAJQ
         w1HS0Xw60ceYt/on2TWdWbxBGddSmhBHRwunIIeIlKWo3AARHKVAT5/nZvV68+/AbnH3
         V9k2aTGfMMKaRcsqBai/1mOpWpEqTo4uRRebWlQt7Y0IyaltGyaQYTMOChqiOr4TybJU
         GcFLrJ+8miSlaNodbSQ10psC91QADRhQ6MJwO6QfDQ6UHTH0LkgqrfaaWRgzvzWXBvb/
         mj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2e/1LSZYAT68MJ3L2CCgpie2RwrLKmQnEWSqIezga84=;
        b=5Wgl5GtwTdcGc+6sFaqUWZ91OuxZKykqAFjgMRALou/Ppls1Y+g/gQxJu0VtaTbAcF
         53ehWOTfKmuUi5034imx/bskSIfHFWGt/L/dXmjOhxNDpCGoOk8uGWft+MmsUWx1yIkO
         jbbgtgfFYgWOGv7qGIFf3FvhY8iwEw4fT5MP8/HFgbMfPIDYIblthxA+8JuFouQGaBUy
         sQ2ZyxEC8E4zPxlGV108u1hRyYOohw77VOErxVT1giuQbO8jPCDWDX7290M6U5UIcquk
         rKEKe7vK18YCEX94xuUH3ikvhibrbpx472HO7RKB74Q4wJy+hA/iwsBjFA1BLVLBbLR1
         tQUQ==
X-Gm-Message-State: AJIora8+dY5jHyTbj8rWJ/VCjd+b3csLLW97HEXg5Vviq/nMSc2ALBps
        dYbCJwEUfFjoF4ilTUDPMs4hM7g2k0uICM/zQJLoWuoDTjJI5PNS
X-Google-Smtp-Source: AGRyM1tnmOWKZ3XfSNnpk7zK3Kd9OteOj3fEz3F2fMNZKmcm4a6CYIcNpilSFQ2gbQlRFhwveDh/ephRpzWbfSBwJyY=
X-Received: by 2002:adf:f5c4:0:b0:210:2ac2:6aa0 with SMTP id
 k4-20020adff5c4000000b002102ac26aa0mr792045wrp.300.1655313173737; Wed, 15 Jun
 2022 10:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <b205da6a-d9a7-4c4b-521d-1b2515f6db4b@linux.ibm.com>
In-Reply-To: <b205da6a-d9a7-4c4b-521d-1b2515f6db4b@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jun 2022 10:12:40 -0700
Message-ID: <CAP-5=fXt1LHgf=vL7KNW6L9MTCVQY_ku8z_cwmXxk9iPmwk2ig@mail.gmail.com>
Subject: Re: Strange behavior when event installed systemwide multiple times
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 15, 2022 at 6:30 AM Thomas Richter <tmricht@linux.ibm.com> wrot=
e:
>
>
> I have a question regarding the behavior when 2 events are installed
> system-wide on the same CPU, for example:
>
>  # perf stat -e cpu-cycles -a -C0 -- sleep 5 &
>  # sleep 2
>  # perf stat -e instructions -a -C0 -- true
>
> I wonder why at the 2nd perf invocation the event cpu-cycles is deleted
> from CPU 0 just to be re-added immediately. I understand this is necessar=
y
> for events attached to a process. This is also done when the event is
> installed system wide, and is not connected to a process.
>
> Looking at the trace
>  # tracer: function
>  #
>  #                    _-----=3D> irqs-off
>  #                   / _----=3D> need-resched
>  #                  | / _---=3D> hardirq/softirq
>  #                  || / _--=3D> preempt-depth
>  #                  ||| /     delay
>  # TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
>  #    | |       |   ||||       |         |
>    perf-19574 [000] d... 10588.974577: x86_pmu_add <-event_sched_in.isra.=
130
>                                 ---> 1st perf runs and 1st event installe=
d
>    perf-19574 [000] d... 10588.974582: x86_pmu_start <-x86_pmu_enable
>    perf-19579 [000] d... 10590.974582: x86_pmu_del <-event_sched_out.isra=
.116
>    perf-19579 [000] d... 10590.974583: x86_pmu_stop <-x86_pmu_del
>                                 ---> 2nd perf runs and 1st event is delet=
ed
>    perf-19579 [000] d... 10590.974585: x86_pmu_add <-event_sched_in.isra.=
130
>                                 ---> 1st event cpu-cycles re-added
>    perf-19579 [000] d... 10590.974586: x86_pmu_add <-event_sched_in.isra.=
130
>    perf-19579 [000] d... 10590.974586: x86_pmu_start <-x86_pmu_enable
>    perf-19579 [000] d... 10590.974587: x86_pmu_start <-x86_pmu_enable
>    perf-19579 [000] d... 10590.975361: x86_pmu_del <-event_sched_out.isra=
.116
>                                 ---> 2nd perf stops and 2nd event removed
>    perf-19579 [000] d... 10590.975361: x86_pmu_stop <-x86_pmu_del
>    perf-19574 [000] d... 10593.975959: x86_pmu_del <-event_sched_out.isra=
.116
>    perf-19574 [000] d... 10593.975961: x86_pmu_stop <-x86_pmu_del
>                                 ---> 1st perf stops and 1st event removed=
.
>
> Is this intended behavior?

It is intended behavior to my knowledge. Every PMU has a context with
per task and per CPU events that may be either pinned or flexible.
Events are scheduled in the order they were opened, when multiplexing
happens we play with that order removing the front event and putting
it at the back. As the scheduling decision is complex the code
schedules everything out and then schedules everything back in, but as
you are pointing out this creates holes in sampling. I believe there
have been patches to make it so we don't do that for say system wide
events, but the change needed to be robust to failing to schedule and
I'm not sure it landed.

Thanks,
Ian

> Thanks a lot.
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
