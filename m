Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57925C3DA66
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 11:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjHYLVc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243324AbjHYLV0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 07:21:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27E1FEC
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 04:20:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40061928e5aso7186555e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962456; x=1693567256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyVYlwAqgLBhb9pjXnI3VdwK+OmQBeJAxGPkhMUt9do=;
        b=xAzctQaaqWDUp/VW4HIk1k0poq1PDBIxGK49RQY+IOkgmWhyxP/3Fpv6X4Ed8tn0C3
         t3+z5TVE9tiAQrQizBbkKgl5VOqge1qy4fJoeNG5wgqLaqxnRw3HxTDjDdOm3BaAbQ7L
         AdjTRBhbhStpyO5ZGkItbyeYzTQDWtJRkKATLP7jpieaNTREt87LSCHGaJ8PB3k90KSX
         RKUPzY7pYeVDIBTVoMIOAiak5S1uTsPGZc9yh6GhzW/F2ied97mVGIRP36cpImKhHrvz
         AwC/uVS3HSCnl8TJIx2vz+yZYvhmYXTPL8yUT7P4/JO28ixTpWtg0j8LgjG07QsFDid5
         JmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962456; x=1693567256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyVYlwAqgLBhb9pjXnI3VdwK+OmQBeJAxGPkhMUt9do=;
        b=dEPf+o9Ve6oL7RIRxqcWfnQwncdGUYETlqkzQ6jE3N4qBVGTz8cVadF6OuzX9GEhjk
         EswEsKLmcGCL5vtD2hjdW92ksCk6DpZUcb4RBpvmgGPno73TOzDmH8zzMRyeoSZTgH2B
         Ss8YNRFaYS2s5ozTqwICP84iwd8E2/BMwIYNHWRg2YGuZiQbMq8eePveO2Ltt5A8J4Fz
         +CIvJqTogEoEyUi+T0DbdYIlKjLDTHr6HtYcpHHWBGESeFE48Ez3XUakq0iU17hO0Ygj
         z80HCdlprOgPhyq2rdtn1QQvXSMDrC366YyfH+bvJx+NopxJSnUz/513gd1niLkRBxAy
         OmhA==
X-Gm-Message-State: AOJu0YwrRJHtWPOGT+jDZZzpwyIzJ5bsuRXITvmfrLJ+ZvqNCiFUUjsJ
        BraLaqCa42kg11P0uueysPkbUQ==
X-Google-Smtp-Source: AGHT+IF4F+IhpNhFa0LEait9G/lVg93DLllxE8WUtCFepSGG51mVVPFuUrfL9VTKvfSysAM94nTvWw==
X-Received: by 2002:adf:fd4e:0:b0:313:ef08:c83b with SMTP id h14-20020adffd4e000000b00313ef08c83bmr12573907wrs.56.1692962455985;
        Fri, 25 Aug 2023 04:20:55 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d67cc000000b00317afc7949csm1950082wrw.50.2023.08.25.04.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:20:55 -0700 (PDT)
Date:   Fri, 25 Aug 2023 12:20:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 6/6] arm64: kgdb: Implement kgdb_roundup_cpus() to
 enable pseudo-NMI roundup
Message-ID: <20230825112053.GE270740@aspen.lan>
References: <20230824153233.1006420-1-dianders@chromium.org>
 <20230824083012.v11.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824083012.v11.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 24, 2023 at 08:30:32AM -0700, Douglas Anderson wrote:
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

From a kgdb point of view:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
