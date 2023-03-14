Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B33C61DA4
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Mar 2023 00:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCNAge (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 20:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCNAg1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 20:36:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7682A97
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 17:36:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q14so2791970pfu.7
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678754176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlH32Emuag8G8y9Ul5mcocRDTiGSeipNTGU5xstePhI=;
        b=LC9WAk/kiCsVP8DZ63qBj9WES4RNUeUZHz0x915YlHbjaPh1l3J5fJy0NT+ObTGJ08
         sPWmP+WS+kbCjhi1JhXNgK/wc/KZPWlI8vzMvW6uH/HNrHWddbpdOnG/SYvbdAUA0QoC
         EIXxfZpCRb47Gr2HzktVuZIxIh+TNzB3UjGpMVy+N0dnFtRGcXGG7Hgoxp3jVeqECN4Q
         TaorKyjxRuAM8gsKUtzC+GLqU8UXvNLbUGwyi4p1G/SDr/Ay2Ylot98x5f+kclK5y7e8
         2PqekyLXOp6JRzqiMkYMYka9PZJzEN5ibhbksk7TJcb1VQ4L9w9hi6UsdTUlczTwMtAj
         rGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678754176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlH32Emuag8G8y9Ul5mcocRDTiGSeipNTGU5xstePhI=;
        b=0uawoGc+FMCq4vcFd+OIwGTOJHXf38aG+h0NMnQ+dUhV4xrtOfHgWgRnO5bkF6Mfpv
         CTx5/kYHz1Scia47u8M3k6QK6HytMHABT8cXGtA9bcqQ/6FGdOUOUmJC/QKBp5iw9AkX
         WrO8rqgyi/LLYJOkQfbTJeyGGdB4j5jLer69sme3vPczgRMiSRxBrQZc8FKtG9aBzQYh
         6nIGqOYY7vQPH95KaLYyv5CZodAH4uF8WLudW0IV2G5IBFYGk2XLsIJImu96fqQetg8k
         rj3v6QbJOXHASAiBOg/S987755Uzda8wuQC6YqpMxqV2kMEjqSI/2P4Y15XFdi8FZeX+
         nCyw==
X-Gm-Message-State: AO0yUKUbIV3jU8P+bmtLbZwmZssx0yhSyyBivYoutobe4FWfNOMSquDA
        U3HN0ResLwdVdhBsnSbBDU2vMQ==
X-Google-Smtp-Source: AK7set+Oh5cn1IYOWU6yauoYsJOvLntjuV2ZQ7CGBQKzeIOFxWwEiay+rHs7xVVYnsJGnaGv7uURFQ==
X-Received: by 2002:a62:8489:0:b0:5a9:bf42:fcc5 with SMTP id k131-20020a628489000000b005a9bf42fcc5mr40513981pfd.0.1678754175989;
        Mon, 13 Mar 2023 17:36:15 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7828b000000b005ded5d2d571sm271368pfm.185.2023.03.13.17.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 17:36:15 -0700 (PDT)
Date:   Tue, 14 Mar 2023 08:36:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mathieu.poirier@linaro.org, adrian.hunter@intel.com,
        Jiri Olsa <jolsa@kernel.org>, acme@redhat.com,
        mike.leach@linaro.org, Will Deacon <will@kernel.org>,
        suzuki.poulose@arm.com
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
Message-ID: <20230314003610.GD2426758@leoy-yangtze.lan>
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com>
 <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan>
 <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
 <20230313121420.GB2426758@leoy-yangtze.lan>
 <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 13, 2023 at 11:15:44AM -0700, Yang Shi wrote:

[...]

> > Just a quick summary, here we have two issues:
> >
> > - With command:
> >   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
> >   -- taskset --cpu-list 1 uname",
> >
> >   perf doesn't enable "text poke" attribution.
> 
> No, it enables "text poke" and perf fails to decode coresight trace
> data too. It doesn't matter whether "--kcore" is after or before "-e
> cs/etm/@tmc_etf63/k".

Understand now.  Thanks for correction, if so we can ignore this one.

Leo
