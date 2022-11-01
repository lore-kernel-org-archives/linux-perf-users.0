Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF211C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Nov 2022 15:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKAPQn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiKAPQS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Nov 2022 11:16:18 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D0310FEF
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Nov 2022 08:13:42 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id h10so10484017qvq.7
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBUz9xidKcyAmfufSwKD+9wwTQJCe8m53sPImB6DPGc=;
        b=CoxjZhEdqEZ5QHMLGN/vqaQhwRjCMxBEFjYHE/kbiVZeFQBbi+Fwefw0H1tEGvMdsN
         NlFo65jFJulXfG5fiXCYKtTQodLV+hzD3SOALvAIaXMAtljxkvo5Q+Yc4LGABULxiilP
         bhf5ACGBpDA/uNvGH8IG9d2kshCOS/4wYMx7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBUz9xidKcyAmfufSwKD+9wwTQJCe8m53sPImB6DPGc=;
        b=LAfCprRIryy/lolNC4QdKstBiSIq44AYTac9f5IL+HgrRZ3aP4bEW76ysaPI1gFUFP
         JvnKY0h6M52X2BijEOSyo8tskR0pBXEVGPYeX2JSZKdihZ7or0LIJtol9G0UDtJKTI/q
         0CxjgB6TWIXk1yntRPJxryWx371FPrlun8jTh5PFHSdzd019ZuwmT0aRPXXlD1UdcPa+
         1hweVbFBd7KvZYIxeE9/R+1541J7aEa74OH3/F19TuDaMa+JNn7/qNY4yjcA1bAumvdI
         fwcg93H6k0fwuPc3Y11iDDW2V4A92Emdm0q01i6ZZrkLjMgvlkbQFfVva+fSzzfuUIUw
         ggMw==
X-Gm-Message-State: ACrzQf1v0IyYZBzotCAiMqDahJcm/t1s5eM/EeO0HocGFI7kupSOhqJo
        IScIHY2TxlCLZ6HyEQrFZBT1ZcMDofEsiQ==
X-Google-Smtp-Source: AMsMyM5yQ68v5wa+UsQYNNMUDFay0HnSqCAc4ZERvzV5QQCEnzN39+Hbz2qyi1f/xxcpcmRQlUftDg==
X-Received: by 2002:a05:6214:1c8e:b0:4af:8570:8878 with SMTP id ib14-20020a0562141c8e00b004af85708878mr16388660qvb.33.1667315621719;
        Tue, 01 Nov 2022 08:13:41 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id bn4-20020a05620a2ac400b006f9f714cb6asm6600845qkb.50.2022.11.01.08.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 08:13:41 -0700 (PDT)
Date:   Tue, 1 Nov 2022 11:13:39 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     tools@linux.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: b4 ignoring Reviewed-by: in quoted-printable email
Message-ID: <20221101151339.rhp6hys6vnxm4skj@nitro.local>
References: <CAMuHMdUsfc-NNHswtS8jjhWFwk4fX2yvynKh4q0x_u01bnUQBA@mail.gmail.com>
 <20221101123035.xkytwxrhrkhjadc3@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221101123035.xkytwxrhrkhjadc3@meerkat.local>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 01, 2022 at 08:30:35AM -0400, Konstantin Ryabitsev wrote:
> It's actually because that message has a subject that doesn't indicate a
> follow-up (doesn't have a Re:):
> 
>     Subject: [PATCH v2] clk: renesas: r9a06g032: Repair grave increment error
> 
> I'll see if we can recognize this situation, but it's definitely an odd
> corner-case.

There is a fix for this in master.

Best regards,
-K
