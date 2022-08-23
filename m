Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C84C32789
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 22:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiHWWMo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 18:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiHWWMH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 18:12:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3477AC3A
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 15:11:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33580e26058so260642857b3.4
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 15:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=oBQ8fNk49ilPWpXTVU4R9YnuRnoXvu3xuE3Ff0vlliw=;
        b=ZtQXSc3nLMgidV0RkXHAnNfb+wLDHFqtJ2m2CLNTkr9/mk1Pb2lwWkDQDUIRWunlg+
         JiLUE2TGYDpGiLgCmsBuVaVEg1BcTU5heky1RUQMVhyxvVDnaw00zccMmaCPs8/Ydk3o
         RcGVndc2p39zpI5Ai5vGpaTxsKlv/L3zgINK+6jbONVRdMRxTmm28HFq9/6vHIJGzl+i
         c52JNYUJjH7z2noWJjC8TFLzblNOHBxhyqaYt3CPSgiJNGkZvPuxbWJPYQ2tYJL2kaAq
         uvEClhlGisibgw2+5AV1jT+xjgGe7vw33oSqWtBSsX3Rllh1pIbzBIeDCtsqXAgUpbuu
         PKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=oBQ8fNk49ilPWpXTVU4R9YnuRnoXvu3xuE3Ff0vlliw=;
        b=CAj9StygviFjsENVu9SphbUUEb8ZhOXsCReOZen8eiEeptP+MbNSp1WCasC7YvCnJB
         c6BHB+EyHwyvqhr/YmZfgpyGUOzTLnro6N96dYDkoFQUQEfom7UNox9ZRlWBkgvtAR+2
         P7iU30DJo2enCo2CvSED7xv7dykeia2VA7hMuf4H+vWZi/tRuf8UKkFFrtrvjRgpthJU
         iukkOEK2iJXfO5DyOFRk7itpim5SP6BG+UM/cL2IrWSr6bZsIaaKB0wkSjXUOnwtAjMl
         CgjoiqyMlsmwfz8cjUGRj34fuOKtME6dbarI8xq3zmEKsA7N5Kqg3CSawHYnlMzctmCl
         UfJw==
X-Gm-Message-State: ACgBeo0HnL+To2ItRi5c19mVRws6Nw76d2HN2jqo+pzPlNjf53WJY1SO
        tlHqzdoGlkmKoXs1nA4L/jIToMOk0rME
X-Google-Smtp-Source: AA6agR4b/l59aAfX2CCgdljg/llF2RNbdpziMN0iJsvjeCzIe3p/c4gad5OdNLA9Z/E64+34TQ87ZO+tJ3li
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a0d:dcc7:0:b0:325:314c:9a30 with SMTP id
 f190-20020a0ddcc7000000b00325314c9a30mr28547074ywe.121.1661292664801; Tue, 23
 Aug 2022 15:11:04 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:19 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-16-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 15/18] perf mutex: Add thread safety annotations
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
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add thread safety annotations to struct mutex so that when compiled with
clang's -Wthread-safety warnings are generated for erroneous lock
patterns. NO_THREAD_SAFETY_ANALYSIS is needed for
mutex_lock/mutex_unlock as the analysis doesn't under pthread calls.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mutex.c |  2 ++
 tools/perf/util/mutex.h | 72 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
index d12cf0714268..c936557d8bbb 100644
--- a/tools/perf/util/mutex.c
+++ b/tools/perf/util/mutex.c
@@ -40,11 +40,13 @@ void mutex_destroy(struct mutex *mtx)
 }
 
 void mutex_lock(struct mutex *mtx)
+	NO_THREAD_SAFETY_ANALYSIS
 {
 	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
 }
 
 void mutex_unlock(struct mutex *mtx)
+	NO_THREAD_SAFETY_ANALYSIS
 {
 	CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
 }
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 952276ad83bd..6c2062d41a4e 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -5,11 +5,73 @@
 #include <pthread.h>
 #include <stdbool.h>
 
