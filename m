Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6125C04A68
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 09:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiG1Jj7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiG1Jj6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 05:39:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2EB765D46;
        Thu, 28 Jul 2022 02:39:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C601106F;
        Thu, 28 Jul 2022 02:39:58 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.43.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB97C3F73B;
        Thu, 28 Jul 2022 02:39:55 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        irogers@google.com
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: python: Fix build when PYTHON_CONFIG is user supplied
Date:   Thu, 28 Jul 2022 10:39:46 +0100
Message-Id: <20220728093946.1337642-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The previous change to Python autodetection had a small mistake where
the auto value was used to determine the Python binary, rather than the
user supplied value. The Python binary is only used for one part of the
build process, rather than the final linking, so it was producing
correct builds in most scenarios, especially when the auto detected
value matched what the user wanted, or the system only had a valid set
of Pythons.

Change it so that the Python binary path is derived from either the
PYTHON_CONFIG value or PYTHON value, depending on what is specified by
the user. This was the original intention.

This error was spotted in a build failure an odd cross compilation
environment after commit 4c41cb46a732fe82 ("perf python: Prefer
python3") was merged.

Fixes: 630af16eee495f58 ("perf tools: Use Python devtools for version autodetection rather than runtime")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d3c254c0f5c6..a69da9f34486 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -265,7 +265,7 @@ endif
 # defined. get-executable-or-default fails with an error if the first argument is supplied but
 # doesn't exist.
 override PYTHON_CONFIG := $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON_AUTO))
-override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_AUTO)))
+override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_CONFIG)))
 
 grep-libs  = $(filter -l%,$(1))
 strip-libs  = $(filter-out -l%,$(1))
-- 
2.28.0

