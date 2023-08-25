Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88293C83F04
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 22:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjHYW2c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 18:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjHYW21 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 18:28:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8662120
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 15:28:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ffa6e25ebbso2907068e87.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693002504; x=1693607304;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/6agghUlnzcFD5k9bdIOnu9jgMgVxK8eg7bQBbKSXA=;
        b=mItPAx/UGYcPcSxAVRQwnU5sZ+4qTl8el9xJ72Vsl3/8vqtU5cYlaaCsVsHNFnlmWT
         Aacfa3xGzdoA//R6GPCO5jTJ97DUV+6JBiaaMWbn2gKi8c7ukMjI3906eBVrlrzDaQYs
         txG+AaV0Hpsqt5sgQAT2z/Dz3uWfVnrX7UCUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693002504; x=1693607304;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/6agghUlnzcFD5k9bdIOnu9jgMgVxK8eg7bQBbKSXA=;
        b=B7J22Q5Wz8wAuoNkYZqZhEjtEV8KYhy02T6wdAap3hIxmlzyZaXe4ady+37Jy7+q1m
         UXuhFxp3dbjHxZ1UPD4J+I9382dzQmAXdnwOB7/uXdmlhSE8lUMIe/UjjmzsVMpOaZL+
         SJNb9flWdz/8Cx61ekpn30O5OMbOS3XeJJsfWcGecYLZ0qu4kBYWiNGjPmVU9ghVJ6NL
         Y7Eah1mykmJ0Pr7W1YAHiD6EVQNekfMNDd2u6P6QmaunB9BjgaQwiLvgDHFcPZJWML/6
         dOxm/1UYtXXmp5mPONqvasKXjYv0tVjDHJJEMD0SV9L7rgNOKL7uuH0q6mwefttyr582
         FxIA==
X-Gm-Message-State: AOJu0YwRmz3zfv5CBCYV2sh5nuEt5+NwofAHDZ73+Gn7+6QCH4J2ah3A
        Sz7fflP0UtLEAST5ssBEuK3U87aAfg63zqmKNod0ag==
X-Google-Smtp-Source: AGHT+IH4+ved9NrODcrL+cqJbDqjLcbW0OPzmoiiz6NJNlJxDjHXtWqNbZlF13w6x+zbyE8eQz2Y96JFLeuco6d5oUs=
X-Received: by 2002:a05:6512:2348:b0:500:8be5:1cb8 with SMTP id
 p8-20020a056512234800b005008be51cb8mr4417150lfu.30.1693002503728; Fri, 25 Aug
 2023 15:28:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Aug 2023 17:28:23 -0500
MIME-Version: 1.0
In-Reply-To: <20230824083012.v11.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Aug 2023 17:28:23 -0500
Message-ID: <CAE-0n50sODsofOC-5uhs_1E6aHyTmyK45nPUvFddq9N9jhqUXg@mail.gmail.com>
Subject: Re: [PATCH v11 6/6] arm64: kgdb: Implement kgdb_roundup_cpus() to
 enable pseudo-NMI roundup
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Quoting Douglas Anderson (2023-08-24 08:30:32)
> Up until now we've been using the generic (weak) implementation for
> kgdb_roundup_cpus() when using kgdb on arm64. Let's move to a custom
> one. The advantage here is that, when pseudo-NMI is enabled on a
> device, we'll be able to round up CPUs using pseudo-NMI. This allows
> us to debug CPUs that are stuck with interrupts disabled. If
> pseudo-NMIs are not enabled then we'll fallback to just using an IPI,
> which is still slightly better than the generic implementation since
> it avoids the potential situation described in the generic
> kgdb_call_nmi_hook().
>
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
