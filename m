Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400BAC77B76
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Apr 2023 20:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjDUU7M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Apr 2023 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjDUU7B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Apr 2023 16:59:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F6A2114
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Apr 2023 13:58:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so3579582a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Apr 2023 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682110710; x=1684702710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYproC0FUmFm/EQBdwibgZJS5ZeYo9POxZK2lapAI5s=;
        b=pAvRPNhrbfzAfdjsHi7AZSDAP7LY7CVW9VPWniRl+nvQ83MxRHLDjnxUTEP7bnckAp
         D+9tNiJjUz8BCl+601haRaESlcEg9d4AeLPhU6FnXHiTUFQGjbCgOy/aw96lnWQXOy9j
         aCwZBy+c7gwvhpKZpw0JMxpgRI9pG2RNkYrQTZl2SIq+mts9zS0g/gjbD0dhhUv+dQUu
         Mxz1EbKJFA4hfiYd1XASlneriM6Z50KV7+pxevlBFOnl1Qw+GZ3YJ2fpe6YdtQEhzzmN
         bPgjL/vvU/i4LYNk6Ry9oHgyDM30WPgWj0KpYJfyBatNSG8HiW6o1BSp/R+nswXtNsoR
         7RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682110710; x=1684702710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYproC0FUmFm/EQBdwibgZJS5ZeYo9POxZK2lapAI5s=;
        b=OUWXbjCHKrLafKKO1C0jL17o/AH0KqzmU3E1UoU9bBwxFFrBeyGX5WRwWgBGuVxfZ7
         LNAXFL/rCbh84s7DX2UO6RrP7qJ+P090zy75ynuOQSS/E/WkuXgVVzPSW2p4/UenAsCE
         0TNoRNaxRPvFx5nhNdJiG3mPrOcrO/GGcAlq9GH4TaJdwQdh+BWEGC5aVM3R6J95vZ/5
         x5LymJvDgX3va4F73eMfn2HnijinD6KTGYQUc9FT2YTxQpXloCq3Ym06wqftLhhofcBR
         f1jURnjKI0Q31LTOH+nAL/Cpu0NMnM6+QM0EPvOqGSJEuSLdA5OkhwKah3iqMu8zGf1y
         yqlA==
X-Gm-Message-State: AAQBX9fSldvZpAeUnk7hCQ37X2J7OmF6l2jOkarwgmedwM1bemCwypoD
        6eAnWYXDUegGL3HMp6vdFJED5iqXKWY=
X-Google-Smtp-Source: AKy350auyCzt7YHqwXsPmmSBppuLNoUiqbpdu6gpFcbDxCG3HgOMwBoWKclFtluvrLbKbRSyRCTCsQ==
X-Received: by 2002:aa7:d94b:0:b0:508:3b21:7cbb with SMTP id l11-20020aa7d94b000000b005083b217cbbmr6089334eds.19.1682110709444;
        Fri, 21 Apr 2023 13:58:29 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-027-023.094.222.pools.vodafone-ip.de. [94.222.27.23])
        by smtp.gmail.com with ESMTPSA id e17-20020aa7d7d1000000b00508480633bdsm2202774eds.74.2023.04.21.13.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:58:28 -0700 (PDT)
Date:   Fri, 21 Apr 2023 22:56:10 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com
Subject: Re: [RFC PATCH] perf stat: Separate bperf from bpf_profiler
Message-ID: <20230421205610.xawzzfy36iskcoyx@erthalion.local>
References: <20230412182316.11628-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412182316.11628-1-9erthalion6@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> On Wed, Apr 12, 2023 at 08:23:16PM +0200, Dmitrii Dolgov wrote:
> It seems that perf stat -b <prog id> doesn't produce any results:
>
>     $ perf stat -e cycles -b 4 -I 10000 -vvv
>     Control descriptor is not initialized
>     cycles: 0 0 0
>                 time        counts unit      events
> 	10.007641640    <not supported>      cycles
>
> Looks like this happens because fentry/fexit progs are getting loaded, but the
> corresponding perf event is not enabled and not added into the events bpf map.
> I think there is some mixing up between two type of bpf support, one for bperf
> and one for bpf_profiler. Both are identified via evsel__is_bpf, based on which
> perf events are enabled, but for the latter (bpf_profiler) a perf event is
> required. Using evsel__is_bperf to check only bperf produces expected results:

Any thoughts on this? I would appreciate clarifications if I'm missing
something.
