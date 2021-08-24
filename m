Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7258DC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 19:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5391F60FD8
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 19:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhHXT13 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhHXT12 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 15:27:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A5D061002;
        Tue, 24 Aug 2021 19:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629833204;
        bh=WTppzCVYfXTRwTJffWzU7XL4rwBv7qiOi43vs1AhyC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6JeatVOpURubaxLFhfEc2oUDCSD5SYOmjTfPSrxNhzZsCKbd7szNhNa/y26DcRLT
         bJyCCQgdo7L9ROnrJMeTqAZwrlr93PWOyg5Rp2rJFqPmyp0aZk0zMTHszyNZoZaJMa
         sXPS1mGWKst4V5CTB4RzSQhNqnZPFh0hQMdEyb44kcdTXshuhXe045fgMkYE4ZXiuz
         GK9G9azaLFANBL46hPdF49ogY4LeGBfMfqxduJCiGHnkApKZLfGmInElocv4tdQCjp
         tVib0XuxteGxgCYhEXr77YWbWeD9HxJbr7UO+vL6Ia7b1nIjJ5uw+APg5iXV44K/gg
         kh7AbsU3yunzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1E244007E; Tue, 24 Aug 2021 16:26:40 -0300 (-03)
Date:   Tue, 24 Aug 2021 16:26:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>, Song Liu <song@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf config: fix caching and memory leak in
 perf_home_perfconfig
Message-ID: <YSVH8NMZ0OFioBQ9@kernel.org>
References: <20210820130817.740536-1-rickyman7@gmail.com>
 <YR+4kOwuIoPsz2Rw@kernel.org>
 <a647993d9eff9fab20196661ba2a153c7258e569.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a647993d9eff9fab20196661ba2a153c7258e569.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 20, 2021 at 09:58:16PM +0200, Riccardo Mancini escreveu:
> On Fri, 2021-08-20 at 11:13 -0300, Arnaldo Carvalho de Melo wrote:
> > diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> > index 63d472b336de21d4..4fb5e90d7a57ae48 100644
> > --- a/tools/perf/util/config.c
> > +++ b/tools/perf/util/config.c
> > @@ -581,7 +581,10 @@ const char *perf_home_perfconfig(void)
> >         static const char *config;
> >         static bool failed;
> >  
> > -       config = failed ? NULL : home_perfconfig();
> > +       if (failed || config)
> > +               return config;
> > +
> > +       config = home_perfconfig();
> >         if (!config)
> >                 failed = true;
> >  
> 
> Looks good to me.
> Shall I resend it fixed?

No need, I'll fix it and apply, thanks for checking!

- Arnaldo
