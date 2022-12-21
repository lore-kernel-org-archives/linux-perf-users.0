Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B77EC4167B
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Dec 2022 22:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbiLUWen (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Dec 2022 17:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiLUWei (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Dec 2022 17:34:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624232AFA
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Dec 2022 14:34:37 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v16-20020a17090a899000b00219b1f0ddebso1965877pjn.5
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Dec 2022 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSNQl52T6aONyRJU3JLzaiDjv/uDuW/eBBmo/7p1gyM=;
        b=hWrFQqbUjVIgEbk5/HxS/gkX6UYWMxIViM61QrBDErGTC0CBNoIoSRAGz4VBIy+Jr7
         JswhbaKF216kLto8y6J0fNHcsV3xpaxqEJUkJbD+LHzyL6/kkMwmt8zPho3uLPm5a1tU
         7T0VUBlzwmSB8KANwYWZ61vZ432nW1Ri7IIk/cr49jkIDjO4Oxy7NlMPIhaxhInVLxGy
         ltZAVnrt/pg51qXbCr0/25IVChcILeO1bWJ/6ep813uuo6FrGRblDVK16UPmaEFBryDQ
         ofPEuG9v8tmkKCKD09he2BxVBvloOkyTcDODFbe2QSWp7KFy4BP1B8TDzbO7Dja+3Obs
         xBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSNQl52T6aONyRJU3JLzaiDjv/uDuW/eBBmo/7p1gyM=;
        b=HfX4Vk2ddJTu4F4q+AvolEneraRKWuBeLH8pdPL6oj+D8eKulHa5zL31r5CbmQGTjQ
         8elmo2PaYoBt4kr4n2fcShIBR4Xg9eOM8KToIN3VGOVjGDFhO6ICNLhlwLK3UljmpZ//
         o0acRpD/SMkWQVG8x49fPv6l3fQCmRRkh+e/PvyqRoT0tI0uTxCrP1OKiszraMnxz2jN
         WaSD/xpCKCXuiBOFpVxaXDnst7khlfpQGV9VFkvmJXpOWJ6t3H0jvGhS9hlGBczhT3nF
         HL1LN7m0ea3fearp7FcSfWZHDmivFwmbEJ7MM5D8+HfJIfrQH2wkB3MWASE89XWLOeVX
         +YqA==
X-Gm-Message-State: AFqh2kohq2YQNDsQzGEq+6NdP7JcDOz02C3mGUU42R4XoMN/JRxz+B0R
        3IcEAiZSMrtmW2Rq1pOyvI994euEwhnY
X-Google-Smtp-Source: AMrXdXv2jCTZRqgvHNw/zlM6+eqhzbGTGQXu+45bytWBX9fVfz/bcWmBaNU4rA3CFSzsBRM24pb0+K70sXOG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:62bd:f120:1fd8:1d21])
 (user=irogers job=sendgmr) by 2002:aa7:8ecc:0:b0:57c:ec11:dc0a with SMTP id
 b12-20020aa78ecc000000b0057cec11dc0amr247300pfr.40.1671662076792; Wed, 21 Dec
 2022 14:34:36 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:34:12 -0800
In-Reply-To: <20221221223420.2157113-1-irogers@google.com>
Message-Id: <20221221223420.2157113-2-irogers@google.com>
Mime-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 1/9] perf jevents metric: Correct Function equality
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

rhs may not be defined, say for source_count, so add a guard.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 4797ed4fd817..2f2fd220e843 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -261,8 +261,10 @@ class Function(Expression):
 
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Function):
-      return self.fn == other.fn and self.lhs.Equals(
-          other.lhs) and self.rhs.Equals(other.rhs)
+      result = self.fn == other.fn and self.lhs.Equals(other.lhs)
+      if self.rhs:
+        result = result and self.rhs.Equals(other.rhs)
+      return result
     return False
 
 
-- 
2.39.0.314.g84b9a713c41-goog

