Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F192DEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jun 2023 16:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345618AbjFPQsN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbjFPQsI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2023 12:48:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195D30FB
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 09:48:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-982c996a193so126037766b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686934081; x=1689526081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e16upKjJABhKcoxJWL82G3CWyoX8UGnrl2PWs2fRuIo=;
        b=Ain4H2QsJN3Ks5/TQE8Ur0TaiBeNdoehFrv+NWMnJc7rXXK4NMdDzkYPfz0QN5o6JV
         Q7N053cCZwms3kxa+NaCn/7vL2t/QviCjfFEANiRbfx16knFk4Tdpyhw6DNC73k1ncNu
         Lx/ia7lRJIdMaVqoZs5b7pqPAMI73VBK03gYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686934081; x=1689526081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e16upKjJABhKcoxJWL82G3CWyoX8UGnrl2PWs2fRuIo=;
        b=e132p1kauYoHbRMEVjh2cdxqjem4XZVDXfKtruLDPermYK/+jRHUPLJB6JGJMZiXg9
         +gEqfMgtaCf/ZJV+l5yx5ep7jz0GUkqWI6kKckDqJbdhabl3/KRwNLrMHNAJILO+RxMW
         F+Kyiqb0TPFjNrAJeiPTMp49zJ9djYGhj4VwUxQ/mb+lVkdaSUInYCztct+QBXdD4TQL
         S7gXAUJStt5HmZchN3oa921UfoXMzG6E1dk1kB5kyENe2XOli8DYnXJ+JDTW2Co+wei/
         ycYbkpgZ1bNck7O6uWSLtwM+hf/ktk/18jzzoKcpWfIhl6jTQ04CR5LTRGsAjw5/lAeC
         vEgQ==
X-Gm-Message-State: AC+VfDzVzUYZs45PoIl2+TWYBHoysD/4SHtKOdLS8B69StHdDsSBVkzh
        PJqPi6zFf5y9andhWMdr7Isq6eIaK+F+uZcwxkkWRKJE
X-Google-Smtp-Source: ACHHUZ4bpaAbPZYIIzketY1845FIf74ad73fnpidTQ5BlvbDRS06XGWLn9MSf6NILrvNz10Qx0cqQQ==
X-Received: by 2002:a17:907:8a0c:b0:982:25d0:6793 with SMTP id sc12-20020a1709078a0c00b0098225d06793mr2459661ejc.3.1686934081206;
        Fri, 16 Jun 2023 09:48:01 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id o10-20020a170906860a00b00977cc10caefsm10957099ejx.104.2023.06.16.09.47.59
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:48:00 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f81b83b8d5so955e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 09:47:59 -0700 (PDT)
X-Received: by 2002:a05:600c:444e:b0:3f4:2736:b5eb with SMTP id
 v14-20020a05600c444e00b003f42736b5ebmr415495wmn.1.1686934079227; Fri, 16 Jun
 2023 09:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-3-pmladek@suse.com>
In-Reply-To: <20230616150618.6073-3-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Jun 2023 09:47:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPhpZyJO=U3NGy1RZbmAQS_xEoDs-K2HawJYb=UHaUww@mail.gmail.com>
Message-ID: <CAD=FV=VPhpZyJO=U3NGy1RZbmAQS_xEoDs-K2HawJYb=UHaUww@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] watchdog/hardlockup: Make the config checks more straightforward
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

On Fri, Jun 16, 2023 at 8:07=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> There are four possible variants of hardlockup detectors:
>
>   + buddy: available when SMP is set.
>
>   + perf: available when HAVE_HARDLOCKUP_DETECTOR_PERF is set.
>
>   + arch-specific: available when HAVE_HARDLOCKUP_DETECTOR_ARCH is set.
>
>   + sparc64 special variant: available when HAVE_NMI_WATCHDOG is set
>         and HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.
>
> The check for the sparc64 variant is more complicated because
> HAVE_NMI_WATCHDOG is used to #ifdef code used by both arch-specific
> and sparc64 specific variant. Therefore it is automatically
> selected with HAVE_HARDLOCKUP_DETECTOR_ARCH.
>
> This complexity is partly hidden in HAVE_HARDLOCKUP_DETECTOR_NON_ARCH.
> It reduces the size of some checks but it makes them harder to follow.
>
> Finally, the other temporary variable HARDLOCKUP_DETECTOR_NON_ARCH
> is used to re-compute HARDLOCKUP_DETECTOR_PERF/BUDDY when the global
> HARDLOCKUP_DETECTOR switch is enabled/disabled.
>
> Make the logic more straightforward by the following changes:
>
>   + Better explain the role of HAVE_HARDLOCKUP_DETECTOR_ARCH and
>     HAVE_NMI_WATCHDOG in comments.
>
>   + Add HAVE_HARDLOCKUP_DETECTOR_BUDDY so that there is separate
>     HAVE_* for all four hardlockup detector variants.
>
>     Use it in the other conditions instead of SMP. It makes it
>     clear that it is about the buddy detector.
>
>   + Open code HAVE_HARDLOCKUP_DETECTOR_NON_ARCH in HARDLOCKUP_DETECTOR
>     and HARDLOCKUP_DETECTOR_PREFER_BUDDY. It helps to understand
>     the conditions between the four hardlockup detector variants.
>
>   + Define the exact conditions when HARDLOCKUP_DETECTOR_PERF/BUDDY
>     can be enabled. It explains the dependency on the other
>     hardlockup detector variants.
>
>     Also it allows to remove HARDLOCKUP_DETECTOR_NON_ARCH by using "imply=
".
>     It triggers re-evaluating HARDLOCKUP_DETECTOR_PERF/BUDDY when
>     the global HARDLOCKUP_DETECTOR switch is changed.
>
>   + Add dependency on HARDLOCKUP_DETECTOR so that the affected variables
>     disappear when the hardlockup detectors are disabled.
>
>     Another nice side effect is that HARDLOCKUP_DETECTOR_PREFER_BUDDY
>     value is not preserved when the global switch is disabled.
>     The user has to make the decision again when it gets re-enabled.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/Kconfig      | 23 +++++++++++++-----
>  lib/Kconfig.debug | 62 +++++++++++++++++++++++++++--------------------
>  2 files changed, 53 insertions(+), 32 deletions(-)

While I'd still paint the bikeshed a different color and organize the
dependencies a little differently, as discussed in your v1 post, this
is still OK w/ me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
