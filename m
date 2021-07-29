Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13B4C43214
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB24B61074
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbhG2OJW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:09:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3523 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbhG2OCd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 10:02:33 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbBnM2gTZz6FFs2;
        Thu, 29 Jul 2021 21:53:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 16:02:28 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:02:24 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 00/11] perf test: Improve pmu-events support
Date:   Thu, 29 Jul 2021 21:56:15 +0800
Message-ID: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Recently it has been shown that the pmu-events tests do not always catch
broken uncore PMU alias support.

The main problem is that the alias matching only tests uncore PMUs which
are present in the host system, so pretty useless.

This series improves that by using fake uncore PMUs, and verifying aliases
generated for those PMUs match known expected values.

This means that even if one arch does not have PMUs which support some
special aliasing, like multiple tokens, we can still have a fake uncore
PMU test on that arch.

Support is also added to test system PMUs alias matching.

Based on 5.14-rc1 + "perf pmu: Fix alias matching".

John Garry (11):
  perf test: Factor out pmu-events event comparison
  perf jevents: Relocate test events to cpu folder
  perf test: Declare pmu-events test events separately
  perf test: Factor out pmu-events alias comparison
  perf test: Test pmu-events core aliases separately
  perf pmu: Check .is_uncore field in pmu_add_cpu_aliases_map()
  perf test: Re-add pmu-event uncore PMU alias test
  perf test: Add more pmu-events uncore aliases
  perf pmu: Make pmu_add_sys_aliases() public
  perf jevents: Print SoC name per system event table
  perf test: Add pmu-events sys event support

 .../{test_cpu => test_soc/cpu}/branch.json    |   0
 .../{test_cpu => test_soc/cpu}/cache.json     |   0
 .../{test_cpu => test_soc/cpu}/other.json     |   0
 .../{test_cpu => test_soc/cpu}/uncore.json    |  23 +-
 .../arch/test/test_soc/sys/uncore.json        |   9 +
 tools/perf/pmu-events/jevents.c               |   5 +-
 tools/perf/pmu-events/pmu-events.h            |   1 +
 tools/perf/tests/pmu-events.c                 | 699 +++++++++++++-----
 tools/perf/util/pmu.c                         |   5 +-
 tools/perf/util/pmu.h                         |   1 +
 10 files changed, 533 insertions(+), 210 deletions(-)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/branch.json (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/cache.json (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/other.json (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/uncore.json (51%)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json

-- 
2.26.2

