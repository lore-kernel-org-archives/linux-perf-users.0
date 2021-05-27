Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC812C4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C174261003
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 16:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhE0Q12 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 12:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235338AbhE0Q11 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 12:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5885E60FF3;
        Thu, 27 May 2021 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622132754;
        bh=Khua+DZPgivlFbIh9u5t7o96xy61LA45QdEqBeYyX5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5JMqWiirU63QukEEtKpD09CQVAMJs3+Q/OXlz3vaxgCOMFcozu8dEI4HYUr1ccJL
         GacFQ+k6Dhvh6HymCw/X0t8uTBFFN8wdAGvcyugnug23jutz9k+yIF8rccxpjNnxgG
         I/yc8YE9zPQMuJ6EPBHmP4VDOBRUFQllRUs6MrLKtC4Pfd06A7jSwSKH4bQDHBbI5p
         8dpdwr7KnXOCToswCGPY+HeBGvdtBJ7zVe9RIR3X0y/x41OnfwKKDyU1dZfrnoGV3f
         XNTgWI46TKAr+xOvEcQBaOYnenrB342uIoM4xHAsTXHeaAsg9rNqdVDBP9i4MSCc/H
         7EdkDLgAeekXg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C1C4D4011C; Thu, 27 May 2021 13:25:51 -0300 (-03)
Date:   Thu, 27 May 2021 13:25:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf: Move debug initialization earlier
Message-ID: <YK/IDzRfX6AyTkbx@kernel.org>
References: <20210519164447.2672030-1-irogers@google.com>
 <CAP-5=fWRAbkd8MVAxdGf0YGE1oFPT40rZC3eb3OKjqWmBVq_BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWRAbkd8MVAxdGf0YGE1oFPT40rZC3eb3OKjqWmBVq_BA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, May 27, 2021 at 08:51:41AM -0700, Ian Rogers escreveu:
> On Wed, May 19, 2021 at 9:44 AM Ian Rogers <irogers@google.com> wrote:
> >
> > This avoids segfaults during option handlers that use pr_err. For
> > example, "perf --debug nopager list" segfaults before this change.
> >
> > Fixes: 8abceacff87d (perf debug: Add debug_set_file function)
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

I thought I had this one in, its now, will go to Linus probably tomorrow,

- Arnaldo
 
> Thanks!
> Ian
> 
> > ---
> >  tools/perf/perf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index 20cb91ef06ff..2f6b67189b42 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -443,6 +443,8 @@ int main(int argc, const char **argv)
> >         const char *cmd;
> >         char sbuf[STRERR_BUFSIZE];
> >
> > +       perf_debug_setup();
> > +
> >         /* libsubcmd init */
> >         exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
> >         pager_init(PERF_PAGER_ENVIRONMENT);
> > @@ -531,8 +533,6 @@ int main(int argc, const char **argv)
> >          */
> >         pthread__block_sigwinch();
> >
> > -       perf_debug_setup();
> > -
> >         while (1) {
> >                 static int done_help;
> >
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >

-- 

- Arnaldo
