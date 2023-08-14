Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE85C001DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Aug 2023 16:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjHNQiR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 12:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjHNQiH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2023 12:38:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D8124
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 09:38:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d67a458ff66so3541836276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692031085; x=1692635885;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9M5Kp6au+xtW2CeK8507RoWf4CnApWNQmihr10EV/wQ=;
        b=KGWwShhyYHQqv5ngOlRXeEsBiMOJRnDM/DZuzfqzoLDqOmXIQSl9ZimX0NceVp5F1g
         my8S/oTKd1PbqI/7q6okf48Xe0Zio1rd3vVSZZTJiQCVclxVj3wYoCMubVQC6HkOyHz/
         Gxum+O6N9bAwsmRs3ZoPYIDktu/+5SPTHz8tq3pcKOBQt++Pognjni7hyhL1FCpg2WKi
         w75ayAGB5wl3ebgCuu8GQnL6C6di135YaTHIAzZ7RCFQdHbF074p3WnrfKgECTnbOEF3
         00HFgKRyoJzzd8O6IN1z+kB+WGRRLt826eqXC0MgdrPOZ8OkucXRSZHD0h+7SiJgcW1B
         duxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031085; x=1692635885;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9M5Kp6au+xtW2CeK8507RoWf4CnApWNQmihr10EV/wQ=;
        b=bP4h55tnPApUiAtdQSDOtXzSBmPQrBh+uK5Au/YmMy37PR6PIrFhjIAWkm8kwzO5sm
         0lQm9pDUhfr/EJaigVnSNjk0CT0xDxVaj1YNLum+rAQP4Vh8scFZYsG7cDi7jqS30Nnd
         aEK5zBFf/uzu/4Eyq9nMukFiJiu8P3J9eoele6KxMYwQWKrNMmpB1TnwTPYYZizWUiCj
         xR2nc1sNoNd3l266gEufq4n5hNufDYLeAD6nrJQFzcT0DRkcFijuwXJuqEJNu1LyBvo8
         MB/x0eGmrHAhuSn5s6aXh+F7shx8UcQpXdURLuKvsIOfGiRC1y8ru0orHWGVkmqZ4Cki
         1sBA==
X-Gm-Message-State: AOJu0YxHeW4u2tZhLXR0Dj9dtZscCzgzHuSzw88Sbv3OthScJJ5zqRCG
        RZEV06zCVPkrW+3nAOStHx7xyBanEcYo
X-Google-Smtp-Source: AGHT+IGtd9vjdp1qvZb1M4Cmv9dej5Ze/an+8QoegeIi5mbhiIxJbZRrPKcsxOnBeYfjqARfHc8SO3fkXIGc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a919:6125:510f:f0ef])
 (user=irogers job=sendgmr) by 2002:a25:ce53:0:b0:d4f:22c:69a3 with SMTP id
 x80-20020a25ce53000000b00d4f022c69a3mr123751ybe.10.1692031084826; Mon, 14 Aug
 2023 09:38:04 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:37:55 -0700
In-Reply-To: <20230814163757.3077138-1-irogers@google.com>
Message-Id: <20230814163757.3077138-2-irogers@google.com>
Mime-Version: 1.0
References: <20230814163757.3077138-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v3 1/3] perf pmus: Sort pmus by name then suffix
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Sort PMUs by name. If two PMUs have the same name but differ by
suffix, sort the suffixes numerically. For example, "breakpoint" comes
before "cpu", "uncore_imc_free_running_0" comes before
"uncore_imc_free_running_1". Suffixes need to be treated specially as
otherwise they will be ordered like 0, 1, 10, 11, .., 2, 20, 21, ..,
etc. Only PMUs starting 'uncore_' are considered to have a potential
suffix.

Sorting of PMUs is done so that later patches can skip duplicate
uncore PMUs that differ only by there suffix.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index c58ba9fb6a36..3581710667b0 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/list.h>
+#include <linux/list_sort.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
 #include <sys/types.h>
+#include <ctype.h>
 #include <dirent.h>
 #include <pthread.h>
 #include <string.h>
@@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
 static bool read_sysfs_core_pmus;
 static bool read_sysfs_all_pmus;
 
+static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
+{
+	int orig_len, len;
+
+	orig_len = len = strlen(str);
+
+	/* Non-uncore PMUs have their full length, for example, i915. */
+	if (strncmp(str, "uncore_", 7))
+		return len;
+
+	/*
+	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
+	 * the full length.
+	 */
+	while (len > 0 && isdigit(str[len - 1]))
+		len--;
+
+	if (len > 0 && len != orig_len && str[len - 1] == '_') {
+		if (num)
+			*num = strtoul(&str[len], NULL, 10);
+		return len - 1;
+	}
+	return orig_len;
+}
+
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
@@ -122,6 +149,25 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
 }
 
+static int pmus_cmp(void *priv __maybe_unused,
+		    const struct list_head *lhs, const struct list_head *rhs)
+{
+	unsigned long lhs_num, rhs_num;
+	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
+	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
+	const char *lhs_pmu_name = lhs_pmu->name ?: "";
+	const char *rhs_pmu_name = rhs_pmu->name ?: "";
+	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
+	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
+	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
+			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
+
+	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
+		return ret;
+
+	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+}
+
 /* Add all pmus in sysfs to pmu list: */
 static void pmu_read_sysfs(bool core_only)
 {
@@ -156,6 +202,8 @@ static void pmu_read_sysfs(bool core_only)
 		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
 			pr_err("Failure to set up any core PMUs\n");
 	}
+	list_sort(NULL, &core_pmus, pmus_cmp);
+	list_sort(NULL, &other_pmus, pmus_cmp);
 	if (!list_empty(&core_pmus)) {
 		read_sysfs_core_pmus = true;
 		if (!core_only)
-- 
2.41.0.640.ga95def55d0-goog

