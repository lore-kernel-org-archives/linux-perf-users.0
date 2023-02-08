Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95204C636CC
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Feb 2023 13:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBHNoe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Feb 2023 08:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjBHNoR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Feb 2023 08:44:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7EF31E2F;
        Wed,  8 Feb 2023 05:44:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42390B81E2B;
        Wed,  8 Feb 2023 13:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE161C433EF;
        Wed,  8 Feb 2023 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675863852;
        bh=XuUgXO5PIjvFnjiQGZDTKwl0VJIpvE6BQPW4sAHzzQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTspW9MNsta6f/zz6O+FtNSEsfCw2tZyWRUSuuNwscvJOpjuNFQxVR1vs+24Mfty6
         ISpzoYwK1BG3fAcUqUAEqAq9mSTxOOykX2Fb1SyK68t5XiB7iaAxwT0oKOYQO+ruVv
         FmkoNGPMFNfe0F28AnEoJc8g6wUXy/JX3vxf2MMpLBcn1DyDPEvFlV4cumqwGL/HAw
         fj9pOYCovt/sSM1VyAiHK5nGgnN9pBG2PPRWW8fUCfK8D54DLYIknEgz6saXDC3GaF
         LFoR05pJVZPyZ8hdlwmtAMM7zloZTEbBfBrMRYBUK7w6DcJ3Sf35Vy4daKmZHrR1lp
         HpTn2eqBiQ4Yw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 758E4405BE; Wed,  8 Feb 2023 10:44:10 -0300 (-03)
Date:   Wed, 8 Feb 2023 10:44:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, hca@linux.ibm.com,
        egorenar@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        sumanthk@linux.ibm.com
Subject: Re: [PATCH] tools/perf: Fix perf tool build error in util/pfm.c
Message-ID: <Y+OnKl9wYcbFvHLY@kernel.org>
References: <20230207140447.1827741-1-tmricht@linux.ibm.com>
 <Y+JoGRdML/Ckkwvb@kernel.org>
 <CAP-5=fU6vHFp1YeY9RyAUE_rS5PMECcUWdnMhR-QsMnAN0wy7g@mail.gmail.com>
 <Y+OmaXOdMEM4II57@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+OmaXOdMEM4II57@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Feb 08, 2023 at 10:40:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Feb 07, 2023 at 09:58:48PM -0800, Ian Rogers escreveu:
> > On Tue, Feb 7, 2023 at 7:02 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > Em Tue, Feb 07, 2023 at 03:04:47PM +0100, Thomas Richter escreveu:
> > > > I have downloaded linux-next and build the perf tool using
> > > >
> > > >  # make LIBPFM4=1
> > > >
> > > > to have libpfm4 support built into perf. The build fails:
> > > >
> > > >  # make LIBPFM4=1
> > >
> > > Ian,
> > >
> > >         Can you please take a look? Should we go this way or have some
> > > feature test to check how that function signature should look?
> > >
> > > - Arnaldo
> > 
> > Tested-by: Ian Rogers <irogers@google.com>
> > 
> > Wrt tests, there is make_with_libpfm4 in tools/perf/tests/make.
> 
> I meant if we should support older versions or state that to build with
> libbpf we need to have the version with this new signature.

I see, the signature change wasn't in libpfm, nevermind, testing now.

- Arnaldo
 
> I'll apply and test build it here.
> 
> - Arnaldo
>  
> > Thanks,
> > Ian
> > 
> > > > ....
> > > > INSTALL libbpf_headers
> > > >   CC      util/pfm.o
> > > > util/pfm.c: In function ‘print_libpfm_event’:
> > > > util/pfm.c:189:9: error: too many arguments to function ‘print_cb->print_event’
> > > >   189 |         print_cb->print_event(print_state,
> > > >       |         ^~~~~~~~
> > > > util/pfm.c:220:25: error: too many arguments to function ‘print_cb->print_event’
> > > >   220 |                         print_cb->print_event(print_state,
> > > >
> > > > The build error is caused by
> > > > commit d9dc8874d6ce ("perf pmu-events: Remove now unused event and metric variables")
> > > > which changes the function prototype of
> > > >   struct print_callbacks {
> > > >       ...
> > > >       void (*print_event)(...);  --> last two parameters removed.
> > > >   };
> > > >
> > > > but does not adjust the usage of this function prototype in util/pfm.c.
> > > > In file util/pfm.c function print_event() is still invoked with 13 parameters
> > > > instead of 11. The compile fails.
> > > >
> > > > When I adjust the file util/pfm.c as in this patch, the build works file.
> > > > Please check this patch for correctness, I have just fixed the compile
> > > > issue.
> > > >
> > > > Fixes d9dc8874d6ce ("perf pmu-events: Remove now unused event and metric variables")
> > > > Cc: irogers@google.com
> > > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > > ---
> > > >  tools/perf/util/pfm.c | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> > > > index ac3227ba769c..b59ba825ddc9 100644
> > > > --- a/tools/perf/util/pfm.c
> > > > +++ b/tools/perf/util/pfm.c
> > > > @@ -193,8 +193,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
> > > >                       /*scale_unit=*/NULL,
> > > >                       /*deprecated=*/NULL, "PFM event",
> > > >                       info->desc, /*long_desc=*/NULL,
> > > > -                     /*encoding_desc=*/buf->buf,
> > > > -                     /*metric_name=*/NULL, /*metric_expr=*/NULL);
> > > > +                     /*encoding_desc=*/buf->buf);
> > > >
> > > >       pfm_for_each_event_attr(j, info) {
> > > >               pfm_event_attr_info_t ainfo;
> > > > @@ -224,8 +223,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
> > > >                                       /*scale_unit=*/NULL,
> > > >                                       /*deprecated=*/NULL, "PFM event",
> > > >                                       ainfo.desc, /*long_desc=*/NULL,
> > > > -                                     /*encoding_desc=*/buf->buf,
> > > > -                                     /*metric_name=*/NULL, /*metric_expr=*/NULL);
> > > > +                                     /*encoding_desc=*/buf->buf);
> > > >               }
> > > >       }
> > > >  }
> > > > --
> > > > 2.39.1
> > > >
> > >
> > > --
> > >
> > > - Arnaldo
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
