Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB734C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Mar 2022 17:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244418AbiCGRUY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244414AbiCGRUX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Mar 2022 12:20:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 429B677AB9;
        Mon,  7 Mar 2022 09:19:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13695153B;
        Mon,  7 Mar 2022 09:19:29 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.41.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E1673FA45;
        Mon,  7 Mar 2022 09:19:27 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        anshuman.khandual@arm.com
Cc:     german.gomez@arm.com, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] perf: Print branch stack entry type in --dump-raw-trace
Date:   Mon,  7 Mar 2022 17:19:15 +0000
Message-Id: <20220307171917.2555829-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220307171917.2555829-1-james.clark@arm.com>
References: <20220307171917.2555829-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This can help with debugging issues. It only prints when -j save_type
is used otherwise an empty string is printed.

Before the change:

  101603801707130 0xa70 [0x630]: PERF_RECORD_SAMPLE(IP, 0x2): 1108/1108: 0xffff9c1df24c period: 10694 addr: 0
  ... branch stack: nr:64
  .....  0: 0000ffff9c26029c -> 0000ffff9c26f340 0 cycles  P   0
  .....  1: 0000ffff9c2601bc -> 0000ffff9c26f340 0 cycles  P   0

After the change:

  101603801707130 0xa70 [0x630]: PERF_RECORD_SAMPLE(IP, 0x2): 1108/1108: 0xffff9c1df24c period: 10694 addr: 0
  ... branch stack: nr:64
  .....  0: 0000ffff9c26029c -> 0000ffff9c26f340 0 cycles  P   0 CALL
  .....  1: 0000ffff9c2601bc -> 0000ffff9c26f340 0 cycles  P   0 IND_CALL

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/session.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f54282d5c648..3b8dfe603e50 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1159,14 +1159,15 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 		struct branch_entry *e = &entries[i];
 
 		if (!callstack) {
-			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x\n",
+			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %s\n",
 				i, e->from, e->to,
 				(unsigned short)e->flags.cycles,
 				e->flags.mispred ? "M" : " ",
 				e->flags.predicted ? "P" : " ",
 				e->flags.abort ? "A" : " ",
 				e->flags.in_tx ? "T" : " ",
-				(unsigned)e->flags.reserved);
+				(unsigned)e->flags.reserved,
+				e->flags.type ? branch_type_name(e->flags.type) : "");
 		} else {
 			printf("..... %2"PRIu64": %016" PRIx64 "\n",
 				i, i > 0 ? e->from : e->to);
-- 
2.28.0

