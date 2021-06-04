Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE32C4743C
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 19:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508116140C
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 19:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhFDT1g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 15:27:36 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:43689 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhFDT1f (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 15:27:35 -0400
Received: by mail-il1-f177.google.com with SMTP id x18so9874729ila.10
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Jun 2021 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3arXY3Iq0Fx3qKjwqpP6enbStCHFC2viArbJLk+gG4=;
        b=KL8HzrlALh6cM6GjOSSchK4iJtooFOlCyIW+t+cN/hfUCT3crtKc5d+nn+U4oJ85C7
         6cPt8MdIJgVcdCbheM2RstyYaQRazt0+1HBK5krcnQ3JXz1qjZlKvc3InCwq8ewndo7H
         Ju0fm9u9B97rgmc3e3b6XO5DT0kLdyIXwFGpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3arXY3Iq0Fx3qKjwqpP6enbStCHFC2viArbJLk+gG4=;
        b=B7VMxaOeog+3wgGe1q6fHz4WW8TnzhjPlBuLOUsxgDU8XPDvI4aYD2cx6bIKiYwRRW
         2DaiHjGGjswxV3I68S6pdJzlBLKKkwEo6w6tnZVLwAkPTIKNRHvNnZgD2vjYR+QywF3y
         WMNXRGlwr59r+7WdfxcVDtrtCSC/mNYHg1GgxOxkH2qRLviA4gWwdvPGput6YwjjNXku
         e5QWiYBEhPh1bNWLtGz0UKTP6GBSuFhoUyeyzaghp84Maga048jxPi+7uJOMbSoTMMGw
         xxh9qcBAruEJnX2RPNvAEdsD/ijDpJpJI8erQ7u8Y4GYsB53YQDN9dhbaLPgmHZj/Vpu
         FOtA==
X-Gm-Message-State: AOAM531FATPa0K+ZlD9uoM9eXLv0N5+6whjN9kLXpWMw7l6c8kQ+/agm
        Iiz7P2tlvHB/DIX2XRsyptbnbXjKCaX2dw==
X-Google-Smtp-Source: ABdhPJy+Et4P47+hOI7X1OX1JkQgbEiVe0VtHtT9vnPgaMpct1qZSh3gH0vjMNDiqw+DDjJHBuPvSg==
X-Received: by 2002:a92:50b:: with SMTP id q11mr5356000ile.119.1622834675138;
        Fri, 04 Jun 2021 12:24:35 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id q11sm3893663ilj.80.2021.06.04.12.24.34
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 12:24:34 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id v13so9844939ilh.13
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Jun 2021 12:24:34 -0700 (PDT)
X-Received: by 2002:a05:6e02:de9:: with SMTP id m9mr5380481ilj.89.1622834673935;
 Fri, 04 Jun 2021 12:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210604092638.985694-1-ribalda@chromium.org> <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
In-Reply-To: <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 4 Jun 2021 21:24:23 +0200
X-Gmail-Original-Message-ID: <CANiDSCu4Brz7FZX5oa57kNLG9h_1EASX=bdQij4+apg0ZwW8QA@mail.gmail.com>
Message-ID: <CANiDSCu4Brz7FZX5oa57kNLG9h_1EASX=bdQij4+apg0ZwW8QA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Do not set a variable unless it will be used
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Peter

On Fri, 4 Jun 2021 at 11:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 04, 2021 at 11:26:38AM +0200, Ricardo Ribalda wrote:
> > clang-13 triggers the following warning:
> >
> > bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-variable]
> >         u64 len = 0;
> >
> > This patch sets the value to len only if it will be used afterwards.
>
> My vote would be to kill that warning, what absolute shite.

My knowledge of llvm codebase is close to NULL, so it is much easier
for me to "fix" the code.

I would assume that the static analyser has found a magic condition
where the previous if always returns false, and has managed to
"optimize" the code.





-- 
Ricardo Ribalda
