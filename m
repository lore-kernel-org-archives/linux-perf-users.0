Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1BDC001B0
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 04:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjF0Efo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 00:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjF0Efa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 00:35:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF61722
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 21:35:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57059f90cc5so53082227b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 21:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840529; x=1690432529;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=GGhHei1HXQ2/eDuwm+x2TRZUoV9KBsZ+Y1XPf//HboZJ0pXVaXRqoxpqXkT4G2FLd4
         LaNiwn4Da8qGrPbQJ1SsadtrnJPqutB3BWihU34E3qtpBswwOq72yejdwQwXoWzMtPwt
         +y5uRhYhPOw4jHxwVvqqQuUT639J2WhZpb91636YlufXm9IF8Nl6uRQgVEhtSqBLlPRE
         dwCL25Cikuvdfs4zaLso7TKsY/bxhm/5gWCtqE7vN1Zzz/R07iXPDz8OV6DBJ++Y7LVz
         XXs2BcP9ujeoVCc34lFY+GmgRn8oIAVxueOaIiXXCf768u2txj0KvJkegEH5ngzuzd91
         yj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840529; x=1690432529;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=a6xFyj1FDe2Z3lz05eTSrCrx7byEAUyUkwXKIhrAUNPm69LOMmDmZXjDpMAln+P1Ds
         1pt/EpZsZZNfYuMCblJKWvhxIrBUrY3rj9/d3cTQjFLdY+2JMItEJ/eFcQAydzPj/weY
         1ikcUxH4sQFNYIXCOmUhgvSkvpTN9+El1XE+6ybwPY8wFNfIitN7oP4ukf6JnjvXZylL
         F8rG5ovhy58GvEHNo/WZsLpIjQwgLeOzTL9zdnUGtefeP8amWYP+aZt30Brh7FAmnf/F
         aQhPLUvYxwvmbjiESIgQbzPi6Wak/2aHr41mFicpdhgiDtB2yKKLJWzMZG6cDCLyOC+m
         8NHQ==
X-Gm-Message-State: AC+VfDwJ8wOxEoh8dfRWop8R+LA1Co16YA6/65nTtolGKlL40uJNQpbY
        dfTl/dG5QStsWFbKkxwcXAB0kJoOhb01
X-Google-Smtp-Source: ACHHUZ6vOZIoR5CLG0J9dOgf3ZrdWfNkMBb9GwaJMfM09LU8pQxeBDqYATdE7/ljR1d1snX1nwvtdZ7/2vqK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:ca0b:0:b0:bcd:5dd5:848b with SMTP id
 a11-20020a25ca0b000000b00bcd5dd5848bmr6656602ybg.3.1687840529090; Mon, 26 Jun
 2023 21:35:29 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:50 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-6-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 05/13] perf parse-events: Avoid regrouped warning for wild
 card events
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

There is logic to avoid printing the regrouping warning for wild card
PMUs, this logic also needs to apply for wild card events.

Before:
```
$ perf stat -e '{data_read,data_write}' -a sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'system wide':

          2,979.16 MiB  data_read
            410.26 MiB  data_write

       1.001541923 seconds time elapsed
```
After:
```
$ perf stat -e '{data_read,data_write}' -a sleep 1

 Performance counter stats for 'system wide':

          2,975.94 MiB  data_read
            432.05 MiB  data_write

       1.001119499 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5dcfbf316bf6..0aa4308edb6c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1722,6 +1722,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 							  auto_merge_stats)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
+					parse_state->wild_card_pmus = true;
 					ok++;
 				}
 				parse_events_terms__delete(orig_head);
-- 
2.41.0.162.gfafddb0af9-goog

