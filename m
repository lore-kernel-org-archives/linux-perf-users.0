Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B09C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Mar 2022 19:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbiCRUAt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Mar 2022 16:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbiCRUAs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Mar 2022 16:00:48 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D0A18CD30;
        Fri, 18 Mar 2022 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1647633570; x=1679169570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Khi4kBeH9SGzO7ZWXykd26lWjrq52nVJrfKWlqa0m44=;
  b=C0KLTOU339pEwFiAFLg1HrXj3NslxiSByvJQpqmKjVC+vyqmHverx38d
   VyVMRBDTAjKFA3dMouxkssad2+wxTy+YsYkTA1NxPpQucOYSaRZUKz6by
   h5xaPe0AZBFTu/PifOPgCFAJG4oEpa7DgvIejhgNC6UU+gfGemTo1WI7M
   M=;
X-IronPort-AV: E=Sophos;i="5.90,192,1643673600"; 
   d="scan'208";a="72160464"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 18 Mar 2022 19:59:28 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com (Postfix) with ESMTPS id CF876A0DA0;
        Fri, 18 Mar 2022 19:59:27 +0000 (UTC)
Received: from EX13D02UWC001.ant.amazon.com (10.43.162.243) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 18 Mar 2022 19:59:27 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02UWC001.ant.amazon.com (10.43.162.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 18 Mar 2022 19:59:27 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Fri, 18 Mar 2022 19:59:26
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 87481BBB; Fri, 18 Mar 2022 19:59:25 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <german.gomez@arm.com>,
        <leo.yan@linaro.org>
CC:     <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
        <Nick.Forrington@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <andrew.kilroy@arm.com>,
        <james.clark@arm.com>, <john.garry@huawei.com>, <jolsa@kernel.org>,
        <kjain@linux.ibm.com>, <lihuafei1@huawei.com>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: [PATCH v3 3/3] perf mem: Support HITM for when mem_lvl_num is any
Date:   Fri, 18 Mar 2022 19:59:13 +0000
Message-ID: <20220318195913.17459-4-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318195913.17459-1-alisaidi@amazon.com>
References: <20220318195913.17459-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For loads that hit in a the LLC snoop filter and are fulfilled from a
higher level cache on arm64 Neoverse cores, it's not usually clear what
the true level of the cache the data came from (i.e. a transfer from a
core could come from it's L1 or L2). Instead of making an assumption of
where the line came from, add support for incrementing HITM if the
source is CACHE_ANY.

Since other architectures don't seem to populate the mem_lvl_num field
here there shouldn't be a change in functionality.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/mem-events.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index e5e405185498..084977cfebef 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -539,6 +539,15 @@ do {				\
 					stats->ld_llchit++;
 			}
 
+			/*
+			 * A hit in another cores cache must mean a llc snoop
+			 * filter hit
+			 */
+			if (lnum == P(LVLNUM, ANY_CACHE)) {
+				if (snoop & P(SNOOP, HITM))
+					HITM_INC(lcl_hitm);
+			}
+
 			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {
 				stats->lcl_dram++;
 				if (snoop & P(SNOOP, HIT))
-- 
2.32.0

