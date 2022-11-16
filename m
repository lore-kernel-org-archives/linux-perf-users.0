Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4C9C43217
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 07:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiKPHN0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 02:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiKPHNT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 02:13:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3583B2124B
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:13 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349423f04dbso156689017b3.13
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wK54JSKXe0LqXOZ3d575hQDmq52LEert5D/pS8cJUkE=;
        b=U1d7MimG9gAoAlzFe+38ukpZbqtI6+WSbYJnASee2xaNcWt9opU7e/VTdFaLjmpQZ2
         X6zxHepXPQVF/knczaV0Pk8JFjDlEBpBHbz22Y4XJdOcTCUABE2+IndsM8s4fHNawIC9
         MD1gxzR8AmL78bWa8wfA+IVoUCxS5DHItTEtHlR2nrlphjwbkXfl+hxyZdBarRoMrzr3
         NLndOR5LqnrWjzZmVrvhyHo143J9+5KkXgPEmb1ylBLCZkMwVDWkTAftNfK6J3O5TMag
         GaUcHNH+DaKajLT22/xCtcYz0jKRXgawxf9IPirCd6aZfH/lds7D6x85YrlWF35ZX96L
         V0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wK54JSKXe0LqXOZ3d575hQDmq52LEert5D/pS8cJUkE=;
        b=4nW8oi6F/9nozcZ7yXJfRANBBMoXWtcHvLrNJXBW5y9P7/0oPNwBaZDiW0Tvqj2wRe
         WMvomFzC/mDbCGMXxcGm97eC4vF8ihf9Ou3xOkTA4UR9qQglNIHZgceu8qxAEJ/pLSNY
         n6uYuGLHOVg0OwyJSiwRTsm4V83HLTxwAO5C55LuqA+xd7EWWVhMytB2GNdPmOgLzRQv
         FWcG/P1j8udJzcxwmVETlpIPVRg2z98QHUTPW7Ze1zIYIHPMLqbiOnRRxYzsXmAIfsVM
         IdSDG3mz8q72yIRrNYeoz3mNTPAJPz8Sx1CG1EF6vcsnof6Rpx47f7K6DsCOuKnPH29X
         Yfbw==
X-Gm-Message-State: ANoB5pkRlEbDBPEtm4IOcqta4UhVvRq8o0gVtpgB9dFaVQxjQ745sVSt
        EQ3nyI4uL1p/WwG5rcUVsWmmlRMVA3lX
X-Google-Smtp-Source: AA0mqf4Owhg9TSF5BqPmkokKmNN1T62eQp1AeaL0nFC6RJ1ulWDmRb4Tbo2Zj8w/ORKb01IV4bsRzBTCf1i+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:a05:690c:e:b0:388:2fb:57d9 with SMTP id
 bc14-20020a05690c000e00b0038802fb57d9mr4675335ywb.371.1668582792508; Tue, 15
 Nov 2022 23:13:12 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:12:59 -0800
In-Reply-To: <20221116071259.2832681-1-irogers@google.com>
Message-Id: <20221116071259.2832681-5-irogers@google.com>
Mime-Version: 1.0
References: <20221116071259.2832681-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 4/4] perf list: List callback support for libpfm
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

Missed previously, add libpfm support for 'perf list' callbacks and
thereby json support.

