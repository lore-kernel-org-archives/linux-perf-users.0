Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC4CC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Feb 2022 13:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359036AbiBUNXS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 08:23:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359030AbiBUNXL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 08:23:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E5B21E20
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 05:22:48 -0800 (PST)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2NHZ0yHkz6898d;
        Mon, 21 Feb 2022 21:21:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 14:22:46 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 13:22:43 +0000
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <olsajiri@gmail.com>, <rric@kernel.org>, <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/2] perf: Fix version kernel tag
Date:   Mon, 21 Feb 2022 21:16:49 +0800
Message-ID: <1645449409-158238-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645449409-158238-1-git-send-email-john.garry@huawei.com>
References: <1645449409-158238-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Generating the version kernel tag relies on "git describe" command to get
the latest Linus kernel tag.

However, when working from clones of Linus' git we may not have the latest
tag. For example, when working on Arnaldo's acme.git, we can have this:
$git branch
perf/core
$head -n 5 ../../Makefile
head -n 5 ../../Makefile  | tail -n 4
VERSION = 5
PATCHLEVEL = 17
SUBLEVEL = 0
EXTRAVERSION = -rc3
$ git describe --abbrev=0 --match "v[0-9].[0-9]*"
v4.13-rc5

Indeed using tags is a problem as it relies on tags being pulled from
Linus' git (and pushed to the clone).

In commit a4147f0f9138 ("perf tools: Fix perf version generation"), Robert
introduced a change to use the kernelversion rule to generate the kernel
tag when no git tags are available. However, as mentioned above, the tag we
generate may be incorrect, so just always use kernelversion to get the tag
(apart from building perf out of tree).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/PERF-VERSION-GEN | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
index 59241ff342be..0ee5af529238 100755
--- a/tools/perf/util/PERF-VERSION-GEN
+++ b/tools/perf/util/PERF-VERSION-GEN
@@ -11,23 +11,18 @@ LF='
 '
 
 #
-# First check if there is a .git to get the version from git describe
-# otherwise try to get the version from the kernel Makefile
+# Always try first to get the version from the kernel Makefile
 #
 CID=
 TAG=
 if test -d ../../.git -o -f ../../.git
 then
-	TAG=$(git describe --abbrev=0 --match "v[0-9].[0-9]*" 2>/dev/null )
+	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
 	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
-elif test -f ../../PERF-VERSION-FILE
-then
+else
 	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
 fi
-if test -z "$TAG"
-then
-	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
-fi
+
 VN="$TAG$CID"
 if test -n "$CID"
 then
-- 
2.26.2

