Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C1AC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 09:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbiFOJPJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347680AbiFOJOS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 05:14:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632DB393D9
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 02:14:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k7so535442plg.7
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U5W+u2socUdfvA7Xut56xq8m0f3VViU7LDQmKDKAFUw=;
        b=AuhzgNxfF4Wt8XjnPKCHtvnPTDkBF9j9nHeM3JacQLlyl4UesOejhMt+G6sv5jOza1
         Ip1smplzqEW9tti/ZgM8KZ7wQq6oJO5Wd3QSQ6S2+pDFFvqFx+AqWLdAOO63jkSE5gZI
         EKRXzrTPC61QKv/gkS+anhA9Ev6a9cfxgUdwD43YtoqPukJuA5Hq4wIXfzGtFke1zo5L
         ZqazuW56GgUg4Elsv7veM5cpyfsKta6gqLyTuhM1PtMC8XNaO+r1TANLyJ6xD90goJmy
         h1EHqcBvkgkeekeF9sIMqYr9Go8bpOcLDgiiqq6on37PuuWeRUZiMlYnIRLyninwm8Or
         ATtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U5W+u2socUdfvA7Xut56xq8m0f3VViU7LDQmKDKAFUw=;
        b=s0eSOF2T3iX866Ce8dhbIxybbr/mpzCrBAvevNTXrrp227jX8ymqunzo+ynLGpl/eO
         m6Ok58wKiXfRD7b+/YI8FnYOn7udfvpCSwxtLC3RGqzvd2HIBMJ+8zP7jaJh0F96Z7VJ
         wMX302U665lmyyKqYtVbY1O6E9D0ZaGwIUlQ0YaaO/Hp9VX8jHA6pkOfmNPs/XTP8qNb
         iDatqKhVCh9vvc0L2MJaWMwBxHWhW1gFUOzBG4FFjOhS7jLyPjltAHUZS2bDz7MWAX/F
         tx+d5vg+8EWes4mpxrXd/pe5KdlBH0u1o1qvbnHuJMKoe1UzYpeLDDLHkLmJ+k6doP/e
         u2xg==
X-Gm-Message-State: AJIora/W3qEnNQ+oZLBEVg3IzU6TCM1bQqDlfss6jv0Pb64jU9wgxWLE
        BPQ587pHZp835hRgsSMpjDd3Zw==
X-Google-Smtp-Source: AGRyM1t/aeseBSMJUh1pB4pBXT7wadG652+Zr21QtvXUxfp40vVCbCLIM4o3ACzHMUvDYa13RC/Tgw==
X-Received: by 2002:a17:902:6901:b0:168:9bb4:7adb with SMTP id j1-20020a170902690100b001689bb47adbmr8392907plk.147.1655284456709;
        Wed, 15 Jun 2022 02:14:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f2cb00b00163aba9a2a5sm8717942plc.106.2022.06.15.02.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:14:15 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:14:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 2/3] perf test: Shell - only run .sh shell files to skip
 other files
Message-ID: <20220615091406.GB121786@leoy-ThinkPad-X240s>
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
 <20220309122859.31487-2-carsten.haitzler@foss.arm.com>
 <20220410022846.GB14326@leoy-ThinkPad-X240s>
 <9ab780aa-7e78-b0f9-21ed-cf30f41f8fab@foss.arm.com>
 <20220526101423.GB795802@leoy-ThinkPad-X240s>
 <ae8bdc2c-a444-74c1-70d5-c97d27b22ec5@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8bdc2c-a444-74c1-70d5-c97d27b22ec5@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 13, 2022 at 02:08:30PM +0100, Carsten Haitzler wrote:

[...]

> > If the condition checking gets complex, seems to me it is reasonable to
> > use a static function (or a macro?) to encapsulate the logics.
> 
> Well normally my rule i s - if it gets re-used then do it, otherwise it just
> involves more indirection to follow. :) But regardless of that, given some
> other things you ask for that kind of makes this discussion moot as it
> requires much bigger wholesale changes to the test infra which will make
> these patches a lot more work. I'll get to that later in mails.

Your mentioned rule makes sense to me.

> > > But one catch... it really should be is_non_hidden_exe_shell_script() as
> > > it's checking that it's not a hidden file AND is a shell script. Or do I
> > > keep the hidden file test outside of the function in the if? If we're nit
> > > picking then I need to know exactly what you want here as your suggested
> > > name is actually incorrect.
> > 
> > I personally prefer to use the condition:
> > 
> >    if (is_exe_shell_script() && ent->d_name[0] != '.')
> >        do_something...
> > 
> > The reason is the function is_exe_shell_script() is more common and we
> > use it easily in wider scope.
> 
> As above - will probably have to redo a lot of the test infra involving the
> shell tests to handle some of your other requests, but if we don't go that
> way, I have got where you want to go and I can do this.

To be honest, I am not sure if this patch is related with refactoring
test infrastructure or not.  You could reconsider when you spin for next
patch set (as you said, might refactor test infra).

In case you still want to keep this patch as it is, it would be fine for
me and you could add my reviewed tag:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks,
Leo
