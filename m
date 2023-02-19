Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2736FC636CC
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBSJaE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBSJaD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:30:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149E12581
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:29:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m13-20020a25260d000000b0087f69905709so346787ybm.10
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpSaNFvC8VmLiMMzNqVi6YMEMj22ak1daXzeVt5eMAk=;
        b=HcBv1rkbvDldKyrDrO0aggLoq3rOU9HtvU+pzmjwa8Ux0B1KVOh4j8kILHgYFzodGs
         q7FHA8VF7wHWGnSmn6YVglkgBiheCph85mVXO2727cgB4U/R416NU+pIV9PVC1yP1IKT
         nsJ+wXh647jNXsjYXnz/rmI6T3y4ixe98L+h/LwtJ6uZDKOkqF145rV3liTbQfcNuvXw
         +wvjCDO3XWGrwUhOU6wNzR+0DSatllL4NCLdst2qS9VItUg1x4bigbuFwqNwRCqqlJaH
         SA2vUGQpGnDR+Dm03t5wFIxSQN7+d3nR0wTN/jsAXGHCxURshr7AqnpGX5wjEOu5SCEw
         Pa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpSaNFvC8VmLiMMzNqVi6YMEMj22ak1daXzeVt5eMAk=;
        b=F2QyUBFnBoRNlKVfkbm6Z4zMDHQxpziqWu9Slm0Wa/JEP4uDJzX5xjKdIP99q3Edae
         Duhfn5S6UY4k8yZed+pajkIPHxcWO9//SIY6VepG6ayFRYpSPse9UEJJyKj/lMaEAExw
         5iKruVIm0fU/6jNMH2PhEQLXYEfZGGgqVUxx8yy4yX87joDaInryDJZFvKklJZqubDdt
         noF977hwTjTGe7r4dmxJganibpz9FMBh0hyDRBx/Z6rRq+p1YsGJtI8vY/p90l0/QODX
         BCanYhsxO6rg9iP1sE11YxMhMqpRULLHETLmnPbFIDHvXY3yjvU5rz0+CBOaRnIzweNZ
         0g4g==
X-Gm-Message-State: AO0yUKVAznlzLUYKfmPUrl5F1QyXKtSucGX8RkYHk5g53x37WQr2cJB+
        CV8r0nxxo4RTvJCKNQ2q4N0/k0I4ugnH
X-Google-Smtp-Source: AK7set+/IPJPR2TJCsCRPOBld36mgcNb8QWHQJkTJaS1X/3VSb0/0V2mUrZzloFp8neALyJ35/txBaNTQ9s3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c6:b0:97a:ebd:a594 with SMTP id
 w6-20020a05690210c600b0097a0ebda594mr389689ybu.3.1676798982991; Sun, 19 Feb
 2023 01:29:42 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:02 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-6-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 05/51] perf pmu-events: Change deprecated to be a bool
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Switch to a more natural bool rather than string encoding, where NULL
implicitly meant false.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   |  2 +-
 tools/perf/pmu-events/pmu-events.h |  4 +++-
 tools/perf/tests/pmu-events.c      |  4 ++--
 tools/perf/util/pmu.c              | 10 ++++------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2b08d7c18f4b..35ca34eca74a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -678,7 +678,7 @@ static void decompress_event(int offset, struct pmu_event *pe)
 {
 \tconst char *p = &big_c_string[offset];
 """)
-  enum_attributes = ['aggr_mode']
+  enum_attributes = ['aggr_mode', 'deprecated']
   for attr in _json_event_attributes:
     _args.output_file.write(f'\n\tpe->{attr} = ')
     if attr in enum_attributes:
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 7225efc4e4df..2434bc7cf92d 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -2,6 +2,8 @@
 #ifndef PMU_EVENTS_H
 #define PMU_EVENTS_H
 
+#include <stdbool.h>
+
 struct perf_pmu;
 
 enum aggr_mode_class {
@@ -22,7 +24,7 @@ struct pmu_event {
 	const char *pmu;
 	const char *unit;
 	const char *perpkg;
-	const char *deprecated;
+	bool deprecated;
 };
 
 struct pmu_metric {
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 9b4c94ba5460..937804c84e29 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -331,8 +331,8 @@ static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event
 		return -1;
 	}
 
-	if (!is_same(e1->deprecated, e2->deprecated)) {
-		pr_debug2("testing event e1 %s: mismatched deprecated, %s vs %s\n",
+	if (e1->deprecated != e2->deprecated) {
+		pr_debug2("testing event e1 %s: mismatched deprecated, %d vs %d\n",
 			  e1->name, e1->deprecated, e2->deprecated);
 		return -1;
 	}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c256b29defad..80644e25a568 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -331,14 +331,15 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	int num;
 	char newval[256];
 	char *long_desc = NULL, *topic = NULL, *unit = NULL, *perpkg = NULL,
-	     *deprecated = NULL, *pmu_name = NULL;
+	     *pmu_name = NULL;
+	bool deprecated = false;
 
 	if (pe) {
 		long_desc = (char *)pe->long_desc;
 		topic = (char *)pe->topic;
 		unit = (char *)pe->unit;
 		perpkg = (char *)pe->perpkg;
-		deprecated = (char *)pe->deprecated;
+		deprecated = pe->deprecated;
 		pmu_name = (char *)pe->pmu;
 	}
 
@@ -351,7 +352,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	alias->unit[0] = '\0';
 	alias->per_pkg = false;
 	alias->snapshot = false;
-	alias->deprecated = false;
+	alias->deprecated = deprecated;
 
 	ret = parse_events_terms(&alias->terms, val);
 	if (ret) {
@@ -405,9 +406,6 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	alias->str = strdup(newval);
 	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
 
-	if (deprecated)
-		alias->deprecated = true;
-
 	if (!perf_pmu_merge_alias(alias, list))
 		list_add_tail(&alias->list, list);
 
-- 
2.39.2.637.g21b0678d19-goog

