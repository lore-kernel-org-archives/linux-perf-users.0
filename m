Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA71EC77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jun 2023 08:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjFAIam (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 04:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjFAIa1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jun 2023 04:30:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F8E125
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jun 2023 01:30:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb51cb4d4so822909276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685608211; x=1688200211;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2W+D3X61SHji5TdcPTT7aQE7+SKMk9nGQHSrp9XR3js=;
        b=hFIvLmGP3lv7GenwMucp7vgjD92bKKVaKTHzPrnD0d5s2WVEN+JDM4TmLgr1bPgKy1
         7IjnHzCWR6v9OjFGON+bq8ILrk/5KyCBmclQhLXrjVcmxKksBw33B/w3G3YtehGwyaj3
         5/pvgPkxiT739fYEk0zq8KuyIg12SXt8xRW9V5bkDXq5ArJu4hDz5dWZ1Bl4h0B3k57p
         7GS5yHSKPem6KDK8XLnNVHoyQUcPiURYWAAjWIYExIORyP4qYAGBSnKVmox7VGE0fPBP
         DE1oiy1aDLl5M4KG/5VKbR3FkAy3/+uVJYIumaGGr64vDXs5m6FB4mAlnbGkms9glEKs
         +ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608211; x=1688200211;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2W+D3X61SHji5TdcPTT7aQE7+SKMk9nGQHSrp9XR3js=;
        b=W+JOyUQ2cz6aVaZnLneYySjR+qvr7Mr6na72aIx15aRsCArPlQbAquHVAG+tQd0/Dd
         K7WCsw3NbGH31sk+cFChF5geMhD0on0qop8FwLM/45Dg5PuMzmml7vsOuYy/qnCegZtd
         LhPGnH+IVsxQGjlP2O+0tyYq92N6oE7gnp9cePYwwNbDlh1hP9uj2zmCWTQ8tm8shznk
         uX4S/vv94mZeSof7yTetk8fZcBJYhoEnRf3LkvAxs8bjCuIxSqHUCbrUlumz9pGQfKkJ
         KKgwTW/GD0zM/UYIqzl5Ny+Q6Q3DYHnATGkPvAxKYysNU2t8VQNZjwV7Z6JOGtmD07jU
         G7kw==
X-Gm-Message-State: AC+VfDzAUQOdwwvnErVHar06a0YRvqXOEJnpUt4Hg2sCUsMivpHCpP19
        UvGeZ+pnCUpQHaLxn4A74a/sF3gQprrG
X-Google-Smtp-Source: ACHHUZ4CtvHxqbmMlOebUnOkHAbQEfnmI2HybhjxUjmo0bcgbzA6MKi2iuDhUt8X/cL0NStkjLBjtimTjIwJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a344:94b4:9b8d:a089])
 (user=irogers job=sendgmr) by 2002:a05:6902:729:b0:bb1:445a:6f05 with SMTP id
 l9-20020a056902072900b00bb1445a6f05mr2517804ybt.4.1685608211098; Thu, 01 Jun
 2023 01:30:11 -0700 (PDT)
Date:   Thu,  1 Jun 2023 01:29:52 -0700
In-Reply-To: <20230601082954.754318-1-irogers@google.com>
Message-Id: <20230601082954.754318-3-irogers@google.com>
Mime-Version: 1.0
References: <20230601082954.754318-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 2/4] perf evsel: Add verbose 3 print of evsel name when opening
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It is often useful to know not just the attribute and perf_event_open
details when opening an evsel, but also the evsel's name. Add this
debug output for verbose 3 so that it won't interfere with the current
verbose 2 output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 46da3f0bb47e..779bc2b574f4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2038,6 +2038,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 fallback_missing_features:
 	evsel__disable_missing_features(evsel);
 
+	pr_debug3("Opening: %s\n", evsel__name(evsel));
 	display_attr(&evsel->core.attr);
 
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
-- 
2.41.0.rc0.172.g3f132b7071-goog

