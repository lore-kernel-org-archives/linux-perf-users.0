Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8682FC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7CD60EE3
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 13:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhJRNxL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 09:53:11 -0400
Received: from foss.arm.com ([217.140.110.172]:38348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233214AbhJRNvK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Oct 2021 09:51:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5049B11B3;
        Mon, 18 Oct 2021 06:48:59 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.27.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC4223F73D;
        Mon, 18 Oct 2021 06:48:57 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     denik@chromium.org, James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf inject: Add vmlinux and ignore-vmlinux arguments
Date:   Mon, 18 Oct 2021 14:48:43 +0100
Message-Id: <20211018134844.2627174-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211018134844.2627174-1-james.clark@arm.com>
References: <20211018134844.2627174-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Other perf tools allow specifying the path to vmlinux. Perf inject
didn't have this argument which made some auxtrace workflows difficult.

Also add ignore-vmlinux for consistency with other tools.

Suggested-by: Denis Nitikin <denik@chromium.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-inject.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6ad191e731fc..4261ad89730f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -938,6 +938,10 @@ int cmd_inject(int argc, const char **argv)
 #endif
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose (show build ids, etc)"),
+		OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
+			   "file", "vmlinux pathname"),
+		OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
+			    "don't load vmlinux even if found"),
 		OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name, "file",
 			   "kallsyms pathname"),
 		OPT_BOOLEAN('f', "force", &data.force, "don't complain, do it"),
@@ -972,6 +976,9 @@ int cmd_inject(int argc, const char **argv)
 		return -1;
 	}
 
+	if (symbol__validate_sym_arguments())
+		return -1;
+
 	if (inject.in_place_update) {
 		if (!strcmp(inject.input_name, "-")) {
 			pr_err("Input file name required for in-place updating\n");
-- 
2.28.0

