Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF65C433B4
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 May 2021 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D3F6141E
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 May 2021 15:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhEHPQz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 8 May 2021 11:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhEHPQy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 8 May 2021 11:16:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3969F6141D;
        Sat,  8 May 2021 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620486953;
        bh=Sgq70qU/onynKPpWMpEi2Z7PKmV25AfeplhuLwk1LM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOli2pVOIo5aByrJNtI/blSsYE14nBNMJ1M7nVXjfvjNfOuAWzdcrQ+qrX28rcvMa
         uKZeQv5N+W9FXYwGxkHPcgwmAMbBv80yucSowuLps1khomqIjGcuw2BSIJ2neV7wRS
         6WSIRVR5YFb9n6QOVzLVITsDq68mFboVwMpAAFVLFOQ1v73pdyT2EXzm/34MVWAFn0
         3TFny9vremhxcuTA7F3fTZmIwzeIZwl8EHv9JqNH53mBZ9J85SYG4jF7NJfgWFkocw
         xo97lgQIT7HLAcPiVxQNYgpWGEMF+2uLKhz9lD003UtwJ4FxRtKRIEYfnax8HXxcjf
         el1hwJ9qGnMnw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A30F34034C; Sat,  8 May 2021 12:15:49 -0300 (-03)
Date:   Sat, 8 May 2021 12:15:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Dmitry Koshelev <karaghiozis@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Fix swapping of cpu_map and stat_config records
Message-ID: <YJarJWbjlhizmt5A@kernel.org>
References: <20210506131244.13328-1-karaghiozis@gmail.com>
 <YJPv2u6NBuYX9FUX@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJPv2u6NBuYX9FUX@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, May 06, 2021 at 03:32:10PM +0200, Jiri Olsa escreveu:
> On Thu, May 06, 2021 at 01:11:49PM +0000, Dmitry Koshelev wrote:
> > 'data' field in perf_record_cpu_map_data struct is 16-bit
> > wide and so should be swapped using bswap_16().
> > 
> > 'nr' field in perf_record_stat_config struct should be
> > swapped before being used for size calculation.
> > 
> > Signed-off-by: Dmitry Koshelev <karaghiozis@gmail.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/session.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index a12cf4f0e97a..106b3d60881a 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -904,7 +904,7 @@ static void perf_event__cpu_map_swap(union perf_event *event,
> >  	struct perf_record_record_cpu_map *mask;
> >  	unsigned i;
> >  
> > -	data->type = bswap_64(data->type);
> > +	data->type = bswap_16(data->type);
> >  
> >  	switch (data->type) {
> >  	case PERF_CPU_MAP__CPUS:
> > @@ -937,7 +937,7 @@ static void perf_event__stat_config_swap(union perf_event *event,
> >  {
> >  	u64 size;
> >  
> > -	size  = event->stat_config.nr * sizeof(event->stat_config.data[0]);
> > +	size  = bswap_64(event->stat_config.nr) * sizeof(event->stat_config.data[0]);
> >  	size += 1; /* nr item itself */
> >  	mem_bswap_64(&event->stat_config.nr, size);
> >  }
> > -- 
> > 2.25.1
> > 
> 

-- 

- Arnaldo
