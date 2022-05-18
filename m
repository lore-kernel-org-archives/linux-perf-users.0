Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D51BC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 04:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiEREUl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 00:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiEREUk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 00:20:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB4921256
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r206-20020a2576d7000000b0064d82e5b692so890095ybc.11
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/et+mNXky9AxgqPAZ+01K1qLv9QXAe8M1JaYskOrLf4=;
        b=aYImPI0UwHk+52e5no/ILuPrJfO3c3hinpptzjjpVQXzYxqXKctJPuu6vh7PjAQwGh
         5YxQ59UjalDv7cVWGPtIZUuQ67qUayzv7cX/6ZWbi4VtWGZIntGJOb3oWax4NCunNetS
         L8ZekdeFUTPnlfnT/r6EWJQwP8FzXZBbrsR983XBL6YbqumBcv1Ae5jjGClfiVfGCvrI
         rGqtJgbI8D9AZQTHjd1+TSZZIKCzzisFzHV1NI+98fTGdpbqwa/yxR7MQvL0NUpNoiwx
         ++/W35XpKsPWGA7XCcN5TISjB1/eLUlL3VFNK11UkwGm/Fx1+DDzUKq1Z0GaLwmGepRA
         Oo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/et+mNXky9AxgqPAZ+01K1qLv9QXAe8M1JaYskOrLf4=;
        b=oN97yr9oEqioxQXda5QsHH6pUigb+VYnydNX+AjvFlGwiHeGDLWU3TDvRoeMX/1UUZ
         nD7tF+GsoF00wNJHQ9qYey2cUeLL4xllyHTz+5hayWDltgEt2izKdTMLMDtkv1I7Fh8d
         W3/A8u2rZRgSnwBT2BnJOH5IgAB2+dyOwX3s7bAdAQZVQ0g57SV6ullR1QVNqgOCF8hS
         4/yZDbw1dcrQW+p+HLgxbHfpmCfEKGPflzB+fMLwf8U553mB792EZnEWlqrKNgCX/Rbr
         wXHnWMhgnTC5mld8JvHxiEb95JSkPpXw4oE7bxKwLnhwEKIdST4cZaKukMTgJjt2G1rR
         NrIQ==
X-Gm-Message-State: AOAM532WukgU3Uis7HVhzKGyOWi6XaIggUFaiiF+IQMLT7KjbXa73dfQ
        SUBkmyILVCZENoCWyv8cli+ZJBmj2Yaw
X-Google-Smtp-Source: ABdhPJzA31F5Eh2pcBc3NkRDp7vhQd5a9Npu6LdorVkBhQJSHBs+FimXYU6pTuBJ4J9+7Ei5NKS7HwZYyWmk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:7008:0:b0:648:6d04:f4ab with SMTP id
 l8-20020a257008000000b006486d04f4abmr26390471ybc.127.1652847637939; Tue, 17
 May 2022 21:20:37 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:21 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-3-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 2/8] perf test: Use skip in vmlinux kallsyms
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
index 93dee542a177..4fd8d703ff19 100644
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
+		pr_debug("machine__create_kernel_maps failed");
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

