Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C550FC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 13:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCE4611ED
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 13:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhIUNL4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:11:56 -0400
Received: from foss.arm.com ([217.140.110.172]:33406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232969AbhIUNLy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 09:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA362106F;
        Tue, 21 Sep 2021 06:10:25 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.50.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B144B3F59C;
        Tue, 21 Sep 2021 06:10:23 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, leo.yan@linaro.com,
        linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf tests: Fix trace+probe_vfs_getname.sh /tmp cleanup
Date:   Tue, 21 Sep 2021 14:10:08 +0100
Message-Id: <20210921131009.390810-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210921131009.390810-1-james.clark@arm.com>
References: <20210921131009.390810-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The temp file is only cleaned up if the test is not skipped, so delay
making it until after the skip so it doesn't get left behind in /tmp.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 3d31c1d560d6..3d60e993d2b8 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -17,8 +17,6 @@ skip_if_no_perf_trace || exit 2
 
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
-file=$(mktemp /tmp/temporary_file.XXXXX)
-
 trace_open_vfs_getname() {
 	evts=$(echo $(perf list syscalls:sys_enter_open* 2>/dev/null | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
 	perf trace -e $evts touch $file 2>&1 | \
@@ -32,6 +30,8 @@ if [ $err -ne 0 ] ; then
 	exit $err
 fi
 
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
 # Do not use whatever ~/.perfconfig file, it may change the output
 # via trace.{show_timestamp,show_prefix,etc}
 export PERF_CONFIG=/dev/null
-- 
2.28.0

