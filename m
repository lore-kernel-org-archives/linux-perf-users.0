Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF42EEB64D8
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jun 2023 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjFTP5O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjFTP5K (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jun 2023 11:57:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA6B7;
        Tue, 20 Jun 2023 08:57:08 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qlrln3fy1zMpHZ;
        Tue, 20 Jun 2023 23:53:57 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 20 Jun 2023 23:57:04 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 0/2] perf/core: deliver PERF_RECORD_COMM and PERF_RECORD_MMAP side-band events to all online cpus
Date:   Tue, 20 Jun 2023 15:55:13 +0000
Message-ID: <20230620155515.101222-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Tasks are migrated between cores due to scheduling.
If perf samples specified CPUs, PERF_RECORD_COMM and PERF_RECORD_MMAP
events need be deliver to all cores to avoids the problem that the comm
and symbols cannot be parsed due to task migration to the target core.

The specific scenarios are as follows:

         CPU0                                 CPU1
  perf record -C 0 start
                              taskA starts to be created and executed
                                -> PERF_RECORD_COMM and PERF_RECORD_MMAP
                                   events only deliver to CPU1
                              ......
                                |
                          migrate to CPU0
                                |
  Running on CPU0    <----------/
  ...

  perf record -C 0 stop

Now perf samples the PC of taskA. However, perf does not record the
PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
Therefore, the comm and symbols of taskA cannot be parsed.

Yang Jihong (2):
  perf/core: perf_iterate_sb_cpu() supports to receive side-band events
    for all oneline cpus
  perf/core: deliver PERF_RECORD_COMM and PERF_RECORD_MMAP side-band
    events to all online cpus

 kernel/events/core.c | 58 +++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 17 deletions(-)

-- 
2.30.GIT

