Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48711ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 02:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIPCWE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Sep 2022 22:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIPCWD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Sep 2022 22:22:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8EB78BC4
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Sep 2022 19:22:02 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTHmP0R2QzmVRq;
        Fri, 16 Sep 2022 10:18:13 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 10:22:00 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 10:21:59 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 0/8] perf: Fix error return code
Date:   Fri, 16 Sep 2022 10:56:19 +0800
Message-ID: <20220916025627.13967-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Set the error return code that has been assigned by previous function to
the default value, which may caused by the patches insert function that
assign to the error code and overwrites the default one.

Shang XiaoJing (8):
  perf c2c: Fix error return code in perf_c2c__report
  perf lock: Fix error return code in __cmd_contention
  perf probe: Fix error return code in perf_del_probe_events
  perf record: Fix error return code in cmd_record
  perf report: Fix error return code in cmd_report
  perf sched: Fix error return code in perf_sched__timehist
  perf stat: Fix error return code in cmd_stat
  perf trace: Fix error return code in trace__replay and cmd_trace

 tools/perf/builtin-c2c.c    |  5 ++++-
 tools/perf/builtin-lock.c   | 10 +++++++---
 tools/perf/builtin-probe.c  |  8 ++++++--
 tools/perf/builtin-record.c |  3 +++
 tools/perf/builtin-report.c |  6 +++++-
 tools/perf/builtin-sched.c  |  1 +
 tools/perf/builtin-stat.c   |  9 +++++++--
 tools/perf/builtin-trace.c  |  5 +++++
 tools/perf/util/cgroup.c    |  2 +-
 9 files changed, 39 insertions(+), 10 deletions(-)

-- 
2.17.1

