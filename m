Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D75EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 05:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjGQF5V (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jul 2023 01:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjGQF5U (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jul 2023 01:57:20 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE14E4B
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Jul 2023 22:57:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6686708c986so4242285b3a.0
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Jul 2023 22:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689573438; x=1692165438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CXS3RmyWWgom91Sv94zX4MYmhnr9NNlrigD9YVxcfFM=;
        b=sZvISqmbQql4wFArhW21VXG+Bi/Vy9DGhpzrBp63sSEL99+PPbpIXs/OyTvyO4TBuJ
         0iVCkCXyKV5rl2GUv+rl6bkZ6kbKYYfa6o7hqbVnCe9ETWy4uFWAVxU+D/cJjmFHGggj
         2m8Fu20nIA4RyfQF+j96H4ZAF0iN+W8+xkSAOGGdadWEXI18nOIY16fiZWduC1RgqeiP
         AD9VrebJlqutkdcxwkmxPY94XP7B0tiwlVA2J+PstljZjj8DXp3/9CFatDi32VBTJjPn
         pl7fATHbtJXHo9N+CAxiv/vdnvGGMYmfNR4ZjGGkSUUMQdlo+HFWfRDS3NjozN3hzEzL
         ok9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689573438; x=1692165438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXS3RmyWWgom91Sv94zX4MYmhnr9NNlrigD9YVxcfFM=;
        b=MDpq88Vcy9ySiIF5JqfqvhAQgryc+L0wjc5QOAwm+1bawbDfvgziOj3ViLxlSLP37J
         +BqAFTYOIwn3iRTikFPvwEJw6xcl1HSU1kvk7Z926koILl1yLyKxFD5gCW4Xv8dlZ7PE
         4UcAk6i2cxiOnmvZBgDLOZxRoN/DwBh1x7YGaz4xF/7i8ioTy5Q+fL6XQcs4SW5AxzPn
         mNQqT8X38IOvCtQBusk6CGQGlQN7RiTDZ7899rtZ4nUhdqUkLYzuZ23MGCLIuBbPvNcx
         jpUzYnUpo6pz3Y77qib9qsLmDiAm8EIKnel0dxuBZjVXX7dOXAtJAOaYBng8me12H1lT
         dsJQ==
X-Gm-Message-State: ABy/qLaQJntorZoKozGi4Hh4zSLVQqto0CsVhaqkuifM79M27sFysng4
        C/Ads65TnuJesdNs4rqs77jm5w==
X-Google-Smtp-Source: APBJJlG+GLmJb3DLkjsbWz43FlHVnd5GUILcKO5yeyWHw3ZgYrW10GmfTKaol8vq4/cXNw4zfl1n9g==
X-Received: by 2002:a05:6a00:240f:b0:64c:4f2f:a235 with SMTP id z15-20020a056a00240f00b0064c4f2fa235mr13669845pfh.30.1689573438187;
        Sun, 16 Jul 2023 22:57:18 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b00678afd48250sm10968865pfi.218.2023.07.16.22.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 22:57:17 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:57:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        =?utf-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Some questions about using the perf tool in ARM-SPE
Message-ID: <20230717055713.GA79840@leoy-huanghe.lan>
References: <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
 <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan>
 <cf180f9a-085b-ad9b-c477-f02d32559c0a@arm.com>
 <f811f7ce-bf04-b5af-ee33-ea489927649f@arm.com>
 <20230703093913.GA904662@leoy-huanghe>
 <87b24c93-c457-6cec-736f-ab976ee1d608@arm.com>
 <20230703102032.GB904662@leoy-huanghe>
 <0ed20560-a880-9790-a7b2-5089c091fdae@arm.com>
 <CAM9d7chz+7szVG8-XWrFGyiCPXFRc2zfq8s7VqMcqx3J7QCeyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chz+7szVG8-XWrFGyiCPXFRc2zfq8s7VqMcqx3J7QCeyQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Suzuki,

On Wed, Jul 05, 2023 at 10:33:18AM -0700, Namhyung Kim wrote:
> On Mon, Jul 3, 2023 at 6:33 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> > On 03/07/2023 11:20, Leo Yan wrote:
> > > On Mon, Jul 03, 2023 at 10:42:21AM +0100, James Clark wrote:

[...]

> > Do we somehow sync (copy) the cputype.h for perf tool ? Or do we keep
> > them in sync with a patch ?
> >
> > If it is the former, I wouldn't bother about updating the kernel
> > headers.
> 
> In general, perf tool has a copy of kernel headers and there's a script
> called check-headers.sh to verify they are in sync.  We don't
> recommend kernel patches to touch the tool's copy.  And it's done
> by tool devs separately.

We have the kernel header arch/arm64/include/asm/cputype.h, tools have a
copy which is placed in tools/arch/arm64/include/asm/cputype.h.

As Namhyung explained, usually the kernel header is firstly changed and
then the tool developers send a separate patch to sync with kernel
header.  You could see a recent example by Arnaldo's patch [1].

By following this working model, I sent patch series to add Cortex-X4
CPU part and MIDR definitions.  I personally think this is the best
way for us to keep the alignment between the kernel header and tools
header [2].  Please let me know if this doable or not?

Sorry for late response due to vacation :)

Thanks,
Leo

[1] https://lore.kernel.org/lkml/ZLFQ%2Ftu%2FATQwDEIW@kernel.org/
[2] https://lore.kernel.org/lkml/20230717054327.79815-1-leo.yan@linaro.org/
