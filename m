Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B94EB64DC
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 13:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245114AbjFNNrk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbjFNNrj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 09:47:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17FB9C
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 06:47:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f624daccd1so8186026e87.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686750453; x=1689342453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76di/i2mInmVCxeVKqtSRBrcXSBLthtuA5QqmKpv0gg=;
        b=jlp8OxtI66wmx6ofvYbecBCQapH2lREmqablzfBh+9OExysu5k9h76l1tCeV8/J90c
         4Z1ZouQnIxyCpFC63R+Y2e/3+b2Jxk5JrOBGOCsPtQ8f8vMjLIC0eQU8nmbwpRYwQPz+
         zcnti9QTI56yIvgkrHHGpaaUQcJKbnO76la6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750453; x=1689342453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76di/i2mInmVCxeVKqtSRBrcXSBLthtuA5QqmKpv0gg=;
        b=Z0+Cc33gO4/5pbv/sw+NuFvHV5Lw4JxHMVIh7Bi9b2dnaKqdpWJqGwJw+PCjdA5o5u
         NO1zEPu2cKQTdpmOhY661+gfTwX4TN7/5FTWFkCz8BR6jvUzKYQxf3F7tuHvLKSAjQNc
         5X7MaC2Nci11LcSOynbens5Tk5vx6x4Lq2ayYrnNUggIxAm5536zXxT8lovIYocKnygP
         A3cqRjJlCBaw1latGvfCE2HhWtK8jWVfvA5p8U3LwOYWc9QwlepaxBxMkcub86D7N5kU
         r5p9cnv+ob5b0a+9fLd6V5JsSqPV+bP2XYB/FEFE62fNA4PUWhGhABJhGJruzlCp9jIr
         Wh+A==
X-Gm-Message-State: AC+VfDzI517Osxn3ieHuWLFiCwxL5P1eIWHnWzYLAyUjK9nkWODlVqV5
        uzrO4P/GcuqqyFdyj+sDeLjQOglKwshPjDaf6dWz4GEE
X-Google-Smtp-Source: ACHHUZ6O6V+Y6LCP95dwOe0TCKA0JFxGS7HEppJaH5GNU7PTNlB9vYqgsHzBqtGyBp7WSNAFX8TRMQ==
X-Received: by 2002:a19:760e:0:b0:4cc:96f8:f9c6 with SMTP id c14-20020a19760e000000b004cc96f8f9c6mr6484293lff.5.1686750452998;
        Wed, 14 Jun 2023 06:47:32 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id u3-20020aa7d543000000b00514bddcb87csm7893376edr.31.2023.06.14.06.47.31
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 06:47:32 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so8280a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 06:47:31 -0700 (PDT)
X-Received: by 2002:a50:9f82:0:b0:50b:c48c:8a25 with SMTP id
 c2-20020a509f82000000b0050bc48c8a25mr104476edf.6.1686750451172; Wed, 14 Jun
 2023 06:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-3-pmladek@suse.com>
 <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com>
 <ZIG1Qi0iUjTKICQM@alley> <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
 <ZImWd62fXjsZildv@alley>
In-Reply-To: <ZImWd62fXjsZildv@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Jun 2023 06:47:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WP39nUmdeNjjTGx-XWhS4AgG5haHCfYjFUCEKckYVZDA@mail.gmail.com>
Message-ID: <CAD=FV=WP39nUmdeNjjTGx-XWhS4AgG5haHCfYjFUCEKckYVZDA@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 3:29=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> It seems that we have entered into a bike shedding mode.
> The following questions come to my mind:
>
>    1. Does this patchset improve the current state?
>
>    2. Maybe, it is not black&white. Is it possible to summarize
>       what exactly got better and what got worse?
>
> Maybe, there is no need to do bike-shedding about every step
> if the final result is reasonable and the steps are not
> completely wrong.
>
> I just followed my intuition and tried to do some changes step
> by step. I got lost many times so maybe the steps are not
> ideal. Anyway, the steps helped me to understand the logic
> and stay reasonably confident that they did not change
> the behavior.
>
> I could rework the patchset. But I first need to know what
> exactly is bad in the result. And eventually if there is more
> logical way how to end there.

Sure. I still feel like the end result of the CONFIG options after
your whole patchset is easier to understand / cleaner by adjusting the
dependencies as I have suggested. That being said, I agree that it is
the type of thing that can be more a matter of personal preference. I
do agree that, even if you don't take my suggestion of adjusting the
dependencies, the end result of your patchset still makes things
better than they were.

...so if you really feel strongly that things are more understandable
with the dependencies specified as you have, I won't stand in the way.
I still think you need a v2, though, just to address other nits.

-Doug
