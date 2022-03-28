Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CEFC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Mar 2022 01:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiC1B5S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Mar 2022 21:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiC1B5R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Mar 2022 21:57:17 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B050F22;
        Sun, 27 Mar 2022 18:55:36 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 09:55:35 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 28 Mar
 2022 09:55:34 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] perf evlist: Directly return instead of using local ret variable
Date:   Mon, 28 Mar 2022 09:55:32 +0800
Message-ID: <1648432532-23151-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

fixes coccinelle warning:
./tools/perf/util/evlist.c:1333:5-8: Unneeded variable: "err". Return
"- ENOMEM" on line 1358

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 tools/perf/util/evlist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9bb79e0..1883278 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1330,7 +1330,6 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 {
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
-	int err = -ENOMEM;
 
 	/*
 	 * Try reading /sys/devices/system/cpu/online to get
@@ -1355,7 +1354,7 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 out_put:
 	perf_cpu_map__put(cpus);
 out:
-	return err;
+	return -ENOMEM;
 }
 
 int evlist__open(struct evlist *evlist)
-- 
2.7.4

