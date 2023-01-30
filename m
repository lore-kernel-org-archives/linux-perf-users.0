Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A05C05027
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Jan 2023 02:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjA3COB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 29 Jan 2023 21:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjA3COA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 29 Jan 2023 21:14:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE312593
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Jan 2023 18:13:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so14030593pjq.0
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Jan 2023 18:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd9O/tR7VekNHZVuIxvEglh3Auv4HgbQ30VX5q49uEs=;
        b=d/ceRODYDTq6388o2Sj48+kUXOFYULwGnarz33zqwylf/zJkz0Bge4T7BLscO506ai
         jLUbnxaUH71+oPw308UmtNlkQTqzaDudjlP58CDyjEmXnX/6oMQfZJu5nWFNbUuNJJu2
         Sqn9oSKGDSyKZ9lyLpy7yz4uf4tWJWdUufX2sch4xsDg9qLw1lA9Dpk1qkv3Ldfw1/qN
         bInHry90CD0sWv9xg4ELRBAA7ZKIlwKBc3d4OHNwsGBlpTmVE1yodXWEdYMqdh488xlL
         kkNcmywNOklRxzmIM6YFR7FrBXJBzi0dz48n5X9SxqfjASHvrGnClC0xt5Pm5oyHC060
         fHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd9O/tR7VekNHZVuIxvEglh3Auv4HgbQ30VX5q49uEs=;
        b=3QWmK/IRuo3ZEl5u6d59uuOdbsXDxwawtwCG0fci9Edc6BNztrGOzo0BIwyH5JBXxq
         Etq/QFgnI9nbhpp1PQB33pk75oc2in3QpOq+IrGdfMHz/HB35PSI52zEPzxZ4D37jtiE
         SaVVJ65V20PRPUCuDSoEk6u4NvFAmN1CdKF/Ye9bg1mjxfJM2cGnrh6qveushJ14IUXO
         xdUrhALHO9Sj2RDprYofaxX7IFkzQyhyheM1oBTSnRy5HzPNiW2T0mEVyhcc5DoOB57e
         j5ZCnB2o2YwWvwhfO9Db1tV7hwR41kVTGpICfXXGYG/5ncr7ff6PTDQynsRPEx4OLnRa
         NqAg==
X-Gm-Message-State: AO0yUKXuT0VXInxWrSPtoCtsFzns76sTe0JOHbS7F03d6vbQO0ggs7CM
        51Mo0lqoN3FLOrpJiKC1OmmgsA==
X-Google-Smtp-Source: AK7set+SgtT6XMWy7cDFb1dkQK0NVFq/QUJ9BPIeOHt8108rRMeCoMgAdS2eyaIWzDM5ZebZnePAlw==
X-Received: by 2002:a17:903:1c7:b0:196:682a:b3db with SMTP id e7-20020a17090301c700b00196682ab3dbmr8566682plh.38.1675044838787;
        Sun, 29 Jan 2023 18:13:58 -0800 (PST)
Received: from leoy-yangtze.lan (211-23-48-221.hinet-ip.hinet.net. [211.23.48.221])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902b28b00b00177efb56475sm6513067plr.85.2023.01.29.18.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 18:13:58 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:13:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Only warn once for each unsupported
 address packet
Message-ID: <Y9cn4NYvI6+XW302@leoy-yangtze.lan>
References: <20230127205546.667740-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127205546.667740-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 27, 2023 at 02:55:46PM -0600, Rob Herring wrote:
> Unknown address packet indexes are not an error as the Arm architecture
> can (and has with SPEv1.2) define new ones and implementation defined
> ones are also allowed. The error message for every occurrence of the
> packet is needlessly noisy as well. Change the message to print just
> once for each unknown index.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 091987dd3966..40dcedfd75cd 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -68,7 +68,11 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
>  		/* Clean highest byte */
>  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  	} else {
> -		pr_err("unsupported address packet index: 0x%x\n", index);
> +		static u32 seen_idx = 0;
> +		if (!(seen_idx & BIT(index))) {
> +			seen_idx |= BIT(index);
> +			pr_warning("ignoring unsupported address packet index: 0x%x\n", index);
> +		}
>  	}
>  
>  	return payload;
> -- 
> 2.39.0
> 
