Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD4C001DB
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Aug 2023 15:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjHGPYy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjHGPYu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2023 11:24:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E520210DE
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Aug 2023 08:24:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso40019085e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Aug 2023 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691421887; x=1692026687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RM6FEX0hkfSucEN2RNtPwB4Lp3pZ1/g2aHa0yo5DkxA=;
        b=YBfAYrox4WwNmSljlKByV5/fpIap2pKUoRw5AygT2uJb2iRFmdXouQKc9P8DlghNBn
         mD9d5xOsnCzGOCCwXphMo4cvJTfBp37FlIxYd5iaS6JX3YNY8Twb6NyyioxxNZ15/yMp
         OSRbBgvU2b1TwsfAaUxBxc0GDJJVxRUZBJGGmT1PN5bkFh/gdOovIuFoP+21R5ocXzBg
         08QaWeNi1GpA9zhcYxWWOxOey3tkERo9fB23ax/OV6UI6IthFUHlfSILQ/SAuJhjxObI
         fj2F3r7m3cuIP6OxAgL66LQ1cbbrbBujYRezedh9b96POwP/ifMXwFnGRbeU4lgxz2j5
         2RGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691421887; x=1692026687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM6FEX0hkfSucEN2RNtPwB4Lp3pZ1/g2aHa0yo5DkxA=;
        b=eAZAnc0AnUVDkq31mOTRUrHr4hqOlCL+23+6rVZ+IboavFbQ7CewDcK8xVcAwRkW5k
         /tuF1FmgZAI27f7HWc8a3FFZnSziOW2HR+E1JliecUqs+/fblvnV6X0iXX5tYyNYhvZl
         lSHZ44G3ffa8XnDk6pjsBYk2MCSJL0VpDE1BGO/qPq70j3apK7INHTfKrgD883b0NZSC
         Ir9gBdtGInYs8a03+719xVA4U++YgpL4oFJ30KRvq2YLSyL7SXK3Szv20IylLoQLIGN8
         I8HTbE8pOwYpmdM903tWivJQJ0LyFQEvfkt1syRcpq5t6jiK3GF6uQvetzPQG8Fvo8zX
         Z9YA==
X-Gm-Message-State: AOJu0YwRYsAmNHYcjremVYg1y/1/eqm9kSwn6cFSJbtO5nl68Wh7NCta
        0/1ym5d3vTR0rgdgOsHZQeuH0g==
X-Google-Smtp-Source: AGHT+IGBcN8x+jcr5Z6fXcbJpNL+hygXsHQl0A6iUvy8eoqLQSJBGrRviYCA1pNQ7vzL2NtQD5wOPw==
X-Received: by 2002:a05:600c:2210:b0:3fb:a62d:1992 with SMTP id z16-20020a05600c221000b003fba62d1992mr6230198wml.0.1691421887335;
        Mon, 07 Aug 2023 08:24:47 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c248400b003fbb5506e54sm11026994wms.29.2023.08.07.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 08:24:46 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:24:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/7] arm64: kgdb: Roundup cpus using the debug IPI
Message-ID: <20230807152444.GA375529@aspen.lan>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.7.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
 <ZNDHZLGds0DTN6zg@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNDHZLGds0DTN6zg@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 07, 2023 at 11:28:52AM +0100, Mark Rutland wrote:
> On Thu, Jun 01, 2023 at 02:31:51PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > Let's use the debug IPI for rounding up CPUs in kgdb. When the debug
> > IPI is backed by an NMI (or pseudo NMI) then this will let us debug
> > even hard locked CPUs. When the debug IPI isn't backed by an NMI then
> > this won't really have any huge benefit but it will still work.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v9:
> > - Remove fallback for when debug IPI isn't available.
> > - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> >
> >  arch/arm64/kernel/ipi_debug.c |  5 +++++
> >  arch/arm64/kernel/kgdb.c      | 14 ++++++++++++++
> >  2 files changed, 19 insertions(+)
>
> This looks fine to me, but I'd feel a bit happier if we had separate SGIs for
> the backtrace and the KGDB callback as they're logically unrelated.

I've no objections to seperate SGIs (if one can be found) but I'm curious
what benefit emerges from giving them seperate IPIs.

Both interfaces are already designed to share and NMI-like IPI nicely
(and IIUC they must share one on x86), neither is performance
critical[1] and the content of /proc/interrupts for the IPI is seldom
going to be of much interest.

As mentioned it is perfectly OK to separate them if there is space in
the SGI allocations. However if any two functions are good candidates to
share a scarce resource such as an SGI then it is these!


Daniel.


[1] In both cases their results are only required at human-scale
    and the work of the both handlers is hugely more expensive than
    either up front quick-check.
