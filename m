Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12B6C77B7C
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 16:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjEEQoF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjEEQoF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 12:44:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5403813284
        for <linux-perf-users@vger.kernel.org>; Fri,  5 May 2023 09:44:04 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-76375982b6aso147810739f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683305043; x=1685897043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPJ3eJX3Wd0Hq9EHdr00dwY2jAtHzFmYEuKOc8G/h4A=;
        b=ZqMquCJWPGNyK4dPyFWCwMj3HujlFDiCHJlMSIOHkBM5QcCdnQnARk43+mldrOjlQ2
         yURnjy2bXo83BCJCpuoyMmCCZaLsZPFCOUks4RKPnTe7hdeL31HezD5eR0Zth0nj9uPB
         TeTX6sBYbTjRITAHaJECWljT3wjqICCVKQ8sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305043; x=1685897043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPJ3eJX3Wd0Hq9EHdr00dwY2jAtHzFmYEuKOc8G/h4A=;
        b=cHU8vlypolu+UAvm/CxPMyrARbnNJQy9pOiz1saLH/htoJGgo8V2U7KB6Widm6SiNa
         WNlq5FYniI6lSrP+OHXmJ4pzKd0xCvO2wFOqzPZGdgr5oWVva8t9thWSlZ1//9fTfT05
         KG5FCGXnQ914O5M5Kfhw0L0NBaTt0PrUy68yKX7FSdwcA3EqV0WVMQcH/uVNnygC0VZP
         6xenFLuFhmdRqU9hx9pkaCfhkYDy3lID3v5pDgj7zinUxxDUjfXouLW7uTbnorUCMwoc
         BOVnpyzWFa3SxcoNg1wO6EsdfbXVwoi6hR1CCZ8FLVyuQbyugBuQBUEbTtc4/cL2LdBV
         /fbw==
X-Gm-Message-State: AC+VfDwZYwcv9Cv8BkcTC56MsQXFEbtIRhfCOlxIewQ5FVn0921WEEth
        TF3hW4nrGQ+7MblSi0EaoRAErbsprb8xc4fn0gY=
X-Google-Smtp-Source: ACHHUZ7TRHECDxVOIHpYAzCrxCf3adC+3uH4asqawJ5rpThH6oUIOW92dnIVejgtfBakRQf8iFTP8w==
X-Received: by 2002:a92:d950:0:b0:328:6412:df0e with SMTP id l16-20020a92d950000000b003286412df0emr1364348ilq.29.1683305043083;
        Fri, 05 May 2023 09:44:03 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id k17-20020a026611000000b0040bd326b279sm46477jac.167.2023.05.05.09.44.02
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:44:02 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so796515ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:44:02 -0700 (PDT)
X-Received: by 2002:ac8:5716:0:b0:3ef:330c:8f9e with SMTP id
 22-20020ac85716000000b003ef330c8f9emr343597qtw.10.1683304683433; Fri, 05 May
 2023 09:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.7.Id4133d3183e798122dc3b6205e7852601f289071@changeid> <CSE09YL4X0XY.1GAQWAFOOEK42@wheely>
In-Reply-To: <CSE09YL4X0XY.1GAQWAFOOEK42@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:37:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vom15dOxnp=x5RFsk7ZCXGVwUjjrA4z1js-cCB=PDLFg@mail.gmail.com>
Message-ID: <CAD=FV=Vom15dOxnp=x5RFsk7ZCXGVwUjjrA4z1js-cCB=PDLFg@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] watchdog/hardlockup: Move perf hardlockup
 checking/panic to common watchdog.c
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, linuxppc-dev@lists.ozlabs.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Thu, May 4, 2023 at 7:58=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > The perf hardlockup detector works by looking at interrupt counts and
> > seeing if they change from run to run. The interrupt counts are
> > managed by the common watchdog code via its watchdog_timer_fn().
> >
> > Currently the API between the perf detector and the common code is a
> > function: is_hardlockup(). When the hard lockup detector sees that
> > function return true then it handles printing out debug info and
> > inducing a panic if necessary.
> >
> > Let's change the API a little bit in preparation for the buddy
> > hardlockup detector. The buddy hardlockup detector wants to print
>
> I think the name change is a gratuitous. Especially since it's now
> static.
>
> watchdog_hardlockup_ is a pretty long prefix too, hardlockup_
> should be enough?
>
> Seems okay otherwise though.

I went back and forth on names far too much when constructing this
patch series. Mostly I was trying to balance what looked good to me
and what Petr suggested [1]. I'm not super picky about the names and
I'm happy to change them all to a "hardlockup_" prefix. I'd love to
hear Petr's opinion.

[1] https://lore.kernel.org/r/ZFErmshcrcikrSU1@alley
