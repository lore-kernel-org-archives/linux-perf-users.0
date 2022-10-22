Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C84C433FE
	for <linux-perf-users@archiver.kernel.org>; Sat, 22 Oct 2022 10:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJVKfS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 22 Oct 2022 06:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJVKeu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 22 Oct 2022 06:34:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B5BAC388;
        Sat, 22 Oct 2022 02:51:30 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MvbYb1tr3zmVBf;
        Sat, 22 Oct 2022 17:26:11 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 17:30:59 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 17:30:58 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <ak@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 1/3] perf daemon: Check err before calling setup_server_config in __cmd_start
Date:   Sat, 22 Oct 2022 17:27:33 +0800
Message-ID: <20221022092735.114967-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20221022092735.114967-1-yangjihong1@huawei.com>
References: <20221022092735.114967-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If err!=0 before calling setup_server_config and reconfig==true,
setup_server_config function may return 0 and err becomes 0.
As a result, previous error is overwritten, need to check value of err first.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 6cb3f6cc36d0..b82bd902602a 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1333,7 +1333,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 			if (fda.entries[signal_pos].revents & POLLIN)
 				err = handle_signalfd(daemon) < 0;
 
-			if (reconfig)
+			if (!err && reconfig)
 				err = setup_server_config(daemon);
 		}
 	}
-- 
2.30.GIT

