Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC10C47089
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 16:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F0D6113D
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 16:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhE0Q21 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 12:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235589AbhE0Q21 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 12:28:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4E346100C;
        Thu, 27 May 2021 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622132813;
        bh=6yMbrF+OTPauQf1W+8cY34/65ezovBZNW8a6Zi9Ji4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwI74TETjlVVnaZOrDweNtb+9uRx0I/avnHxkzJoT1rHHMNerlej2e4eTfzG1CZzi
         xD7b0HYMOO+moYEGvL660CrPm3LA7DyQPbQZct1xrC+zPSTvBHpJ/zs9SIgibVVcft
         wIk5QiSa1LX+QJCaiYCsRxYTnCazP0vYlp4PFb/pgnhDLAmErSz2k+Uf8OFKW3xPzm
         p4PGeY6aRm+1bCbVHI+U0KB+KqX/bWmufsOgIg8RSax8nTv49K3IqioHE5oZqUiUjV
         M2onma0lPY+q4FUo0mWeaO1+WAknrz+/S261P1qleEJuE2nB0fEI4YWXCT7/Z7q2jn
         7g+lUdRmGfoHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A8154011C; Thu, 27 May 2021 13:26:51 -0300 (-03)
Date:   Thu, 27 May 2021 13:26:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test: Test 2 libpfm4 error cases
Message-ID: <YK/IS9cQeSuZT4cK@kernel.org>
References: <20210519151213.2643570-1-irogers@google.com>
 <CAP-5=fXpibzr2Vdzy4RHPVzQbSAOLimpHeuVY_L_YsXDy-2_1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXpibzr2Vdzy4RHPVzQbSAOLimpHeuVY_L_YsXDy-2_1Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, May 27, 2021 at 08:52:14AM -0700, Ian Rogers escreveu:
> On Wed, May 19, 2021 at 8:12 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Proposed in:
> > https://lore.kernel.org/lkml/20210517140931.2559364-1-tmricht@linux.ibm.com/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Thanks, applied.

- Arnaldo

 
> Thanks!
> Ian
> 
> > ---
> >  tools/perf/tests/pfm.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
> > index d4b0ef74defc..acd50944f6af 100644
> > --- a/tools/perf/tests/pfm.c
> > +++ b/tools/perf/tests/pfm.c
> > @@ -155,6 +155,16 @@ static int test__pfm_group(void)
> >                         .nr_events = 3,
> >                         .nr_groups = 1,
> >                 },
> > +               {
> > +                       .events = "instructions}",
> > +                       .nr_events = 1,
> > +                       .nr_groups = 0,
> > +               },
> > +               {
> > +                       .events = "{{instructions}}",
> > +                       .nr_events = 0,
> > +                       .nr_groups = 0,
> > +               },
> >         };
> >
> >         for (i = 0; i < ARRAY_SIZE(table); i++) {
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >

-- 

- Arnaldo
