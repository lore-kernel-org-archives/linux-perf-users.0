Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9125C4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04FC60ED7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhGWFzr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 01:55:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:50829 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234056AbhGWFzh (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 01:55:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="191412018"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="191412018"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 23:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="455002302"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga007.jf.intel.com with ESMTP; 22 Jul 2021 23:36:09 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 2/3] perf tools: Create hybrid flag in target
Date:   Fri, 23 Jul 2021 14:34:32 +0800
Message-Id: <20210723063433.7318-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723063433.7318-1-yao.jin@linux.intel.com>
References: <20210723063433.7318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

User may count or collect only on a cpu list via '-C/--cpus' option.
Previously cpus for evsel was retrieved from pmu sysfs. But if the
target cpu list is defined, the retrieved cpus are not kept and the
target cpu list is used instead.

But for hybrid system, we can't directly use target cpu list. The
cpu list may not available on hybrid pmu (e.g. cpu_core or cpu_atom).
So we should not set 'has_user_cpus' flag for hybrid system.

The difficulity is that we can't call perf_pmu__has_hybrid() in evlist.c
to check hybrid system otherwise 'perf test python' would be failed
(undefined symbol for perf_pmu__has_hybrid). If we add pmu.c to
python-ext-sources, too many symbol dependencies are hard to resolve.

We use an alternative method by using a new 'hybrid' flag in target
for hybrid system checking.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3/v4:
 - No change.

v2:
 - New in v2.

 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/target.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 47581a237c7a..06f8890816c3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1002,7 +1002,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!cpus)
 		goto out_delete_threads;
 
-	evlist->core.has_user_cpus = !!target->cpu_list;
+	evlist->core.has_user_cpus = !!target->cpu_list && !target->hybrid;
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 4ff56217f2a6..daec6cba500d 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -17,6 +17,7 @@ struct target {
 	bool	     default_per_cpu;
 	bool	     per_thread;
 	bool	     use_bpf;
+	bool	     hybrid;
 	const char   *attr_map;
 };
 
-- 
2.17.1

