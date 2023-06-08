Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D781C7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbjFHNzk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFHNzj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 09:55:39 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0329A1BD
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 06:55:38 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77ac30e95caso22139539f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686232537; x=1688824537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27Vs9lje4ue6a9YND5XSnEpnS9VI2Lo/geXINpFnbB8=;
        b=oVg83mrTBUl29PTk+RqO5MA1BbM29G9oM3VedLfG6Qy1nJ9HCw3ztfODFjNfW/5Foj
         PV9ypqz1v+8NtZyWCWnd+W4r6KFZUVomawer+u+FDGofP56S8HQjCx39B7+Wj2Mltud4
         3FUSID/L+JQ3Q0AHzm5LxcJ0wqiK8FdELAXCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232537; x=1688824537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27Vs9lje4ue6a9YND5XSnEpnS9VI2Lo/geXINpFnbB8=;
        b=aZB+KqnPetv+/K3BCCT3A7R3Qd7/IKmN/xhs/orMx1Noa3A9j4wrbHkJIe6atyRlS9
         mIvrR+mUKodnnuuOt1/DWoas+kcyVNxkvtQUG49I8wW+Sazho7gjwShc74rkgeKVwDPA
         w/lqz+9upg/0F1vaCtCwcvZJHnAo1UaNuv9VKK3E+SQHDlfxc5OQH5HQJCGtgh1juMu5
         YZ6kuOc7w0o8oGYGmHQL7Snuup53U9iBW0vDZb3EKdis2LU4znOeI1bDK0Y8jX3INw0M
         mx/kNoNqMEPviLZ9ro5HHbzyTZghRYFAacQzCkKaGmki4PRVdSqkTOVicjkU4c7ZHNX7
         jyBQ==
X-Gm-Message-State: AC+VfDytIO4SaZa/56CfXtVh9ZRjayyC/1jMFap/+OWM/K2PX65OgQG0
        bhSNsYd3JBBfCx/bjeSiIH8bG31lu1J3mBl/SRw=
X-Google-Smtp-Source: ACHHUZ7+bDye1jhKpSQRdiaV6Ym6Nrf5XZj8Vp3EI90t3cBnC7V7jIgru6mRfOqXPmpmAR1X6NgAJg==
X-Received: by 2002:a5e:c111:0:b0:76c:71dc:55f3 with SMTP id v17-20020a5ec111000000b0076c71dc55f3mr11363560iol.6.1686232536733;
        Thu, 08 Jun 2023 06:55:36 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id j25-20020a02cb19000000b0040f8d42c110sm287974jap.95.2023.06.08.06.55.35
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:55:35 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-33d928a268eso121305ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 06:55:35 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a82:b0:32f:7715:4482 with SMTP id
 k2-20020a056e021a8200b0032f77154482mr109894ilv.4.1686232535228; Thu, 08 Jun
 2023 06:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-3-pmladek@suse.com>
 <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com> <ZIG1Qi0iUjTKICQM@alley>
In-Reply-To: <ZIG1Qi0iUjTKICQM@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Jun 2023 06:55:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
Message-ID: <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
Subject: Re: [PATCH 2/7] watchdog/hardlockup: Make the config checks more straightforward
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Thu, Jun 8, 2023 at 4:02=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> > >  config HARDLOCKUP_DETECTOR
> > >         bool "Detect Hard Lockups"
> > >         depends on DEBUG_KERNEL && !S390
> > > -       depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCK=
UP_DETECTOR_ARCH
> > > +       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP=
_DETECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
> >
> > Adding the dependency to buddy (see ablove) would simplify the above
> > to just this:
> >
> > depends on HAVE_HARDLOCKUP_DETECTOR_PERF ||
> > HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
>
> This is exactly what I do not want. It would just move the check
> somewhere else. But it would make the logic harder to understand.

Hmmm. To me, it felt easier to understand by moving this into the
"HAVE_HARDLOCKUP_DETECTOR_BUDDY". To me it was pretty easy to say "if
an architecture defined its own arch-specific watchdog then buddy
can't be enabled" and that felt like it fit cleanly within the
"HAVE_HARDLOCKUP_DETECTOR_BUDDY" definition. It got rid of _a lot_ of
other special cases / checks elsewhere and felt quite a bit cleaner to
me. I only had to think about the conflict between the "buddy" and
"nmi" watchdogs once when I understood
"HAVE_HARDLOCKUP_DETECTOR_BUDDY".


> > As per above, it's simply a responsibility of architectures not to
> > define that they have both "perf" if they have the NMI watchdog, so
> > it's just buddy to worry about.
>
> Where is this documented, please?
> Is it safe to assume this?

It's not well documented and I agree that it could be improved. Right
now, HAVE_NMI_WATCHDOG is documented to say that the architecture
"defines its own arch_touch_nmi_watchdog()". Looking before my
patches, you can see that "kernel/watchdog_hld.c" (the "perf" detector
code) unconditionally defines arch_touch_nmi_watchdog(). That would
give you a linker error.


> I would personally prefer to ensure this by the config check.
> It is even better than documentation because nobody reads
> documentation ;-)

Sure. IMO this should be documented as close as possible to the root
of the problem. Make "HAVE_NMI_WATCHDOG" depend on
"!HAVE_HARDLOCKUP_DETECTOR_PERF". That expresses that an architecture
is not allowed to declare that it has both.
