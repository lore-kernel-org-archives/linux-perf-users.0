Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10612C77B7F
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 16:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjEEQhx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjEEQhw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 12:37:52 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE1160B4
        for <linux-perf-users@vger.kernel.org>; Fri,  5 May 2023 09:37:51 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3ef35d44612so20175221cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683304670; x=1685896670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yj1n8SZYpHx6GcDEfBZNc+Nz+lwlz9tugCt27cvkK8=;
        b=CMsm/LqGEAj+s7CIDExkm9nhwDFeJQDa+Oeq9fVS2Bmq3gS2DMH4rbkFfJstSWSWVJ
         sE6rFmodbvgtKNrRH1DIZUJNoyIpRSrlkmD5UQQ1e0/L6pdn3226k8bNu4IsYNMmUJHT
         StGBLiDqJmtf8Cr0AU5QJCiTcVq+LrUiMT5JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683304670; x=1685896670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yj1n8SZYpHx6GcDEfBZNc+Nz+lwlz9tugCt27cvkK8=;
        b=HLliOPKpizjMxO4xt/ywHmXmyEzP36TablDS5ImOBHgC5NbClggtMjm4BClxiam3gz
         Kt5oGORI6oc47bGPVqBE1VUcSBx2JV1iWFKzQT3Lvc11UeHXDgNklWeoDjENEnrXFH4T
         zwqjJb4Hdtj6k/jtk7/MaNXAte9nttyvvlAqcggOpT11QzcD0vHj4mFqKJYYo395t8E4
         sR+J8jaAS2QRSdWW5P5k4IRjEEGB/jdhRrrcWW0q3SOvFnlvsRcU7i6EIQqxVkXNoaCE
         /sLT3bMt9PWGUGBueLtcmxy345JCR9WPw7b/oY8CAPCUXNvrBujKy+esaqvh5BVSsp+s
         u0dQ==
X-Gm-Message-State: AC+VfDyHnsYA4elN8hOjzZWMSkyF5FyOTuP2MEObPA2bpLuKZ2a5LP0f
        eq4XsIgHNTPOkfUN/VxsmbiBBExaa7bbfXQLnVM=
X-Google-Smtp-Source: ACHHUZ4bEHedbkqQjhy57z/+2nUPmA5asW5g6XL7rY2bYz16chXbzFohbUmQXn+vycd1LlbYm9oFwg==
X-Received: by 2002:a05:622a:138d:b0:3f0:a3ae:7e69 with SMTP id o13-20020a05622a138d00b003f0a3ae7e69mr3451797qtk.18.1683304670246;
        Fri, 05 May 2023 09:37:50 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id bx13-20020a05622a090d00b003e8160cf93asm729440qtb.80.2023.05.05.09.37.49
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:37:49 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1091991cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:37:49 -0700 (PDT)
X-Received: by 2002:a05:622a:206:b0:3db:1c01:9d95 with SMTP id
 b6-20020a05622a020600b003db1c019d95mr335755qtx.4.1683304668543; Fri, 05 May
 2023 09:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.5.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid> <CSE04EI159N2.2TSXHBN2QLFCM@wheely>
In-Reply-To: <CSE04EI159N2.2TSXHBN2QLFCM@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:37:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXzo3m2dqwtNST+uXGQz6NW_e-B6-tWkJMrHoCTZBT9Q@mail.gmail.com>
Message-ID: <CAD=FV=XXzo3m2dqwtNST+uXGQz6NW_e-B6-tWkJMrHoCTZBT9Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] watchdog/hardlockup: Rename touch_nmi_watchdog()
 to touch_hardlockup_watchdog()
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

On Thu, May 4, 2023 at 7:51=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > In preparation for the buddy hardlockup detector, rename
> > touch_nmi_watchdog() to touch_hardlockup_watchdog() to make it clear
> > that it will touch whatever hardlockup detector is configured. We'll
> > add a #define for the old name (touch_nmi_watchdog) so that we don't
> > have to touch every piece of code referring to the old name.
>
> Is this really helpful? Now it's got two names Could just leave it.
> If you insist then it'd be better just to rename everything in one
> go at the end of a merge window IMO. Conflicts would be trivial.

I'm not picky here. I changed the name since Petr requested names to
be changed for any code I was touching [1] and so I threw this out as
a proposal. I agree that having two names can be confusing, but in
this case it didn't feel too terrible to me.

I'd love to hear Petr's opinion on this name change. I'm happy with:

a) This patch as it is.

b) Dropping this patch (or perhaps just changing it to add comments).

c) Changing this patch to rename all 70 uses of the old name. Assuming
this will go through Andrew Morton's tree, I'd be interested in
whether he's OK w/ this.

d) Dropping this patch from this series but putting it on the
backburner to try to do later (so that the rename can happen at a time
when it's least disruptive).


> > Ideally this change would also rename the arch_touch_nmi_watchdog(),
> > but that is harder since arch_touch_nmi_watchdog() is exported with
> > EXPORT_SYMBOL() and thus is ABI. Add a comment next to the call to
> > hopefully alleviate some of the confusion here.
>
> We don't keep ABI fixed upstream.

I'm happy to be corrected, but my understanding was that kernel devs
made an effort not to mess with things exported via "EXPORT_SYMBOL",
but things exported via "EXPORT_SYMBOL_GPL" were fair game.

I guess maybe my patch calling it "ABI" is a stronger statement than
that, though. Doing a little more research, nobody wants to say that
things exported with "EXPORT_SYMBOL" are ABI, they just want to say
that we make an effort to have them be more stable.

So certainly I should adjust my patch series not to call it ABI, but
I'm still on the fence about whether I should rename this or not. I'd
love to hear other opinions. This rename actually would be a lot
easier than the touch_nmi_watchdog() one since the code referencing
the name "arch_touch_nmi_watchdog" isn't spread so broadly through the
kernel.

[1] https://lore.kernel.org/r/ZFErmshcrcikrSU1@alley

-Doug
