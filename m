Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BC3C4320E
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D33C610CB
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 14:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbhHaO4K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:56:10 -0400
Received: from foss.arm.com ([217.140.110.172]:55704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237512AbhHaO4J (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 10:56:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF6C9106F;
        Tue, 31 Aug 2021 07:55:13 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.42.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 703863F5A1;
        Tue, 31 Aug 2021 07:55:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 3/3] perf tools: Fix LLVM download hint link
Date:   Tue, 31 Aug 2021 15:55:01 +0100
Message-Id: <20210831145501.2135754-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210831145501.2135754-1-james.clark@arm.com>
References: <20210831145501.2135754-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

http://llvm.org/apt returns 404, it has moved to https://apt.llvm.org/

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/llvm-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index d95c56d175bc..96c8ef60f4f8 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -234,7 +234,7 @@ version_notice(void)
 "     \t\tgit clone http://llvm.org/git/clang.git\n\n"
 "     \tOr fetch the latest clang/llvm 3.7 from pre-built llvm packages for\n"
 "     \tdebian/ubuntu:\n"
-"     \t\thttp://llvm.org/apt\n\n"
+"     \t\thttps://apt.llvm.org/\n\n"
 "     \tIf you are using old version of clang, change 'clang-bpf-cmd-template'\n"
 "     \toption in [llvm] section of ~/.perfconfig to:\n\n"
 "     \t  \"$CLANG_EXEC $CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS \\\n"
-- 
2.28.0

