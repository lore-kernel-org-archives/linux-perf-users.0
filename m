Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D831C77B75
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 May 2023 06:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjESGhq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 May 2023 02:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESGhp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 May 2023 02:37:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE84E52
        for <linux-perf-users@vger.kernel.org>; Thu, 18 May 2023 23:37:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561abf855afso33533507b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 18 May 2023 23:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684478263; x=1687070263;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5TeZYA6Yh2uxMAka8ZUm4LCgpMtMW40FXjoIbBP7Ak=;
        b=sBwkLDS3aNkG+qNJbW+6Y7LdB7i8GJJ/qFPaOxjiSknN/QNJnCRcAzzdAfzBqv2IY7
         L0bAa/1DmOehqeJd2dBslVVTcI8hbvKTxSZjn1j874wh4PM36QZ5xpncKPdqc27QsDRN
         ximxGSk7BeTcdV3721QxOoyzTCE+5A/HHeq8SSrSBCqYInpqHxz8tQ7MMlaXnxlTImz1
         MfWEzhCu1fRezXvI01G80vNerSa/tfhCbVDyIujrl2yfUL24DTiQlMJoobWPe5soyoSU
         CJeKVgKkGVbPEY3zT1y0RynWt8HxhaCqMTk9VXHF6f8eQZ8v7P/IeXxdzQQgA0JrQT5M
         ANnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684478263; x=1687070263;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5TeZYA6Yh2uxMAka8ZUm4LCgpMtMW40FXjoIbBP7Ak=;
        b=esEhnjuvoHuLgWI0ctzd256NJ430loVaRTlRa+eRbyfEgSVFjWxPibuDLZt8KRcGvR
         WPB+IfTwpAVw4BSdiHqOZ6S+VMy5J5JZhWrFpNVSYfTDAtpKEvBFBKFge5yIw8z0Xrlg
         G5sgbANS2OTVHC3hsWwKh88OeOuUteyiDOXX4XbjSqgmcvUIJ+r+4lxasO92I71kNwIW
         P1cHLW6Atk3B/hx2qmkUhcj33WqkV0YLGHuTJu+iqM93z6pNQCaxNy+SB/Yr/vnFoZBG
         m7Dy+6bQHIcqEanDeeB3Z6XM+wBS2rwoiKIk06wfXZhPAelBbqvwSLSf9Lh83vP8DJfk
         ffGw==
X-Gm-Message-State: AC+VfDwNXfE1RWFXuPKFPXQ4COjGq1uDFKnSmgJ1TRRCoYuBGp5vN64a
        sNZLzkEhYZDf9X7IKxfrnHGWibU9aQGH
X-Google-Smtp-Source: ACHHUZ50/gkYHnLZWwB7w8YrKMq3GhfBeGBQdjSAT0G8K/6GVh4gVPhnBlr/do5az+RqLm3jPFftzyZEcAHc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a7c2:2c4c:d716:50e2])
 (user=irogers job=sendgmr) by 2002:a81:b616:0:b0:561:8c16:2b64 with SMTP id
 u22-20020a81b616000000b005618c162b64mr644074ywh.5.1684478263638; Thu, 18 May
 2023 23:37:43 -0700 (PDT)
Date:   Thu, 18 May 2023 23:37:19 -0700
In-Reply-To: <20230519063719.1029596-1-irogers@google.com>
Message-Id: <20230519063719.1029596-2-irogers@google.com>
Mime-Version: 1.0
References: <20230519063719.1029596-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 2/2] perf stat: Document --metric-no-threshold and
 threshold colors
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Document the threshold behavior for -M/--metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 29bdcfa93f04..694950345e15 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -353,6 +353,15 @@ small group that need not have multiplexing is lowered. This option
 forbids the event merging logic from sharing events between groups and
 may be used to increase accuracy in this case.
 
+--metric-no-threshold::
+Metric thresholds may increase the number of events necessary to
+compute whether a metric has exceeded its threshold expression. This
+may not be desirable, for example, as the events can introduce
+multiplexing. This option disables the adding of threshold expression
+events for a metric. However, if there are sufficient events to
+compute the threshold then the threshold is still computed and used to
+color the metric's computed value.
+
 --quiet::
 Don't print output, warnings or messages. This is useful with perf stat
 record below to only write data to the perf.data file.
@@ -389,6 +398,12 @@ For a group all metrics from the group are added.
 The events from the metrics are automatically measured.
 See perf list output for the possible metrics and metricgroups.
 
+	When threshold information is available for a metric, the
+	color red is used to signify a metric has exceeded a threshold
+	while green shows it hasn't. The default color means that
+	no threshold information was available or the threshold
+	couldn't be computed.
+
 -A::
 --no-aggr::
 Do not aggregate counts across all monitored CPUs.
-- 
2.40.1.698.g37aff9b760-goog

