Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC53DC433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932A564E77
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBJNXj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 08:23:39 -0500
Received: from foss.arm.com ([217.140.110.172]:37746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhBJNXc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Feb 2021 08:23:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B48A113E;
        Wed, 10 Feb 2021 05:22:45 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.16.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B744A3F73D;
        Wed, 10 Feb 2021 05:22:44 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>
Subject: [PATCH v2 2/4] perf tools: add a mechanism to inject stack frames
Date:   Wed, 10 Feb 2021 13:22:11 +0000
Message-Id: <20210210132213.8146-2-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210210132213.8146-1-alexandre.truong@arm.com>
References: <20210210132213.8146-1-alexandre.truong@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a mechanism for platforms to inject stack frames for the leaf
frame caller if there is enough information to determine a frame
is missing from dwarf or other post processing mechanisms.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
---
 tools/perf/util/machine.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 522ea3236bcc..40082d70eec1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2671,6 +2671,12 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 	return err;
 }
 
+static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
+		struct thread *thread __maybe_unused)
+{
+	return 0;
+}
+
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct evsel *evsel,
@@ -2687,6 +2693,8 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	int i, j, err, nr_entries;
 	int skip_idx = -1;
 	int first_call = 0;
+	u64 leaf_frame_caller;
+	int pos;
 
 	if (chain)
 		chain_nr = chain->nr;
@@ -2811,6 +2819,21 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 		}
 
+		pos = callchain_param.order == ORDER_CALLEE ? 2 : chain_nr - 2;
+
+		if (i == pos) {
+			leaf_frame_caller = get_leaf_frame_caller(sample, thread);
+
+			if (leaf_frame_caller && leaf_frame_caller != ip) {
+
+				err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, leaf_frame_caller,
+					       false, NULL, NULL, 0);
+				if (err)
+					return (err < 0) ? err : 0;
+			}
+		}
+
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       false, NULL, NULL, 0);
-- 
2.23.0

