Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC6BFA373F
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiJXT63 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiJXT6H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:07 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0251CF57D
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:20:49 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id k16-20020a170902c41000b00184987e3d09so6901942plk.21
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JoX+rXrU6K8JU7iZ2f6KugPkmXCVMdf9ZXNzq+WXZng=;
        b=PfDJLEVQTdoSZljLCftkKuXa4vHopLYHW+Zs+nAdnw9TlLOLf0h8zJ4UAoR/va/HTR
         sHI5mvAdv8WI9Esx2Hjez50/j5mBeOzp1EIRDJljrTzVizQiItYexTMX21rnSWlM11lQ
         z0ASHmhiCbvWXv+tdJ/n8B/rCosqMKyI+ttlXWe54G0sQsvhwzvMffRPFfuukJXfiSEW
         EF64a1r4+3KyRVosZ80wWMwumtN1UytVZRSLR8sB9lzHxQaMtG5msBH27OC97WnwY6vl
         jmojGGz0FWrjFDgGqxYlqab+Iigjjw1wJkiKE31bCXFqLRU3r7rx59vEFgTvD/vxguQ9
         qzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoX+rXrU6K8JU7iZ2f6KugPkmXCVMdf9ZXNzq+WXZng=;
        b=tnpq0rISGZa1cC6bkbq1j2nUJfSnlio+itbF+SVp4fEQBd/gsglzkGhQQqBujOw8mY
         sPoMeceYxNmIFBVTqjPDSoAkGcFelSHvj6A3SEUS3dQ6chKatwuehOiU7s7iF20MmoSU
         e8ua52/LM+sLzlpuADoALrtV/RMoUH0kf02+oze/pu3+R0S+ez3YmgfbgcEfRiU2t8cW
         FEij83TtujURViRC0gU/yeuTmikuKW6wWeOO3gjkBlCpr1BdOE+/NSKehtUvLC360bYv
         R/G3ca84iRzWnpbtD4vMj+R/Ou0Ec4rO//QT+Atq1039dyqtlDcTpcTn+KAgC0kUSOtq
         f7qQ==
X-Gm-Message-State: ACrzQf18mxbXorpA8sYyy3SKQvVlW80pEgbXeaK7g2F4N2T6i6hyk0Si
        e0876eFmonBzYLMWHzwBVCwvhb3f5/xy
X-Google-Smtp-Source: AMsMyM5rcWqWlK0OCIxzqrI1ljMyKEHeEueoBjrUw/oTrsAAhxhIPmRXnVUrh/WArpGokhdgHKMqS+NJSdm/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90a:5892:b0:20a:9cf5:c13c with SMTP id
 j18-20020a17090a589200b0020a9cf5c13cmr75024424pji.63.1666635598568; Mon, 24
 Oct 2022 11:19:58 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:08 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-4-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 3/8] perf daemon: Use sig_atomic_t to avoid UB
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use sig_atomic_t for a variable written to in a signal handler and
read elsewhere. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 6cb3f6cc36d0..aaa47d721ae7 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -105,7 +105,7 @@ static const char * const daemon_usage[] = {
 	NULL
 };
 
-static bool done;
+static volatile sig_atomic_t done;
 
 static void sig_handler(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

