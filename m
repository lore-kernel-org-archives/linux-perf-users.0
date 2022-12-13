Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B3C10F1B
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Dec 2022 05:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiLMFEH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 00:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiLMFD0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Dec 2022 00:03:26 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5E220185
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Dec 2022 21:01:31 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id nb2-20020a17090b35c200b00221433a393dso1226088pjb.5
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Dec 2022 21:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuMMy9JhlpVg2nn8+xv0lc+LSPhmKVJUX8QvXqiK4NY=;
        b=K7HwGifKageycgoYMSuL41vFu6ZhGRCcITu74LY4LmX1sc3fl9DJan6HW5X6P//2l1
         lPsMsUSdkbzMOy98nKuXLhVpvkhkz0ngM1GDc+ZgChWBDyukLgh6FZlAVvh7awbKYiE+
         9HO5w2Ds4ekRxhkntFo+py07FVGrwLFO4zdeOF3RB/10oD1X8YaJiKOI2vwKYsyAwO/c
         k/5F8MDpuD2y3hHkC6qiT1hrauEipZws87UgdKj/abWMoUcLVSmd3KBqef7OD7j0ihfK
         6/V8KoxuzLRCjvzza/1yXEJh/vePWiW+Wwk1PJcBF3rzb8giDyJK8tJ+MjNqPLYBSwfl
         Q76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuMMy9JhlpVg2nn8+xv0lc+LSPhmKVJUX8QvXqiK4NY=;
        b=PcvIhPEpRFN95uFWFOtaXcJfmdqplkx7fylQryNJRW5pupInT60ACUjJf1AYjADRkY
         KRWCiIpNeewu9FHBfkt4vOCtuy5yOXIHCdalxaQxa2zOAWICiVVaJerQPmvLwkQuiR05
         Ms4dZhHbHoAMZ8yZgs2JjvSjyBkbHrQTm+WBxXeQradA/eWvZDXIEy/qQGIk4I0OrrqZ
         D16iYvwwcShUCZRdq9FAZIecKhw5V+AL8yuiqOp12Bhn562FuiS9l5ic5ntgdtQOFkzF
         iVSzmSb9EMkbBUCYSykiGBfPu6aJAvXcjjgi5m8AP+ZLRQTdvUACSvovTu0ENYxQvQPH
         FGRg==
X-Gm-Message-State: ANoB5pncGAdX52vXEu6D1D7cH4okW9ZMzr8hKgcAeAq01h87Gl0CiPK0
        a2tDifXWXtZpTIXCJs0jk9SM+kDK1eiY
X-Google-Smtp-Source: AA0mqf5hvvOzFevKbErNXEY+8TZG9ovyRZebB0AcYGaD6tNlLcRATfVWQ68dqrG52wztuEyPBmImvlRNdUIZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6b9f:864c:28da:e99b])
 (user=irogers job=sendgmr) by 2002:aa7:8b4d:0:b0:56c:411f:b699 with SMTP id
 i13-20020aa78b4d000000b0056c411fb699mr77952723pfd.48.1670907690534; Mon, 12
 Dec 2022 21:01:30 -0800 (PST)
Date:   Mon, 12 Dec 2022 21:00:35 -0800
In-Reply-To: <20221213050043.1199380-1-irogers@google.com>
Message-Id: <20221213050043.1199380-2-irogers@google.com>
Mime-Version: 1.0
References: <20221213050043.1199380-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH v1 1/9] perf jevents metric: Correct Function equality
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
index cc451a265751..1fa3478b9ab0 100644
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
2.39.0.rc1.256.g54fd8350bd-goog

