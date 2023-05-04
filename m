Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DBAC77B73
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 22:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjEDWfC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 18:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEDWfB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 18:35:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC647AA3
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 15:35:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3ef4daaf906so5199961cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683239699; x=1685831699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4uBgz0yZBTHWQuliVmtKoGkSIHeFOTfO6AJGNbOg9A=;
        b=isO3eR5NuFdGcjEDfd6yhyFJJVV3hdhYc0m+77AV3Ct9egH/L2YLByRmiZ5Q10jro/
         W3Qzih1wosvohCkiVkhLWkyAQKqFIQAC6Q4hYgHanRcrYJQEIkvb9xnwFO5VCZBKJChT
         G2UI9CFbw5KOObPyiyJQTqFRfjboVKHSX9aAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683239699; x=1685831699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4uBgz0yZBTHWQuliVmtKoGkSIHeFOTfO6AJGNbOg9A=;
        b=SAlhIBrsUid9fC4vU1iET/AAkjH05GL4dcxL0oRTJnmVQ3OUH/4+LjC2dxTD0hmuSh
         1V/tnYLUE/cnwPhJ4uzXSn6qjaV6ZiG9+AtOTD1m9fgmyyl2t4eK4OW/OxLq0hr1z0N0
         BUoloaSTYiCWh7ewLO1h2SPJX6YKgFBGsE4jza6QOOuEslnAQrUNATJN3puVpBTG8tfS
         eYIQ4XsL3y7G0F+p0PHGCmYuC3dFR9xDglsYTDcJnzB6kkVruJ4HRwKZsgjWMYZZ36kt
         jC4kXE6Kxm1z4jTLtQmTH4T+7wyFnpBpvdRRBrHt74A42JQInbU859XgSe12ybk65gD2
         dQeA==
X-Gm-Message-State: AC+VfDyBOFXNx6KBmktKuQIPDvFgKwsPAtqzyFpXp5jCoKR/AppFFteg
        Cyrqtat83hjlumqvkDuIAOb0KXcwvOuUn/nLxFU=
X-Google-Smtp-Source: ACHHUZ7lVhzM2ww7R/sb/PJcFTkcUQfpsCEdxtCgKhmJ4wqLxV7IFHxT6fLlSlxBCvlbsFGOneB6zg==
X-Received: by 2002:ac8:7c45:0:b0:3bf:cff2:2c2f with SMTP id o5-20020ac87c45000000b003bfcff22c2fmr7369980qtv.44.1683239698866;
        Thu, 04 May 2023 15:34:58 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id z27-20020ac8431b000000b003eda962ed24sm60621qtm.22.2023.05.04.15.34.58
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 15:34:58 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3f0a2f8216fso890281cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 15:34:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1487:b0:3f3:75c2:7466 with SMTP id
 t7-20020a05622a148700b003f375c27466mr43810qtx.8.1683239371523; Thu, 04 May
 2023 15:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <ZFErmshcrcikrSU1@alley>
In-Reply-To: <ZFErmshcrcikrSU1@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 May 2023 15:29:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UVFR5YvJ8QrZ8YYPpwzYeymuy_JhcmZknbwUXg9njoGA@mail.gmail.com>
Message-ID: <CAD=FV=UVFR5YvJ8QrZ8YYPpwzYeymuy_JhcmZknbwUXg9njoGA@mail.gmail.com>
Subject: Re: shared code: was: Re: [PATCH v3] hardlockup: detect hard lockups
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

On Tue, May 2, 2023 at 8:26=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> > +int __weak watchdog_nmi_enable(unsigned int cpu) { return 0; }
> > +void __weak watchdog_nmi_disable(unsigned int cpu) { return; }
>
> Honestly, the mix of softlockup and hardlockup code was a hard to
> follow even before this patch. And it is going to be worse.
>
> Anyway, the buddy watchdog is not using NMI at all. It should not
> get enable using a function called *_nmi_enabled().

Thanks for your review! I'm not going to individually reply to all
your comments below, but I've sent out a v4 [1] where I think I've
done a semi-decent job of making this a little cleaner (not perfect,
but hopefully a step in the right direction). Please take a look.

[1] https://lore.kernel.org/r/20230504221349.1535669-1-dianders@chromium.or=
g


> Also some comments are not longer valid, for example:
>
> static void watchdog_enable(unsigned int cpu)
> {
> [...]
>         /* Enable the perf event */
>         if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
>                 watchdog_nmi_enable(cpu);

Ugh, after I sent the new version I just realized that I missed
updating the above comment. :( If I need to send a v5 I can update it
then, or if v4 lands I can send a follow-on patch to update that
comment. My eyes are glazed over enough from trying to organize a
17-patch series, so I somewhat imagine it's not the only comment I
missed...

-Doug
