Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B064AC6FA94
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 13:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIVNkg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIVNka (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 09:40:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD4FB6003
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 06:40:27 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYGX03dv0zlWGG;
        Thu, 22 Sep 2022 21:36:16 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:40:25 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 21:40:24 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 3/4] perf top: Fix error code in cmd_top()
Date:   Thu, 22 Sep 2022 22:14:37 +0800
Message-ID: <20220922141438.22487-4-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922141438.22487-1-shangxiaojing@huawei.com>
References: <20220922141438.22487-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There are three error paths which return success:

1. Propagate the errno from evlist__create_maps() if it failed.

2. Return -EINVAL if top.sb_evlist is NULL.

3. Return -EINVAL if evlist__add_bpf_sb_event() failed.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-top.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e89208b4ad4b..4b3ff7687236 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1707,6 +1707,7 @@ int cmd_top(int argc, const char **argv)
 	if (evlist__create_maps(top.evlist, target) < 0) {
 		ui__error("Couldn't create thread/CPU maps: %s\n",
 			  errno == ENOENT ? "No such process" : str_error_r(errno, errbuf, sizeof(errbuf)));
+		status = -errno;
 		goto out_delete_evlist;
 	}
 
@@ -1759,11 +1760,13 @@ int cmd_top(int argc, const char **argv)
 
 		if (top.sb_evlist == NULL) {
 			pr_err("Couldn't create side band evlist.\n.");
+			status = -EINVAL;
 			goto out_delete_evlist;
 		}
 
 		if (evlist__add_bpf_sb_event(top.sb_evlist, &perf_env)) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			status = -EINVAL;
 			goto out_delete_evlist;
 		}
 	}
-- 
2.17.1

