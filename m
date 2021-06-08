Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D882BC47082
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77A961246
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 12:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhFHMtt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhFHMtt (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 08:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7442960FF4;
        Tue,  8 Jun 2021 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623156476;
        bh=bhSgOLiDaEHajTgk+K80fedzHbAhBAikOd+huyUSHo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VInSooZkuCYeNrnAy/G28Rf+6q0RLHFNM3lDBXvcrRORxIMotGAnJ6DvP2e+L+zoj
         aFv0wwecRoBSwJHpgQmHzR6MhXuVaWMErQAYoOw5/DsIn++o0LGruYt/BoaJjF8BoD
         ptvC0+250JeHcoB6Zto5FHEwHfSQRPC1eTF0rmvcs9sViVTsOXXKdihmZ6wcaniXHN
         lrkP4RX+Rc8eweJoCyGHfZ7HiSxYC6vIU9d+Ut0CK9QeUaTr8BcrNyNR8Cs/U7AE0G
         web3VHcQePWc/l9Jf79+/jK63JTtQd2P9YMzalzYrJAC51g2kTfKSQZKivnI9fbcXv
         juMIvvnesdkew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4623640B1A; Tue,  8 Jun 2021 09:47:54 -0300 (-03)
Date:   Tue, 8 Jun 2021 09:47:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf session: Correct buffer copying when peek event
Message-ID: <YL9m+liygPxoa5bu@kernel.org>
References: <20210605052957.1070720-1-leo.yan@linaro.org>
 <YL9PatslajgTZpZM@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9PatslajgTZpZM@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 08, 2021 at 01:07:22PM +0200, Jiri Olsa escreveu:
> On Sat, Jun 05, 2021 at 01:29:57PM +0800, Leo Yan wrote:
> > When peek an event, it has a short path and a long path.  The short path
> > uses the session pointer "one_mmap_addr" to directly fetch event; and
> > the long path needs to read out the event header and the followed event
> > data from file and fill into the buffer pointer passed through the
> > argument "buf".
> > 
> > The issue is in the long path that it copies the event header and event
> > data into the same destination address which pointer "buf", this means
> > the event header is overwritten.  We are just lucky to run into the
> > short path in most cases, so we don't hit the issue in the long path.
> > 
> > This patch adds the offset "hdr_sz" to the pointer "buf" when copying
> > the event data, so that it can reserve the event header which can be
> > used properly by its caller.
> > 
> > Fixes: 5a52f33adf02 ("perf session: Add perf_session__peek_event()")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/session.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 106b3d60881a..e59242c361ce 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1723,6 +1723,7 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
> >  	if (event->header.size < hdr_sz || event->header.size > buf_sz)
> >  		return -1;
> >  
> > +	buf += hdr_sz;
> 
> nice ;-)
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

