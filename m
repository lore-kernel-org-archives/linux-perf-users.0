Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47052C77B73
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jun 2023 14:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjFEOof (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 10:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjFEOoe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jun 2023 10:44:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC419C
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 07:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B6E46181E
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 14:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3B6C433D2;
        Mon,  5 Jun 2023 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685976272;
        bh=P4tmsurHnR8oymLXkCCN1+yzfSSIoKX5T6gyAEC+nAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOw2zhQV9DVeCo+SyrJIs/1PupzXl85bHQXkC53dV00RR9kgvNEvUAhRutOwYc67S
         m4Psn5ErNYwh7+EpOBXK07wKKGtpAjXVkg5MHlXDMvVUlFQThHV3QhiDHExNOHtfSG
         rveNrNZIiJhyouIDmDmD1GMV5i1+D9KIqBAjhFGQuN1ebByxqQfSQOGwroymikiQvD
         Q/r9zEKIURv2u2PGGmOan3i0dHlnLP2HHC4bwO89xr+p+1z9HSQ/k3taIisCiYFixZ
         8NU5/STrqE+z8Nf7sf+sfMgDtIL7O3dY828oEfWAP49w43OPLhF1sqBJUDptK2yGpp
         7OX24EtDxOLSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8995D40692; Mon,  5 Jun 2023 11:44:30 -0300 (-03)
Date:   Mon, 5 Jun 2023 11:44:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH RESEND v3 0/5] perf tools: Modify mksyscalltbl
Message-ID: <ZH30zvFRQabaeq0b@kernel.org>
References: <1685441401-8709-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7EjxoVg_FAV2hTAKjZYJJEeHiDcfo21=z3OYstboSvxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7EjxoVg_FAV2hTAKjZYJJEeHiDcfo21=z3OYstboSvxw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 31, 2023 at 03:58:41PM +0800, Huacai Chen escreveu:
> For the whole series,
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Thanks, added to the patches.

- Arnaldo
 
> On Tue, May 30, 2023 at 6:10 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > I'm sorry, somehow the patchset didn't reach mailing lists.
> > Resending with a fewer people in the cc list, which probably
> > was the reason.
> >
> > Thanks Alexander, Leo and Ian for your reviews and suggestions.
> >
> > v3:
> >   -- Add a new patch to declare syscalltbl_*[] as const for all archs,
> >      suggested by Ian.
> >   -- Add a new patch to use max_nr to define SYSCALLTBL_ARM64_MAX_ID.
> >
> > v2:
> >   -- Add a new patch to rename create_table_from_c()
> >      to create_sc_table(), suggested by Leo.
> >   -- Simplify the shell script, suggested by Alexander.
> >
> > Tiezhu Yang (5):
> >   perf tools: Declare syscalltbl_*[] as const for all archs
> >   perf arm64: Rename create_table_from_c() to create_sc_table()
> >   perf arm64: Handle __NR3264_ prefixed syscall number
> >   perf arm64: Use max_nr to define SYSCALLTBL_ARM64_MAX_ID
> >   perf LoongArch: Simplify mksyscalltbl
> >
> >  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  | 17 ++++-----
> >  .../arch/loongarch/entry/syscalls/mksyscalltbl     | 40 +++++++---------------
> >  tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  2 +-
> >  .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  2 +-
> >  tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  2 +-
> >  tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  2 +-
> >  tools/perf/util/syscalltbl.c                       | 14 ++++----
> >  7 files changed, 32 insertions(+), 47 deletions(-)
> >
> > --
> > 2.1.0
> >
> >

-- 

- Arnaldo
