Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86E5C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D6B60EE2
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhGWFzc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 01:55:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:50829 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhGWFzc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 01:55:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="191412009"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="191412009"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 23:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="455002283"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga007.jf.intel.com with ESMTP; 22 Jul 2021 23:36:03 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 0/3] perf tool: Enable cpu list for hybrid
Date:   Fri, 23 Jul 2021 14:34:30 +0800
Message-Id: <20210723063433.7318-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The perf-record and perf-stat have supported the option '-C/--cpus'
to count or collect only on the list of CPUs provided. This option
needs to be supported for hybrid as well.

v4:
---
Rename evlist__use_cpu_list to evlist__fix_hybrid_cpus
Add comments to evlist__fix_hybrid_cpus.

v3:
---
Rebase to latest perf/core branch.

v2:
---
Automatically map to hybrid pmu.

For example,

If cpu0-7 are 'cpu_core' and cpu9-11 are 'cpu_atom',

  # perf stat -e cycles -C0,11 -- sleep 1
  WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.

   Performance counter stats for 'CPU(s) 0,11':

           1,914,704      cpu_core/cycles/
           2,036,983      cpu_atom/cycles/

         1.005815641 seconds time elapsed

It automatically selects cpu0 for cpu_core/cycles/, selects cpu11 for
cpu_atom/cycles/, also with some warnings output.

Jin Yao (3):
  libperf: Add perf_cpu_map__default_new()
  perf tools: Create hybrid flag in target
  perf tools: Enable on a list of CPUs for hybrid

 tools/lib/perf/cpumap.c              |  5 ++
 tools/lib/perf/include/perf/cpumap.h |  1 +
 tools/perf/builtin-record.c          |  7 +++
 tools/perf/builtin-stat.c            |  6 +++
 tools/perf/util/evlist-hybrid.c      | 73 ++++++++++++++++++++++++++++
 tools/perf/util/evlist-hybrid.h      |  1 +
 tools/perf/util/evlist.c             |  3 +-
 tools/perf/util/pmu.c                | 35 +++++++++++++
 tools/perf/util/pmu.h                |  4 ++
 tools/perf/util/target.h             |  1 +
 10 files changed, 135 insertions(+), 1 deletion(-)

-- 
2.17.1

