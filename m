Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B142CC43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 09:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiGRJBs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 05:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiGRJBs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 05:01:48 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0849211A1F
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 02:01:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id f73so19565293yba.10
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwIR57e0FpLcYSgHsIlB7cNnZ4wN4yZUqWvCDFdbb1A=;
        b=wlKycwQn3NPKJsiygbPpb+xpZQGwblMIPQG+J4zoQskTSg3yPVUBtGxcPWP/c1yZ16
         /RqkK5G+YTVpneAW0nvxxOAih2jqSXAfkS53i9Y41xvCKo6UFr8ZzDXYYjbkM8KETgRC
         Sh2clEMrRPex39CjQxfYE8+zbsIbUlXWdKWEF4MhP3FGaB6LLIqAx7dbd6/C1m/QHIlH
         ZrdEArAp1CRluArreszsjeSeGtY+4b+6wMtmrfftN/WqA+7oYBH2FRsIWIsCO9aKh5cm
         5muW/BJGoZ+w3Mvr6Fz0CgRZUSTFDe+wsvNXd6allxOWNF1tjkDS3mAnqEfFyCBJDsgc
         gLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwIR57e0FpLcYSgHsIlB7cNnZ4wN4yZUqWvCDFdbb1A=;
        b=3s1SWhZ71YVaa3I61jqle02btqLtgcJaPFbae5XsSBUG4NiNaI7NTmyiuws++yMJNQ
         CwR86buoU5xg2VXKRD8UBsXdrVLTFd2OpeTY8saBVX+SUr4wFn4bK+HOyGOK4U9zBCCy
         Pmn9GDi01K2f4ZpdbcCY58YAeei4veKuCzxpdzAtieoKNwxnXygOGm/AKYI227hOjUwD
         ++PFuIDQKgSD0sY1PEkNt2VrcVEPPukR2aWsaA7vBBuBOfPfkBhJ2PFQ/hsCpzHy1MUa
         Q7Cs9HG0i9fIcQGWMC1HpEExE+96su/VppFyguPu56qe4Vuw6k6ecUjWRSa/4R5SqYPI
         rp5g==
X-Gm-Message-State: AJIora+DAEpez657pT5x/KlZJCZtvfVnjIlpPafXBhactrDRvmS4etOB
        2xCHmTK9PCoLWWSIwdUEGUaVr7Aw2eO8FJZhu26KQg==
X-Google-Smtp-Source: AGRyM1t5Q5wZByTTLxFH8JVS7pwe73tESzwepbBLzJfkt4scpJhV5hBV8XU73ln+CgaRWSYRXmHKb0vTaAqvKeaCFtk=
X-Received: by 2002:a05:6902:124e:b0:668:222c:e8da with SMTP id
 t14-20020a056902124e00b00668222ce8damr25009907ybu.383.1658134904805; Mon, 18
 Jul 2022 02:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220712021527.109921-1-lihuafei1@huawei.com> <20220712021527.109921-3-lihuafei1@huawei.com>
In-Reply-To: <20220712021527.109921-3-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:01:33 +0200
Message-ID: <CACRpkdY0Jo7rzXjc10dLLrHnDkoBphvNYiyF5q8iHz-8QqaEwA@mail.gmail.com>
Subject: Re: [PATCH 2/5] ARM: stacktrace: Avoid duplicate saving of exception
 PC value
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
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

On Tue, Jul 12, 2022 at 4:18 AM Li Huafei <lihuafei1@huawei.com> wrote:

> Because an exception stack frame is not created in the exception entry,
> save_trace() does special handling for the exception PC, but this is
> only needed when CONFIG_FRAME_POINTER_UNWIND=y. When
> CONFIG_ARM_UNWIND=y, unwind annotations have been added to the exception
> entry and save_trace() will repeatedly save the exception PC:
>
>     [0x7f000090] hrtimer_hander+0x8/0x10 [hrtimer]
>     [0x8019ec50] __hrtimer_run_queues+0x18c/0x394
>     [0x8019f760] hrtimer_run_queues+0xbc/0xd0
>     [0x8019def0] update_process_times+0x34/0x80
>     [0x801ad2a4] tick_periodic+0x48/0xd0
>     [0x801ad3dc] tick_handle_periodic+0x1c/0x7c
>     [0x8010f2e0] twd_handler+0x30/0x40
>     [0x80177620] handle_percpu_devid_irq+0xa0/0x23c
>     [0x801718d0] generic_handle_domain_irq+0x24/0x34
>     [0x80502d28] gic_handle_irq+0x74/0x88
>     [0x8085817c] generic_handle_arch_irq+0x58/0x78
>     [0x80100ba8] __irq_svc+0x88/0xc8
>     [0x80108114] arch_cpu_idle+0x38/0x3c
>     [0x80108114] arch_cpu_idle+0x38/0x3c    <==== duplicate saved exception PC
>     [0x80861bf8] default_idle_call+0x38/0x130
>     [0x8015d5cc] do_idle+0x150/0x214
>     [0x8015d978] cpu_startup_entry+0x18/0x1c
>     [0x808589c0] rest_init+0xd8/0xdc
>     [0x80c00a44] arch_post_acpi_subsys_init+0x0/0x8
>
> We can move the special handling of the exception PC in save_trace() to
> the unwind_frame() of the frame pointer unwinder.
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

This is another very nice patch!
Reviewed-by: Linus Waleij <linus.walleij@linaro.org>

Nitpick:

> +               if ((unsigned long)&regs[1] > ALIGN(frame->sp, THREAD_SIZE))
> +                       return -EINVAL;

It'd be nice to add a comment saying what is in regs[1] at this point
so it is easier to understand the code. Not your fault as it is just
moved code, but if you have time please add a small comment.

Yours,
Linus Walleij
