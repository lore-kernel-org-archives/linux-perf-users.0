Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B7AC7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 00:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjFHACG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jun 2023 20:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjFHACF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2023 20:02:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D31B9
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Jun 2023 17:02:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b01dac1a82so41776755ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686182523; x=1688774523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhl3RV14fXn8RdG370rcvuPNBbtc0Bpx0+NmOZMVtZc=;
        b=F0Qqt/YKnwewnO0vUDfIsuZ/pFg2xGpDqXxFmH2JHDRpfmWEL787x7LdzQ2J/7j35s
         DN/pJYI1jS+dSX/VOOuRzpdUOXqmqh1Y16NS4Qy91RTAc1eJQke1qXAG6g/BE6v+w6bI
         1fScWbEvi/8Y8XRYOYSC4KdEAeIv1qoZn/n3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686182523; x=1688774523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhl3RV14fXn8RdG370rcvuPNBbtc0Bpx0+NmOZMVtZc=;
        b=Yp2bjH/nbCuXYMI2+QBXA/6Z4k1ZkYuPCMYVfIw7N/5ChKU7ybBuaBvDwIivtOrqDl
         eeROIbhiYXVnPaRZv562p7L5t5aw2Z85UC1unlA47F6SykN0yvcamF1plkQtsUXeB+qu
         y4sjr07+TW6CQCycD5AExhJgl+aGyrnVgWsU1uXRB+aA6h5xBGt6P26uqbWKz4egCkai
         cTj3c/xLfyqPZnWFdD5otXQ8GeeA3E+pevaWwhPhKaZWCk5EOFxk8hOAoeEpYREDeU6Y
         Zflo4RLzOyMCSe5k9j3RS8YSDcXixfsDI1kYlRVvEoO62DMLGxKEvX26zL+cq2VITUj6
         FAew==
X-Gm-Message-State: AC+VfDwrokGWi5GGaxIhj3mSKC00QyYiMKrA9N8kh5Bjd8tJNJVp7NNu
        tjmasfF1HvD/TjTK79bqGYPhi8Gij8fzPe7qRyU=
X-Google-Smtp-Source: ACHHUZ76PpEOY4qEGotBQrvRGFbOCLD5fKb3L4NG/1Oa++FgOwG9yGA9v9xZqF+9P1XklMaUTPbIWQ==
X-Received: by 2002:a17:902:e88a:b0:1ae:4553:edfa with SMTP id w10-20020a170902e88a00b001ae4553edfamr5165978plg.29.1686182523576;
        Wed, 07 Jun 2023 17:02:03 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id y24-20020a170902b49800b001b1a2bf5277sm78809plr.39.2023.06.07.17.02.03
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 17:02:03 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b1b51ec3e9so74455ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 17:02:03 -0700 (PDT)
X-Received: by 2002:a92:c54d:0:b0:33e:6b65:6f78 with SMTP id
 a13-20020a92c54d000000b0033e6b656f78mr16489ilj.27.1686181007418; Wed, 07 Jun
 2023 16:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-5-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-5-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:36:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VV3Y7KoZWPtZfmfRsUCftAgo_CLRDazrYSgbR2XJKf=g@mail.gmail.com>
Message-ID: <CAD=FV=VV3Y7KoZWPtZfmfRsUCftAgo_CLRDazrYSgbR2XJKf=g@mail.gmail.com>
Subject: Re: [PATCH 4/7] watchdog/hardlockup: Enable HAVE_NMI_WATCHDOG only on sparc64
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

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 13c6e596cf9e..57f15babe188 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -404,10 +404,9 @@ config HAVE_NMI_WATCHDOG
>         depends on HAVE_NMI
>         bool
>         help
> -         The arch provides its own hardlockup detector implementation in=
stead
> +         Sparc64 provides its own hardlockup detector implementation ins=
tead
>           of the generic perf one.

It's a little weird to document generic things with the specifics of
the user. The exception, IMO, is when something is deprecated.
Personally, it would sound less weird to me to say something like:

The arch provides its own hardlockup detector implementation instead
of the generic perf one. This is a deprecated thing to do and kept
around until sparc64 provides a full hardlockup implementation or
moves to generic code.


> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d201f5d3876b..4b4aa0f941f9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1050,15 +1050,13 @@ config HAVE_HARDLOCKUP_DETECTOR_BUDDY
>  #      sparc64: has a custom implementation which is not using the commo=
n
>  #              hardlockup command line options and sysctl interface.
>  #
> -# Note that HAVE_NMI_WATCHDOG is used to distinguish the sparc64 specifi=
c
> -# implementaion. It is automatically enabled also for other arch-specifi=
c
> -# variants which set HAVE_HARDLOCKUP_DETECTOR_ARCH. It makes the check
> -# of avaialable and supported variants quite tricky.
> +# Note that HAVE_NMI_WATCHDOG is set when the sparc64 specific implement=
ation
> +# is used.
>  #
>  config HARDLOCKUP_DETECTOR
>         bool "Detect Hard Lockups"
> -       depends on DEBUG_KERNEL && !S390
> -       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DET=
ECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
> +       depends on DEBUG_KERNEL && !S390 && !HAVE_NMI_WATCHDOG
> +       depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETEC=
TOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH

If you add the "!HAVE_NMI_WATCHDOG" as a dependency to
HAVE_HARDLOCKUP_DETECTOR_BUDDY, as discussed in a previous patch, you
can skip adding it here.


>         imply HARDLOCKUP_DETECTOR_PERF
>         imply HARDLOCKUP_DETECTOR_BUDDY
>         select LOCKUP_DETECTOR
> @@ -1079,7 +1077,7 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
>         bool "Prefer the buddy CPU hardlockup detector"
>         depends on HARDLOCKUP_DETECTOR
>         depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETEC=
TOR_BUDDY
> -       depends on !HAVE_NMI_WATCHDOG
> +       depends on !HAVE_HARLOCKUP_DETECTOR_ARCH

Don't need this. Architectures never are allowed to define
HAVE_HARDLOCKUP_DETECTOR_PERF and HAVE_HARLOCKUP_DETECTOR_ARCH


>         default n
>         help
>           Say Y here to prefer the buddy hardlockup detector over the per=
f one.
> @@ -1096,7 +1094,7 @@ config HARDLOCKUP_DETECTOR_PERF
>         bool
>         depends on HARDLOCKUP_DETECTOR
>         depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_=
PREFER_BUDDY
> -       depends on !HAVE_NMI_WATCHDOG
> +       depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH

Similarly, don't need this.


>         select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
>
>  config HARDLOCKUP_DETECTOR_BUDDY
> @@ -1104,7 +1102,7 @@ config HARDLOCKUP_DETECTOR_BUDDY
>         depends on HARDLOCKUP_DETECTOR
>         depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
>         depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_=
PREFER_BUDDY
> -       depends on !HAVE_NMI_WATCHDOG
> +       depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH

Similarly, don't need this.


In general I don't object to splitting out HAVE_NMI_WATCHDOG from
HAVE_HARDLOCKUP_DETECTOR_ARCH.
