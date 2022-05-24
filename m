Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46600C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 May 2022 14:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiEXOdn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 May 2022 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiEXOdm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 May 2022 10:33:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E0166F84
        for <linux-perf-users@vger.kernel.org>; Tue, 24 May 2022 07:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EE3FB818F7
        for <linux-perf-users@vger.kernel.org>; Tue, 24 May 2022 14:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE08FC385AA;
        Tue, 24 May 2022 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653402818;
        bh=uJe7035b21o5k3OU08seVvA/khYOdy/5WhxDrU94Yhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1X7lEiZ+5+Ytk6TWSqOdCZIe+ByLgMFwwY05w1QUQm5oI3nPLvGRlEn4R9/N/Eex
         ggJkKls25fswtNZAD+YCCKjpkRQT7R/YHlmhKUKr8EZwh1R9kS4/hbZNdRToygoRCO
         WKGbpIucDSnjQBaJYyj4TZUZJ7tQGf6R2eJMz+c+6sp9Gq9v4yGieLHd3nyS2uVxtK
         OUphRla9UWf1aBqxuTcbaf7AMFjA8ANYjeIzY896c9RGHHfLK9oxILZaQbjCa4KAtk
         1YJDbL2wR1+j5mDNfkw9jjCWP7oTfuorRiRRX3I5fnqdNCGWdpImpb1j4jOQ+mhV/L
         HqJH92iFhPg/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BA2C4007E; Tue, 24 May 2022 11:33:35 -0300 (-03)
Date:   Tue, 24 May 2022 11:33:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        vasily Gorbik <gor@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: perf test case 40 LLVM search and compile runs endless (eBPF
 linkage issue)
Message-ID: <Yozsvxx0JsTbVgW1@kernel.org>
References: <bac4efca-c61e-5f62-daa1-f508b64d6a7f@linux.ibm.com>
 <YotrewGfs8c2sXfV@krava>
 <YozLKby7ITEtchC9@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YozLKby7ITEtchC9@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, May 24, 2022 at 02:10:17PM +0200, Jiri Olsa escreveu:
> On Mon, May 23, 2022 at 01:09:51PM +0200, Jiri Olsa wrote:
> > On Mon, May 23, 2022 at 12:52:06PM +0200, Thomas Richter wrote:
> > > On s390 the test case 40 'LLVM search and compile' runs for ever:
> > > 
> > >   # date; timeout 30s perf test -F 40; date
> > >   Mon May 23 12:35:48 PM CEST 2022
> > >    40: LLVM search and compile   :
> > >    40.1: Basic BPF llvm compile  :
> > >   Mon May 23 12:36:18 PM CEST 2022
> > >   #
> > > 
> > > Investigation by Ilya Leoshkevich revealed:
> > > On s390 we hit an endless loop where bpf_object__next_program and bpf_program__next 
> > > infinitely call each other. We tracked this down to ld.so preferring the perf's 
> > > bpf_object__next_program weak copy over the libbpf's strong one.
> > > 
> > > This is introduced with commit 2a4898fc264a ("perf tools: Add more weak libbpf functions")
> > > 
> > > Also see discussion in 
> > > https://lore.kernel.org/lkml/YY%2FAR2Dcaws0BAE9@kernel.org/
> > > 
> > > How can this be fixed asap? Thanks a lot.
> > 
> > I was just suggesting to remove that:
> >   https://lore.kernel.org/bpf/Yos8hq3NmBwemoJw@krava/T/#mda8abccbf475b99d25abe5498a5df1af2da82ee8
> > 
> > it's no longer needed and can cause problem apparently
> 
> after discussing with Arnaldo we decided to go for another fix,
> could you please try this branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/weak

I'm adding comments, testing and applying that series in my local tree,
so far so good, will push to tmp.perf/core later.

Please let us know if you guys looked at the patches in Jiri's perf/weak
branch and if you are ok with it so that I can add
Tested-by/acked-by/reviewed-by, which are always more than welcome.

Thanks,

- Arnaldo
