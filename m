Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B154C7EE25
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 23:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjFGXhu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjFGXhr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2023 19:37:47 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AAD26A0
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Jun 2023 16:37:28 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-33d37cc9d12so8363545ab.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181047; x=1688773047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKF2b8Vjs6mvxh6WU02Nj8q7SFKUM+Iw8gQlZJ28woQ=;
        b=ZLYxN3i/8aqPg8Ck8v+7WXh+Hyw5IVGfz5XgKH/QyTeEn8jzz9NnbLOH2aRkS0Yym1
         A/SEpyVe+Co6qpDCVmgXXoebo8PMyKbBhccnDo30V5PRZ0eTyjQotHtMTfdh8IM+caCn
         4bFIKFV7fzwC1yMYfxrrlIobxf25rGo5OPK9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181047; x=1688773047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKF2b8Vjs6mvxh6WU02Nj8q7SFKUM+Iw8gQlZJ28woQ=;
        b=N7rE9Dse3S/C0FSBAmFpE92uFa7ahi36ACELIxrnPHdnWOqsnoC+PPQuF7+jGzykYE
         2WpfUbmq7ysz75Sl223oZyDqvki9vvcHsQgejkSbDCXAhmkmBq2QqtNrnAkrN20JZBMo
         p9XDFWHhPcgjIsh99iWLYomhreCjPEHJ2Sxs/pWq+Up36xRZtUGNGqDjkkBJdEUoVEOf
         7u8xEDW2BEFfOey3+PbJ72O2fD6+W/rbQ0rwtmrKZQrHW0Mm7TKkx0PR9UZjuGug8p3A
         NuMZoLV0tbJj5f4DhOUSBRsw+4rC/Yj7WbSFpkjenfIflG8/iMgQuAOJ6Xacc4iYE5+3
         /HPg==
X-Gm-Message-State: AC+VfDypKusyF34FVX0tDv8kc0U0vkBvspmK2sHWFip+4eb9CeJPnCT1
        uKxkiWWy2zpzsBi1lIR8hzaAvPojSS0vCanVkZ4=
X-Google-Smtp-Source: ACHHUZ7aJknxCMMxktL6Ex9TSLRcIwCz7Cefgn5XUR6lKC3kOQD+U9CRT3MvTjyejstaZCUqz52ywg==
X-Received: by 2002:a92:90f:0:b0:33d:16b6:3df8 with SMTP id y15-20020a92090f000000b0033d16b63df8mr6433466ilg.24.1686181047660;
        Wed, 07 Jun 2023 16:37:27 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id t9-20020a02cca9000000b0041f49dbcaf3sm2957176jap.171.2023.06.07.16.37.22
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:37:23 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33d928a268eso54725ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:37:22 -0700 (PDT)
X-Received: by 2002:a92:cda5:0:b0:338:1993:1194 with SMTP id
 g5-20020a92cda5000000b0033819931194mr7952ild.2.1686181042584; Wed, 07 Jun
 2023 16:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-8-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-8-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:37:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8CTttqz9jL6TockdKTd1dM1ApR4Nw+X3OF5tgoagfRQ@mail.gmail.com>
Message-ID: <CAD=FV=U8CTttqz9jL6TockdKTd1dM1ApR4Nw+X3OF5tgoagfRQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH
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
> @@ -1102,6 +1103,14 @@ config HARDLOCKUP_DETECTOR_BUDDY
>         depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
>         select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
>
> +config HARDLOCKUP_DETECTOR_ARCH
> +       bool
> +       depends on HARDLOCKUP_DETECTOR
> +       depends on HAVE_HARDLOCKUP_DETECTOR_ARCH
> +       help
> +         The arch-specific implementation of the hardlockup detector is
> +         available.

nit: "is available" makes it sound a bit too much like a "have"
version. Maybe "The arch-specific implementation of the hardlockup
detector will be used" or something like that?

Otherise:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
