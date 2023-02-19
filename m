Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DAAC636CC
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBSJoU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjBSJoS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:44:18 -0500
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92D783DC
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:43:36 -0800 (PST)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-171db29c040so144698fac.14
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDHxoNK+iGgerGSxgoF4xDhtMfF1M1KB0gmMhIH6g+o=;
        b=szVoKRw23j5Oh2tOkbAIG0IvtMpMsOrvW9A3e7kcO9it79BlwWVgNPV/uB9d0sO7u/
         I5P/KixArxBv49X8CI3tQxLa1twzSrl7TRDwEq1x2y6kljyqBkBCYoIMwLoi+xqN41ew
         1YfVyzeiNzV35kAtc0w1HbeMjjubJLR48JfNp8ElXZGSO/WXsj10RUfCtCXN1HnCxZyR
         j2zQAAH13HqlMas9+N26ILACb+ttaBbF6Jt9XRfpsIyNeIBd6pDcvMVo8sZ+Ar6TSVKI
         HOY1Q4URcucKu7ff34heQu958Cgzod/PuzJPQJrHwtSrEsUCVeat8sQUeniU8nlRMHHv
         3Wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDHxoNK+iGgerGSxgoF4xDhtMfF1M1KB0gmMhIH6g+o=;
        b=jEPYkgcbOcRzvUuYZW7TmehgaCICNnjxd3lOaj68NJcnDCyJk5GU4ca4SX4N1yjtkh
         RMzcW5bNbt1pzaYAgwEeux2I3QdZyAab66BMDvXLPyqS7K7sXKdeA5WMqMLPUtUcsmoG
         dyeUlLE3O4qn2DgSiVsLmLVnn5w09OsThmf7egFniDZijDK+sdjy7WcV24n2ZRdbJ0e3
         dWCU2IcFbaglZSDSCKW4rsugr1T1wmJ0lfhxY+HVbM8TANhhX8YSl5caY4T71m32WaVL
         vmI9tzK+Z8ynQrSp+/4iQ3PMUrqGCILzu2c+POv09JaqEg3ZxdqWzU2c4/GbpBmO1gZZ
         hQUQ==
X-Gm-Message-State: AO0yUKUjG/rodw0pLG9/kQbwUagQLD6SoUjM5r2Oqk1vVnPA797Dyrr6
        fXXQCvUdc+JDGPqyWGgpPfej+WuV+pdV
X-Google-Smtp-Source: AK7set+3n8bzTs6jlEite8UPyzDtlGWXVaLGOAeCv19aTjMK1elNMeI7zwFyr8LOnDdLf7qku0lKAJCZ5SfJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:287:b0:8da:cda:7a50 with SMTP id
 v7-20020a056902028700b008da0cda7a50mr9710ybh.11.1676799207878; Sun, 19 Feb
 2023 01:33:27 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:29 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-33-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 32/51] perf jevents: Add rand support to metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

rand (reverse and) is useful in the parsing of metric
thresholds. Update the documentation on operator precedence to clarify
the simple expression parser and python differences wrt binary/logical
operators.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 77ea6ff98538..8ec0ba884673 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -44,6 +44,9 @@ class Expression:
   def __and__(self, other: Union[int, float, 'Expression']) -> 'Operator':
     return Operator('&', self, other)
 
+  def __rand__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('&', other, self)
+
   def __lt__(self, other: Union[int, float, 'Expression']) -> 'Operator':
     return Operator('<', self, other)
 
@@ -88,7 +91,10 @@ def _Constify(val: Union[bool, int, float, Expression]) -> Expression:
 
 
 # Simple lookup for operator precedence, used to avoid unnecessary
-# brackets. Precedence matches that of python and the simple expression parser.
+# brackets. Precedence matches that of the simple expression parser
+# but differs from python where comparisons are lower precedence than
+# the bitwise &, ^, | but not the logical versions that the expression
+# parser doesn't have.
 _PRECEDENCE = {
     '|': 0,
     '^': 1,
-- 
2.39.2.637.g21b0678d19-goog

