Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB22C7EE25
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 23:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjFGXhS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjFGXhR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2023 19:37:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4D02707
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Jun 2023 16:37:03 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33b4b70693eso10231155ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181021; x=1688773021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG+ft0QEOw+l4T57sY6QqoB2Q4VLY5mgSyLH0/dKkXM=;
        b=oaXcUKk5abltt6CAWt7RJKDE5+S8Q4mmUuvuRLrU3jPFHt79X8tNA3wXI83YBky7rD
         rrFto6RsX2P8luXadcahrNXiZvtT9UkWbkZ/Xmo2V6dPNJSfN4+WeHREpK9oJtUeIPYr
         4dZT39+OmMK/aEAbjtcZHjy9KssyfdIX9Ia3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181021; x=1688773021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG+ft0QEOw+l4T57sY6QqoB2Q4VLY5mgSyLH0/dKkXM=;
        b=lOOMBbVylhxeyMR3s7sS2qoXMcQ9Y1p4kguIrunxiIIMGR9rqyBdmApv1kGNZFSzHD
         V6w3vTuts3i72tbj7B7Pyk026T3jBjmoqWowaO5Qxq6LilR0f1r+QASGt2CEH5EJ/PwC
         nYLLLKVfm3CCwyJ2Mr+4RCPOBmKYV4M5QvDl/X0T7BW4NnFSMH579iHwKqeKcLeWKK+Q
         ruhMxdpJouq9EUwHTWweHrI3h01iOoW9TPFfKzqFQUUSHld0dZq9D0KNyxk/HhZlJXwU
         5LXjQmWqhwNc+3q/DWGxjwGp1W7jLOMKmB12Z4PAgFWNT06JLp7Nn1/U7tKhMKEqnL0K
         Dnnw==
X-Gm-Message-State: AC+VfDwtXANf0p5PWPiuH+UayrmHVGSBZGaBnA9zEJa3tnBrdmg7hvpM
        vpbhdcVfgV9Vy/aKYFNL7PGQBrINvn/fs+E1D+4=
X-Google-Smtp-Source: ACHHUZ7byOiJjh6uvV9ZdVkdH/mV0dR3oxAaQDYjLj9mq1jX1IlGmm7KnmPb6ddJz7GMA8F7kdJFPg==
X-Received: by 2002:a92:d9c5:0:b0:33e:6230:aa6f with SMTP id n5-20020a92d9c5000000b0033e6230aa6fmr1764209ilq.2.1686181021755;
        Wed, 07 Jun 2023 16:37:01 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id x9-20020a92dc49000000b0033d2b3928d1sm36761ilq.51.2023.06.07.16.36.55
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:36:56 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so56555ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:36:55 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c4c:b0:33d:8238:80c6 with SMTP id
 d12-20020a056e021c4c00b0033d823880c6mr101962ilg.9.1686181015033; Wed, 07 Jun
 2023 16:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-6-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-6-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:36:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTKR42i8hozXSfSHu07TQ7g1TJQs8dqpqGHHraZr+-vQ@mail.gmail.com>
Message-ID: <CAD=FV=VTKR42i8hozXSfSHu07TQ7g1TJQs8dqpqGHHraZr+-vQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] watchdog/sparc64: Rename HAVE_NMI_WATCHDOG to HAVE_HARDLOCKUP_WATCHDOG_SPARC64
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
> The configuration variable HAVE_NMI_WATCHDOG has a generic name but
> it is selected only for SPARC64.
>
> It should _not_ be used in general because it is not integrated with
> the other hardlockup detectors. Namely, it does not support the hardlocku=
p
> specific command line parameters and systcl interface. Instead, it is
> enabled/disabled together with the softlockup detector by the global
> "watchdog" sysctl.
>
> Rename it to HAVE_HARDLOCKUP_WATCHDOG_SPARC64 to make the special
> behavior more clear.
>
> Also the variable is set only on sparc64. Move the definition
> from arch/Kconfig to arch/sparc/Kconfig.debug.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/Kconfig             | 12 ------------
>  arch/sparc/Kconfig       |  2 +-
>  arch/sparc/Kconfig.debug | 12 ++++++++++++
>  include/linux/nmi.h      |  4 ++--
>  kernel/watchdog.c        |  2 +-
>  lib/Kconfig.debug        |  5 +----
>  6 files changed, 17 insertions(+), 20 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
