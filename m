Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC6C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 02:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9771660EC0
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 02:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhHKCuc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 22:50:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:49103 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhHKCuc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 22:50:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="300628185"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="300628185"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 19:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="445651161"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 10 Aug 2021 19:50:05 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        rickyman7@gmail.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 0/2] perf tools: Add PMU alias support
Date:   Wed, 11 Aug 2021 10:48:25 +0800
Message-Id: <20210811024827.9483-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A perf uncore PMU may have two PMU names, a real name and an alias name.
With this patch set, the perf tool can monitor the PMU with either the
real name or the alias.

Use the real name,
 $ perf stat -e uncore_cha_2/event=1/ -x,
   4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,

Use the alias,
 $ perf stat -e uncore_type_0_2/event=1/ -x,
   3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,

v4:
---
1. Fix memory leaks in pmu_lookup.
2. Rebase to perf/core.

v3:
---
1. Use fgets() to replace fscanf().
2. Resource cleanup.

v2:
---
Add test case to verify the real name and alias name having same effect.

Jin Yao (1):
  perf tests: Test for PMU alias

Kan Liang (1):
  perf pmu: Add PMU alias support

 tools/perf/arch/x86/util/pmu.c  | 129 +++++++++++++++++++++++++++++++-
 tools/perf/tests/parse-events.c |  92 +++++++++++++++++++++++
 tools/perf/util/parse-events.y  |   3 +-
 tools/perf/util/pmu.c           |  47 +++++++++---
 tools/perf/util/pmu.h           |   5 ++
 5 files changed, 264 insertions(+), 12 deletions(-)

-- 
2.17.1

