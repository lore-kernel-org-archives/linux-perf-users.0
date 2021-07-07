Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A657C07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C6B61130
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 14:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhGGOuG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232050AbhGGOuG (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 10:50:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE00F61CC1;
        Wed,  7 Jul 2021 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625669245;
        bh=rVyXTr/H4kPIthUl9Fp6sw9E9LOv7RqtGRY8URy8Qqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2Is5yM96GpKa1aTLrbCsa0JGq72fWl8mIi73dsPZIdyVDgIk5dSMOgQ1T+jk98AI
         yPA+r9eacNzD+KIQL6ufs2SGirzsdPprp1SrCYhPgaQfkcFOI9SAKjgLWGjebbdibE
         bCUNFcgGj8OKXiND9PiRyIb5CDl55r9RCV0aPwvB5gYyCPSYVmkVmJw2qb777Kb4Zd
         DAGS8aK6xkU7oHlqPfaJ5sGHtSAaOdcDmVU//bA7PdqSvoXY8bmCQQiCPEU9booXW+
         sQ9khB1cHHAj+fiap9Zq7KyNi+sNSzDPwVbz9otb8BKVzUmITdP6vzlBEHlNuwy0yc
         ccoXoAbwInxNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6231640B1A; Wed,  7 Jul 2021 11:47:23 -0300 (-03)
Date:   Wed, 7 Jul 2021 11:47:23 -0300
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
Message-ID: <YOW+eyxYtPhc2hSf@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706151704.73662-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 06, 2021 at 05:16:57PM +0200, Jiri Olsa escreveu:
> hi,
> moving leader/group info to libperf's perf_evsel.
> 
> This was asked for by Shunsuke [1] and is on my list
> as a prereq for event parsing move to libperf.

So I'll add a:

Requested-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

- Arnaldo
 
> I still need to do more tests, but I'd like to check
> with you guys if there's any feedback on this first.
> 
> Also available in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   libperf/groups
> 
> v2 change:
>   - repost due to smtp failures, no changes
> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/linux-perf-users/OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com/
> 
> 
> ---
> Jiri Olsa (7):
>       libperf: Change tests to single static and shared binaries
>       libperf: Move idx to perf_evsel::idx
>       libperf: Move leader to perf_evsel::leader
>       libperf: Move nr_groups to evlist::nr_groups
>       libperf: Add perf_evlist__set_leader function
>       libperF: Add group support to perf_evsel__open
>       libperf: Add tests for perf_evlist__set_leader function
> 
>  tools/lib/perf/Build                     |  2 ++
>  tools/lib/perf/Makefile                  | 30 +++++++++++++++++++++++++-----
>  tools/lib/perf/evlist.c                  | 22 ++++++++++++++++++++++
>  tools/lib/perf/evsel.c                   | 33 +++++++++++++++++++++++++++++----
>  tools/lib/perf/include/internal/evlist.h |  2 ++
>  tools/lib/perf/include/internal/evsel.h  |  5 ++++-
>  tools/lib/perf/include/internal/tests.h  |  4 ++--
>  tools/lib/perf/include/perf/evlist.h     |  1 +
>  tools/lib/perf/libperf.map               |  1 +
>  tools/lib/perf/tests/Build               |  5 +++++
>  tools/lib/perf/tests/Makefile            | 40 ----------------------------------------
>  tools/lib/perf/tests/main.c              | 15 +++++++++++++++
>  tools/lib/perf/tests/test-cpumap.c       |  3 ++-
>  tools/lib/perf/tests/test-evlist.c       | 30 +++++++++++++++++++++++-------
>  tools/lib/perf/tests/test-evsel.c        |  3 ++-
>  tools/lib/perf/tests/test-threadmap.c    |  3 ++-
>  tools/lib/perf/tests/tests.h             | 10 ++++++++++
>  tools/perf/arch/x86/util/iostat.c        |  4 ++--
>  tools/perf/builtin-diff.c                |  4 ++--
>  tools/perf/builtin-record.c              |  4 ++--
>  tools/perf/builtin-report.c              |  8 ++++----
>  tools/perf/builtin-script.c              |  9 +++++----
>  tools/perf/builtin-stat.c                | 12 ++++++------
>  tools/perf/builtin-top.c                 | 10 +++++-----
>  tools/perf/tests/bpf.c                   |  2 +-
>  tools/perf/tests/evsel-roundtrip-name.c  |  6 +++---
>  tools/perf/tests/mmap-basic.c            |  8 ++++----
>  tools/perf/tests/parse-events.c          | 74 +++++++++++++++++++++++++++++++++++++-------------------------------------
>  tools/perf/tests/pfm.c                   |  4 ++--
>  tools/perf/ui/browsers/annotate.c        |  2 +-
>  tools/perf/util/annotate.c               |  8 ++++----
>  tools/perf/util/auxtrace.c               | 12 ++++++------
>  tools/perf/util/cgroup.c                 |  2 +-
>  tools/perf/util/evlist.c                 | 44 +++++++++++++-------------------------------
>  tools/perf/util/evlist.h                 |  2 --
>  tools/perf/util/evsel.c                  | 32 +++++++++++++++++++++++++-------
>  tools/perf/util/evsel.h                  | 14 ++++++++------
>  tools/perf/util/header.c                 | 18 +++++++++---------
>  tools/perf/util/metricgroup.c            | 22 +++++++++++-----------
>  tools/perf/util/parse-events.c           |  8 ++++----
>  tools/perf/util/pfm.c                    |  2 +-
>  tools/perf/util/python.c                 |  2 +-
>  tools/perf/util/record.c                 |  6 +++---
>  tools/perf/util/stat-shadow.c            |  2 +-
>  tools/perf/util/stat.c                   |  2 +-
>  tools/perf/util/stream.c                 |  2 +-
>  46 files changed, 310 insertions(+), 224 deletions(-)
>  create mode 100644 tools/lib/perf/tests/Build
>  delete mode 100644 tools/lib/perf/tests/Makefile
>  create mode 100644 tools/lib/perf/tests/main.c
>  create mode 100644 tools/lib/perf/tests/tests.h
> 

-- 

- Arnaldo