Fixes: df936cadfb58ba93 ("perf stat: Add JSON output option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pfm.c | 154 ++++++++++++++++++------------------------
 tools/perf/util/pfm.h |   6 +-
 2 files changed, 70 insertions(+), 90 deletions(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index f0bcfcab1a93..ac3227ba769c 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -12,6 +12,7 @@
 #include "util/parse-events.h"
 #include "util/pmu.h"
 #include "util/pfm.h"
+#include "util/strbuf.h"
 
 #include <string.h>
 #include <linux/kernel.h>
@@ -130,53 +131,36 @@ static const char *srcs[PFM_ATTR_CTRL_MAX] = {
 };
 
 static void
-print_attr_flags(pfm_event_attr_info_t *info)
+print_attr_flags(struct strbuf *buf, const pfm_event_attr_info_t *info)
 {
-	int n = 0;
+	if (info->is_dfl)
+		strbuf_addf(buf, "[default] ");
 
-	if (info->is_dfl) {
-		printf("[default] ");
-		n++;
-	}
-
-	if (info->is_precise) {
-		printf("[precise] ");
-		n++;
-	}
-
-	if (!n)
-		printf("- ");
+	if (info->is_precise)
+		strbuf_addf(buf, "[precise] ");
 }
 
 static void
-print_libpfm_events_detailed(pfm_event_info_t *info, bool long_desc)
+print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
+		const pfm_pmu_info_t *pinfo, const pfm_event_info_t *info,
+		struct strbuf *buf)
 {
-	pfm_event_attr_info_t ainfo;
-	const char *src;
 	int j, ret;
+	char topic[80], name[80];
 
-	ainfo.size = sizeof(ainfo);
+	strbuf_setlen(buf, 0);
+	snprintf(topic, sizeof(topic), "pfm %s", pinfo->name);
 
-	printf("  %s\n", info->name);
-	printf("    [%s]\n", info->desc);
-	if (long_desc) {
-		if (info->equiv)
-			printf("      Equiv: %s\n", info->equiv);
+	snprintf(name, sizeof(name), "%s::%s", pinfo->name, info->name);
+	strbuf_addf(buf, "Code: 0x%"PRIx64"\n", info->code);
 
-		printf("      Code  : 0x%"PRIx64"\n", info->code);
-	}
 	pfm_for_each_event_attr(j, info) {
-		ret = pfm_get_event_attr_info(info->idx, j,
-					      PFM_OS_PERF_EVENT_EXT, &ainfo);
-		if (ret != PFM_SUCCESS)
-			continue;
-
-		if (ainfo.type == PFM_ATTR_UMASK) {
-			printf("      %s:%s\n", info->name, ainfo.name);
-			printf("        [%s]\n", ainfo.desc);
-		}
+		pfm_event_attr_info_t ainfo;
+		const char *src;
 
-		if (!long_desc)
+		ainfo.size = sizeof(ainfo);
+		ret = pfm_get_event_attr_info(info->idx, j, PFM_OS_PERF_EVENT_EXT, &ainfo);
+		if (ret != PFM_SUCCESS)
 			continue;
 
 		if (ainfo.ctrl >= PFM_ATTR_CTRL_MAX)
@@ -184,64 +168,74 @@ print_libpfm_events_detailed(pfm_event_info_t *info, bool long_desc)
 
 		src = srcs[ainfo.ctrl];
 		switch (ainfo.type) {
-		case PFM_ATTR_UMASK:
-			printf("        Umask : 0x%02"PRIx64" : %s: ",
-				ainfo.code, src);
-			print_attr_flags(&ainfo);
-			putchar('\n');
+		case PFM_ATTR_UMASK: /* Ignore for now */
 			break;
 		case PFM_ATTR_MOD_BOOL:
-			printf("      Modif : %s: [%s] : %s (boolean)\n", src,
-				ainfo.name, ainfo.desc);
+			strbuf_addf(buf, " Modif: %s: [%s] : %s (boolean)\n", src,
+				    ainfo.name, ainfo.desc);
 			break;
 		case PFM_ATTR_MOD_INTEGER:
-			printf("      Modif : %s: [%s] : %s (integer)\n", src,
-				ainfo.name, ainfo.desc);
+			strbuf_addf(buf, " Modif: %s: [%s] : %s (integer)\n", src,
+				    ainfo.name, ainfo.desc);
 			break;
 		case PFM_ATTR_NONE:
 		case PFM_ATTR_RAW_UMASK:
 		case PFM_ATTR_MAX:
 		default:
-			printf("      Attr  : %s: [%s] : %s\n", src,
-				ainfo.name, ainfo.desc);
+			strbuf_addf(buf, " Attr: %s: [%s] : %s\n", src,
+				    ainfo.name, ainfo.desc);
 		}
 	}
-}
+	print_cb->print_event(print_state,
+			pinfo->name,
+			topic,
+			name, info->equiv,
+			/*scale_unit=*/NULL,
+			/*deprecated=*/NULL, "PFM event",
+			info->desc, /*long_desc=*/NULL,
+			/*encoding_desc=*/buf->buf,
+			/*metric_name=*/NULL, /*metric_expr=*/NULL);
 
-/*
- * list all pmu::event:umask, pmu::event
- * printed events may not be all valid combinations of umask for an event
- */
-static void
-print_libpfm_events_raw(pfm_pmu_info_t *pinfo, pfm_event_info_t *info)
-{
-	pfm_event_attr_info_t ainfo;
-	int j, ret;
-	bool has_umask = false;
+	pfm_for_each_event_attr(j, info) {
+		pfm_event_attr_info_t ainfo;
+		const char *src;
 
-	ainfo.size = sizeof(ainfo);
+		strbuf_setlen(buf, 0);
 
-	pfm_for_each_event_attr(j, info) {
-		ret = pfm_get_event_attr_info(info->idx, j,
-					      PFM_OS_PERF_EVENT_EXT, &ainfo);
+		ainfo.size = sizeof(ainfo);
+		ret = pfm_get_event_attr_info(info->idx, j, PFM_OS_PERF_EVENT_EXT, &ainfo);
 		if (ret != PFM_SUCCESS)
 			continue;
 
-		if (ainfo.type != PFM_ATTR_UMASK)
-			continue;
+		if (ainfo.ctrl >= PFM_ATTR_CTRL_MAX)
+			ainfo.ctrl = PFM_ATTR_CTRL_UNKNOWN;
 
-		printf("%s::%s:%s\n", pinfo->name, info->name, ainfo.name);
-		has_umask = true;
+		src = srcs[ainfo.ctrl];
+		if (ainfo.type == PFM_ATTR_UMASK) {
+			strbuf_addf(buf, "Umask: 0x%02"PRIx64" : %s: ",
+				ainfo.code, src);
+			print_attr_flags(buf, &ainfo);
+			snprintf(name, sizeof(name), "%s::%s:%s",
+				 pinfo->name, info->name, ainfo.name);
+			print_cb->print_event(print_state,
+					pinfo->name,
+					topic,
+					name, /*alias=*/NULL,
+					/*scale_unit=*/NULL,
+					/*deprecated=*/NULL, "PFM event",
+					ainfo.desc, /*long_desc=*/NULL,
+					/*encoding_desc=*/buf->buf,
+					/*metric_name=*/NULL, /*metric_expr=*/NULL);
+		}
 	}
-	if (!has_umask)
-		printf("%s::%s\n", pinfo->name, info->name);
 }
 
-void print_libpfm_events(bool name_only, bool long_desc)
+void print_libpfm_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	pfm_event_info_t info;
 	pfm_pmu_info_t pinfo;
-	int i, p, ret;
+	int p, ret;
+	struct strbuf storage;
 
 	libpfm_initialize();
 
@@ -249,12 +243,9 @@ void print_libpfm_events(bool name_only, bool long_desc)
 	info.size  = sizeof(info);
 	pinfo.size = sizeof(pinfo);
 
-	if (!name_only)
-		puts("\nList of pre-defined events (to be used in --pfm-events):\n");
+	strbuf_init(&storage, 2048);
 
 	pfm_for_all_pmus(p) {
-		bool printed_pmu = false;
-
 		ret = pfm_get_pmu_info(p, &pinfo);
 		if (ret != PFM_SUCCESS)
 			continue;
@@ -267,25 +258,14 @@ void print_libpfm_events(bool name_only, bool long_desc)
 		if (pinfo.pmu == PFM_PMU_PERF_EVENT)
 			continue;
 
-		for (i = pinfo.first_event; i != -1;
-		     i = pfm_get_event_next(i)) {
-
+		for (int i = pinfo.first_event; i != -1; i = pfm_get_event_next(i)) {
 			ret = pfm_get_event_info(i, PFM_OS_PERF_EVENT_EXT,
 						&info);
 			if (ret != PFM_SUCCESS)
 				continue;
 
-			if (!name_only && !printed_pmu) {
-				printf("%s:\n", pinfo.name);
-				printed_pmu = true;
-			}
-
-			if (!name_only)
-				print_libpfm_events_detailed(&info, long_desc);
-			else
-				print_libpfm_events_raw(&pinfo, &info);
+			print_libpfm_event(print_cb, print_state, &pinfo, &info, &storage);
 		}
-		if (!name_only && printed_pmu)
-			putchar('\n');
 	}
+	strbuf_release(&storage);
 }
diff --git a/tools/perf/util/pfm.h b/tools/perf/util/pfm.h
index 7d70dda87012..9cc9bb1e0949 100644
--- a/tools/perf/util/pfm.h
+++ b/tools/perf/util/pfm.h
@@ -7,13 +7,14 @@
 #ifndef __PERF_PFM_H
 #define __PERF_PFM_H
 
+#include "print-events.h"
 #include <subcmd/parse-options.h>
 
 #ifdef HAVE_LIBPFM
 int parse_libpfm_events_option(const struct option *opt, const char *str,
 			int unset);
 
-void print_libpfm_events(bool name_only, bool long_desc);
+void print_libpfm_events(const struct print_callbacks *print_cb, void *print_state);
 
 #else
 #include <linux/compiler.h>
@@ -26,8 +27,7 @@ static inline int parse_libpfm_events_option(
 	return 0;
 }
 
-static inline void print_libpfm_events(bool name_only __maybe_unused,
-				       bool long_desc __maybe_unused)
+static inline void print_libpfm_events(const struct print_callbacks *print_cb, void *print_state)
 {
 }
 
-- 
2.38.1.431.g37b22c650d-goog

