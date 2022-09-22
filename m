Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3D8C54EE9
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 13:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIVNkd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIVNk0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 09:40:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75CD7F09B
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 06:40:25 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYGWz2sFdz14S3R;
        Thu, 22 Sep 2022 21:36:15 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:40:23 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 21:40:22 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 1/4] perf genelf: Fix error code in jit_write_elf()
Date:   Thu, 22 Sep 2022 22:14:35 +0800
Message-ID: <20220922141438.22487-2-shangxiaojing@huawei.com>
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

The error code is set to -1 at the beginning of jit_write_elf(), but it is
assigned by jit_add_eh_frame_info() in the middle, hence the following
error can only return the error code of jit_add_eh_frame_info(). Reset
the error code to the default value after being assigned by
jit_add_eh_frame_info().

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/util/genelf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index ed28a0dbcb7f..2e45b204494a 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -331,6 +331,7 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 					       eh_frame_base_offset);
 		if (retval)
 			goto error;
+		retval = -1;
 	}
 
 	/*
-- 
2.17.1

