Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFF0C001DB
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Aug 2023 15:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjHHP63 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjHHP5B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Aug 2023 11:57:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0693A5BAD
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Aug 2023 08:43:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so49052985e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Aug 2023 08:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509425; x=1692114225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uf6Qwp5IcBfnw8cvFBZLBD+6OL+Kh6Nn1R+GOEG85Xs=;
        b=kPP3w8S/eKjWGKiUHi4oWYPKxRc0SaRoRJGIgBX5ZpHZ9aE3FjBH6QUjhdhrowiBjw
         UFgF6+86GWc/XTTCiR9u1GNmuBWBvHthKtcQ+l84YC7lhUA+M7qSiiGrhBFIZ1V0aFkt
         hmaqDk9oG4H9X5/sRcUaXgs/DF0S/ubI4ntMniaV6OrCwIyStSYMolNMXvsEy8Q/7DVg
         GCD4Ue7acAm/cQaLaTqSUluRYkCxfdEMTpx87i80izNukJ086Vn081SZOzOQ5tueKSJc
         YKi57gm/KuGtv1W8nI0VppijltfVpeDcNbrmvtJGVOFRNGaNET4kCe6dIAUmSMDwjFBf
         ypEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509425; x=1692114225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf6Qwp5IcBfnw8cvFBZLBD+6OL+Kh6Nn1R+GOEG85Xs=;
        b=jhBSSwjh0odEX8JYdNAdqMs5HxzBLu9ZcI3K7W9VM8ZaAunAK9pbJ625zIojOmubcJ
         CmD/BJjSEa73Nz2S9c1Jh7vAaswj+gGyhzs4TJYS9H0O25WUkJPSowWgIWWCKMM0oVcK
         BbFwWAYS9QoO4edxcath6nCVg5VTrNLB5F0SezfZgsACaKEgzKpyxVCZ+z+iU0NzEIaK
         mVdGGeGEp+ravJb9Gv119BRT1mDYUTl5Oyfb30PY4WA4bmTe9LIfnfzs4LwdVP6t4ATB
         Kw5U/EJvWYhZtWDXieQWqBHR1+x5iE1i3z50zaEEfY5Q8GVGg41M+XE7wXQytlbx5iHs
         0A6A==
X-Gm-Message-State: AOJu0Yy0eR0YZwjql2Tf1u3VfC/SegN8s256YDLOqazf3mOLvaoYuQDN
        ANjUJ5SYKcjpHL0LMfk5RBOTkR0QbBIDAksdzNsv6w==
X-Google-Smtp-Source: AGHT+IEoY3AsYBoeqi4l/r6UwxzB9eht2nw5J7VW0R/XG0aViKCtpjVte+QLSioXOu6hnHCUhQPKuQ==
X-Received: by 2002:a2e:3004:0:b0:2b4:6d59:7863 with SMTP id w4-20020a2e3004000000b002b46d597863mr8284441ljw.25.1691493425593;
        Tue, 08 Aug 2023 04:17:05 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003fa98908014sm17836323wmq.8.2023.08.08.04.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:17:05 -0700 (PDT)
Date:   Tue, 8 Aug 2023 12:17:03 +0100
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
Message-ID: <20230808111703.GB411689@aspen.lan>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.7.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
 <ZNDHZLGds0DTN6zg@FVFF77S0Q05N.cambridge.arm.com>
 <20230807152444.GA375529@aspen.lan>
 <ZNEV_mz4VU1HyBc9@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEV_mz4VU1HyBc9@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 07, 2023 at 05:04:14PM +0100, Mark Rutland wrote:
> On Mon, Aug 07, 2023 at 04:24:44PM +0100, Daniel Thompson wrote:
> > On Mon, Aug 07, 2023 at 11:28:52AM +0100, Mark Rutland wrote:
> > > On Thu, Jun 01, 2023 at 02:31:51PM -0700, Douglas Anderson wrote:
> > > > From: Sumit Garg <sumit.garg@linaro.org>
> > > >
> > > > Let's use the debug IPI for rounding up CPUs in kgdb. When the debug
> > > > IPI is backed by an NMI (or pseudo NMI) then this will let us debug
> > > > even hard locked CPUs. When the debug IPI isn't backed by an NMI then
> > > > this won't really have any huge benefit but it will still work.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > > Changes in v9:
> > > > - Remove fallback for when debug IPI isn't available.
> > > > - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> > > >
> > > >  arch/arm64/kernel/ipi_debug.c |  5 +++++
> > > >  arch/arm64/kernel/kgdb.c      | 14 ++++++++++++++
> > > >  2 files changed, 19 insertions(+)
> > >
> > > This looks fine to me, but I'd feel a bit happier if we had separate SGIs for
> > > the backtrace and the KGDB callback as they're logically unrelated.
> >
> > I've no objections to seperate SGIs (if one can be found) but I'm curious
> > what benefit emerges from giving them seperate IPIs.
>
> Mostly an "I'd feel happier"; they're logically unrelated and having them
> separate avoids the risk of them unintentionally getting in the way of the
> other.
>
> > Both interfaces are already designed to share and NMI-like IPI nicely
> > (and IIUC they must share one on x86), neither is performance
> > critical[1] and the content of /proc/interrupts for the IPI is seldom
> > going to be of much interest.
>
> Sure; I understand that. The flip side of "neither is performance critical" is
> that they're seldom tested in terms of interaction with one another, and hence
> for robustness I'd prefer they're separate.

We can't really stop them interacting when kdb is enabled: both activate
special logic to intercept console messages and this is much more
complex than the "is this my IPI?" tests.


> I agree it's not strictly necessary, but given we can easily free up an SGI
> slot, I think it'd be worthwhile. We can always decide to fold them together in
> future if we have to.

Agreed.

It should be very little bother to "reclaim" an IPI from the diagnostics
machinery if that is ever needed. So seperate IPIs is no problem from my
point of view.


Daniel.
