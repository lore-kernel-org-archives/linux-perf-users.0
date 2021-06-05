Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD01C47082
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 06:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0409461287
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 06:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFEGaT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 5 Jun 2021 02:30:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3435 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFEGaT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 5 Jun 2021 02:30:19 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxqPj2Gffz6tmM;
        Sat,  5 Jun 2021 14:25:29 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 14:28:29 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 14:28:28 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] perf/x86/intel/pt: fix doc warnings in pt.c
Date:   Sat, 5 Jun 2021 14:37:41 +0800
Message-ID: <20210605063741.687206-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 arch/x86/events/intel/pt.c:729: warning: Function parameter or 
  member 'cpu' not described in 'topa_insert_pages'
 arch/x86/events/intel/pt.c:1196: warning: Function parameter or 
  member 'cpu' not described in 'pt_buffer_init_topa'
 arch/x86/events/intel/pt.c:1196: warning: Function parameter or 
  member 'nr_pages' not described in 'pt_buffer_init_topa'
 arch/x86/events/intel/pt.c:1196: warning: Excess 
  function parameter 'size' description in 'pt_buffer_init_topa'
 arch/x86/events/intel/pt.c:1269: warning: Function parameter or 
  member 'event' not described in 'pt_buffer_setup_aux'
 arch/x86/events/intel/pt.c:1269: warning: Excess 
  function parameter 'cpu' description in 'pt_buffer_setup_aux'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 arch/x86/events/intel/pt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 915847655c06..035752429cea 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -718,6 +718,7 @@ static bool topa_table_full(struct topa *topa)
 /**
  * topa_insert_pages() - create a list of ToPA tables
  * @buf:	PT buffer being initialized.
+ * @cpu:	Cpu on which to allocate, -1 means current.
  * @gfp:	Allocation flags.
  *
  * This initializes a list of ToPA tables with entries from
@@ -1188,7 +1189,8 @@ static void pt_buffer_fini_topa(struct pt_buffer *buf)
 /**
  * pt_buffer_init_topa() - initialize ToPA table for pt buffer
  * @buf:	PT buffer.
- * @size:	Total size of all regions within this ToPA.
+ * @cpu:	Cpu on which to allocate, -1 means current.
+ * @nr_pages:	Number of pages in the buffer.
  * @gfp:	Allocation flags.
  */
 static int pt_buffer_init_topa(struct pt_buffer *buf, int cpu,
@@ -1253,7 +1255,7 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
 
 /**
  * pt_buffer_setup_aux() - set up topa tables for a PT buffer
- * @cpu:	Cpu on which to allocate, -1 means current.
+ * @event:	The perf event.
  * @pages:	Array of pointers to buffer pages passed from perf core.
  * @nr_pages:	Number of pages in the buffer.
  * @snapshot:	If this is a snapshot/overwrite counter.
-- 
2.31.1

