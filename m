Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA647C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 03:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45B161A40
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 03:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbhKRDkg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 22:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242758AbhKRDke (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 22:40:34 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0AC061764
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Nov 2021 19:37:35 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id m6so11244709oim.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Nov 2021 19:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhREUrClrSZH2dV69k4dP6KEPon/EeosTqyONwAMhE8=;
        b=h/yswSEAHXoaF3XDllZ4EdSdNP33Ep69dECFNQYXbaRditDnzLEo4TqssOXwXaj32t
         AQbthw/p59KIuAXL4ARg13SKPvyhy9L3f0xOD5gOCeUgH2yhW5Sld7DZO/l1vZJvYeuX
         HyZKWIlMVm3NHv2MzlGheO9/AfcspzqI4FZKmksdlHWttWg0bGRVHaeSBK6pxvhVMNXz
         aZGNnsDzqCFs9fqr8r7Bhi4w260aA2dLIo7sQIkIWAWBnBB3ZhqW+vF+SETeXiz3Zl+6
         joWHQZDSV6OE/Zy5IaoUSvoVXbH1K6NdRUwO9CgmBpyv1cR5B5V9pqD2M5CnhYFkM9Xo
         HBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhREUrClrSZH2dV69k4dP6KEPon/EeosTqyONwAMhE8=;
        b=4C3ECsDdPfvW4N+2AICD4F1q2zD7uKKrqYARIw3JaVtUUu8Rd2npgGzi0Ny1QhzPpm
         0PPHT3aYhPPr3myrBhwPwnOhLXYmey3tuaChLGXDsXAsqO8SEco/9XYBlJkhJfWA0yvJ
         RQ9h0jPOrAVTQLgzc4QdydafpcWJMJSCDZHFobUTVoERNm1Hq87cVFAq9AdQYWv9Q1Mt
         xw7xoPlx/Bcbi7kWjFjtswbV/h/+6khaSaJcCmp7c0Qx4VvWpHmyMrAp93jcUonV795U
         ShiFermkuPWEyAFtpI9r4vj9pK/ELjgdkM/Bkw2KrIXSXLPzw0iZ95q+pcQcSQavLy9Y
         XVYA==
X-Gm-Message-State: AOAM531ZM0Qup+p1TNLci9NKOwTkN3ixRVHeH2SY83hgBbdou59fOjD/
        QV0oy94h068AqcY9VHowbGMsfeMnj0+u0Y6+69fxkQ==
X-Google-Smtp-Source: ABdhPJw6R6EijKAAU+9v2Nbg4ShYSOpnsofIgXJ09MpaMRaqAeT1b23OwC/u1/kbpmjWdUSdyH+SvqaRgHaRjcNrlFQ=
X-Received: by 2002:aca:3055:: with SMTP id w82mr4614339oiw.2.1637206653715;
 Wed, 17 Nov 2021 19:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20211112235235.1125060-1-jmattson@google.com> <20211112235235.1125060-2-jmattson@google.com>
 <fcb9aea5-2cf5-897f-5a3d-054ead555da4@gmail.com> <CALMp9eR5oi=ZrrEsZpcAJ7AP-Jo2cLGz9GA=SoTjX--TiG4=sw@mail.gmail.com>
 <afb108ed-a2f3-cb49-d0b4-b1bd6739cdb6@gmail.com> <CALMp9eSYvGW=EfuDCyc+fu7gVNnKHmEvFMackYcuZ-sGT8H5uA@mail.gmail.com>
In-Reply-To: <CALMp9eSYvGW=EfuDCyc+fu7gVNnKHmEvFMackYcuZ-sGT8H5uA@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 17 Nov 2021 19:37:22 -0800
Message-ID: <CALMp9eTq2NwhB5cq_LknUjJncKHK2xPuQ5vpTaDN_zCDPT_JWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: Update vPMCs when retiring instructions
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     "Paolo Bonzini - Distinguished Engineer (kernel-recipes.org)" 
        <pbonzini@redhat.com>, Eric Hankland <ehankland@google.com>,
        kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel OTC, Netherlander)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 17, 2021 at 12:01 PM Jim Mattson <jmattson@google.com> wrote:
>
> On Tue, Nov 16, 2021 at 7:22 PM Like Xu <like.xu.linux@gmail.com> wrote:
> >
> > On 17/11/2021 6:15 am, Jim Mattson wrote:
> > > On Tue, Nov 16, 2021 at 4:44 AM Like Xu <like.xu.linux@gmail.com> wrote:
> > >>
> > >> Hi Jim,
> > >>
> > >> On 13/11/2021 7:52 am, Jim Mattson wrote:
> > >>> When KVM retires a guest instruction through emulation, increment any
> > >>> vPMCs that are configured to monitor "instructions retired," and
> > >>> update the sample period of those counters so that they will overflow
> > >>> at the right time.
> > >>>
> > >>> Signed-off-by: Eric Hankland <ehankland@google.com>
> > >>> [jmattson:
> > >>>     - Split the code to increment "branch instructions retired" into a
> > >>>       separate commit.
> > >>>     - Added 'static' to kvm_pmu_incr_counter() definition.
> > >>>     - Modified kvm_pmu_incr_counter() to check pmc->perf_event->state ==
> > >>>       PERF_EVENT_STATE_ACTIVE.
> > >>> ]
> > >>> Signed-off-by: Jim Mattson <jmattson@google.com>
> > >>> Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")
> > >>> ---
> > >>>    arch/x86/kvm/pmu.c | 31 +++++++++++++++++++++++++++++++
> > >>>    arch/x86/kvm/pmu.h |  1 +
> > >>>    arch/x86/kvm/x86.c |  3 +++
> > >>>    3 files changed, 35 insertions(+)
> > >>>
> > >>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > >>> index 09873f6488f7..153c488032a5 100644
> > >>> --- a/arch/x86/kvm/pmu.c
> > >>> +++ b/arch/x86/kvm/pmu.c
> > >>> @@ -490,6 +490,37 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu)
> > >>>        kvm_pmu_reset(vcpu);
> > >>>    }
> > >>>
> > >>> +static void kvm_pmu_incr_counter(struct kvm_pmc *pmc, u64 evt)
> > >>> +{
> > >>> +     u64 counter_value, sample_period;
> > >>> +
> > >>> +     if (pmc->perf_event &&
> > >>
> > >> We need to incr pmc->counter whether it has a perf_event or not.
> > >>
> > >>> +         pmc->perf_event->attr.type == PERF_TYPE_HARDWARE &&
> > >>
> > >> We need to cover PERF_TYPE_RAW as well, for example,
> > >> it has the basic bits for "{ 0xc0, 0x00, PERF_COUNT_HW_INSTRUCTIONS },"
> > >> plus HSW_IN_TX or ARCH_PERFMON_EVENTSEL_EDGE stuff.
> > >>
> > >> We just need to focus on checking the select and umask bits:
> > >
> > > [What follows applies only to Intel CPUs. I haven't looked at AMD's
> > > PMU implementation yet.]
> >
> > x86 has the same bit definition and semantics on at least the select and umask bits.
>
> Yes, but AMD supports 12 bits of event selector. AMD also has the
> HG_ONLY bits, which affect whether or not to count the event based on
> context.

It looks like we already have an issue with event selector truncation
on the AMD side. It's not clear from the APM if AMD has always had a
12-bit event selector field, but it's 12 bits now. Milan, for example,
has at least 6 different events with selectors > 255. I don't see how
a guest could monitor those events with the existing KVM
implementation.
