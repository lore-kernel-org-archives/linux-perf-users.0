Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6044EE4993
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 08:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjHWIao (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjHWI3X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 04:29:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F42B1722
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:12:39 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40c72caec5cso251041cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778359; x=1693383159;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hAS0PucsjGJ0x+ONVaiQoPrUdvJWs0Q6o9fYxtLr1Y=;
        b=jH89Lz24KB4c4HeG4wUCO0s6Q7VX+mz8HZQmZAsTCy1XOaRjkXM3VVAkCwsTGOXHau
         /wipm8OF2SsaEqCBDl3n1ssRgdH+09Yjgdhe97QfoXAnESDZKP7M0x9YgEyAZP7V/U1/
         ypUJOvwz9jzxWi6Oj60FWEhagE27LYaTRgcxAzmr12jWM/M1J2y7W4WUCJZWV234iawA
         Pvh0pJ0HQKNg5P0RMiqlTYWjclXeBLGXQ0CWC5th8JfEat7EDEKmlLjwK509liO9qE9u
         18df3qnXWzO9AI9J0lANmDZiHYBUL0VISHc72rVD01xI8mbIjpyuQpqGFe///Z4J3AfQ
         9ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778359; x=1693383159;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hAS0PucsjGJ0x+ONVaiQoPrUdvJWs0Q6o9fYxtLr1Y=;
        b=Q6pTsr0kJvrLcMXQ7RJj5d1tePbU0LTnRGGIeTbPhMvATgutup0qXi5VYZlB3fiapM
         BDL/LYyuGm+RZfk5hhiwDr4TVh3KaBpJuUURPTch4bWUAZAsMENq78pKg3lUxplsGOh2
         WvIlA44gD/fKnOHJUiz3gz1+WvbyM2PHxTSEnM82L4FfJai2VyMGjXIvT6jhFBbzD1KK
         RYAUM3zZ7Gjs4qseJLP751DtTRvXJHIpGriWpz6bE5z1I6Ua0ltDRqHTkrIseuudp+iK
         u4zYkO3ED0NDIc70K2y5ALHV6/dtksStC52ZXhjHUYXViVRbTpJF2Ye7n/mVEAG8NJT1
         z/TQ==
X-Gm-Message-State: AOJu0YxqDDonpa+bCwxuBba5QZ4lDGod6ceE2wIfHtabxLH5VSz00eQ0
        33lfEKO5vduX6DuT+yVj4VFshzk0SDwvrREjDeoGDw==
X-Google-Smtp-Source: AGHT+IE77K8yRPmJ2SQORc9C/8F23EPMFOTtGihYaUoykwCv43DtexAo6gDBGFGSHRNTiHfVT1iWXndiEs+MoCe4pzk=
X-Received: by 2002:ac8:5a47:0:b0:410:653f:90e8 with SMTP id
 o7-20020ac85a47000000b00410653f90e8mr425655qta.11.1692778358905; Wed, 23 Aug
 2023 01:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Aug 2023 01:12:27 -0700
Message-ID: <CAP-5=fX3a=Ng=8Gd-DNx1+dKj7QEZJxMCFW_=brdU52ADuwf7g@mail.gmail.com>
Subject: Re: [PATCH v1 00/25] Lazily load PMU data
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 23, 2023 at 1:08=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Lazily load PMU data both from sysfs and json files. Reorganize
> json data to be more PMU oriented to facilitate this, for
> example, json data is now sorted into arrays for their PMU.
>
> In refactoring the code some changes were made to get rid of maximum
> encoding sizes for events (256 bytes), with input files being directly
> passed to the lex generated code. There is also a small event parse
> error message improvement.
>
> Some results from an Intel tigerlake laptop running Debian:
>
> Binary size reduction of 1.4% or 143,264 bytes because the PMU
> name no longer appears in the string.
>
> stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open calls re=
duced
> from 171 to 94.
>
> stat default minor faults reduced from 1085 to 1727, open calls reduced
> from 654 to 343.

s/1085/1805/

Thanks,
Ian

>
> Average PMU scanning reduced from 4720.641usec to 2927.293usec.
> Average core PMU scanning reduced from 1004.658usec to 232.668usec
> (4.3x faster).
>
> Ian Rogers (25):
>   perf script ibs: Remove unused include
>   perf pmu: Avoid a path name copy
>   perf pmu: Move perf_pmu__set_format to pmu.y
>   perf pmu: Reduce scope of perf_pmu_error
>   perf pmu: Avoid passing format list to perf_pmu__config_terms
>   perf pmu: Avoid passing format list to perf_pmu__format_type
>   perf pmu: Avoid passing format list to perf_pmu__format_bits
>   perf pmu: Pass PMU rather than aliases and format
>   perf pmu: Make the loading of formats lazy
>   perf pmu: Abstract alias/event struct
>   perf pmu-events: Add extra underscore to function names
>   perf jevents: Group events by PMU
>   perf parse-events: Improve error message for double setting
>   perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
>   perf pmu-events: Reduce processed events by passing PMU
>   perf pmu-events: Add pmu_events_table__find_event
>   perf pmu: Parse sysfs events directly from a file
>   perf pmu: Prefer passing pmu to aliases list
>   perf pmu: Merge json events with sysfs at load time
>   perf pmu: Cache json events table
>   perf pmu: Lazily add json events
>   perf pmu: Scan type early to fail an invalid PMU quickly
>   perf pmu: Be lazy about loading event info files from sysfs
>   perf pmu: Lazily load sysfs aliases
>   perf jevents: Sort strings in the big C string to reduce faults
>
>  tools/perf/arch/x86/util/intel-pt.c      |  39 +-
>  tools/perf/bench/pmu-scan.c              |   8 +-
>  tools/perf/pmu-events/empty-pmu-events.c |  49 +-
>  tools/perf/pmu-events/jevents.py         | 319 +++++++--
>  tools/perf/pmu-events/pmu-events.h       |  15 +-
>  tools/perf/tests/parse-events.c          |   2 +-
>  tools/perf/tests/pmu-events.c            | 183 ++---
>  tools/perf/tests/pmu.c                   |  76 +-
>  tools/perf/util/amd-sample-raw.c         |   1 -
>  tools/perf/util/metricgroup.c            |  10 +-
>  tools/perf/util/parse-events.c           |  91 ++-
>  tools/perf/util/parse-events.h           |   3 +-
>  tools/perf/util/pmu.c                    | 872 +++++++++++++++--------
>  tools/perf/util/pmu.h                    | 110 ++-
>  tools/perf/util/pmu.y                    |  32 +-
>  tools/perf/util/pmus.c                   | 230 ++----
>  tools/perf/util/s390-sample-raw.c        |  50 +-
>  17 files changed, 1251 insertions(+), 839 deletions(-)
>
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
