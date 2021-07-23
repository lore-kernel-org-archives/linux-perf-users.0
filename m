Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842EBC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 18:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E97060F25
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 18:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhGWSQG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGWSQG (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 14:16:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C4F160F23;
        Fri, 23 Jul 2021 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627066599;
        bh=X1Y5jRGM8rZJoda6qzzReNjRoRKFhTGjPw+WwpzIAi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kvmjh3ylBuQCqhqELcKoE+IywK4tjXA9Ab2B3uhq4oxyn6DYckveWcXy7kkiow6cP
         2Q7ViRjDXqKJ1dJFkw3JvNiNCLrZXLCUgdN7jqqK5USfGaVDnZjfHf6ArRhb3VJHmF
         J3EgEVuDY09mYTuqq3klLXvXwDUNpmg4frwokwPAC4/Bm9Fs0LLDfNZxcPTcYoCi/f
         HsRTbk61T3qfWdQHdjMj4PG1+w9sIIMU0WVyN9aJkHJN5Buk86VVNrGft2ay194QEw
         wtKznB9InW6LTYZFwgEAd/NrsbiaZSfhEghckflF1vOCNJ2MTi2NGS6BUHvDkYnSuo
         h/5OU3/Q9xVIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9C57F403F2; Fri, 23 Jul 2021 15:56:36 -0300 (-03)
Date:   Fri, 23 Jul 2021 15:56:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH 4/7] perf doc: Add info pages to all target.
Message-ID: <YPsQ5En9N7xG1Cya@kernel.org>
References: <20210715013343.2286699-1-irogers@google.com>
 <20210715013343.2286699-5-irogers@google.com>
 <YPsKLa0Qe5/as4Jh@kernel.org>
 <YPsQGZOXqoy7Tfe6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPsQGZOXqoy7Tfe6@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jul 23, 2021 at 03:53:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jul 23, 2021 at 03:27:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Jul 14, 2021 at 06:33:40PM -0700, Ian Rogers escreveu:
> > > Enabled to ensure that info pages build.
> > 
> > How did you test this? I tried installing texinfo, that is where
> > makeinfo belongs:
> > 
> > ⬢[acme@toolbox perf]$ rpm -qf /usr/bin/makeinfo
> > texinfo-6.7-10.fc34.x86_64
> > ⬢[acme@toolbox perf]$ rpm -q texinfo
> > texinfo-6.7-10.fc34.x86_64
> > ⬢[acme@toolbox perf]$
> > 
> > And then:
> > 
> > ⬢[acme@toolbox perf]$ make -C tools/perf O=/tmp/build/perf install-doc
> > make: Entering directory '/var/home/acme/git/perf/tools/perf'
> >   BUILD:   Doing 'make -j24' parallel build
> >   INSTALL Documentation-man
> > make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> > ⬢[acme@toolbox perf]$
> 
> Also:

We get closer if we do:

⬢[acme@toolbox perf]$ make -C tools/perf/Documentation/ install-info
make: Entering directory '/var/home/acme/git/perf/tools/perf/Documentation'
  ASCIIDOC perf.xml
  DB2TEXI  perf.texi
/bin/sh: line 2: docbook2x-texi: command not found
make: *** [Makefile:289: perf.texi] Error 127
make: Leaving directory '/var/home/acme/git/perf/tools/perf/Documentation'
⬢[acme@toolbox perf]$

- Arnaldo
