Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40A7CCA473
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Jun 2022 02:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350034AbiFDCHc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350001AbiFDCHa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Jun 2022 22:07:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64AF313AF
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 19:07:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a10so8572712pju.3
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 19:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ff/IhfCPH41H+OZSAXWB83B0oZdz+7dYMwu9KM64DQw=;
        b=ceZCdMwmQ+8G45eBMa/Yfy/rn6hFeHi7miTK9GBzQM0Na2P3sRiZNS33cnb4VAtjzP
         xIpg/TbOxpvQU/7irs6zU/aADpLUMdiGcQuFjUY0HLgYoj7I+paYvpkMvb7JSG3i2WpV
         RB8AiOpYfqRJRSM4j0uvO4NbwE9/vuMq0OlCVqFoOQHHwqw4R9zb8HRu2UuGSjQZsrn5
         0EEgLpQGwmi/WtYD9zaJaTOKpJs2zCUM8plapvqlq9jp9BW/VOdPPOytPkt47MuYdQMS
         UFeOSwXlBTOJgPu/GNZtGFNvWsU8Iqyc0140qnFy6XAmSJh4ocbn1O4jSoIEvdIQ8n1u
         5jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ff/IhfCPH41H+OZSAXWB83B0oZdz+7dYMwu9KM64DQw=;
        b=X3zF9zjCTozhPM0H4tZ++aDauDMM+/d2ReWcmcI++N6FgzMb7i1SlVYuCG6sAEZxY+
         aha8xK3wbF/oSfmewf8HCkrUIbGVvoQMMGqi2Omy/wko4BOKiLZxWm+BCNZKyM+XD46U
         AoQw1KbDuZzMLwk1e/pM/5bf1SsueD7vFBeFlYv9sEuMRkwb3IfEVsb70exh+wE32rPc
         kLWxUrcQkOIWOBvdfxHdRbzyiG2xiI7JuENPetlWqgCTDeDukdut6u6vz8Q2OFv5z3kT
         xyzFlOytKagfFeGfqwL4rbWP06e5F30kw5ARcxPxiw/m+aFBGZ5By4Ov3AjWrOwOU/E4
         yCCg==
X-Gm-Message-State: AOAM530Os63Y7FtvIibveEEj09opS+d8oO60zpYoAxYvo0V7BE8YPPNe
        6o81gUrgrUbMLDLCtiTUQE7sKw==
X-Google-Smtp-Source: ABdhPJyciJHiB4w7inpufhaHNS4EDndG3bC1pR3Eg/dKEgOX/M3M4LpojRWlNirzvjbZq8/I9eLCCA==
X-Received: by 2002:a17:90b:4c8c:b0:1e8:5607:7ec0 with SMTP id my12-20020a17090b4c8c00b001e856077ec0mr523504pjb.36.1654308449330;
        Fri, 03 Jun 2022 19:07:29 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b00163fd24ca8csm6079468ple.119.2022.06.03.19.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 19:07:28 -0700 (PDT)
Date:   Sat, 4 Jun 2022 10:07:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        acme@kernel.org, german.gomez@arm.com, mathieu.poirier@linaro.org,
        john.garry@huawei.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf: arm64: Kernel support for Dwarf unwinding
 through SVE functions
Message-ID: <20220604020721.GB53464@leoy-ThinkPad-X240s>
References: <20220517100743.3020667-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517100743.3020667-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 17, 2022 at 11:07:41AM +0100, James Clark wrote:
> Changes since v1:
> 
>   * Add Mark's review tag
>   * Clarify in docs that it's the SVE register length
>   * Split patchset into kernel side and Perf tool changes
> 
> When SVE registers are pushed onto the stack the VG register is required to
> unwind because the stack offsets would vary by the SVE register width at the
> time when the sample was taken.
> 
> These first two patches add support for sampling the VG register to the kernel
> and the docs. There is another patchset to add support to userspace perf.

Hi Catalin, Will,

Since James is on vacation, just want to ping if you could pick up
this two patches?  Mark.B has given review tags for this patch set.

I did this is because there has another patch set in perf tool to
enable SVE registsers [1], which is dependent on this patch set's
merging.

Thanks,
Leo

[1] https://lore.kernel.org/lkml/20220525154114.718321-1-james.clark@arm.com/
