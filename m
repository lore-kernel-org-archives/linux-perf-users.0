Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83059400DE9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422160; cv=none; b=Poega4rcqsauaUe3VCQ7OpgO5jFHy2/IuDR79QaVV8K9Cg6dKizQzUz46roOoWIe82EoYqI29xUwS1lXcvK6LMJL/aHg9aZLamDQru1NKEEBYqNHfIuIZkpVMc6w8QPAn9D4gd/ywMssN0J+J0sppvMwCVB8yu/czr1644Notd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422160; c=relaxed/simple;
	bh=1He7DS91ONaMRC7Yv1RYg8Ljem3Mgk0ads6jjPvHjPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c6a+ETeC1pBlEarlNdTJ3j39W/QmnyXhYKahGvDZAjhuvjQKJOYDZCqW8Z0y4KXnk9gKzmNUkoKTRJKvBzoE2Ljdg1gT7UqXMzDkKoyAQxHKgjV9yDHYyBK0XLCxUevxoOgSNHnzhP6UljPs/7rBe8BChvrJkflzUXecMJ9NgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hM4hei9v; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM4hei9v"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e4636205so13196175eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422157; x=1781026957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9UJVtMJu7kuLm59PY+ldFUr8Ibis/stoVc4HwoiZPE=;
        b=hM4hei9vEnio4JxSgfG/DrHtLruJ+Ctazlo8kX+gMuQ2VvHL93pm5VYSue/7VqGvKp
         qUwgyWI3P/Tar+qEWMGjM+0S8uoaglukNeGBzatHS8JhWgKOtV7fNRH/OSpbMdrbb2IE
         DI9PvAJHY9azCpueUYLTuBR46OLJIDMCzYKmTQbJs1Owq+J6LAFLL66Nr11KdwKYZhHE
         GaayxMf87Ny0zCxybbBVzWFSU7E62COS9HGeBcO2F+81syMaGhNiJtSxjoJyEGflbK+v
         k1GbG0NnRaM7lrwC7bZ8RnVyurJZHAcmLyvvBGLbmTJQpHLmI/CH4mL68hbxNR5ShkDo
         gS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422157; x=1781026957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9UJVtMJu7kuLm59PY+ldFUr8Ibis/stoVc4HwoiZPE=;
        b=kXAwr7pl07Rn1t3aPUoer4Js9OgU5USmSbYpa1dx5oOio32yBmphGIuNEEPrqMv7M8
         LiOlyqKxybl1tIDCh8djkraIxc3PIPsC6ixp6uZ10Tosfux6AqaB/wgAaYeMPMSbHxlz
         a5HhbKR3DhXhb/yT2K4DSwplZyFsM8XJYOGUZdyPuqbhlYsMrPaLyMoJqDH6mKL9XjnF
         4hPgmE/I2TfMgrKmQ02tfazmzoXtRggft44NTw0krDxWYzarDUncdzBi1o4V3nvi21A8
         7KUXxX09Z8tKAWfqb1C5lk95Zk72231Op44thKwv6eph018CTK49+lg1plIB0TkGPoiJ
         sXqg==
X-Forwarded-Encrypted: i=1; AFNElJ/UqR9/Y0xh5dF9KK5tW4bmGCWh8juGP8R6zwy8nE3rTqSWvp32mJyOGI1+LAzhdiaukY7qLnfKNbIO1YNmcD5e@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIqMBXJeJJLB9Y6yOB1ShOHkTYmKR9ovJxoAuFSNRHtyDTeCw
	StF+ya8EO6LicaXHGbIevOU5TBPEGlrEyZz5dQFbS9kgu/NUx46sSb+mYJZgcQLEfc8EmLMhRTs
	zmnnWgwwCrA==
