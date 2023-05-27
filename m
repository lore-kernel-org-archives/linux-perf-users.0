Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBF1C77B73
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 17:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjE0RAa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 13:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjE0RA3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 13:00:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5AAB
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 10:00:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so30415e9.0
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685206826; x=1687798826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=835du44Mx31StLMyTUW9zq6P6oaX0jDJQHvLjYcMIks=;
        b=g/e2OD8/lcYnFEB7TjPtnUAWhfOd/2bK12EsBn2OA3a46lLILB7qPx4F/iarCiWsg+
         iyesd8VmGUdkZ9rLoSniHWnHSwc8ckYrZ6CD8gCN24R7N9iNaJCesv1kU5CFGdiYA9vi
         Q4J26hnroLEH/p7nYu10W7XCjyvNNXyPzaAtTzQ0E/vY0e6Utx+J38vJe99fCfu+qVXl
         MJqQaVJOs4ZM4tLJK01LDv/Tmdh8tXwZn1JPOww61qLfg8KHe/H6IUd511666F4wE2TK
         kzvsibyzvM7bXYPu17eLPZ06veH3GQzgclXlj5lHpg1s+jl4F6IqPhc/hlBrdwcna2xq
         2QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685206826; x=1687798826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=835du44Mx31StLMyTUW9zq6P6oaX0jDJQHvLjYcMIks=;
        b=OZhPzPQFmzNR1BCwp8r/0Oq/j4+rYZv7229lO0zZ6qkg0s8flTOyg1X4INZ1/kN9FJ
         CEfpLK8zmV/e7EMw5bmIITsSgdiYeHoT4M+bDb4wdjag1CIL4lqDjMI+thhuW7C0UidK
         G3LOL0KHFKcLgWFUSzOMzDr8VaORsnlGyI7LlfYGxoUFlUSJupXEM9KoYR1OHZ5tiW2J
         /WNqd87Y9Q6eNzjGGrevRploRnNxNIOUOZZMfpgcxw7eKYmIkcKZKZaUhaIN0+lhhfNP
         EDHPb8xH5Fx95is0ycvBuC57Tao+fxSLCOIYTsKwI4ZXOAVuSq3C6OcUgroJv0Cmrn++
         aSCQ==
X-Gm-Message-State: AC+VfDzzPXv++2A2b8jKAc3GrBdRxbzv/bsjDeVlF8TJzKl2oHjkMA1s
        whg+MS7875dJSY6kydKPKshc/aWfa09EjUhOymZznQ==
X-Google-Smtp-Source: ACHHUZ4AQ/bE5YgHhD1uPFM4J8yLJ74PCEyrnXodNu4xMmKiVPPom5xBu38zOJ3RsWqN16HNFxmxvevUYXrROl5pj84=
X-Received: by 2002:a05:600c:3b8d:b0:3f1:9396:6fbf with SMTP id
 n13-20020a05600c3b8d00b003f193966fbfmr180106wms.4.1685206826363; Sat, 27 May
 2023 10:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230504110003.2548-1-ravi.bangoria@amd.com> <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X> <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com>
 <ZG8KLbZSECiYaKFc@linux.dev> <20230525142031.GU83892@hirez.programming.kicks-ass.net>
 <ZG+FLdP2kkfI1m2Z@linux.dev> <CAP-5=fWYbzmTETgqJ11y22=JaXDM0gnb4qR6KYeRGmFXw08f-Q@mail.gmail.com>
 <86jzwtdhmk.wl-maz@kernel.org>
In-Reply-To: <86jzwtdhmk.wl-maz@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 27 May 2023 10:00:13 -0700
Message-ID: <CAP-5=fVW6KbUbbEfF3mEFvTfFDC5yKSjSpa+w3D55dG3CNUERw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Nathan Chancellor <nathan@kernel.org>, namhyung@kernel.org,
        eranian@google.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, May 27, 2023 at 6:32=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Sat, 27 May 2023 00:00:47 +0100,
> Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, May 25, 2023 at 8:56=E2=80=AFAM Oliver Upton <oliver.upton@linu=
x.dev> wrote:
> > >
> > > On Thu, May 25, 2023 at 04:20:31PM +0200, Peter Zijlstra wrote:
> > > > On Thu, May 25, 2023 at 07:11:41AM +0000, Oliver Upton wrote:
> > > >
> > > > > The PMUv3 driver does pass a name, but it relies on getting back =
an
> > > > > allocated pmu id as @type is -1 in the call to perf_pmu_register(=
).
> > > > >
> > > > > What actually broke is how KVM probes for a default core PMU to u=
se for
> > > > > a guest. kvm_pmu_probe_armpmu() creates a counter w/ PERF_TYPE_RA=
W and
> > > > > reads the pmu from the returned perf_event. The linear search had=
 the
> > > > > effect of eventually stumbling on the correct core PMU and succee=
ding.
> > > > >
> > > > > Perf folks: is this WAI for heterogenous systems?
> > > >
> > > > TBH, I'm not sure. hetero and virt don't mix very well AFAIK and I'=
m not
> > > > sure what ARM64 does here.
> > > >
> > > > IIRC the only way is to hard affine things; that is, force vCPU of
> > > > 'type' to the pCPU mask of 'type' CPUs.
> > >
> > > We provide absolutely no illusion of consistency across implementatio=
ns.
> > > Userspace can select the PMU type, and then it is a userspace problem
> > > affining vCPUs to the right pCPUs.
> > >
> > > And if they get that wrong, we just bail and refuse to run the vCPU.
> > >
> > > > If you don't do that; or let userspace 'override' that, things go
> > > > sideways *real* fast.
> > >
> > > Oh yeah, and I wish PMUs were the only problem with these hetero
> > > systems...
> >
> > Just to add some context from what I understand. There are inbuilt
> > type numbers for PMUs:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/inc=
lude/uapi/linux/perf_event.h?h=3Dperf-tools-next#n34
> > so the PMU generally called /sys/devices/cpu should have type 4 (ARM
> > give it another name). For heterogeneous ARM there is a single PMU and
> > the same events are programmed regardless of whether it is a big or a
> > little core - the cpumask lists all CPUs.
>
> I think you misunderstood the way heterogeneous arm64 systems are
> described . Each CPU type gets its own PMU type, and its own event
> list. Case in point:
>
> $ grep . /sys/devices/*pmu/{type,cpus}
> /sys/devices/apple_avalanche_pmu/type:9
> /sys/devices/apple_blizzard_pmu/type:8
> /sys/devices/apple_avalanche_pmu/cpus:4-9
> /sys/devices/apple_blizzard_pmu/cpus:0-3
>
> Type 4 (aka PERF_EVENT_RAW) is AFAICT just a way to encode the raw
> event number, nothing else.

Which PMU will a raw event open on? Note, the raw events don't support
the extended type that is present in PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/include/ua=
pi/linux/perf_event.h#n41
as the bits are already in use for being just plain config values. I
suspect not being type 4 is a bug on apple ARM here.

Thanks,
Ian

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
