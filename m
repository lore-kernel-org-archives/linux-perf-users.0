Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794712D63F8
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610796; cv=none; b=ODxtcpnzIYnbASErr848sKKCBSm8wLacW+XFesFPHjHiT+HxhL/Z3SKogqh+W1JitLvcv2L3fmN5289FunNjg/ZjE1x0ievxyIiRFRNbUnepqqwQ+w86SY2+K9hgMIs3ScT0JEzS8YJPVteysl1kmx/q4OJpRtPYEsNYt0TdC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610796; c=relaxed/simple;
	bh=l/iGF1eiicn0gyOFHtPdUcmiqCfkLzEyUFFsiLKcBJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uu8pTE4FfLRNjsxD1rx6TmgbAGh4Z76c7LJ4Rl143IWcjhjCaF+fjf7utOoXeXd77S7GaQWFkPXWwzQ0EbNzK7cFFudTBD9QqLAT5vhDVVOe5xnWD+YuHFJoNGECLNW+vd6EbMCL3a/39gcXvGfV1nB60VuKLcKADowMQmY4u0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNH7Vw2K; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNH7Vw2K"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137f8f21861so1892626c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 15:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780610792; x=1781215592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwUobqll5CG8S8DaYyJ6P1PbcVuywzyfMBEqRscWVk0=;
        b=BNH7Vw2Kgf+cwS4DTSn5aWItpWBUuEIWEeI15OQw2djg3LkrkWzjmpapU90vVMNzlO
         ShifD/WOU3zMXpgRBP3LXt9rciUbXzweMyf6wJP27ljZZAcTFxjapb9XW4S/OQVtJCi1
         wQcr3CPrMdPPYc3T/5SPxZ/scX+SGISNmZ0AyWzGeGQWgi3EUHm/IKXjhjra5zWeud39
         bGHcEqR5PlEvHQ33YoFd3yI1B3W+RrdEtzEWNRrh+lb23UI6M1bAY5HTq9MWMTP1Wbti
         l498INFnX6d61Ik9w0oyZBulH8mWkEbLCUuv8VyJ089e9ET3/4/Piy4CHHdWJtaXqMoa
         TyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610792; x=1781215592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwUobqll5CG8S8DaYyJ6P1PbcVuywzyfMBEqRscWVk0=;
        b=QDPbsx47DSiCKDv9RrT4jb64/rW1HDGuhN4cUqJLOdtJer+eiuX5P7gTbEt9vbuG+h
         ErBYQOajzezE/byjl3HHH8PiM/c76x0Na8O+mhVJvFwqqGShnbFgfzHbhH0/IbWOFVM8
         0y3cVieMdxy5eRq81VSmsrBZ3E47kwGd9ZwlOOE7y8zpRT+ufWXkedMyd7mzuFONgIAS
         nnCAf6I5bqR9P23/LWFewkR3CnpxAC/G5Kgy6E5Y+vJ+09is0sLt01R+P5EUZF8ybBqd
         43mfiPZgwOto2LXxM03jGSCShwPEPtzTMOL4uuEC8ikSQLkciLzgWhf4Xn/h45XxHFrf
         EG2g==
X-Forwarded-Encrypted: i=1; AFNElJ9QhUpqATsdyM8XM6ASAnkn7aQmvyPnkS8XrvC+uyPGlzQ30SbvBxAsipK4ZhIURMHf0kWn+Wxf8M2Nr3rHN7Nx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3v8uRTVrn0WDzDhBw2UU1MYI9R75mA+C/0x5OesVAqMbNeGb
	uiWIj7Jvzkt5JfCj7Eb9EYHcsYDY1aVcZ53/MKLJkzaikUm8PUbNkFHXMFAJQc2HWTYnhEChUfm
	d6tMUuXjE4A==
X-Received: from dlbqq4.prod.google.com ([2002:a05:7022:ed04:b0:137:fec5:89b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f81:b0:137:4062:4c1b
 with SMTP id a92af1059eb24-138066d1951mr393721c88.11.1780610792212; Thu, 04
 Jun 2026 15:06:32 -0700 (PDT)
Date: Thu,  4 Jun 2026 15:06:27 -0700
In-Reply-To: <CAP-5=fWtK6tGzJaWRz4SZ8_sK=tz39+-5im64Yzt47B0e+X_PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWtK6tGzJaWRz4SZ8_sK=tz39+-5im64Yzt47B0e+X_PA@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604220627.902635-1-irogers@google.com>
Subject: [PATCH v10] perf test: Truncate printed test descriptions dynamically
 to avoid terminal wrapping
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

Also, remove the width padding from the test suite headers which do not
display inline status messages. This prevents their trailing colons from
wrapping onto new lines on standard width terminals.

Finally, avoid GCC 16's -Wformat-truncation warnings by delegating the
description padding to pr_info's %-*s format specifier instead of padding
within a temporary buffer, and clamp the truncation limit to the temporary
buffer's size.

JUnit XML output and the failure summary report still print the full,
untruncated test descriptions.

Assisted-by: Gemini-CLI:Google Gemini 3.1 Pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 66 +++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b64fc2204f22..fd83ca2bda12 100644
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
@@ -404,19 +406,69 @@ static char *xml_escape(const char *str)
 	return res ? res : strdup("");
 }
 
+static const char *format_test_description(const char *desc, int max_desc_width,
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
+	if (len > max_desc_width) {
+		snprintf(buf, buf_sz, "%.*s...", max_desc_width - 3, desc);
+		return buf;
+	}
+	return desc;
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
+		desc = format_test_description(desc, desc_padding, desc_buf, sizeof(desc_buf));
+		pr_info("%s %-*s:", prefix, desc_padding, desc);
+	} else {
+		desc_padding = target_desc_area_width - 5;
+		if (desc_padding < 20)
+			desc_padding = 20;
+
+		desc = format_test_description(desc, desc_padding, desc_buf, sizeof(desc_buf));
+		pr_info("%3d: %-*s:", curr_suite + 1, desc_padding, desc);
+	}
 
 	switch (result) {
 	case TEST_RUNNING:
@@ -700,7 +752,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	 * sub test names.
 	 */
 	if (test_suite__num_test_cases(t) > 1 && curr_test_case == 0)
-		pr_info("%3d: %-*s:\n", curr_suite + 1, width, test_description(t, -1));
+		pr_info("%3d: %s:\n", curr_suite + 1, test_description(t, -1));
 
 	/*
 	 * Busy loop reading from the child's stdout/stderr that are set to be
@@ -976,7 +1028,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			if (next_child) {
 				if (test_suite__num_test_cases(next_child->test) > 1 &&
 				    last_suite_printed != next_child->suite_num) {
-					pr_info("%3d: %-*s:\n", next_child->suite_num + 1, width,
+					pr_info("%3d: %s:\n", next_child->suite_num + 1,
 						test_description(next_child->test, -1));
 					last_suite_printed = next_child->suite_num;
 				}
@@ -1040,7 +1092,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 
 			if (test_suite__num_test_cases(child->test) > 1 &&
 			    last_suite_printed != child->suite_num) {
-				pr_info("%3d: %-*s:\n", child->suite_num + 1, width,
+				pr_info("%3d: %s:\n", child->suite_num + 1,
 					test_description(child->test, -1));
 				last_suite_printed = child->suite_num;
 			}
-- 
2.54.0.1032.g2f8565e1d1-goog