X-Received: from dycqa11.prod.google.com ([2002:a05:7300:fe4b:b0:304:df46:263a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1698:b0:304:e865:f7d1
 with SMTP id 5a478bee46e88-304fa74349amr8251927eec.25.1780422156509; Tue, 02
 Jun 2026 10:42:36 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:29 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-19-irogers@google.com>
Subject: [PATCH v8 18/18] perf test: Truncate printed test descriptions
 dynamically to avoid terminal wrapping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When test descriptions are extremely long (e.g., the truncated perf.data
graceful handling test is 103 characters long), they wrap across terminal
boundaries.

Because the ANSI escape code to delete the line (PERF_COLOR_DELETE_LINE)
only clears a single terminal line, visual wrapping leaves orphan
wrapped lines on the screen, which results in the test description being
printed multiple times.

Resolve this by checking the terminal width (get_term_dimensions) and
dynamically truncating the printed test description to fit within the
available columns, leaving safety space for the prefix index and status
suffix.

JUnit XML output and the failure summary report still print the full,
untruncated test descriptions.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 63 +++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b64fc2204f22..edb4eaa695f1 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -20,6 +20,8 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <sys/time.h>
+#include <sys/ioctl.h>
+#include "util/term.h"
 #include "builtin.h"
 #include "config.h"
 #include "hist.h"
@@ -404,19 +406,66 @@ static char *xml_escape(const char *str)
 	return res ? res : strdup("");
 }
 
+static const char *format_test_description(const char *desc, int width, int max_desc_width,
+					  char *buf, size_t buf_sz)
+{
+	int len = strlen(desc);
+
+	if (width > max_desc_width)
+		width = max_desc_width;
+
+	if (len > max_desc_width) {
+		snprintf(buf, buf_sz, "%.*s...", max_desc_width - 3, desc);
+	} else {
+		snprintf(buf, buf_sz, "%-*s", width, desc);
+	}
+	return buf;
+}
+
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running,
 			     const char *err_output, double elapsed)
 {
+	char desc_buf[256];
+	const char *desc = test_description(t, curr_test_case);
+	struct winsize ws;
+	int max_desc_area_width;
+	int target_desc_area_width;
+	int desc_padding;
+
+	get_term_dimensions(&ws);
+	/*
+	 * Total terminal columns minus space for status e.g. " Running (12 active)"
+	 * which is 20 chars, plus a margin of 3 chars = 23 chars.
+	 */
+	max_desc_area_width = ws.ws_col - 23;
+	if (max_desc_area_width < 40)
+		max_desc_area_width = 40;
+
+	/* Standard test has prefix "%3d: " which is 5 chars */
+	target_desc_area_width = width + 5;
+	if (target_desc_area_width > max_desc_area_width)
+		target_desc_area_width = max_desc_area_width;
+
 	if (test_suite__num_test_cases(t) > 1) {
 		char prefix[32];
 		int len = snprintf(prefix, sizeof(prefix), "%3d.%1d:",
 				   curr_suite + 1, curr_test_case + 1);
-		int subw = len >= 4 ? width + 4 - len : width;
 
-		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
-	} else
-		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_test_case));
+		desc_padding = target_desc_area_width - (len + 1);
+		if (desc_padding < 20)
+			desc_padding = 20;
+
+		format_test_description(desc, desc_padding, desc_padding, desc_buf, sizeof(desc_buf));
+		pr_info("%s %s:", prefix, desc_buf);
+	} else {
+		desc_padding = target_desc_area_width - 5;
+		if (desc_padding < 20)
+			desc_padding = 20;
+
+		format_test_description(desc, desc_padding, desc_padding, desc_buf, sizeof(desc_buf));
+		pr_info("%3d: %s:", curr_suite + 1, desc_buf);
+	}
 
 	switch (result) {
 	case TEST_RUNNING:
@@ -700,7 +749,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	 * sub test names.
 	 */
 	if (test_suite__num_test_cases(t) > 1 && curr_test_case == 0)
-		pr_info("%3d: %-*s:\n", curr_suite + 1, width, test_description(t, -1));
+		pr_info("%3d: %s:\n", curr_suite + 1, test_description(t, -1));
 
 	/*
 	 * Busy loop reading from the child's stdout/stderr that are set to be
@@ -976,7 +1025,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			if (next_child) {
 				if (test_suite__num_test_cases(next_child->test) > 1 &&
 				    last_suite_printed != next_child->suite_num) {
-					pr_info("%3d: %-*s:\n", next_child->suite_num + 1, width,
+					pr_info("%3d: %s:\n", next_child->suite_num + 1,
 						test_description(next_child->test, -1));
 					last_suite_printed = next_child->suite_num;
 				}
@@ -1040,7 +1089,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 
 			if (test_suite__num_test_cases(child->test) > 1 &&
 			    last_suite_printed != child->suite_num) {
-				pr_info("%3d: %-*s:\n", child->suite_num + 1, width,
+				pr_info("%3d: %s:\n", child->suite_num + 1,
 					test_description(child->test, -1));
 				last_suite_printed = child->suite_num;
 			}
-- 
2.54.0.1013.g208068f2d8-goog

