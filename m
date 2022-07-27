Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0823C04A68
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Jul 2022 07:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiG0HZd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Jul 2022 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiG0HZc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Jul 2022 03:25:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF93E75E
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 00:25:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id os14so30024626ejb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rydDqlFJvbn5JuZDSQ+fXBnsGfZJlblYwnY24ftaijo=;
        b=E+qTzrBWSrgHjQRguRQQdvlNKWssv6zsmDgh33eijxuIPtJRHibCfgdaeFR71FqghW
         38YRPWmQ4EjiiKd+dbY4W5rNW52QKyxNv227fhUNR8AaPik/PUfwVwivkKPKG8rgrYrL
         Xv20fgwOtbto9sx7cnvnFC/yHAgLvlvkbELc4gajxdtqHPCaajA/MxpiaMR5iB0cUAgb
         q9dsM/bIs13WbIEEQiO1a73RC7mBL69301FVhw03jFILZKYXMpL2J/OsBZsyYe6xSbut
         qu8LtSqWNcDaRuEDyT+Y9+H5V+b5UGOXEqk7107xwG8uymYj+8GaNFIM5XCyW+7p3vkk
         maog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rydDqlFJvbn5JuZDSQ+fXBnsGfZJlblYwnY24ftaijo=;
        b=VfFWpTjWLrTGnzUGi7kzyE7tOfft/IAK+R/Wc0TQdVTLkm/Z8pT/tvbUtIsNXj4om5
         ijS5wqM/tIk2aktmmXe3rCT1zNJGN8AguIHCfxykfMnWs0AZRAw9q1Rfuwqba51gRs6G
         GCrO8lmhNvGT3c2y/hZVP9LPVt8vyhyf32k3YcVsElWTxRPcZWFH7oKeUDAPakE2YPK6
         qfycmIpLTbFsCucLNFuod5KSGgpjH/R7Yu0r8dXMG1U65IhmF5qEzsltyokf/mPxRUyU
         rvhVpQOTwsqxTOcydsLoB8uw9M36wSe6Nf16Yfpb8JrB5c/OTyd4vSvsN5Yia8S1s3bc
         dlGg==
X-Gm-Message-State: AJIora/Uc18OYoLkS+D7R8xyQfNbZWi4BBI04pdlfYDA9VJ3rXpZNMu8
        26+v3itnTqetTHonb9buKkuSqe3Vcp4al/OGDSNO/Q==
X-Google-Smtp-Source: AGRyM1vxmco3aYUjfYxZjr+kwVOiRBIVmMeZhZUY4wsw3ERIYrSEPbtpbvKETSkTS/aUQ66bA/Tt85bh1Np0KmYc9oc=
X-Received: by 2002:a17:906:2ed7:b0:72f:d080:411 with SMTP id
 s23-20020a1709062ed700b0072fd0800411mr12069816eji.203.1658906729603; Wed, 27
 Jul 2022 00:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220727040022.139387-1-lihuafei1@huawei.com> <20220727040022.139387-5-lihuafei1@huawei.com>
In-Reply-To: <20220727040022.139387-5-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Jul 2022 09:25:18 +0200
Message-ID: <CACRpkdbu8M84s2rPsKTwMmMXeeYEmNVaXFnp1hsKM0Dc9jzNfw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 27, 2022 at 6:03 AM Li Huafei <lihuafei1@huawei.com> wrote:

> Historically architectures have had duplicated code in their stack trace
> implementations for filtering what gets traced. In order to avoid this
> duplication some generic code has been provided using a new interface
> arch_stack_walk(), enabled by selecting ARCH_STACKWALK in Kconfig, which
> factors all this out into the generic stack trace code. Convert ARM to
> use this common infrastructure.
>
> When initializing the stack frame of the current task, arm64 uses
> __builtin_frame_address(1) to initialize the frame pointer, skipping
> arch_stack_walk(), see the commit c607ab4f916d ("arm64: stacktrace:
> don't trace arch_ stack_walk()"). Since __builtin_frame_address(1) does
> not work on ARM, unwind_frame() is used to unwind the stack one layer
> forward before calling walk_stackframe().
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
