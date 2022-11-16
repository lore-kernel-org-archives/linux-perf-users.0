Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE7C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 07:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiKPHNZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 02:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiKPHNO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 02:13:14 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A68205D9
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:11 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368e6c449f2so155022547b3.5
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BtTjoVTgJBCnMEOfrF9LMVewuWD63PoncZuyhv6/RQ=;
        b=qMXfYRpM94F/ZAAUpeaVfNAUPzTX87g3JG1eVb+B3lSzOCPQq7ftZwYck58S/u3iMU
         N2UzvX6bAF+hHMbXbBxhrBndXHpJShGWWP9xcKFOMp3lnoVeMOCHV/Si6N8Esvh7Amts
         GB59QsaFyxFp7MM8q36anQQ2jfAgXgoRtXXW946thbBbrWwp42qMWn/Jv4SJbIChlhUO
         81F9YNt55oSCcBQwok9R4x3FufoGxjqEm8yyyhynYkVWfQrgV6MDiXsLcUb/LzDuGgmG
         WfBQj6IjYw+L8HIEpm+VbyFHdKdl1fjhWhJtU/hoOAbvc0/jY6DnaVkkeeVVfVczuPz0
         BOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BtTjoVTgJBCnMEOfrF9LMVewuWD63PoncZuyhv6/RQ=;
        b=uKx6qe+GT7yoN7GtjIJ9oIZxP2771Wy9+mWqEAB0UdW2e5lIeJk5QzajWTol5pm9r9
         7PejlIyttfj/57iDUVcMZZB2lPKtVaqY7NTS0zfNdKT/0TSaQJdodRn9Adw+xAnmrpcL
         G8ylfiZiWUL6OH1e3H68gSygujNseN3E6EciYy5uTAUuDRG1Fp7i0wj+ZGEhD4Dwxwgx
         o9UePpSodv9o/nbZ6tZfvPixsjM8ZiYSVY4Vj9DSrxZdhpG3eRRchSVCGV2lqSIHYQKx
         hOWiYyjP86PNGHEWio0zRqVkrCQeVT175TafI/eSz3gzE+QkmF6bE+WIVb91nHOd3DJi
         rmEQ==
X-Gm-Message-State: ANoB5plvah3BxII99vvyYbjuT0c2cudlGHYx9V99Brk7+TtcdwhUZkbe
        13XH90eVccIIyTxZGGm0rcCOnxMDmzYw
X-Google-Smtp-Source: AA0mqf5AqRay4kWJpBlr8wcHh3MyyR/e1oEbI/Gc/G3dmbepVgwzY3QgfAuQrNKkSosSEqB1wtALddShzsts
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:a25:aaeb:0:b0:6dd:89ad:6c33 with SMTP id
 t98-20020a25aaeb000000b006dd89ad6c33mr20698230ybi.188.1668582790604; Tue, 15
 Nov 2022 23:13:10 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:12:58 -0800
In-Reply-To: <20221116071259.2832681-1-irogers@google.com>
Message-Id: <20221116071259.2832681-4-irogers@google.com>
Mime-Version: 1.0
References: <20221116071259.2832681-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 3/4] perf list: Json escape encoding improvements
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use strbuf to make the string under construction's length
unlimited. Use the format %s to mean a literal string copy and %S to
signify a need to escape the string. Add supported for escaping a
newline character.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 109 +++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 43c635d58627..30937e1dd82c 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -17,6 +17,7 @@
 #include "util/metricgroup.h"
 #include "util/string2.h"
 #include "util/strlist.h"
+#include "util/strbuf.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <stdarg.h>
@@ -249,45 +250,56 @@ static void json_print_end(void *ps)
 	printf("%s]\n", print_state->need_sep ? "\n" : "");
 }
 
