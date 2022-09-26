Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB7AC6FA82
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Sep 2022 03:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiIZDSf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 25 Sep 2022 23:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIZDSd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 25 Sep 2022 23:18:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CAD25EB4;
        Sun, 25 Sep 2022 20:18:32 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MbSXT23mDz1P72q;
        Mon, 26 Sep 2022 11:14:17 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:30 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:30 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <john.garry@huawei.com>, <adrian.hunter@intel.com>,
        <ak@linux.intel.com>, <florian.fischer@muhq.space>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next 0/5] perf: Minor fixes and cleanup
Date:   Mon, 26 Sep 2022 11:14:35 +0800
Message-ID: <20220926031440.28275-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This series fixes and cleans up some minor issues for perf-event and
perf-trace. Mainly about cleaning dead code and macros.

Chen Zhongjin (5):
  perf: Fix show_arg_names not working for tp arg names
  perf: Fix incorrectly parsed flags in filter
  perf: Remove duplicate errbuf
  perf: Remove unused macros __PERF_EVENT_FIELD
  perf: Remove unused macro K

 tools/perf/builtin-trace.c     | 20 +++++---------------
 tools/perf/util/parse-events.c |  8 --------
 tools/perf/util/string.c       |  1 -
 3 files changed, 5 insertions(+), 24 deletions(-)

-- 
2.17.1

