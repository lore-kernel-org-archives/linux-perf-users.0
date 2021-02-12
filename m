Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE2C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Feb 2021 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62DC64E42
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Feb 2021 17:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhBLRFD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Feb 2021 12:05:03 -0500
Received: from foss.arm.com ([217.140.110.172]:39934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhBLREy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Feb 2021 12:04:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E3F2139F;
        Fri, 12 Feb 2021 09:04:06 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.5.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C1403F73B;
        Fri, 12 Feb 2021 09:04:05 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>
Subject: [PATCH v2 3/4] perf tools: enable dwarf_callchain_users on aarch64
Date:   Fri, 12 Feb 2021 17:03:42 +0000
Message-Id: <20210212170343.7729-3-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210212170343.7729-1-alexandre.truong@arm.com>
References: <20210212170343.7729-1-alexandre.truong@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On arm64, enable dwarf_callchain_users which will be needed
to do a dwarf unwind in order to get the caller of the leaf frame.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
---
 tools/perf/builtin-report.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2a845d6cac09..93661a3eaeb1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -405,6 +405,10 @@ static int report__setup_sample_type(struct report *rep)
 
 	callchain_param_setup(sample_type);
 
+	if (callchain_param.record_mode == CALLCHAIN_FP &&
+			strncmp(rep->session->header.env.arch, "aarch64", 7) == 0)
+		dwarf_callchain_users = true;
+
 	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
 			    "Please apply --call-graph lbr when recording.\n");
-- 
2.23.0

