Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01218C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 08:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbiFOIOM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 04:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbiFOIOI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 04:14:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064DC16598
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 01:14:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e66so10705521pgc.8
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VkHWHF8MpaRs/nihAB7C/Xh+47HVF9z5Z4k45WEq9xY=;
        b=HVFUBBhY+Kt7w8a7m6zrJvK4FoGKXsXiFF4aALpTQ2ZFbXBJobG1oveOs9pGLju/UQ
         aj87OL11Vly4ovkYYzBka3WsYVL4ZpDVmdVtUhtdj14fYdJ9eIKQX/0oP22099ywtamb
         djmf7AM4Bp+u3pVg6PpvGZXz5tbYB1TbyKRjEMng2hAva7DZZjDOQoJJSNFpkqar+hDt
         R4/bZ4aPt60DjUNoWDvlUQpBb65qXLafrrKbQjQwW7J7+lltX020UGGLulTWkDRNWlOq
         pdIlonOycU5OBfcuLQ4057NUPXbY33Z44CXgybouUmRW716VLX1LZrkbv9uEjBqPVY6O
         QAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VkHWHF8MpaRs/nihAB7C/Xh+47HVF9z5Z4k45WEq9xY=;
        b=3DrrIQTXomVWM3n2T2Zpz4cZ/Z/rfWfkoeyWAcS7NdOZJL0A3DecIy/SSfaehbwAV5
         If9pt8QpPEan0FrXGKO5ML2ihCygMv3QpsnSWBBtF4Iiv7YV20DFx8jYpgi3NFu1+fBL
         Xu1ckrcKTvYUB2RDYVhhkLGG0UlvWfmWcopOt39rNPfeWfRtI8Q4xuEh1K+n9ud71mDj
         rrrdWOnEzWsSH5ZBnY0PEG+Ein9oAtNJ05wJiEiwTlI4z9/21qiZtHh6oxd2uSwCjUEO
         tatjDPSwKrh05slUPRqeJFHMTDg/GgqjY7wbWnmrVXvYgL5wmvnxBbqGd/xN51FERYW9
         js/w==
X-Gm-Message-State: AOAM531/f65J55FWZ9mGQlJdGoc0m+yqNltbDZyr7VM/rdW0wxJaJ/n2
        q8xd4r1/nPYz40FeZFo3K8FRmbR9bGdeWXt/
X-Google-Smtp-Source: ABdhPJz17qKd6RkXUJ1QdBsiQLZt4HAWNkclH6GXQ+78KHjWUid1OLBJqdYHG5dRSzpXgTsUQBS73A==
X-Received: by 2002:a65:588b:0:b0:3fe:4237:2ee5 with SMTP id d11-20020a65588b000000b003fe42372ee5mr7940707pgu.442.1655280847377;
        Wed, 15 Jun 2022 01:14:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b0015e8d4eb1f7sm8575117plb.65.2022.06.15.01.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 01:14:06 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:14:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        jolsa@kernel.org, german.gomez@arm.com
Subject: Re: [PATCH] perf test: Record only user callchains
Message-ID: <20220615081402.GA121588@leoy-ThinkPad-X240s>
References: <20220614105207.26223-1-mpetlan@redhat.com>
 <20220614131704.GA237086@leoy-ThinkPad-X240s>
 <Yqjc/FSW2sJ6ZA5U@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqjc/FSW2sJ6ZA5U@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 14, 2022 at 04:09:48PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > With addressing German's comment for "excluding kernel callchains":
> 
> Addressed.
>  
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> Thanks, added.

Thanks a lot, Arnaldo!
