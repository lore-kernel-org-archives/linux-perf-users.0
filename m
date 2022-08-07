Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0394C19F2A
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Aug 2022 05:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiHGFtA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Aug 2022 01:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiHGFs7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Aug 2022 01:48:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA0BB1FF
        for <linux-perf-users@vger.kernel.org>; Sat,  6 Aug 2022 22:48:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o3so5976169ple.5
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Aug 2022 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZGw1PnHsXxrYwCyXKBLZGs4Yl0JJ1Too94jRTJKoa0=;
        b=k9ieTByRp257nB1pQB06VrPzSLeXQtwbFMtklYPxezobo1Fzoio1z4Zey8sfGgRNh+
         RADp322TENPrOh3/Q4k2X6EXQb4L6dLLQaNPN8Lc03Ong+0bWKvB02zW5TNiM3WJ8SpW
         eapJLPKPc2ab6wgblIY04RPHORohLCj3qS7pHUpija1zz6uXSOF35j2gVtaqDQXeLffj
         49maLAboTYsCRRCtj/9RpVHtWcT1F+hcYZmHYng5SZsQhZSP8dwhDo/oeNhd3saQmIVN
         2V1sKz89Qv9aFr0VSj26+AI/b6rPR3w5Asa/gWDk4XgaiDdWZkYdlTvXCngpzNjUvhQ5
         BZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KZGw1PnHsXxrYwCyXKBLZGs4Yl0JJ1Too94jRTJKoa0=;
        b=1X+fRuDYDPmnYTYSroR2FjGNqiWFGlEYCRbrS5EHUibUsSlto2OLK3cxTdN7rlbYtm
         yJUSgqQAinnY7hPjIFVYtV3aU+RFcEuEi8tWK6dAs0txe91m398qZJEgOaHj/LBMAtPM
         zLDWxl22DR6VqSKO7eUvznBXXGVGgkOY4XjqQ5wlCIhhAqoMNT24fVuqXWyJpR7eouka
         Nb8RtS3g6abPMrBQ6fS2gR7NkZ2ZOyZqQTUvMR4wUuPP3Jwb7TCTCUXriPbZ3Q5Zm6iV
         sCtmf0P/GgsM6qmmLBlQAU/hII7EIjk3/8KRBZJnHPdfBJPocXmV93em8xO+P/mg1qbh
         opAg==
X-Gm-Message-State: ACgBeo0KYSwWfP1MO5Gcv8I0dEpX8uTqJ2Eq8WGgjhh/Yxjwr1oJ37ym
        IwPs4mGak01aSzOIoZgSyOKaSA==
X-Google-Smtp-Source: AA6agR65OvLjWIiqwaCVUlT0OrSK6YQzHH7bKQz1av2dopEKBoPbdOgfedcQT/OlrFhLK8W6lw80Mw==
X-Received: by 2002:a17:90b:681:b0:1f2:147a:5e55 with SMTP id m1-20020a17090b068100b001f2147a5e55mr15175599pjz.159.1659851338432;
        Sat, 06 Aug 2022 22:48:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id ie9-20020a17090b400900b001f327021900sm5604846pjb.1.2022.08.06.22.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 22:48:58 -0700 (PDT)
Date:   Sun, 7 Aug 2022 13:48:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 13/14] perf test: Add git ignore for tmp and output
 files of CoreSight tests
Message-ID: <20220807054854.GK34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-14-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-14-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:55PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Ignore other output files of the new CoreSight tests so they don't
> fill git status with noise we don't need or want.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index faa23b5d32f5..a653311d9693 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -22,6 +22,7 @@ perf-archive
>  perf-iostat
>  tags
>  TAGS
> +stats-*.csv
>  cscope*
>  config.mak
>  config.mak.autogen
> @@ -29,6 +30,7 @@ config.mak.autogen
>  *-flex.*
>  *.pyc
>  *.pyo
> +*.stdout
>  .config-detected
>  util/intel-pt-decoder/inat-tables.c
>  arch/*/include/generated/
> -- 
> 2.32.0
> 
