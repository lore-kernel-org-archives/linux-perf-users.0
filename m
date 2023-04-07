Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23686C76196
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 Apr 2023 23:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDGXEk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjDGXEj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Apr 2023 19:04:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934C9E05B
        for <linux-perf-users@vger.kernel.org>; Fri,  7 Apr 2023 16:04:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f66-20020a255145000000b00b714602d43fso43847884ybb.10
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Apr 2023 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680908678;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=59paec+IWSQBz2L9CjqeP22mRhkSxyuTil9toZzz+2E=;
        b=jlZb9danWvv+ixJf3PU7oMdPaoWTKji9N1XTbeOIi2Q4zCMVso1x0EQEF0GmrJFyqw
         /eBDqunf5xCemE7/Ccz8arnTjRSY6aqbJBDdXMN4PpMDNgMzY+dlKb7HClsohYGHS6y9
         O8h5Q+X52uCBkRUwtyv0V80QU+dKa9YX+3Ot6UIS5oqzHZwJaYIsX76zjlRhRlr/QqzN
         WIivivWJL0jCQVgm9BV+51EMoC0akd0CxnxSdP86HYvW/brazjK+M1zDraRKi0G2RKpq
         PWcOiNPXSywqsFJVZHpFdyKJBTo4kEV0ykNE10v7Z13dDJxEqjFu7KBJt7nwTSxO2GWs
         lUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680908678;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59paec+IWSQBz2L9CjqeP22mRhkSxyuTil9toZzz+2E=;
        b=e32fmKWrN8BYcyS/4q2uDG9AG+G2Gae4YzPXNcij1mXZ6lm1Ut2V0Fj6Oic8LR+ExP
         4n5wIJn9+OWRfHNdJVYcDEWj8Y19MhHBiCIf7l/chIgy8LSH8WMYK5M7KdvxwdnJRYPX
         aoJQo2De4epVBTjhN9i6KH1pZqCWOpHvwCKUv0ieTwxWHM4cWlFxcV5LvOvLHNA3RQeW
         5aD5u1EEJVsvnPBAgNZfCG5KwqK4/m2C6hBFGuYFhsoxPJiuy2wQp0ot5kD9lWDcXHSY
         lra5j9GdLZ+4Yd2/wjTm6rR+PkD2WTZABEJOjOJJFiXvXccYXaZGOmZB+c2T1CsAiZy2
         abng==
X-Gm-Message-State: AAQBX9cCINzCWNKF2UqOgJYt621ULWPotDADFYqpveLO+fGv2PT1EvbO
        79Jtf074m48SWbOneRReJVlGk9XsoKHG
X-Google-Smtp-Source: AKy350bKg/Da1VLiNEVJ2OJM6u7YBHcM9+S2I35CQPhyi/mADelAipjwwpcBKwDi+gl/5RcsJ4RaXJ0uPV/4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b240:9cdf:7861:b23e])
 (user=irogers job=sendgmr) by 2002:a25:cbd6:0:b0:b6e:361a:c86 with SMTP id
 b205-20020a25cbd6000000b00b6e361a0c86mr314698ybg.3.1680908677793; Fri, 07 Apr
 2023 16:04:37 -0700 (PDT)
Date:   Fri,  7 Apr 2023 16:04:01 -0700
In-Reply-To: <20230407230405.2931830-1-irogers@google.com>
Message-Id: <20230407230405.2931830-2-irogers@google.com>
Mime-Version: 1.0
References: <20230407230405.2931830-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v7 1/5] libperf: Add reference count checking macros.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The macros serve as a way to debug use of a reference counted struct.
The macros add a memory allocated pointer that is interposed between
the reference counted original struct at a get and freed by a put.
The pointer replaces the original struct, so use of the struct name
via APIs remains unchanged.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/rc_check.h | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 tools/lib/perf/include/internal/rc_check.h

diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
new file mode 100644
index 000000000000..c0626d8beb59
--- /dev/null
+++ b/tools/lib/perf/include/internal/rc_check.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __LIBPERF_INTERNAL_RC_CHECK_H
+#define __LIBPERF_INTERNAL_RC_CHECK_H
+
+#include <stdlib.h>
+#include <linux/zalloc.h>
+
+/*
+ * Shared reference count checking macros.
+ *
+ * Reference count checking is an approach to sanitizing the use of reference
+ * counted structs. It leverages address and leak sanitizers to make sure gets
+ * are paired with a put. Reference count checking adds a malloc-ed layer of
+ * indirection on a get, and frees it on a put. A missed put will be reported as
+ * a memory leak. A double put will be reported as a double free. Accessing
+ * after a put will cause a use-after-free and/or a segfault.
+ */
+
+#ifndef REFCNT_CHECKING
+/* Replaces "struct foo" so that the pointer may be interposed. */
+#define DECLARE_RC_STRUCT(struct_name)		\
+	struct struct_name
+
+/* Declare a reference counted struct variable. */
+#define RC_STRUCT(struct_name) struct struct_name
+
+/*
+ * Interpose the indirection. Result will hold the indirection and object is the
+ * reference counted struct.
+ */
+#define ADD_RC_CHK(result, object) (result = object, object)
+
+/* Strip the indirection layer. */
+#define RC_CHK_ACCESS(object) object
+
+/* Frees the object and the indirection layer. */
+#define RC_CHK_FREE(object) free(object)
+
+/* A get operation adding the indirection layer. */
+#define RC_CHK_GET(result, object) ADD_RC_CHK(result, object)
+
+/* A put operation removing the indirection layer. */
+#define RC_CHK_PUT(object) {}
+
+#else
+
+/* Replaces "struct foo" so that the pointer may be interposed. */
+#define DECLARE_RC_STRUCT(struct_name)			\
+	struct original_##struct_name;			\
+	struct struct_name {				\
+		struct original_##struct_name *orig;	\
+	};						\
+	struct original_##struct_name
+
+/* Declare a reference counted struct variable. */
+#define RC_STRUCT(struct_name) struct original_##struct_name
+
+/*
+ * Interpose the indirection. Result will hold the indirection and object is the
+ * reference counted struct.
+ */
+#define ADD_RC_CHK(result, object)					\
+	(								\
+		object ? (result = malloc(sizeof(*result)),		\
+			result ? (result->orig = object, result)	\
+			: (result = NULL, NULL))			\
+		: (result = NULL, NULL)					\
+		)
+
+/* Strip the indirection layer. */
+#define RC_CHK_ACCESS(object) object->orig
+
+/* Frees the object and the indirection layer. */
+#define RC_CHK_FREE(object)			\
+	do {					\
+		zfree(&object->orig);		\
+		free(object);			\
+	} while(0)
+
+/* A get operation adding the indirection layer. */
+#define RC_CHK_GET(result, object) ADD_RC_CHK(result, (object ? object->orig : NULL))
+
+/* A put operation removing the indirection layer. */
+#define RC_CHK_PUT(object)			\
+	do {					\
+		if (object) {			\
+			object->orig = NULL;	\
+			free(object);		\
+		}				\
+	} while(0)
+
+#endif
+
+#endif /* __LIBPERF_INTERNAL_RC_CHECK_H */
-- 
2.40.0.577.gac1e443424-goog

