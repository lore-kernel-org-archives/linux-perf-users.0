Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599B2C858
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="meDc3XHp"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0170410D0
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cafa90160so5745254276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186255; x=1698791055; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NM9dcQFM3UJZ90iyVMmsCAaNS1wz3u9iN52BCuG9Qew=;
        b=meDc3XHpY9ExaB280nqOJ6K12OSUwce6tf+IECrl3phpC11mlm2lK0RtXg1hlcetqQ
         IARFzopmnj2l0M1LYYdylBWVYy8/qq2za77E8GuduEiFUQJyM9cjX9GO45Fiil3YMs6Y
         GY3R2xmNPk5JnsdAhz+XU2mGcSN++OBrYzAvjbRZU5i9w7OSu5mV/7UmwQRYvderROeH
         qFtLHtmi3fAE89TaP/eI9TrrMZosgnEr2XPChozMnTtw2Q2rXVkY0eIs5kE5k/VjROEs
         M4j+fFEFoz23hcJILF8zpJj/P9hNWAXbMOqtnsHCx7dDkufNWU8GmNTqVk1gMtn7S+Q1
         LfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186255; x=1698791055;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NM9dcQFM3UJZ90iyVMmsCAaNS1wz3u9iN52BCuG9Qew=;
        b=BeX6IbDAC3kVazdv5c619AxIKts7nrFgNe2pHyE5LyMIUOKqbh4fd52S8FtQyWVwf6
         IoMwZ2ct+ec0PQVxNaOTSLoGf+WhNeZLqjHjY+f4U4xPlitZIwuYuBNrQ5sSq+lkyuYS
         rogzxBB9qlwXytY5VLd8kyb7wMGuygcRKS2MQm9EMxwS/8ursgxgp4qCbnTyma/iPMXC
         x/Fu5bWcVH8Z2c7NPhIRsFTM7ibGJrKbITudDXNh7cwNNwDfV8PHpYSKWSQSGuFi6E2V
         MZQXgGvhbEoRKeX2xJepOmcBrTfjN42E3fVLE5ku0KBFgmt9mXZ5d9QGnoFoxtAfTtwg
         imlg==
X-Gm-Message-State: AOJu0YwzKmTrH1bc8u04Et+cKvuXStCTxVxOjO2pl5EMzvCn6N4cy/9Y
	bgzXpYNLm3tOC1oA+VvK3uUBzu8b4T2P
X-Google-Smtp-Source: AGHT+IF7nlRfsAq1YqcW3CsH70jSGEhchSRGYDNQ7SmWyO76Nk3DNu3kvo4mRn/43YxUo7ddKr0wFqtUs8/z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:d107:0:b0:d9a:50d2:a8ba with SMTP id
 i7-20020a25d107000000b00d9a50d2a8bamr250692ybg.2.1698186255187; Tue, 24 Oct
 2023 15:24:15 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:04 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 01/50] perf rwsem: Add debug mode that uses a mutex
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Mutex error check will capture trying to take the lock recursively and
other problems that rwlock won't. At the expense of concurrency, adda
debug mode that uses a mutex in place of a rwsem.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/rwsem.c | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/util/rwsem.h | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/util/rwsem.c b/tools/perf/util/rwsem.c
index f3d29d8ddc99..5109167f27f7 100644
--- a/tools/perf/util/rwsem.c
+++ b/tools/perf/util/rwsem.c
@@ -2,32 +2,66 @@
 #include "util.h"
 #include "rwsem.h"
 
+#if RWS_ERRORCHECK
+#include "mutex.h"
+#endif
+
 int init_rwsem(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_init(&sem->mtx);
+	return 0;
+#else
 	return pthread_rwlock_init(&sem->lock, NULL);
+#endif
 }
 
 int exit_rwsem(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_destroy(&sem->mtx);
+	return 0;
+#else
 	return pthread_rwlock_destroy(&sem->lock);
+#endif
 }
 
 int down_read(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_lock(&sem->mtx);
+	return 0;
+#else
 	return perf_singlethreaded ? 0 : pthread_rwlock_rdlock(&sem->lock);
+#endif
 }
 
 int up_read(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_unlock(&sem->mtx);
+	return 0;
+#else
 	return perf_singlethreaded ? 0 : pthread_rwlock_unlock(&sem->lock);
+#endif
 }
 
 int down_write(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_lock(&sem->mtx);
+	return 0;
+#else
 	return perf_singlethreaded ? 0 : pthread_rwlock_wrlock(&sem->lock);
+#endif
 }
 
 int up_write(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_unlock(&sem->mtx);
+	return 0;
+#else
 	return perf_singlethreaded ? 0 : pthread_rwlock_unlock(&sem->lock);
+#endif
 }
diff --git a/tools/perf/util/rwsem.h b/tools/perf/util/rwsem.h
index 94565ad4d494..ef5cbc31d967 100644
--- a/tools/perf/util/rwsem.h
+++ b/tools/perf/util/rwsem.h
@@ -2,9 +2,20 @@
 #define _PERF_RWSEM_H
 
 #include <pthread.h>
+#include "mutex.h"
+
+/*
+ * Mutexes have additional error checking. Enable to use a mutex rather than a
+ * rwlock for debugging.
+ */
+#define RWS_ERRORCHECK 0
 
 struct rw_semaphore {
+#if RWS_ERRORCHECK
+	struct mutex mtx;
+#else
 	pthread_rwlock_t lock;
+#endif
 };
 
 int init_rwsem(struct rw_semaphore *sem);
-- 
2.42.0.758.gaed0368e0e-goog

