Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6EAC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 Nov 2021 18:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369CC610CA
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 Nov 2021 18:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhKBSKl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:10:41 -0400
Received: from foss.arm.com ([217.140.110.172]:41316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234882AbhKBSKk (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Nov 2021 14:10:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A374142F;
        Tue,  2 Nov 2021 11:08:05 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85AD13F7B4;
        Tue,  2 Nov 2021 11:08:03 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] perf arm-spe: Save context ID in record
Date:   Tue,  2 Nov 2021 18:07:38 +0000
Message-Id: <20211102180739.18049-3-german.gomez@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211102180739.18049-1-german.gomez@arm.com>
References: <20211102180739.18049-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch is to save context ID in record, this will be used to set TID
for samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 32fe41835..1b58859d2 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -151,6 +151,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 	u64 payload, ip;
 
 	memset(&decoder->record, 0x0, sizeof(decoder->record));
+	decoder->record.context_id = -1;
 
 	while (1) {
 		err = arm_spe_get_next_packet(decoder);
@@ -180,6 +181,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 		case ARM_SPE_COUNTER:
 			break;
 		case ARM_SPE_CONTEXT:
+			decoder->record.context_id = payload;
 			break;
 		case ARM_SPE_OP_TYPE:
 			if (idx == SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC) {
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 59bdb7309..46a8556a9 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -38,6 +38,7 @@ struct arm_spe_record {
 	u64 timestamp;
 	u64 virt_addr;
 	u64 phys_addr;
+	u64 context_id;
 };
 
 struct arm_spe_insn;
-- 
2.25.1

