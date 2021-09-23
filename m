Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB6C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4E861107
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhIWHsV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbhIWHsS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757DEC061757
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:47 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 61-20020aed2143000000b002a6a0f52ce7so16883432qtc.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CH2wfweYlXSkrBMY+EWAyo/kDd2ZFKaxNyUFDQse7Ek=;
        b=lIRkvIUn79NH9MvjfHE7pASLtyI67ldRrBLfsfDkbKKHT7As7IOGVlf+jIqhOczi6A
         Wgu8rNiH3P9HXgO6akmhbAQdF54t1TMqcr1Ygn4mdbr4adt3OToEPSE1ZO7YwXKzyosn
         l19lOmdPbBPwEamgCdaFEjTJ8C8hCL62sTYwRE3+4W++jMbgSt8C4LO254f9mDiuONeE
         6gqPJ0NklG1vZ5X8RjywO915pA4Hz/jDeLAWFmnCPI6OQS3IVMk6yGUxdWEKW0TcMdXn
         CibbiIbDmi6rW/q5syK5X+x5GrrPrjbVnMftAzyWHZQcf1GPhrXg3x37FXr2VEE6NBQG
         NN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CH2wfweYlXSkrBMY+EWAyo/kDd2ZFKaxNyUFDQse7Ek=;
        b=IIB7j4xnF4sU2kOijuLaHJi05D3Kb3sonjG6Gm8/QZVOyS0vRaMq86IrQnGSjV/PVr
         RYuf760XJ5qjeEUCTCEfTVp5SxUba5U+c9kiPi9HqSRh52O1I7hUZDVwhDAwen1HCLkI
         Bzds0pl5XnReVebkhcfMQWXlTMuamlRy0WN6m+IHc5Ka/M2zpx8OD/FdAXUrUbLTUbY8
         4rHlRmM62vJZFC5lU0Okpp1M5Vdsh2PCGkNgHuVSpO71O1PLWkp+P1QRyQzzyA/V2kg1
         7FB3beVt+5DZcTh3e+aUqcSFdEDh+AqQiAkaJy+t0tjOFoqSqnYhhu497qYxgzbSkqi+
         DzpQ==
X-Gm-Message-State: AOAM530LedO963Y4iJTt/FN98RPETAI0iiYRokp7wPyx7RIaHqiP+uLA
        rixHTRqzMQp8U2ZYhT/hMIw3lkGM5VlX
X-Google-Smtp-Source: ABdhPJwEjkQ7FuNj4fQbf3vnT5ewzSpH6LKVZLyQL/zmTVlQRDWbSFylPe9T+77fbXHvY4hWbW6kgJuSVgZ9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:3086:: with SMTP id
 w128mr4257655ybw.139.1632383206601; Thu, 23 Sep 2021 00:46:46 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:08 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-6-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 05/13] perf expr: Use macros for operators
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

No functional change, switch the operators to use macros so that
additional complexity for constants can be added in a later change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 68b122e59b3f..5535badeef0a 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -43,6 +43,12 @@ static void expr_error(double *final_val __maybe_unused,
 	pr_debug("%s\n", s);
 }
 
+#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
+	RESULT = (long)LHS OP (long)RHS;
+
+#define BINARY_OP(RESULT, OP, LHS, RHS)					\
+	RESULT = LHS OP RHS;
+
 %}
 %%
 
@@ -81,14 +87,14 @@ expr:	  NUMBER
 
 					free($1);
 				}
-	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
-	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
-	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
-	| expr '<' expr		{ $$ = $1 < $3; }
-	| expr '>' expr		{ $$ = $1 > $3; }
-	| expr '+' expr		{ $$ = $1 + $3; }
-	| expr '-' expr		{ $$ = $1 - $3; }
-	| expr '*' expr		{ $$ = $1 * $3; }
+	| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
+	| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
+	| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
+	| expr '<' expr { BINARY_OP($$, <, $1, $3); }
+	| expr '>' expr { BINARY_OP($$, >, $1, $3); }
+	| expr '+' expr { BINARY_OP($$, +, $1, $3); }
+	| expr '-' expr { BINARY_OP($$, -, $1, $3); }
+	| expr '*' expr { BINARY_OP($$, *, $1, $3); }
 	| expr '/' expr		{ if ($3 == 0) {
 					pr_debug("division by zero\n");
 					YYABORT;
-- 
2.33.0.464.g1972c5931b-goog

