Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831FC433FE
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 08:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B881B613B3
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 08:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhKGI5g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 03:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhKGI5g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 03:57:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74FBC061570
        for <linux-perf-users@vger.kernel.org>; Sun,  7 Nov 2021 01:54:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v7-20020a25ab87000000b005c2130838beso20844173ybi.0
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Nov 2021 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DajBIroFd0GsI1ullswibDzDkMFfTGKQsv9lOFR0ogk=;
        b=pxklLbl4JwVW35jW2MV9d7u+SUEh2eCzUJ3afRfDnQRr/T+niKQaTj3XeeXRUhc17E
         tdp4uKCZ/HZKrIOWNnl+qkZdD+5iU6n4tyGL/rGqtycRxsOwsOw0qBFb3kxrWupUoTmE
         vgr7tI7NX7JsJ0EdYtZqK2TpMaKnghUwlRK+ZsCaxxwnUnCaWCBgyjzfvo2KhFsvP78R
         BhU/esXS1zaaWUryxFxcP0O/LzwvcLylTUt5yVFjNFTJdBd6mFpFncaf+XXXHJtJ85xh
         VzDGM5/bB5omhtLGBaoRkwq9WH61BVyT1d6cF6LS0WSBXn0puAu0+ra2WpcGGp3PSVpf
         R9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DajBIroFd0GsI1ullswibDzDkMFfTGKQsv9lOFR0ogk=;
        b=V8LKC2GF5RO3BuZKBndn+o8dCbmXX/2qrQsGFiSkMWRdR315PliVm1Gaz7kpSftXXN
         9WvxxIhzziztkVeB11rXV4hcEk0TyZHz2FWGLI6NhqgVwSFwBDsL/tjbgg+6VAVL13ah
         y1IPdkx0YdpplhFBwWtYeHfKgjviQDlDDeX3rUP81kXBhsgSojqfmB0F5yhyVnZ31MXv
         B6LIE6412uJVi3wQWotPrakMMahATH5aogRZwfBjem8iM68RW5sMIGXGJN32iMc+G0K+
         8Hasol2HVE1zTWDi6AMb1WciB/kdSA+MznIr8fpmDHTsVX8AfwZues8i4xMmGX2Yvhkq
         QdRw==
X-Gm-Message-State: AOAM5311wKURFBUjQkTjH1cT4km9Ucj9YO5KCzedj0n+Cig+SxteTO8r
        Y8k/TNw1JSbCbKn3XusY25ITyQ+zHf+4
X-Google-Smtp-Source: ABdhPJx+2ONQ0CP6pqrI/JrEaktBIJRfxWudb0c33p+ZQC2Vuyx5Y6NYIFHuQMEAS5UUTCux5Mwpd6MIGaFO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:421f:fd78:d785:693a])
 (user=irogers job=sendgmr) by 2002:a25:bb52:: with SMTP id
 b18mr80637696ybk.506.1636275291759; Sun, 07 Nov 2021 01:54:51 -0700 (PDT)
Date:   Sun,  7 Nov 2021 01:54:44 -0700
Message-Id: <20211107085444.3781604-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] perf stat: Fix memory leak on error path
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Strdup is used to deduplicate, ensure it isn't overwriting an already
created string by freeing first.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 69f3cf3b4a44..e4fb02b05130 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -444,6 +444,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 						"Add %s event to groups to get metric expression for %s\n",
 						metric_name,
 						counter->name);
+					free(printed);
 					printed = strdup(metric_name);
 				}
 				invalid = true;
-- 
2.34.0.rc0.344.g81b53c2807-goog

