Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92896C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Mar 2022 09:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiCRJOe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiCRJOd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Mar 2022 05:14:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6DB6FA21;
        Fri, 18 Mar 2022 02:13:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKdXr51swzCqs4;
        Fri, 18 Mar 2022 17:11:08 +0800 (CST)
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
Subject: [PATCH RESEND 0/2] perf tools: Fix mis-matching of perf sub-commands
Date:   Fri, 18 Mar 2022 17:22:43 +0800
Message-ID: <20220318092245.2700489-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
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

We support short command 'rec*' for 'record' and 'rep*' for 'report' in
lots of sub-commands, but the matching is not quite strict currnetly.

It may be puzzling sometime, like we mis-type a 'recport' to report but
it will perform 'record' in fact without any message. So fix the
mis-matching.

Wei Li (2):
  perf string: Add strcmp_prefix()
  perf tools: Enhance the matching of sub-commands

 tools/perf/builtin-c2c.c       |  5 +++--
 tools/perf/builtin-kmem.c      |  2 +-
 tools/perf/builtin-kvm.c       |  9 +++++----
 tools/perf/builtin-lock.c      |  5 +++--
 tools/perf/builtin-mem.c       |  5 +++--
 tools/perf/builtin-sched.c     |  4 ++--
 tools/perf/builtin-script.c    |  6 ++++--
 tools/perf/builtin-stat.c      |  4 ++--
 tools/perf/builtin-timechart.c |  3 ++-
 tools/perf/util/string.c       | 17 +++++++++++++++++
 tools/perf/util/string2.h      |  1 +
 11 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.25.1

