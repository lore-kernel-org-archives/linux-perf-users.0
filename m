Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFE9C001DE
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Aug 2023 21:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjHJVuJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjHJVuI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2023 17:50:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5AC2738
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 14:50:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585f254c41aso17247367b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704207; x=1692309007;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLtP1qtlvTA2kCfp1Ts4w1guanUnakgxywtNcXiy9W8=;
        b=YC9fZNq/b9KbQfHldtBuTXro+KtUVPjH/3nUZF+AMHUn+gdmg7ibGC0S/cxkMnN9nP
         qmCz1wHZhq87HbDKl5IMrcHLEmv5quM96FvZHHiaQ6ixawb6zv74FwrTvS8OQxPyTyom
         5zOx5UB3axV/7mxBB/ZYl3W3YUKXX8o7J9e60oF3nCUxEdV8thWIaUYU7CAnGqSZ53kF
         l4ylVkMKYG2+3SK3H4SBhi6ZHMeaN80dAeEybmjty7Zm3kziDuHXaRbX6VaZPF6gkxGH
         KZTchU0C9zi4M8bl+lpDaWRYXIoVJn11Ky87pxNMnAIpykRFsy9GspzHb6poLkKWkFIC
         WVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704207; x=1692309007;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLtP1qtlvTA2kCfp1Ts4w1guanUnakgxywtNcXiy9W8=;
        b=fm/ebmIVbvAUvboRoHqZfMj58iO9QtI9OqIxu7uF9EV6uz4dVatWhY3rPtEANmayAf
         TAMK8GlFLoysfEQ2AaHKlFixqwrcMh6j+BRG2RQX4+HfofdwDYqQT1xKpgHneilMLI9K
         crwT9EIQcoIriGwr6a2qo7PeABjKmOokEk1l9pxyagODx+IOpd6UURQvYg/0n4hKaNE8
         2r5Dz9N04qB8FavmT7vxliUfsgmnZJqoft6cAYGpvFMuFRcJEE8hT8qQ2xLEpQK5dPYR
         tSyogsSs3xtgWNqkIv0WHixTBSPM40Cycmmszw4a/6jw8IyiGsaa+CMaJDczRdv9Kl6U
         iD6w==
X-Gm-Message-State: AOJu0YxsOBz3rqQOI2Rj6qw+lcNzr0rf6oVmGZHYMnfHGPwUv/MLhvZo
        WkPKqVglJ3P1lHH/2qxDqZJC7Y6E0+B1
X-Google-Smtp-Source: AGHT+IEYsDFnzflV/jH0oE2OFvevp2qXB5ijl9PvOCqXoN+rOZm6n23oBbrY1iL48zKDsq40EAAutNM2yHtb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a25:32d6:0:b0:d62:5d0f:a6a6 with SMTP id
 y205-20020a2532d6000000b00d625d0fa6a6mr60084yby.1.1691704206914; Thu, 10 Aug
 2023 14:50:06 -0700 (PDT)
Date:   Thu, 10 Aug 2023 14:49:50 -0700
In-Reply-To: <20230810214952.2934029-1-irogers@google.com>
Message-Id: <20230810214952.2934029-2-irogers@google.com>
Mime-Version: 1.0
References: <20230810214952.2934029-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v2 1/3] perf pmus: Sort pmus by name then suffix
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
"uncore_imc_free_running_1".

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

