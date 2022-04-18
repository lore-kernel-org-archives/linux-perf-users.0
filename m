Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB46FC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Apr 2022 22:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiDRWCo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiDRWCg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Apr 2022 18:02:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589FE1A38E
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Apr 2022 14:59:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s17so2590136plg.9
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Apr 2022 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cLLWAAHArn9WgPwOUwNflPPJDgjsRY1O3bHGAhIDsQw=;
        b=LTURonE53ti9q/GT1aK7iRoPMpGAeCy1e4EeYMoQ5ND31pPzYRrBIuxOtS32aAiFM+
         1XHlY0ymuxtf7KP5zzxh8j9ip4/ZkYqKkInt8TY5JnA0taa6ag1p6HhrtkPYOmL/X1BS
         68H/ZEsyd88OXRqhJx4ed+KaxwMRzhvwF+Q30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cLLWAAHArn9WgPwOUwNflPPJDgjsRY1O3bHGAhIDsQw=;
        b=nbTZogvIXB3O8TKnZWF70/+SIO41eKh4tHKsE+qxebK6wZVQI24mMXtjNuTaT68xig
         znFPwqh7IkZ2+nZaDP+RwCDudewVcotCzYMctLuKp1xt9yPks0WeuvwRsLRTVbCfJQnU
         OvQl8/BiIxj6Yx0betG0kjNce6R6ND6VQp3fAlOxqohxo5jxxTOhz2UFb/7NjqckeF4m
         KMvXDl+MpdMr32cLBVd9uj/32hOJWw/H+A7CUh7o8uX2JRpeP3zjSjuynwmSUt+l8Hox
         m4QLgxAWnS697Xrqn0ET1/EtqtH0SDjHdAB2k7nouHv9ghV4IFWxzfcXW127iZ0z9fzK
         ti3g==
X-Gm-Message-State: AOAM533zMyduR1QpSvY9kg0X7LIJzbLVVVRf0JC30RVnDeaeyiQL8NVK
        mgEdOAG4VD3V1WPYnFTXk4i56A==
X-Google-Smtp-Source: ABdhPJysM2kkydsu6S512r9sNHn81bBvZQZwemOKp8WmD7sADc0kfHvR6/TUHLqhcn1MQ99fL/O1Og==
X-Received: by 2002:a17:902:6bc2:b0:158:a26b:5884 with SMTP id m2-20020a1709026bc200b00158a26b5884mr12917161plt.38.1650319190427;
        Mon, 18 Apr 2022 14:59:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm12953099pfw.168.2022.04.18.14.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:59:50 -0700 (PDT)
Date:   Mon, 18 Apr 2022 14:59:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] arm64: stacktrace: Add arch_within_stack_frames
Message-ID: <202204181457.9DE190CE@keescook>
References: <20220418132217.1573072-1-zhe.he@windriver.com>
 <20220418132217.1573072-3-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418132217.1573072-3-zhe.he@windriver.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 18, 2022 at 09:22:11PM +0800, He Zhe wrote:
> This function checks if the given address range crosses frame boundary.
> It is based on the existing x86 algorithm, but implemented via stacktrace.
> This can be tested by USERCOPY_STACK_FRAME_FROM and
> USERCOPY_STACK_FRAME_TO in lkdtm.

Hi,

Thanks for doing this implementation! One reason usercopy hardening
didn't persue doing a "full" stacktrace was because it seemed relatively
expensive. Did you do any usercopy-heavily workload testing to see if
there was a noticeable performance impact?

It would be nice to block the exposure of canaries and PAC bits, though,
so I'm not opposed, but I'd like to get a better sense of how "heavy"
this might be.

Thanks!

-Kees

-- 
Kees Cook
