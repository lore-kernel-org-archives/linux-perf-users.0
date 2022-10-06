Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBA9C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 19:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJFTgN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 15:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiJFTgM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 15:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61211144C5
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 12:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E35D61A7E
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 19:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E863C433D6;
        Thu,  6 Oct 2022 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665084970;
        bh=aul7StrWb+Rp3kNiFBb1bHSMlPfe45lVR5pYl9vFiVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0xwV1xsseBFM0JCu145gwHub7Wl4Q46Fu0dq3UrqlDxJp9hXSMYm9wOVYlvNWS2T
         15DA7hVCb0HbeS/Mq4akRNgmFwAwkG4D2u7n/Hxprbw7mabWKlpXWt0huNZlhXEyWb
         JC7/UD01py5g5NnMrKZn73uzuvarzWlxybqlZAYycgWSbW+pzSh64XLM7Tn3MxmQq4
         PU7fa2Hqy71GyTloy4l4zmq3E87ICbypZYDUSbaPA3ZxdLAPHxR5BQR/7eIdqSP1ll
         6M7I8pCdv+uV4tJ/im8icJPGglop3cyjd/fE/IngZIEu+FnkidV0xdFyaen7xwxZuW
         o2Eb5Dt3twP+g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 940144062C; Thu,  6 Oct 2022 16:36:07 -0300 (-03)
Date:   Thu, 6 Oct 2022 16:36:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h:
 No such file or directory
Message-ID: <Yz8uJ9gdYOUIuhIL@kernel.org>
References: <20221006142852.mhrgi3r4fvtkircw@altlinux.org>
 <20221006151622.i45co6lioxgheval@altlinux.org>
 <CAP-5=fXqQpcVk+mzPpM9vC=RHTcZvm4Ng14dJ0Uax4kCQ5Qa7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXqQpcVk+mzPpM9vC=RHTcZvm4Ng14dJ0Uax4kCQ5Qa7Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 06, 2022 at 10:20:34AM -0700, Ian Rogers escreveu:
> On Thu, Oct 6, 2022 at 8:16 AM Vitaly Chikunov <vt@altlinux.org> wrote:
> >
> > On Thu, Oct 06, 2022 at 05:28:53PM +0300, Vitaly Chikunov wrote:
> > > I noticed that perf examples do not compile anymore with v6.0 (first on ALT,
> > > but on Fedora is the same). Fedora example for convenience:
> > >
> > >   # dnf install kernel libperf-devel gcc
> > >   # cc /usr/share/doc/libperf/examples/counting.c -lperf
> > >   In file included from /usr/share/doc/libperf/examples/counting.c:8:
> > >   /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No such file or directory
> > >       9 | #include <linux/compiler.h>
> > >       |          ^~~~~~~~~~~~~~~~~~
> > >   compilation terminated.
> >
> > This is introduced in b2f10cd4e805 ("perf cpumap: Fix alignment for
> > masks in event encoding") just (it seems) for `__packed'.
> > I am told that all uapi is using  __attribute__ ((__packed__)) for that.
> >
> > Thanks,
> 
> Thanks for reporting the issue and sorry for the breakage. I'm not a
> dependency/packaging expert. Arnaldo, what should be the next steps
> here?

I guess we should just use '__attribute__ ((__packed__))', as its what
we see when grepping for attribute on /usr/include/linux/

But t his patch seems to simple remove the packed, no? I.e. is that
packed really needed?

- Arnaldo