-static void fix_escape_printf(const char *fmt, ...)
+static void fix_escape_printf(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
-	char buf[2048];
-	size_t buf_pos = 0;
 
 	va_start(args, fmt);
+	strbuf_setlen(buf, 0);
 	for (size_t fmt_pos = 0; fmt_pos < strlen(fmt); fmt_pos++) {
 		switch (fmt[fmt_pos]) {
-		case '%': {
-			const char *s = va_arg(args, const char*);
-
+		case '%':
 			fmt_pos++;
-			assert(fmt[fmt_pos] == 's');
-			for (size_t s_pos = 0; s_pos < strlen(s); s_pos++) {
-				switch (s[s_pos]) {
-				case '\\':
-					__fallthrough;
-				case '\"':
-					buf[buf_pos++] = '\\';
-					assert(buf_pos < sizeof(buf));
-					__fallthrough;
-				default:
-					buf[buf_pos++] = s[s_pos];
-					assert(buf_pos < sizeof(buf));
-					break;
+			switch (fmt[fmt_pos]) {
+			case 's': {
+				const char *s = va_arg(args, const char*);
+
+				strbuf_addstr(buf, s);
+				break;
+			}
+			case 'S': {
+				const char *s = va_arg(args, const char*);
+
+				for (size_t s_pos = 0; s_pos < strlen(s); s_pos++) {
+					switch (s[s_pos]) {
+					case '\n':
+						strbuf_addstr(buf, "\\n");
+						break;
+					case '\\':
+						__fallthrough;
+					case '\"':
+						strbuf_addch(buf, '\\');
+						__fallthrough;
+					default:
+						strbuf_addch(buf, s[s_pos]);
+						break;
+					}
 				}
+				break;
+			}
+			default:
+				pr_err("Unexpected format character '%c'\n", fmt[fmt_pos]);
+				strbuf_addch(buf, '%');
+				strbuf_addch(buf, fmt[fmt_pos]);
 			}
 			break;
-		}
 		default:
-			buf[buf_pos++] = fmt[fmt_pos];
-			assert(buf_pos < sizeof(buf));
+			strbuf_addch(buf, fmt[fmt_pos]);
 			break;
 		}
 	}
 	va_end(args);
-	buf[buf_pos] = '\0';
-	fputs(buf, stdout);
+	fputs(buf->buf, stdout);
 }
 
 static void json_print_event(void *ps, const char *pmu_name, const char *topic,
@@ -300,62 +312,71 @@ static void json_print_event(void *ps, const char *pmu_name, const char *topic,
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
+	struct strbuf buf;
 
+	strbuf_init(&buf, 0);
 	printf("%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
 	if (pmu_name) {
-		fix_escape_printf("\t\"Unit\": \"%s\"", pmu_name);
+		fix_escape_printf(&buf, "\t\"Unit\": \"%S\"", pmu_name);
 		need_sep = true;
 	}
 	if (topic) {
-		fix_escape_printf("%s\t\"Topic\": \"%s\"", need_sep ? ",\n" : "", topic);
+		fix_escape_printf(&buf, "%s\t\"Topic\": \"%S\"", need_sep ? ",\n" : "", topic);
 		need_sep = true;
 	}
 	if (event_name) {
-		fix_escape_printf("%s\t\"EventName\": \"%s\"", need_sep ? ",\n" : "", event_name);
+		fix_escape_printf(&buf, "%s\t\"EventName\": \"%S\"", need_sep ? ",\n" : "",
+				  event_name);
 		need_sep = true;
 	}
 	if (event_alias && strlen(event_alias)) {
-		fix_escape_printf("%s\t\"EventAlias\": \"%s\"", need_sep ? ",\n" : "", event_alias);
+		fix_escape_printf(&buf, "%s\t\"EventAlias\": \"%S\"", need_sep ? ",\n" : "",
+				  event_alias);
 		need_sep = true;
 	}
 	if (scale_unit && strlen(scale_unit)) {
-		fix_escape_printf("%s\t\"ScaleUnit\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"ScaleUnit\": \"%S\"", need_sep ? ",\n" : "",
 				  scale_unit);
 		need_sep = true;
 	}
 	if (event_type_desc) {
-		fix_escape_printf("%s\t\"EventType\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"EventType\": \"%S\"", need_sep ? ",\n" : "",
 				  event_type_desc);
 		need_sep = true;
 	}
 	if (deprecated) {
-		fix_escape_printf("%s\t\"Deprecated\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"Deprecated\": \"%S\"", need_sep ? ",\n" : "",
 				  deprecated ? "1" : "0");
 		need_sep = true;
 	}
 	if (desc) {
-		fix_escape_printf("%s\t\"BriefDescription\": \"%s\"", need_sep ? ",\n" : "", desc);
+		fix_escape_printf(&buf, "%s\t\"BriefDescription\": \"%S\"", need_sep ? ",\n" : "",
+				  desc);
 		need_sep = true;
 	}
 	if (long_desc) {
-		fix_escape_printf("%s\t\"PublicDescription\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"PublicDescription\": \"%S\"", need_sep ? ",\n" : "",
 				  long_desc);
 		need_sep = true;
 	}
 	if (encoding_desc) {
-		fix_escape_printf("%s\t\"Encoding\": \"%s\"", need_sep ? ",\n" : "", encoding_desc);
+		fix_escape_printf(&buf, "%s\t\"Encoding\": \"%S\"", need_sep ? ",\n" : "",
+				  encoding_desc);
 		need_sep = true;
 	}
 	if (metric_name) {
-		fix_escape_printf("%s\t\"MetricName\": \"%s\"", need_sep ? ",\n" : "", metric_name);
+		fix_escape_printf(&buf, "%s\t\"MetricName\": \"%S\"", need_sep ? ",\n" : "",
+				  metric_name);
 		need_sep = true;
 	}
 	if (metric_expr) {
-		fix_escape_printf("%s\t\"MetricExpr\": \"%s\"", need_sep ? ",\n" : "", metric_expr);
+		fix_escape_printf(&buf, "%s\t\"MetricExpr\": \"%S\"", need_sep ? ",\n" : "",
+				  metric_expr);
 		need_sep = true;
 	}
 	printf("%s}", need_sep ? "\n" : "");
+	strbuf_release(&buf);
 }
 
 static void json_print_metric(void *ps __maybe_unused, const char *group,
@@ -365,35 +386,39 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
+	struct strbuf buf;
 
+	strbuf_init(&buf, 0);
 	printf("%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
 	if (group) {
-		fix_escape_printf("\t\"MetricGroup\": \"%s\"", group);
+		fix_escape_printf(&buf, "\t\"MetricGroup\": \"%S\"", group);
 		need_sep = true;
 	}
 	if (name) {
-		fix_escape_printf("%s\t\"MetricName\": \"%s\"", need_sep ? ",\n" : "", name);
+		fix_escape_printf(&buf, "%s\t\"MetricName\": \"%S\"", need_sep ? ",\n" : "", name);
 		need_sep = true;
 	}
 	if (expr) {
-		fix_escape_printf("%s\t\"MetricExpr\": \"%s\"", need_sep ? ",\n" : "", expr);
+		fix_escape_printf(&buf, "%s\t\"MetricExpr\": \"%S\"", need_sep ? ",\n" : "", expr);
 		need_sep = true;
 	}
 	if (unit) {
-		fix_escape_printf("%s\t\"ScaleUnit\": \"%s\"", need_sep ? ",\n" : "", unit);
+		fix_escape_printf(&buf, "%s\t\"ScaleUnit\": \"%S\"", need_sep ? ",\n" : "", unit);
 		need_sep = true;
 	}
 	if (desc) {
-		fix_escape_printf("%s\t\"BriefDescription\": \"%s\"", need_sep ? ",\n" : "", desc);
+		fix_escape_printf(&buf, "%s\t\"BriefDescription\": \"%S\"", need_sep ? ",\n" : "",
+				  desc);
 		need_sep = true;
 	}
 	if (long_desc) {
-		fix_escape_printf("%s\t\"PublicDescription\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"PublicDescription\": \"%S\"", need_sep ? ",\n" : "",
 				  long_desc);
 		need_sep = true;
 	}
 	printf("%s}", need_sep ? "\n" : "");
+	strbuf_release(&buf);
 }
 
 int cmd_list(int argc, const char **argv)
-- 
2.38.1.431.g37b22c650d-goog

