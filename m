Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F03FC4708F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE15560233
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhFAJ2z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:28:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2820 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhFAJ2y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 05:28:54 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvRWn6zJjzWqSW;
        Tue,  1 Jun 2021 17:22:29 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:27:10 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:27:09 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <acme@kernel.org>, <mhiramat@kernel.org>
CC:     <namhyung@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <srikar@linux.vnet.ibm.com>, <fche@redhat.com>,
        <Jianlin.Lv@arm.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
        <zhangjinhao2@huawei.com>, <lihuafei1@huawei.com>
Subject: [PATCH] perf probe: Fix null pointer dereference in convert_variable_location()
Date:   Tue, 1 Jun 2021 17:27:50 +0800
Message-ID: <20210601092750.169601-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If we just check whether the variable can be converted, 'tvar' should be
a null pointer. However, the null pointer check is missing in the
'Constant value' execution path.

The following cases can trigger this problem:

	$ cat test.c
	#include <stdio.h>

	void main(void)
	{
	        int a;
	        const int b = 1;

	        asm volatile("mov %1, %0" : "=r"(a): "i"(b));
	        printf("a: %d\n", a);
	}

	$ gcc test.c -o test -O -g
	$ sudo ./perf probe -x ./test -L "main"
	<main@/home/lhf/test.c:0>
	      0  void main(void)
	         {
	      2          int a;
	                 const int b = 1;

	                 asm volatile("mov %1, %0" : "=r"(a): "i"(b));
	      6          printf("a: %d\n", a);
	         }

	$ sudo ./perf probe -x ./test -V "main:6"
	Segmentation fault

The check on 'tvar' is added. If 'tavr' is a null pointer, we return 0
to indicate that the variable can be converted. Now, we can successfully
show the variables that can be accessed.

	$ sudo ./perf probe -x ./test -V "main:6"
	Available variables at main:6
	        @<main+13>
	                char*   __fmt
	                int     a
	                int     b

However, the variable 'b' cannot be tracked.

	$ sudo ./perf probe -x ./test -D "main:6 b"
	Failed to find the location of the 'b' variable at this address.
	 Perhaps it has been optimized out.
	 Use -V with the --range option to show 'b' location range.
	  Error: Failed to add events.

This is because __die_find_variable_cb() did not successfully match
variable 'b', which has the DW_AT_const_value attribute instead of
DW_AT_location. We added support for DW_AT_const_value in
__die_find_variable_cb(). With this modification, we can successfully
track the variable 'b'.

	$ sudo ./perf probe -x ./test -D "main:6 b"
	p:probe_test/main_L6 /home/lhf/test:0x1156 b=\1:s32

Fixes: 66f69b219716 ("perf probe: Support DW_AT_const_value constant value")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/util/dwarf-aux.c    | 8 ++++++--
 tools/perf/util/probe-finder.c | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index b2f4920e19a6..7d2ba8419b0c 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -975,9 +975,13 @@ static int __die_find_variable_cb(Dwarf_Die *die_mem, void *data)
 	if ((tag == DW_TAG_formal_parameter ||
 	     tag == DW_TAG_variable) &&
 	    die_compare_name(die_mem, fvp->name) &&
-	/* Does the DIE have location information or external instance? */
+	/*
+	 * Does the DIE have location information or const value
+	 * or external instance?
+	 */
 	    (dwarf_attr(die_mem, DW_AT_external, &attr) ||
-	     dwarf_attr(die_mem, DW_AT_location, &attr)))
+	     dwarf_attr(die_mem, DW_AT_location, &attr) ||
+	     dwarf_attr(die_mem, DW_AT_const_value, &attr)))
 		return DIE_FIND_CB_END;
 	if (dwarf_haspc(die_mem, fvp->addr))
 		return DIE_FIND_CB_CONTINUE;
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 866f2d514d72..b029c29ce227 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -190,6 +190,9 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	    immediate_value_is_supported()) {
 		Dwarf_Sword snum;
 
+		if (!tvar)
+			return 0;
+
 		dwarf_formsdata(&attr, &snum);
 		ret = asprintf(&tvar->value, "\\%ld", (long)snum);
 
-- 
2.17.1

