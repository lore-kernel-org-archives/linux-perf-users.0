Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00818C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CEE61037
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 18:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbhHDSkE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 14:40:04 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60883 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbhHDSkE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Aug 2021 14:40:04 -0400
Received: (Authenticated sender: edwin@etorok.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7DA83E0007;
        Wed,  4 Aug 2021 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etorok.net; s=gm1;
        t=1628102390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psvfep6hWXjTVMEg9R5p4wT51NrNpB1sLwGhQXSzqDw=;
        b=Q7LWz1RD0AdsoypX+h4oLJqh1CCJ6rUYTXtpRTJHCY91sC8a8pcEpcObe/+HgwNL64STSG
        jiom2uGQ+/6ZmfEBL5jJwDI5wMO3h66btC4oXMjDkUDRxqtK4adVL8qHc8SbUgnarGrY4+
        8f/bWrOEEfoO2NEB2ESEHsdGPsUurNZyu5GM7QUlSHKT3HBbDVfamgqPh0leB0tTS1T94t
        wcU+iiaTxYUFaewCSO4p9JlJr3KOem+i9U4d/TvgtytXe38ejCucmB4GH8XepzLzUES8nI
        qlIisyy7t6s1pyM6f9JA0R0MJ1z6hTYuWSNfgbNYjgBi5glxD2SHY2FK4b/qbQ==
Message-ID: <fda2eff99e5727656a8c2de8d77b5d3afe1f336b.camel@etorok.net>
Subject: Re: [PATCH 1/4] tools/perf/arch/riscv: record registers needed for
 --call-graph=dwarf
From:   Edwin =?ISO-8859-1?Q?T=F6r=F6k?= <edwin@etorok.net>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-perf-users@vger.kernel.org
Date:   Wed, 04 Aug 2021 19:39:46 +0100
In-Reply-To: <mhng-3ff979c8-3e24-48a4-8a22-8aa3f14f42ac@palmerdabbelt-glaptop>
References: <mhng-3ff979c8-3e24-48a4-8a22-8aa3f14f42ac@palmerdabbelt-glaptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 2021-08-03 at 21:22 -0700, Palmer Dabbelt wrote:
> On Mon, 05 Jul 2021 16:25:21 PDT (-0700), edwin@etorok.net wrote:
> > For libdw-based callgraph sampling to work we need to sample
> > registers.
> > 
> > Tested on HiFive Unmatched with a trunk version of OCaml:
> 
> These generally LGTM, but I don't have patch #2.

PATCH 2/4 is here:
https://lore.kernel.org/linux-riscv/20210705232524.4024832-3-edwin@etorok.net/
https://patchwork.kernel.org/project/linux-riscv/patch/20210705232524.4024832-3-edwin@etorok.net/

>   Sometimes that means 
> they're just not targeted at the RISC-V tree, which is fine with me but
> I'm happy to take some time to look closer and take them if that's what
> you're looking for.
> A cover letter can be a good bet, to describe this sort of stuff.

Thanks for taking a look, I'll try to ensure that RISC-V maintainers
are CC-ed on the entire series in the future (I used
scripts/get_maintainer.pl which might've been too selective).

All patches should be on the RISC-V mailing list though, cover letter
included:
https://lore.kernel.org/linux-riscv/20210705232524.4024832-1-edwin@etorok.net/T/#t
https://patchwork.kernel.org/project/linux-riscv/list/?series=511107

PATCH 2/4 is patching tools/perf/check-headers.sh, so although
technically outside of the RISC-V specific tree it actually adds one
line to include the riscv headers, so if you could take all 4 patches
into your tree that'd be great.

Thanks,
--Edwin

