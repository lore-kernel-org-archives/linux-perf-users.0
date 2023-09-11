Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9300CCA0EC3
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Sep 2023 21:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbjIKV2F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243332AbjIKRGM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Sep 2023 13:06:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB1193
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Sep 2023 10:06:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5925fb6087bso49875877b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Sep 2023 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451966; x=1695056766; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B+1JF0nXPGoS/vVdsOZGIJs7CEBRG2VuSy9rJAtNprY=;
        b=5BE5OcUUXBss0ejL7AyeJWL0MVOiaWhzHM7YmpFVYa7AUDz/z26MI4nTsRql0+s5gx
         NmKvOyRNZc1KrLdWGpIxSKEawR2SLmZ+nCL014P9ikwZ78f3LN+PUudDS/hcz9op0EJy
         bBMWTDpVqmkdLkDmWwr7MK/CA7eXeg33zQaaimfrqdlPxs951euiwm9ByI0MMGnPekSa
         TVv84rz9pIQHh+v701zV153HB5a5Fpcsy2MDxLcO1EvrBQWJbHNYWtMOUslXGgD6c20b
         Dyygp2aZGAAMVddit4/ZSIaOIgN8tmT0uVbWvY5Cj8XXGs1tuOUb94UEPiUwzb5Nj2Hc
         WlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451966; x=1695056766;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+1JF0nXPGoS/vVdsOZGIJs7CEBRG2VuSy9rJAtNprY=;
        b=mHwITnkhB6qzdd5z3EWUxA6yAvPWizPr82kRGef1U6M5giYKPxCh/FVjxiMykxMEuK
         4GFaXMygA/aqLPMDMjvBFMH+pwikH2OjgSaChYTJozy8DfknYthoMrg3pPxWP4HzvTyS
         Rrse8+gjmeyM9jc4fjc2O115miqiI7kSNHTvjxFmeEAuFscIJy7tNU/pRANiujtjjKXP
         DVOLPyJQXJ7YogE7uHkDfhcGZW6dtdUOGeRVMGp0Yn1QDxJbWjelOfbh54X6uLOHo/o6
         f+pPJcaIA6RJYQXNEiQeVOcE3o46ScmDLtAYBqQpvozfU+Cu9rLrmwHCk+r5Wn3sq+Ly
         c+vA==
X-Gm-Message-State: AOJu0Yx46yM9cJ88n+nMEijDi5o2EhMfTl3FtamAfdsfpUn9R96jA9Zn
        pC9H9ecil4L9jN7wPh7fG/kImwhuIX8C
X-Google-Smtp-Source: AGHT+IEYi4t5k8LUPrFyZM7IByX5LTESJDfzfvk31cVZDMoClizybOgg9g6ptBh8r+jVlC5Vjlvh5W/Wtdhm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a81:d441:0:b0:584:3d8f:a425 with SMTP id
 g1-20020a81d441000000b005843d8fa425mr276417ywl.10.1694451966387; Mon, 11 Sep
 2023 10:06:06 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:05:55 -0700
Message-Id: <20230911170559.4037734-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 1/5] perf parse-events: Remove unused header files
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
        James Clark <james.clark@arm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The fnmatch header is now used in the PMU matching logic in pmu.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 21bfe7e0d944..ef03728b7ea3 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -9,11 +9,8 @@
 #define YYDEBUG 1
 
 #include <errno.h>
-#include <fnmatch.h>
-#include <stdio.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/zalloc.h>
 #include "pmu.h"
 #include "pmus.h"
 #include "evsel.h"
-- 
2.42.0.283.g2d96d420d3-goog

