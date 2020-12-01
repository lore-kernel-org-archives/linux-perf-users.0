Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9639C64E7A
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 03:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6595520657
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 03:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmY6e5c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbgLADsz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 22:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbgLADsz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Nov 2020 22:48:55 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E70EC0613D4
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Nov 2020 19:48:15 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w16so391532pga.9
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Nov 2020 19:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Wokl3NuLwiPSjcjDBebQ10YZQViNxd9/jLnYLLUJ4w=;
        b=bmY6e5c6D0pEK/SJMeJjjoIGXBMsLtWz5HSLHfIwz70h+FuTx40QIWsTWllkNTSpKI
         Ul1aWvkDqBgCcNiBQZa/QMqWpmVAseeFwHgSGxakmW+5WNf5Kj5AwwmWCjW9nhd7veSf
         XiPK101JvU+pJspdxHQPhFoi87bY9srzYs1dCEMgc1ODewBWd4+H4wpTBuIbi1hDffd/
         JIJtvSO6zhqYGH6u+uTq09drhC7TZvH9FG2WQcQzNGKJI/foAu/idYksAuFI8cc2NJXu
         mmoxLspqh6UP7G8YCdc2ankNaoDjCq6cj9AWbmyAk97DUpc6bIC9S/aP3jV9O/8vurKT
         xjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Wokl3NuLwiPSjcjDBebQ10YZQViNxd9/jLnYLLUJ4w=;
        b=l7ykVmgAZ0CDEaZnDLgYzzlL7LjTo927wXa7yHgmI13g/lPJEYSDrfkk8arCziPLOy
         RLB8kC9RirJFtEbuWffvPi8dyENOKk7sTPn1Wohz5p3JlOTrZ6YDRuQmH8za+24mDeYs
         i4Wlwv+hvZ3ZMSY6By+V79GczsocNbHN6oiBBP+o0w8RvpV7ILQ3mBjatn5OmgMRbsXp
         CeCnSxNRrIJfhpyDnVSl0I3Xzz3eIhccJUPXRcZQ16Q1qMkbTYLkML7h09BJHuOf+jwg
         2fmxVMtBGnV02ef3PxXFQfa7CKLwYL3KEO9AEl48X+3+0hw+1TvMuS93nhkw0Vp1HOf5
         Y8pA==
X-Gm-Message-State: AOAM531AM36MSBu/UVZp1vepe6No+eMVh+WaxWvlTMsliO9dqfhP8Q64
        ep+/6gIEBQmCsT0f4xhRcp6Bvg==
X-Google-Smtp-Source: ABdhPJxSrMgRY0rvRLn2C3maAHsCO7hWoJE8yYcpGzeZA5VKxfhfOi/ePTUi28fcw+w0Ehf4c3jfPg==
X-Received: by 2002:a63:6882:: with SMTP id d124mr544352pgc.197.1606794492799;
        Mon, 30 Nov 2020 19:48:12 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id g26sm529243pfo.57.2020.11.30.19.48.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Nov 2020 19:48:12 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:48:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Alexandre Truong <alexandre.truong@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        james.clark@arm.com, John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] perf tools: add aarch64 registers to --user-regs
Message-ID: <20201201034806.GB28939@leoy-ThinkPad-X240s>
References: <20201127153923.26717-1-alexandre.truong@arm.com>
 <20201201034627.GA28939@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201034627.GA28939@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


Correct for Will's email address, sorry for spamming.

