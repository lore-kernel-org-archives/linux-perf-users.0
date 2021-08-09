Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D1C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F87561040
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhHIU2g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233500AbhHIU2g (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 16:28:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26DB36101E;
        Mon,  9 Aug 2021 20:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628540895;
        bh=GZtBG4eVbD+pfnOgxDdLXHWQqpxXh98WNaGc/VD+0es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqM3Dxu0VqOYHIQgS5X7WK06Bz8MJ9XQvR2hdi81N+wwzBy7sD5CNmv7GaNEB7yPG
         2lYOFtBtydzP/hbZHdOkmhlX8fhyz+L1JAhX7yI2GwARmtUyLzkPQdVVhdXdElgMdp
         KS8LyqEA85Z9ImwSrZQQbNehvCmbf5msAoDIEeBIh1le92TGUCHAxrmR2vQvACvE8X
         35uKLdg1/IoNPJk9AXODVtfBcjD2Ks/lqmKGC42giD+t9pAIhx41Shgxuntv3MXV4r
         CBVHMxJYT+63qizkXsfcsdleFOy1XeygSOF2vFgM+XKbaNMJdkbtUz1CJVuVL1TpWu
         AmGG/b1V9RilQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 45CD2403F2; Mon,  9 Aug 2021 17:28:12 -0300 (-03)
Date:   Mon, 9 Aug 2021 17:28:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench: add benchmark for evlist open/close
 operations
Message-ID: <YRGP3DR8f6ZEvn/P@kernel.org>
References: <20210809201101.277594-1-rickyman7@gmail.com>
 <YRGOwx3xlPRxNAXM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRGOwx3xlPRxNAXM@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 09, 2021 at 05:23:31PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Aug 09, 2021 at 10:11:02PM +0200, Riccardo Mancini escreveu:
> > +static struct evlist *bench__create_evlist(char *evstr)
> > +{
> > +	struct evlist *evlist;
> > +	struct parse_events_error err;
> > +	int ret;

> > +	evlist = evlist__new();
> > +	if (!evlist) {
> > +		pr_err("Not enough memory to create evlist\n");
> > +		return NULL;
> > +	}

> > +	bzero(&err, sizeof(err));

> man bzero
> 
>        The bzero() function is deprecated (marked as LEGACY in POSIX.1-2001); use memset(3) in new programs.  POSIX.1-2008 removes the specification of bzero().  The bzero() function first appeared in 4.3BSD.

> I'm replacing it with a memset().

This one is also equivalent:

tools/perf/tests/pmu-events.c:	struct parse_events_error error = { .idx = 0, };

https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html

That text is a bit roundabout, as it says that the members that are not
explicitely initialized will be initialized as variables with static
storage duration, i.e. zeroed.

- Arnaldo
