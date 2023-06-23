Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF4EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 15:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjFWPLX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjFWPLJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5982950
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:10:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd5b8a9d82cso1164457276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533034; x=1690125034;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FUa7aJDe332KJMbrrfq8+rXTMZSs6TUcvwlXqFrw4f4=;
        b=buCQ7AobFyOfUQhTRWfnpL5MysqUQy6IqKNAwfK/A6KTWMZksdzmTFv6Wc7f4LmdTH
         Hg/32i9jG/ouG/ij8ApZliWIq2IEjLhPZ9jh4IjgYg3iCo8qHw2HIDw3UZ1ctk2pbLig
         KKqm2HoLH+6KM4YvaEiTEb+gDsBVSE7QXxgKDCpFHT92yUnlElUr1b7cGBxsLIhRwV5r
         WCagZ0aooyD1l6GXPaRksmmty5ExsrQQr7jZNlS7BicFZdMtYHsmO41PJInkoGWV+jPY
         m2OWceI6IEXMb2YYGxAmxnKTvkrsdJz2dHQQ7N4LhUyOuDagxukM30bBLFnt0JuvNepz
         KPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533034; x=1690125034;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUa7aJDe332KJMbrrfq8+rXTMZSs6TUcvwlXqFrw4f4=;
        b=NjFPAZ6GCRVpfUH6Xjr4Fdrui8ZsXj5PlEXAZcok2LIN3QZeuPX5FF9qaISvENE+AI
         RS04XeYGk1y1++y9hiGNat7Yf9oqorUfDkZHOqsFibpx4lDBYUEvHAQQ3IxZ9ZdRcxZs
         7T95iljtUHX9Ck94xsOhaxu7doy6j0I26RLUdtZjuHrBlR1k5OP0Br41PJXMS06SzSlF
         X6W8DKAokKRsRagio8MIY5po5HRYU/57Mw6BnDWCqeszGILriiKu4LRzkrgIawYy85kC
         Wi4l769iVizX8jon8lB9X0+xmEKeS/aoH7mo9JnBoZI4WCBPm/FjaYRGDBoEEJv8GLTA
         TT9g==
X-Gm-Message-State: AC+VfDwuDZVBzu/zwz4P3UaepDJ4bdIoQ4jVs6sBEMsiijP3wHAnsrM3
        GKcwG+s7wp1IAEfF49uPZ0v1H2N95FUG
X-Google-Smtp-Source: ACHHUZ4WlgrFOOhwbt6uy/HTsZGrBBXq9mACGq2atguqeN9H8kQB/yEfifsQH/TLhBk5JrHwbhcVmYecDzer
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:748e:0:b0:bac:fd63:b567 with SMTP id
 p136-20020a25748e000000b00bacfd63b567mr10016177ybc.4.1687533034231; Fri, 23
 Jun 2023 08:10:34 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:10:04 -0700
Message-Id: <20230623151016.4193660-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 00/12] Add metric has_event, update intel vendor events
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
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a new has_event function for metrics so that events that can be
disabled by the kernel/firmware don't cause metrics to fail. Use this
function for Intel transaction metrics fixing "perf all metrics test"
on systems with TSX disabled. The update conversion script is posted in:
https://github.com/intel/perfmon/pull/90

Re-generate Intel vendor events using:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
Adding rocketlake support, uncore and many core events for meteorlake,
and smaller updates for cascakelakex, icelake, icelakex,
sapphirerapids, skylake, skylakex and tigerlake.

v2. Handle failed memory allocated for evlist, John Garry.

