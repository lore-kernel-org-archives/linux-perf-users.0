Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86382C77B7C
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 16:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjEEQfv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjEEQfq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 12:35:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0AA191C8
        for <linux-perf-users@vger.kernel.org>; Fri,  5 May 2023 09:35:45 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75178b082a5so91664085a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683304543; x=1685896543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpDnC2craXa71PgQOtY/fZMYoEOsNHjFRztUygfINOs=;
        b=nDSG83gvAxsI1q5Lf2iXaJn5kgyIzRmDZ88V/iuExJBMKAZ8ItX2XgzNS+HhRZBT4Z
         CYf8PwhRLPKs/vqjZugnfa99wmW2iBYXxN31X8IFnP+Q89BrEBQjJhUhpn7U2Ng5zkvx
         AMspwL2r6mcXM74FVBZXvqTKaYpGltgFnBVwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683304543; x=1685896543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpDnC2craXa71PgQOtY/fZMYoEOsNHjFRztUygfINOs=;
        b=G4+1or+zvIJgX7UK27BmMEZ5ZsQvOgaUaCAKbRZjcp69pXQiLaA2Qso97N1hPS+hjb
         sV09bsWcWtS8lL+VUc4+Zz7g6cQSo/f2k1veNAR1dMWRQogOlICiwBHwk7NLLL+Y5a8H
         wJRpK8V81Vw6+BgSBmHGhIlE8WqyYWB8R41Z/K0KjFJLiyoMdaF7BFoWl0eOTYzm7mBW
         qQXrrS/hv/hzgQW/pqLfjZCkYVeHdmYuFn5AlOrnOb8+lLmSW7xHQaiIVTsGfWoGxQaQ
         xSdmptFybSUqQxkoyYHwsI+d13C9r0dAigxTv58e1bqw5wq2cH7TTN04tLUbQA2lUmRa
         bgBw==
X-Gm-Message-State: AC+VfDxJ2Z1LF2Pl1rhyESX2OLnjk6cSHLvhc8Ne8t7gxfxd+7UtW5mg
        wN8rPUsDfflVGnWfHRPwbySX1RZQ583COgENsbc=
X-Google-Smtp-Source: ACHHUZ6aVByVT71VYjq7a5kjTVRwv631Z0CUVIBPxn0M3ezeq8I87+gqWsD1WChnyrEnyV2C1Q7MaA==
X-Received: by 2002:a05:6214:20a5:b0:5fd:7701:88c5 with SMTP id 5-20020a05621420a500b005fd770188c5mr2303408qvd.6.1683304542745;
        Fri, 05 May 2023 09:35:42 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id o16-20020a0ce410000000b005dd8b93459esm712383qvl.54.2023.05.05.09.35.39
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:35:40 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f0a2f8216fso1093211cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:35:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1981:b0:3ed:210b:e698 with SMTP id
 u1-20020a05622a198100b003ed210be698mr317734qtc.7.1683304539483; Fri, 05 May
 2023 09:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid> <CSDZSKA38AEF.FY7J3JXBJX4I@wheely>
In-Reply-To: <CSDZSKA38AEF.FY7J3JXBJX4I@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:35:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
Message-ID: <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] watchdog/hardlockup: detect hard lockups using
 secondary (buddy) CPUs
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        Colin Cross <ccross@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Thu, May 4, 2023 at 7:36=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > From: Colin Cross <ccross@android.com>
> >
> > Implement a hardlockup detector that doesn't doesn't need any extra
> > arch-specific support code to detect lockups. Instead of using
> > something arch-specific we will use the buddy system, where each CPU
> > watches out for another one. Specifically, each CPU will use its
> > softlockup hrtimer to check that the next CPU is processing hrtimer
> > interrupts by verifying that a counter is increasing.
>
> Powerpc's watchdog has an SMP checker, did you see it?

No, I wasn't aware of it. Interesting, it seems to basically enable
both types of hardlockup detectors together. If that really catches
more lockups, it seems like we could do the same thing for the buddy
system. If people want, I don't think it would be very hard to make
the buddy system _not_ exclusive of the perf system. Instead of having
the buddy system implement the "weak" functions I could just call the
buddy functions in the right places directly and leave the "weak"
functions for a more traditional hardlockup detector to implement.
Opinions?

Maybe after all this lands, the powerpc watchdog could move to use the
common code? As evidenced by this patch series, there's not really a
reason for the SMP detection to be platform specific.


> It's all to
> all rather than buddy which makes it more complicated but arguably
> bit better functionality.

Can you come up with an example crash where the "all to all" would
work better than the simple buddy system provided by this patch? It
seems like they would be equivalent, but I could be missing something.
Specifically they both need at least one non-locked-up CPU to detect a
problem. If one or more CPUs is locked up then we'll always detect it.
I suppose maybe you could provide a better error message at lockup
time saying that several CPUs were locked up and that could be
helpful. For now, I'd keep the current buddy system the way it is and
if you want to provide a patch improving things to be "all-to-all" in
the future that would be interesting to review.
