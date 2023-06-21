Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB3EB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 23:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFUXua (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 19:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUXu2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 19:50:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9741B10C1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 16:50:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-988e6fc41ccso428560266b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 16:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687391425; x=1689983425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhYNZ0vxtpjuX5s0wcMa09N91qzj3byTq4ke4NqIBlc=;
        b=HZDteg5s2Vpl4Dj3x2y2xDB5nI/Qbe7Mj8TIWbglj/Afe2Df8ThS6myu4ctAr7BySI
         lN6IEuMEfPC2jekn2PiCOzacJ5o3hhPY0TVfjYc90WW++TO4fcWk3jVeIIqDxZW+Ag+v
         3gWB4WdyMMmHkHwc3FuCxBT4mKHgXUkDjtvgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687391425; x=1689983425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhYNZ0vxtpjuX5s0wcMa09N91qzj3byTq4ke4NqIBlc=;
        b=A62pz2wue7dS4KqjEWTlKbUO44WduiYxTCGlLACZnnGgYj6nU8W1GIVb3hkAGPcJQD
         js0d4HR5cQIeOr2XzkAa+2Sio+TSpi0UqAptWSaHBveyaE1L4ZI5rJWyK9t5dPhtl2J7
         6g7EN/JcQ0Mb1UijhxqDTKIUFYjjar7hIJE0Be3MA+dke8/c8RJiCX3DDU+dVDA3kspx
         MJN4NO9qZ2ejpF+9lfJtbwWUY3UzY00axKyTo8AMiqJj2ilpU2mryIUwoP6lnUR86Jwy
         r/ASaa05mK7vrPXoYB9g18lWdvB/vPWC/YcDhA+yNDllCRf3/XlK0x9gxALFrQ094K7c
         y1aQ==
X-Gm-Message-State: AC+VfDwR6oEkIHVXqdIaLRcgXeLstjSIO3LeSfzsDpVc8oDj9rAj39ih
        azoV9qAsFmmNy3xIztPZIWiF0zH7ZSPqrAgypmYq8PfL
X-Google-Smtp-Source: ACHHUZ5HkpEKBM4S/Qk3F7ExUwRSgBdrcSWZ8rQkqSmx1DPD5aEsa4lRm9aic1gcrJbdvAMRqjwJhQ==
X-Received: by 2002:a17:907:60d4:b0:988:a986:b11c with SMTP id hv20-20020a17090760d400b00988a986b11cmr8145622ejc.29.1687391425215;
        Wed, 21 Jun 2023 16:50:25 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id qu21-20020a170907111500b00982cfe1fe5dsm3672658ejb.65.2023.06.21.16.50.24
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 16:50:25 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so730a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 16:50:24 -0700 (PDT)
X-Received: by 2002:a50:c35e:0:b0:519:7d2:e256 with SMTP id
 q30-20020a50c35e000000b0051907d2e256mr4978edb.0.1687391424164; Wed, 21 Jun
 2023 16:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-7-pmladek@suse.com>
 <871qi5otdh.fsf@mail.lhotse>
In-Reply-To: <871qi5otdh.fsf@mail.lhotse>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Jun 2023 16:50:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgC0JkjMZjx0z-gt0iXp-UJr87nutB9xWKhB6qMzWWNg@mail.gmail.com>
Message-ID: <CAD=FV=XgC0JkjMZjx0z-gt0iXp-UJr87nutB9xWKhB6qMzWWNg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
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

On Wed, Jun 21, 2023 at 6:08=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Petr Mladek <pmladek@suse.com> writes:
> > The HAVE_ prefix means that the code could be enabled. Add another
> > variable for HAVE_HARDLOCKUP_DETECTOR_ARCH without this prefix.
> > It will be set when it should be built. It will make it compatible
> > with the other hardlockup detectors.
> >
> > The change allows to clean up dependencies of PPC_WATCHDOG
> > and HAVE_HARDLOCKUP_DETECTOR_PERF definitions for powerpc.
> >
> > As a result HAVE_HARDLOCKUP_DETECTOR_PERF has the same dependencies
> > on arm, x86, powerpc architectures.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  arch/powerpc/Kconfig | 5 ++---
> >  include/linux/nmi.h  | 2 +-
> >  lib/Kconfig.debug    | 9 +++++++++
> >  3 files changed, 12 insertions(+), 4 deletions(-)
>
> Something in this patch is breaking the powerpc g5_defconfig, I don't
> immediately see what though.
>
> ../arch/powerpc/kernel/stacktrace.c: In function =E2=80=98handle_backtrac=
e_ipi=E2=80=99:
> ../arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of=
 function =E2=80=98nmi_cpu_backtrace=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
>   171 |         nmi_cpu_backtrace(regs);
>       |         ^~~~~~~~~~~~~~~~~
> ../arch/powerpc/kernel/stacktrace.c: In function =E2=80=98arch_trigger_cp=
umask_backtrace=E2=80=99:
> ../arch/powerpc/kernel/stacktrace.c:226:9: error: implicit declaration of=
 function =E2=80=98nmi_trigger_cpumask_backtrace=E2=80=99; did you mean =E2=
=80=98arch_trigger_cpumask_backtrace=E2=80=99? [-Werror=3Dimplicit-function=
-declaration]
>   226 |         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_b=
acktrace_ipi);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         arch_trigger_cpumask_backtrace
> cc1: all warnings being treated as errors

Yeah, I can reproduce that.

The problem is that before ${SUBJECT} patch "include/linux/nmi.h"
would include <asm/nmi.h>. Now it won't.

There are a ton of different ways to fix this, but I think the one
that makes sense is to be consistent with other architectures and move
the "arch_trigger_cpumask_backtrace" definitions to asm/irq.h.

https://lore.kernel.org/r/20230621164809.1.Ice67126857506712559078e7de26d32=
d26e64631@changeid

-Doug
