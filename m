Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C72CCA48B
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jul 2022 22:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiGYWgt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiGYWgt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jul 2022 18:36:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD725C74
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 15:36:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z1-20020a5b0201000000b006712e0c865bso3321755ybl.21
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 15:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JzNZf8+4+AkLiixfXHUf0Tr6YoyJNaYpbyf1w4wer88=;
        b=tnK2CIQUOLdZ4NZbW8ydd9eU6zUbz9glKlcJuST5dbUiptR3O3ThSFAQ0hzTsFgi/M
         NowDcyhR/WYcZKYDTuF1UVqvddi196NDL7h9B56XWeG81+krSHJrJ8UIe+OYUoEtgkBT
         Sjw5ZB1LhlZbf00O4oBY8b54KtTpH66DLTo0T3iej+xnCLkeqC4UcUaH96Z6w/Cdtgu6
         O9HrspLmFrWmdNqUYZ9oBf6BeyX/dTlc9k4AFkpyvt0AkV3/YxTnega/9g4bPTYQMixZ
         GF/DdFwc+4dnmAs5s9jzaL5f72uVil7XyXEWodIPwFGAaEdqOMb5E3LBKqG8ePhK1q5y
         c+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JzNZf8+4+AkLiixfXHUf0Tr6YoyJNaYpbyf1w4wer88=;
        b=r0PxTJh3YH3b12zKKIeUzG0+8nTrksIHAfYet+wc/ckVz1KvBHr3vPkV6YIhISTQM7
         H2SHjRN0pcRsvbQRkr/gXm9ESlIJ9xbRA8IqXKpNm7GK2TqujxY+V6NMZghLZLoFj+rW
         SZV845XQZ5EJo3+7I76JHoBwpYZBDMvNhM3qyW1E2JPuo78qKPCxxGc/vDJYhRGrX1jh
         m3whEecK6dSlU46nKmSif9yMSFITwya7zJQISgTIdt1yqOKzvfz76PdiMsDHDBL9Lgp0
         53f6mjgpnh9YfWoqgCmbt8sPvjybLtL8ncobVu2cszHYpoTEqk8vKIa/q0Z17PblbNwf
         J/qg==
X-Gm-Message-State: AJIora8oUbagLW0RuBoZPF9UQk91y8OxmKbZCeCSruyV6zLAYpcpYIOD
        5ut7KUjP6+SNLQesuk8M2WfUFZ18qQe1
X-Google-Smtp-Source: AGRyM1vrR5j1FUsCLO6h9AJRqbE3AEW5WaFKcvcXiCX4fT2x1gRBbyeIwKk70N2Wu6tK3NlPhG7Ygx/KIhDa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a81:250f:0:b0:31c:3c38:d3cc with SMTP id
 l15-20020a81250f000000b0031c3c38d3ccmr11998077ywl.306.1658788607534; Mon, 25
 Jul 2022 15:36:47 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:02 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-2-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 01/32] perf test: Avoid sysfs state affecting fake events
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Icelake has a slots event, on my Skylakex I have CPU events in sysfs
of topdown-slots-issued and topdown-total-slots. Legacy event parsing
would try to use '-' to separate parts of an event and so
perf_pmu__parse_init sets 'slots' to be a PMU_EVENT_SYMBOL_SUFFIX2. As
such parsing the slots event for a fake PMU fails as a
PMU_EVENT_SYMBOL_SUFFIX2 isn't made into the PE_PMU_EVENT_FAKE token.
Resolve this issue by test initializing the PMU parsing state before
every parse. This must be done every parse as the state is removes after
each parse_events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 478b33825790..263cbb67c861 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -812,6 +812,15 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 	for (cur = strchr(dup, '@') ; cur; cur = strchr(++cur, '@'))
 		*cur = '/';
 
+	if (fake_pmu) {
+		/*
+		 * Every call to __parse_events will try to initialize the PMU
+		 * state from sysfs and then clean it up at the end. Reset the
+		 * PMU events to the test state so that we don't pick up
+		 * erroneous prefixes and suffixes.
+		 */
+		perf_pmu__test_parse_init();
+	}
 	ret = __parse_events(evlist, dup, error, fake_pmu);
 	free(dup);
 
-- 
2.37.1.359.gd136c6c3e2-goog