Ian Rogers (12):
  perf expr: Add has_event function
  perf jevents: Support for has_event function
  perf vendor metrics intel: Make transaction metrics conditional
  perf vendor events intel: Add rocketlake events/metrics
  perf vendor events intel: Update meteorlake to 1.03
  perf vendor events intel: Update cascadelakex to 1.19
  perf vendor events intel: Update icelake to 1.19
  perf vendor events intel: Update icelakex to 1.21
  perf vendor events intel: Update sapphirerapids to 1.14
  perf vendor events intel: Update skylake to 57
  perf vendor events intel: Update skylakex to 1.31
  perf vendor events intel: Update tigerlake to 1.13

 .../arch/x86/alderlake/adl-metrics.json       |    8 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |    8 +-
 .../arch/x86/cascadelakex/frontend.json       |   43 +-
 .../arch/x86/cascadelakex/pipeline.json       |   17 +-
 .../x86/cascadelakex/uncore-interconnect.json |    2 +-
 .../arch/x86/cascadelakex/uncore-memory.json  |    2 +-
 .../pmu-events/arch/x86/icelake/cache.json    |    8 +-
 .../pmu-events/arch/x86/icelake/frontend.json |   32 +-
 .../arch/x86/icelake/icl-metrics.json         |    8 +-
 .../pmu-events/arch/x86/icelake/pipeline.json |    6 +-
 .../arch/x86/icelakex/frontend.json           |   32 +-
 .../arch/x86/icelakex/icx-metrics.json        |    8 +-
 .../arch/x86/icelakex/pipeline.json           |    4 +-
 .../x86/icelakex/uncore-interconnect.json     |    2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   17 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  811 +++++++++
 .../arch/x86/meteorlake/floating-point.json   |  143 ++
 .../arch/x86/meteorlake/frontend.json         |  410 +++++
 .../arch/x86/meteorlake/memory.json           |  142 +-
 .../pmu-events/arch/x86/meteorlake/other.json |   57 +-
 .../arch/x86/meteorlake/pipeline.json         | 1211 ++++++++++++-
 .../arch/x86/meteorlake/uncore-cache.json     |   18 +
 .../x86/meteorlake/uncore-interconnect.json   |   42 +
 .../arch/x86/meteorlake/uncore-memory.json    |  126 ++
 .../arch/x86/meteorlake/virtual-memory.json   |  257 +++
 .../pmu-events/arch/x86/rocketlake/cache.json |  894 ++++++++++
 .../arch/x86/rocketlake/floating-point.json   |  105 ++
 .../arch/x86/rocketlake/frontend.json         |  377 ++++
 .../arch/x86/rocketlake/memory.json           |  394 +++++
 .../arch/x86/rocketlake/metricgroups.json     |  113 ++
 .../pmu-events/arch/x86/rocketlake/other.json |  242 +++
 .../arch/x86/rocketlake/pipeline.json         |  801 +++++++++
 .../arch/x86/rocketlake/rkl-metrics.json      | 1571 +++++++++++++++++
 .../x86/rocketlake/uncore-interconnect.json   |   74 +
 .../arch/x86/rocketlake/uncore-other.json     |    9 +
 .../arch/x86/rocketlake/virtual-memory.json   |  165 ++
 .../arch/x86/sapphirerapids/pipeline.json     |    2 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  |    8 +-
 .../arch/x86/sapphirerapids/uncore-cache.json |  308 ++++
 .../sapphirerapids/uncore-interconnect.json   |    2 +-
 .../pmu-events/arch/x86/skylake/frontend.json |   43 +-
 .../pmu-events/arch/x86/skylake/pipeline.json |   17 +-
 .../arch/x86/skylake/skl-metrics.json         |    8 +-
 .../arch/x86/skylakex/frontend.json           |   43 +-
 .../arch/x86/skylakex/pipeline.json           |   17 +-
 .../arch/x86/skylakex/skx-metrics.json        |    8 +-
 .../x86/skylakex/uncore-interconnect.json     |    2 +-
 .../arch/x86/skylakex/uncore-memory.json      |    2 +-
 .../arch/x86/tigerlake/frontend.json          |   32 +-
 .../arch/x86/tigerlake/pipeline.json          |    6 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |    8 +-
 tools/perf/pmu-events/metric.py               |    8 +-
 tools/perf/tests/expr.c                       |    4 +
 tools/perf/util/expr.c                        |   21 +
 tools/perf/util/expr.h                        |    1 +
 tools/perf/util/expr.l                        |    1 +
 tools/perf/util/expr.y                        |    8 +-
 57 files changed, 8506 insertions(+), 202 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/virtual-memory.json

-- 
2.41.0.162.gfafddb0af9-goog

