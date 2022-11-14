Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B88FC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 07:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiKNHvp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 02:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiKNHvn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 02:51:43 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380A618E26
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Nov 2022 23:51:43 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id h16-20020a170902f55000b001871b770a83so8375541plf.9
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Nov 2022 23:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G6SAmxX7apXJc1sZ6rk+vGVz5JqMggUrClmeEtAw6v8=;
        b=bQwfvaqnGgw3iau0Mqw9WIaSEQ3ScV4gxhh1hWdcHbvItifG7Lgv4sbWAj9/Nvv4hx
         O/BTIUqD6HoaIQqaPYVVgL2NwGzTO8oNGQNSQxroakZnguud1K7UqJC/QbXwLUH6U5Cy
         O/0y4jVcpZHLW9fpNt7kx5BpZuOl1Ne1BLvJIvFHI6lUDgWcS2NTrUympRPdB40vmzA8
         4c1VRCNc2W6oAwMAo2DtDDy+diH0NqDkRe7UUo//EVafVgJCZfjprVhdeopeU23gTCxS
         CFFIoHiXogb+9ZvcHksfSuamruT3nJTlM9g8P8PLWMD59AzMAOBQZxmeS6Pc/5ACjFpb
         ADKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6SAmxX7apXJc1sZ6rk+vGVz5JqMggUrClmeEtAw6v8=;
        b=Dej50lJR5s43MKCbeKT1Fccd8EausC3urNEuPGB6l+y2pFBOVkdEew4vlQhCxNohLV
         k/w5B4q64KBtemDbrNgmwsN6gMcWot77CsVpfA9RU72iMHneoAHGm7g7Yz13QSWKTwzm
         ZKbbYsHmJllwEW7EgZe358n/0vzclQzKyAao6pUxcEFLB9dqwOYX9n2tohj6oB02IhOL
         o8opR7Czw4HvZsHnY0GPZ9nslhIC/dqMzndMFhhash0YMArFFn0tYFR5AlPpk+n60Upo
         4/X2ikB/394bXCyJBC9BO1MCMc/w16LD9avg71u8j/1vmG3//ZbWdUotV2tVo9qbGFWD
         vWpA==
X-Gm-Message-State: ANoB5pl0xiz6wHwxTDX/Jiz3RzA5xT/dRf2vgWvQdE9Yi3uZc6muNwxo
        MQVstqtSlXwPNbLhV8ty/1BAK8/1dKo9
X-Google-Smtp-Source: AA0mqf6yrRvPV60i0ASJWQGSbHOO4Xlx2AzyaU1Rn44gk+Qrajc3HzCqBUk4zZ0pL/SPC7wYPWWY7pT0o58h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a17:902:f80a:b0:186:8376:209f with SMTP id
 ix10-20020a170902f80a00b001868376209fmr12625608plb.161.1668412302667; Sun, 13
 Nov 2022 23:51:42 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:18 -0800
Message-Id: <20221114075127.2650315-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 0/9] Restructure perf list and add json output
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Restructure perf list so that it uses callbacks to print events and
metrics. Use the callbacks to implement json output. In the process
add documentation to pmu.h, avoid some sorting of events, fix some
command line and output bugs.

Ian Rogers (9):
  perf pmu: Add documentation
  tools lib api fs tracing_path: Add scandir alphasort
  perf tracepoint: Sort events in iterator
  perf list: Generalize limiting to a PMU name
  perf list: Simplify cache event printing
  perf list: Simplify symbol event printing
  perf pmu: Restructure print_pmu_events
  perf list: Reorganize to use callbacks
  perf list: Add json output option

 tools/lib/api/fs/tracing_path.c        |  16 +
 tools/lib/api/fs/tracing_path.h        |   1 +
 tools/perf/Documentation/perf-list.txt |  10 +-
 tools/perf/builtin-list.c              | 503 +++++++++++++++++---
 tools/perf/util/metricgroup.c          | 238 +++-------
 tools/perf/util/metricgroup.h          |   4 +-
 tools/perf/util/pmu.c                  | 277 +++++------
 tools/perf/util/pmu.h                  | 110 ++++-
 tools/perf/util/print-events.c         | 630 ++++++++++---------------
 tools/perf/util/print-events.h         |  40 +-
 10 files changed, 1034 insertions(+), 795 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

