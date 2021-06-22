Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F93C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 17:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0E061107
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 17:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhFVRpG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhFVRo3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 13:44:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 008BA6109E;
        Tue, 22 Jun 2021 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624383732;
        bh=GWanZPHLYwqwtTj2NWjEdTQwKu/xr9UDKDkcTpBF4X8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qj50r7lQ1tQ4Fb5ebUDY1iJaohhfqmrVk6YkwM2zysaL0eJLXhPhVox5KLPZJuWqR
         cix7eBaGDBy3VeZlVdiNYX4mahkiSHBicDG9bEVeCn7pjpQYelY9qqFd9g4hMm6FFW
         5aiYFiedKzv6TbXsaM0PaVSb7QgLnjWM1x6CK1XKPqf6WVAFEkYpDzzMR5zDkl8M+M
         bvkq9RVFu27SHCq0A5m9FvfZRxfWWfSA8Y9HtILDUQ4OE7t7qQe42phdbgWx9alyc0
         w1rVn2uKv//UjoKmYzOt2vw3wqTRsdKhw5A6STLpg9nZhe2alw52xeDHPfoqWjGIli
         NM/B/zTDHsVDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E0E240B1A; Tue, 22 Jun 2021 14:42:04 -0300 (-03)
Date:   Tue, 22 Jun 2021 14:42:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf script: delete evlist when deleting session
Message-ID: <YNIg7OkPi7YgsBZ3@kernel.org>
References: <20210621234317.235545-1-rickyman7@gmail.com>
 <20210621234317.235545-3-rickyman7@gmail.com>
 <CAP-5=fUGRdj=G6=srwoATWMimK5tB4X2Sxa64tTVk_JRwMJdWg@mail.gmail.com>
 <d4921abf8dcff02245ccf7ad8edfd8048e926936.camel@gmail.com>
 <CAP-5=fXGJXmpddPVEjmCCv9oC7bmum3p+1m1m6rem8Pdy+XaXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXGJXmpddPVEjmCCv9oC7bmum3p+1m1m6rem8Pdy+XaXA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 22, 2021 at 09:33:23AM -0700, Ian Rogers escreveu:
> On Tue, Jun 22, 2021 at 12:44 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> >
> > Hi,
> >
> > thanks for your comments.
> >
> > On Mon, 2021-06-21 at 22:14 -0700, Ian Rogers wrote:
> > > On Mon, Jun 21, 2021 at 4:44 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > > >
> > > > ASan reports a memory leak related to session->evlist never being deleted.
> > > > The evlist member is not deleted in perf_session__delete, so it should be
> > > > deleted separately.
> > > > This patch adds the missing deletion in perf-script.
> > > >
> > > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > > > ---
> > > >  tools/perf/builtin-script.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > > index 1280cbfad4db..635a1d9cfc88 100644
> > > > --- a/tools/perf/builtin-script.c
> > > > +++ b/tools/perf/builtin-script.c
> > > > @@ -3991,7 +3991,7 @@ int cmd_script(int argc, const char **argv)
> > > >                 zfree(&script.ptime_range);
> > > >         }
> > > >
> > > > -       evlist__free_stats(session->evlist);
> > >
> > > Should this be removed?
> >
> > Probably not. I originally thought this was already taken care of by
> > evlist__delete, but it's not.
> > Oddly, this issue is not causing a memory leak in my simple test.
> >
> > >
> > > > +       evlist__delete(session->evlist);

This looks like a bug, if it is a 'session' member, its a session method
that should delete it, probably perf_session__delete().

> > > If the perf session "owns" the evlist, would it be cleaner to add this
> > > to perf_session__delete?
> >
> > I thought about that too, but that's not always true.
> > E.g., in perf-record, __cmd_record calls perf_session__delete,then cmd_record
> > calls evlist__delete on rec->evlist, which points to the same location to which
> > session->evlist pointed.
> 
> Agreed. I find it hard to understand the ownership properties in the
> perf code. The missing delete is an example of the owner of the evlist
> (the caller) not "knowing" it needed cleaning up. I'd like it if we
> documented things like perf_sessions' evlist to say not owned, user
> must clean up. The makes it unambiguous who has to take
> responsibility. Having things clean up after themselves is of course
> easiest, hence wanting this to be in perf_session__delete.

This specific case, from just reading the description on this message,
looks just like a bug/thinko.
 
> Fwiw, I've been reading around things like sparse [1, 2] and Clang's
> similar analysis [3] that people have looked to use like sparse [4]. I
> don't see anything that handles memory allocation lifetimes, but
> perhaps something will feed into C's standards by way of C++ [5].
> Perhaps people have ideas to rewrite in checked C or Rust :-)
> 
> Some thoughts:
> 1) we can't have C++ as we're trying to follow kernel conventions [6]
> 2) we can't annotate code for things like sparse or thread safety
> analysis, as checking for memory errors is out of scope for them, the
> annotations don't exist, etc.
> 3) we can add comments, document the rules around pointers, perhaps
> even invent empty annotations that may one day help with automated
> checking.
> 4) we can try to clean up the ownership model to make bugs less likely.
> 
> I've heard concerns on non-kernel projects about annotation litter and
> comments adding to complexity. I think your patch is good, it follows
> the existing conventions. I wonder if we can learn something from the
> fact the code was wrong to make it less likely we have wrong code in
> the future. I'd be interested to hear what others think.
> 
> Thanks,
> Ian
> 
> [1] https://lore.kernel.org/lkml/Pine.LNX.4.58.0410302005270.28839@ppc970.osdl.org/
> [2] https://lwn.net/Articles/689907/
> [3] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html
> [4] https://www.openwall.com/lists/kernel-hardening/2019/05/20/3
> [5] https://github.com/isocpp/CppCoreGuidelines/blob/master/docs/Lifetime.pdf
> [6] even concatenating a string is error prone in C :-(
> https://lore.kernel.org/lkml/YMzOpgZPJeC2jGKf@kernel.org/
> 
> > Thanks,
> > Riccardo
> >
> > >
> > > Thanks,
> > > Ian
> > >
> > > >         perf_session__delete(session);
> > > >
> > > >         if (script_started)
> > > > --
> > > > 2.31.1
> > > >
> >
> >

-- 

- Arnaldo
