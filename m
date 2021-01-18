Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB80C433DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 15:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E592245C
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 15:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405825AbhARPVM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 10:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405286AbhARPUp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 10:20:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 792F2223E8
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610983204;
        bh=F9zx6aNlGiK2ADjiuajjxn5pHpynVe/Ym8MGgaQx9kE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r1RihukUh/1DCAH6qCsQbr95RZdSeg5Vf2GF5h4OYp/AkvE2BgICjMdMYjODgyUpv
         S6A9KJ+2VUoXrEVaLi/TZksCAxgyUI0LCT0zc/Kicmu/uiGSQdc00doTUYcSXU0RzW
         VubvERptmxyHyBaovmebBEGDiHkY6zchlvT4kYAWrmVHANplPXEeqgLGdIW+QvbdZg
         qz0IaCdnF33vzIE4KKnuuVrfGPtAjV9RIampXXOpD/tQAjeVWCHvEqfVl7usozd5v6
         9/wMrltWnB2En62eD4dh0lpN1NmUBrFL6dEl1op67EInBbh3R60Yn821+ZF62DfZpy
         lyGNoCftuYPPw==
Received: by mail-ot1-f41.google.com with SMTP id w3so16518697otp.13
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 07:20:04 -0800 (PST)
X-Gm-Message-State: AOAM5311K0TmZUwNb1XQLR2xgzjnn2nLHM+fXgWBkjs+7o6nrfHsy+u7
        MViJpr8I+dw+zxGNQKteA7eyYb6g9If6AUBS65c=
X-Google-Smtp-Source: ABdhPJx3ItoX6SB05ukriTmlj614AEls8Ei/3+EVOdnv1xH0FuJhifAfBEgrFPIWhmUl0PEM4jhVRWy4QfrNv9w8jik=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr2516390otq.305.1610983203837;
 Mon, 18 Jan 2021 07:20:03 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com> <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com> <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
In-Reply-To: <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Jan 2021 16:19:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
Message-ID: <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
Subject: Re: perf tools build broken for RISCV 32 bit
To:     Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Khem Raj <raj.khem@gmail.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 18, 2021 at 3:53 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
>
> Hi,
>
> after some searching I found this patch from Yocto project:
>
> https://www.mail-archive.com/linux-yocto@lists.yoctoproject.org/msg01004.html.
>
> I don't know if it's ever been proposed as mainline patch.
>
> What do you think about it? Could it be the right solution?

No. While this makes it work on rv32, it does not fix it in a
way that makes it work on other architectures with a time64
libc. If you fix it, please do it in a way that works on all architectures.

I had really expected both Alistair and Khem to know better.

      Arnd
