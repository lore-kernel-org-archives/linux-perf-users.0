Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB3C77B7C
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 22:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjEDWQn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 18:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDWQm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 18:16:42 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5241311DB1
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 15:16:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-74fb8677a36so56028585a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238598; x=1685830598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzswV8h6Pv5RbnDUfs5XaziOPH7Dg5YP+9HIzH76G84=;
        b=NB2139Nf7RGw9RCIAQw10bNLb48qHeZGcJSCY/GZW76l3WHWt9CmmEmkXDfTJERPEG
         rFVzAf6cf/LDkA7PZtoDtVPvfaoTz+RR8J/9dmpbQEncxGDvC3tbHp4dv/ZlJEfTlw/x
         4Ho5qauU1IwbLhhzrYajB3VLrviVbdCntZXCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238598; x=1685830598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzswV8h6Pv5RbnDUfs5XaziOPH7Dg5YP+9HIzH76G84=;
        b=M50fyIXiwLYzWU05Hz8EhLSzRJ3g2n+4EsN7C6TxGzo99TfN2OuwkuYNqYD7BqeVlC
         734hRVXVsm9zeDEUzFTQuZvk2CXI0ZFw7n4XmokRhwR00Flcx1NiIQOTkcrz9n65Vexv
         jYnVRPA2GP1A/oNncbvUw3ou8CCGsxGRpMSzYXZTqcHrNVbPrjRXwduhlv8hJkTXcad2
         dZzP2lVxCtVkIvFjLMcdpbZpcSyMKyoI1un/6gq5oVjF2tHmwHgYvV3Ttjri1IPsRUPp
         7h2vEE1bxmvGZysmv61jKm01fQyDzBiRqhDuxLOgvNgrzZ0HfZL+u19NccByfzy5yfVT
         LS/Q==
X-Gm-Message-State: AC+VfDzx4VcHrVSuaQjECS2HRbEGzGCmzqS3P5PHHn+XV3tP1YAA2+nC
        FpCjyHBYlbpGux24Xaz5exARKKUvRfL+O2sVmRo=
X-Google-Smtp-Source: ACHHUZ7Bv4knZ0aIRxleLUJ/wxyDIju9LnV/AiEakU9IUOglTQkQjY3ELLjjDXbk0fLGQTaaNySPGA==
X-Received: by 2002:a05:6214:2689:b0:5ec:4388:8807 with SMTP id gm9-20020a056214268900b005ec43888807mr17261991qvb.24.1683238598026;
        Thu, 04 May 2023 15:16:38 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id a19-20020a0cca93000000b0061f7cf8207esm72419qvk.89.2023.05.04.15.16.36
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 15:16:37 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3ef36d814a5so911241cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 15:16:36 -0700 (PDT)
X-Received: by 2002:a05:622a:144d:b0:3de:1aaa:42f5 with SMTP id
 v13-20020a05622a144d00b003de1aaa42f5mr10116qtx.15.1683238596262; Thu, 04 May
 2023 15:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <ZFEqynvf5nqkzEvQ@alley>
In-Reply-To: <ZFEqynvf5nqkzEvQ@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 May 2023 15:16:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1nqunM83LzSXnYiODC66tn5hjSWsUvxabf6vSO7reUQ@mail.gmail.com>
Message-ID: <CAD=FV=V1nqunM83LzSXnYiODC66tn5hjSWsUvxabf6vSO7reUQ@mail.gmail.com>
Subject: Re: cpu hotplug : was: Re: [PATCH v3] hardlockup: detect hard lockups
 using secondary (buddy) CPUs
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ian Rogers <irogers@google.com>, ravi.v.shankar@intel.com,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>, Andi Kleen <ak@linux.intel.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Tue, May 2, 2023 at 8:23=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Mon 2023-05-01 08:24:46, Douglas Anderson wrote:
> > From: Colin Cross <ccross@android.com>
> >
> > Implement a hardlockup detector that doesn't doesn't need any extra
> > arch-specific support code to detect lockups. Instead of using
> > something arch-specific we will use the buddy system, where each CPU
> > watches out for another one. Specifically, each CPU will use its
> > softlockup hrtimer to check that the next CPU is processing hrtimer
> > interrupts by verifying that a counter is increasing.
> >
> > --- /dev/null
> > +++ b/kernel/watchdog_buddy_cpu.c
> > +int watchdog_nmi_enable(unsigned int cpu)
> > +{
> > +     /*
> > +      * The new CPU will be marked online before the first hrtimer int=
errupt
> > +      * runs on it.
>
> It does not need to be the first hrtimer interrupt. The CPU might have
> been offlined/onlined repeatedly. The counter might have any value.
>
> > +      * If another CPU tests for a hardlockup on the new CPU
> > +      * before it has run its first hrtimer, it will get a false posit=
ive.
> > +      * Touch the watchdog on the new CPU to delay the first check for=
 at
> > +      * least 3 sampling periods to guarantee one hrtimer has run on t=
he new
> > +      * CPU.
> > +      */

OK, I've updated the above comment to:

/*
 * The new CPU will be marked online before the hrtimer interrupt
 * gets a chance to run on it. If another CPU tests for a
 * hardlockup on the new CPU before it has run its the hrtimer
 * interrupt, it will get a false positive. Touch the watchdog on
 * the new CPU to delay the check for at least 3 sampling periods
 * to guarantee one hrtimer has run on the new CPU.
 */

> > +     per_cpu(watchdog_touch, cpu) =3D true;
>
> We should touch also the next_cpu:
>
>         /*
>          * We are going to check the next CPU. Our watchdog_hrtimer
>          * need not be zero if the CPU has already been online earlier.
>          * Touch the watchdog on the next CPU to avoid false positive
>          * if we try to check it in less then 3 interrupts.
>          */
>         next_cpu =3D watchdog_next_cpu(cpu);
>         if (next_cpu < nr_cpu_ids)
>                 per_cpu(watchdog_touch, next_cpu) =3D true;
>
> Alternative would be to clear watchdog_hrtimer. But it would kind-of
> affect also the softlockup detector.

Looks reasonable. I've incorporated it.
