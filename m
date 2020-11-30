Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BEDC64E8A
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Nov 2020 17:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C542F206E3
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Nov 2020 17:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXUyAX68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgK3Rme (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 12:42:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgK3Rmd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Nov 2020 12:42:33 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E13206E3;
        Mon, 30 Nov 2020 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606758112;
        bh=9oc09UhZQ+9WG+FlwKiW0WDOYaBxkPTKMA/1Xn5sjh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXUyAX68aWV4Ug2I2fNCAwn2NWdwXHawizNENhyFI27GCX9wS4eMX+bCBardiZBmt
         l59EzfuUWNm185ji2QfiYCSKC7YyfbLMzxgIbFy5I06J6rdKko+0aZ7KFopwGNKJ0E
         eZQEgisJ9+rWDpfAZ686mIKtux4EAdmG+JeYDY6Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F3C84079D; Mon, 30 Nov 2020 14:41:55 -0300 (-03)
Date:   Mon, 30 Nov 2020 14:41:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Alexandre Truong <alexandre.truong@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        james.clark@arm.com, Leo Yan <leo.yan@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] perf tools: add aarch64 registers to --user-regs
Message-ID: <20201130174155.GA49333@kernel.org>
References: <20201127153923.26717-1-alexandre.truong@arm.com>
 <9022edaa-78c5-2397-320a-4ca3d884fced@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9022edaa-78c5-2397-320a-4ca3d884fced@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Nov 30, 2020 at 05:30:12PM +0000, John Garry escreveu:
> On 27/11/2020 15:39, Alexandre Truong wrote:
> > Previously, this command returns no help message on aarch64:
> > 
> >    -> ./perf record --user-regs=?
> > 
> >    available registers:
> >    Usage: perf record [<options>] [<command>]
> >        or: perf record [<options>] -- <command> [<options>]
> > 
> > With this change, the registers are listed.
> > 
> >    -> ./perf record --user-regs=?
> > 
> >    available registers: x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 lr sp pc
> > 
> > It's also now possible to record subsets of registers on aarch64:
> > 
> >    -> ./perf record --user-regs=x4,x5 ls
> >    -> ./perf report --dump-raw-trace
> > 
> >    12801163749305260 0xc70 [0x40]: PERF_RECORD_SAMPLE(IP, 0x2): 51956/51956: 0xffffaa6571f0 period: 145785 addr: 0
> >    ... user regs: mask 0x30 ABI 64-bit
> >    .... x4    0x000000000000006c
> >    .... x5    0x0000001001000001
> >     ... thread: ls:51956
> >      ...... dso: /usr/lib64/ld-2.17.so
> > 
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
> 
> This looks ok, just adding in more guys recorded as reviewers in
> MAINTAINERS.

Taking that "this looks ok" as an Acked-by as per
Documentation/process/submitting-patches.rst/
 
> John
> 
> > ---
> >   tools/perf/arch/arm64/util/perf_regs.c | 33 ++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> > 
> > diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
> > index 2833e101a..54efa12fd 100644
> > --- a/tools/perf/arch/arm64/util/perf_regs.c
> > +++ b/tools/perf/arch/arm64/util/perf_regs.c
> > @@ -2,5 +2,38 @@
> >   #include "../../../util/perf_regs.h"
> >   const struct sample_reg sample_reg_masks[] = {
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
> >   	SMPL_REG_END
> >   };
> > 
> 

-- 

- Arnaldo
