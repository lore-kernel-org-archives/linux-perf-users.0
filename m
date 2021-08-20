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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C36C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1294360FDA
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhHTKzc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbhHTKzO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809CC0612A7;
        Fri, 20 Aug 2021 03:54:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mf2so838548ejb.9;
        Fri, 20 Aug 2021 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bd4LxF7EfYOezAHRUDFne0+ypPECPvt4lGSARLhhTug=;
        b=hYLvT2+zxH+B8EYaj9FoIhzTTdIyHrP/uclgbEJJF1KdQF5NH7ZXoIYlZ0vip1QkdI
         hZW75vfAUDIFKadsniAC71O4TzUzBc4f4ISAQVKYplqzH6FFmpdfRwVrWGYVetMqxAuJ
         uHf9tt3fG9xjyWqfDf4TGHdJ5Zp1nBy9SL1rkCkM+fIbHu98XjKU3LpjH3bOB7gbS0DU
         Ci6QonQ4fU27NIHiJxfqsdBnpB/+eXvpOA6NPLWW2Yn/8tuMymUTlrF7b7/9Otp0rsY5
         C1lCQRlXWlhD9CQebICArF2yU9QDliqWWulCGZwvP43uILehQU2UhVoQldu8haNTPVEs
         ck3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bd4LxF7EfYOezAHRUDFne0+ypPECPvt4lGSARLhhTug=;
        b=saM2e3KLE9czhX8t4+kCkSyJho9YMD5thkhf7vu9UOnmXb3jVVcquwBuwvdfZJGfOZ
         PM4bNLxJ1TPKEcKy1/qrNpfzIal3PiXxvHidMpYZsnu+rtB4yeCQ8uwTcfZpxB3sKVOT
         icByccKDbK4X/JEqZlxw/Dwje4DO9qToVNvImwfbT4jtPCh3ncdNVXiOfOLjAMsv5CDs
         au6fJAOpC0Keu9EzvEeNlbkPnjcLEkiKfx1tt5assKhlT/2KYefj8L5pSg9AW/uQQyYF
         46lV7+nq+bpw5qFaGFGsot4LLoW2xJVQmX7NT0fDdy9Sr5B6f2VYndoOP8G8/sUUAttv
         GCSA==
X-Gm-Message-State: AOAM533ECPWUCi/ogmzZDiwKyqkf13Ni9gGxMaHrMkB2wQ4nLmvQiuXk
        i3utLlBCa4C4ocvJHQT33BU=
X-Google-Smtp-Source: ABdhPJwOPYvFFESBi+Fj1/yYBiyAtTi6fMLmOpR86r98AI6ATIoe7vmAyzoezbbY9z7rJ3gkPGzNWQ==
X-Received: by 2002:a17:906:cf91:: with SMTP id um17mr21455344ejb.490.1629456871059;
        Fri, 20 Aug 2021 03:54:31 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:30 -0700 (PDT)
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
Subject: [RFC PATCH v3 12/15] perf record: setup global workqueue
Date:   Fri, 20 Aug 2021 12:53:58 +0200
Message-Id: <3666b3e081d50de57d8669530eec59ed8be0c841.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch initializes the global workqueue in perf-record if
nr_threads_synthesize is set.

This patch is a preparation for using the global_workqueue in
synthesize.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-record.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 548c1dbde6c52ed6..4d7b610b1d0bb9af 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -49,6 +49,7 @@
 #include "util/clockid.h"
 #include "util/pmu-hybrid.h"
 #include "util/evlist-hybrid.h"
+#include "util/workqueue/workqueue.h"
 #include "asm/bug.h"
 #include "perf.h"
 
@@ -2894,7 +2895,21 @@ int cmd_record(int argc, const char **argv)
 		rec->opts.comp_level = comp_level_max;
 	pr_debug("comp level: %d\n", rec->opts.comp_level);
 
+	if (rec->opts.nr_threads_synthesize == UINT_MAX)
+		rec->opts.nr_threads_synthesize = sysconf(_SC_NPROCESSORS_ONLN);
+	if (rec->opts.nr_threads_synthesize > 1) {
+		err = setup_global_workqueue(rec->opts.nr_threads_synthesize);
+		if (err) {
+			create_workqueue_strerror(global_wq, errbuf, sizeof(errbuf));
+			pr_err("setup_global_workqueue: %s\n", errbuf);
+			goto out;
+		}
+	}
+
 	err = __cmd_record(&record, argc, argv);
+
+	if (rec->opts.nr_threads_synthesize > 1)
+		teardown_global_workqueue();
 out:
 	bitmap_free(rec->affinity_mask.bits);
 	evlist__delete(rec->evlist);
-- 
2.31.1

