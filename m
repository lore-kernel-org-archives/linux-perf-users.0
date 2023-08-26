Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639B8C83F11
	for <linux-perf-users@archiver.kernel.org>; Sat, 26 Aug 2023 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjHZVkv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 26 Aug 2023 17:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjHZVk0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 26 Aug 2023 17:40:26 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Aug 2023 14:40:24 PDT
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B922CD1
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Aug 2023 14:40:24 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id a0tiqMyNVntrua0tiqFk2g; Sat, 26 Aug 2023 23:32:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693085573;
        bh=4MX0lTEIfMwloRuVnSSaTXgUJ5kaTWKMUvM8PI8P8MU=;
        h=From:To:Cc:Subject:Date;
        b=q+OVRHG/fVWMNSoIxH972kG2FoUfEJaBwS0VnqcCkbnHkWK6LJsCWvrP2GeHK3PSP
         Blry+75Lk4VRMNTFQCbMNn0jGq3OX3V+6nt0+GfcX9yymtDmUPQY3SpLr9f2dr8Oq4
         aQ0oLs1eXD1V7gs3vDRe5FyLxJ9Nut13C0MkOzKHScGvjhH03UIwnziZ1RsSRqLwRE
         8cLSAi75kN8xMmYZVzjG5eWuwlX0pd/n0/4nQi6NoQ3X93lfexKAJtKUBk1aCKw3mH
         4Z+XE6lvXBaBJO5arKqNjpS44uWnxpDasnbfX8OqbLNnCXb6u7V6UZm2BYPUp9hFjt
         Q6DUtXvWVnXdw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Aug 2023 23:32:53 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf pmu: Fix a potential memory leak in perf_pmu__lookup()
Date:   Sat, 26 Aug 2023 23:32:45 +0200
Message-Id: <9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The commit in Fixes has reordered some code, but missed an error handling
path.

'goto err' now, in order to avoid a memory leak in case of error.

Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 tools/perf/util/pmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bb2ca29cd7bd..8dfce84ad9fe 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1018,10 +1018,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * type value and format definitions. Load both right
 	 * now.
 	 */
-	if (pmu_format(pmu, dirfd, name)) {
-		free(pmu);
-		return NULL;
-	}
+	if (pmu_format(pmu, dirfd, name))
+		goto err;
+
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
-- 
2.34.1

