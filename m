Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E60C12002
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D998A6109F
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhGUImY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:42:24 -0400
Received: from foss.arm.com ([217.140.110.172]:49272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235742AbhGUI04 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 04:26:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5B1111D4;
        Wed, 21 Jul 2021 02:07:32 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.38.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DA2E3F694;
        Wed, 21 Jul 2021 02:07:30 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.org, al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 4/6] perf cs-etm: Update OpenCSD decoder for ETE
Date:   Wed, 21 Jul 2021 10:07:03 +0100
Message-Id: <20210721090706.21523-5-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721090706.21523-1-james.clark@arm.com>
References: <20210721090706.21523-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

OpenCSD v1.1.1 has a bug fix for the installation of the ETE decoder
headers. This also means that including headers separately for each
decoder is unnecessary so remove these.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/build/feature/test-libopencsd.c           | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index 52c790b0317b..eb6303ff446e 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((1 << 16) | (0 << 8) | (0))
+#define OCSD_MIN_VER ((1 << 16) | (1 << 8) | (1))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 1.0.0 is required"
+#error "OpenCSD >= 1.1.1 is required"
 #endif
 
 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 5972a8afcc6b..60147c908425 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -13,8 +13,6 @@
 #include <linux/zalloc.h>
 #include <stdlib.h>
 #include <opencsd/c_api/opencsd_c_api.h>
-#include <opencsd/etmv4/trc_pkt_types_etmv4.h>
-#include <opencsd/ocsd_if_types.h>
 
 #include "cs-etm.h"
 #include "cs-etm-decoder.h"
-- 
2.28.0

