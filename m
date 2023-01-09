Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424C5C5479D
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Jan 2023 19:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbjAIT5C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjAIT5B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 14:57:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5933A11C05
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Jan 2023 11:56:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso13995266pjt.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2023 11:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0/0D3Mo+wWzikUduU1CAWV0Q8LsaDVd0/kxK56kXw8=;
        b=OwX1Qbq6gonTa1LwP39ZsEU2QCCmVCurCBjbRc9yTUKyXZH8CHaDklcQWIYMrQFNWJ
         UrGnDfWU2LfqjqxunfcPKXvQksl7MuXGseixNYA5MxF3pr9ZOCBupn5GbsVDr/YxwU2i
         0DwMvH2EbjOBNVkS0i5/uPqlAvdbA90lDoBOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0/0D3Mo+wWzikUduU1CAWV0Q8LsaDVd0/kxK56kXw8=;
        b=fQiSI8rcAvXcp5LmT5XKsHx33/vrZPV7Y0NnHHvEEbYsVEeu3r2xwqQlN/L8nt16J+
         z9q4OV5n1q0Hz3K+3+lVlV6xN2aSSjplSck8SWDF0TgwpAx7E08I+9bdoD5zLCzBBFJx
         pGjEFmpWBXHqorEMs49PaPmcOrUjIlsbCSFaJeqwVS5VOWAm5UuMJbwFk6Yatmu7aD6T
         NUkNi7CpIiFqmhZJxJCmLC59LQ57d/jMPN7xgbfurm/Imu8uAu2+7nN36QMnRz85rhIK
         6dYk2HEaceRpk46j9HljCkCqNVQOV4Wx+GyxrPAcaNoeFRzhtdV9wh5PFFzg8ioZS9+Q
         pJAw==
X-Gm-Message-State: AFqh2kqxd+TqcOw4RbuvWuvij7P/fWhNFDoc/JTKUo5PHDjsh+Xl5wai
        /Rz4y7Yr5sv4uV5C9XRX/UcFIdXohU78ALd5dgAl
X-Google-Smtp-Source: AMrXdXsTJ7aO2iHHoPnOlTsETf7fuA9nWCMKbupCxgU+CEyC/kSDdnp1NEvXq0hwRCfiNrNdXwSC1KZF42ZCb3bvN1M=
X-Received: by 2002:a17:902:6b83:b0:192:d373:2e02 with SMTP id
 p3-20020a1709026b8300b00192d3732e02mr2064310plk.75.1673294218760; Mon, 09 Jan
 2023 11:56:58 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUKNFNRs6WkPNWV94BuLmT3KSPWK2FYCiD4PxPCxRs76PA@mail.gmail.com>
 <Y7wLa7I2hlz3rKw/@hirez.programming.kicks-ass.net>
