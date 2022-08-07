Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6ACC19F2A
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Aug 2022 04:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiHGEfP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Aug 2022 00:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGEfO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Aug 2022 00:35:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569271A3
        for <linux-perf-users@vger.kernel.org>; Sat,  6 Aug 2022 21:35:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso11659455pjf.5
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Aug 2022 21:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Stge8ij00ak/lu/+zv2sql6FgjCXn7x2g+8N+A6jXAo=;
        b=qvDhVQ6TJRd1C1ouWtzwzHxKSh90MkOwKvRqlZqFpgO0luBVQSus02sT1ws1F5oRy9
         OI9/yRPwsR6Lfawewc7s+apgHvD1wI7HsRBzouZBneXhRgZPWwRF1qL+f0Chpzf4d1nk
         pcepDErdQ4FdZy5qCGTEL1qxgUN8DGrT2CuThdDAUaQhAUkRyYsve8zqB1K6Jb/dUeqA
         3vKFSaYaBqDDWJBSIT0uYDDEVH8+1X/myWvDWz6PSIk6O0mPoz/kPBcnDFfMfqmQRuum
         SBsiSsTR4rS+LZu8W+fnw2X6LX0hteNJYM0Ln5khYgQFZZe6WdkjmRA/o/sCG2r4gDYE
         mgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Stge8ij00ak/lu/+zv2sql6FgjCXn7x2g+8N+A6jXAo=;
        b=zG74KcW4+2ftAVeABo6t/uGkr7pZaN7UvWJYZIcZ3V3VvSD+fYZEtlJA7LI+3GIx6T
         Uy0s0sU3lGDE54We6l5DgiJoptjCxEA1B5gXaxy5FFpWs5Ptj3J1FxxNe/lnjFN8vwXu
         +EjqSP59ltKAu2XqGBfPOtVjvVJsu4sfWiceKh2OSM9okF6Ku1k1NztawiWtIXfF5Wnv
         OGWcTzfAV5k2fDP8G9yWSoZvGjhYVJQ6zJDU46Iy7AFHZ1mAmltVZEEgFg3Vs2O1sBer
         gpBrGpFvnE+C5Byre0RkaGJyFsEGmAXyEK/nh/InCg31K3wc2Vct3fAkMInx4+w/CzC+
         nB1Q==
X-Gm-Message-State: ACgBeo1rvZAVqv8FWNcBcj4VTPJlbnpUZw/6ILgKkQhKMVu9hfQlD0aW
        L3c3CHvHJgT5pAG9fENhf6uZuqRBRu+bzbPsAq8=
X-Google-Smtp-Source: AA6agR6PvYHJPx63cx/TWBSIzUDKEHuEneqcgqwfRXdhc+m5SJaEhC7MNTdbMjOwgp5EGfmyVmS7JA==
X-Received: by 2002:a17:90a:9383:b0:1f4:fd59:7e47 with SMTP id q3-20020a17090a938300b001f4fd597e47mr15352310pjo.172.1659846912638;
        Sat, 06 Aug 2022 21:35:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id g14-20020aa79dce000000b0052d51acf115sm5894801pfq.157.2022.08.06.21.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:35:12 -0700 (PDT)
Date:   Sun, 7 Aug 2022 12:35:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 05/14] perf test: Add asm pureloop test shell script
Message-ID: <20220807043508.GD34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-6-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-6-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:47PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add a script to drive the asm pureloop test for arm64/CoreSight that
> gathers data so it passes a minimum bar for amount and quality of
> content that we extract from the kernel's perf support.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
