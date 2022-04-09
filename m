Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC04C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  9 Apr 2022 15:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiDIPlM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 9 Apr 2022 11:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbiDIPlL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 9 Apr 2022 11:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD78F9A0
        for <linux-perf-users@vger.kernel.org>; Sat,  9 Apr 2022 08:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53DAD60B1B
        for <linux-perf-users@vger.kernel.org>; Sat,  9 Apr 2022 15:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FECC385A4;
        Sat,  9 Apr 2022 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649518743;
        bh=H2s7g3yfAeIXcNaVW+MWwNNRD5YQpmxQ2lT62/S96Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0fKB0eXORywg7sLdZAJanMb+c3M86ZHmQpNKIq0IjT0W8BBGKbgJjKQ6E2H8PHqx
         i7sdWVm3aQIhBeGKmWBgdBitgHilVYFGP0jNiEpJEwsp6gXZBgFKgxSSleOI+Tw0aS
         02dGPZcuxBFI1rvIb3H+160zXBvdv8ZDCqTRWr63zLlE9CoAZRt2bYXV/omA227Ns8
         i8Ax4w599srT9jSzdIjBljqQL4KNanqjpaf9a5IfzORneIoy3z48QIKBtClsDDFwlo
         jsXSTtJuaUH46jrROVqSA0x024IOvKgW1e7jc1IBQHqgAQD0xsvwaehDTKk9HGfaMd
         uhmi1C6qIkvYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C94F240407; Sat,  9 Apr 2022 12:39:00 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:39:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, acme@redhat.com, jolsa@kernel.org
Subject: Re: [PATCH 1/2] perf docs: Add perf-iostat link to manpages
Message-ID: <YlGolJB0r1vZy3F1@kernel.org>
References: <20220404221541.30312-1-mpetlan@redhat.com>
 <CAP-5=fVUs0rtEWsym4Sw7t83COvdOUFqGYi30_qX4zA=TMzJog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVUs0rtEWsym4Sw7t83COvdOUFqGYi30_qX4zA=TMzJog@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Apr 05, 2022 at 01:53:59PM -0700, Ian Rogers escreveu:
> On Mon, Apr 4, 2022 at 3:59 PM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/Documentation/perf.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> > index 9c330cdfa973..71ebdf8125de 100644
> > --- a/tools/perf/Documentation/perf.txt
> > +++ b/tools/perf/Documentation/perf.txt
> > @@ -83,7 +83,7 @@ linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
> >  linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
> >  linkperf:perf-evlist[1], linkperf:perf-ftrace[1],
> >  linkperf:perf-help[1], linkperf:perf-inject[1],
> > -linkperf:perf-intel-pt[1], linkperf:perf-kallsyms[1],
> > +linkperf:perf-intel-pt[1], linkperf:perf-iostat[1], linkperf:perf-kallsyms[1],
> >  linkperf:perf-kmem[1], linkperf:perf-kvm[1], linkperf:perf-lock[1],
> >  linkperf:perf-mem[1], linkperf:perf-probe[1], linkperf:perf-sched[1],
> >  linkperf:perf-script[1], linkperf:perf-test[1],
> > --
> > 2.18.4
> >

-- 

- Arnaldo
