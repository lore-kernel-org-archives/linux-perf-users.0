Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1DCEE49A5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 23:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjHVXO1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHVXO0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 19:14:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266C210D
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 16:14:24 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50091b91a83so1153398e87.3
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692746062; x=1693350862;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSHMwkSWj+u0BB4H/Eo8pB+iKXhMpxFBtrURAK/KgwY=;
        b=CFQLVEZLykqjzDO7usGcMJuYkJlvatCTEZRBqCa5ZQK+ctOL++F8hjWBQU/QQNbz1x
         ddIRInCUD8C2fG5FUO/vHg+B/KkgFbXq2pbO7k6qHnqQrhMjV5f5cfy0sW+JF5vwePBo
         HNM+NJz7fv46v8rG41AMguHMRE2oMWrER6LZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692746062; x=1693350862;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSHMwkSWj+u0BB4H/Eo8pB+iKXhMpxFBtrURAK/KgwY=;
        b=M7jQIpjmzdfkz9CQ2H43kClDl/usvgFzUZNgQLcoKFR+Y/rpWBRtsj1x2wjCtRu8R4
         KX2tIpqK5iT64v+eZoEPVgPlsbXA/6U7jBLXLkAy2/YMm0+vxaEQ02VWTjTlcvHUFvrm
         EM0q1rQ/ujqHJgOjkANltoYWs2XH0O8GvdLw80aQ1AXuFtSaWGKzhihWQZ6GnLRgvQd7
         OEBQnOwjt9WtiC2W/PP84Hq6n7wo9mvcmefTmDroWs5k2UsqkgXvHMaiSNlyYkROoGyO
         VDhjp3cro8APqrvlo0nnVmWWSG7cH+EcW95TAirghjRhBW4WDwkxiZaovS7TOw9EeeIk
         c6OA==
X-Gm-Message-State: AOJu0YymzLjXo3Ak5biM7HdL/sFZ8+mcOeXb21B+nqsUqbDJ3E2r6wVu
        mw7q7h502Eo+xX2jWdSKn+Z1vVfj3srMPv3lQM2VkA==
X-Google-Smtp-Source: AGHT+IE9cNxYcnE+sNDcjWkiOsU52/mJjpudLz7kYq/Voq07K6+JEnzA+zqz02s367o6vNiTqYWr4E4Lc//Ttvw4Omw=
X-Received: by 2002:a19:7b12:0:b0:4f6:2b25:194e with SMTP id
 w18-20020a197b12000000b004f62b25194emr6213559lfc.58.1692746062347; Tue, 22
 Aug 2023 16:14:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Aug 2023 16:14:21 -0700
MIME-Version: 1.0
In-Reply-To: <20230822142644.v10.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
References: <20230822212927.249645-1-dianders@chromium.org> <20230822142644.v10.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Aug 2023 16:14:21 -0700
Message-ID: <CAE-0n53QBBfX77ibE+NdWZa70VVOKkNnhn5BNhBk04XKEFKNJw@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] arm64: idle: Tag the arm64 idle functions as __cpuidle
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Quoting Douglas Anderson (2023-08-22 14:26:57)
> As per the (somewhat recent) comment before the definition of
> `__cpuidle`, the tag is like `noinstr` but also marks a function so it
> can be identified by cpu_in_idle(). Let'a add this.

s/Let'a/Let's/

Maybe also define "this" to be "Let's add these markings to arm64
cpuidle functions".

>
> After doing this then when we dump stack traces of all processors
> using nmi_cpu_backtrace() then instead of getting useless backtraces
> we get things like:

Sorry, this sentence is really hard for me to read. Perhaps:

With this change we get useful backtraces like:

   NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98

instead of useless backtraces when dumping all processors using
nmi_cpu_backtrace().

>
>   NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98
>
> NOTE: this patch won't make cpu_in_idle() work perfectly for arm64,
> but it doesn't hurt and does catch some cases. Specifically an example
> that wasn't caught in my testing looked like this:

I wonder if it improves locality of cpu idle code as well by moving the
functions to the idle text section so any branch targets are closer.

>
>  gic_cpu_sys_reg_init+0x1f8/0x314
>  gic_cpu_pm_notifier+0x40/0x78
>  raw_notifier_call_chain+0x5c/0x134
>  cpu_pm_notify+0x38/0x64
>  cpu_pm_exit+0x20/0x2c
>  psci_enter_idle_state+0x48/0x70
>  cpuidle_enter_state+0xb8/0x260
>  cpuidle_enter+0x44/0x5c
>  do_idle+0x188/0x30c
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
