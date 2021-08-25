Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE1FC4320A
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F2A61075
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 16:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbhHYQoA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:44:00 -0400
Received: from foss.arm.com ([217.140.110.172]:55842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232649AbhHYQn7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Aug 2021 12:43:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF45D6E;
        Wed, 25 Aug 2021 09:43:12 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DFDE3F66F;
        Wed, 25 Aug 2021 09:43:11 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix *probe_vfs_getname.sh test failures
Date:   Wed, 25 Aug 2021 17:42:59 +0100
Message-Id: <20210825164259.833222-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The commit 4d6101f5fd5d ("perf probe: Clarify error message about not
finding kernel modules debuginfo") changed the error message "Failed to
find the path for kernel" to "Failed to find the path for the kernel".

Update the regex so that the tests still skip rather than fail when
kernel debug symbols aren't present.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index c2cc42daf924..5b17d916c555 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -19,6 +19,6 @@ add_probe_vfs_getname() {
 }
 
 skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for kernel|Debuginfo-analysis is not supported)" && return 2
+	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)" && return 2
 	return 1
 }
-- 
2.28.0

