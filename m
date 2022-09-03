Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C8C6FA82
	for <linux-perf-users@archiver.kernel.org>; Sat,  3 Sep 2022 06:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiICGu6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 3 Sep 2022 02:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiICGu4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 3 Sep 2022 02:50:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D484173307;
        Fri,  2 Sep 2022 23:50:55 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MKQNt29yDzrS2y;
        Sat,  3 Sep 2022 14:49:02 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 3 Sep 2022 14:50:52 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 3 Sep
 2022 14:50:51 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 0/3] perf: Clean up and fix potential mem leak
Date:   Sat, 3 Sep 2022 15:25:39 +0800
Message-ID: <20220903072542.27678-1-shangxiaojing@huawei.com>
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

Some clean up in perf.c and builtin-c2c.c.

Shang XiaoJing (3):
  perf clean: Add same_cmd_with_prefix helper
  perf c2c: Add helpers to get counts of loads or stores
  perf c2c: Prevent potential memory leak in c2c_he_zalloc

 tools/perf/builtin-c2c.c | 79 ++++++++++++++++++++--------------------
 tools/perf/perf.c        | 12 ++++--
 2 files changed, 48 insertions(+), 43 deletions(-)

-- 
2.17.1

