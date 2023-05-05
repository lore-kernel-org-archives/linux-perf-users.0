Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31BEC77B7C
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 16:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjEEQqM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 12:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEEQqL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 12:46:11 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA6B13284
        for <linux-perf-users@vger.kernel.org>; Fri,  5 May 2023 09:46:10 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-61af33bdf1dso9506236d6.2
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683305169; x=1685897169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hx/Z1QGIGo513DGFRHbMqQT6fmsKMlQd8/3rs/cumNc=;
        b=lKIduvGI33S/Pa/N9oIpeJpTDR0OyPb4EGyGWPDuLALNgAP+QWlBobLRviWrY+P0xS
         K6AHTHIM5pWY4RojkX9YXQSL6V97zLKhVr9V16Gvdj8fv2MFiTs8OPcS4gxG/lEtt5pX
         iqlLtuNHfHpcCqu3uov8L0bq9qcYrGHwgeFVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305169; x=1685897169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hx/Z1QGIGo513DGFRHbMqQT6fmsKMlQd8/3rs/cumNc=;
        b=chPeLtHMa4yNhD/skrnC4cNTXnb1BVX+iKeLWdoNXbGzVTr0w0VT7xDCdK+ZG3wcrT
         UcNCDs0UM0MUpEz7BiRj4GaGnOUg1Ln3kbBacwQVVuaqg1zBNv6hVPARDyu3kbV08/ev
         Rd3EedQjFMkSGZa6cB2WFPb3LqwK8JkGXP1LJKVCezInag1MhqKgzlYCdhqP9PLRQR84
         lw7ctD7PXonmHa8YESPtsuP0E+YHge1uQNWEqPjXtZjBWPWgA9291XegIMh4dKC58x4z
         W9cOZtN5Ay30s7moULrZTrS/O1sf5y7ucBztsMZMdEkBC1ylMUg1OTPXDkml5vVqIyq8
         fNuA==
X-Gm-Message-State: AC+VfDyPQvdaXwKrz/qqoNFFUe6ZbisaLoehdPsMomcaZZub+Ch/o9L8
        vRKuNzetwjWjS1ZdZ4ybLtEKPjqqd/38ZS84RGM=
X-Google-Smtp-Source: ACHHUZ63WxetCRK1Y2p6Rg7HinoImq/QTEGTjmfaNqCo8Q0nNg4iw6/eeoRQh42ZwipFdS/3kh11UA==
X-Received: by 2002:ad4:5ba2:0:b0:5ca:83ed:12be with SMTP id 2-20020ad45ba2000000b005ca83ed12bemr3369565qvq.21.1683305169057;
        Fri, 05 May 2023 09:46:09 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id n18-20020ae9c312000000b0074e003c55f0sm691561qkg.102.2023.05.05.09.46.08
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:46:08 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-3ef36d814a5so1119621cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:46:08 -0700 (PDT)
X-Received: by 2002:a05:622a:1898:b0:3ef:31a5:13c with SMTP id
 v24-20020a05622a189800b003ef31a5013cmr206117qtc.3.1683304708084; Fri, 05 May
 2023 09:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.8.I818492c326b632560b09f20d2608455ecf9d3650@changeid> <CSE0CI3TFK72.2I4E5TJIRHDGM@wheely>
In-Reply-To: <CSE0CI3TFK72.2I4E5TJIRHDGM@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:38:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vuad+gxrUirhyx8aFuLbh2M1hMnoY5NUVBxdycd8kFiQ@mail.gmail.com>
Message-ID: <CAD=FV=Vuad+gxrUirhyx8aFuLbh2M1hMnoY5NUVBxdycd8kFiQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/17] watchdog/hardlockup: Style changes to
 watchdog_hardlockup_check() / ..._is_lockedup()
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

On Thu, May 4, 2023 at 8:02=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > These are tiny style changes:
> > - Add a blank line before a "return".
> > - Renames two globals to use the "watchdog_hld" prefix.
>
> Particularly static ones don't really need the namespace prefixes.

Renames are mostly at Petr's request. If I've misunderstood what he
wants here that I'm happy to remove them.


> Not sure if processed is better than warn.

I can undo this one if you want. It felt like we were doing more than
just warning, but if people think "warn" is a better way to describe
it then that's fine with me.


> allcpu_dumped is better
> than dumped_stacks though because the all-CPUs-dump is a particular
> thing.

OK, I can undo this and leave it as "allcpu_dumped".


[1] https://lore.kernel.org/r/ZFErmshcrcikrSU1@alley
