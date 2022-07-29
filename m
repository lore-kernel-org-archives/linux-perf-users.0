Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62FCC00144
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 20:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiG2Umc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiG2Umb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 16:42:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1E5A15B
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 13:42:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s14-20020a5b044e000000b00672caf96368so4638200ybp.21
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rKpsJkAvhpK46Oj026Hnlt3lw23B8Cir0Qd7OTp8i94=;
        b=dss7HY6AV15fZ2XVOxvesgo5Sb3jz0aFRmH+hnMlXqSzfuD+WfMczxtF7b51UR+JGR
         bqMVPJUdIjCNjGjapGnP29VAASb528hSsSUDRiR7R3vmJB4PYH/jjFTLK/0K1fGYVaHl
         YHlGBAxkkkwhp8Z2vwDzB3XAB8xaUIE0wqIBTZaOdrqYUACzJrcc3OMuLGle5j5EYvls
         0PqBkgTGwB5xFUBEekhdjbPQQ3ZBZId3h4FnsnGoYf3Kjl5p4RdYu/B55aTARyiiObYx
         HYSPEEw4idJ704KeZSjcb9KxXwEzVCEVa3laqZBLAlmrxXmDymAf2reDnRIwjt1fEUHv
         OYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rKpsJkAvhpK46Oj026Hnlt3lw23B8Cir0Qd7OTp8i94=;
        b=iQ9fa5EB4aPO+nUUQPdkHIyrcHDiZnj7uQjZqCQtJlUja3jasQtGu1E0o+tbfWMWd9
         4kwDmyVkhTzauc6uTUkGTz+ZGsKXuykl+SbLoHVQMD5HNJc7hR3/UtURJqeCtcMhFJjl
         R3aRBaYrD9yyHqHJL5VbotDMFoGpNj+mbOUWre1G28oejgb823J5r/Mmz8bnel/8HrD3
         uoIcAkuXxwm5masuO4pEdo/kViUJEpEPREdTGFUrfwbvvfZH6iRHeJ83yB0rD4eo+4I4
         kg9gc29vZUyPb1tpiIzgp5qJlLp1B3xRmdNcBcBoZDiWWqHcOf/mFogSPrKGvlHxtlV5
         k+pw==
X-Gm-Message-State: ACgBeo3f0t9KIcqS6m6JBp4C5B3IowYwnWR4AhgWZe85brd5hTagTjl/
        39DP/2xH2SYPrmBiSt1DzAfN3V3si7d2
X-Google-Smtp-Source: AA6agR4ZZ4/L/oV7IUKIC48Wz9Yb4rYjAYbL1P2OxP2WEskCqZufqLL2yZR+AapD+iMe9y2Gco2or6qcmyuL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a25:230e:0:b0:676:a887:3006 with SMTP id
 j14-20020a25230e000000b00676a8873006mr4122720ybj.558.1659127348323; Fri, 29
 Jul 2022 13:42:28 -0700 (PDT)
Date:   Fri, 29 Jul 2022 13:42:15 -0700
Message-Id: <20220729204217.250166-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 0/2] perf parse-events: Break out tracepoint and printing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

parse-events.c is a large piece of code that doesn't need to contain the
printing (perf list) and tracepoint functionality. Split apart.

v3. Split removal of #define to its own change as suggested by Jiri
    Olsa <jolsa@kernel.org>.
v2. Rebase in particular after hybrid PMU changes.


Ian Rogers (2):
  perf parse-events: Don't #define YY_EXTRA_TYPE
  perf parse-events: Break out tracepoint and printing.

 tools/perf/builtin-list.c          |   2 +-
 tools/perf/builtin-lock.c          |   1 +
 tools/perf/builtin-timechart.c     |   1 +
 tools/perf/builtin-trace.c         |   1 +
 tools/perf/util/Build              |   2 +
 tools/perf/util/parse-events.c     | 714 +----------------------------
 tools/perf/util/parse-events.h     |  31 --
 tools/perf/util/print-events.c     | 571 +++++++++++++++++++++++
 tools/perf/util/print-events.h     |  22 +
 tools/perf/util/trace-event-info.c |  96 ++++
 tools/perf/util/tracepoint.c       |  63 +++
 tools/perf/util/tracepoint.h       |  25 +
 12 files changed, 790 insertions(+), 739 deletions(-)
 create mode 100644 tools/perf/util/print-events.c
 create mode 100644 tools/perf/util/print-events.h
 create mode 100644 tools/perf/util/tracepoint.c
 create mode 100644 tools/perf/util/tracepoint.h

-- 
2.37.1.455.g008518b4e5-goog

