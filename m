Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFD9C46467
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Jan 2023 13:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjAKNRj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Jan 2023 08:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjAKNRc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Jan 2023 08:17:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52081AA1C
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jan 2023 05:17:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93AE5B81BDE
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jan 2023 13:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D76C433D2;
        Wed, 11 Jan 2023 13:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443047;
        bh=60gIQMYvFe3Fc0IWjiCAxr+C6fShjYaz5c0/QjpIZQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FeFgxn0L7fM02KPNVsFkXBFh1nMkO7M5IXdmpRAUh2EcHUkbHq+Eq3kI4b9yJ19AB
         za0kOPU+UDUHcgCyoiLLM8ilnTTGxD4bgQKG4dNandCPPyVrgtXex/vDJ8qNfXwUOB
         VUiwK2LzU1nqiktfMA203ck0YyQqYzap+AtKEd4idzKwky7ZPHMk7xKh1Vdw7KojRa
         avLJCumSYdWFc37ITGC1bI+nYltEZz4jhW7tFD03l7pra6un/NvXOTeOhtqquCg0Sd
         13pqcOwGu2awu8qVJ00JZXkhke7I+7iAbXGyPsMcVUsEALEgxye+LRhi998lFZgpH9
         LKr8hSNPwKy7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 03C7B40468; Wed, 11 Jan 2023 10:17:24 -0300 (-03)
Date:   Wed, 11 Jan 2023 10:17:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, mingo@redhat.com,
        jolsa@kernel.org, irogers@google.com
Subject: Re: [RFC PATCH v1] perf record: Correct address filters for
 duplicated symbols
Message-ID: <Y7625DUhEE+NUfWh@kernel.org>
References: <20230106203751.403270-1-9erthalion6@gmail.com>
 <aad6782c-fb30-ba39-ba59-775c5f227d56@intel.com>
 <20230110104848.hty4upem76lkxj2y@ddolgov.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110104848.hty4upem76lkxj2y@ddolgov.remote.csb>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jan 10, 2023 at 11:48:48AM +0100, Dmitry Dolgov escreveu:
> > On Mon, Jan 09, 2023 at 09:02:02AM +0200, Adrian Hunter wrote:
> > On 6/01/23 22:37, Dmitrii Dolgov wrote:
> > > It seems the logic to handle duplicated symbols is off. In case if the
> > > symbol index is specified it will:
> > >
> > > * find a match
> > > * continue searching
> > > * check that start is not null and idx is set on the next loop
> > > * exit with the error code 1
> > >
> > > My guess is the expectation was that at this point the second match is
> > > found (because *start is not null), although the new symbol hasn't pass
> > > dso_sym_match yet. Here is how it looks like:
> >
> > If *start && idx > 0 there is no need to match anymore.  The
> > code is just getting *size.  Looks to me like it should be:
> >
> > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > index 265d20cc126b..c2e323cd7d49 100644
> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -2611,7 +2611,7 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
> >  				*size = sym->start - *start;
> >  			if (idx > 0) {
> >  				if (*size)
> > -					return 1;
> > +					return 0;
> >  			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
> >  				print_duplicate_syms(dso, sym_name);
> >  				return -EINVAL;
> 
> Yes, if there was no intention to continue searching symbols, this would
> work as well. Just in case I have verified this on my test, everything
> is fine. Would you send a patch for that?

So I'll take this as a:

Tested-by: Dmitry Dolgov <9erthalion6@gmail.com>

Ok?

- Arnaldo
