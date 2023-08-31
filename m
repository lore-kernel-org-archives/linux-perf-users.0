Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C1CC83F29
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Aug 2023 07:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbjHaHOp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjHaHOp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Aug 2023 03:14:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7BC1A4
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 00:14:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7b52f36714so362924276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693466081; x=1694070881; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNPghSXfXGCF8iNdVb3qJhwXrSSWCCWSl9neVzBLPgs=;
        b=NxmVOrMrGOj7svxPzXO4lrmsC2KSQggS27LuV8vJarN0N7dgXecFEdIALH5rn46HS7
         bi29hbouVr/iHS2ZImki0ljZ0YPVksLqi6ON+FCRwiEpYRlpDuRGUMSV0qwekph7OGTO
         EfItDuv0nf0Y3xSamEdbDr9qUs0i2dp7dpeDfrmYr1riAc6phKiV9YBELm13HlbiqFFS
         aLN1t35OAUyr33xMzALiimbuqdPOlj4mAEutAy6aNkqxLNpqDWd/msEqYGtkDe/HIIrT
         s0KAuLbvf5gzZY6E1jCsLdM56rsGucHSi7BsBYie8jK0SAPvpmSEathJkr2iiNmsbypN
         EWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693466081; x=1694070881;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNPghSXfXGCF8iNdVb3qJhwXrSSWCCWSl9neVzBLPgs=;
        b=S1Dmpio/g2aV+t+hRhM/skVW1GkV/QGMyTDH/70xn9MqbaODOs7LsvpQCCYejH6/NA
         fu7Cwkdi/cllOl8NN758wRU2A3pCMiFonYUKckCZHT4lo/7+ebZjedQvklPhCty2Qzgn
         6u2ICf09B1bSYSVq8Hql7qg1RA3qi18gJe+JTwISz7ds9OFgybKmviUQe3niMqf6UYbB
         qv/yuQd6ZCAsvzAUvy607Xnn6V9iHe/eTdFaa8F3tfyce6vIvkQYR45cKDyaFB7us7KN
         wiWdViKihVmpJk1xlpqGG1hA+Z5M9/nVqWf2Qzky0mtrany0fa6Tx8u82lFPiG5McGW/
         /J6Q==
X-Gm-Message-State: AOJu0YytP7YS8L44NB18qWIl1grD/kVldMyXlGzADgO0YxTejOZEZ2Uv
        zWq4a5hNWhKHPlzZNLLwvNuTs3yV343X
X-Google-Smtp-Source: AGHT+IGSXBWMPyRg5UZKwzuPxj5dS8Vszbq3Z5775/Cxnfe4gWJ+wi4rrmAHdy9E8H5a4PNidWNGphAzBZyC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:feef:cd5e:6353:57f0])
 (user=irogers job=sendgmr) by 2002:a25:d8d6:0:b0:d44:be8a:ca39 with SMTP id
 p205-20020a25d8d6000000b00d44be8aca39mr113898ybg.7.1693466081622; Thu, 31 Aug
 2023 00:14:41 -0700 (PDT)
Date:   Thu, 31 Aug 2023 00:14:18 -0700
Message-Id: <20230831071421.2201358-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1 0/3] perf list/debug output fixes
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
        Rob Herring <robh@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix a long standing parse_events_term cloning bug so that the bad
display of terms can be fixed and the code somewhat more intuitive:
https://lore.kernel.org/lkml/20230830070753.1821629-2-irogers@google.com/

Fix a bug caused by the rename of 'cpu' to 'default_core' in perf list.

Add more documentation, increase type safety and fix some related bugs
where terms weren't initialized properly.

Ian Rogers (3):
  perf list: Don't print Unit for default_core
  perf parse-events: Name the two term enums
  perf parse-events: Fix propagation of term's no_value when cloning

 tools/perf/builtin-list.c      |   2 +-
 tools/perf/util/parse-events.c | 203 +++++++++++++++++++++++----------
 tools/perf/util/parse-events.h |  60 +++++++---
 tools/perf/util/parse-events.l |   2 +-
 tools/perf/util/parse-events.y |  27 +++--
 tools/perf/util/pmu.c          |   2 +-
 6 files changed, 207 insertions(+), 89 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

