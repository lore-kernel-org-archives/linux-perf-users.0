Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B07C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 May 2022 14:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbiEKOBC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 May 2022 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbiEKOAz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 May 2022 10:00:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706B140D1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 07:00:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i5so3097565wrc.13
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PP4n1NdHg9QHiLkwHMI2DKYBSLICDPjo1UeB4YFK0mk=;
        b=RGNbqfeCmMq8/GNn84N/gizYPcA6O+qs/CXjLRVFfORFtL57JhKm/rqDxHgwa7Kxev
         09VAjndF+7UPP9e3k/hqmnpF9kwYKmRrWFrfptFOZJMsyNBnu8laZwLsR28TNYB2CkSk
         R/Qru62yOUTw4XuILJO2xSuo06HcqnBb+9oVCdXajAwh2W656pVovIXTBYgcuUJFm9uH
         /UzzBmkUamX9E+sUL9CL64I0rXt5bk9Bxp1ZFAx6N+ZnZpzhWE7IPifPRcG0JNyqXZCF
         ww0csyq3V81VY3ytIW52dcmrckU/lbLMPq+odPBqYfNvdHpy1lBW7tKgQFHNT8Znd4JT
         XR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PP4n1NdHg9QHiLkwHMI2DKYBSLICDPjo1UeB4YFK0mk=;
        b=ZcWO3lI9E1VVo0V2Z+nLY9rMgBwQnAdRqcviHEDSKBFPF7ZQrANGmuYi88kA6AySLh
         KjGb/SJgFLFMkHGokCChEDNHJ++zS46ZLLTuYlxEyaBNBtOQOklGTqcj24Lb4SFz+yna
         oYYFFDSAnUmeCbgc0ziqoeNNKmjg5L+oJxzOF4WLoC53eFRaXQA46wFEZWPfIdKU2h8n
         wALr7PNel5nuInHTu9Z0oM9Gv+S9NRjVMfkV/hLjOxLc97QdndyGNhvwAeOSarDX13Gu
         HuQ09SKeFYeLMa+OwdjYKI8d0uteJArPoWvZnFtRHGi4e62IcBtwE7iJc5KucHXpD53E
         Z8Sg==
X-Gm-Message-State: AOAM530u8zIA2BWmYItP3vlS68Tlx752DKJiiIB0eU8c68VGWuwlfqBH
        Uk7iycyFHMvO/6yetmQ9AAGiIl6UUvYQayRYePM6Gg==
X-Google-Smtp-Source: ABdhPJzoiIi5nrpAkY7EXcpSj6fVqXUrBgWe6ZyE5mPWu6R1BrCGDnOr1htd4VMNmJtK2fE3vOHJ1wHCYeMur97WtWo=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr22757965wri.343.1652277651154; Wed, 11
 May 2022 07:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com> <20220511073501.GW76023@worktop.programming.kicks-ass.net>
 <CAP-5=fVoZSusNWfpYDpHvbxF=J0-a2jF+TpxEYLxmtWx6QFZ7A@mail.gmail.com> <20220511135605.GA76023@worktop.programming.kicks-ass.net>
In-Reply-To: <20220511135605.GA76023@worktop.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 11 May 2022 07:00:35 -0700
Message-ID: <CAP-5=fXjW7L+dfW9wfHuG70Ne6rWAHwx1krQUTiB7xEyJ-rmMA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Rewrite jevents program in python
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 11, 2022 at 6:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 11, 2022 at 06:50:59AM -0700, Ian Rogers wrote:
> > On Wed, May 11, 2022 at 12:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, May 11, 2022 at 12:01:26AM -0700, Ian Rogers wrote:
> > >
> > > > The changes here switch from jevents.c to a rewrite in python called
> > > > jevents.py. This means there is a build time dependency on python, but
> > > > such a dependency already exists for asciidoc (used to generate perf's
> > > > man pages).
> > >
> > > You mean just building perf (not the docs) will now require snake stuff?
> > >
> > > That's very tedious :/ I don't typically have snakes on my machines.
> >
> > Hi Peter,
> >
> > You're right that after these changes python is a build requirement
> > for jevents. We could keep the C code around for the case that python
> > isn't there, but I want to do things like remove the string
> > relocations, sort the events by name so we don't linearly search, etc.
> > which would be a massive chore to keep alive on the C side. An
> > alternative would be to have an empty pmu-events.c file that is used
> > for this case. If you wanted to keep things in C and have jevents like
> > event names, you could use the empty version and link in libpfm4.
>
> I'm not normally linking to libpfm4. All I really care about is that I
> can still build a bare cli perf (not even tui). If all the snake stuff
> is purely optional and it just disables some features, but I do get a
> perf out at the end, then I'm all good.
>

Great! I'll add a conditional "empty" file version for this case.

Thanks,
Ian
