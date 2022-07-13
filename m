Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB7C43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jul 2022 07:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiGMHYE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Jul 2022 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiGMHYB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Jul 2022 03:24:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521ABA58DF
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Jul 2022 00:24:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso2161460pjj.5
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Jul 2022 00:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uFgDBk59dxIvNKwO7TbFi3S9yCLunUgwSwhRll6Zcig=;
        b=jIKsimRMrAYD9WDmhOnIemZHqNaqeCD/7FB14dA/vg/HRKSJ/8zMcTVfOyXgZ/thEK
         XbPOZo5/fxnTmQVda9j9GydtmdD0Sg6SQf6IwvskAsALhbQbiWR8QdPNNF/JleGqjuju
         J0JJC8SDfjcyPCvvk+h9Yr+dUYPVPy0k70fJZy/lyzDAlrHbA1sBYhptvBEXPawl/SBz
         t09aQbwySMv8tVAiT75Twzyzf8C9GBhaJwtsu93I0tDaS7BhAyTEUjgi4sau74of+LNn
         gZaGBPYj//FxEZa294MVy+IyOkojeiJ4Huu98bK4Sz9cH4WUR/nrvGgDQf3o4JMZQRy/
         lt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uFgDBk59dxIvNKwO7TbFi3S9yCLunUgwSwhRll6Zcig=;
        b=T7hTRGIMOQFQCtszpsjNGmh2LfBXajMBfUkX1ilkMQbJL78ZaRUNVF+P4QAykiMbfW
         OcKNJv+WKmNr7qHyAwepi85bhUB9PjGWUOOHK6H8YWsRG0fKE2VbccohNZgzC1v9f2OT
         FJMgdVYUvfwHfFbqjmxyi9zwz64M+w8+BwUd1hLE0Vf2Slf0uU07Iar+BfuK3rM6vjKK
         MiKBavhnVK7nmSye8dudDCFJvTDqKyFhgkMa+7aiwUkpn7E7vsDfPeERMgxBqcdY7AaE
         AmUQTk5NIFRMSL0idqX3DZ//N4A0WM47CE8UcywqDy7+j1dch+Gt4vKlo82xUdiw9bmR
         apdg==
X-Gm-Message-State: AJIora/eUTxhclj6GiEKcl3AqIRKS2zy4nD1k4wqKWzSg6C8orOntnta
        JLHDe3ysaKOQtAVH6EkbHSxDkLGE3fyEIA==
X-Google-Smtp-Source: AGRyM1vAmdjvGOUNAVOQV1aNvFD8FWfYkVuxCIRzfqwxBWhy+5D/ztBkv3wDp3zk2B1QtAChzRqDXg==
X-Received: by 2002:a17:90a:2b4a:b0:1ef:3e28:fbc8 with SMTP id y10-20020a17090a2b4a00b001ef3e28fbc8mr2337876pjc.54.1657697039790;
        Wed, 13 Jul 2022 00:23:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id w21-20020a1709027b9500b0015eab1b097dsm8036801pll.22.2022.07.13.00.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:23:59 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:23:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 02/14] perf test: Add CoreSight shell lib shared code for
 future tests
Message-ID: <20220713072352.GD1354743@leoy-ThinkPad-X240s>
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
 <20220712135750.2212005-3-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712135750.2212005-3-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 12, 2022 at 02:57:38PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> This adds a library of shell "code" to be shared and used by future
> tests that target quality testing for Arm CoreSight support in perf
> and the Linux kernel.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
