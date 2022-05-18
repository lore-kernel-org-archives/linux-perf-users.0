Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D731C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 13:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbiERNSD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 09:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiERNSC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 09:18:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDE1ABF49;
        Wed, 18 May 2022 06:18:01 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3D6q27SbzhZ6R;
        Wed, 18 May 2022 21:17:23 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 21:17:59 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 21:17:58 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gustavoars@kernel.org>, <johnny.chenyi@huawei.com>,
        <chenjiahao16@huawei.com>, <chenlifu@huawei.com>,
        <lizhengyu3@huawei.com>, <liaochang1@huawei.com>,
        <linyujun809@huawei.com>, <wangzhu9@huawei.com>,
        <xuyihang@huawei.com>, <chris.zjh@huawei.com>,
        <zouyipeng@huawei.com>
Subject: [PATCH -next] x86/events:Use struct_size() helper in kzalloc()
Date:   Wed, 18 May 2022 21:16:26 +0800
Message-ID: <20220518131626.109123-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Replace sizeof() with struct_size() to avoid potential integer
or heap overflow.

Also, address the following sparse warnings:
arch/x86/events/rapl.c:685:16: warning: using sizeof on a
flexible structure

Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/x86/events/rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47af5ad..c7e79f0ac04f 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -685,7 +685,7 @@ static int __init init_rapl_pmus(void)
 	int maxdie = topology_max_packages() * topology_max_die_per_package();
 	size_t size;
 
-	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
+	size = struct_size(rapl_pmus, pmus, maxdie);
 	rapl_pmus = kzalloc(size, GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
-- 
2.17.1

