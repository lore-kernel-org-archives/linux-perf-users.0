Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C11C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 May 2022 14:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbiEZOp0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 May 2022 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347601AbiEZOpC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 May 2022 10:45:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A25D808E
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 07:45:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w3so1591769plp.13
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+RbLucXFRxTah8kZ+jl2a5HS0Pr8cEZF8tVZzhFz8Rw=;
        b=VTTfvSBKq+WmDXM0HZ8z+rbfgMlszuIkE5XXSA9MVpVtUBM0dh5XAORtdBRuhwFpdG
         +fRQ5fPA2wvPliUOJuiuKXzbcyhlBmi3PuebPlabzgVCUcWkNo6R3xGy/DlsF2dsQPnK
         e7zCpLnRvT+QzndGdLRekSFJoLQxTMIq4cGPsgKLt14JNqwTyt2kjN1Elb23mkNs5Qfz
         AfGv0t1+WYgAvuLi1fw31O7zB8vz6/JXGceKPPiwai6d/3oMHwliAvskJloYKFpjLM1Y
         FYueK4JMlxzlSLedpXavCfTOo2lkV4YWsVgfi+1KFg3gcjgJmsHaYqNqo/PQKagjUqFV
         QYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+RbLucXFRxTah8kZ+jl2a5HS0Pr8cEZF8tVZzhFz8Rw=;
        b=x6Z4mQ7G8ba1ycZuJyiu+Si2RRTkAiqk6iNEchJD8wlVOrXQAX9eayd+GkV1zMNryC
         vXerbhFiZRgcHaqUcVNn1pJB1kmz1tsnCg/yWbdb9cbJrG0QcsRYhA9/VL1CcT12VZoB
         wbZbGPRkW33AFDb4ZNM45bf15Z2wyDPaXxomrVQpT/JhnlcoqmR2DvnURDnjozFki2FP
         I9+0naydUJWjgnuK4ZPOw89T2pUHKi/iwPFB4NkVJJbkAgXk1Zej3cB7+ISyQZ3MADR1
         9/X+efel/ffO8YcemJlDlLzKh5cJb+zsH1gL+KDjpcOb3OT1GtMFpb9kgSOyisXdfA4u
         pbTQ==
X-Gm-Message-State: AOAM530+n+EBtrq4OrnMOAtcSfQopbVsrjuLssjFsSpoXXlx7f3MPv0D
        sIt//45nNnmZR7eH/MIb6eFTIQ==
X-Google-Smtp-Source: ABdhPJwXNqAMHg5wxewtScCEWWIVKUg1NiL/cGKvS+oTPPtDWE9rp4KUd21tfnPif4/FUV3Ux/IPvw==
X-Received: by 2002:a17:90b:4c4c:b0:1df:bab5:4f56 with SMTP id np12-20020a17090b4c4c00b001dfbab54f56mr2999734pjb.202.1653576300894;
        Thu, 26 May 2022 07:45:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b0015e8d4eb269sm1633098plf.179.2022.05.26.07.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:45:00 -0700 (PDT)
Date:   Thu, 26 May 2022 22:44:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Joe Mario <jmario@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
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
Message-ID: <20220526144453.GC795802@leoy-ThinkPad-X240s>
References: <20220517020326.18580-1-alisaidi@amazon.com>
 <YoQRg1r7HuwiO3bZ@kernel.org>
 <20220518041630.GD402837@leoy-ThinkPad-X240s>
 <32e5a3b7-9294-bbd5-0ae4-b5c04eb4e0e6@redhat.com>
 <20220522061533.GA715382@leoy-ThinkPad-X240s>
 <7bf021df-2755-6937-629f-b3ed9281804d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf021df-2755-6937-629f-b3ed9281804d@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Joe,

On Mon, May 23, 2022 at 01:24:32PM -0400, Joe Mario wrote:

[...]

> Hi Leo:
> I figured out why my output was different than yours.
> 
> I did not have the slang-devel rpm installed on the host system.  
> 
> In my original perf build, I missed the this output in the build log:
>  > slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
> 
> Once I installed slang-devel, rebuilt perf, and then reran my test, the pareto output looked fine.
> 
> When the TUI support is disabled, it shouldn't corrupt the resulting stdio output.  I don't believe this has anything to do with your commits.  

Thanks for taking time to hunt this issue.  I checked the code and
sent out a patch to fix the stdio interface if slang lib is not
installed.  Please see the patch:

https://lore.kernel.org/lkml/20220526143917.607928-1-leo.yan@linaro.org/T/#u

> Last, it looks like you should update the help text for the display flag options to reflect your new peer option.
> Currently it says:
>    -d, --display <Switch HITM output type>
>                           lcl,rmt
> 
> But since you added the "peer" display, shouldn't the output for that help text state:
>    -d, --display <Switch HITM output type>
>                           lcl,rmt,peer

Yeah, will fix.

Very appreciate for your detailed testing and suggestions.

Leo
