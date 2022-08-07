Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED52C19F2A
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Aug 2022 05:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiHGFRn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Aug 2022 01:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHGFRm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Aug 2022 01:17:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1BCE0E1
        for <linux-perf-users@vger.kernel.org>; Sat,  6 Aug 2022 22:17:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m2so5958999pls.4
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Aug 2022 22:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/M40Lir0c3unLFM3oH2uK5N2/5ZEFQr2Skfy+gX1t/U=;
        b=KPa5EHbxec7dPBJyLKuuOBy2dcOFjef0WqKoi6IaYpXsd7sdYVQ6Wr9sI6F+9kSaRc
         Mq74iqKc93IhmZzCuW7QcPyGnJLqENWiLTgrDPLKfE4aLXkYylagFwdJ9AumUPXM2ucD
         4tcsb5gX/Svz16b7fYggGScSQqGitFbJ6PiewhJ18aAnVchzwWQvdppBPLivoJtqg+NB
         SlCI6nvSjkT3kAPGr3CPJiTe5e77vkm59LRpt2FdKKpbJQyvbiLG2+sFBBaHZQU5gtd2
         /+f2Eu43Aye+MqiSpHFEk7SgwwGAfqUbMvJNZvJFNs/N34EWaditc3RWGNF2Pu08qMHU
         lJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/M40Lir0c3unLFM3oH2uK5N2/5ZEFQr2Skfy+gX1t/U=;
        b=OIGHBpL0y24M7f6w9Frd4fs7KK7ow7ISQE2+qGEKfepZthe9ES+MRC7tl7xchFygoU
         sW0lewINu/Rc1y3uM6iH/ZNTLxbY5kRxnxS68GuXU7wjVP/FdpfdZhG+rtAZPDQySzfv
         iykGfzw16QD2Jnlqyqzik3sIInyx9u0CN2lXTvgXQe5z4JBulQfqdPLnVkBLVv+Wg0qS
         EbiMC9PhvWHSiG5UDJJgAw41rkZslRH/Uj1ht3CAZULrJDy4B2rnPifKMdjJdnlmc+pw
         2HofEtaaLp+x42SIIB2Sydmhdz+fkEnE07u0JAwDwjyMV4BDX9bPiizLydwjBHXUlW3g
         hXZw==
X-Gm-Message-State: ACgBeo3Bp5FnrN29PYp2ZCygTlAhbJQz4ExOM8GMdJfY9olSg2qs+g3h
        stVahrdZPyY/gGmrTXVR1x4Hmw==
X-Google-Smtp-Source: AA6agR6NsU64wnmBKtMCQ71dQuf9D7EHh46eTrnAKTS/AgPHAL00p3DQabpZDAS1UBQG1dlBfMfwvw==
X-Received: by 2002:a17:90b:394:b0:1f5:90a1:acf0 with SMTP id ga20-20020a17090b039400b001f590a1acf0mr9593429pjb.40.1659849461339;
        Sat, 06 Aug 2022 22:17:41 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902c65200b0016d738d5dbbsm5860632pls.97.2022.08.06.22.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 22:17:40 -0700 (PDT)
Date:   Sun, 7 Aug 2022 13:17:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 10/14] perf test: Add thread loop test shell scripts
Message-ID: <20220807051737.GH34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-11-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-11-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:52PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add a script to drive the thread loop test that gathers data so
> it passes a minimum bar (in this case do we get any perf context data
> for every thread).
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
