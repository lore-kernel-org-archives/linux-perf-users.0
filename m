Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D5C83F18
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Aug 2023 16:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjH2QDs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbjH2QD0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 12:03:26 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B8912D
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 09:03:23 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-64b3504144cso26273066d6.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693324999; x=1693929799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFxggldoPBim4o7gj2Za9WWmVK+cpYLI2YfSUTJ9s80=;
        b=bOSHLCpT+VZM2wlktXqOnykYhGHMe5Msyy/ERRwUPJXpHhs517oK+IlR4GxbLTh1/j
         siIBHc3V9RZtatMccU5xJ34QSDIH6QCs9Fp+SlaW0itFEGHqgbPKS5WsG3PTUUFFYZCy
         wQwSWtS6+2BlK3eleK+s0io63BgDwP1U9pwKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693324999; x=1693929799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFxggldoPBim4o7gj2Za9WWmVK+cpYLI2YfSUTJ9s80=;
        b=K1Ot4+zj6CC9niV/pmok203AHoAvf9ub+etUwYtG8OEli2GjYWXjjzpfOG82dvC88L
         a6InWH47H5xksP/ROHp68gXd5Fj41rCDi7eXebd7/+MjzTrs4DgV68PXy51gxxYb/2nk
         aYecnHMI26JeF+0+zBAZaqhN5JRnwOeX38zUDyXpMbLjN7nGI/Q+CtHEGGjG8KEoQpT3
         8M7Q/JYqoarOZtGvlY0o5Ko0LmX0Ca+Ub/wJfy6Dh1KWHzwnpA54AYaOtGRClHGJmGTe
         MrdC710ZH2Ry2jpMuEinxCwvYRZPcdWtSY/0Faeo4vuIxRnsjvOFu+YIbkrV8L9T+Qz3
         bAqA==
X-Gm-Message-State: AOJu0Yx4D/lX1bmmdCTHCtzH7k2A2hYYI2z80Dn99FuieM3rFRCCE628
        VzP9jE/7yT2aoUUEM4s+IhYASQAVwEKf8BRsQxQqow==
X-Google-Smtp-Source: AGHT+IGSvCni3/aFn6b6Gu3ywlxc/cx9VA8Yr65SzzQirj6ARsCN7i+SeejpUZbays8sXWWa1qKhEg==
X-Received: by 2002:a0c:dd8e:0:b0:64f:91de:3aab with SMTP id v14-20020a0cdd8e000000b0064f91de3aabmr8932651qvk.29.1693324999162;
        Tue, 29 Aug 2023 09:03:19 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id n6-20020a0ce486000000b006490a9946b6sm3426584qvl.119.2023.08.29.09.03.17
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:03:18 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so13007a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 09:03:17 -0700 (PDT)
X-Received: by 2002:a50:c2c9:0:b0:522:28a1:2095 with SMTP id
 u9-20020a50c2c9000000b0052228a12095mr174413edf.3.1693324996834; Tue, 29 Aug
 2023 09:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org>
 <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid> <TYCPR01MB11025E1AB8ED779D1D67F05CBE5E7A@TYCPR01MB11025.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11025E1AB8ED779D1D67F05CBE5E7A@TYCPR01MB11025.jpnprd01.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Aug 2023 09:03:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZeHicVLn3GAxdFrtUbwHnb8GEvsfe9BM7cfBrTrK=Fg@mail.gmail.com>
Message-ID: <CAD=FV=UZeHicVLn3GAxdFrtUbwHnb8GEvsfe9BM7cfBrTrK=Fg@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using pseudo-NMI
To:     "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Yuichi Ito (Fujitsu)" <ito-yuichi@fujitsu.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Mon, Aug 28, 2023 at 10:23=E2=80=AFPM Tomohiro Misono (Fujitsu)
<misono.tomohiro@fujitsu.com> wrote:
>
> > -----Original Message-----
> > Subject: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace usi=
ng
> > pseudo-NMI
> >
> > Enable arch_trigger_cpumask_backtrace() support on arm64. This enables
> > things much like they are enabled on arm32 (including some of the
> > funky logic around NR_IPI, nr_ipi, and MAX_IPI) but with the
> > difference that, unlike arm32, we'll try to enable the backtrace to
> > use pseudo-NMI.
> >
> > NOTE: this patch is a squash of the little bit of code adding the
> > ability to mark an IPI to try to use pseudo-NMI plus the little bit of
> > code to hook things up for kgdb. This approach was decided upon in the
> > discussion of v9 [1].
> >
> > This patch depends on commit 36759e343ff9 ("nmi_backtrace: allow
>
> Hi,
> Is this commit ID valid? I believe this commit is not included in the
> mainline yet. Other than this,
>  Reviewed-by: Misono Tomohiro <misono.tomohiro@fujitsu.com>

Ah, good call. I must have grabbed that git hash before the commit
moved from Andrew Morton's unstable branch to his stable branch. As
far as I can tell, it should be commit 8d539b84f1e3 ("nmi_backtrace:
allow excluding an arbitrary CPU"). ...at least that's what's in
linuxnext today. That also appears to match the commit hash in the
pull request that Andrew just sent to Linus [1].

I'll update the git hash and add your tag in v12, which I'm currently
aiming to send out tomorrow.

[1] https://lore.kernel.org/r/20230828225431.354d3d2d3b80ee5b88e65eb5@linux=
-foundation.org
