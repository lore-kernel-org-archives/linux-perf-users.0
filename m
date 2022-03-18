Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C993DC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Mar 2022 09:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiCRJOe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiCRJOd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Mar 2022 05:14:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B676070063;
        Fri, 18 Mar 2022 02:13:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKdYV3ZhjzfYrD;
        Fri, 18 Mar 2022 17:11:42 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 17:13:11 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH RESEND 1/2] perf string: Add strcmp_prefix()
Date:   Fri, 18 Mar 2022 17:22:44 +0800
Message-ID: <20220318092245.2700489-2-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318092245.2700489-1-liwei391@huawei.com>
References: <20220318092245.2700489-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a helper to check whether a string has the given prefix.
This function is stolen from fs/xattr.c

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/util/string.c  | 17 +++++++++++++++++
 tools/perf/util/string2.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index f6d90cdd9225..0ed3e2d0b70f 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -209,6 +209,23 @@ int strtailcmp(const char *s1, const char *s2)
 	return 0;
 }
 
+/**
+ * strcmp_prefix - check string for given prefix
+ * @str: the target string to check
+ * @prefix: the given prefix to match
+ *
+ * Return the rest string in @str if @str has the given @prefix, return NULL
+ * otherwise.
+ */
+const char *strcmp_prefix(const char *str, const char *prefix)
+{
+	while (*prefix && *str == *prefix) {
+		str++;
+		prefix++;
+	}
+	return *prefix ? NULL : str;
+}
+
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
 {
 	/*
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 56c30fef9682..58929ad928f7 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -20,6 +20,7 @@ static inline bool strisglob(const char *str)
 	return strpbrk(str, "*?[") != NULL;
 }
 int strtailcmp(const char *s1, const char *s2);
+const char *strcmp_prefix(const char *str, const char *prefix);
 
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
 
-- 
2.25.1

