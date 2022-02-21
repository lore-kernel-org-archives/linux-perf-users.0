Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDCEC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Feb 2022 13:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbiBUNXG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 08:23:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359026AbiBUNXF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 08:23:05 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE321E19
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 05:22:42 -0800 (PST)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2NCC0RTBz681D8;
        Mon, 21 Feb 2022 21:17:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 14:22:40 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 13:22:37 +0000
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <olsajiri@gmail.com>, <rric@kernel.org>, <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/2] perf tool versioning fixes
Date:   Mon, 21 Feb 2022 21:16:47 +0800
Message-ID: <1645449409-158238-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This series includes a couple of fixes I made from working on a clone of
acme.git

It is based on perf/urgent @ commit b3d971ec2534.

Differences to v1:
- Add patch to fix kernel version tag
- Fix perf out-of-tree build

John Garry (2):
  perf: Fix dependency for version file creation
  perf: Fix version kernel tag

 tools/perf/Makefile.perf         |  4 ++--
 tools/perf/util/PERF-VERSION-GEN | 13 ++++---------
 2 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.26.2

