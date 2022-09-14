Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0758FC6FA82
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 12:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiINMBE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiINMAm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 08:00:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9647F087
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Sep 2022 05:00:41 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSJh33kFJzNm7h;
        Wed, 14 Sep 2022 19:56:03 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 20:00:39 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 20:00:38 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 3/5] perf dso: Merge cases in dso__read_binary_type_filename
Date:   Wed, 14 Sep 2022 20:35:05 +0800
Message-ID: <20220914123507.23319-4-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914123507.23319-1-shangxiaojing@huawei.com>
References: <20220914123507.23319-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Merge the cases having same procedure processing in
dso__read_binary_type_filename.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/util/dso.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index f1a14c0ad26d..6357ac1e9015 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -184,6 +184,8 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__VMLINUX:
 	case DSO_BINARY_TYPE__GUEST_VMLINUX:
 	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
 		__symbol__join_symfs(filename, size, dso->long_name);
 		break;
 
@@ -193,11 +195,6 @@ int dso__read_binary_type_filename(const struct dso *dso,
 			    root_dir, dso->long_name);
 		break;
 
-	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
-	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
-		__symbol__join_symfs(filename, size, dso->long_name);
-		break;
-
 	case DSO_BINARY_TYPE__KCORE:
 	case DSO_BINARY_TYPE__GUEST_KCORE:
 		snprintf(filename, size, "%s", dso->long_name);
-- 
2.17.1

