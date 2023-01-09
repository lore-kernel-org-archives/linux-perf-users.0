Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB17C54EBD
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Jan 2023 20:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjAIUev (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 15:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjAIUet (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 15:34:49 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E319625EC
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Jan 2023 12:34:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b196-20020a621bcd000000b0058a63dc105eso159248pfb.6
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2023 12:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHhCz4k6MsqFldWGTt35hGeLdTBertltyGAk8DkitQI=;
        b=jYreWH3G8qj8aqLI2lf2fojvZ1VbNj626aIjavkpLCvO0HobsS7JXqXnaJI+xr+DL2
         D6r06OX4moENxNPfWztM6ExFvIWlwX19QTFwl7izchuAdcEpyvhIGQ4+wuDlN6NfePKf
         Sx1p9CGyBRPgtBal6aqpiqUF4+PPgboVUxnv+ha4A7fWoL7RyVxRe70QOeLBkeGwaZY4
         KQlctpFPDPKMZX5uoc3ALB1Hi5plVOwuSqDre0tG6b67mSnZigwASw46MPZu8Lbd5XxZ
         WvsOZwmrEsZjLvYvnTam4OKDbZvtYUA2R/uP6EkmwOei0TNH+/RMfzFON69/IJKklj0R
         ij0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHhCz4k6MsqFldWGTt35hGeLdTBertltyGAk8DkitQI=;
        b=XUSO0LNcfrjZV4MpKqc9gNOYQjEWUXEiZtEbac5hIkxMrfuTri1q0gJHt/A1xWmiSk
         Fd8ROJNwSB/4Tp74Ho5PXkt7A+4qYa6Kjw4tmc939brB9lUdBaMhbKLvaMcLl7uJ0YXg
         WqvaDe7LXGWNM34CpayVA7kwEAGOu1auysEHka5JsLdQ+ISCDRV+siEilrQWitQL6NpZ
         jk7jkoQRgovZ2XawF5+JBuOO8ZpJx5iz6VFVn4CvrVEvyUKHE9mZT2vY3hZkyLiW/OFu
         x+qyO6NGW9WDwr6y8bTuYKDVot0OaEw7jtAle6nk6RtQsf52mwMg6aNQK6YSfVz7fbI4
         WJyQ==
X-Gm-Message-State: AFqh2koJgZ8RzA8R4cgNbJ4TtfidEYdkvQAPngyBTRKUUbyoyKH52jtb
        1rvTpe8RKedUA7+bJg6r/W0yi4HrYlE5
X-Google-Smtp-Source: AMrXdXs1O1fjJcR30MwySho6lEMCVpl+i5Ji3yBimHJYNI3s7IvRm6tM9nux2BLY7FVot98H2Y7lwHEtFRNw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:59e7:81ad:bc43:d9dc])
 (user=irogers job=sendgmr) by 2002:a17:90b:1002:b0:226:9980:67f3 with SMTP id
 gm2-20020a17090b100200b00226998067f3mr156078pjb.1.1673296487423; Mon, 09 Jan
 2023 12:34:47 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:34:22 -0800
In-Reply-To: <20230109203424.1157561-1-irogers@google.com>
Message-Id: <20230109203424.1157561-2-irogers@google.com>
Mime-Version: 1.0
References: <20230109203424.1157561-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 1/3] tools build: Pass libbpf feature only if libbpf 1.0+
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

libbpf 1.0 represented a cleanup and stabilization of APIs. Simplify
development by only passing the feature test if libbpf 1.0 is
installed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/test-libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/build/feature/test-libbpf.c b/tools/build/feature/test-libbpf.c
index a508756cf4cc..cd9989f52119 100644
--- a/tools/build/feature/test-libbpf.c
+++ b/tools/build/feature/test-libbpf.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <bpf/libbpf.h>
 
+#if !defined(LIBBPF_MAJOR_VERSION) || (LIBBPF_MAJOR_VERSION < 1)
+#error At least libbpf 1.0 is required for Linux tools.
+#endif
+
 int main(void)
 {
 	return bpf_object__open("test") ? 0 : -1;
-- 
2.39.0.314.g84b9a713c41-goog

