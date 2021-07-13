Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1314C11F67
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860F6610D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhGMMOa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbhGMMO1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6215C0613E9;
        Tue, 13 Jul 2021 05:11:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f9so24505455wrq.11;
        Tue, 13 Jul 2021 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzJvn64GuVocrnD1XoP9dZWXdMIrLWE/L8xn1sXzEeI=;
        b=OxqcifLaScke4f2YQblfHkQW8pHpHTd0Q6NqWm8rddEsJN/4mxspYQpzGNA+SebrZU
         cQidDY4CI8BpPyp6M8h5tS0AQjjgUor8+/Vw/lZQly0wmVBi0JkkQM04CIYjLtW8Ao3+
         vVWTsoA9076w9xRYf57SQevtNMMhs2dp9xk+Ycg5BIOzRKeZCd5oHCkk2KmIfedqecUi
         +0mFGKad+U+UUq9gZnxeGT04SILC/WdeJyPE3GKL2UI8lQCrDfVWJI21vkE2ILiGKPFS
         3wt2ZplKwKZT9/ctv3H5dS83N+g06BeGZujsv6sDKBasaNffDs5xcfcHO/X76SkoDJiM
         XoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzJvn64GuVocrnD1XoP9dZWXdMIrLWE/L8xn1sXzEeI=;
        b=hqeQU6p4Dw/SaRYqGtfTTdNpSkNyMvQ6oAtCwAiTjgZ+uPoq4GkRkDlNf4QlniYRDJ
         VGlRLGKjHVqk1Gy/xTVSQuuLyI4P4FqEzPAEPIAxWOYK5E5vv3QyoAbtbZTb9EmG3FFJ
         fhh5VUo8BS0+pYv+2uA1+mEpPleiPaVy4r1rQ3bJl98Y73825Y1NODgn39W+7EJQ3gEq
         ex4eWWm/yxeR4UEln3VMGmmhC6G/VA6PyGiSa9EWKxCz4esT5EhiehNLH6YpUQTzrrto
         QPYp9CmP7ZrREmwRnIOKZCEhbh1I81WF9PycrgK8t/41CHMtx1ioty2yCYoJySZiDnEP
         rcYQ==
X-Gm-Message-State: AOAM530fCeT54Yk0oCpko/mXgGGXJDbbeOtisqoWWWB75uD7e3T4Jfqz
        xeJMc4qR48QHBE5HEKq9U0w=
X-Google-Smtp-Source: ABdhPJzcfig1KgcU/nPLA4oq3WUsr6xs7Nxg//CB8b5JyuwwsHXMosCZVFlqPJfDyPZGCU56+K82Cg==
X-Received: by 2002:a5d:5102:: with SMTP id s2mr5314252wrt.214.1626178296428;
        Tue, 13 Jul 2021 05:11:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:36 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH 05/10] perf workqueue: add sparse annotation header
Date:   Tue, 13 Jul 2021 14:11:16 +0200
Message-Id: <1d27bcf0ee7ba61850b4297318241bc07ba06e07.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds a simple header containing sparse annotations.

TODO: what is the best place to put this?

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/workqueue/sparse.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 tools/perf/util/workqueue/sparse.h

diff --git a/tools/perf/util/workqueue/sparse.h b/tools/perf/util/workqueue/sparse.h
new file mode 100644
index 0000000000000000..644f6db8f050ab50
--- /dev/null
+++ b/tools/perf/util/workqueue/sparse.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __WORKQUEUE_SPARSE_H
+#define __WORKQUEUE_SPARSE_H
+
+#ifdef __CHECKER__
+# define __must_hold(x)		__attribute__((context(x, 1, 1)))
+# define __acquires(x)		__attribute__((context(x, 0, 1)))
+# define __releases(x)		__attribute__((context(x, 1, 0)))
+# define __acquire(x)		__context__(x, 1)
+# define __release(x)		__context__(x, -1)
+# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
+#else
+# define __must_hold(x)
+# define __acquires(x)
+# define __releases(x)
+# define __acquire(x)		((void)0)
+# define __release(x)		((void)0)
+# define __cond_lock(x, c)	(c)
+#endif
+
+#endif /* __WORKQUEUE_SPARSE_H */
-- 
2.31.1

