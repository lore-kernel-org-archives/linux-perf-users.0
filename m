Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9992C7EE2E
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbjEYHMS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbjEYHMN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:12:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B206E59
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561eadd916fso6410817b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998723; x=1687590723;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hra6WZ69L60AglI3672uw9bYTDH1KKdTR4WzF2eX2xU=;
        b=TA8mB11I1h+QeQQMXUG+vE9M/EN78BRwaxlLxUeqzVJ34TnG10IS0ugy3AVMvd9/xC
         eMPwd9a/QSq0g2ImBqKqt7J/QfGPS28JdZVv5y9SymqrKJdeoA85n3wRz88Y42poyCXf
         LTrwJ6kjvw5GcPH61PUch/P3C9WkzlUoESnNK825zrFM0TJZAalIEQakn7KWQ8T6s63P
         5QsBLD9b6Z/MIUiWBm+ZmnOaq0fTx9MJJ336uGoTCx8VWt0UF6xr6eQrx8JJFkL6N1Gc
         ZFtC1f44h1U+lclYFbSBZNy9wNKyLL3C/P3j+JlWhhivKTQuB1oQzgNJr3cAWmbbTz0x
         nfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998723; x=1687590723;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hra6WZ69L60AglI3672uw9bYTDH1KKdTR4WzF2eX2xU=;
        b=UF+uPf9IM+8c3T3vdWYPdbnAtRX/1X7cJTivZ/nW2xPDuXQjmezeyvjC9C6kGzef/L
         r6fZP6g4W+gi6uknbus2Dbh6J7DiWbdwuxXF1fP00s86qY34OIcQ5agnbVPLeLjUfjM7
         SHtuuwsKHVfu8sT5QjZCZ4CvgefHQizaCmlmast79gjbUKS/shTrSImv3l/4t2+mg36a
         ttQfGYiDtH2bHrqEnsK5J68RuQ8iOwcsWQbUGch+MXEosG2oNcbGHmUR6XDDPdqmZ0yU
         SoeqB7zXcErByGnV1oayR4akSMskMXRAuHRVtRbzTBc9hPX9EWJcOwicrx18ICqhHMwq
         1Xkw==
X-Gm-Message-State: AC+VfDxKPnqjU3kY4rY9nWLWQNlby06EJWjd4H1S1vjex1TG9jYKjLYN
        QODRXTrxK6ut9khkl/EM1ykv3VX2PK2u
X-Google-Smtp-Source: ACHHUZ7jaebbxMj65Qp3RY/tMW9DiUNK6wQ5cXeeS7I29t97r1ExaRLt2iqCakfQG8xC2up0vFMD8BAVirTh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ae09:0:b0:55a:8930:b13 with SMTP id
 m9-20020a81ae09000000b0055a89300b13mr12708203ywh.9.1684998723538; Thu, 25 May
 2023 00:12:03 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:19 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-3-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 02/16] perf test x86: insn-x86 test data is immutable so
 mark it const
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This allows the movement of some sizeable data arrays (168,624bytes)
to .data.relro. Without PIE or the strings it could be moved to
.rodata.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/insn-x86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index 735257d205b5..7b5eb8baf0f2 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -18,14 +18,14 @@ struct test_data {
 	const char *asm_rep;
 };
 
-struct test_data test_data_32[] = {
+const struct test_data test_data_32[] = {
 #include "insn-x86-dat-32.c"
 	{{0x0f, 0x01, 0xee}, 3, 0, NULL, NULL, "0f 01 ee             \trdpkru"},
 	{{0x0f, 0x01, 0xef}, 3, 0, NULL, NULL, "0f 01 ef             \twrpkru"},
 	{{0}, 0, 0, NULL, NULL, NULL},
 };
 
-struct test_data test_data_64[] = {
+const struct test_data test_data_64[] = {
 #include "insn-x86-dat-64.c"
 	{{0x0f, 0x01, 0xee}, 3, 0, NULL, NULL, "0f 01 ee             \trdpkru"},
 	{{0x0f, 0x01, 0xef}, 3, 0, NULL, NULL, "0f 01 ef             \twrpkru"},
@@ -97,7 +97,7 @@ static int get_branch(const char *branch_str)
 	return -1;
 }
 
-static int test_data_item(struct test_data *dat, int x86_64)
+static int test_data_item(const struct test_data *dat, int x86_64)
 {
 	struct intel_pt_insn intel_pt_insn;
 	int op, branch, ret;
@@ -147,9 +147,9 @@ static int test_data_item(struct test_data *dat, int x86_64)
 	return 0;
 }
 
-static int test_data_set(struct test_data *dat_set, int x86_64)
+static int test_data_set(const struct test_data *dat_set, int x86_64)
 {
-	struct test_data *dat;
+	const struct test_data *dat;
 	int ret = 0;
 
 	for (dat = dat_set; dat->expected_length; dat++) {
-- 
2.40.1.698.g37aff9b760-goog

