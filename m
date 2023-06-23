Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF6DEB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 15:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjFWPLa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjFWPLN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE52957
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:10:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd5f9d084c9so1150680276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533039; x=1690125039;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbVKkaPWXAVNKNh1CW8R2oY532WwWiXP5nT3QKlBBnU=;
        b=vU5EMJOqgJyjuf6oMjP3eYqV5oZcVODZ2DycPDXEAR3DL4Uh3QlyZvy3EVx3Qfl10j
         1Y66GEKJEORy4XU2Ls2sXcoZw/hhvMoqjh8PoWCQGLDyoSejBP0fkcxUxOuFtN+FTGrh
         gWveHqtpFlKeruJfUPow/9m8m4rXSz5Z+Hr3UFl0VsohIZ1tVx581ZHeCsRKn+NYveYA
         KBk0wNh2IxFdeCmBY3i9yXpQ6o0569eVjqLgyCMHTCggK39f3Bl9tiu99mQiOVKApm4W
         Efoci3DdXd1iy2RsAmT/br3/843FEfpR/G/9QO3QQxABTu53SoHdWCVqvF6v2o5yXRFU
         4LIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533039; x=1690125039;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbVKkaPWXAVNKNh1CW8R2oY532WwWiXP5nT3QKlBBnU=;
        b=LFtSpkBLB3IBM5ohFcGe59qORiyBO4WGMSj2ygSKEfP2FcaBClvuYAMy5Qv3+IxkXN
         6eCLw0btknZLZy4xLdA/xSh3eXrKo9lB+Df834GGCkle+FxJfrjPvV0Y1XS0Muut0ig4
         5Lu4aBvuZ4zxEbr1JcXKchnvPqJPtugVXvp7Jjqn2eknWudEp/iidOmEcEX8uWDtSrSK
         YXBqlERm5yHChQVrUCluHcvQie+iRbBm8Cvk2e2JvQP33s0VYzThoaHv+bCu130DN9//
         vYB658egJRKZ3R2rJ2CPeWRNv7S7Yx5odSUoBHksP8BEHpAZBc2Tq+0ezo19zngVLe6y
         vMjg==
X-Gm-Message-State: AC+VfDx7Tl3XOvhuMJv+K98lnohYEOfSduT8VNa6y0HIX4Ov0Jbw4Wve
        MfPuwtCOYeUBMLaBLRbDqbfAUd5FZcHi
X-Google-Smtp-Source: ACHHUZ7Oj7PYMfj8umh+RnQOhnMUR+dcjSbU75/Urxl0UyXXlV6mPll8kv0KpVxT3g6YZTk5ZWmaJR+aRI3h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:d658:0:b0:bbb:8c13:ce26 with SMTP id
 n85-20020a25d658000000b00bbb8c13ce26mr9861677ybg.11.1687533039349; Fri, 23
 Jun 2023 08:10:39 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:10:06 -0700
In-Reply-To: <20230623151016.4193660-1-irogers@google.com>
Message-Id: <20230623151016.4193660-3-irogers@google.com>
Mime-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 02/12] perf jevents: Support for has_event function
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Support for the new has_event function in metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index af58b74d1644..85a3545f5b6a 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -408,6 +408,12 @@ def source_count(event: Event) -> Function:
   return Function('source_count', event)
 
 
+def has_event(event: Event) -> Function:
+  # pylint: disable=redefined-builtin
+  # pylint: disable=invalid-name
+  return Function('has_event', event)
+
+
 class Metric:
   """An individual metric that will specifiable on the perf command line."""
   groups: Set[str]
@@ -539,7 +545,7 @@ def ParsePerfJson(orig: str) -> Expression:
               r'Event(r"\1")', py)
   py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
   py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
-  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count']
+  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event']
   for kw in keywords:
     py = re.sub(rf'Event\(r"{kw}"\)', kw, py)
 
-- 
2.41.0.162.gfafddb0af9-goog

