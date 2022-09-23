Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC7FECAAD8
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 08:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIWILa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiIWILa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 04:11:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A29110B25
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 01:11:27 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYl9G5J7tzMpPk;
        Fri, 23 Sep 2022 16:06:42 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 16:11:26 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 16:11:25 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <yao.jin@linux.intel.com>, <shangxiaojing@huawei.com>
Subject: [PATCH v2 0/6] perf: Clean up by adding helpers and Merging
Date:   Fri, 23 Sep 2022 16:45:34 +0800
Message-ID: <20220923084540.25849-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some Clean up in tools/perf.

changes in v2:
- adjust the subject or commit msg of some patches
- add the patch 6 "perf script: Add perf_sample__fprintf_dsoname helper"

Shang XiaoJing (6):
  perf block-info: Merge branches in __block_info__cmp
  perf block-range: Add block_range__insert_left/right helper
  perf dso: Merge cases in dso__read_binary_type_filename
  perf stat: Add print_cache_common helper
  perf genelf: Add create_section_and_get_data helper
  perf script: Add perf_sample__fprintf_dsoname helper

 tools/perf/builtin-script.c   | 64 +++++++++--------------
 tools/perf/util/block-info.c  |  4 +-
 tools/perf/util/block-range.c | 36 +++++++------
 tools/perf/util/dso.c         |  7 +--
 tools/perf/util/genelf.c      | 96 +++++++++--------------------------
 tools/perf/util/stat-shadow.c | 80 +++++++++--------------------
 6 files changed, 99 insertions(+), 188 deletions(-)

-- 
2.17.1

