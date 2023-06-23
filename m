Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AAAEB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 00:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFWAdt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 20:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjFWAdl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 20:33:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D78A2105
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 17:33:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb2202e0108so106352276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 17:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687480419; x=1690072419;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbVKkaPWXAVNKNh1CW8R2oY532WwWiXP5nT3QKlBBnU=;
        b=AdZj95gn/6aKGa5/KrKdIrcRgLHwI7xGlA7gkFnioFB6Mkp3qh01STRcC6TkWd2arz
         RR5eal7q3bARX28UG8/zf7JX2q2tmHG1EMpLl+x46y1y+Zyi51pAaM2tNvdKwPls3Fbv
         3U8iROKcwq58bF588NdLWbbGKxKrKBhc6+oIanUDWqvPQksYtzAIBVsrUy4Ngyh46Ss8
         KlUiHLSgypuVEHA2w7sdsrwFyNL3HfqgIDZBsV43/lDBkIlD79MYlAEhJoUDTXUaJwGE
         IOyL9XBiJ0fCvjnQY+iAZncz4GLB9Pav3j3G0C+Esyipcb2sT3aXRCTjSCW56ThCiXyp
         SkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687480419; x=1690072419;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbVKkaPWXAVNKNh1CW8R2oY532WwWiXP5nT3QKlBBnU=;
        b=Yhz0VACuQ05EH34dniz4V2ikYiLmN1tFO5OGIAuNS6SedFs5hwMYZvt4ro7eeUY2mZ
         9rM8euoiMg+PsQ4bJl5/1tW6QsFmLVpuwVkRMl01f1twBU6O0bOFhTBVgs1JsEW17Nn3
         Yp8vXDZJmPz+k1jXzPRcGEZWHHp0r/QO1uo3p5+k+6JBwPkhbbCmEIW9oOqijuXktX9F
         P5Nido4kEYwmCPNaaDnti6wji6/c7Fgv3OdKK1yAB5XoUdecQTzFo2IfXXJnrVtWbt+O
         fNmVq7lmTvD/G5JAFctijvcYJgfRazEc7vEgILb0TTkpesawDvwFAHZ8CSYtWF9vkpY3
         dqVQ==
X-Gm-Message-State: AC+VfDxvusL5g9T13I0zSff6XpiigVOTOGAv0RFgafpwm3ngd75VM3YP
        Y7zbCBsHXKLEFt7reIUgpIfPH6X4jZ+c
X-Google-Smtp-Source: ACHHUZ6OJjD/teA9FBh+MFiVaUrzMx+E2xx2BI4tAwweZAbRn/r2rD6fOAUB3scwLjT71V+K06EFs3vEs4pt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a05:6902:1363:b0:bea:918f:2ef6 with SMTP
 id bt3-20020a056902136300b00bea918f2ef6mr2524024ybb.0.1687480419806; Thu, 22
 Jun 2023 17:33:39 -0700 (PDT)
Date:   Thu, 22 Jun 2023 17:33:02 -0700
In-Reply-To: <20230623003312.3981075-1-irogers@google.com>
Message-Id: <20230623003312.3981075-3-irogers@google.com>
Mime-Version: 1.0
References: <20230623003312.3981075-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 02/12] perf jevents: Support for has_event function
From:   Ian Rogers <irogers@google.com>
To:     eter Zijlstra <peterz@infradead.org>,
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

