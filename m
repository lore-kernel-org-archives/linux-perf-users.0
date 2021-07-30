Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EE7C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 07:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F2560FED
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 07:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhG3HIu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 03:08:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:47755 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhG3HIt (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 03:08:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="193323604"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="193323604"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 00:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="476869150"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2021 00:08:42 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        rickyman7@gmail.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/2] perf tools: Add PMU alias support
Date:   Fri, 30 Jul 2021 15:07:15 +0800
Message-Id: <20210730070717.30997-1-yao.jin@linux.intel.com>
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
 tools/perf/util/pmu.c           |  26 ++++++-
 tools/perf/util/pmu.h           |   5 ++
 5 files changed, 250 insertions(+), 5 deletions(-)

-- 
2.27.0

