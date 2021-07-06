Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A521CC07E96
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 13:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E4861C82
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 13:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhGFNPA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231504AbhGFNO4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 09:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625577135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aPcv2FhczGXfb0Fzq3d94pKmcL+xjGfR4nhsVcDzM9M=;
        b=I45GUJleWfHB7/FIG/YMk47SnEfJWtwgbbEH+h1LdHBe3uQe7rF6LlPM2IlBVObDSfH62d
        bF/Pwar3tIduVhmt9ENLOujHuErChXg72WMjJdkxjTwoT5r3QJd/dcXngTOqOxvUPU/01b
        QOGIK7JhtqJzAdHz29+fis+DMiY3WDc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-9GE4o35MMkqfinTyrQ9kLA-1; Tue, 06 Jul 2021 09:12:14 -0400
X-MC-Unique: 9GE4o35MMkqfinTyrQ9kLA-1
Received: by mail-wm1-f69.google.com with SMTP id j38-20020a05600c1c26b02901dbf7d18ff8so1079634wms.8
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 06:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPcv2FhczGXfb0Fzq3d94pKmcL+xjGfR4nhsVcDzM9M=;
        b=PuON06Lm88fNEbv/4zTLu7lJclfO0ibgTp6bcYC+isalWMTK7uasRWhrjOyTHyI6mp
         xuitBoV/JncrkMMsaokUZjoA0PxzOETIXwyVg1vhS4XTae++tN6Y+yU/TrrBafhwxm8g
         e+mcmoR8QSUvHIDL/U0634rv2OaeXbhpk11fqK0rmCo3NFtGpbuI3TinbgUx0OwMq2aZ
         3pJG3fqxY13CtglQ+EIXn72r0eZorhQOcpm6kzuDdLUgz9z8ZVEmvkkkoh97Q1MU5XjV
         oH7crVa95E7rPdc/I35QWuRoSe/JO2G3QUmY9+SvCN1e3+0sZflZtU50nhip3IR2cqLz
         /DXw==
X-Gm-Message-State: AOAM533wsnhC5KqFJz75egIYmGUmESQzvDtKK0+D893NqcsreBr2CS1c
        b5+0Hnc3B+/I4zM6t+ktj76kXeCrp4FgYHCaJhGV/rrryYsnk+Dco+flWHgNVm4sEPTKa9N7dyk
        iBC4SxnWfrtIKGMw34jsfMzsz4xPWjg==
X-Received: by 2002:adf:e5c9:: with SMTP id a9mr20663401wrn.376.1625577132601;
        Tue, 06 Jul 2021 06:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgFJEYIIwEvlI6H8xsdg3uJepFOQkIYAceHyhovY6B4OFYgZ3B6GXsGPyS7fJ48weoEYLmRA==
X-Received: by 2002:adf:e5c9:: with SMTP id a9mr20663358wrn.376.1625577132368;
        Tue, 06 Jul 2021 06:12:12 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id h14sm18824223wro.32.2021.07.06.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 06:12:11 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
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
Subject: [RFC 0/7] libperf: Add leader/group info to perf_evsel
Date:   Tue,  6 Jul 2021 15:12:02 +0200
Message-Id: <20210706131209.69782-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

hi,
moving leader/group info to libperf's perf_evsel.

This was asked for by Shunsuke [1] and is on my list
as a prereq for event parsing move to libperf.

I still need to do more tests, but I'd like to check
with you guys if there's any feedback on this first.

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  libperf/groups

thanks,
jirka


[1] https://lore.kernel.org/linux-perf-users/OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com/


---
Jiri Olsa (7):
      libperf: Change tests to single static and shared binaries
      libperf: Move idx to perf_evsel::idx
      libperf: Move leader to perf_evsel::leader
      libperf: Move nr_groups to evlist::nr_groups
      libperf: Add perf_evlist__set_leader function
      libperF: Add group support to perf_evsel__open
      libperf: Add tests for perf_evlist__set_leader function

 tools/lib/perf/Build                     |  2 ++
 tools/lib/perf/Makefile                  | 30 +++++++++++++++++++++++++-----
 tools/lib/perf/evlist.c                  | 22 ++++++++++++++++++++++
 tools/lib/perf/evsel.c                   | 33 +++++++++++++++++++++++++++++----
 tools/lib/perf/include/internal/evlist.h |  2 ++
 tools/lib/perf/include/internal/evsel.h  |  5 ++++-
 tools/lib/perf/include/internal/tests.h  |  4 ++--
 tools/lib/perf/include/perf/evlist.h     |  1 +
 tools/lib/perf/libperf.map               |  1 +
 tools/lib/perf/tests/Build               |  5 +++++
 tools/lib/perf/tests/Makefile            | 40 ----------------------------------------
 tools/lib/perf/tests/main.c              | 15 +++++++++++++++
 tools/lib/perf/tests/test-cpumap.c       |  3 ++-
 tools/lib/perf/tests/test-evlist.c       | 30 +++++++++++++++++++++++-------
 tools/lib/perf/tests/test-evsel.c        |  3 ++-
 tools/lib/perf/tests/test-threadmap.c    |  3 ++-
 tools/lib/perf/tests/tests.h             | 10 ++++++++++
 tools/perf/arch/x86/util/iostat.c        |  4 ++--
 tools/perf/builtin-diff.c                |  4 ++--
 tools/perf/builtin-record.c              |  4 ++--
 tools/perf/builtin-report.c              |  8 ++++----
 tools/perf/builtin-script.c              |  9 +++++----
 tools/perf/builtin-stat.c                | 12 ++++++------
 tools/perf/builtin-top.c                 | 10 +++++-----
 tools/perf/tests/bpf.c                   |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c  |  6 +++---
 tools/perf/tests/mmap-basic.c            |  8 ++++----
 tools/perf/tests/parse-events.c          | 74 +++++++++++++++++++++++++++++++++++++-------------------------------------
 tools/perf/tests/pfm.c                   |  4 ++--
 tools/perf/ui/browsers/annotate.c        |  2 +-
 tools/perf/util/annotate.c               |  8 ++++----
 tools/perf/util/auxtrace.c               | 12 ++++++------
 tools/perf/util/cgroup.c                 |  2 +-
 tools/perf/util/evlist.c                 | 44 +++++++++++++-------------------------------
 tools/perf/util/evlist.h                 |  2 --
 tools/perf/util/evsel.c                  | 32 +++++++++++++++++++++++++-------
 tools/perf/util/evsel.h                  | 14 ++++++++------
 tools/perf/util/header.c                 | 18 +++++++++---------
 tools/perf/util/metricgroup.c            | 22 +++++++++++-----------
 tools/perf/util/parse-events.c           |  8 ++++----
 tools/perf/util/pfm.c                    |  2 +-
 tools/perf/util/python.c                 |  2 +-
 tools/perf/util/record.c                 |  6 +++---
 tools/perf/util/stat-shadow.c            |  2 +-
 tools/perf/util/stat.c                   |  2 +-
 tools/perf/util/stream.c                 |  2 +-
 46 files changed, 310 insertions(+), 224 deletions(-)
 create mode 100644 tools/lib/perf/tests/Build
 delete mode 100644 tools/lib/perf/tests/Makefile
 create mode 100644 tools/lib/perf/tests/main.c
 create mode 100644 tools/lib/perf/tests/tests.h

