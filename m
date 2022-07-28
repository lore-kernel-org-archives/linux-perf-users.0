Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB14C04A68
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 14:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiG1OHb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiG1OHa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 10:07:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC7BB4AD
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 07:07:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ez10so3309675ejc.13
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QZxVwmxBuY4glS8He1NEoVQZGmzmifZVxltSMpgRBFA=;
        b=NghgwNWtKz+JANRzqnnukXpuxc/UDeNii9m77lMd5nUR+T9OM2Z9WwypKpU1T67pxe
         RrWQLkp3xpTnecpKmM16zpgCne+0D6tpkJ1k2AaYy+OPhV1hrea3TS2FsVbDzzdLNDEH
         H5fTyFYjxFL5gO69QJO/xBHeCKFS3qjpa2X8s1uP7Humv2Eu0c+qO7ux16Fpm875OFKv
         g12MP4uGcOaf/gNUOeBl8DZC9LDu3+p2JDTctLSmZDTJ+iS40uiZDZ1c5yxZGE7jwdQs
         xLiSMuD4SJMYhf2mfnGXXaUt0DfnkZ+FEGvPzIyPQoCPQUIVK9KJhWo+8ratnZftUNoX
         rodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QZxVwmxBuY4glS8He1NEoVQZGmzmifZVxltSMpgRBFA=;
        b=Gn1CrWejv2ayikGC7WQbaIcaHdmzmqVVIovNKqCRFIDJI6f5ubl93dU2A2f9oygMp8
         P/bq4CJiqmyoUkrUeiI6+uymPQ5ph2iU0H406U4qq2z8LllGRtJvlqMB+97HpLyPOypf
         UM3HAyJGDtVsWoCRtllf+HUeevga2yUgOM8RW8UJd+/SNmQRyyhLO9qKbbmnDbr3M8xQ
         3aBa4kkfXWnZxVShUudAf2BLfonfKRZkyIp1x8/Awq+yuSSgrkpKNkSkc+jXheLtoQHN
         UJN4aB3v3VSu50s7RcpJjSlwsb3bezfh6v80eGkc3m8sa2NICISDbRtbIY6aZHRHuBfv
         ABuA==
X-Gm-Message-State: AJIora8IWVrP02zVPI1FCZVH6mssjpjhsr/4nECiX2DusF9dQ7kzj1qR
        HuQYY3YLN0S12juOka98/djD6Q==
X-Google-Smtp-Source: AGRyM1vKxhFrpfn0IYoDMcb3+vqvrZWXIMa+hNENRWmapEq/FXLPx/GD2n1/Koyt2hwPHkgA3SBoig==
X-Received: by 2002:a17:907:168f:b0:72b:5571:2228 with SMTP id hc15-20020a170907168f00b0072b55712228mr21170383ejc.397.1659017247699;
        Thu, 28 Jul 2022 07:07:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id qp8-20020a170907206800b0070b7875aa6asm448167ejb.166.2022.07.28.07.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:07:27 -0700 (PDT)
Date:   Thu, 28 Jul 2022 22:07:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila <adrian.herrera@arm.com>
Cc:     tmricht@linux.ibm.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, James.Clark@arm.com, nd@arm.com,
        songliubraving@fb.com
Subject: Re: perf tools: software regression in
 d0a0a511493d269514fcbd852481cdca32c95350
Message-ID: <20220728140721.GA52489@leoy-ThinkPad-X240s>
References: <f15afd38-3628-c57a-0735-1342f379b83c@arm.com>
 <20220714124638.GB155077@leoy-ThinkPad-X240s>
 <ee574459-f2e3-ff9a-5da5-a634952a726f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee574459-f2e3-ff9a-5da5-a634952a726f@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adrián,

On Thu, Jul 28, 2022 at 01:44:57PM +0100, Adrián Herrera Arcila wrote:
> Thank you Leo.

Welcome, I recognized that I am not the best person to answer
your question :)

> I think the source code fragment in perf-record is more readable (logical)
> than in perf-stat, so replicating it would be better, also for consistency.

Makes sense for me.

> I have prepared a patch for that which I will send for review.

Very good!  I will review and test your patch.

> perf-stat differs from perf-record in the presence of BPF counters; these
> are enabled inside enable_counters immediately, independent of the delay; I
> respected that behaviour, but if it is not a problem to delay their
> enablement as well, the code would be slightly simplified. I have added Song
> Liu (author of BPF counters), in case of any comments on this.

Yeah, I also noticed that BPF counter enabling in perf-stat.

To be honest, I am also wandering why BPF counter cannot be enabled at
the same point with other events.  Would leave this question if Song
has chance to confirm for this.

> Note Thomas issue arised when using "-a"; without it, events are enabled on
> exec of the workload/command, so the instruction he mentioned would be
> captured. The code structure in perf-record, and in the patch I prepared,
> relies implicitly on enable_on_exec; I tried to clarify it in the comments.

Seems to me, using the flag 'enable_on_exec' is right thing to do.
I looked the code in "perf record", it uses a tricky to enable dummy
event when the workload process is forked for system wide tracing,
PMU events are deferred to be enabled for "initial_delay".

Look forward to seeing your fixing!

Thanks,
Leo
