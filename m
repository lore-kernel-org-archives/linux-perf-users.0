Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72CC7EE22
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 23:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbjEOX2e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 19:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245409AbjEOX2d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 19:28:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F84489
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 16:28:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24df161f84bso9179929a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684193311; x=1686785311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHuslTqJZ+9z+0LpFkq3T91ljIFdmNLjNbw3NtdKpY8=;
        b=f+Z02Uy31lPqTvDFl6gmNqndDKg3WWxA2S0ieryC9XeSdtcmcwXg6yPt53mtmlJWHY
         fIvajAw1Qfh8aTSjv+MeAW0UOXL5YW55LZN2F61hkzKAeApr97jSnaBNVB9t6JJFWlrz
         XuUc0cMuVD7J2nfQ5oT/RPCh6TIIo7yGHhdUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684193311; x=1686785311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHuslTqJZ+9z+0LpFkq3T91ljIFdmNLjNbw3NtdKpY8=;
        b=NwOxGivllt5iornD0ZA+u6/121I87w6kc4en/iiSi+oHkLVtkQInPXnYM/bChREaZl
         XbZR6LrnsfG+nTsH1U+Orya6RZCYFYus+AvMiFCAozXkoPChr4TFzwlJdGEbDUtXDpzz
         NNQLyAGwQqtBG/jdV3rGrXSC2yo7YKK+a+pgXSXkP+6ZeOGaksVdqG1zSa73wrvISdCG
         z/LyRZGqmdhjubyQkByJXoDKZJ1SZO9BtPvzuEMFmqyXVLhSdnSaD4kCS+UHqFr3reKh
         qdnEcZyMC7jDQuMkV5vEE38V6C4+PAbTMFJS5koXQBnkzMuSqkDPW3zThRCUNBwEzE1H
         N9GA==
X-Gm-Message-State: AC+VfDyyEb1jDGykQ3Zl+9OjnnlMHQmNhqsUoo0EyaOzzlemqHOo2Z8t
        HxNv0X2w3fcs2VONhHm6Pah+4byE4EEeMvfFI9U=
X-Google-Smtp-Source: ACHHUZ7Ls/yr72xDqt69wEuQNmiCF7Ah9QKJqwglAQmvOkst4Pxv3fhbIjh3XchKmlp3nrDs9ZVitw==
X-Received: by 2002:a17:90a:6ac4:b0:24e:1ae5:1bed with SMTP id b4-20020a17090a6ac400b0024e1ae51bedmr34703030pjm.16.1684193311124;
        Mon, 15 May 2023 16:28:31 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com. [209.85.214.182])
        by smtp.gmail.com with ESMTPSA id mv9-20020a17090b198900b0024de3dff70esm145690pjb.56.2023.05.15.16.28.30
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 16:28:30 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ac65ab7432so780435ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 16:28:30 -0700 (PDT)
X-Received: by 2002:a05:622a:88:b0:3f3:9c91:fee7 with SMTP id
 o8-20020a05622a008800b003f39c91fee7mr75321qtw.16.1684192903654; Mon, 15 May
 2023 16:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.7.I21d92f8974c8e4001a5982fea6c98da1bed33ef5@changeid>
 <20230512134853.GA216623@aspen.lan>
In-Reply-To: <20230512134853.GA216623@aspen.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 May 2023 16:21:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W4owWm4pVhXWKJpjFj75E=hzYkOZ6ZrZu2DqUF8Nt0cw@mail.gmail.com>
Message-ID: <CAD=FV=W4owWm4pVhXWKJpjFj75E=hzYkOZ6ZrZu2DqUF8Nt0cw@mail.gmail.com>
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

On Fri, May 12, 2023 at 6:49=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Apr 19, 2023 at 03:56:01PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > Add a new API kgdb_smp_call_nmi_hook() to expose default CPUs roundup
> > mechanism to a particular archichecture as a runtime fallback if it
> > detects to not support NMI roundup.
> >
> > Currently such an architecture example is arm64 supporting pseudo NMIs
> > feature which is only available on platforms which have support for GIC=
v3
> > or later version.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Tested-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  include/linux/kgdb.h      | 12 ++++++++++++
> >  kernel/debug/debug_core.c |  8 +++++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 258cdde8d356..87713bd390f3 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -199,6 +199,18 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
> >
> >  extern void kgdb_call_nmi_hook(void *ignored);
> >
> > +/**
> > + *   kgdb_smp_call_nmi_hook - Provide default fallback mechanism to
> > + *                            round-up CPUs
> > + *
> > + *   If you're using the default implementation of kgdb_roundup_cpus()
> > + *   this function will be called.  And if an arch detects at runtime =
to
> > + *   not support NMI based roundup then it can fallback to default
> > + *   mechanism using this API.
> > + */
> > +
> > +extern void kgdb_smp_call_nmi_hook(void);
>
> Concept looks sensible but this is a terrible name for aa command to
> round up the CPUs using smp_call... functions. Whilst it is true it that
> kgdb_roundup_cpus() does use kgdb_call_nmi_hook() internally that
> doesn't mean we should name functions after it. They should be named
> after what they are do, not how they do it.
>
> Something more like kgdb_roundup_cpus_with_smp_call() would be a much
> better name.

Sounds good. I'm happy to spin with this rename, though I was kinda
hoping to drop ${SUBJECT} patch if folks were OK with patch #10 in
this series [1]. I personally think that's the right way to go but
it's unclear to me if arm64 maintainers will think it's a hack
(despite the fact that arm32 implements the "nmi" functions with
regular IPIs).

For now, maybe I'll think positive thoughts and hope that folks will
have the time to review the series soon. If another few weeks go by
then I'll send a v9 with just your comments addressed. If nothing
else, maybe you can land the kgdb parts in a tree targeting v6.5 and
then when arm64 folks have the bandwidth then it will be easier to get
them landed.

[1] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522fc=
3afcdfd88d7a5f030@changeid


-Doug
