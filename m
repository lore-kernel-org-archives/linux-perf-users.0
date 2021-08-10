Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E481CC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 14:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA0E60F35
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 14:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhHJODr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236686AbhHJODr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 10:03:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F371960E52;
        Tue, 10 Aug 2021 14:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628604205;
        bh=Td8E4SnrU0EwYxqbg86EgADaAZSpTbgyuIW0jEf6cek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnPHh11oY7YFlpTdsCAQ+09LermdZbMkyjzjjyr8yoJ09r80n5nE1bMblfcW9dSfw
         599+S1R1XP5jQQj9v9ad4/S/ML13MNGvIae/qztxO2dU3eWHmsJQ2RN19Bf+EEMSNQ
         2JSrTCBOnh5l1Za9wWMI09xdHXKEohmeX8ly+5bzfV+XgCAw3qmAqS4qTFDloePGGu
         u/uUIeb73MiqOobayU/ipgqc7D5bl4m3uoA49xfE9foxqCd8HF1jqIfcN42dVdjO3A
         hBJPhL5I5FlFtCeZrrsNA8E7jDikFCdBrN5FXpZ9oHXxnfwmfjLjGBXf5BzK2ZSqMX
         PTkkviwJCIkUA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FFC8403F2; Tue, 10 Aug 2021 11:03:22 -0300 (-03)
Date:   Tue, 10 Aug 2021 11:03:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench: add benchmark for evlist open/close
 operations
Message-ID: <YRKHKiHMSaYZWwQv@kernel.org>
References: <20210809201101.277594-1-rickyman7@gmail.com>
 <YRGOwx3xlPRxNAXM@kernel.org>
 <YRGP3DR8f6ZEvn/P@kernel.org>
 <aa2e93cdaf636b0cd9df05d759661363b2a59d3f.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa2e93cdaf636b0cd9df05d759661363b2a59d3f.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 10, 2021 at 12:31:55PM +0200, Riccardo Mancini escreveu:
> Hi Arnaldo,
> 
> On Mon, 2021-08-09 at 17:28 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Aug 09, 2021 at 05:23:31PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Aug 09, 2021 at 10:11:02PM +0200, Riccardo Mancini escreveu:
> > > > +static struct evlist *bench__create_evlist(char *evstr)
> > > > +{
> > > > +       struct evlist *evlist;
> > > > +       struct parse_events_error err;
> > > > +       int ret;
> > 
> > > > +       evlist = evlist__new();
> > > > +       if (!evlist) {
> > > > +               pr_err("Not enough memory to create evlist\n");
> > > > +               return NULL;
> > > > +       }
> > 
> > > > +       bzero(&err, sizeof(err));
> > 
> > > man bzero
> > > 
> > >        The bzero() function is deprecated (marked as LEGACY in POSIX.1-2001);
> > > use memset(3) in new programs.  POSIX.1-2008 removes the specification of
> > > bzero().  The bzero() function first appeared in 4.3BSD.
> 
> Oops, I didn't know, but I saw it is being used in some parts in perf, maybe we
> should get rid of them:
> $ rg -c bzero
> builtin-lock.c:1
> arch/powerpc/util/kvm-stat.c:1
> builtin-stat.c:1
> builtin-trace.c:2
> bench/evlist-open-close.c:1
> bench/numa.c:5
> tests/parse-events.c:1
> tests/backward-ring-buffer.c:1
> tests/bpf.c:2
> util/metricgroup.c:1
> util/parse-events.c:1

Yeah, patches are welcome, but at least lets not add new ones :-)
 
> > > I'm replacing it with a memset().
> > 
> > This one is also equivalent:
> > 
> > tools/perf/tests/pmu-events.c:  struct parse_events_error error = { .idx = 0, };
> > 
> > https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
> > 
> > That text is a bit roundabout, as it says that the members that are not
> > explicitely initialized will be initialized as variables with static
> > storage duration, i.e. zeroed.
> 
> Would it be the same doing the shorter {0}. It would be a general solution for
> these init-to-zero cases.

I'd have to do some extra research to remember why that is also not
optimal, IIRC the '= { .a = 0, };' is the optimal one.
 
> Unrelated to this small issue, I noticed I forgot to check the return of
> bench__create_evlist. Would you like me to send a v2 fixing both issues or are
> you able to apply this other small change yourself?

Nah, as this is the HEAD right now in my local branch, I'll apply it
myself, thanks!

- Arnaldo
 
> diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
> index 40bce06f5ca7bef3..f0b9c330f34f2984 100644
> --- a/tools/perf/bench/evlist-open-close.c
> +++ b/tools/perf/bench/evlist-open-close.c
> @@ -168,7 +168,11 @@ static int bench_evlist_open_close__run(char *evstr)
>  
>         for (i = 0; i < iterations; i++) {
>                 pr_debug("Started iteration %d\n", i);
> +
>                 evlist = bench__create_evlist(evstr);
> +               if (!evlist)
> +                       return -ENOMEM;
> +
>                 gettimeofday(&start, NULL);
>                 err = bench__do_evlist_open_close(evlist);
>                 if (err) {
> 
> Thanks,
> Riccardo
> 
> > 
> > - Arnaldo
> 
> 

-- 

- Arnaldo
