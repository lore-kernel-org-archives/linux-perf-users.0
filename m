Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86477C2D0E4
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Nov 2020 03:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42ABD2240C
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Nov 2020 03:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+10cZhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgKUDLX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 22:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgKUDLX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Nov 2020 22:11:23 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58312C0613CF
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2020 19:11:23 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id n8so2802722plp.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2020 19:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Y9nCqzUR00s397XbJ4MbVQrXlMlJKCQR9tfy/2YBpDw=;
        b=G+10cZhZBNjcNDMYayyrBcwRdjmzCDoI5BfPvWKZLsKDq8xkqAmgkMLRX9A3cN9Vht
         zFE3C8AFGvZE7F4VlKu8YOLDGjReIHdDv/qzJQM0TC4LXQnHWiR/GtaJx5Jh6bRB8CEb
         Q8MIMXJciGLHBvy9KH7MTInktArucVOAIcgqfB4r+fBqH6OS1iuloNzmHm1+zBy+g8NK
         5KUKPi6+YzlkUrihuXK4DALsltvekLGRQLbz0HMZCxTcxfyz6uAIhH6VAZQ7uv9qphPx
         jqpkBlrnHzqk96egvIuQFHlQV86NnlzdzZ1YzldbyK/JDTGZfRadYh32xiyUAXMVJ5o/
         DPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Y9nCqzUR00s397XbJ4MbVQrXlMlJKCQR9tfy/2YBpDw=;
        b=jYzTC16F3G+YfPaeKgeJh72MSr+ffrasV6bpDHUg3fTEkmM8njaKiQBBE/VyEKc1T+
         9ueLMrUbyO8dkCe1Oxp3tAAfa0NnyvhqceVFCgNEcl79hOANLCqmyj1YmoYIY8AFdgW/
         bxZnM+OMHH/7NIb/5DcWwwY4tHwjcWG2YjalQYw1yUAHX6a4abkM8Lx2EZ0LiAowJYyQ
         biLlw2ofomCcqLJ5sujedIaAfMx/xHxNqFLXoAaQB+01pX2s3hIo7PSTx8XNG6lfTMWb
         vewq0NIF87C/pbfdwW2G2jK8hnE+27wbJpOwYfyV6hekyD3xy4k2JgozBywujyPOF03u
         GO6g==
X-Gm-Message-State: AOAM5308fc/0t/eJIl3VbpvNUy97AB8fVyC0qOK3ZF6QMHnA9r+6AwMr
        Szg+xTZMgfAWwnrGSltvX0GrFWjlu+0G
X-Google-Smtp-Source: ABdhPJzUvcp5hTaYjLuNdjpX0iq33Vr4pv15dTOX8kvtu+msfPlnNsUx47+E/jaAqnTXiLWG39TCyG1iFZX8
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:902:ba8b:b029:d7:e6da:cd21 with SMTP
 id k11-20020a170902ba8bb02900d7e6dacd21mr16233793pls.38.1605928282856; Fri,
 20 Nov 2020 19:11:22 -0800 (PST)
Date:   Fri, 20 Nov 2020 19:11:14 -0800
Message-Id: <20201121031119.3554769-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 0/5] Don't compute events that won't be used in a metric.
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

v3. fixes an assignment in patch 2/5. In patch 5/5 additional comments
are added and useless frees are replaced by asserts. A new peephole
optimization is added for the case CONST IF expr ELSE CONST, where the
the constants are identical, as we don't need to evaluate the IF
condition.

v2. is a rebase.

Ian Rogers (5):
  perf metric: Restructure struct expr_parse_ctx.
  perf metric: Use NAN for missing event IDs.
  perf metric: Rename expr__find_other.
  perf metric: Add utilities to work on ids map.
  perf metric: Don't compute unused events.

 tools/perf/tests/expr.c       | 159 +++++++++-----
 tools/perf/tests/pmu-events.c |  42 ++--
 tools/perf/util/expr.c        | 136 ++++++++++--
 tools/perf/util/expr.h        |  17 +-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 376 +++++++++++++++++++++++++++-------
 tools/perf/util/metricgroup.c |  44 ++--
 tools/perf/util/stat-shadow.c |  54 +++--
 8 files changed, 623 insertions(+), 214 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

