Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61CDC04E69
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Aug 2023 16:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHNQiS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjHNQiL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2023 12:38:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E91A8
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 09:38:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589a45c1b0fso63682427b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692031089; x=1692635889;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nscFVL3MFrP2MCfpvE3b34w9xAwW74LjxwP+hgfykt8=;
        b=U9uMvD45gGusaDttinkNdE3G1frqMqeAZgoBEl4kO4UpMSWz4uWQkmm43ItG1zVAvH
         fuLK6gjRAPwOQOV4fZgW/QRxRBwKlmOC5QrTISPScN/qBXuZRy6dNElCLDQUtWlKfThS
         PZylvUlNMqaxUD75Q2ifyLOkbO7VD7UdgS5ttzVfVu1FZEW0XHuPythKS8iw5BBzTJih
         rJvoYUF/cLxCyfnI+My/Gd+IGoVDih7slULOv4pud4S3f1Omp1bDGhiXSUn9wdzr62lO
         bCxa+t8ZVLf/TlGEn0RFe4eWcb5VK619rNI6hdDdov0SFBQ0T571QEwEQVLzdOYUdY3v
         lbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031089; x=1692635889;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nscFVL3MFrP2MCfpvE3b34w9xAwW74LjxwP+hgfykt8=;
        b=k7+9Gh14x1kTYtFZj+qoVw3mrrhXfi0h301lSt/7OvtBpe5Ii7UqixfRLjZlnwH/dO
         WMW4fAa9Sie+yKsGVuHIv09kOL/nmoR2yOyjc977E1MMQ0UqfAjzy/42OVVqy37W/VYy
         GuYZlEcCgLJogvzhPPbK1vNZ6U1J90TiKT/L3VHcCJ2t1TOX557AevpHdFRs7FT64QmJ
         OAbYD9oN6FN0yC/p1UQKYslOwd76ykaN3EYmopDrrc69grI33UCaqXaHXGJncqxU1b+X
         Ko/wCW+XSwkr74/lmINnFhJKvAKgPqs/bvwCKiYFvhVFgujfBtd/I37KrGJ9b6rh+v5x
         00Qg==
X-Gm-Message-State: AOJu0YzAT3p7DzeQCXuuGMOR79f5Onmhgc7VglGHeC/18QM07uol6bkg
        gBbaw0na0MESvEZ5gq+DvmgqQbRxy8S1
X-Google-Smtp-Source: AGHT+IGILuj3oJi0XcEflNpwgbZiMygoIL9Z0oYEluFBltIoEdxznvbSgnXaL7yKzRFf5SLq8mw8deBFfqrB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a919:6125:510f:f0ef])
 (user=irogers job=sendgmr) by 2002:a81:441f:0:b0:589:a5c6:4a8e with SMTP id
 r31-20020a81441f000000b00589a5c64a8emr146149ywa.1.1692031089732; Mon, 14 Aug
 2023 09:38:09 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:37:57 -0700
In-Reply-To: <20230814163757.3077138-1-irogers@google.com>
Message-Id: <20230814163757.3077138-4-irogers@google.com>
Mime-Version: 1.0
References: <20230814163757.3077138-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v3 3/3] perf pmus: Don't print duplicate PMU suffix in list by default
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Duplicate PMUs are no longer printed by default but the suffix of the
first is printed. When duplicate PMUs are being skipped avoid printing
the suffix.

Before:
```
$ perf list
...
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
```

After:
```
$ perf list
...
  uncore_imc_free_running/data_read/                 [Kernel PMU event]
  uncore_imc_free_running/data_total/                [Kernel PMU event]
  uncore_imc_free_running/data_write/                [Kernel PMU event]
...
$ perf list -v
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
  uncore_imc_free_running_1/data_read/               [Kernel PMU event]
  uncore_imc_free_running_1/data_total/              [Kernel PMU event]
  uncore_imc_free_running_1/data_write/              [Kernel PMU event]
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 5073843aca19..b0ecb2e5bdcc 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -440,10 +440,13 @@ static int sub_non_neg(int a, int b)
 }
 
 static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
-			  const struct perf_pmu_alias *alias)
+			  const struct perf_pmu_alias *alias, bool skip_duplicate_pmus)
 {
 	struct parse_events_term *term;
-	int used = snprintf(buf, len, "%s/%s", pmu->name, alias->name);
+	int pmu_name_len = skip_duplicate_pmus
+		? pmu_name_len_no_suffix(pmu->name, /*num=*/NULL)
+		: (int)strlen(pmu->name);
+	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &alias->terms, list) {
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
@@ -473,9 +476,10 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	int printed = 0;
 	int len, j;
 	struct sevent *aliases;
+	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
 	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
 
-	if (print_cb->skip_duplicate_pmus(print_state))
+	if (skip_duplicate_pmus)
 		scan_fn = perf_pmus__scan_skip_duplicates;
 	else
 		scan_fn = perf_pmus__scan;
@@ -518,6 +522,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 			*desc = NULL, *long_desc = NULL,
 			*encoding_desc = NULL, *topic = NULL,
 			*pmu_name = NULL;
+		int pmu_name_len;
 		bool deprecated = false;
 		size_t buf_used;
 
@@ -528,7 +533,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		if (!aliases[j].event) {
 			/* A selectable event. */
 			pmu_name = aliases[j].pmu->name;
-			buf_used = snprintf(buf, sizeof(buf), "%s//", pmu_name) + 1;
+			pmu_name_len = pmu_name_len_no_suffix(pmu_name, /*num=*/NULL);
+			buf_used = snprintf(buf, sizeof(buf), "%.*s//", pmu_name_len, pmu_name) + 1;
 			name = buf;
 		} else {
 			if (aliases[j].event->desc) {
@@ -536,7 +542,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 				buf_used = 0;
 			} else {
 				name = format_alias(buf, sizeof(buf), aliases[j].pmu,
-						    aliases[j].event);
+						    aliases[j].event, skip_duplicate_pmus);
 				if (aliases[j].is_cpu) {
 					alias = name;
 					name = aliases[j].event->name;
@@ -554,8 +560,10 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 			long_desc = aliases[j].event->long_desc;
 			topic = aliases[j].event->topic;
 			encoding_desc = buf + buf_used;
+			pmu_name_len = pmu_name_len_no_suffix(pmu_name, /*num=*/NULL);
 			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-					"%s/%s/", pmu_name, aliases[j].event->str) + 1;
+					"%.*s/%s/", pmu_name_len, pmu_name,
+					aliases[j].event->str) + 1;
 			deprecated = aliases[j].event->deprecated;
 		}
 		print_cb->print_event(print_state,
-- 
2.41.0.640.ga95def55d0-goog

