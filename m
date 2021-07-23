Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B72CC432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C23360EAF
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhGWFzr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 01:55:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:50829 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234049AbhGWFze (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 01:55:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="191412015"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="191412015"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 23:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="455002297"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga007.jf.intel.com with ESMTP; 22 Jul 2021 23:36:06 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 1/3] libperf: Add perf_cpu_map__default_new()
Date:   Fri, 23 Jul 2021 14:34:31 +0800
Message-Id: <20210723063433.7318-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723063433.7318-1-yao.jin@linux.intel.com>
References: <20210723063433.7318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The libperf already has a static function 'cpu_map__default_new()'.
Add a new API perf_cpu_map__default_new() to export the function.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3/v4:
 - No change.

v2:
 - New in v2.

 tools/lib/perf/cpumap.c              | 5 +++++
 tools/lib/perf/include/perf/cpumap.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ca0215047c32..51b6553912e0 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -68,6 +68,11 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 	return cpus;
 }
 
+struct perf_cpu_map *perf_cpu_map__default_new(void)
+{
+	return cpu_map__default_new();
+}
+
 static int cmp_int(const void *a, const void *b)
 {
 	return *(const int *)a - *(const int*)b;
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 6a17ad730cbc..7c27766ea0bf 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -9,6 +9,7 @@
 struct perf_cpu_map;
 
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
-- 
2.17.1

