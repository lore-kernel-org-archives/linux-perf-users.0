Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C3BC388F7
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 00:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AEB2223F
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 00:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSV+mjSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKMARA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 Nov 2020 19:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMAQ4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Nov 2020 19:16:56 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3080FC0613D4
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2020 16:16:56 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id b191so5499450qkc.10
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2020 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=SF2/0cBD4SDXrx4kSO5jpkw3cm1P8On8XdzbrxLvYHc=;
        b=eSV+mjSXgJcCb1CVnnrLnnD0ABu+pRfHzud1Sn/xHVeRS4cxxt3tssKBrDRO+fvBNl
         0ZI6atxrCJKqLTib4fLCMfKcyXqzMMxqRmGwZB6kZV3d713uwHTsAWiAPQ3BP8h1qrKb
         TU/OoojdIdLIvGZ2Q9zoAbQNUsq5rpuuqHYWv0yEp01ATsqJ0+fOGFjYxlzCgCIpJtE1
         0dYhn80pwsJbwuLdnT6UhKvH87Q9JzkmnPKU1YYnmaiZ4hVkpGoABNePD8RMumgQqvJ0
         Mm01M3GvVx8X6GiaFUjEvzf+UinZIO31niJV0uM+tFxVRvcEMyUkRi8RADxJxfiEJzOO
         3QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=SF2/0cBD4SDXrx4kSO5jpkw3cm1P8On8XdzbrxLvYHc=;
        b=W0ILQvkwdWqukDNLsKXWWWBzJfQaS1OGqQ2ia5ZzoVbo7T5msDywQxU+pdBErM4I26
         xbmKAlK3FD7PV1Q/7WLodG0pTXE+Iu/IHddue3+JIIOTSLGsMKiKy2GYaaONVQu1Fxha
         Ua5+6/eIgezvn9CPkD9Gm6BHTray3NSbmJEztVQS6Q80Okdek5eORlz03aiY4n5iU+0/
         yITqNUrpUAn4mRXF6qPai6Z09Qy8P7u/KJX8FKF6qbRzM9DGn4B9IOocjqs7Fqmu4Zx0
         MWb/npWklIM/z7Q+o4ZALih8tSqGqoFicOIIir71MEm7FVRXS4Vf6OLaqMjLTKzDYUUK
         VTuw==
X-Gm-Message-State: AOAM533FdFLn9h91u3kE/xF/4rYozTN3hJmJFEfEjm/2dtZzr+9oaoVS
        CaitSeWqRKU8PJ5zl4E6r9u8ZVBsYyj0
X-Google-Smtp-Source: ABdhPJwyboO74LHKP98PlInQeAm3Rn2ncH8TrzT9NTK5yWDR5AbUSz+LT4KC0pVNzuUBfniZGLxyJE9p1S3T
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:c18a:: with SMTP id
 n10mr2475691qvh.54.1605226615225; Thu, 12 Nov 2020 16:16:55 -0800 (PST)
Date:   Thu, 12 Nov 2020 16:16:46 -0800
Message-Id: <20201113001651.544348-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH 0/5] Don't compute events that won't be used in a metric.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

    
For a metric like:
  EVENT1 if #smt_on else EVENT2
    
currently EVENT1 and EVENT2 will be measured and then when the metric
is reported EVENT1 or EVENT2 will be printed depending on the value
from smt_on() during the expr parsing. Computing both events is
unnecessary and can lead to multiplexing as discussed in this thread:
https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

This change modifies expression parsing so that constants are
considered when building the set of ids (events) and only events not
contributing to a constant value are measured.

Ian Rogers (5):
  perf metric: Restructure struct expr_parse_ctx.
  perf metric: Use NAN for missing event IDs.
  perf metric: Rename expr__find_other.
  perf metric: Add utilities to work on ids map.
  perf metric: Don't compute unused events.

 tools/perf/tests/expr.c       | 148 ++++++++++-----
 tools/perf/tests/pmu-events.c |  42 +++--
 tools/perf/util/expr.c        | 136 ++++++++++++--
 tools/perf/util/expr.h        |  17 +-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 343 +++++++++++++++++++++++++++-------
 tools/perf/util/metricgroup.c |  44 +++--
 tools/perf/util/stat-shadow.c |  54 ++++--
 8 files changed, 586 insertions(+), 207 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

