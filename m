Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE09C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 04:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376940AbiEMEFe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 00:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376932AbiEMEFc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 00:05:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EADA29B029
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 21:05:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f825f8c944so62315927b3.15
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 21:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=20i4c1kc+enHNe40Ax5Yg1Hwx6kxN38xUQQ6orKgm5M=;
        b=QpsfvaFVhUgzwxz9VTeCun1CQpi20aeZleVBr7p+5qnaq/zf0ooX26/68S/OwE8Cn/
         mI/kdQQAHxlMKD7IZhg5dFosbsXW24XDN60pyUkgxMBMPPikOvyg3T1JpMv2NG9+es61
         Il0duHkhcZeKyHO2nkr/ahOkjkynFMrnCtdzMnhZI5ogSepB6WVAvIyzoZFezhPTv1um
         MzvWxcViOPPWXZlZe2Runzadv/0iOnvUUJF/VO0Ch2FPWxAMEAlCHQ3Tj4qEGa0gCtYY
         jfga3HRFjDuYxPurA7RE2bu3Xd/JdHs3W/em/dT8ttKhNg6VXBaWK0/iISVqpPoNraNw
         YrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=20i4c1kc+enHNe40Ax5Yg1Hwx6kxN38xUQQ6orKgm5M=;
        b=y48TPtRaETnS7glAuOz8puiL+EgR64amYJ11EzkXqQ5xSTCTRRcb357U7DGUDE64gN
         sDTpsND9WX+IW+7Z0nXpWjIzuvr1kGIf7sRVntODvtA66hnuTc9H0plyTkpKVja3YHeG
         Tk0g5vrH/Dc01PsewXP8RmtQSkRDy15yc3QF5DjQeUryzp+HlUpLnUoMHJO9gVuVTvc3
         Pn3co8rTf25wyDHI3e3u/NCAHTUOzTe8nFWLiyaUqf3Ff8xJZmUFZoljgpKkq/LhqCEH
         7r1iC+pJ2RE7bMq8Ysg2XhFVw3yYmFo1qICRyjXSS0yGty1PX14UQ3dwvYDqH8FAqNfM
         rYUA==
X-Gm-Message-State: AOAM531CpNuk2tSbQVQIczcbJHHVGH8yMh+kV9hxwLjMoJDq+T23wmVH
        xCoh9UhJzqYIyjfm5QMrLdWcBXsoM0AQ
X-Google-Smtp-Source: ABdhPJwaZZfSOmopDsuZd6+bJPH9rtKQAR3lvKZfNgkt+4z4fWX387Ba3M8Eb6MMf0/bEJH5wKU7LPpfgxhY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a81:24d2:0:b0:2f7:b684:de49 with SMTP id
 k201-20020a8124d2000000b002f7b684de49mr3552435ywk.310.1652414729894; Thu, 12
 May 2022 21:05:29 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:14 -0700
In-Reply-To: <20220513040519.1499333-1-irogers@google.com>
Message-Id: <20220513040519.1499333-3-irogers@google.com>
Mime-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 2/7] perf test: Use skip in vmlinux kallsyms
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently failures in reading vmlinux or kallsyms result in a test
failure. However, the failure is typically permission related. Prefer to
flag these failures as skip.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 93dee542a177..983f32964749 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -114,7 +114,7 @@ static bool is_ignored_symbol(const char *name, char type)
 static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused,
 					int subtest __maybe_unused)
 {
-	int err = -1;
+	int err = TEST_FAIL;
 	struct rb_node *nd;
 	struct symbol *sym;
 	struct map *kallsyms_map, *vmlinux_map, *map;
@@ -142,7 +142,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * and find the .ko files that match them in /lib/modules/`uname -r`/.
 	 */
 	if (machine__create_kernel_maps(&kallsyms) < 0) {
-		pr_debug("machine__create_kernel_maps ");
+		pr_info("machine__create_kernel_maps failed");
+		err = TEST_SKIP;
 		goto out;
 	}
 
@@ -158,7 +159,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * code and with the one got from /proc/modules from the "kallsyms" code.
 	 */
 	if (machine__load_kallsyms(&kallsyms, "/proc/kallsyms") <= 0) {
-		pr_debug("dso__load_kallsyms ");
+		pr_debug("machine__load_kallsyms failed");
+		err = TEST_SKIP;
 		goto out;
 	}
 
@@ -178,7 +180,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * Now repeat step 2, this time for the vmlinux file we'll auto-locate.
 	 */
 	if (machine__create_kernel_maps(&vmlinux) < 0) {
-		pr_debug("machine__create_kernel_maps ");
+		pr_info("machine__create_kernel_maps failed");
 		goto out;
 	}
 
@@ -196,7 +198,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * to fixup the symbols.
 	 */
 	if (machine__load_vmlinux_path(&vmlinux) <= 0) {
-		pr_debug("Couldn't find a vmlinux that matches the kernel running on this machine, skipping test\n");
+		pr_info("Couldn't find a vmlinux that matches the kernel running on this machine, skipping test\n");
 		err = TEST_SKIP;
 		goto out;
 	}
-- 
2.36.0.550.gb090851708-goog

