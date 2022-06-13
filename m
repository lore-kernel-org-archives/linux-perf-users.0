Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDB0CCA47D
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Jun 2022 09:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbiFMJsp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Jun 2022 05:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbiFMJsK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B90193F8;
        Mon, 13 Jun 2022 02:48:08 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LM6D66n53zjXZg;
        Mon, 13 Jun 2022 17:47:02 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:05 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:05 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 05/13] tools lib: Add list_last_entry_or_null
Date:   Mon, 13 Jun 2022 17:45:57 +0800
Message-ID: <20220613094605.208401-6-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220613094605.208401-1-yangjihong1@huawei.com>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add list_last_entry_or_null to get the last element from a list,
returns NULL if the list is empty.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/include/linux/list.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/linux/list.h b/tools/include/linux/list.h
index b2fc48d5478c..a4dfb6a7cc6a 100644
--- a/tools/include/linux/list.h
+++ b/tools/include/linux/list.h
@@ -384,6 +384,17 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_first_entry_or_null(ptr, type, member) \
 	(!list_empty(ptr) ? list_first_entry(ptr, type, member) : NULL)
 
+/**
+ * list_last_entry_or_null - get the last element from a list
+ * @ptr:       the list head to take the element from.
+ * @type:      the type of the struct this is embedded in.
+ * @member:    the name of the list_head within the struct.
+ *
+ * Note that if the list is empty, it returns NULL.
+ */
+#define list_last_entry_or_null(ptr, type, member) \
+	(!list_empty(ptr) ? list_last_entry(ptr, type, member) : NULL)
+
 /**
  * list_next_entry - get the next element in list
  * @pos:	the type * to cursor
-- 
2.30.GIT

