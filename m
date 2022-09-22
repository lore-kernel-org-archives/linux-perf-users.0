Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E88C6FA86
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 13:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIVNkf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIVNk0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 09:40:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1D05D124
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 06:40:24 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYGZD18zXzHpxG;
        Thu, 22 Sep 2022 21:38:12 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:40:22 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 21:40:21 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 0/4] perf: Some clean up
Date:   Thu, 22 Sep 2022 22:14:34 +0800
Message-ID: <20220922141438.22487-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some clean ups in tools/perf.

Shang XiaoJing (4):
  perf genelf: Fix error code in jit_write_elf()
  perf stat: Merge cases in process_evlist
  perf top: Fix error code in cmd_top()
  perf stat: Clean redundant if in process_evlist

 tools/perf/builtin-stat.c | 5 -----
 tools/perf/builtin-top.c  | 3 +++
 tools/perf/util/genelf.c  | 1 +
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.17.1

