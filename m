Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A9EC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4847F60F51
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 06:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhIEGwE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhIEGwE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 02:52:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5ACC061575
        for <linux-perf-users@vger.kernel.org>; Sat,  4 Sep 2021 23:51:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so6981102lfu.5
        for <linux-perf-users@vger.kernel.org>; Sat, 04 Sep 2021 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCUn+2qRLI75io76iCw/x7jzz8g6PLJM9nRzlA50GNc=;
        b=RCbmcwboEt8sPEv7c+tRTYjWE1a4LsfUigdH9KQcA9cfUx4WuFpuISXhGIS9rqDLzS
         eX7pcbVRdzwUqsJlfYHdPkZ2YvNrJzf8aKrgpvmnUXMnOoCLYHLmUBMrk9O1AQaCl7ni
         KTsSDJ2WYzlLAsr3R/9DPg1EicNu0eLMbADQrjKe123OfV050nsOhSJ8x2DXUDW8hVg8
         j1r7fCAmzgTXa+FDicDu6grTC6jZ2kDRt/18M4qG8UsioTsMVoHzN5sOf3kcy5sYpZkg
         Uehjhy4mZNjHmEmEP30ItxKGGNsD/2dBZQhgc07prjxRSqfaMEmOsCbkYSlG6XSF52UG
         jfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCUn+2qRLI75io76iCw/x7jzz8g6PLJM9nRzlA50GNc=;
        b=B6BNJt2sJdYIvFjP653JJdxzzIbzoZLwJddCjTJQi2Sqoe68fE+A4NlqGFMpKyOSVp
         dpLlpTPhKxu6sf0FJXw+88xidQBQmmx1Folio9J9GWiXplWpdzSj7UwQ/LhrVMOJXhZT
         kvd3WcU9/TH7T0y0KT2mJm32j9CLKB05ukrG2Uu2guMFqivRJVsK9LXtGwaJjA95o9xk
         wGTlcdyOMWgbue+RcuCNFr8qLUDMocWvfwlGOAVYaVt8Vwik/on913BvQvsY2ajEuIUJ
         8bCxQ1vyzfEBLN31RpcUSdQZ5+apPGJ5hG9sQ7Nvx8RLqhbKuaodc10fRUYU9TCdrZ4m
         GD8Q==
X-Gm-Message-State: AOAM53111LQjjwSqxzXKWI5zjLVF+R0dY6wIFztNZWqEbXBagbNsynWv
        FfzfvR09GovOR5qiL9GLL0v7nKrh4BtQyIbwW5824QTi
X-Google-Smtp-Source: ABdhPJxMxT0AEOqag9xYSl65g+i3ZSeL/gpYrXfYEsYXfq3F+bVsZd+6p+gRd25bRCaErLKJzjJh3KlbGAgdBBVTjhk=
X-Received: by 2002:ac2:5c45:: with SMTP id s5mr5364346lfp.464.1630824659283;
 Sat, 04 Sep 2021 23:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAM07o6QB9rUgzxHxR=sdwTddn+2GxeK5Uwj9QeCVMyEiD5SRdA@mail.gmail.com>
In-Reply-To: <CAM07o6QB9rUgzxHxR=sdwTddn+2GxeK5Uwj9QeCVMyEiD5SRdA@mail.gmail.com>
From:   Brendan Gregg <brendan.d.gregg@gmail.com>
Date:   Sun, 5 Sep 2021 16:50:32 +1000
Message-ID: <CAE40pdf7n-YzZb71CvFmNFtCh3eTiBfAtiWxdJQLQRxs-hVUmA@mail.gmail.com>
Subject: Re: A list of visual Profiler UIs for linux perf
To:     Mark Hansen <mark@markhansen.co.nz>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks Mark,

Nice to see the adoption of flame graphs everywhere.

I'd encourage people not to overlook Flame Scope. I created this
visualization to address problems with flame graphs: how they can hide
variation, perturbations, and interval patterns. These are all
illustrated by the flame scope subsecond offset heat map, and then you
highlight detail and get the flame graph for those samples.

Or put it this way: If I wasn't a Netflix engineer, flame scope might
be my commercial startup and you'd be paying $30/instance/month to use
it. :-) Instead it's free: https://github.com/Netflix/flamescope

Brendan


On Sun, Sep 5, 2021 at 4:20 PM Mark Hansen <mark@markhansen.co.nz> wrote:
>
> Hi perf-toolers,
>
> I wrote a quick literature-review of profiler user interfaces
> available for analysing the output of Linux perf:
> https://www.markhansen.co.nz/profiler-uis/
>
> I couldn't find a similar list of profiler UIs online. Hopefully this
> can help people find the profiler UI that's right for them.
>
> I'd appreciate any feedback; in particular: did I miss any great perf UIs?
>
> Thank you for all your work on perf,
> Mark
