Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D5CC83F17
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Aug 2023 18:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjH3Se4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241803AbjH3HIC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Aug 2023 03:08:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3211A3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 00:07:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59263889eacso73243057b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693379279; x=1693984079; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5NaHsU6gXgFOenHk7MfqZGVTVXuRwf+WJ70Gj+1DurU=;
        b=6/GxsNd9Kywu8N8XjZIO0gtCnLdeXgprY6VCHDrGvNdNtgmQWcqKTR+ASayOySQdea
         oBuJMJ0bS8QA18CQxHCZuERQQQQTUoRXf4QY9jedpUkKPTXNsSsEmh0nYtpN6CihA2x7
         7kMZwLwOc6AMLS8MOuxrhPupvQDVMbQOV3uOtfQntIvadA20eEHV1a4ncqemahlUoVKf
         KJZfb+dWMC1ProTCP+xXsqpUHwq7upPdAhJL5FZrhstZ486VOWSB4MZ2TvMP6TGG5LGL
         6nxwg9L455g7bJv8sTozqXuIxGezChegJOoEztWFkxvv42t20X7xV6+wdW3LiT6zdI7T
         9liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693379279; x=1693984079;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NaHsU6gXgFOenHk7MfqZGVTVXuRwf+WJ70Gj+1DurU=;
        b=FV8M1mDy99zl+Qph3jrHff0Xs0ranJa50vgD15lZtWMwQeKWRu6AXqnfAHKjFdvCls
         HX7dYTMnvv4OJWkvjZQFju9VV6yEiIiUOMDHRcoPJyqXANIj0k1LZJARY/oNnNikpVna
         kSfo03YdGhcKG94a74dZBD6Q7PoAmLsubcecF7t/W0PjrZJ6dHJRc9KCXOXg/ugDu9va
         d4GOZsWfSNZbfKbvQLSTCElw7T//NiBwkiAHBAU8HNG88qs+DuGRN6hkhdNHWBhaesy6
         B4WNqwn9to2nqwOJk2pPAs5frSSdT02Wei/OQm+JSAfVSbdYBZ9r23K8flQNevJuSPOw
         4/YQ==
X-Gm-Message-State: AOJu0Yw2U3dvTEv/h/mEnkKtAiVv2AZHJDosQiTI8kRBk8KrWBzAfYa5
        O2ha4kT4IR9PD2+VkamsE1UZSqBlcDsn
X-Google-Smtp-Source: AGHT+IEsqhzZVskXpYnOT+qq+VkLTum6nBgxwvZomGfzTOhPcyfHGK9ecuI2vCBSfox/qM2B17EZrYy6QlAq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d623:3cd7:ecbc:8798])
 (user=irogers job=sendgmr) by 2002:a25:d0e:0:b0:d63:8364:328 with SMTP id
 14-20020a250d0e000000b00d6383640328mr35188ybn.5.1693379278979; Wed, 30 Aug
 2023 00:07:58 -0700 (PDT)
Date:   Wed, 30 Aug 2023 00:07:51 -0700
Message-Id: <20230830070753.1821629-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1 1/3] perf parse-events: Minor help message improvements
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
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Be more specific and fix a typo.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 3a9d4e2513b5..4a370c36a0d5 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -342,7 +342,7 @@ PE_NAME opt_pmu_config
 			struct parse_events_error *error = parse_state->error;
 			char *help;
 
-			if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+			if (asprintf(&help, "Unable to find PMU or event on a PMU of '%s'", $1) < 0)
 				help = NULL;
 			parse_events_error__handle(error, @1.first_column,
 						   strdup("Bad event or PMU"),
@@ -368,7 +368,7 @@ PE_NAME sep_dc
 		struct parse_events_error *error = parse_state->error;
 		char *help;
 
-		if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+		if (asprintf(&help, "Unable to find event on a PMU of '%s'", $1) < 0)
 			help = NULL;
 		parse_events_error__handle(error, @1.first_column, strdup("Bad event name"), help);
 		free($1);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

