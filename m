Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378E6C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 10:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4EC60E97
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 10:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhHJKcV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 06:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbhHJKcV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 06:32:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0BFC0613D3;
        Tue, 10 Aug 2021 03:31:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k9so12198052edr.10;
        Tue, 10 Aug 2021 03:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BnSqEsuVsZQxzk7uU1gGlvVcqSUFyn9wHYGuW2UZsQ4=;
        b=n3Rs6nkeAnpeBBbj/lelqVJsvACu3cY4wK/GBjjiCEuinblpKwNpXb5FA7dO3Lp564
         gHZnsLfRiz3V0gFUttLDAvn8u85XA682QTx8NC0JK4PJ6nerPJ75Hj8QSdhz8SibZPyz
         y3NFME94rR9znlSOFeyYSNQ9sh3fwcmCBDjnYlIKATPibgUKGa3lW0DZSJuCHPxyDMOp
         oZVKhM3d0Cgq1B8iG79IdKVS8PLtH2B75W10ofUnrdLJok6UpzQyx7a5bNlYMSx2AQdz
         W8rqWqKagfNnysD/d9R3afQSRitWVMKnDEkSy/R1Fgsc76A6q01oxkiwzZuzx72S/ZSv
         zCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BnSqEsuVsZQxzk7uU1gGlvVcqSUFyn9wHYGuW2UZsQ4=;
        b=cPv5BGAalw2SAA3yYQ70DOeAzfC9lOHUeWZYwWAeDzGX67LhtDgsSqiGjxaKv0f00f
         no8x6enx4UvIZP01tcEbk9Hs3CiIa+zqNZCou5cnzrWWVfUxfTgOLrkNRsZkB3AkyCox
         t7WtJHaPK1kEfZ8SgcB8qz7Xw/oB8l6cQKxz0r6UYNvBHxes2bE2ZedS33aOKY+OzeBU
         zW1Sf2fZ4UDCfdz/1ISsr+CJ9ioyDXailoGGuCwqnhGRD6bZ7WHgKpQa+vpxXDJ2KmQR
         BXtt6lPVfykXZyrcAexXtUXq5KcMCc6k22TEgJhsAXUr1vbu6tfWv1Zz+ZrwsOtP17xh
         oD4w==
X-Gm-Message-State: AOAM531ZtJAo9tbcxFoYE5Ia9vBQdnkdS/lg7k5/rw3fQzLPRUUOwsMB
        1F9BRGFIH2KgWzbADtUmEHU=
X-Google-Smtp-Source: ABdhPJwdz637dun8TYBCZjDmrYWS7lBJVStAmA1K4VPhLORrT/iZ6ytRX0oIzXLNvtz/zft/kHkg8w==
X-Received: by 2002:aa7:d144:: with SMTP id r4mr4062691edo.111.1628591517782;
        Tue, 10 Aug 2021 03:31:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id z8sm6684876ejd.94.2021.08.10.03.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:31:57 -0700 (PDT)
Message-ID: <aa2e93cdaf636b0cd9df05d759661363b2a59d3f.camel@gmail.com>
Subject: Re: [PATCH] perf bench: add benchmark for evlist open/close
 operations
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Date:   Tue, 10 Aug 2021 12:31:55 +0200
In-Reply-To: <YRGP3DR8f6ZEvn/P@kernel.org>
References: <20210809201101.277594-1-rickyman7@gmail.com>
         <YRGOwx3xlPRxNAXM@kernel.org> <YRGP3DR8f6ZEvn/P@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Mon, 2021-08-09 at 17:28 -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 09, 2021 at 05:23:31PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Aug 09, 2021 at 10:11:02PM +0200, Riccardo Mancini escreveu:
> > > +static struct evlist *bench__create_evlist(char *evstr)
> > > +{
> > > +       struct evlist *evlist;
> > > +       struct parse_events_error err;
> > > +       int ret;
> 
> > > +       evlist = evlist__new();
> > > +       if (!evlist) {
> > > +               pr_err("Not enough memory to create evlist\n");
> > > +               return NULL;
> > > +       }
> 
> > > +       bzero(&err, sizeof(err));
> 
> > man bzero
> > 
> >        The bzero() function is deprecated (marked as LEGACY in POSIX.1-2001);
> > use memset(3) in new programs.  POSIX.1-2008 removes the specification of
> > bzero().  The bzero() function first appeared in 4.3BSD.

Oops, I didn't know, but I saw it is being used in some parts in perf, maybe we
should get rid of them:
$ rg -c bzero
builtin-lock.c:1
arch/powerpc/util/kvm-stat.c:1
builtin-stat.c:1
builtin-trace.c:2
bench/evlist-open-close.c:1
bench/numa.c:5
tests/parse-events.c:1
tests/backward-ring-buffer.c:1
tests/bpf.c:2
util/metricgroup.c:1
util/parse-events.c:1

> 
> > I'm replacing it with a memset().
> 
> This one is also equivalent:
> 
> tools/perf/tests/pmu-events.c:  struct parse_events_error error = { .idx = 0, };
> 
> https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
> 
> That text is a bit roundabout, as it says that the members that are not
> explicitely initialized will be initialized as variables with static
> storage duration, i.e. zeroed.

Would it be the same doing the shorter {0}. It would be a general solution for
these init-to-zero cases.

Unrelated to this small issue, I noticed I forgot to check the return of
bench__create_evlist. Would you like me to send a v2 fixing both issues or are
you able to apply this other small change yourself?

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 40bce06f5ca7bef3..f0b9c330f34f2984 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -168,7 +168,11 @@ static int bench_evlist_open_close__run(char *evstr)
 
        for (i = 0; i < iterations; i++) {
                pr_debug("Started iteration %d\n", i);
+
                evlist = bench__create_evlist(evstr);
+               if (!evlist)
+                       return -ENOMEM;
+
                gettimeofday(&start, NULL);
                err = bench__do_evlist_open_close(evlist);
                if (err) {

Thanks,
Riccardo

> 
> - Arnaldo