On Tue, Dec 01, 2020 at 11:46:27AM +0800, Leo Yan wrote:
> On Fri, Nov 27, 2020 at 03:39:23PM +0000, Alexandre Truong wrote:
> > Previously, this command returns no help message on aarch64:
> > 
> >   -> ./perf record --user-regs=?
> > 
> >   available registers:
> >   Usage: perf record [<options>] [<command>]
> >       or: perf record [<options>] -- <command> [<options>]
> > 
> > With this change, the registers are listed.
> > 
> >   -> ./perf record --user-regs=?
> > 
> >   available registers: x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 lr sp pc
> > 
> > It's also now possible to record subsets of registers on aarch64:
> > 
> >   -> ./perf record --user-regs=x4,x5 ls
> >   -> ./perf report --dump-raw-trace
> > 
> >   12801163749305260 0xc70 [0x40]: PERF_RECORD_SAMPLE(IP, 0x2): 51956/51956: 0xffffaa6571f0 period: 145785 addr: 0
> >   ... user regs: mask 0x30 ABI 64-bit
> >   .... x4    0x000000000000006c
> >   .... x5    0x0000001001000001
> >    ... thread: ls:51956
> >     ...... dso: /usr/lib64/ld-2.17.so
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> Except this patch for enabling registers on aarch64, it's good to add
> arm32's version in the file arch/arm/util/perf_regs.c.
> 
> Just note for a side topic, I checked a bit for the implementation for
> x86/powerpc, you could consider to enable Statically Defined Tracing
> in the perf_regs.c file as well.  This can be separate task for
> arm/arm64.
> 
> Thanks,
> Leo
> 
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
> > ---
> >  tools/perf/arch/arm64/util/perf_regs.c | 33 ++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
> > index 2833e101a..54efa12fd 100644
> > --- a/tools/perf/arch/arm64/util/perf_regs.c
> > +++ b/tools/perf/arch/arm64/util/perf_regs.c
> > @@ -2,5 +2,38 @@
> >  #include "../../../util/perf_regs.h"
> >  
> >  const struct sample_reg sample_reg_masks[] = {
> > +	SMPL_REG(x0, PERF_REG_ARM64_X0),
> > +	SMPL_REG(x1, PERF_REG_ARM64_X1),
> > +	SMPL_REG(x2, PERF_REG_ARM64_X2),
> > +	SMPL_REG(x3, PERF_REG_ARM64_X3),
> > +	SMPL_REG(x4, PERF_REG_ARM64_X4),
> > +	SMPL_REG(x5, PERF_REG_ARM64_X5),
> > +	SMPL_REG(x6, PERF_REG_ARM64_X6),
> > +	SMPL_REG(x7, PERF_REG_ARM64_X7),
> > +	SMPL_REG(x8, PERF_REG_ARM64_X8),
> > +	SMPL_REG(x9, PERF_REG_ARM64_X9),
> > +	SMPL_REG(x10, PERF_REG_ARM64_X10),
> > +	SMPL_REG(x11, PERF_REG_ARM64_X11),
> > +	SMPL_REG(x12, PERF_REG_ARM64_X12),
> > +	SMPL_REG(x13, PERF_REG_ARM64_X13),
> > +	SMPL_REG(x14, PERF_REG_ARM64_X14),
> > +	SMPL_REG(x15, PERF_REG_ARM64_X15),
> > +	SMPL_REG(x16, PERF_REG_ARM64_X16),
> > +	SMPL_REG(x17, PERF_REG_ARM64_X17),
> > +	SMPL_REG(x18, PERF_REG_ARM64_X18),
> > +	SMPL_REG(x19, PERF_REG_ARM64_X19),
> > +	SMPL_REG(x20, PERF_REG_ARM64_X20),
> > +	SMPL_REG(x21, PERF_REG_ARM64_X21),
> > +	SMPL_REG(x22, PERF_REG_ARM64_X22),
> > +	SMPL_REG(x23, PERF_REG_ARM64_X23),
> > +	SMPL_REG(x24, PERF_REG_ARM64_X24),
> > +	SMPL_REG(x25, PERF_REG_ARM64_X25),
> > +	SMPL_REG(x26, PERF_REG_ARM64_X26),
> > +	SMPL_REG(x27, PERF_REG_ARM64_X27),
> > +	SMPL_REG(x28, PERF_REG_ARM64_X28),
> > +	SMPL_REG(x29, PERF_REG_ARM64_X29),
> > +	SMPL_REG(lr, PERF_REG_ARM64_LR),
> > +	SMPL_REG(sp, PERF_REG_ARM64_SP),
> > +	SMPL_REG(pc, PERF_REG_ARM64_PC),
> >  	SMPL_REG_END
> >  };
> > -- 
> > 2.23.0
> > 
