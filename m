Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAEAEE49B6
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 22:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjHYWRR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 18:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjHYWRK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 18:17:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67426AF
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 15:17:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so2154432e87.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693001826; x=1693606626;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrlOotjavXB0JqE55pt9ehBxyPFQpiJrYDjXTIglhZ0=;
        b=Ym/itz7Gtk0QnmD2HxbKyjjDXZ1SPqzcCAIeQ27erNIraYMX9ABmsl6JM6oJo+MJcQ
         G5G4uXwpd5tjwcovfCHznTiZVpuXrSW/zUC3VNNxCI3+X0gfsoiilxOuuR7V/ggNsj5W
         yQa84nEF7h2FarP7X0vagsDa39Fx68fLNueTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001826; x=1693606626;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrlOotjavXB0JqE55pt9ehBxyPFQpiJrYDjXTIglhZ0=;
        b=kLXF+cONyLXTBBMzPphEUUeIg04qRlbodTH8rzA2CA1vAB2OPIyFqbxX9PeardVEg8
         exGvjRidygIUxaaDTDta62DqSfTSuKdDUXTwNONGnV0MjjzKvNNp+G5yPCFPcQVeEFUe
         5Rkp6aGKpV2xJoYWquKK0DhOGqyY9ceyPtFvJu8bHHX20BQxZINx4+02f+nmo/FQnaUZ
         rerGu3Y3GVpifL6X0Qz0smr9xGXkdZ6XRGwn6nmVMqWNFJKxUPmUZg0EO8MaAyohE6RO
         fLzrZwP9KRPI89T9lLRm7/2JfkDEEx0rVG0DD5zODLzeBwUy3JuOnjC48bWe+IqmBavU
         41/A==
X-Gm-Message-State: AOJu0YwWhQafFvkqRkleKBzQ+YzaLJoCuC4RLbSeEy6sN0wmwqtkvkxB
        MRBv/Kp9zoGFmT++kzz11Sm1NH7it1wGzMkGmmFWbA==
X-Google-Smtp-Source: AGHT+IFKi/FjhPlAtZuPfnduFO2X83UaOHf4igEYpqi6QoVsmqz2ZB7PjG3rx+zsaSbxAb1kDqzEuOme7CDM83+kHIs=
X-Received: by 2002:a05:6512:a86:b0:4f8:64f5:f591 with SMTP id
 m6-20020a0565120a8600b004f864f5f591mr14490218lfu.12.1693001826529; Fri, 25
 Aug 2023 15:17:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Aug 2023 17:17:06 -0500
MIME-Version: 1.0
In-Reply-To: <20230824083012.v11.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Aug 2023 17:17:06 -0500
Message-ID: <CAE-0n51KWPN3bTSuVTTCxoULs_86A2WVm66FQ3jf+dztDU4G9g@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] arm64: smp: Remove dedicated wakeup IPI
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
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Quoting Douglas Anderson (2023-08-24 08:30:29)
> From: Mark Rutland <mark.rutland@arm.com>
>
> To enable NMI backtrace and KGDB's NMI cpu roundup, we need to free up
> at least one dedicated IPI.
>
> On arm64 the IPI_WAKEUP IPI is only used for the ACPI parking protocol,
> which itself is only used on some very early ARMv8 systems which
> couldn't implement PSCI.
>
> Remove the IPI_WAKEUP IPI, and rely on the IPI_RESCHEDULE IPI to wake
> CPUs from the parked state. This will cause a tiny amonut of redundant
> work to check the thread flags, but this is miniscule in relation to the
> cost of taking and handling the IPI in the first place. We can safely
> handle redundant IPI_RESCHEDULE IPIs, so there should be no functional
> impact as a result of this change.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
