Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D14C07E9C
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD5961CDE
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhGGSkg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232241AbhGGSkR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CE4660C41;
        Wed,  7 Jul 2021 18:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625683056;
        bh=cToattK8KRagMqTO0iZ6wFbDJffmktvYxLuVFg8PCUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqF8ksrbYuXv3WYpPqW/bDg774MjR8RJjDVUiE9ln3C1zQ6ZP24OTOW2ZFV1dLdLW
         dwnKdRAyrYaRJHjJtbBMTE48+RMR0GUrYt2ZuxVUuQGzzuNdQ0Lgi5PU+4iWLrspyS
         2CIFI+mfbpRlr9fEBGddx7Tss8mTSHUjUAhjW0WtV6jPt8CssuPuH7zwaSbnnMyHo1
         w8rKyQnqcMAUOKJ0DFKRehFpUh6UUSjnKedVgT6/g5hQVk+h94OgMZN5itTylUtJUi
         28ZiZCsCIWPz3fX9NeADHhii1xjaIPSVRzs5SP7GZeiWgcWx0aNPKqxK1mczA6jPC+
         E3iihYXOjloCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27BF740B1A; Wed,  7 Jul 2021 15:37:34 -0300 (-03)
Date:   Wed, 7 Jul 2021 15:37:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFCv2 0/7] libperf: Add leader/group info to perf_evsel
Message-ID: <YOX0bpjlr/Xqlbk0@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <YOW+eyxYtPhc2hSf@kernel.org>
 <YOXwVPS6zIyw0C/k@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXwVPS6zIyw0C/k@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 07, 2021 at 08:20:04PM +0200, Jiri Olsa escreveu:
> On Wed, Jul 07, 2021 at 11:47:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 06, 2021 at 05:16:57PM +0200, Jiri Olsa escreveu:
> > > hi,
> > > moving leader/group info to libperf's perf_evsel.
> > > 
> > > This was asked for by Shunsuke [1] and is on my list
> > > as a prereq for event parsing move to libperf.
> > 
> > So I'll add a:
> > 
> > Requested-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> 
> yep, but let's hear from him first if that's the case actualy ;-)
> 
> he did not mention any specific interface.. so I wonder
> what we have is ok with him

Its all in tmp.perf/core, but from what I saw, yeah, he requested being
able to have a group leader.

Nakamura-san, isn't that the case?

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > - Arnaldo
> >  
> > > I still need to do more tests, but I'd like to check
> > > with you guys if there's any feedback on this first.
> > > 
> > > Also available in:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   libperf/groups
> > > 
> > > v2 change:
> > >   - repost due to smtp failures, no changes
> > > 
> > > thanks,
> > > jirka
> > > 
> > > 
> > > [1] https://lore.kernel.org/linux-perf-users/OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com/
> > > 
> > > 
> > > ---
> > > Jiri Olsa (7):
> > >       libperf: Change tests to single static and shared binaries
> > >       libperf: Move idx to perf_evsel::idx
> > >       libperf: Move leader to perf_evsel::leader
> > >       libperf: Move nr_groups to evlist::nr_groups
> > >       libperf: Add perf_evlist__set_leader function
> > >       libperF: Add group support to perf_evsel__open
> > >       libperf: Add tests for perf_evlist__set_leader function
> > > 
> > >  tools/lib/perf/Build                     |  2 ++
> > >  tools/lib/perf/Makefile                  | 30 +++++++++++++++++++++++++-----
> > >  tools/lib/perf/evlist.c                  | 22 ++++++++++++++++++++++
> > >  tools/lib/perf/evsel.c                   | 33 +++++++++++++++++++++++++++++----
> > >  tools/lib/perf/include/internal/evlist.h |  2 ++
> > >  tools/lib/perf/include/internal/evsel.h  |  5 ++++-
> > >  tools/lib/perf/include/internal/tests.h  |  4 ++--
> > >  tools/lib/perf/include/perf/evlist.h     |  1 +
> > >  tools/lib/perf/libperf.map               |  1 +
> > >  tools/lib/perf/tests/Build               |  5 +++++
> > >  tools/lib/perf/tests/Makefile            | 40 ----------------------------------------
> > >  tools/lib/perf/tests/main.c              | 15 +++++++++++++++
> > >  tools/lib/perf/tests/test-cpumap.c       |  3 ++-
> > >  tools/lib/perf/tests/test-evlist.c       | 30 +++++++++++++++++++++++-------
> > >  tools/lib/perf/tests/test-evsel.c        |  3 ++-
> > >  tools/lib/perf/tests/test-threadmap.c    |  3 ++-
> > >  tools/lib/perf/tests/tests.h             | 10 ++++++++++
> > >  tools/perf/arch/x86/util/iostat.c        |  4 ++--
> > >  tools/perf/builtin-diff.c                |  4 ++--
> > >  tools/perf/builtin-record.c              |  4 ++--
> > >  tools/perf/builtin-report.c              |  8 ++++----
> > >  tools/perf/builtin-script.c              |  9 +++++----
> > >  tools/perf/builtin-stat.c                | 12 ++++++------
> > >  tools/perf/builtin-top.c                 | 10 +++++-----
> > >  tools/perf/tests/bpf.c                   |  2 +-
> > >  tools/perf/tests/evsel-roundtrip-name.c  |  6 +++---
> > >  tools/perf/tests/mmap-basic.c            |  8 ++++----
> > >  tools/perf/tests/parse-events.c          | 74 +++++++++++++++++++++++++++++++++++++-------------------------------------
> > >  tools/perf/tests/pfm.c                   |  4 ++--
> > >  tools/perf/ui/browsers/annotate.c        |  2 +-
> > >  tools/perf/util/annotate.c               |  8 ++++----
> > >  tools/perf/util/auxtrace.c               | 12 ++++++------
> > >  tools/perf/util/cgroup.c                 |  2 +-
> > >  tools/perf/util/evlist.c                 | 44 +++++++++++++-------------------------------
> > >  tools/perf/util/evlist.h                 |  2 --
> > >  tools/perf/util/evsel.c                  | 32 +++++++++++++++++++++++++-------
> > >  tools/perf/util/evsel.h                  | 14 ++++++++------
> > >  tools/perf/util/header.c                 | 18 +++++++++---------
> > >  tools/perf/util/metricgroup.c            | 22 +++++++++++-----------
> > >  tools/perf/util/parse-events.c           |  8 ++++----
> > >  tools/perf/util/pfm.c                    |  2 +-
> > >  tools/perf/util/python.c                 |  2 +-
> > >  tools/perf/util/record.c                 |  6 +++---
> > >  tools/perf/util/stat-shadow.c            |  2 +-
> > >  tools/perf/util/stat.c                   |  2 +-
> > >  tools/perf/util/stream.c                 |  2 +-
> > >  46 files changed, 310 insertions(+), 224 deletions(-)
> > >  create mode 100644 tools/lib/perf/tests/Build
> > >  delete mode 100644 tools/lib/perf/tests/Makefile
> > >  create mode 100644 tools/lib/perf/tests/main.c
> > >  create mode 100644 tools/lib/perf/tests/tests.h
> > > 
> > 
> > -- 
> > 
> > - Arnaldo
> > 
> 

-- 

- Arnaldo
