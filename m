Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F0EECAAD3
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 17:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiHaRuE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiHaRtw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 13:49:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628382DF
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 10:49:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3363b1dffa0so209940347b3.23
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=FIhE9np411d4p3gN9blVTRPdzI3E6ppyXBOT6UPFbR4=;
        b=ne9hSOueraTKLt8B5Cb23CIuuHBACsq29lffrVlmCbtJ+wIUo6y/lzIcGacW0pICES
         ND3eaRFXLukN+o+BTCx6E/CwfDw5PKfyfUAwBfkx6AOgLtzjKxkmtMm9tTMXEq5TJB+o
         T5UoEd4og4+/s2fdLG8ZcMM+T01avD4CaXvmUR5vRy7qQ7ZjLmfTXsBRS7lyGCARMH7E
         tJHQaOSAVFlZz4eRNlrsQAFiy8f/kkhs3c4aaZnmjQfDFDEanQMdfKp3/PPOULKsxx4K
         IZxhp6YtK1161/rjbG2CMiAejR9L95NqM5+2LFilD/hSzDd2LTENesnpRSq+AfA6fXTU
         fW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=FIhE9np411d4p3gN9blVTRPdzI3E6ppyXBOT6UPFbR4=;
        b=dMWEkIuTZCY13MrL3Dx2V9hOX0jOCkjN7zO3ylxnE1FdjxJTcCQJaYGgg87623zmGq
         NmcLS9LoIkTRvt9Y5qkLeWx9uXH0jGGkep46KZ4CF6AD2VKXOhppoTMgq6PUA0gT4XgI
         sPNtbbEe1iI4NNSdnXsLflC+scJvWDHlDzlh7Y+1wzb5eFaXon0deCt7S1TT3bSmCe1R
         WYrfohxa6hfbC8Fi7ocITL9sFFNkFGBeAyOijKQ6Z511HOTB2m2clvsqPPKVwnROP73s
         gVTYl6XvtTf/PocYt/w2vKme90Hba/W9atF5W2fyRvs61RPUUWov5j9/qUuX1c5VZ93O
         Wb+Q==
X-Gm-Message-State: ACgBeo1eSCU30+bGgVKadcJs5VEvyTxR6S+Rd3sVRWOP0XijgvgPEEq0
        wH5aRN9QGCR0RcJahOMd6EeTHMc3XS/C
X-Google-Smtp-Source: AA6agR4B7PQHzA5GEWgennxyCAc9Ns5xYfYAa5bOnz0OECUYKf6mW+FhxZe1AzmfytNMjb2G3jAMvNJ75M5X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8e4:a3e5:9d09:d3d4])
 (user=irogers job=sendgmr) by 2002:a25:4e42:0:b0:696:4c4d:6545 with SMTP id
 c63-20020a254e42000000b006964c4d6545mr16758166ybb.488.1661968185602; Wed, 31
 Aug 2022 10:49:45 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:20 -0700
In-Reply-To: <20220831174926.579643-1-irogers@google.com>
Message-Id: <20220831174926.579643-2-irogers@google.com>
Mime-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2 1/7] perf metric: Return early if no CPU PMU table exists
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Previous behavior is to segfault if there is no CPU PMU table and a
metric is sought. To reproduce compile with NO_JEVENTS=1 then request
a metric, for example, "perf stat -M IPC true".

Fixes: 00facc760903 ("perf jevents: Switch build to use jevents.py")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ad5cacdecd81..18aae040d61d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1655,6 +1655,9 @@ int metricgroup__parse_groups(const struct option *opt,
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	const struct pmu_events_table *table = pmu_events_table__find();
 
+	if (!table)
+		return -EINVAL;
+
 	return parse_groups(perf_evlist, str, metric_no_group,
 			    metric_no_merge, NULL, metric_events, table);
 }
-- 
2.37.2.672.g94769d06f0-goog

