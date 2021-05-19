Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC21C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 13:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E372161363
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 13:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353637AbhESNao (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 09:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239739AbhESNao (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 09:30:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B1F160FF2;
        Wed, 19 May 2021 13:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621430964;
        bh=JQuIFikX2LB0ssFXoz9KKfQObi9t6NSh4izYf1JqYPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROx8QG94DaNgkkz8Ej/A++v7hVd9fcUYHXMfqjcfmL0wZ+alrDZ2yB3+yPMw2V53z
         4PTXuiiCzu0waWHptWKfgdrYUkGVXyQ3bH44wJgFyUYE/eMT9vZJrsoQesQw5ltCC4
         tZunPFXdVZgq4upcW2Lf3h5X5SpVRz5C7XvrvOIN45vvhoZ6vDZfZGuVe1xJK9U9Ev
         6JE6WottHC9Bu6XV7RK1vvBLAq7F3Wlh9STltRH80TvNZMoxOu2Tx2o+Fk85Gc73y+
         uC1oHJpo12pyN4u19Iu0gZ9xTDafk79NuIErmU2e/shAkfmSRiUICD0D3AoK9e0x3v
         Rwq8bstTBnL5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3655240DC6; Wed, 19 May 2021 10:29:21 -0300 (-03)
Date:   Wed, 19 May 2021 10:29:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>, svens@linux.ibm.com,
        Vasily Gorbik <gor@linux.ibm.com>, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Test libpfm4 support (63) reports error
Message-ID: <YKUSseBM+IW4tphS@kernel.org>
References: <20210517140931.2559364-1-tmricht@linux.ibm.com>
 <CAP-5=fV-2J1rxHAaGv_GwFzY-mAKKogEvQf1A87PUvZxT7wzUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV-2J1rxHAaGv_GwFzY-mAKKogEvQf1A87PUvZxT7wzUQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, May 18, 2021 at 04:30:35PM -0700, Ian Rogers escreveu:
> On Mon, May 17, 2021 at 7:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Compiling perf with make LIBPFM4=1 includes libpfm support and
> > enables test case 63 'Test libpfm4 support'. This test reports an error
> > on all platforms for subtest 63.2 'test groups of --pfm-events'.
> > The reported error message is 'nested event groups not supported'
> 
> The parsing test checks broken and working strings and so errors are
> always going to be reported, but agreed this error is wrong.
> 
> >  # ./perf test -F 63
> >  63: Test libpfm4 support                                            :
> >  63.1: test of individual --pfm-events                               :
> >  Error:
> >  failed to parse event stereolab : event not found
> >  Error:
> >  failed to parse event stereolab,instructions : event not found
> >  Error:
> >  failed to parse event instructions,stereolab : event not found
> >   Ok
> >  63.2: test groups of --pfm-events                                   :
> >  Error:
> >  nested event groups not supported    <------ Error message here
> >  Error:
> >  failed to parse event {stereolab} : event not found
> >  Error:
> >  failed to parse event {instructions,cycles},{instructions,stereolab} :\
> >          event not found
> >  Ok
> >  #
> >
> > This patch addresses the error message 'nested event groups not supported'.
> > The root cause is function parse_libpfm_events_option() which parses the
> > event string '{},{instructions}' and can not handle a leading empty
> > group notation '{},...'.
> >
> > The code detects the first (empty) group indicator '{' but does not
> > terminate group processing on the following group closing character '}'.
> > So when the second group indicator '{' is detected, the code assumes
> > a nested group and returns an error.
> >
> > With the error message fixed, also change the expected event number to
> > one for the test case to succeed.
> >
> > While at it also fix a memory leak. In good case the function does not
> > free the duplicated string given as first parameter.
> >
> > Output after:
> >  # ./perf test -F 63
> >  63: Test libpfm4 support                                            :
> >  63.1: test of individual --pfm-events                               :
> >  Error:
> >  failed to parse event stereolab : event not found
> >  Error:
> >  failed to parse event stereolab,instructions : event not found
> >  Error:
> >  failed to parse event instructions,stereolab : event not found
> >   Ok
> >  63.2: test groups of --pfm-events                                   :
> >  Error:
> >  failed to parse event {stereolab} : event not found
> >  Error:
> >  failed to parse event {instructions,cycles},{instructions,stereolab} : \
> >          event not found
> >   Ok
> >  #
> > Error message 'nested event groups not supported' is gone.
> 
> Acked-By: Ian Rogers <irogers@google.com>
> 
> I wonder if we should add some coverage for the error cases to the pfm
> test with something like the following.

Yeah, agreed, please consider sending a patch for that.

Thanks, applied.

- Arnaldo
 
> Thanks,
> Ian
> 
> --- a/tools/perf/tests/pfm.c
> +++ b/tools/perf/tests/pfm.c
> @@ -155,6 +155,16 @@ static int test__pfm_group(void)
>                         .nr_events = 3,
>                         .nr_groups = 1,
>                 },
> +               {
> +                       .events = "instructions}",
> +                       .nr_events = 1,
> +                       .nr_groups = 0,
> +               },
> +               {
> +                       .events = "{{instructions}}",
> +                       .nr_events = 0,
> +                       .nr_groups = 0,
> +               },
>         };
> 
>         for (i = 0; i < ARRAY_SIZE(table); i++) {
> 
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > ---
> >  tools/perf/tests/pfm.c |  4 ++--
> >  tools/perf/util/pfm.c  | 11 ++++++++++-
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
> > index 76a53126efdf..d4b0ef74defc 100644
> > --- a/tools/perf/tests/pfm.c
> > +++ b/tools/perf/tests/pfm.c
> > @@ -131,8 +131,8 @@ static int test__pfm_group(void)
> >                 },
> >                 {
> >                         .events = "{},{instructions}",
> > -                       .nr_events = 0,
> > -                       .nr_groups = 0,
> > +                       .nr_events = 1,
> > +                       .nr_groups = 1,
> >                 },
> >                 {
> >                         .events = "{instructions},{instructions}",
> > diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> > index d735acb6c29c..6eef6dfeaa57 100644
> > --- a/tools/perf/util/pfm.c
> > +++ b/tools/perf/util/pfm.c
> > @@ -62,8 +62,16 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
> >                 }
> >
> >                 /* no event */
> > -               if (*q == '\0')
> > +               if (*q == '\0') {
> > +                       if (*sep == '}') {
> > +                               if (grp_evt < 0) {
> > +                                       ui__error("cannot close a non-existing event group\n");
> > +                                       goto error;
> > +                               }
> > +                               grp_evt--;
> > +                       }
> >                         continue;
> > +               }
> >
> >                 memset(&attr, 0, sizeof(attr));
> >                 event_attr_init(&attr);
> > @@ -107,6 +115,7 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
> >                         grp_evt = -1;
> >                 }
> >         }
> > +       free(p_orig);
> >         return 0;
> >  error:
> >         free(p_orig);
> > --
> > 2.31.1
> >

-- 

- Arnaldo
