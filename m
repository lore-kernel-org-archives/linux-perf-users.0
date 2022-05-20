Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A690C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 May 2022 17:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350672AbiETR2f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 May 2022 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbiETR2b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 May 2022 13:28:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D7917DDC6
        for <linux-perf-users@vger.kernel.org>; Fri, 20 May 2022 10:28:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so769035wrc.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 May 2022 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlBrfFXLkcBjzvaU5ZE61p8d0548/U8plsIcnYc6nwM=;
        b=AmbYVUjm1Vvk52XX+gT8m9nyVd9UytuO7zSN8e691d+mbvoHmjsMc3RLNZylvOQYEd
         zVzN2oVZE5VSxSZ0ETLdp1LjgvBp4qRgPDMzDPAVIU0gpQVTswTvQECG8uwX066LpKKI
         YEIRmDtjNrpaO3W4dM2Ky78GbZkwkzyF2vpuDPED4OCG9qDL3saqa+x6tp8L6DuVhM59
         QbK5RBe3Cq/eVInec37zHdr3yFJ3c9xUJRYg2uiKRtowHai8bi6VAsjGu3EFmt6GffUt
         lnrtvgFNmq5JClrkBHf7tNeCTeBQMw6mCfTlR54dmHw6YlJUZ2DGyB3juoK/oBhcIZ4E
         m0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlBrfFXLkcBjzvaU5ZE61p8d0548/U8plsIcnYc6nwM=;
        b=3Y3K0d22e9n+YiQXf48nKpSOHpT7DpIodb8JycvrklkQnaaQJFKCIJSJfHwy686Lmd
         cT5uprHSKG/QoF4Fre72xKQ+CNLYGC1SzT+py3YNp9qX/wxnpYkuIBnxX10BsTroajS4
         MGuHDswybp1s4uVjER9fkSqyjLpK3hFwck7/wbXNsehoZYSB7CvwlL3XtUcr4mJRnTFq
         UzfYQHqPl1Qpcq9LvwKDdVI1ixGBC6Onh2OplzE6kLuEpVDDBoid1A7AsGtE3afC7tl8
         UdPwKWL0LL3XuG+PFbLzyLTYYp9rEtS4j9hdyW/tcWfdpu2ncCNeC4+g2fl7sL7/30J8
         GHdA==
X-Gm-Message-State: AOAM531gu/4vlAjeRii51dWzzgBmvyvIkz5DGFmx+YT78+/eAeJ0zAWN
        Mx3s+ZK4nJRu6RvoJNY/+Rqxj2935Rw+hIbLTX2znQ==
X-Google-Smtp-Source: ABdhPJz+I2ODFYGbdO1VhcQmaC6u7o1kmBPfNUDweJO4khAF66jihI5X7p3fHMS8kkj/hBJpwYFY/Rjm2u34bv5Uw+k=
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id
 j13-20020a5d448d000000b0020d07447663mr9282426wrq.654.1653067708557; Fri, 20
 May 2022 10:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <f523b0fe-1262-c1e5-c587-15842ccf0fcf@arm.com> <28509191-3a45-de6d-f5bc-a8e7331c0a9e@huawei.com>
 <5773b630-8159-1eba-481a-1bf3c406c055@arm.com> <cf7d8003-9700-880f-0e46-ff40e6348bb1@huawei.com>
 <7a17256d-cad0-bd94-02e7-f8adaa959654@arm.com> <2d73146a-86fc-e0d1-11b9-432c7431d58a@huawei.com>
 <b4a16e3e-efbe-c06b-1bc3-c02e151a19a6@arm.com>
In-Reply-To: <b4a16e3e-efbe-c06b-1bc3-c02e151a19a6@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 20 May 2022 10:28:16 -0700
Message-ID: <CAP-5=fXL7mVOvkFHgh7NtGnLfpBFKf_gPJ8wRYfJwRY9kpOoag@mail.gmail.com>
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 19, 2022 at 6:53 AM Nick Forrington <nick.forrington@arm.com> wrote:
>
>
> On 19/05/2022 08:59, John Garry wrote:
> > On 18/05/2022 15:14, Robin Murphy wrote:
> >>> Sure, we should have these 32b cores supported for ARCH=arm if they
> >>> are supported for ARCH=arm64. But then does it even make sense to
> >>> have A7 support in arch/arm64?
> >>
> >> That's what I'm getting at. If it is tied to the build target as
> >> you've said above, then there is no point in an AArch64 perf tool
> >> including data for CPUs on which that tool cannot possibly run; it's
> >> simply a waste of space.
> >>
> >> If there is interest in plumbing in support on AArch32 builds as
> >> well, then I'd still be inclined to have a single arch/arm events
> >> directory, and either do some build-time path munging or just symlink
> >> an arch/arm64 sibling back to it. Yes, technically there are
> >> AArch64-only CPUs whose data would then be redundant when building
> >> for AArch32,
> >
> > If size is an issue then we have ways to cut this down, like doing the
> > arch standard events fixup dynamically when running perf tool, or even
> > not describing those events in the JSONs and rely on reading the CPU
> > PMU events folder to learn which of those events are supported.
> >
> > > but those are
> > > such a minority that it seems like an entirely reasonable compromise.
> >
> > @Nick, Can you drop the 32b core support for arm64? Or, if you really
> > want them, look into ARCH=arm pmu-events support?
>
> No problem - I'll resubmit without the 32b-only CPUs.
>
> Thanks,
> Nick
>

I'm hoping with jevents.py [1] then we can do a few things on the size front:

1) relocations - the current pattern of generating '.foo = "foo_Bar"'
means that when perf starts the .foo pointer needs to be updated for
the relocation. If we concatenate the strings together then we can
have 1 relocation, but we'll need an offset and length to get .foo's
value and some kind of iteration abstraction. If we do this then we
could also look to compress the string at compile time.
2) sorting events - not really a compiler size improvement but should
lower some runtime memory usage. We shouldn't need to linearly search
event names, sorting at compile time means we can locate faster, less
paging, etc.
3) we've spoken in the past of the problems of cross-architecture
testing of events, metrics, etc. For metrics, we may want to record
events on one architecture and compute metrics on another. One idea is
to have a fuller jevents mode where everything is built into one
binary, which would make size improvements more valuable.

Another thing with jevents.py is trying to make the pmu-events.c
presentation more consistent with sysfs', which may regress things on
size.

Anyway, I think it is good to have more events and I'm excited to see
this merged in a way that's suitable for John. I'm happy to do more
optionality stuff with jevents.py or the build if that can mean having
more events on ARM32.

Thanks,
Ian

[1] https://lore.kernel.org/linux-perf-users/20220511211526.1021908-1-irogers@google.com/
- show your love with Acked-bys :-D
