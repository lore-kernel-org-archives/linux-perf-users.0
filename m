Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EB48B37B
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590998; cv=none; b=pxqzX67GJv4OEaE9BJAkbzb4UlAyITKyee77wH1lqO9cVqMipUy4GseVIxS6KYVYevVc/WBBmgl6HtOd5+M4eRvX+rgd16nq47DmJYto+gerLOIFFdK21keerrCpcDiM59d7eFUk7zmID7WmSYf7oDVjdBulQyLbg8CKTlM46Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590998; c=relaxed/simple;
	bh=KAYhkahAb+18m5LFcYwamkdiSsZ3QqvHTYW8D7Ouw/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCQlYAVQDcTgwbJHRe0Q40r9WEASlHjIiBZh9clb+5IWK30RbG6mH4lJaDJ4RZf8SwxEAV8qpLmPanQhuqFGeZI754PZI/fXLfygzWpMAhv7LvJ6IxQ1fmfOsojOTW7UchoCNdIr/1VPvNvtB1TnwKQvHTa6BnkzQpKJjH1VvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8RW8hDO; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8RW8hDO"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f23c55b2so759922eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780590996; x=1781195796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJQYLG1uMFrbb0Ahpo+z3gzkQ0y5w5F6/NRuMiORe/g=;
        b=l8RW8hDOaZaYXLLhds7fwhU8IzxZtFZPIXlkZpscgSLzuyehh5XAVHU1HMnl8JzAnC
         eoPJwPWiZdidWsu3tLMGfK18qCL0q+K4cYA0jKBuxqCiMKOoq4pAmofNMK+vJk09mcHe
         g5lDn98ynu+0AePB+JcXCKgVAWt4cfzaHWXRJ85AJTS1uaVUmIxOSXJgskO6X9kOlaLc
         8ouApP7xkvgioIDHLc8trX72MxJINvyPaWyLCFwPWSD1QYdJNR4EUq66BdNwukAqolSK
         2MixUdg5i6PeSOhyZC4H6eoKNo7i9GeL/yvyc0gDfUzBdhQ3Xb9bcvP87B4tK0jJnU4V
         OhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590996; x=1781195796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJQYLG1uMFrbb0Ahpo+z3gzkQ0y5w5F6/NRuMiORe/g=;
        b=r8vI068Zeqk39HhMGxBrT2AaaOzM1zr13hWrBpJ2+TFbASlXh6LkTKiR9AQwZjF7rr
         CPI8EgvPg0Ou4OoURtZ5ym8O10uB/SqM8PHKjON2PYh6oPWWopY5MYXZiUfDuh1mwAvA
         Fwff9Xy+RBHEgEWMrxKQcZ22fnSYyEsBWLhtFkKmbkwcOsby7FVHpAQtdS5zCYaIsk6G
         NnlckZRDNu3GVCiynuR7h9j2I/DzsmwAOCeSgCMsWNZYw9rTTjAGLRkc0uSvdFICunUV
         1ZsOhbwWyhhsQLWgkzCm3ezXEq2Lp/hS9X84GDddyNCFC/8QAWzzxLmafhk9NkvYBcJ8
         jaAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mqR3FRoJ/GYAy3ta6HiFut0rSD9iEQAiYPimcHFFB+ZE/0Nf0jko6wNyJeuSca+CcS+0PZhD4ErXDFpRyUsQ0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2df1vXlJtPpXwQJuA0SvUn0+FTuuRU27LQPHLZ2a1kT/yhFJ
	AQTMDesXsW5mog1mcjuLXi7gMmQjmj8SgHBOqQVT5uNEM7gtGv1LeqPJmM9M0iOklJd0KW25XAD
	L3bIaI3wkPg==
X-Received: from dyblz38.prod.google.com ([2002:a05:7301:1626:b0:304:1e27:a62f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2284:b0:2e1:e3e6:2909
 with SMTP id 5a478bee46e88-3074fa64a4bmr3849860eec.9.1780590995818; Thu, 04
 Jun 2026 09:36:35 -0700 (PDT)
Date: Thu,  4 Jun 2026 09:36:27 -0700
In-Reply-To: <20260604163627.501078-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602174129.3192312-1-irogers@google.com> <20260604163627.501078-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604163627.501078-3-irogers@google.com>
Subject: [PATCH v9 2/2] perf test: Truncate printed test descriptions
 dynamically to avoid terminal wrapping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
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

Also, remove the width padding from the test suite headers which do not
display inline status messages. This prevents their trailing colons from
wrapping onto new lines on standard width terminals.

Finally, explicitly clamp the dynamically calculated description width to
the formatting buffer's size to satisfy GCC 16's bounds checking and
prevent a -Wformat-truncation warning during compilation.

JUnit XML output and the failure summary report still print the full,
untruncated test descriptions.

Assisted-by: Gemini-CLI:Google Gemini 3.1 Pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 70 +++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b64fc2204f22..b7eebfcf7700 100644
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
@@ -404,19 +406,73 @@ static char *xml_escape(const char *str)
 	return res ? res : strdup("");
 }
 
+static const char *format_test_description(const char *desc, int width, int max_desc_width,
+					  char *buf, size_t buf_sz)
+{
+	int len = strlen(desc);
+
+	/*
+	 * Clamp to buf_sz to prevent GCC format-truncation warnings
+	 * when terminal width is very large.
+	 */
+	if (max_desc_width >= (int)buf_sz)
+		max_desc_width = buf_sz - 1;
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
@@ -700,7 +756,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	 * sub test names.
 	 */
 	if (test_suite__num_test_cases(t) > 1 && curr_test_case == 0)
-		pr_info("%3d: %-*s:\n", curr_suite + 1, width, test_description(t, -1));
+		pr_info("%3d: %s:\n", curr_suite + 1, test_description(t, -1));
 
 	/*
 	 * Busy loop reading from the child's stdout/stderr that are set to be
@@ -976,7 +1032,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			if (next_child) {
 				if (test_suite__num_test_cases(next_child->test) > 1 &&
 				    last_suite_printed != next_child->suite_num) {
-					pr_info("%3d: %-*s:\n", next_child->suite_num + 1, width,
+					pr_info("%3d: %s:\n", next_child->suite_num + 1,
 						test_description(next_child->test, -1));
 					last_suite_printed = next_child->suite_num;
 				}
@@ -1040,7 +1096,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 
 			if (test_suite__num_test_cases(child->test) > 1 &&
 			    last_suite_printed != child->suite_num) {
-				pr_info("%3d: %-*s:\n", child->suite_num + 1, width,
+				pr_info("%3d: %s:\n", child->suite_num + 1,
 					test_description(child->test, -1));
 				last_suite_printed = child->suite_num;
 			}
-- 
2.54.0.1032.g2f8565e1d1-goog

