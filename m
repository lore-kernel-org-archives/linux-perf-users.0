Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5791CC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3647061139
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhJFJ7R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:59:17 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139]:52809 "EHLO
        esa6.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229874AbhJFJ7P (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 05:59:15 -0400
IronPort-SDR: Z3L3ldJ4jOYFCMBkyH6glg8g9T2OcYbocgNJNF4YBwABS3nEotQG9d1gVlWbHG8WbpKj7tu0vq
 23GoG/d7V+xsykeIiO7GfwtN9w4rGA8AbyTiHd0JHTAYSABu347SxW4Bbx4SQae2D4VyX37Cwu
 InzQntMVIS4ODmKUeBCU4lYCd3Xb2ZvrJgtX4eYCPg5ME4kqCHenu8qqpdFlTHadddk1pJXjej
 AARjqbKdbsFeGXzDN16+hlpjcckPUSjAqWJMvmjiiRdeMIf2p+r2fK7YofY/hAWf6pUE1WSiq1
 ALW0bHrTRLT9ALmsdFZodiZm
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="47996128"
X-IronPort-AV: E=Sophos;i="5.85,350,1624287600"; 
   d="scan'208";a="47996128"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Oct 2021 18:57:21 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 52042E6880;
        Wed,  6 Oct 2021 18:57:21 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8CABA216AE9;
        Wed,  6 Oct 2021 18:57:20 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 427AB4019A56D;
        Wed,  6 Oct 2021 18:57:20 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] libperf test: Fix build error
Date:   Wed,  6 Oct 2021 18:57:03 +0900
Message-Id: <20211006095703.477826-1-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In test_stat_user_read, following build error occurs except i386 and 
x86_64 architectures:

tests/test-evsel.c:129:31: error: variable 'pc' set but not used [-Werror=unused-but-set-variable]
  struct perf_event_mmap_page *pc;

Fix build error.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evsel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index a184e4861627..9abd4c0bf6db 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -148,6 +148,7 @@ static int test_stat_user_read(int event)
 	__T("failed to mmap evsel", err == 0);
 
 	pc = perf_evsel__mmap_base(evsel, 0, 0);
+	__T("failed to get mmapped address", pc);
 
 #if defined(__i386__) || defined(__x86_64__)
 	__T("userspace counter access not supported", pc->cap_user_rdpmc);
-- 
2.25.1

