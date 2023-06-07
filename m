Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B6DC77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 23:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjFGXhg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjFGXhd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2023 19:37:33 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F6E26A8
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Jun 2023 16:37:13 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33d22754450so10070655ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181031; x=1688773031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+jSOn4aArekcx3+zLzXPOVm14+fmJKsE3biZ6If6cY=;
        b=eF/CsreLoQfobMrHMICynZIiM+fC2cKLmXTiTpKx+xYvLsGxCv5zGk11/kBMGzDTPz
         Cg/T13MDCDY05KF83FKKUWvcvK03RMbiiQY8Thc0ZOBVLZv9XIXWdkYepBJbvePsFvvr
         Ig+5/g9zYWWykfXWtG6g8kH9q6CwSVKV3s1ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181031; x=1688773031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+jSOn4aArekcx3+zLzXPOVm14+fmJKsE3biZ6If6cY=;
        b=Vz3v+MCxLRwA1wdAcWoHZYdu+kSBJ07dWBwqhILzbuOgNybkM6RaxwVhQ0+sb0ZSEh
         2i+OIa3Un+zl65ALClUK7qSKo+gZslTqLmF6lPL31MsxpbsSdgiefmyTVejMurcYI2Is
         5dzgiD9AZnL3tKcf681g41eojHhYoFmWcfp3WjF2RbCCcjPMJwREQ+cZKpW69/lJ6xpp
         gv7PsHLDnu4+BBjlVhUmgA8vsf3LQWUHh2xahRAVQ3IFrMzsg4UA6Fua2ZUVQcE3MQLe
         q1NGFgipSPrNYE6ZjUde8uMBBAp4ga0GnAtbxoPNtePDee+W2rADnI+0JBhylutb50ev
         NZrA==
X-Gm-Message-State: AC+VfDx0T/SLOOsSN3WLxBaKko6cZM0DiBXOrzPGVlBBSddKuPqEXEMx
        ixrLuhcaDaQNGCiydc6Ds/enBIINAFYwe5qsUUk=
X-Google-Smtp-Source: ACHHUZ517VvX8rJ1naWzmErX3gyaKRVcqZizq8Gwe7pKHcQ8GlU06Ouy8q5DM1gthgzcNWJrHSB5mw==
X-Received: by 2002:a92:cb05:0:b0:331:763b:b3a1 with SMTP id s5-20020a92cb05000000b00331763bb3a1mr9014810ilo.6.1686181031457;
        Wed, 07 Jun 2023 16:37:11 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id q18-20020a02cf12000000b0041f4d47722csm2802781jar.126.2023.06.07.16.37.02
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:37:05 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33dea7d5424so26205ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:37:02 -0700 (PDT)
X-Received: by 2002:a05:6e02:170c:b0:33c:a46c:23b3 with SMTP id
 u12-20020a056e02170c00b0033ca46c23b3mr99141ill.1.1686181022226; Wed, 07 Jun
 2023 16:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-7-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-7-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:36:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-H9z20zT8Oop5+Hnf-S3QgiotzQ=f3LGvN6AiLUxi=Q@mail.gmail.com>
Message-ID: <CAD=FV=V-H9z20zT8Oop5+Hnf-S3QgiotzQ=f3LGvN6AiLUxi=Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] watchdog/sparc64: Define HARDLOCKUP_DETECTOR_SPARC64
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

On Wed, Jun 7, 2023 at 8:26=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> The HAVE_ prefix means that the code could be enabled. Add another
> variable for HAVE_HARDLOCKUP_DETECTOR_SPARC64 without this prefix.
> It will be set when it should be built. It will make it compatible
> with the other hardlockup detectors.
>
> Before, it is far from obvious that the SPARC64 variant is actually used:
>
> $> make ARCH=3Dsparc64 defconfig
> $> grep HARDLOCKUP_DETECTOR .config
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64=3Dy
>
> After, it is more clear:
>
> $> make ARCH=3Dsparc64 defconfig
> $> grep HARDLOCKUP_DETECTOR .config
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64=3Dy
> CONFIG_HARDLOCKUP_DETECTOR_SPARC64=3Dy
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/sparc/Kconfig.debug | 10 +++++++++-
>  include/linux/nmi.h      |  4 ++--
>  kernel/watchdog.c        |  2 +-
>  lib/Kconfig.debug        |  2 +-
>  4 files changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
