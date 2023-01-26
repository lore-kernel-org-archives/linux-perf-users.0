Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CA6C54EAA
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Jan 2023 23:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjAZXjW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Jan 2023 18:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjAZXjV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Jan 2023 18:39:21 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C433646C
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 15:38:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n194-20020a2540cb000000b008038647d9ebso3590535yba.5
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 15:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTYdmI9og0perxBFMnwOyD8JALYBo9fFqhvIGnAB7iw=;
        b=pN++yaxhHw5hsqtHgPMZeHJr1T+f83UqE4aoFtt5+LAeg4UHQo6kEIwVfN/W5KzpWd
         NAKHo1zdw7heZJbx1WfqGp1S+SxrOx8iQQEmdAlVDg2VTtwzUZXBX9I4nN6s/ySTc+jr
         3ZaRTEU2LdtjdBqC28mfYKA3RWWRWiipp0ubURRbSnB2td+dOXW6A6Z1YmXTTTs7lrMt
         kSSpO1HdzzSc0Io1imdV8ICez2HaQFT3vzJjPfo5xcK7Rc2m+quLXQ9DiPdQKhFDh9i9
         7D6enP4ZWLDUdi03ANNOdVpbRaEKQA7hGat0dQrO/F54JVVNV8CR5DwopbFxCgwL+Ylt
         8iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTYdmI9og0perxBFMnwOyD8JALYBo9fFqhvIGnAB7iw=;
        b=Q1vjxvFzznaY18nqADgFoFGOfP74eIUUIrXZNAs9AIHxNCrAP9ZxtMTIn8NiqRMPbs
         rUc0U/6stWwIGpR5UFwTF/bJNuGNlp6aAymifSKp9pTEZdAU4iI+WsU3HjCx+rRWxLnL
         1Jth1hLsatMNhoRV4/zrozqnMD884Ahz0VSpyys/a/smsh1ddRQkuIoDNKBgNGmkyoYx
         BhAZjfEyJhR4ypkIciP3oVvEUza1hpfiVFoUfIkpf4IOhhC/4usWTVw+76Pl7nsNEFj3
         j2sz5vwKrq6h4pVzO+gFY2KDTyPFPp8/98AILaMB+4TLGkmJ/UQqevxeGxgnZ5aBkJtF
         vYKA==
X-Gm-Message-State: AO0yUKXgf3LgrbjDHCzdYxSeSW8JizGqVQdPLtSAw/dKsBv321JnXKlb
        eU8dMR1lp/fkjbe71/V6febz0D7NoUel
X-Google-Smtp-Source: AK7set8ogChtzu8dxXsUiUpTxkmy4XJKX0fEnPVUFfp8yLVVlaZbFvMbbtXJs9Lil32EN+jbOQsVkSj+abRi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a25:ce90:0:b0:80b:6168:a831 with SMTP id
 x138-20020a25ce90000000b0080b6168a831mr1670207ybe.408.1674776313147; Thu, 26
 Jan 2023 15:38:33 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:43 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-14-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 13/15] perf jevents: Correct bad character encoding
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

A character encoding issue added a "3D" character that breaks the
metrics test.

Fixes: 40769665b63d ("perf jevents: Parse metrics during conversion")
---
 tools/perf/pmu-events/metric_test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index ced5998bd827..e4c792428277 100644
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -89,8 +89,8 @@ class TestMetricExpressions(unittest.TestCase):
     after = r'min((a + b if c > 1 else c + d), e + f)'
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
-    before =3D r'a if b else c if d else e'
-    after =3D r'(a if b else (c if d else e))'
+    before = r'a if b else c if d else e'
+    after = r'(a if b else (c if d else e))'
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
   def test_ToPython(self):
-- 
2.39.1.456.gfc5497dd1b-goog