+/*
+ * A function-like feature checking macro that is a wrapper around
+ * `__has_attribute`, which is defined by GCC 5+ and Clang and evaluates to a
+ * nonzero constant integer if the attribute is supported or 0 if not.
+ */
+#ifdef __has_attribute
+#define HAVE_ATTRIBUTE(x) __has_attribute(x)
+#else
+#define HAVE_ATTRIBUTE(x) 0
+#endif
+
+
+#if HAVE_ATTRIBUTE(guarded_by) && HAVE_ATTRIBUTE(pt_guarded_by) && \
+	HAVE_ATTRIBUTE(lockable) && HAVE_ATTRIBUTE(exclusive_lock_function) && \
+	HAVE_ATTRIBUTE(exclusive_trylock_function) && HAVE_ATTRIBUTE(exclusive_locks_required) && \
+	HAVE_ATTRIBUTE(no_thread_safety_analysis)
+
+/* Documents if a shared field or global variable needs to be protected by a mutex. */
+#define GUARDED_BY(x) __attribute__((guarded_by(x)))
+
+/*
+ * Documents if the memory location pointed to by a pointer should be guarded by
+ * a mutex when dereferencing the pointer.
+ */
+#define PT_GUARDED_BY(x) __attribute__((pt_guarded_by(x)))
+
+/* Documents if a type is a lockable type. */
+#define LOCKABLE __attribute__((capability("lockable")))
+
+/* Documents functions that acquire a lock in the body of a function, and do not release it. */
+#define EXCLUSIVE_LOCK_FUNCTION(...)  __attribute__((exclusive_lock_function(__VA_ARGS__)))
+
+/*
+ * Documents functions that expect a lock to be held on entry to the function,
+ * and release it in the body of the function.
+ */
+#define UNLOCK_FUNCTION(...) __attribute__((unlock_function(__VA_ARGS__)))
+
+/* Documents functions that try to acquire a lock, and return success or failure. */
+#define EXCLUSIVE_TRYLOCK_FUNCTION(...) \
+	__attribute__((exclusive_trylock_function(__VA_ARGS__)))
+
+
+/* Documents a function that expects a mutex to be held prior to entry. */
+#define EXCLUSIVE_LOCKS_REQUIRED(...) __attribute__((exclusive_locks_required(__VA_ARGS__)))
+
+/* Turns off thread safety checking within the body of a particular function. */
+#define NO_THREAD_SAFETY_ANALYSIS __attribute__((no_thread_safety_analysis))
+
+#else
+
+#define GUARDED_BY(x)
+#define PT_GUARDED_BY(x)
+#define LOCKABLE
+#define EXCLUSIVE_LOCK_FUNCTION(...)
+#define UNLOCK_FUNCTION(...)
+#define EXCLUSIVE_TRYLOCK_FUNCTION(...)
+#define EXCLUSIVE_LOCKS_REQUIRED(...)
+#define NO_THREAD_SAFETY_ANALYSIS
+
+#endif
+
 /*
  * A wrapper around the mutex implementation that allows perf to error check
  * usage, etc.
  */
-struct mutex {
+struct LOCKABLE mutex {
 	pthread_mutex_t lock;
 };
 
@@ -25,9 +87,9 @@ struct cond {
 void mutex_init(struct mutex *mtx, bool pshared);
 void mutex_destroy(struct mutex *mtx);
 
-void mutex_lock(struct mutex *mtx);
-void mutex_unlock(struct mutex *mtx);
-bool mutex_trylock(struct mutex *mtx);
+void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
+void mutex_unlock(struct mutex *mtx) UNLOCK_FUNCTION(*mtx);
+bool mutex_trylock(struct mutex *mtx) EXCLUSIVE_TRYLOCK_FUNCTION(true, *mtx);
 
 /*
  * Initialize the cond struct, if pshared is set then specify the process-shared
@@ -36,7 +98,7 @@ bool mutex_trylock(struct mutex *mtx);
 void cond_init(struct cond *cnd, bool pshared);
 void cond_destroy(struct cond *cnd);
 
-void cond_wait(struct cond *cnd, struct mutex *mtx);
+void cond_wait(struct cond *cnd, struct mutex *mtx) EXCLUSIVE_LOCKS_REQUIRED(mtx);
 void cond_signal(struct cond *cnd);
 void cond_broadcast(struct cond *cnd);
 
-- 
2.37.2.609.g9ff673ca1a-goog

