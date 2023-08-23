Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4568EEE49A0
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 08:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjHWIO1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjHWILH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 04:11:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5BBCE6
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:09:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c9d29588aso70358107b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778162; x=1693382962;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXvCFhL984TX2oQ47qDb/BYaP1EU6FGu4C4k2bcoWxA=;
        b=d2ctvFcr4XNnEwl476cUwp8Ir8ybnDC28SJSGMpFfm3HWQyw6DeVHNNKOF2qZSfQL/
         SFfKkvhanOKg/MhxxNwtbs5iHXcg6yQz+3K1BR/jH7TbgPHZ5W2aDSWuynYNLUENf4vM
         hdVSpYlpMjLCEwCOP6A88bPMTrLIU4KT1tM95Hq2GQNL5d28EMRcpTQ7vS+PY4QIy5VS
         Hr+tG9hvmXo+TwCpR/kov9shGLDR4zVThP9yDDLo7ipKpky3dybPMVywktOfFvBBaLLc
         8ZwUDltEXVcQ/MNI1LYIZ7Pkf5QOoLXL0lGKRg0ZWmTgQvLq2KRmrGH7QX+u4e/JxafI
         AMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778162; x=1693382962;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXvCFhL984TX2oQ47qDb/BYaP1EU6FGu4C4k2bcoWxA=;
        b=WMYrVxfX3+dqZ1K+ytjv/MAYQ3bTr8re6P3lKU6hafG7NxXrS1rIlO0dtEvKaLpD1/
         ccBzqV4YzAsk8ZmHumEYQadrVeANJRAJYD//iod9XlfNMTc4lc28235xlolRMyLDBZ8l
         LDK3RVC9DoEdC3cay4++bIAASKVveFrs/HdAlXk+M0fE/M61zDz6CBGuKjf8NOBYmWNy
         36Mw29LeL932DQpRXKGM8IFozwRHzOUWD+O7rz0xbW/aOZHHQ0SpY58W1udI1J2rWSv1
         3OStKozCCEANK5+Z0li3Kn3RmFv8jo4yveKtY/MlWsN1iEfLHlfUVAFVgUNzAFx7B0RX
         NrgA==
X-Gm-Message-State: AOJu0YyFtNmtfxMRabJLqPx7mzJCOFkR/Vqb7ICWHZKhJ0qyn68Y2ffs
        ZuE9F9OjHaY4VLi0+cjo7leK9o+bTzs9
X-Google-Smtp-Source: AGHT+IHXFsqtea8U7dSOIUqSWapJui7ri3nA09iWxLIct/mbtTiUjfIR5ZaEbwTJ9gFdLqnPC3azMTOFhCFQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a05:6902:12c6:b0:d77:bcce:eb11 with SMTP
 id j6-20020a05690212c600b00d77bcceeb11mr37382ybu.10.1692778162082; Wed, 23
 Aug 2023 01:09:22 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:23 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-21-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 20/25] perf pmu: Cache json events table
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Cache the json events table so that finding it isn't done per
event/alias. Change the events table find so that when the PMU is
given, if the PMU has no json events return null. Update usage to
always use the PMU variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 14 ++++++++++++--
 tools/perf/tests/pmu-events.c    |  2 ++
 tools/perf/util/pmu.c            | 17 ++++++++---------
 tools/perf/util/pmu.h            |  4 ++++
 4 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 991fcf6cca64..f07864fabd54 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -948,7 +948,7 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
         const struct pmu_events_table *table = NULL;
         char *cpuid = perf_pmu__getcpuid(pmu);
-        int i;
+        size_t i;
 
         /* on some platforms which uses cpus map, cpuid can be NULL for
          * PMUs other than CORE PMUs.
@@ -968,7 +968,17 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
                 }
         }
         free(cpuid);
-        return table;
+        if (!pmu)
+                return table;
+
+        for (i = 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+
+                if (pmu__name_match(pmu, pmu_name))
+                        return table;
+        }
+        return NULL;
 }
 
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 34f0de182fa9..4fcb84fd1f65 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -544,6 +544,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 	INIT_LIST_HEAD(&pmu->list);
 	pmu->name = strdup(pmu_name);
 
+	pmu->events_table = table;
 	pmu_add_cpu_aliases_table(pmu, table);
 
 	res = pmu_events_table__find_event(table, pmu, "bp_l1_btb_correct", NULL, NULL);
@@ -583,6 +584,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	events_table = find_core_events_table("testarch", "testcpu");
 	if (!events_table)
 		return -1;
+	pmu->events_table = events_table;
 	pmu_add_cpu_aliases_table(pmu, events_table);
 	pmu_add_sys_aliases(pmu);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a7d96e309843..dabae2019bd0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -518,10 +518,10 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 	}
 	if (!pe) {
 		/* Update an event from sysfs with json data. */
-		const struct pmu_events_table *table = perf_pmu__find_events_table(pmu);
-
-		if (table)
-			pmu_events_table__find_event(table, pmu, name, update_alias, alias);
+		if (pmu->events_table) {
+			pmu_events_table__find_event(pmu->events_table, pmu, name,
+						     update_alias, alias);
+		}
 	}
 
 	/* Scan event and remove leading zeroes, spaces, newlines, some
@@ -871,13 +871,10 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_tab
 
 static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
 {
-	const struct pmu_events_table *table;
-
-	table = perf_pmu__find_events_table(pmu);
-	if (!table)
+	if (!pmu->events_table)
 		return;
 
-	pmu_add_cpu_aliases_table(pmu, table);
+	pmu_add_cpu_aliases_table(pmu, pmu->events_table);
 }
 
 static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
@@ -988,6 +985,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
 	pmu->max_precise = pmu_max_precise(dirfd, pmu);
+	pmu->events_table = perf_pmu__find_events_table(pmu);
 	pmu_add_cpu_aliases(pmu);
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
@@ -1001,6 +999,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	return NULL;
 }
 
+
 /* Creates the PMU when sysfs scanning fails. */
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2b1730152bc0..6bf0fbde4e85 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -114,6 +114,10 @@ struct perf_pmu {
 	 * from json events in pmu-events.c.
 	 */
 	struct list_head aliases;
+	/**
+	 * @events_table: The events table for json events in pmu-events.c.
+	 */
+	const struct pmu_events_table *events_table;
 	/** @caps_initialized: Has the list caps been initialized? */
 	bool caps_initialized;
 	/** @nr_caps: The length of the list caps. */
-- 
2.42.0.rc1.204.g551eb34607-goog

