Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB7C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC66261181
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 16:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbhJOQzt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:55:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3990 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbhJOQzs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 12:55:48 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HWC115fYtz686MY;
        Sat, 16 Oct 2021 00:49:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 18:53:40 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 17:53:37 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mingo@redhat.com>
CC:     <irogers@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] perf jevents: Enable warnings through HOSTCFLAGS
Date:   Sat, 16 Oct 2021 00:48:27 +0800
Message-ID: <1634316507-227751-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
References: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently no compiler warnings at all are enabled for building jevents,
so help catch bugs at compile time by enabling through HOSTCFLAGS.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/Makefile.config  | 1 +
 tools/perf/Makefile.perf    | 2 +-
 tools/perf/pmu-events/Build | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0ae2e3d8b832..65934984f032 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -17,6 +17,7 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
+HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
 include $(srctree)/tools/scripts/Makefile.arch
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7df13e74450c..118bcdc70bb4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -226,7 +226,7 @@ else
 endif
 
 export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
-export HOSTCC HOSTLD HOSTAR
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
 
 include $(srctree)/tools/build/Makefile.include
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a055dee6a46a..d5c287f069a2 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,7 @@
 hostprogs := jevents
 
 jevents-y	+= json.o jsmn.o jevents.o
-HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
+HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include $(HOSTCFLAGS)
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
 JSON		=  $(shell [ -d $(JDIR) ] &&				\
-- 
2.26.2

