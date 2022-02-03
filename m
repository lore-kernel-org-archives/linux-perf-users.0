Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7195C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Feb 2022 17:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiBCR4E (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiBCR4E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Feb 2022 12:56:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA742C06173B
        for <linux-perf-users@vger.kernel.org>; Thu,  3 Feb 2022 09:56:03 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a8so2857259pfa.6
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Feb 2022 09:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8HaK0i9jf2UcVNcXuP8D7mSAZG8MOe1HhPyJaO7I8Q=;
        b=TVxvv5yTB3OUqhojmDstZ7tQWhDcXZ4jpCyqkg9jbivK/C1566qKFHayI7jpBndbQ+
         FOCDC2YcF3usx4dctmk9R8nJyNg5GvlCEv+PpbHsz25fOjUlbU8uSRBs2UcZlde0Behe
         44RhXSykZ2O7bFeb/o9Ed1o9VScqAZVcVTVISw4llgs9aGFtXFypRYf6LaymPbBUfeX6
         OfswONiwh32E/ZUFmZwRaNO40x3TmQLAEaYVK5A+FTnOn/NItMbLQRR8qs7Vnjh4VsAQ
         lnoWBhIsjje0qkqX50LuBjwgjfoPX/4DU7y/RaD4QX7BBnqtFanLTdhJu3FnKVY/1fmv
         grGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8HaK0i9jf2UcVNcXuP8D7mSAZG8MOe1HhPyJaO7I8Q=;
        b=ISTwwBkJ6BZ/xuf8m40CROhG+rkUVPXf7WyaR8CozH4jSILIRCfIjFsVkbE9lI02nJ
         /Dp/n6Ct1K6KsXoqGI8io8qHFvlShg4TfsNe0/9EK46emqZDMoVrVJxPwtF3Ay2u1a4N
         CDCRGtAHseT2Ky3p9dR9TkaQJqOiTMXMapp+EVGMdKjB9PTMyG7zXXgUR2xTNIVfg5lO
         /8NyZ3xsJJJViySJR7BPgUTsCFbyUQkAwTYj6xN9+nkxrePis4mTXV2sHMQ6d3hu1Jpn
         7xp8y++JiYMxLgSCDQsn8MpA1HEBuZkSAUfR/3kwftFTo5ZRCtvK4D8Qb/F4yqEoc5PM
         iLbw==
X-Gm-Message-State: AOAM530VRRp/qil1ASOAqNRGZCUmAWQ2PHl+Sd9KbwFPC9xi0PU/L9Js
        Lo/1fl/T61obka6Rbn59VwNwNg9cM85OPxWIdW/wYw==
X-Google-Smtp-Source: ABdhPJzRZIzU+1TmLjz8JS/znJLlCO2nOV1qFO5xDB83D14HthfaMVGtwy+dHrERqfPkvjx3rBGtF97Ku7LaxYJ3o0g=
X-Received: by 2002:a63:371b:: with SMTP id e27mr28863288pga.618.1643910963109;
 Thu, 03 Feb 2022 09:56:03 -0800 (PST)
MIME-Version: 1.0
References: <2e96421f-44b5-c8b7-82f7-5a9a9040104b@amd.com> <20220202105158.7072-1-ravi.bangoria@amd.com>
 <CALMp9eQHfAgcW-J1YY=01ki4m_YVBBEz6D1T662p2BUp05ZcPQ@mail.gmail.com> <3c97e081-ae46-d92d-fe8f-58642d6b773e@amd.com>
In-Reply-To: <3c97e081-ae46-d92d-fe8f-58642d6b773e@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 3 Feb 2022 09:55:51 -0800
Message-ID: <CALMp9eS72bhP=hGJRzTwGxG9XrijEnGKnJ-pqtHxYG-5Shs+2g@mail.gmail.com>
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

On Wed, Feb 2, 2022 at 9:18 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Jim,
>
> On 03-Feb-22 9:39 AM, Jim Mattson wrote:
> > On Wed, Feb 2, 2022 at 2:52 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>
> >> Perf counter may overcount for a list of Retire Based Events. Implement
> >> workaround for Zen3 Family 19 Model 00-0F processors as suggested in
> >> Revision Guide[1]:
> >>
> >>   To count the non-FP affected PMC events correctly:
> >>     o Use Core::X86::Msr::PERF_CTL2 to count the events, and
> >>     o Program Core::X86::Msr::PERF_CTL2[43] to 1b, and
> >>     o Program Core::X86::Msr::PERF_CTL2[20] to 0b.
> >>
> >> Note that the specified workaround applies only to counting events and
> >> not to sampling events. Thus sampling event will continue functioning
> >> as is.
> >>
> >> Although the issue exists on all previous Zen revisions, the workaround
> >> is different and thus not included in this patch.
> >>
> >> This patch needs Like's patch[2] to make it work on kvm guest.
> >
> > IIUC, this patch along with Like's patch actually breaks PMU
> > virtualization for a kvm guest.
> >
> > Suppose I have some code which counts event 0xC2 [Retired Branch
> > Instructions] on PMC0 and event 0xC4 [Retired Taken Branch
> > Instructions] on PMC1. I then divide PMC1 by PMC0 to see what
> > percentage of my branch instructions are taken. On hardware that
> > suffers from erratum 1292, both counters may overcount, but if the
> > inaccuracy is small, then my final result may still be fairly close to
> > reality.
> >
> > With these patches, if I run that same code in a kvm guest, it looks
> > like one of those events will be counted on PMC2 and the other won't
> > be counted at all. So, when I calculate the percentage of branch
> > instructions taken, I either get 0 or infinity.
>
> Events get multiplexed internally. See below quick test I ran inside
> guest. My host is running with my+Like's patch and guest is running
> with only my patch.

Your guest may be multiplexing the counters. The guest I posited does not.

I hope that you are not saying that kvm's *thread-pinned* perf events
are not being multiplexed at the host level, because that completely
breaks PMU virtualization.
