Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14080C77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 23:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjFGXnJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFGXnI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2023 19:43:08 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694D6212B
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Jun 2023 16:43:07 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39a3f165ac5so42098b6e.3
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181386; x=1688773386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GavxFaHwlTnRx3gt9uObRrogsyEG4oEATw/XGEuAuMI=;
        b=jo7abgemSwouf2eZ5x1CqzH/x0i9O3mDwBr5hdEkTwjuzcmlBcBwfkgp+g+8z/oJo8
         8pg9aB1C1osS61nQNaZMoMUW1fBSAK7WFXXzpk5fz2iWg29ztpgAFIsfODr4y0FyV5wu
         q9RVzJ3N8m4CGohrXrmDH6k+WP6gT1UIQVQaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181386; x=1688773386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GavxFaHwlTnRx3gt9uObRrogsyEG4oEATw/XGEuAuMI=;
        b=Dw0XMm1ezcPUyiaJGNVBgEYW+r2UmbChGYYrQfUCcq3OFMWKjZ0/EeJl2lh8zl0hxd
         01c3NTy6jrrWkG6mvh6TtRl5txfvJsDRrtxpwAFqDPg2esw8FG26gw7uC7SDLpSu/7fe
         RvQUzeMgEKFZ2ytIVGNKrQGrjS5HXHKLAWMBb38FkLP7Y+p+Ht9DTdVLMaiTy0ANatrG
         4C9wGZlNQNGubEpSIh7r69xx1rf5818CwxWhU1Uwq0Yf64DIblNzVA0LoqRhgWRMHuRu
         x/sJXKP92D1v6cOuNLwnc+9SCFrQ3ueEmdlFZv8YFIyy0iNd6l6Gti9c3N9EZLGJSqs+
         FZaw==
X-Gm-Message-State: AC+VfDwqxyCTGicZ2vgPNGDHOuS4h/9Y1CRdaYwWhXDMg+/4krE6+TN+
        KLgMps4KZ9e/0wZmSlcTSmskeR9LMcQGcGmOCr8=
X-Google-Smtp-Source: ACHHUZ522m0cTEfDX9XLz/soplvWoXd8b4TJVgKIucrSaIpcTH1rechvtwVkZegIOk+XbM1BU8bGvw==
X-Received: by 2002:a05:6808:201:b0:39c:40c0:703c with SMTP id l1-20020a056808020100b0039c40c0703cmr6931060oie.1.1686181386123;
        Wed, 07 Jun 2023 16:43:06 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id p4-20020acad804000000b00395f2c84b81sm6283432oig.54.2023.06.07.16.43.05
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:43:05 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-39a505b901dso52123b6e.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:43:05 -0700 (PDT)
X-Received: by 2002:a5e:a611:0:b0:777:aa56:f5e9 with SMTP id
 q17-20020a5ea611000000b00777aa56f5e9mr11095206ioi.16.1686180931677; Wed, 07
 Jun 2023 16:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-4-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-4-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:35:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XvUAeKFAcOD_xaT2to45=CCiKJMRbi-uxgrZ4mWN7hZg@mail.gmail.com>
Message-ID: <CAD=FV=XvUAeKFAcOD_xaT2to45=CCiKJMRbi-uxgrZ4mWN7hZg@mail.gmail.com>
Subject: Re: [PATCH 3/7] watchdog/hardlockup: Declare arch_touch_nmi_watchdog()
 only in linux/nmi.h
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
> arch_touch_nmi_watchdog() needs a different implementation for various
> hardlockup detector implementations. And it does nothing when
> any hardlockup detector is not build at all.

s/build/built/


> arch_touch_nmi_watchdog() has to be declared in linux/nmi.h. It is done
> directly in this header file for the perf and buddy detectors. And it
> is done in the included asm/linux.h for arch specific detectors.
>
> The reason probably is that the arch specific variants build the code
> using another conditions. For example, powerpc64/sparc64 builds the code
> when CONFIG_PPC_WATCHDOG is enabled.
>
> Another reason might be that these architectures define more functions
> in asm/nmi.h anyway.
>
> However the generic code actually knows the information. The config
> variables HAVE_NMI_WATCHDOG and HAVE_HARDLOCKUP_DETECTOR_ARCH are used
> to decide whether to build the buddy detector.
>
> In particular, CONFIG_HARDLOCKUP_DETECTOR is set only when a generic
> or arch-specific hardlockup detector is built. The only exception
> is sparc64 which ignores the global HARDLOCKUP_DETECTOR switch.
>
> The information about sparc64 is a bit complicated. The hardlockup
> detector is built there when CONFIG_HAVE_NMI_WATCHDOG is set and
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.
>
> People might wonder whether this change really makes things easier.
> The motivation is:
>
>   + The current logic in linux/nmi.h is far from obvious.
>     For example, arch_touch_nmi_watchdog() is defined as {} when
>     neither CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER nor
>     CONFIG_HAVE_NMI_WATCHDOG is defined.
>
>   + The change synchronizes the checks in lib/Kconfig.debug and
>     in the generic code.
>
>   + It is a step that will help cleaning HAVE_NMI_WATCHDOG related
>     checks.
>
> The change should not change the existing behavior.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/powerpc/include/asm/nmi.h |  2 --
>  arch/sparc/include/asm/nmi.h   |  1 -
>  include/linux/nmi.h            | 13 ++++++++++---
>  3 files changed, 10 insertions(+), 6 deletions(-)

This looks right and is a nice cleanup.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
