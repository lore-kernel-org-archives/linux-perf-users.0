Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0954FC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Apr 2022 20:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351813AbiD1Ucg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351820AbiD1Ucf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Apr 2022 16:32:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F843C0D2F
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 13:29:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7eaa730d9so56959847b3.13
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=bO37AFCpe1/E1wIgqlJlZti6Su6aZgapKCGNNQ0qvyY=;
        b=YtNmFiAHUlm9kDuzzsMam1KjATnxi4mjsWWlVSXCASDjopMVUgmqOXfxYU3WqjrWuo
         HJPp2c0g0UkuQK5RLYoBxkQhZWbFc1d0/8YPiQb7/JVzTCwUjqUXlMHcp7G36RNx/XUg
         7epg9i5/xrzLJCoOGOd8srdk68bGJoAZIsVB8mJiIhGM4WXjS7xwM3WkXbklqhq6hyla
         HcFyqNhMhTeuzinC0xn3CEgbCESJ54nDVn2SMzdYNtDzwzEnRe7g6y0yiC9WHbHpmUw+
         Tr9uas6Fas17VppW9VSX9V/A6rDkc11sSFYzHpkuxw6wY1le+WXZzjg+JMjdA2QTcI8y
         rqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=bO37AFCpe1/E1wIgqlJlZti6Su6aZgapKCGNNQ0qvyY=;
        b=NH6DhIvG5Vx1mvL7ddkUK86uDM90v/8wgs4qrMrxlm6/qTIxCMRX3w6vKDGo2uMl8P
         xXPDrrKn+EB8fr6VLrOcIIWpg1rmT4cNUxY3lWPkubqqQex51ZnkPcM15UqqunGb+Rv8
         2x7GCcBHtxgKQJ98HvDq7r3qwzeFOG9nOiulHEiuxQHxB9ojiUcN0xGTz3UvgN898qp/
         YggGbStmNzQZktqgH4QCJLL0bce8nt7onJwRsGQ1Quk11pUMdtjO9aWTowM6J7+RvjRV
         E0RJuNuAHbGaeMEhUqRoYmcwwl0Sl1Y+G1ubDNR0mJrolqj9l8Dq38l/RAa5nGmI2SC3
         qK3A==
X-Gm-Message-State: AOAM530LH4RoRfR7VzlSO76d2WkEu9inGhV9K2jnRvQx9MOSRYSImEas
        5E7wAFcbQic3OGPeT3AyizCU2/A8FK6l
X-Google-Smtp-Source: ABdhPJyGVJ7PjGpPvXxm9zgkSvmK9qcOgX2lV9sz3ErQQnYDkU2b+aDsJqp6yFxFeq1vIJNtLvcm0BK8o9gQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3c33:ed69:1770:973e])
 (user=irogers job=sendgmr) by 2002:a5b:cd:0:b0:63d:ab85:a6f7 with SMTP id
 d13-20020a5b00cd000000b0063dab85a6f7mr31688296ybp.290.1651177759300; Thu, 28
 Apr 2022 13:29:19 -0700 (PDT)
Date:   Thu, 28 Apr 2022 13:29:12 -0700
In-Reply-To: <20220428202912.1056444-1-irogers@google.com>
Message-Id: <20220428202912.1056444-2-irogers@google.com>
Mime-Version: 1.0
References: <20220428202912.1056444-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 2/2] perf vendor events intel: Add cpuid for sapphirerapids
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fixes compile time warnings:

pmu-events/pmu-events.c:27238:31: error: =E2=80=98pme_sapphirerapids=E2=80=
=99 defined but not used [-Werror=3Dunused-const-variable=3D]
27238 | static const struct pmu_event pme_sapphirerapids[] =3D {
      |                               ^~~~~~~~~~~~~~~~~~

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 963a76fec277..4b47ac1b806d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -41,6 +41,7 @@ GenuineIntel-6-A7,v1,icelake,core
 GenuineIntel-6-6A,v1,icelakex,core
 GenuineIntel-6-6C,v1,icelakex,core
 GenuineIntel-6-86,v1,tremontx,core
+GenuineIntel-6-8F,v1,sapphirerapids,core
 GenuineIntel-6-96,v1,elkhartlake,core
 GenuineIntel-6-97,v1,alderlake,core
 GenuineIntel-6-9A,v1,alderlake,core
--=20
2.36.0.464.gb9c8b46e94-goog

