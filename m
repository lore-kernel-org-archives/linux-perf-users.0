Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B732C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 01:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiERBGs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 21:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiERBGr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 21:06:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699E036E19
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 18:06:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h24so723006pgh.12
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 18:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GbQqiHon5mXOJtQ7qDFO/1YT/pDph51vsh9Oavp7fmY=;
        b=inH5xjVG/jZfmds2/BFsMpqvlCQ8Sg2Wav2+94TRKdGaS4+3kKdtfIAB1q75ETZ/fJ
         ATNzYfeV9BvxkfK0CVOMcA4QwLQn671w4YX8oy12oUJRtw2hhKXt73nBYPlAuWq+OBXr
         DSTJaLBzVyiQZXJiLKDckGzb1EF8GM1e6FizTL+j71ddqjrGXCMuji4wriuKi3hKaBZB
         IEZbfFq8q76Z4cwA6B4v3WkisogPY84j/ZTbHKwZ/xyfu3CUgHp1RB8WlsV+KOpiJfLz
         DUJeLhTKdChApQqpbWmBwJnHLuLaqYFjHQqRn9xiA7ii6CvrzdVGskWF/L+bmEJD2e5Y
         1Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GbQqiHon5mXOJtQ7qDFO/1YT/pDph51vsh9Oavp7fmY=;
        b=QjelT1tMPqqRzz7KKAsFnhWO++uBc/s4uRmdp2Ea2RJ7Elr6hMsrwLPSxUofbSvPzZ
         eS4O3DDRAxh1RkB2vmIIJWQ4rAx1bAg+sFJs0MmUXRActKd6FyldY3KICTErolj2wOcv
         0mNmDBHRHjn2Xmcyylf9XD+l99lQYPh/p0Oke17129R+epyZD+Ic89RH0mdm3bfdvzzs
         bKb8awoWrpzcg596p8RIFX1960PNGHJ8M7k+CQFcG3F0djPmvo+Ec/lCcO+TvH0oDSi0
         JeKu5nW75D4dhnod6jM0sXFXPioqe8+HzOIFP1/rT437NoqoUO9lk5fLjr9Ksgzf5X89
         TKtQ==
X-Gm-Message-State: AOAM531P+LuP6jygyrpO5w8D79CRyIXKMMvuRcJBFUbUYavuLqXt7wzG
        qkjWLWAgU2MlvjLiNhWVtxGOkA==
X-Google-Smtp-Source: ABdhPJxHe6wTqA3Hd7+cLFPc0AM72PmGHVpv6W3BGxsjD2AA0peE3NA6rzS5zkdrIPuaWIMecvj0pg==
X-Received: by 2002:a63:455f:0:b0:3c6:401c:c884 with SMTP id u31-20020a63455f000000b003c6401cc884mr21023993pgk.28.1652836005799;
        Tue, 17 May 2022 18:06:45 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id 79-20020a630252000000b003c14af50605sm191559pgc.29.2022.05.17.18.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:06:45 -0700 (PDT)
Date:   Wed, 18 May 2022 09:06:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com,
        Jiri Olsa <jolsa@kernel.org>, kjain@linux.ibm.com,
        lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v8 0/4] perf: arm-spe: Decode SPE source and use for perf
 c2c
Message-ID: <20220518010623.GA402837@leoy-ThinkPad-X240s>
References: <20220517020326.18580-1-alisaidi@amazon.com>
 <YoQRg1r7HuwiO3bZ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoQRg1r7HuwiO3bZ@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Tue, May 17, 2022 at 06:20:03PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 17, 2022 at 02:03:21AM +0000, Ali Saidi escreveu:
> > When synthesizing data from SPE, augment the type with source information
> > for Arm Neoverse cores so we can detect situtions like cache line
> > contention and transfers on Arm platforms. 
> > 
> > This changes enables future changes to c2c on a system with SPE where lines that
> > are shared among multiple cores show up in perf c2c output. 
> > 
> > Changes is v9:
> >  * Change reporting of remote socket data which should make Leo's upcomping
> >    patch set for c2c make sense on multi-socket platforms  
> 
> Hey,
> 
> 	Joe Mario, who is one of 'perf c2c' authors asked me about some
> git tree he could clone from for both building the kernel and
> tools/perf/ so that he could do tests, can you please provide that?

Sure, I will prepare a git tree for testing and share with Joe.

> thanks!

Also thanks for your reminding.

Leo
