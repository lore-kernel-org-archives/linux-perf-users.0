Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419B4C77B73
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Apr 2023 17:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDTRSe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjDTRS2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Apr 2023 13:18:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0743C44AE
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Apr 2023 10:18:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-555d8c556faso27388887b3.5
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Apr 2023 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682011104; x=1684603104;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YdIqMyPsEr0gHs4l/llP+kkiN7mlxuAb3vlVBqEI0dg=;
        b=VZBVK9Wk4NuIbFIFJxytyMlkljzYTpCwXmlMNhlTQJBgio03D0Ga6j7Vaa0Qh64f8q
         9ioPsZhH1NMX7ra+cqxLo5JZ/T4/t6XHcdMhnH/c/f8c11+7yt4NKZViQiO1trsLhwGi
         f/lJsZEiiUtlkkiXQQFn35RH9zMlWIMr9T80uN3MMIx2zMx+MbblSYD0Bv/AgeEnKJN4
         HV3iICnx3TISDRfQQRINqpOjKDpGK7Oq7TVnZP/WEAIvyz0B+gs1VeJmjcpahmsCpb0S
         FPHr00arqpKItk3RKnD+AhfK3QDtXeMt7jHDof5rgrbJyznuNxkcYafMsFMmQNcAEvFm
         ZsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011104; x=1684603104;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdIqMyPsEr0gHs4l/llP+kkiN7mlxuAb3vlVBqEI0dg=;
        b=PRIvlomrHg/G51z4mYYW0g/+9oah+dI+auJBZiUfxeFC/41a1dr/Ezc24GLUL02DUr
         pxFVY5T//xOLlhfmkxQcVDA7w59aGiUmgODkB5QOE1+7ZCB4DvHUlShxVL+++ry4yA3M
         wPXnUf0RUrf19IALfmI66RpuxI1ci0orSV5stSIXKVdHRdkae0fObzgUqSdPVR6CTDTm
         S4zbD6QMtxJJVE27oY0ebHGjtEmEjdOOoC9jgbK+YrFJUQZ0JeYt3QV2vNYc7bFCHxTB
         vG0n/yxio2WI+6ORdYeCDdTy9abAvLzn9rWx2mtN8GFMZ1NrS/Rw2WJhWj48MUjheaVj
         zP/A==
X-Gm-Message-State: AAQBX9eMxxKV1rd5EsULmAxkwOMu6WssBnd1t52ZD1suQfV0hh8Esvsq
        yf3/vaP9Se6jfA5m8TfTDURzsUkIXHdP
X-Google-Smtp-Source: AKy350YCsMObkz9XUCyBTT8b9NxzuVD1AGbQwwdZ2MIHTkJGkMlbZEVeV1X6z7bNzUnxUrlqxy4evNWM4NvG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2265:b6ce:fba4:80e6])
 (user=irogers job=sendgmr) by 2002:a25:76d1:0:b0:b76:ceb2:661b with SMTP id
 r200-20020a2576d1000000b00b76ceb2661bmr1502922ybc.3.1682011104229; Thu, 20
 Apr 2023 10:18:24 -0700 (PDT)
Date:   Thu, 20 Apr 2023 10:18:12 -0700
Message-Id: <20230420171812.561603-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Subject: [PATCH v1] libperf rc_check: Enable implicitly with sanitizers
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If using leak sanitizer then implicitly enable reference count
checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/rc_check.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
index c0626d8beb59..d5d771ccdc7b 100644
--- a/tools/lib/perf/include/internal/rc_check.h
+++ b/tools/lib/perf/include/internal/rc_check.h
@@ -5,6 +5,14 @@
 #include <stdlib.h>
 #include <linux/zalloc.h>
 
+/*
+ * Enable reference count checking implicitly with leak checking, which is
+ * integrated into address sanitizer.
+ */
+#if defined(LEAK_SANITIZER) || defined(ADDRESS_SANITIZER)
+#define REFCNT_CHECKING 1
+#endif
+
 /*
  * Shared reference count checking macros.
  *
-- 
2.40.0.634.g4ca3ef3211-goog

