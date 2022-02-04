Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35BDC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Feb 2022 13:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244756AbiBDNBT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiBDNBS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Feb 2022 08:01:18 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801C7C06173D
        for <linux-perf-users@vger.kernel.org>; Fri,  4 Feb 2022 05:01:18 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id m10so8414353oie.2
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2022 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxrOWR/gZztW7YQEW1JYcvX+yxiEfvcBy6vYQPVdyHo=;
        b=T7MokBOygJuqC8MwMYoe7IQIR/ylS0JIrnND8YvA1v6psTjrzb5TXKnKBvCCr12ZxH
         Ht8YuvVf0/Ll5yIL0SoniGRNgKyF1+zsWNky/YG+aj1/OvBH4YqkYLptsHJ3gyjBMd/T
         b2KcYQF1AohONEFWoh0WDJFVbw+OC5iuMCHylGVYsVuOZPU1B3PdOtK7a7LBLVwxAtvQ
         ngUUrZUFf7/THPaQ1ZOHLF4GE3g3u04CH1bRkAMmXnaJXoQosglH0uYYZGxdfEOeZ9AR
         gAKryNuiFR7SBqT5gofy2OQQKB0gbGA/A8gNZwLMV1ckf1hhy54BT4sS5+vuMsVfUBAl
         ZQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxrOWR/gZztW7YQEW1JYcvX+yxiEfvcBy6vYQPVdyHo=;
        b=RT07Vwr4cwHVng40HXujvZepXgxyibnJXY36544XCR5/RtzsCp8bk62TfsxBjbYO3T
         5x8SWHu4bf1pdgsNx8dHmZDWWRio8fmhTr49UaVnn+FsRoEfXr4bwlyU5BEIjDtZcAYo
         oWfWqoncRnlTrAYtTBR89bkjM5Fbx+herzAsh2nLholKMPZOr+nkHLOrI1R7ULRAqXvp
         eTvuijgaAxmb4SU7n0Xn4xzThqGG79o22m8l5zAbsk2aRLLfhUykTzqtnlIDRZziZ+P0
         SnLJKz/J6u9dzHHdXP+l0grqeBFzsvSctBdoTcIRzhzEvIs1nlneUIqh4UNziJAgBm5W
         r2iA==
X-Gm-Message-State: AOAM533Ahi6yMDn27WtxEBITmhIQydd14O7red9S8qknaox1WLQCJizO
        jaZMA/FSNQOvjKjcHvPE+RVroNpIMbMxJHuhtMNHHg==
X-Google-Smtp-Source: ABdhPJzUI4MfqfBJjOeHn/jcFyfAqgoyixENV9Tfbs33cptyQeLioq/gssUH7JENaz+cVN5AzO7wM+j/ESGve7by9uY=
X-Received: by 2002:a05:6808:1292:: with SMTP id a18mr1214335oiw.314.1643979675976;
 Fri, 04 Feb 2022 05:01:15 -0800 (PST)
MIME-Version: 1.0
References: <2e96421f-44b5-c8b7-82f7-5a9a9040104b@amd.com> <20220202105158.7072-1-ravi.bangoria@amd.com>
 <CALMp9eQHfAgcW-J1YY=01ki4m_YVBBEz6D1T662p2BUp05ZcPQ@mail.gmail.com>
 <3c97e081-ae46-d92d-fe8f-58642d6b773e@amd.com> <CALMp9eS72bhP=hGJRzTwGxG9XrijEnGKnJ-pqtHxYG-5Shs+2g@mail.gmail.com>
 <9b890769-e769-83ed-c953-d25930b067ba@amd.com>
In-Reply-To: <9b890769-e769-83ed-c953-d25930b067ba@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 4 Feb 2022 05:01:05 -0800
Message-ID: <CALMp9eQ9K+CXHVZ1zSyw78n-agM2+NQ1xJ4niO-YxSkQCLcK-A@mail.gmail.com>
Subject: Re: [PATCH v2] perf/amd: Implement erratum #1292 workaround for F19h M00-0Fh
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     like.xu.linux@gmail.com, eranian@google.com,
        santosh.shukla@amd.com, pbonzini@redhat.com, seanjc@google.com,
        wanpengli@tencent.com, vkuznets@redhat.com, joro@8bytes.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        kvm@vger.kernel.org, x86@kernel.org,
        linux-perf-users@vger.kernel.org, ananth.narayan@amd.com,
        kim.phillips@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Feb 4, 2022 at 1:33 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
>
>
> On 03-Feb-22 11:25 PM, Jim Mattson wrote:
> > On Wed, Feb 2, 2022 at 9:18 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>
> >> Hi Jim,
> >>
> >> On 03-Feb-22 9:39 AM, Jim Mattson wrote:
> >>> On Wed, Feb 2, 2022 at 2:52 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>>>
> >>>> Perf counter may overcount for a list of Retire Based Events. Implement
> >>>> workaround for Zen3 Family 19 Model 00-0F processors as suggested in
> >>>> Revision Guide[1]:
> >>>>
> >>>>   To count the non-FP affected PMC events correctly:
> >>>>     o Use Core::X86::Msr::PERF_CTL2 to count the events, and
> >>>>     o Program Core::X86::Msr::PERF_CTL2[43] to 1b, and
> >>>>     o Program Core::X86::Msr::PERF_CTL2[20] to 0b.
> >>>>
> >>>> Note that the specified workaround applies only to counting events and
> >>>> not to sampling events. Thus sampling event will continue functioning
> >>>> as is.
> >>>>
> >>>> Although the issue exists on all previous Zen revisions, the workaround
> >>>> is different and thus not included in this patch.
> >>>>
> >>>> This patch needs Like's patch[2] to make it work on kvm guest.
> >>>
> >>> IIUC, this patch along with Like's patch actually breaks PMU
> >>> virtualization for a kvm guest.
> >>>
> >>> Suppose I have some code which counts event 0xC2 [Retired Branch
> >>> Instructions] on PMC0 and event 0xC4 [Retired Taken Branch
> >>> Instructions] on PMC1. I then divide PMC1 by PMC0 to see what
> >>> percentage of my branch instructions are taken. On hardware that
> >>> suffers from erratum 1292, both counters may overcount, but if the
> >>> inaccuracy is small, then my final result may still be fairly close to
> >>> reality.
> >>>
> >>> With these patches, if I run that same code in a kvm guest, it looks
> >>> like one of those events will be counted on PMC2 and the other won't
> >>> be counted at all. So, when I calculate the percentage of branch
> >>> instructions taken, I either get 0 or infinity.
> >>
> >> Events get multiplexed internally. See below quick test I ran inside
> >> guest. My host is running with my+Like's patch and guest is running
> >> with only my patch.
> >
> > Your guest may be multiplexing the counters. The guest I posited does not.
>
> It would be helpful if you can provide an example.

Perf on any current Linux distro (i.e. without your fix).

> > I hope that you are not saying that kvm's *thread-pinned* perf events
> > are not being multiplexed at the host level, because that completely
> > breaks PMU virtualization.
>
> IIUC, multiplexing happens inside the guest.

I'm not sure that multiplexing is the answer. Extrapolation may
introduce greater imprecision than the erratum.

If you count something like "instructions retired" three ways:
1) Unfixed counter
2) PMC2 with the fix
3) Multiplexed on PMC2 with the fix

Is (3) always more accurate than (1)?

> Thanks,
> Ravi
