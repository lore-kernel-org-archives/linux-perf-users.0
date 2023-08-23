Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCE0EE49B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 08:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHWIJo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjHWIJK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DF2E60
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58e4d2b7d16so71989417b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778112; x=1693382912;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F2JVycqj7NyzXptj4+H0IvIRwFTBhGtFQhZxDM1SxBA=;
        b=hPFzweU/vPs5vXDl3IvqbHUSZT/woIU8PZMfdhekcWrr/26OCLjJfo/qBcq4q7ZMsv
         QU73QX8wiv4A3GBJDkOiaTCJaJhs8K/LfdwQc8EV9ltbJadYp3y2hp9EnpjddCCuugJV
         qOlxdV/9DByiwFjXWtRHrlS/jXuO0Aj9Dp336hYc0l07yV0c8C1ERKWWfvQblOfOZ9IA
         qVJFQSaQMQLx61sUwGaKivfCT+jhJIwbTCWVv9PdGB/SsX3J/xfM8lLuIYIvvasL+rGU
         pe3HnwCWHYAq2t8eLzlV8WIv+5KmABrBjM29CsqAh0XMjZSZnj6c0Lgp4CgIucF8UdA7
         rZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778112; x=1693382912;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2JVycqj7NyzXptj4+H0IvIRwFTBhGtFQhZxDM1SxBA=;
        b=d+wWmbZVJP9GBkXgdK/31FRK7Yr7oIJopHgIFNWl/4kVfC/v4ItYY+5RfTIdN8w19z
         VPubsx4qRx53Lb5Nov1blWy0WKAMv64yaJLMQVk5bmCezBjLTjsGArSBeYMDYCRkfxRA
         MkopI7fUkwxhMChgQNL4MN1UghHu1HJ55mipFvtfyT4g88J5QTdAfEdO+sfu/GLW4ocE
         LCU3PHujiug9Q+z99J7GSka65OkBWddHCUX65BYgRoI+kYSCPkywcehr+Ozm38jjgjrs
         emf8e0p+WwhmCW8J7TZQM2ZIaitG8X6sOvA0i2i/EMb2frUoST1IZpBOHKuNPZ7thxr8
         YCSA==
X-Gm-Message-State: AOJu0YwpQ/hMD4dqjOQ5AoyodBLl7V/mepvW868lfZJuRY0jWW4efmOp
        EBwWvRW31c7vpUrZKG43o06ose8eRaAW
X-Google-Smtp-Source: AGHT+IFDpiyvw2quRyqNwtWZepy68qkaJhARjQRj4Xbv5XR4q+3rBCbNgfUiVt+dUc4SB+NEmDDXm4qGO4Ka
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a25:2c7:0:b0:cb1:918b:d19b with SMTP id
 190-20020a2502c7000000b00cb1918bd19bmr145769ybc.0.1692778112102; Wed, 23 Aug
 2023 01:08:32 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:03 -0700
Message-Id: <20230823080828.1460376-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 00/25] Lazily load PMU data
From:   Ian Rogers <irogers@google.com>
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
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Lazily load PMU data both from sysfs and json files. Reorganize
json data to be more PMU oriented to facilitate this, for
example, json data is now sorted into arrays for their PMU.

In refactoring the code some changes were made to get rid of maximum
encoding sizes for events (256 bytes), with input files being directly
passed to the lex generated code. There is also a small event parse
error message improvement.

Some results from an Intel tigerlake laptop running Debian:

Binary size reduction of 1.4% or 143,264 bytes because the PMU
name no longer appears in the string.

stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open calls reduced
from 171 to 94.

stat default minor faults reduced from 1085 to 1727, open calls reduced
from 654 to 343.

Average PMU scanning reduced from 4720.641usec to 2927.293usec.
Average core PMU scanning reduced from 1004.658usec to 232.668usec
(4.3x faster).

Ian Rogers (25):
  perf script ibs: Remove unused include
  perf pmu: Avoid a path name copy
  perf pmu: Move perf_pmu__set_format to pmu.y
  perf pmu: Reduce scope of perf_pmu_error
  perf pmu: Avoid passing format list to perf_pmu__config_terms
  perf pmu: Avoid passing format list to perf_pmu__format_type
  perf pmu: Avoid passing format list to perf_pmu__format_bits
  perf pmu: Pass PMU rather than aliases and format
  perf pmu: Make the loading of formats lazy
  perf pmu: Abstract alias/event struct
  perf pmu-events: Add extra underscore to function names
  perf jevents: Group events by PMU
  perf parse-events: Improve error message for double setting
  perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
  perf pmu-events: Reduce processed events by passing PMU
  perf pmu-events: Add pmu_events_table__find_event
  perf pmu: Parse sysfs events directly from a file
  perf pmu: Prefer passing pmu to aliases list
  perf pmu: Merge json events with sysfs at load time
  perf pmu: Cache json events table
  perf pmu: Lazily add json events
  perf pmu: Scan type early to fail an invalid PMU quickly
  perf pmu: Be lazy about loading event info files from sysfs
  perf pmu: Lazily load sysfs aliases
  perf jevents: Sort strings in the big C string to reduce faults

 tools/perf/arch/x86/util/intel-pt.c      |  39 +-
 tools/perf/bench/pmu-scan.c              |   8 +-
 tools/perf/pmu-events/empty-pmu-events.c |  49 +-
 tools/perf/pmu-events/jevents.py         | 319 +++++++--
 tools/perf/pmu-events/pmu-events.h       |  15 +-
 tools/perf/tests/parse-events.c          |   2 +-
 tools/perf/tests/pmu-events.c            | 183 ++---
 tools/perf/tests/pmu.c                   |  76 +-
 tools/perf/util/amd-sample-raw.c         |   1 -
 tools/perf/util/metricgroup.c            |  10 +-
 tools/perf/util/parse-events.c           |  91 ++-
 tools/perf/util/parse-events.h           |   3 +-
 tools/perf/util/pmu.c                    | 872 +++++++++++++++--------
 tools/perf/util/pmu.h                    | 110 ++-
 tools/perf/util/pmu.y                    |  32 +-
 tools/perf/util/pmus.c                   | 230 ++----
 tools/perf/util/s390-sample-raw.c        |  50 +-
 17 files changed, 1251 insertions(+), 839 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

