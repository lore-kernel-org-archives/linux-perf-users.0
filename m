Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD2C433ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 06:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B276061432
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 06:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhEMGGA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 May 2021 02:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhEMGF5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 May 2021 02:05:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F6FC061574
        for <linux-perf-users@vger.kernel.org>; Wed, 12 May 2021 23:04:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l9-20020a5b0b890000b02904f7fb53ca12so31148043ybq.15
        for <linux-perf-users@vger.kernel.org>; Wed, 12 May 2021 23:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BKWt80lRxmYSViKcJANT1cCUs7XXzGAp8/6du3DmL1c=;
        b=pcJXCMW5PN0PYXnKZYY9Bun0flTcmM++Nco06USNrP3Sj7KLWoiS5GqkyrwhhyAyeF
         04pGnqrTgymZkVkkvWk/GMP7NCMdZS5vVDksmyV220nPMiSVYKgp6k7yA/7SYyDc3441
         eNYeCO5LEXPRpf2sGTJcmNDZhymSlSdPu5mmRTq/Ka+8JzyjWTBiol9Kt4JiMdPt3+iO
         PJxYewYY2c0/Cr2/yuzKyB+MZjtzfUcg06hl1kgl5PCdgUSrC3zbsILnxeZsbW9bsDRa
         imr8A7k8wepd5Lrz0qpKA3rsNSh4UAEZXl+lwhQEGT7mZrN2Ez9oa1FcZssqs3QyMBUt
         CZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BKWt80lRxmYSViKcJANT1cCUs7XXzGAp8/6du3DmL1c=;
        b=h8Nw036bYdFgslcV8YWT+tO+X552zLjXoi3kYBYJQqtO+QWXyj45/NinpTpI3TKJsb
         dywh6P1J06UxDvLJT+qRjP2dJ+Dm9jw9KFYy0JpMWNiInsVskUBNARgBwpAWcYBr6EVg
         bIKCfcI76+g7o/E+ZuNesCJxzAJ3ffbWvEBXDKjZkUB/aRkTOdOtQQBhIgG4VqFe8P/T
         qGJOkTXnAtAtCh/UZJkTWelMMebVAxONa/+NVHrGpOsMBCUOQfTu3gX6X3BRxWUIcFCz
         rJKUIKYR6KOIHKRvSav6mLqHaZAMdLBuf1aAKy7RKsXiXrIO0RDHtpE3O2EGajZ/vPGF
         Beow==
X-Gm-Message-State: AOAM531pVsN1MGk8LjUvySxyitnTqKLroLS8hWVgWH5nGwS7upccSCSo
        XCmpeNJmKEW0k8SrR3WKD9Wq64QMHreM
X-Google-Smtp-Source: ABdhPJzMsrwEsgjOgSX1IoBA0CHbRxHtzIBBIAgeq8zxxo8QFolQAIdIgpl1rWCiVK3Fth1ZcKOexo1FGeT5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:e4e5:7eca:a5a8:f77c])
 (user=irogers job=sendgmr) by 2002:a25:1009:: with SMTP id
 9mr26792934ybq.386.1620885886115; Wed, 12 May 2021 23:04:46 -0700 (PDT)
Date:   Wed, 12 May 2021 23:04:41 -0700
Message-Id: <20210513060441.408507-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] perf beauty: Reuse the generic switch.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Previously the code would see if, for example,
tools/perf/arch/arm/include/uapi/asm/errno.h exists and if not generate
a "generic" switch statement using the asm-generic/errno.h. This creates
multiple identical "generic" switch statements before the default
generic switch statement for an unknown architecture. By simplifying the
archlist to be only for architectures that are not "generic" the amount
of generated code can be reduced from 14 down to 6 functions.

Remove the special case of x86, instead reverse the architecture names
so that it comes first.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/trace/beauty/arch_errno_names.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 9f9ea45cddc4..2c5f72fa8108 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -87,14 +87,13 @@ cat <<EoHEADER
 
 EoHEADER
 
-# Create list of architectures and ignore those that do not appear
-# in tools/perf/arch
+# Create list of architectures that have a specific errno.h.
 archlist=""
-for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
-	test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
+for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort -r); do
+	test -f $toolsdir/arch/$arch/include/uapi/asm/errno.h && archlist="$archlist $arch"
 done
 
-for arch in x86 $archlist generic; do
+for arch in generic $archlist; do
 	process_arch "$arch"
 done
-create_arch_errno_table_func "x86 $archlist" "generic"
+create_arch_errno_table_func "$archlist" "generic"
-- 
2.31.1.751.gd2f1c929bd-goog

