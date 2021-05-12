Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B964C43611
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 15:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C40BA61C20
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 15:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhELP6V (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 May 2021 11:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236952AbhELPre (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 May 2021 11:47:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B35CB615FF;
        Wed, 12 May 2021 15:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620833046;
        bh=jjJSg1UkQ1lgP0jWjsn1+KaxdffEcxoj3ORUXacOc+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFV2oicgTFhsw+OD15BogcbG2+RpacUV7JYmYZhsSOrokhtXiWISAIMlpV0wxEC08
         wJzrgqgm/kyw8TefEg/gww+jNx/MPaoqlr8JPOSYpaVLv6MAoltXLNj6w0nYbQRDvf
         y5BJABiNAio7i4gJ4yRv87FU+pGK59exPNiQCXJRmwMU8syHmcnkGxYnh/li/OALgb
         BhOJPBRj4LYnFebICxpSnkq6V09trHJM6deqN14LXfMGbV1rWjA7/VSutA9Nezw5lJ
         /bN4kh6Z48raCKLSFJGA5lgkarBBZBe3ycL7bgJhgtjFRWH0IoSH8L2LDMYUnQWA/y
         gc/ryxWSQuPng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E3424034C; Wed, 12 May 2021 12:24:03 -0300 (-03)
Date:   Wed, 12 May 2021 12:24:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     acme@redhat.com, alexey.budankov@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kenel.org
Subject: Re: [PATCH] perf buildid-list: Initialize zstd_data
Message-ID: <YJvzE1fE7WRDzw57@kernel.org>
References: <20210429185759.59870-1-milian.wolff@kdab.com>
 <3144693.egzistUG4v@milian-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3144693.egzistUG4v@milian-workstation>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 12, 2021 at 05:14:29PM +0200, Milian Wolff escreveu:
> On Donnerstag, 29. April 2021 20:57:59 CEST Milian Wolff wrote:
> > Fixes segmentation fault when trying to obtain buildid list (e.g. via
> > perf-archive) from a zstd-compressed `perf.data` file:
> 
> Ping, can someone please review and push this upstream? It's such a trivial 
> fix, I would like to see it fixed upstream.

Fell thru the cracks, processing it now.

- Arnaldo
 
> Thanks
> 
> > ```
> >     $ perf record -z ls
> >     ...
> >     [ perf record: Captured and wrote 0,010 MB perf.data, compressed
> > (original 0,001 MB, ratio is 2,190) ] $ memcheck perf buildid-list
> >     ...
> >     ==57268== Invalid read of size 4
> >     ==57268==    at 0x5260D88: ZSTD_decompressStream (in
> > /usr/lib/libzstd.so.1.4.9) ==57268==    by 0x4BB51B: zstd_decompress_stream
> > (zstd.c:100)
> >     ==57268==    by 0x425C6C: perf_session__process_compressed_event
> > (session.c:73) ==57268==    by 0x427450: perf_session__process_user_event
> > (session.c:1631) ==57268==    by 0x42A609: reader__process_events
> > (session.c:2207) ==57268==    by 0x42A609: __perf_session__process_events
> > (session.c:2264) ==57268==    by 0x42A609: perf_session__process_events
> > (session.c:2297) ==57268==    by 0x343A62: perf_session__list_build_ids
> > (builtin-buildid-list.c:88) ==57268==    by 0x343A62: cmd_buildid_list
> > (builtin-buildid-list.c:120) ==57268==    by 0x3C7732: run_builtin
> > (perf.c:313)
> >     ==57268==    by 0x331157: handle_internal_command (perf.c:365)
> >     ==57268==    by 0x331157: run_argv (perf.c:409)
> >     ==57268==    by 0x331157: main (perf.c:539)
> >     ==57268==  Address 0x7470 is not stack'd, malloc'd or (recently) free'd
> > ```
> > 
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > ---
> >  tools/perf/builtin-buildid-list.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-buildid-list.c
> > b/tools/perf/builtin-buildid-list.c index 87f5b1a4a7fa..833405c27dae 100644
> > --- a/tools/perf/builtin-buildid-list.c
> > +++ b/tools/perf/builtin-buildid-list.c
> > @@ -80,6 +80,9 @@ static int perf_session__list_build_ids(bool force, bool
> > with_hits) if (!perf_header__has_feat(&session->header, HEADER_BUILD_ID))
> >  		with_hits = true;
> > 
> > +	if (zstd_init(&(session->zstd_data), 0) < 0)
> > +		pr_warning("Decompression initialization failed. Reported data 
> may be
> > incomplete.\n"); +
> >  	/*
> >  	 * in pipe-mode, the only way to get the buildids is to parse
> >  	 * the record stream. Buildids are stored as RECORD_HEADER_BUILD_ID
> 
> 
> -- 
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts



-- 

- Arnaldo