In-Reply-To: <Y7wLa7I2hlz3rKw/@hirez.programming.kicks-ass.net>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 9 Jan 2023 11:56:47 -0800
Message-ID: <CAOnJCU+qsJk9oL-2L8fJuGvpaJsyfwQ5+wFXA1L1jM6Fe=FK6A@mail.gmail.com>
Subject: Re: Expected rdpmc behavior during context swtich and a RISC-V conundrum
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Beeman Strong <beeman@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 9, 2023 at 4:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 05, 2023 at 11:59:24AM -0800, Atish Patra wrote:
> > Hi All,
> > There was a recent uabi update[1] for RISC-V that allows the users to
> > read cycle and instruction count without any checks.
> > We tried to restrict that behavior to address security concerns
> > earlier but it resulted in breakage for some user space
> > applications[2].
> > Thus, previous behavior was restored where a user on RISC-V platforms
> > can directly read cycle or instruction count[3].
> >
> > Comparison with other ISAs w.r.t user space access of counters:
> > ARM64
> >   -- Enabled/Disabled via (/proc/sys/kernel/perf_user_access)
> >   -- Only for task bound events configured via perf.
> >
> > X86
> >  --- rdpmc instruction
> >  --- Enable/Disable via =E2=80=9C/sys/devices/cpu/rdpmc=E2=80=9D
> > -- Before v4.0
> >  -- any process (even without active perf event) rdpmc
> > After v4.0
> > -- Default behavior changed to support only active events in a
> > process=E2=80=99s context.
> > -- Configured through perf similar to ARM64
> > -- Continue to maintain backward compatibility for unrestricted access
> > by writing 2 to =E2=80=9C/sys/devices/cpu/rdpmc=E2=80=9D
> >
> > IMO, RISC-V should only enable user space access through perf similar
> > to ARM64 and x86 (post v4.0).
> > However, we do have to support the legacy behavior to avoid
> > application breakage.
> > As per my understanding a direct user space access can lead to the
> > following problems:
> >
> > 1) There is no context switch support, so counts from other contexts ar=
e exposed
> > 2) If a perf user is allocated one of these counters, the counter
> > value will be written
> >
> > Looking at the x86 code as it continues to allow the above behavior,
> > rdpmc_always_available_key is enabled in the above case. However,
> > during the context switch (cr4_update_pce_mm)
> > only dirty counters are cleared. It only prevents leakage from perf
> > task to rdpmc task.
> >
> > How does the context switch of counters work for users who enable
> > unrestricted access by writing 2 to =E2=80=9C/sys/devices/cpu/rdpmc=E2=
=80=9D ?
> > Otherwise, rdpmc users likely get noise from other applications. Is
> > that expected ?
> > This can be a security concern also where a rogue rdpmc user
> > application can monitor other critical applications to initiate side
> > channel attack.
> >
> > Am I missing something? Please correct my understanding of the x86
> > implementation if it is wrong.
>
> So on x86 we have RDTSC and RDPMC instructions. RDTSC reads the
> Time-Stamp-Counter which is a globally synchronized monotonic increasing
> counter at some 'random' rate (idealized, don't ask). This thing is used
> for time-keeping etc..
>
> And then there's RDPMC which (optionally) allows reading the PMU
> counters which are normally disabled and all 0.
>
> Even if RDPMC is unconditionally allowed from userspace (the 2 option
> you refer to) userspace will only be able to read these 0s unless
> someone also programs the PMU. Linux only supports a single means of
> doing so: perf (some people use /dev/msr to poke directly to the MSRs
> but they get to keep all pieces).
>

It makes sense now. Thanks!!

AFAIK, the /dev/msr interface is also allowed for root users only. So that
covers the security concerns I was asking about.

> RDPMC is only useful if you read counters you own on yourself -- IOW
> selfmonitoring, using the interface outlined in uapi/linux/perf_events.h
> near struct perf_event_mmap_page.
>
> Any other usage -- you get to keep the pieces.
>
> Can you observe random other counters, yes, unavoidably so. The sysfs
> control you mention was instituted to restrict this somewhat.
>
> If the RISC-V counters are fundamentally the PMU counters that need to
> be reset to trigger events, then you've managed to paint yourself into a
> tight spot :/
>
> Either you must dis-allow userspace access to these things (and break
> them) or limit the PMU usage -- both options suck.
>
>
> Now, I'm thinking that esp. something like instruction count is not
> synchronized between cores (seems fundamentally impossible) and can only
> be reasonably be consumed (and compared) when strictly affine to a
> particular CPU, you can argue that applications doing this without also
> strictly managing their affinity mask are broken anyway and therefore
> your breakage is not in fact a breaking them -- you can't break
> something that's already broken.
>

I think most broken applications were using rdcycle to measure time
which was wrong anyways.
It probably happened because there was no "time" CSR in the early
hardwares. Thus, the rdtime would
trap & emulated by the firmware which was slow. This lead to user
space application to use rdcycle which
was not correct either. So the existing applications are broken for
using rdcycle as well.

Since both cycle & instret behave similarly (fixed counters), they get
enabled/disabled together.

>
> Anyway, given RISC-V being a very young platform, I would try really
> *really* *REALLY* hard to stomp on these applications and get them to
> change in order to reclaim the PMU usage.

Yes. Thanks for your valuable input.

--=20
Regards,
Atish
