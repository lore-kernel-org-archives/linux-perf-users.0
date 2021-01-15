Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D10C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C315F23877
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbhAOTsj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:48:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388013AbhAOTse (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Jan 2021 14:48:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7780A235F8;
        Fri, 15 Jan 2021 19:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610740073;
        bh=kqOX2A6clD03b+iOOz6xMw7OmOeGpcJteFQPhqT9lQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMyKbvItthsILbBBWKw0oYrZpM/KH51mosprqBA/ZTujmQj85Mhwz7lWwlfWhV6zF
         nDb97DRlUGpsm6NlAMgg6lAExsL164P18GyGJFsJPma5jPLYpIryxxX4xGBWEQAJJJ
         E8fJ+T53DSuR3tyA+NM+RQxPOHMdXdOBfzt+wp7HSvDvsdofsHsn45xfjsa3c/A2k3
         psF8Yz20GBOT/mwiPZePAwfhs2oxujQpu/L8J66Fcc0Nfj1wb4KzbJTS9h7MPXyhoU
         hnyray3pz011CjJDOZUozIqfssA4hdVr9m2TT5cR/tL4NZ9VbDStgztl5Tmcl1vVeg
         cwg07X7yPmL2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E05D40522; Fri, 15 Jan 2021 16:48:25 -0300 (-03)
Date:   Fri, 15 Jan 2021 16:48:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Denis Nikitin <denik@chromium.org>,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        al.grant@arm.com, al.grant@foss.arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject: correct event attribute sizes
Message-ID: <20210115194825.GL457607@kernel.org>
References: <20201124195818.30603-1-al.grant@arm.com>
 <20201216065816.1840893-1-denik@chromium.org>
 <20201223221105.GA236568@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223221105.GA236568@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Dec 23, 2020 at 11:11:05PM +0100, Jiri Olsa escreveu:
> On Tue, Dec 15, 2020 at 10:58:16PM -0800, Denis Nikitin wrote:
> > When perf inject reads a perf.data file from an older version of perf,
> > it writes event attributes into the output with the original size field,
> > but lays them out as if they had the size currently used. Readers see
> > a corrupt file. Update the size field to match the layout.
> > 
> > Signed-off-by: Al Grant <al.grant@foss.arm.com>
> > Signed-off-by: Denis Nikitin <denik@chromium.org>
> > ---
> >  tools/perf/util/header.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index be850e9f8852..0d95981df8dd 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -3331,6 +3331,14 @@ int perf_session__write_header(struct perf_session *session,
> >  	attr_offset = lseek(ff.fd, 0, SEEK_CUR);
> >  
> >  	evlist__for_each_entry(evlist, evsel) {
> > +		if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
> > +			/*
> > +			 * We are likely in "perf inject" and have read
> > +			 * from an older file. Update attr size so that
> > +			 * reader gets the right offset to the ids.
> > +			 */
> > +			evsel->core.attr.size = sizeof(evsel->core.attr);
> > +		}
> 
> seems ok, just wondering if it would be better
> to fix it in perf_event__process_attr instead
> 
> where we know where the data is coming from,
> here we could cover for some unexpected case
> of having different attr.size?
> 
> anyway both would be probably equal, I'm ok
> with either way
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

