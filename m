Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60924C433E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1377A64EB7
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhBRTAj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:00:39 -0500
Received: from mr85p00im-hyfv06011301.me.com ([17.58.23.184]:58915 "EHLO
        mr85p00im-hyfv06011301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231847AbhBRRHU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Feb 2021 12:07:20 -0500
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2021 12:07:20 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1613667430; bh=EJ+z2L/tEllhgwk+XPexkaLYm7t6nP8lodzn1ESuZdU=;
        h=From:To:Subject:Date:Message-Id;
        b=0ACWD8W9auvyUmXK0uIsPSN5ciP+WQw1bwIhoyiFTuERzNlry6EQkYyqroeP1d3vU
         N11jNS89J3aIixJQhKxdjhi7x7xRz4Ijjl1XFtgeKRePCJnqLzXFAhMUTZ3Qhy7S2l
         0ToOzMSojLdkhCQbLoYLDUBAERx0zoqMHW86gwPOO4jwP1AG3KdJIH7KcVoXIbuCVV
         2cyq89QfjjabJhPali69GoFvLoG4rg/yIvGda/pNDKOtwNUiMO9KARA/liN1y6choY
         SLveMboCVYpL+9J8WqcAKF+WHXb2kNSu1gF5J0rjHu146+fXy+8Zp9SMHxbLaRKaGD
         Kbc4BnLeDiYVQ==
Received: from delirium.com (home.amunra.co.uk [88.97.61.234])
        by mr85p00im-hyfv06011301.me.com (Postfix) with ESMTPSA id 3CD2B580926;
        Thu, 18 Feb 2021 16:57:08 +0000 (UTC)
From:   d.rigby@me.com
To:     d.rigby@me.com
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] perf unwind: Set userdata for all __report_module paths
Date:   Thu, 18 Feb 2021 16:56:54 +0000
Message-Id: <20210218165654.36604-1-d.rigby@me.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_08:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=862 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102180144
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Dave Rigby <d.rigby@me.com>

When locating the dwarf module for a given address, __find_debuginfo()
requires a 'struct dso' passed via the userdata argument.

However, this field is only set in __report_module() if the module is
found in via dwfl_addrmodule(), not if it is found later via dwfl_report_elf().

Set userdata irrespective of how the dwarf module was found, as long
as we found a module.

Fixes: bf53fc6b5f41 ("perf unwind: Fix separate debug info files when using elfutils' libdw's unwinder")
Cc: linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jan Kratochvil <jan.kratochvil@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/util/unwind-libdw.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 0ada907..a74b517 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -60,10 +60,8 @@ static int __report_module(struct addr_location *al, u64 ip,
 	mod = dwfl_addrmodule(ui->dwfl, ip);
 	if (mod) {
 		Dwarf_Addr s;
-		void **userdatap;
 
-		dwfl_module_info(mod, &userdatap, &s, NULL, NULL, NULL, NULL, NULL);
-		*userdatap = dso;
+		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
 		if (s != al->map->start - al->map->pgoff)
 			mod = 0;
 	}
@@ -79,6 +77,13 @@ static int __report_module(struct addr_location *al, u64 ip,
 					      al->map->start - al->map->pgoff, false);
 	}
 
+	if (mod) {
+		void **userdatap;
+
+		dwfl_module_info(mod, &userdatap, NULL, NULL, NULL, NULL, NULL, NULL);
+		*userdatap = dso;
+	}
+
 	return mod && dwfl_addrmodule(ui->dwfl, ip) == mod ? 0 : -1;
 }
 
-- 
1.8.3.1
