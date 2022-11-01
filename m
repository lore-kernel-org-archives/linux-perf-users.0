Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23684C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Nov 2022 15:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKAPTG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiKAPSg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Nov 2022 11:18:36 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC2411818
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Nov 2022 08:16:48 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id l2so4782802qtq.11
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 08:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdCgoNIOCLrjJEAxFBcxqF43KwlKXZNll1NW/0wnzcM=;
        b=zduSsqPWuc8cyPHa+LYRBCV6qqx4EiWJqz6gevvsbB0DSTClmLUHKC8b45SiClK62B
         JisEkYjxgtD4ns/2CLPURhf0aAAjd7vE2FTsuf3od3yjVVsL0QdxezhT1Rp48OBPNvwy
         QADihldtNq19QZJU9g0C/KTXfLVB9LDK7/YNKw0DjZv8QTGz0eM84GZP7yJtp6pyDTu7
         nIuWjZXCD21LYtPCuGPS+JW1LbvR6duDBS+FZXwoNhOO4nA5bUai7NIS8XMXK1XuqnOv
         BPyV01ED1wR8YHcAL+uFkF9+wlpEtDkRQMgig8x9o4W/FjE/r+qJTL77IvEybVjNxK5H
         e00g==
X-Gm-Message-State: ACrzQf06PDTqI8aQ9d/X+BgnqtnyAqahgFIA5R5hy4tMd/atseKWikxl
        mt/hR+rwOlzOHVBqo/bSAiCKQCLuq4H+6g==
X-Google-Smtp-Source: AMsMyM405TmASF+fY7YKmgfhrp/Uma7FoGVawqgw6Fb+XfjGa4VgAP3SZJmFkROgVV9bwZesGemw6A==
X-Received: by 2002:a05:622a:1c4:b0:39c:f5a3:2f67 with SMTP id t4-20020a05622a01c400b0039cf5a32f67mr15456220qtw.29.1667315806822;
        Tue, 01 Nov 2022 08:16:46 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id i5-20020ac84f45000000b0039ee562799csm5242585qtw.59.2022.11.01.08.16.46
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 08:16:46 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id o70so17671921yba.7
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 08:16:46 -0700 (PDT)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr1766786ybs.380.1667315806284; Tue, 01
 Nov 2022 08:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUsfc-NNHswtS8jjhWFwk4fX2yvynKh4q0x_u01bnUQBA@mail.gmail.com>
 <20221101123035.xkytwxrhrkhjadc3@meerkat.local> <20221101151339.rhp6hys6vnxm4skj@nitro.local>
In-Reply-To: <20221101151339.rhp6hys6vnxm4skj@nitro.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Nov 2022 16:16:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWS-uK63y1D1qGPOvUbrSuhUnAgiCW+RdChP4xKN67OmA@mail.gmail.com>
Message-ID: <CAMuHMdWS-uK63y1D1qGPOvUbrSuhUnAgiCW+RdChP4xKN67OmA@mail.gmail.com>
Subject: Re: b4 ignoring Reviewed-by: in quoted-printable email
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     tools@linux.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Konstantin,

On Tue, Nov 1, 2022 at 4:13 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> On Tue, Nov 01, 2022 at 08:30:35AM -0400, Konstantin Ryabitsev wrote:
> > It's actually because that message has a subject that doesn't indicate a
> > follow-up (doesn't have a Re:):
> >
> >     Subject: [PATCH v2] clk: renesas: r9a06g032: Repair grave increment error
> >
> > I'll see if we can recognize this situation, but it's definitely an odd
> > corner-case.
>
> There is a fix for this in master.

Thank you, confirmed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
