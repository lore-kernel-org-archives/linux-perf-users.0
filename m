Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A08C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 08:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiGRI5p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiGRI5o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 04:57:44 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D369A11C32
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 01:57:43 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r3so19656648ybr.6
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4hcKXeKDY4mZgkkWrO2UJFIB2+YkvdMpf7oiIiz6Vw=;
        b=UCIHI1H6TeNg0v3uYSbIuL/VieFk1ImiXQDuN/19M2oYbk+kcyRKEEqHGhqSw3eUut
         BdnC2zIydmA4KpoHM2EtnVw+ahe4W6zoILmUWR59hch4t38x8wPS53oZhJLwySWmW7Z9
         vHjEDczIaHH3Qftdg7tdTxUstk77/GJABs7mPAZGyswj7G7P3ikkEgn2C4trLQ+r2mz4
         RqM4ConzLpmjisWpgCVxPDvqWjg+e+j8PNmJSPgP7WrNbTU46G4nBXIMkB76x6q+uaFm
         vhOTUvCGzEGEPAprRntYjRsx1Vk6cQXsB+oJPey+mkXfUzy6e25fNM6/jcy+JAkMGsV+
         vVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4hcKXeKDY4mZgkkWrO2UJFIB2+YkvdMpf7oiIiz6Vw=;
        b=UK6MWtw5fXEbRwRbL0+WAkHa/s+mbwieP6INu6hy7nBd42fENwDkfoGSNCY2XoyA/Z
         ZAN+fZHF8GnzjW75lzeTZ7cPFyP21K5ZW/vOCfpEnl/pgFlSJ9HnEp+10amXGhs2pYsA
         Q91+o1nmivDdb46/AvloRM3nmCSK7k1jI3vRLZ+KRIIJG5YBXuhTT/cFUgqY1EFwgzEh
         +HX6LTYDRaXEOQ5Smaim8fxlJvElpvwtAgQwgooAXdXF5UbwcIAtQDhWZJ0fEHLcxzSi
         GxNfgMJH6pblBKcimRvEuu7LuvXJihqWGYbLtIJkzLODen95+bGxthaC/AV2/EQuRejk
         kzIA==
X-Gm-Message-State: AJIora+idUsBFUshlz99y90lAuWJ+iVqx4MQ7dMmlYWfLF0hvFuw1u7f
        H2cyUDghnTxxtCYDmrWGE36FJkMkc2kuP1jJ66XleA==
X-Google-Smtp-Source: AGRyM1uvQuAYd5Xd3CpqPVNwGhgZoalb7/c9+nWogQm4nDzGun/0TtAYRBVk6lqyyRP8T4PC+GMB4hceI7OvjD3faTY=
X-Received: by 2002:a5b:9c5:0:b0:66e:cbbf:2904 with SMTP id
 y5-20020a5b09c5000000b0066ecbbf2904mr24557371ybq.220.1658134663023; Mon, 18
 Jul 2022 01:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220712021527.109921-1-lihuafei1@huawei.com> <20220712021527.109921-2-lihuafei1@huawei.com>
In-Reply-To: <20220712021527.109921-2-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 10:57:31 +0200
Message-ID: <CACRpkdaXDGHLwqXQsEedRt=CLRUe1hei1vJDGAQ+D4U0OPcv8Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: stacktrace: Skip frame pointer boundary check
 for call_with_stack()
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

> When using the frame pointer unwinder, it was found that the stack trace
> output of stack_trace_save() is incomplete if the stack contains
> call_with_stack():
>
>  [0x7f00002c] dump_stack_task+0x2c/0x90 [hrtimer]
>  [0x7f0000a0] hrtimer_hander+0x10/0x18 [hrtimer]
>  [0x801a67f0] __hrtimer_run_queues+0x1b0/0x3b4
>  [0x801a7350] hrtimer_run_queues+0xc4/0xd8
>  [0x801a597c] update_process_times+0x3c/0x88
>  [0x801b5a98] tick_periodic+0x50/0xd8
>  [0x801b5bf4] tick_handle_periodic+0x24/0x84
>  [0x8010ffc4] twd_handler+0x38/0x48
>  [0x8017d220] handle_percpu_devid_irq+0xa8/0x244
>  [0x80176e9c] generic_handle_domain_irq+0x2c/0x3c
>  [0x8052e3a8] gic_handle_irq+0x7c/0x90
>  [0x808ab15c] generic_handle_arch_irq+0x60/0x80
>  [0x8051191c] call_with_stack+0x1c/0x20
>
> For the frame pointer unwinder, unwind_frame() checks stackframe::fp by
> stackframe::sp. Since call_with_stack() switches the SP from one stack
> to another, stackframe::fp and stackframe: :sp will point to different
> stacks, so we can no longer check stackframe::fp by stackframe::sp. Skip
> checking stackframe::fp at this point to avoid this problem.
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Very nice catch! Took me some time to realize what was
going on here.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Nitpick below:

> +       /*
> +        * call_with_stack() is the only place we allow SP to jump from one
> +        * stack to another, with FP and SP pointing to different stacks,
> +        * skipping the FP boundary check at this point.
> +        */
> +       if (pc >= (unsigned long)&call_with_stack &&
> +                       pc < (unsigned long)&call_with_stack_end)
> +               return 0;

Can we create a local helper macro to do this, if it needs to happen
some other time?

#define ARM_PC_IN_FUNCTION(pc, func) (pc >=. ...)

Yours,
Linus Walleij
