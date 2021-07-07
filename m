Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A562BC07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECBA61C72
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhGGSXA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232067AbhGGSWv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 14:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625682010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AONbdOElNVA6Dx7kA8iOl08aAX5KPGMe0+7XYqoXzU=;
        b=Xc7StHwfnckUvJ66bWAxAWqRkUzBkN+c4GjgqTxWwJJBT31O5JQNYYi9yQjk9HpXX83BH8
        kOXUzPdzkr5TBt3aY03jio8iFgvMiodkZM8iPjoOkk7QAg3ovC3wa2aZ/nGjgNFjDcyTnl
        vtHTqDT7v8IbnDkwHAMXjjD4QviUgSM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-B2Abvg-nOUCAQaUSvdzBTw-1; Wed, 07 Jul 2021 14:20:09 -0400
X-MC-Unique: B2Abvg-nOUCAQaUSvdzBTw-1
Received: by mail-wr1-f72.google.com with SMTP id a4-20020adffb840000b02901304c660e75so1044872wrr.19
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jul 2021 11:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4AONbdOElNVA6Dx7kA8iOl08aAX5KPGMe0+7XYqoXzU=;
        b=Ym/+OOGkjfb71wMaSDMWy3qsOS9XzMshN3HvrHANV+astCFUbi0V3jLZxas36sE4eL
         zljQVVslo48c3TI+WAkR9af5dzn5/AM+k/4EtOiz/07Bew5YoWhzN82EE8FhrAP75i6Z
         y3FkG3h1KJo74zMo37dXlxtujikiN070aloIefvxW9l7kwPsSjVRe52hUuXo7fT5GdLc
         7vnzkAYzzxV2JBfZP6+jQ95TCA2oCKSZhCK7Cc7AO5NflTvK4TXA7+6pXeIsY2R3iuso
         SwmDnnQAzjWweh3/Ma+Q0jw7ys4nMGMWz8drnnxEtRENfPvv2FiZRHBTgLtnjFYTF0Uy
         dCSQ==
X-Gm-Message-State: AOAM533eFmgBx/XGLIkfVT2wR2hqFfQk5yRtBOzJTQDHlPctj0CJ4v8/
        fOViAdNx7vox6aavCC8rqNlhhwPS2KxnegPbYwJmz8ytT9QQi70lYCybyqU3QIdm9QdTOhhHy50
        3yZjGev0qBw2Oh68khzHZ+sw04BkVUA==
X-Received: by 2002:adf:edc4:: with SMTP id v4mr29481936wro.54.1625682008256;
        Wed, 07 Jul 2021 11:20:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaXEKTieGyjfVUIMyo4K5xvdOFkeQ+zh4QglF053YAlFPCnlZK49ypa+BjyHd0h/Ycr2wD8g==
X-Received: by 2002:adf:edc4:: with SMTP id v4mr29481918wro.54.1625682008092;
        Wed, 07 Jul 2021 11:20:08 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id c8sm20570919wri.91.2021.07.07.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:20:07 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:20:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <YOXwVPS6zIyw0C/k@krava>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <YOW+eyxYtPhc2hSf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOW+eyxYtPhc2hSf@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 07, 2021 at 11:47:23AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 06, 2021 at 05:16:57PM +0200, Jiri Olsa escreveu:
> > hi,
> > moving leader/group info to libperf's perf_evsel.
> > 
> > This was asked for by Shunsuke [1] and is on my list
> > as a prereq for event parsing move to libperf.
> 
> So I'll add a:
> 
> Requested-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

yep, but let's hear from him first if that's the case actualy ;-)

he did not mention any specific interface.. so I wonder
what we have is ok with him

thanks,
jirka

