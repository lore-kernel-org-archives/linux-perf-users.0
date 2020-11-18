Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0175CC6369E
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 05:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7BC2220B
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 05:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FC+BZ7Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgKRFDl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 00:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRFDl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 Nov 2020 00:03:41 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A7BC061A4D
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2020 21:03:39 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x26so462144pfo.23
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2020 21:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=XHkS0IrFQcowDQBwZTxPmQOZ+zkcfaqHXqP/H07K9L8=;
        b=FC+BZ7DwsOGlR228NtU5hM1UOWWRWd4j2y3XsIXaj+BztrgBkUKQLp5agLO50EuGHK
         VBPShpXThhe/yQIfU4Elk70+vBOiaZdX3PFTH482HLd5av3h8oxYQG3Z8aIxRCC5i9p4
         o1SMwtKq5JPUd82iBg2K4MaqS5eZrmuuwHzQ8wE/aDp/qrZk5OC9nPiC/BRIDmEa1+VT
         IxtL+3d94VngkJBEIjHOXSNF3s4pNlVImhO2uW+kV/McI7EUq5s9sR9pvPqLcbx9uWaF
         tLBeUaVbtsD6gjVqLyG2thxDvkcA1pELbzlm0B/birJ0wEfa0G6/J8VpiP1hlCeotuJO
         W+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=XHkS0IrFQcowDQBwZTxPmQOZ+zkcfaqHXqP/H07K9L8=;
        b=XukAHkD2OC5XwyrCOqMfYUvmGRbPT0tNe3/PvyTB2n7f2dH1ZHHNigilZKwrfpKAYS
         VvyhMWZb6XVvmVL+JGZ8WluhhvD7PNnjtZ64KCTkQbU0seYck9s0u3DbqE+AEPLcutUj
         DjE+cffM2KVZS+e6EL4xoOEa2omXg1BaNiI+/nWB8rr0U4awxpQbNfETHjuRyp1o+PFo
         b9WSPUe8zFEvQ3DRQaHWQDvNkS8QLPr3LFAqnIPf5rtTJpq/wOSCBLM95Qjgx7Zl3G4Q
         MkogDSZYmK7JOBb5fFiEfjuPX8fujZK9+EyTWEImY9FMhwR5P6NAP8SoL1rFpfMUorms
         ilNw==
X-Gm-Message-State: AOAM533JnoeNPECe5BcOuMQ9cBfYYZG7nVmZ5VzObGQmd/Zh0f4p/QWt
        mXd9RRKwa4NdhSYAAnwzNCoNbB3L8kFp
X-Google-Smtp-Source: ABdhPJy5wv5rrYgY4sH21jS/d/gz+btK3xy7UuenbdxpWfMfNB1LJOXdCr321EkxP2OpB1Yh6BzSnq10jTL5
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:902:8685:b029:d7:bb:aa2 with SMTP id
 g5-20020a1709028685b02900d700bb0aa2mr2808834plo.13.1605675819020; Tue, 17 Nov
 2020 21:03:39 -0800 (PST)
Date:   Tue, 17 Nov 2020 21:03:30 -0800
Message-Id: <20201118050335.2347358-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 0/5] Don't compute events that won't be used in a metric.
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

v2. is a rebase.

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

