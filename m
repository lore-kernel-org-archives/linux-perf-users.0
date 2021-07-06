Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB153C07E96
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 05:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2BE61988
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 05:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhGFFyb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 01:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhGFFyb (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 01:54:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5199E613D1;
        Tue,  6 Jul 2021 05:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625550713;
        bh=kQBDeqlMwObvMp1z1vQobCZU96+C9HkHnrkJ4+98krI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NloMr11/8Yug7Objch3jeHZ+/XtB/s2GnywZvjCpw3vcRlXCVJ2OLsW9PqBqtDHsI
         6mgCgS+kVJ4mZFRip8dVcRMJx5DfZ6PburDfN1kO5xZmuo1B3xDrBlI3sZ3E3pJHzu
         wOhEB74e8VQU7jqi8kZQX5UH+eA2SjiPZR+0pMhYxVPS7LimqylAFBXI4pynhFc2PD
         3KVI5Y7NeA7dLf2845hWj6HGUyN9OSppIGPrt7SSAiHOvUwSGQEroJlbZy+G1EVZR0
         ygsRtYgMKncTCLwWlWsMYmcKqLcxMJpcprgKeAOO7ZCTzNtKOUh1EpZhABlyLRA3y7
         7BHNleg4c2/Fg==
Date:   Tue, 6 Jul 2021 14:51:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] perf: Fix perf probe for Fedora34 glibc update
Message-Id: <20210706145150.44130059496442b735962ab2@kernel.org>
In-Reply-To: <CAM9d7cj2H75byaNH-n4XeKbMu30j6_P3TAPwpoE9R1LXVTTSwQ@mail.gmail.com>
References: <162532651032.393143.4602033845482295575.stgit@devnote2>
        <CAM9d7cj2H75byaNH-n4XeKbMu30j6_P3TAPwpoE9R1LXVTTSwQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 5 Jul 2021 13:48:04 -0700
Namhyung Kim <namhyung@gmail.com> wrote:

> On Sat, Jul 3, 2021 at 8:36 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Arnaldo,
> >
> > Here is a series of patches to fix the perf-probe error against the
> > Fedora34 glibc update, which moves most of symbols from .symtab to
> > .dynsym. The key is that the "most of" symbols moved, but it still
> > have some PLT symbols in .symtab. Thus the perf symbol-elf failes to
> > decode symbols.
> 
> Do you know what's the rationale of the move?
> Is it a change from glibc or Fedora?

I don't know, but it seems that this happens when updating glibc package,
the version is same but revision is different. Also, in the Ubuntu, I saw
all symbols has been moved to .dynsym in older glibc.
Thus I guess that this depends on the build option or configuration.
Might Fedora change the packaging script?

Thank you,

> 
> Thanks,
> Namhyung
> 
> 
> >
> > Here is the original report from Thomas about this issue.
> >
> >  https://lore.kernel.org/linux-perf-users/f6752514-eaf9-371e-f81b-0d9e41ebae0c@linux.ibm.com/
> >
> > Thank you,
> >
> > ---
> >
> > Masami Hiramatsu (3):
> >       perf-probe: Fix debuginfo__new() to enable build-id based debuginfo
> >       perf symbol-elf: Decode dynsym even if symtab exists
> >       perf probe: Do not show @plt function by default
> >
> >
> >  tools/perf/builtin-probe.c     |    2 -
> >  tools/perf/util/probe-finder.c |    5 ++
> >  tools/perf/util/symbol-elf.c   |   82 ++++++++++++++++++++++++++--------------
> >  3 files changed, 60 insertions(+), 29 deletions(-)
> >
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
