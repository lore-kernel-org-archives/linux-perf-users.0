Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62956C77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jun 2023 21:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjFAVyj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjFAVyi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jun 2023 17:54:38 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED4107
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jun 2023 14:54:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f6b20ad49dso11326981cf.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685656473; x=1688248473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eogoQvqQO6ZvyvYBhcgWNYvozKgAFgLZqqjPS4QzrXk=;
        b=Cpx2/ZvHEn/wD82g/5yqpL+CoMX9erbLBgapvrL3p4g8GU2IjxgdN612VRtznmSrDd
         LMiAnN/sCLZZk58QB79VTxdmhLOmD+x0gfbfa0LDE6MixGbUd7ZhoR70l4mZ8crqgBMO
         6ZvQE7Ns9OYic4BamJFUI6ygd0OSJ1QHW8CD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685656473; x=1688248473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eogoQvqQO6ZvyvYBhcgWNYvozKgAFgLZqqjPS4QzrXk=;
        b=DdU5IMGNL1nOMBpsKQz5qbQLcUQxbSMF5YYa1d6cJkobizVY4YlMjk24oL1TjbdHsq
         ygcSmod5WEM1Wv/y9nZLxs2xv2auo5pTlj3jrsF8wbSMBvX7rn8a0uLkTP6yf4fC37TF
         oWnCn07lqvrjiPEKcnHUM/SBK686RR6x6LdVEdenS/PxqTicqXjCxaLp38GT7E0P7LuC
         3NWAKAJTyM5RAlXmy8f3BTc0F4CUppkFiuX5x4qLbpMT/TEmyNY2biSgSq9i4LCB7Khn
         OdwllKZ21wVs8eUKBl9gfc15BN9MLeuiMCpVd7A/Xl2ZFaEfTKlzze1HQvwjuEWKCXNJ
         DtLw==
X-Gm-Message-State: AC+VfDxzNkDlY5KpQ9zYKownxes3CxKcKi+EwnaJb+pKH0vHjvqXRrpe
        N907u9ONC5ebMmcLB6TuvoceqTNS95+COI7r7uQ=
X-Google-Smtp-Source: ACHHUZ5k60tx8xHwYGpyxuTxCZcCAeUtQDzHNFmHY3CqausJB/gSOCJJliEfYs6PhnU2rb+dQL47WQ==
X-Received: by 2002:a05:6214:416:b0:625:aa1a:b6d7 with SMTP id z22-20020a056214041600b00625aa1ab6d7mr13611020qvx.57.1685656473284;
        Thu, 01 Jun 2023 14:54:33 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id de4-20020ad45844000000b006260adb2e32sm7084254qvb.85.2023.06.01.14.54.32
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 14:54:33 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3f81ffc9065so23781cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 14:54:32 -0700 (PDT)
X-Received: by 2002:a05:6e02:214e:b0:33b:3d94:afb5 with SMTP id
 d14-20020a056e02214e00b0033b3d94afb5mr11901ilv.25.1685656080333; Thu, 01 Jun
 2023 14:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.7.I21d92f8974c8e4001a5982fea6c98da1bed33ef5@changeid>
 <20230512134853.GA216623@aspen.lan> <CAD=FV=W4owWm4pVhXWKJpjFj75E=hzYkOZ6ZrZu2DqUF8Nt0cw@mail.gmail.com>
In-Reply-To: <CAD=FV=W4owWm4pVhXWKJpjFj75E=hzYkOZ6ZrZu2DqUF8Nt0cw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Jun 2023 14:47:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLAMv1rHiWWAoP8aTCpjWyzuHRuZtYAQRP3BwxFY0YNQ@mail.gmail.com>
Message-ID: <CAD=FV=WLAMv1rHiWWAoP8aTCpjWyzuHRuZtYAQRP3BwxFY0YNQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] kgdb: Expose default CPUs roundup fallback mechanism
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Mon, May 15, 2023 at 4:21=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, May 12, 2023 at 6:49=E2=80=AFAM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Wed, Apr 19, 2023 at 03:56:01PM -0700, Douglas Anderson wrote:
> > > From: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > Add a new API kgdb_smp_call_nmi_hook() to expose default CPUs roundup
> > > mechanism to a particular archichecture as a runtime fallback if it
> > > detects to not support NMI roundup.
> > >
> > > Currently such an architecture example is arm64 supporting pseudo NMI=
s
> > > feature which is only available on platforms which have support for G=
ICv3
> > > or later version.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Tested-by: Chen-Yu Tsai <wens@csie.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  include/linux/kgdb.h      | 12 ++++++++++++
> > >  kernel/debug/debug_core.c |  8 +++++++-
> > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > > index 258cdde8d356..87713bd390f3 100644
> > > --- a/include/linux/kgdb.h
> > > +++ b/include/linux/kgdb.h
> > > @@ -199,6 +199,18 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffe=
r,
> > >
> > >  extern void kgdb_call_nmi_hook(void *ignored);
> > >
> > > +/**
> > > + *   kgdb_smp_call_nmi_hook - Provide default fallback mechanism to
> > > + *                            round-up CPUs
> > > + *
> > > + *   If you're using the default implementation of kgdb_roundup_cpus=
()
> > > + *   this function will be called.  And if an arch detects at runtim=
e to
> > > + *   not support NMI based roundup then it can fallback to default
> > > + *   mechanism using this API.
> > > + */
> > > +
> > > +extern void kgdb_smp_call_nmi_hook(void);
> >
> > Concept looks sensible but this is a terrible name for aa command to
> > round up the CPUs using smp_call... functions. Whilst it is true it tha=
t
> > kgdb_roundup_cpus() does use kgdb_call_nmi_hook() internally that
> > doesn't mean we should name functions after it. They should be named
> > after what they are do, not how they do it.
> >
> > Something more like kgdb_roundup_cpus_with_smp_call() would be a much
> > better name.
>
> Sounds good. I'm happy to spin with this rename, though I was kinda
> hoping to drop ${SUBJECT} patch if folks were OK with patch #10 in
> this series [1]. I personally think that's the right way to go but
> it's unclear to me if arm64 maintainers will think it's a hack
> (despite the fact that arm32 implements the "nmi" functions with
> regular IPIs).
>
> For now, maybe I'll think positive thoughts and hope that folks will
> have the time to review the series soon. If another few weeks go by
> then I'll send a v9 with just your comments addressed. If nothing
> else, maybe you can land the kgdb parts in a tree targeting v6.5 and
> then when arm64 folks have the bandwidth then it will be easier to get
> them landed.
>
> [1] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522=
fc3afcdfd88d7a5f030@changeid

Breadcrumbs: I've dropped this patch and several others in v9 [1] by
embracing the idea of using a normal IPI as a fallback.

[1] https://lore.kernel.org/r/20230601213440.2488667-1-dianders@chromium.or=
g/
