Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7505C4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58A26103B
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbhHTKzd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbhHTKzP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E929C0612AB;
        Fri, 20 Aug 2021 03:54:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q3so13407825edt.5;
        Fri, 20 Aug 2021 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1TwEsY+qGtY8ZIip/DFmceb5xuwhe2EKlWEX/tGJMw=;
        b=NQILQJ+2ib6lfhp9n2EzNvSNDc4xaKPOpEZUkIuKx4mg3xD2DQwjO82lCcVpovp9YA
         tsaw77RHVtu2SqdNmu/uU8Rj1S6936P3Q+5SW9545KOMtpY076hBlPehSXDcOVkIb3UN
         7bWr1++r6Tya7pdDR7B6Um6j5TTR/tke3u7RMNj9nDU12H/1CRmRC60C7GtoagtIQ5Ps
         fDyphi7hVDOC6yfKgsoZANfQ4FwI72C5EwGVpsxcRFlqn3njVsem6Dxn1oebnkG6gQCq
         WBUS+yOFlB/RXpLpb7FHBhoycxv4fiZUOT7EhHFmclga9RHrl+rZ9csznTR0ns35KuBd
         4Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1TwEsY+qGtY8ZIip/DFmceb5xuwhe2EKlWEX/tGJMw=;
        b=fmQUYmbFhJA1soyrRsrhmKYaACvGP285/2mhba8HnvmqGa4qlsfqgpOgKbSXV6IAsM
         zNJOZg+bVUiJfNlpfgdsSEEQZ2+Uu3lrFRU57DEYNF9/+WNAcQeexxZLRWQ+j4ufQ5A6
         7HC1zDPM9abreFGf1V+dwLIT2oy56G/7aChyiE6usqsh2aUAn07UjTxhex0JzoIkv7oH
         Ic0sBrkroHRMO6WU7kuCBh14SoQFvYc1qicdrmD3Uk/U+zooWtQwr8FuBalBLVROyrTC
         L0NsLu1S+ar7VCj1Phym4jZ2iyoq66ed+IjGUA5CKGWQMVeHbt5WFtkSTLcCUp1CeSs9
         TB5g==
X-Gm-Message-State: AOAM530AIv6WnexoNHyCoYzbfUfvbgywdZtoLLXz4cWWDmgqKRfdWl2w
        gG7v5LAVU4U8foicYNP6O3c=
X-Google-Smtp-Source: ABdhPJx33haKToY8EqmPr3rBdIMbiXADjzt7Mcw2VsSURM7b6lbUA++8T6q+eUt4OG/C2fUfXmPkgw==
X-Received: by 2002:a05:6402:d49:: with SMTP id ec9mr21424736edb.333.1629456872597;
        Fri, 20 Aug 2021 03:54:32 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:32 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v3 13/15] perf top: setup global workqueue
Date:   Fri, 20 Aug 2021 12:53:59 +0200
Message-Id: <331e87d881040594673af3399a8b925442fa46d2.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch initializes the global workqueue in perf-top if
nr_threads_synthesize is set.

This patch is a preparation for using the global_workqueue in
synthesize.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-top.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a3ae9176a83e2453..9b4f220920780a95 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -49,6 +49,7 @@
 #include "util/term.h"
 #include "util/intlist.h"
 #include "util/parse-branch-options.h"
+#include "util/workqueue/workqueue.h"
 #include "arch/common.h"
 #include "ui/ui.h"
 
@@ -1767,8 +1768,23 @@ int cmd_top(int argc, const char **argv)
 		opts->no_bpf_event = true;
 	}
 
+	if (top.nr_threads_synthesize == UINT_MAX)
+		top.nr_threads_synthesize = sysconf(_SC_NPROCESSORS_ONLN);
+	if (top.nr_threads_synthesize > 1) {
+		status = setup_global_workqueue(top.nr_threads_synthesize);
+		if (status) {
+			create_workqueue_strerror(global_wq, errbuf, sizeof(errbuf));
+			pr_err("setup_global_workqueue: %s\n", errbuf);
+			goto out_stop_sb_th;
+		}
+	}
+
 	status = __cmd_top(&top);
 
+	if (top.nr_threads_synthesize > 1)
+		teardown_global_workqueue();
+
+out_stop_sb_th:
 	if (!opts->no_bpf_event)
 		evlist__stop_sb_thread(top.sb_evlist);
 
-- 
2.31.1

