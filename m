Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896ABC04A95
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Oct 2022 11:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJYLHO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Oct 2022 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJYLHN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Oct 2022 07:07:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA446188AA9
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Oct 2022 04:07:11 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxTZn2Tk0zpVpp;
        Tue, 25 Oct 2022 19:03:45 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:07:09 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        <linux-perf-users@vger.kernel.org>
CC:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <liuqi6124@gmail.com>, <jonathan.cameron@huawei.com>,
        <alexander.shishkin@linux.intel.com>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH 0/2] perf/tool: minor cleanups
Date:   Tue, 25 Oct 2022 19:06:32 +0800
Message-ID: <20221025110634.45405-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Some cleanups for perf noticed in the previous review of hisi-ptt:

- Duplicated definition of unit marco MiB/KiB
- auxtrace->flush_events() is optional to some PMU and can be improved

Yicong Yang (2):
  perf tool: move unit macros to kernel.h
  perf auxtrace: Make auxtrace->flush_events() optional

 tools/include/linux/kernel.h          | 5 +++++
 tools/perf/arch/arm64/util/arm-spe.c  | 3 ---
 tools/perf/arch/arm64/util/hisi-ptt.c | 3 ---
 tools/perf/arch/x86/util/intel-bts.c  | 5 -----
 tools/perf/arch/x86/util/intel-pt.c   | 5 -----
 tools/perf/util/auxtrace.c            | 2 +-
 tools/perf/util/auxtrace.h            | 2 +-
 tools/perf/util/cs-etm.h              | 3 ---
 tools/perf/util/hisi-ptt.c            | 7 -------
 tools/perf/util/s390-cpumsf.c         | 7 -------
 10 files changed, 7 insertions(+), 35 deletions(-)

-- 
2.24.0

