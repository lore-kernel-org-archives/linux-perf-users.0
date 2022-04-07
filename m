Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C3C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Apr 2022 23:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiDGXHf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Apr 2022 19:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiDGXH1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Apr 2022 19:07:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C001F47FF
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Apr 2022 16:05:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so5321551ybp.19
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Apr 2022 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BlnS9L2b1HywEaYijfWcFOwOQSJE9EtkTs1ukixmBPw=;
        b=ZoLWREi9IpzQjcNCRfvCg0QXxxgq/g/dr8q8lw6hiFwbYUfHDU1oOZdHzFe2C0x/Wj
         +G6TEXOTNFkXW2gltwODOW5zukJ6c3lNHMPBcvQp5GI18h87PtXgxM98avfGpH8OyZ5u
         nzT1o4ojmpF6V/vD2FRe+PGmy0ImyLDV3ZUqcR6ZYZaSKgCLKh4p5yqqe4XuvwTZxhV1
         wKnssK5d/ODNrMayMxzcqVNtNCahdn67ngyBl7U3zRKpGFBBKd8ViX3vlJtwMuf7SlpI
         f+UB8KrczQtgb/Md34bcUsQs03hgQY4AgrDM31NMENxStRmUWp+7sf0pLroD9Ku6pL1D
         dq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BlnS9L2b1HywEaYijfWcFOwOQSJE9EtkTs1ukixmBPw=;
        b=DhOBYF2Fhqvc1eBIXLROA6U5mESBNSy9gc4QVXcMWRluRdlvZVYZUxnqPy2CFlnu2S
         9CbNg9EJ6lfHRH4maU155Rz5J7jU6+QPFUsfKkkytpuDYUHhs2eqUw6va+ffNP4Orsoy
         /LDcYV3+4GIYsO/AVhuMt0jy8OqaxsadwVVmAPIH2ItuR0JwClpGIuLYm4kRpCFD/hUV
         YJ3c9gpZlTQTpcyoZiKM/MEqBMCK0ut5M+ivbp+OZr0VGrm9S0KihWsZ1vjjW1hqeU/+
         U8acyWjqsR+Trcd5RUc8YCfpTomL3fwScR1u3y8F17on3pxNt5Z2RO5qvvCrGpd6I+py
         xdbA==
X-Gm-Message-State: AOAM531y+kRA9YVLaQywQ+Rfn/W9tFyeSnmzxBn6/gcW5UnVb4RisMt4
        jvrflZ3+K5PqK5YMy0SCVnnwdJJ1V4qU
X-Google-Smtp-Source: ABdhPJwO6aQe2goGLlpoTWwXzoYnXPSLIf1haTI2XYvRcrDVlYdlMfH8R5T02DhVCFDBY/64pzF+0lrd295k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a05:6902:392:b0:633:621f:166f with SMTP id
 f18-20020a056902039200b00633621f166fmr12458396ybs.166.1649372724286; Thu, 07
 Apr 2022 16:05:24 -0700 (PDT)
Date:   Thu,  7 Apr 2022 16:05:03 -0700
In-Reply-To: <20220407230503.1265036-1-irogers@google.com>
Message-Id: <20220407230503.1265036-6-irogers@google.com>
Mime-Version: 1.0
References: <20220407230503.1265036-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 5/5] perf symbols: More specific architecture end fixing
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Make the conditions used for symbol fixup closer to the comments. The
logic aims to combine the current conditions as last modified in:
https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/machine.c   | 19 ++++++++++---------
 tools/perf/arch/powerpc/util/machine.c | 18 +++++++++---------
 tools/perf/arch/s390/util/machine.c    | 17 +++++++++--------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index 54fb41de9931..f258c1ebac03 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -18,16 +18,17 @@
 
 #define SYMBOL_LIMIT (1 << 12) /* 4K */
 
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
-			      bool is_kernel __maybe_unused)
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c, bool is_kernel)
 {
-	if (p->end == p->start || p->end != c->start) {
-		if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
-			(strchr(p->name, '[') == NULL && strchr(c->name, '[')))
-			/* Limit range of last symbol in module and kernel */
-			p->end += SYMBOL_LIMIT;
-		else
-			p->end = c->start;
+	if (is_kernel && (p->end == p->start || p->end != c->start) &&
+	    ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
+	     (strchr(p->name, '[') == NULL && strchr(c->name, '[')))) {
+		/* Limit range of last symbol in module and kernel */
+		p->end += SYMBOL_LIMIT;
+		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	} else if (p->end == p->start) {
+		/* Expand empty symbols. */
+		p->end = c->start;
 		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
 	}
 }
diff --git a/tools/perf/arch/powerpc/util/machine.c b/tools/perf/arch/powerpc/util/machine.c
index a732601f951e..689a48040b64 100644
--- a/tools/perf/arch/powerpc/util/machine.c
+++ b/tools/perf/arch/powerpc/util/machine.c
@@ -14,16 +14,16 @@
  * Therefore do not fill this gap and do not assign it to the kernel dso map.
  */
 
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
-			      bool is_kernel __maybe_unused)
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c, bool is_kernel)
 )
 {
-	if (p->end == p->start || p->end != c->start) {
-		if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
-			/* Limit the range of last kernel symbol */
-			p->end += page_size;
-		else
-			p->end = c->start;
-		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	if (is_kernel && (p->end == p->start || p->end != c->start) &&
+	    strchr(p->name, '[') == NULL && strchr(c->name, '[')) {
+		/* Limit the range of last kernel symbol */
+		p->end += page_size;
+	} else if (p->end == p->start) {
+		/* Expand empty symbols. */
+		p->end = c->start;
 	}
+	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
 }
diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index 8622a1b78748..790d98a39c83 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -42,15 +42,16 @@ int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
  * and beginning of first module's text segment is very big.
  * Therefore do not fill this gap and do not assign it to the kernel dso map.
  */
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
-			      bool is_kernel __maybe_unused)
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c, bool is_kernel)
 {
-	if (p->end == p->start || p->end != c->start) {
-		if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
-			/* Last kernel symbol mapped to end of page */
-			p->end = roundup(p->end, page_size);
-		else
-			p->end = c->start;
+	if (is_kernel && (p->end == p->start || p->end != c->start) &&
+	    strchr(p->name, '[') == NULL && strchr(c->name, '[')) {
+		/* Last kernel symbol mapped to end of page */
+		p->end = roundup(p->end, page_size);
+		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	} else if (p->end == p->start) {
+		/* Expand empty symbols. */
+		p->end = c->start;
 		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
 	}
 }
-- 
2.35.1.1178.g4f1659d476-goog