> 
> - Arnaldo
>  
> > I still need to do more tests, but I'd like to check
> > with you guys if there's any feedback on this first.
> > 
> > Also available in:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   libperf/groups
> > 
> > v2 change:
> >   - repost due to smtp failures, no changes
> > 
> > thanks,
> > jirka
> > 
> > 
> > [1] https://lore.kernel.org/linux-perf-users/OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com/
> > 
> > 
> > ---
> > Jiri Olsa (7):
> >       libperf: Change tests to single static and shared binaries
> >       libperf: Move idx to perf_evsel::idx
> >       libperf: Move leader to perf_evsel::leader
> >       libperf: Move nr_groups to evlist::nr_groups
> >       libperf: Add perf_evlist__set_leader function
> >       libperF: Add group support to perf_evsel__open
> >       libperf: Add tests for perf_evlist__set_leader function
> > 
> >  tools/lib/perf/Build                     |  2 ++
> >  tools/lib/perf/Makefile                  | 30 +++++++++++++++++++++++++-----
> >  tools/lib/perf/evlist.c                  | 22 ++++++++++++++++++++++
> >  tools/lib/perf/evsel.c                   | 33 +++++++++++++++++++++++++++++----
> >  tools/lib/perf/include/internal/evlist.h |  2 ++
> >  tools/lib/perf/include/internal/evsel.h  |  5 ++++-
> >  tools/lib/perf/include/internal/tests.h  |  4 ++--
> >  tools/lib/perf/include/perf/evlist.h     |  1 +
> >  tools/lib/perf/libperf.map               |  1 +
> >  tools/lib/perf/tests/Build               |  5 +++++
> >  tools/lib/perf/tests/Makefile            | 40 ----------------------------------------
> >  tools/lib/perf/tests/main.c              | 15 +++++++++++++++
> >  tools/lib/perf/tests/test-cpumap.c       |  3 ++-
> >  tools/lib/perf/tests/test-evlist.c       | 30 +++++++++++++++++++++++-------
> >  tools/lib/perf/tests/test-evsel.c        |  3 ++-
> >  tools/lib/perf/tests/test-threadmap.c    |  3 ++-
> >  tools/lib/perf/tests/tests.h             | 10 ++++++++++
> >  tools/perf/arch/x86/util/iostat.c        |  4 ++--
> >  tools/perf/builtin-diff.c                |  4 ++--
> >  tools/perf/builtin-record.c              |  4 ++--
> >  tools/perf/builtin-report.c              |  8 ++++----
> >  tools/perf/builtin-script.c              |  9 +++++----
> >  tools/perf/builtin-stat.c                | 12 ++++++------
> >  tools/perf/builtin-top.c                 | 10 +++++-----
> >  tools/perf/tests/bpf.c                   |  2 +-
> >  tools/perf/tests/evsel-roundtrip-name.c  |  6 +++---
> >  tools/perf/tests/mmap-basic.c            |  8 ++++----
> >  tools/perf/tests/parse-events.c          | 74 +++++++++++++++++++++++++++++++++++++-------------------------------------
> >  tools/perf/tests/pfm.c                   |  4 ++--
> >  tools/perf/ui/browsers/annotate.c        |  2 +-
> >  tools/perf/util/annotate.c               |  8 ++++----
> >  tools/perf/util/auxtrace.c               | 12 ++++++------
> >  tools/perf/util/cgroup.c                 |  2 +-
> >  tools/perf/util/evlist.c                 | 44 +++++++++++++-------------------------------
> >  tools/perf/util/evlist.h                 |  2 --
> >  tools/perf/util/evsel.c                  | 32 +++++++++++++++++++++++++-------
> >  tools/perf/util/evsel.h                  | 14 ++++++++------
> >  tools/perf/util/header.c                 | 18 +++++++++---------
> >  tools/perf/util/metricgroup.c            | 22 +++++++++++-----------
> >  tools/perf/util/parse-events.c           |  8 ++++----
> >  tools/perf/util/pfm.c                    |  2 +-
> >  tools/perf/util/python.c                 |  2 +-
> >  tools/perf/util/record.c                 |  6 +++---
> >  tools/perf/util/stat-shadow.c            |  2 +-
> >  tools/perf/util/stat.c                   |  2 +-
> >  tools/perf/util/stream.c                 |  2 +-
> >  46 files changed, 310 insertions(+), 224 deletions(-)
> >  create mode 100644 tools/lib/perf/tests/Build
> >  delete mode 100644 tools/lib/perf/tests/Makefile
> >  create mode 100644 tools/lib/perf/tests/main.c
> >  create mode 100644 tools/lib/perf/tests/tests.h
> > 
> 
> -- 
> 
> - Arnaldo
> 

