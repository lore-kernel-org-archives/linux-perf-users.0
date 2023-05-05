Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435E6C77B7C
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 20:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjEEUlf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 16:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjEEUle (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 16:41:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C322F4C15
        for <linux-perf-users@vger.kernel.org>; Fri,  5 May 2023 13:41:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f46dc51bdso4273560276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683319290; x=1685911290;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pmO/mUZslF6zk/m++XhRSloP3Is2SLrKGWDO4GiCCWg=;
        b=4IY0ACt+yzgmWBtCKxDUiZU9IShC6nZeJamyvXM5WHgmY8IcZ+w83GwaSxd6m4CC+H
         C4y+7FzWM+9v1Y7P66pyQxMtRuGs1+mupVht9iE0NUeoV+CI02LkSvVcd7U9U14qQf+x
         99ZL18CT/SmyvZFeWGegQv1DVSWinuAxXL7CqUH+erLHgxaLpqZcZRvaI09PCHzeQa6w
         2maSxVirGJzJGQI8r7+DBeJkB55OePvqGH88Hw5mhAhKhXNzrWqc8SFhJPl81s4cdn1G
         WBEnFhmt+136h8HME+hUHlyQgflXLEJYLo/fPYvp5BARa3WLBG1in3WA0X9vgCUsEEZr
         DBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683319290; x=1685911290;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmO/mUZslF6zk/m++XhRSloP3Is2SLrKGWDO4GiCCWg=;
        b=U4halyk3ox/XYzyyzdEa6rvV6HYfF+XVlNSg4+0BFCgnTEw+5B8TFXIFya9tkpkA8S
         umWS/ZfsTu5l7gd3v/iT0j7x8VAa4z2QdaO9rMIzq/6HnixKoFy79ajFNpyjH3SP1Od6
         C6xy3sFCAZt1Y4MRXh/VlNRL4sZce2tIh5uVvFuviYtAMfu3dA6Pu54JyxqtPX68Um2/
         Vxf8ilfRwE6cT/pf1tV4zIE6uBEVzgzJohnNn1GVd5tP5t4PvWXgQvbf620XMwuzOJoz
         mrBKEjDOBhISU124WaiKNl6syWQzsCud4tt9p/vN+gZX8a0v7fj7rJppfpx/DISQBEza
         PCRg==
X-Gm-Message-State: AC+VfDwLNP5pK2M2AHU1r0VoL/DYDR4N+NHw+Q7OKC8chMewDxC2c4P0
        Z112aUXxWUJ6Cp/0Y4uvn9Twsc4HGcmR
X-Google-Smtp-Source: ACHHUZ5Dv7F5cKDlVBgpxFtZXGpdiBBv258UrDthWKLlxZdY0QJ5+1TO+9v3x3UwVzLba5d6aKz5FytMgJbr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:4715:8e64:29b7:6c4])
 (user=irogers job=sendgmr) by 2002:a05:6902:1021:b0:ba1:b908:364c with SMTP
 id x1-20020a056902102100b00ba1b908364cmr1678204ybt.12.1683319289896; Fri, 05
 May 2023 13:41:29 -0700 (PDT)
Date:   Fri,  5 May 2023 13:41:19 -0700
Message-Id: <20230505204119.3443491-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Subject: [PATCH v1] perf metrics: Fix segv with --for-each-cgroup
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
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Ensure the metric threshold is copied correctly or else a use of
uninitialized memory happens.

Fixes: d0a3052f6fae ("perf metric: Compute and print threshold values")

Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4b9a16291b96..c566c6859302 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1730,6 +1730,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 				return -ENOMEM;
 
 			new_expr->metric_expr = old_expr->metric_expr;
+			new_expr->metric_threshold = old_expr->metric_threshold;
 			new_expr->metric_name = strdup(old_expr->metric_name);
 			if (!new_expr->metric_name)
 				return -ENOMEM;
-- 
2.40.1.521.gf1e218fcd8-goog

