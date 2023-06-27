Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE0AEB64DC
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 04:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF0EhC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 00:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjF0EgY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 00:36:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4582136
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 21:35:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5766e49b802so58138427b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 21:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840547; x=1690432547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xtK5HWFrotXOQTFAtNsXMiJLnjczB0bKaJqMYYAdAw=;
        b=dq8Z6/zkvj5AhkzyvCcePMaY/4TJVw6FKcFL0Grg7cTDpD7U97mANBasuEHRqq5E6J
         CeQG3laHxYsRQCw3jJIaAi640DkEL7fgTvW22VJ8WDVgEl+4NX2s598D87gax6gGuSoB
         5hMicurS2TR9HLtZr0Wd1+mVC7zxtAjFXsaOKbM0in3upafjoLIvGDv/bWUYVrx7xhKU
         cqHeiQZ1IEWQgkzY5fGck0b2h+bdXDUYdfXp4LE7J8DEVN8XccrdNwldcj6O43u/1TpF
         Z9PZyLuTNMg27UDpArpdutfeETdpMIdn7hEG+m84SMTDXzgW2+FoZUTV0XQUDCUMEpna
         RnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840547; x=1690432547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xtK5HWFrotXOQTFAtNsXMiJLnjczB0bKaJqMYYAdAw=;
        b=OIuQQos2FHkh6+98rGmmy3dFQVWmPN9LWc0b61EGDrI334rNYZ1KTAr0a+x3ECQ4vX
         rUAhy2VSK2yLo82oY8l9N5vXMtk8lGIdbRNzLIsTx04L8vq+UkFVax1tZ+gf6Odi8ylC
         7N07zMYRg9S6P+p/dhULpYAiYLLnqmA0JoLlSX6u/qHjQRCD900V61qTVm1v3ZhAO+qP
         6gjl3s+e5T10bYkIxBr9Yj0/fO6l6y48glMd6uL1gVgvhpm78MftsNBIqKmzzHr7PZ1a
         cUnWZCmvGvaSvwEuUhFiygqPaRvrHVemyw0ntlY/OoQISnDy4R5lD7rIY23iZt9RJh/Y
         FNWA==
X-Gm-Message-State: AC+VfDwDS2Edj5DH0Jqt9WRdq+RQK+JSIGWSyORdZ63TPFaDa7mDRVEQ
        QX7RJOsUM746yyjWaJUuCf4h+4ftOoIZ
X-Google-Smtp-Source: ACHHUZ7GCRaJQ8Zjv8j32ZTbpzp8/lqeBYs2D+DAkuQ/ELDVxl53n8Ud2bKcAn8g+26DHXYGmXXZ/pEJnOgt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:b344:0:b0:56d:25f3:f940 with SMTP id
 r65-20020a81b344000000b0056d25f3f940mr13876270ywh.10.1687840547041; Mon, 26
 Jun 2023 21:35:47 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:58 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-14-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 13/13] perf parse-events: Remove ABORT_ON
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Prefer informative messages rather than none with ABORT_ON. Document
one failure mode and add an error message for another.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 844646752462..454577f7aff6 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -22,12 +22,6 @@
 
 void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
 
-#define ABORT_ON(val) \
-do { \
-	if (val) \
-		YYABORT; \
-} while (0)
-
 #define PE_ABORT(val) \
 do { \
 	if (val == -ENOMEM) \
@@ -618,7 +612,9 @@ PE_RAW opt_event_config
 		YYNOMEM;
 	errno = 0;
 	num = strtoull($1 + 1, NULL, 16);
-	ABORT_ON(errno);
+	/* Given the lexer will only give [a-fA-F0-9]+ a failure here should be impossible. */
+	if (errno)
+		YYABORT;
 	free($1);
 	err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, num, $2,
 				       /*wildcard=*/false);
@@ -978,7 +974,17 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
 {
 	struct parse_events_array array;
 
-	ABORT_ON($3 < $1);
+	if ($3 < $1) {
+		struct parse_events_state *parse_state = _parse_state;
+		struct parse_events_error *error = parse_state->error;
+		char *err_str;
+
+		if (asprintf(&err_str, "Expected '%ld' to be less-than '%ld'", $3, $1) < 0)
+			err_str = NULL;
+
+		parse_events_error__handle(error, @1.first_column, err_str, NULL);
+		YYABORT;
+	}
 	array.nr_ranges = 1;
 	array.ranges = malloc(sizeof(array.ranges[0]));
 	if (!array.ranges)
-- 
2.41.0.162.gfafddb0af9-goog

