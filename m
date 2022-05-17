Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8110DC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 10:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiEQKwC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 06:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbiEQKu4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 06:50:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318D436322
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 03:50:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso2036063pjj.4
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vVR6zNLI+c0k/X+csgUVN8nm7PvvodORekMaxXxc1M0=;
        b=P2qf7Qtgz9XAg7exjMtb8+M9Sz0eO/t+AfddkwEFhWXoNRj99c1cdjLjuh/0JEsXQQ
         dEsp4+DhbXW+qtdL1mcwW46guWWKLsujaG/UKrR1X03zrXbgN4RrR2vU+qzqQEJ59fQi
         s5vtF0YquujenckSNVmVwq36pv5QhYE5WUXR7LUOLCf8UpFsjf8nzHdAp/1BCCVygnqH
         IuoHakDVI4ykqxHBI9Fgp927b+FWf9Rfxjlnfz1ktQh+G+mkGGV9acXsQK8qXcDZBb3j
         LY1JeU3X2Ixd2FUjs7iER8Xag1kDOEv6loGhpWZNd2YECqd2RE39jSBpEiCs4GBe0pFB
         DSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vVR6zNLI+c0k/X+csgUVN8nm7PvvodORekMaxXxc1M0=;
        b=2IVdwinACNllMqUTxhSav/Ck+N1Rlnvm2m3OW+8hhmSH2kE0snrp0beDEXJzRvJV/4
         tgTThVOfoAECqZrOaK26BcODEdT7tQQlbrTbflIUoPQ44cr9Wy0cnc3St/0pHqRcwrHL
         sfOm04h6XBGlGPeLGsWdUKKsqaxB78EEeeUBSo4wP/G4J5ljALni13myF78Oi55bU2H2
         yBIUSFrNoxlHjYq0e/xU94QgNN0lolS2xIqDQpfeo4Jee+D3q8zNs8JgqPnMtZRRoRVR
         cQ/OyNz/exUjPMCLsh83nlWsjHKVsDyENfeiAm6zqo/vquZZ2k96BeqFCmXV/W3yi+Qu
         Mz2A==
X-Gm-Message-State: AOAM530yF/8Y7qyDKqECFzma98TWPyeU0IIBMSnpWzyG8t3VX+AXJs7t
        kmseEqiq6rAtJyZr/gZyV8F5H2W1IC80VZZ3iT4=
X-Google-Smtp-Source: ABdhPJzJrylNLgqRP10b0FK8mEviLe31EBXM9tkz9+Fpl4VtpNbhDD1nImE+3rO4hV1KxBwVXYjkqw==
X-Received: by 2002:a17:902:c7cd:b0:161:8b6f:73c3 with SMTP id r13-20020a170902c7cd00b001618b6f73c3mr7000127pla.156.1652784653611;
        Tue, 17 May 2022 03:50:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a858600b001df47e47d41sm1336540pjn.36.2022.05.17.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:50:53 -0700 (PDT)
Date:   Tue, 17 May 2022 18:50:45 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, german.gomez@arm.com,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] perf tools: arm64: Copy perf_regs.h from the
 kernel
Message-ID: <20220517105045.GB153558@leoy-ThinkPad-X240s>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517102005.3022017-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 17, 2022 at 11:20:02AM +0100, James Clark wrote:
> Get the updated header for the newly added VG register.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/arch/arm64/include/uapi/asm/perf_regs.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> index d54daafa89e3..fd157f46727e 100644
> --- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
> +++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> @@ -36,6 +36,11 @@ enum perf_event_arm_regs {
>  	PERF_REG_ARM64_LR,
>  	PERF_REG_ARM64_SP,
>  	PERF_REG_ARM64_PC,
> -	PERF_REG_ARM64_MAX,
> +
> +	/* Extended/pseudo registers */
> +	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
> +
> +	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
> +	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1
>  };
>  #endif /* _ASM_ARM64_PERF_REGS_H */
> -- 
> 2.28.0
> 
