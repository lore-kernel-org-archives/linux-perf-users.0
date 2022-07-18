Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970D6C43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 09:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiGRJOy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 05:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiGRJOv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 05:14:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D34011449
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 02:14:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l23so20071235ejr.5
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwFbbauDX9gsZYxtY8fxgYizduNV3aBKsO3yUHiYWcA=;
        b=lOzYBZxkWa12PFEYxuRa3esea0uZmAzb/unlVnlRnHnhGEcFOCjG5X8DbepRn1wyTe
         JoxJDTxc5gvW/Gs1ToHLdEEEHD/HuuzW/ZZFtax6eEzY0qPDWja14ZRctGByO3HY9bbb
         8GQETaShmaNthrEDIDz5sk72HoLj45JDd4chLJlosTfzpiG0MJMWsXlZXMlOS9/W2Vy6
         nwOD7j0J64i/6T3zM/DnxFniv+zu7SL+KLPl/kR2adbEsVCLomFDOlIV/Rvj0oqGSSHb
         J5kYntdMLrmzpvbmIUOTB62LeN4drnmiHLsEPXJEqU1wDXIUmLbycaKfos5QQcNiI10u
         Icgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwFbbauDX9gsZYxtY8fxgYizduNV3aBKsO3yUHiYWcA=;
        b=UiwNeD8p+pbpub62bmy3vbh2cO9WIuqu+zo3xW9UkHOJfdx8Ff6kgZEKNFRhHVnqY1
         806d7O+NpMtuQk6V7N0AEQ2km1FLOlyv8J0txaApRROCIhrRs0rtSszxDVbMH71xYIDB
         5Qhqlg1t7USnIbpFJSUFaZ6k0xjLyWbKrPnb+1IC3KdPeLSMiPbzWDNKy39Jo0qnnXBS
         av5T0Kxw9gfvPpVEo52y3sdZ4x8d1Vlrh1yTPy0SX0B0Jl/M3Q4hSAr8woRTpnELF1Jf
         QZId40t+hEspDRNog1zS7SS5MtVPY2z28KElGk8K7Jn+Ylx8shYklp/t051V/FDzpfxQ
         ekFw==
X-Gm-Message-State: AJIora9mpUhlMsHnV0gKV6ea5VsoLtzVVn4YX0NrM7yVL0zr6Pa9bLDi
        JHkxY6IiqB/oJYkA5171F1PM3zJzVuQ3e/lAd3QARg==
X-Google-Smtp-Source: AGRyM1tCH5IixWtJI6STLtZK5K2JWPfTCLpcSnp75RgNnuxfWdyUFS3S8v9F4PaWSdnjzvnIzUM7VsEodFwZl4fW2Sc=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr24964642ejs.190.1658135688605; Mon, 18
 Jul 2022 02:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220713110020.85511-1-lihuafei1@huawei.com>
In-Reply-To: <20220713110020.85511-1-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:14:37 +0200
Message-ID: <CACRpkdYmwojupt_024LKA2B0e7zBKmreYYX3ZMC56i5Vrr3fFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ARM: Convert to ARCH_STACKWALK
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 13, 2022 at 1:02 PM Li Huafei <lihuafei1@huawei.com> wrote:

> This series mainly updates the ARM stack trace code to use the newer and
> simpler arch_stack_walk() interface. Two issues were fixed before that
> (see patch 1 and 2), as well as allowing stack_trace_save_tsk() to
> trace non-current tasks (see patch 3).
>
> v2:
>  - As suggested by Mark, the commit logs for patch 4 and 5 were
>    refined for easy review.

I see I reviewed v1 when v2 was already out but think the
comments still stand.

I think you can already add patches 1 & 2 to Russells patch tracker,
they are straight-forward fixes.

Patches 3-5 may need some elaboration but I trust that you have
done some serious testing since you found the snags in
patches 1 & 2.

Yours,
Linus Walleij
