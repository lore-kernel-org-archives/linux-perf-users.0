Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC521FF21
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597339; cv=none; b=LWfxc/55P03nCmUf50eXTZ8a2caQqPqwkug0sPIcY67iNUhwgPyRSDbPuSV+RRsMT+irPq1GvKP6QC16MRfMxYDGSE/rI5fVbiiBJoHrihW2ZkbzQx/cHudVySs+DrkRJ0riv9duu500lnMtflKHnpHl2gwAgmzxHfblVCYCXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597339; c=relaxed/simple;
	bh=Vc7NbMjHAO2dZd+RVkA7mhRl8eTmZhbc/UEd+aji6oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taRaqeYszlQhGZE3TLY0u4MzWsezlGOPSQfiammPK6QtIyXvolAc4jLjlvCtYUX9SRtdaHOOuX9bnJFUUSClA0W0G+eFSP5hTzMbRGACuJWJucFR2ViHaShdRVunE8WMCfK36eswiWmnPD3esqkVJqOC8qOvhx8dAtVGNKooFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HZy7M2u+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HZy7M2u+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-311ef4fb549so1553681a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597337; x=1749202137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHtdmIKid/axHIhLP0cCYOHEJ6hr+IyJWWADeBRNQ/E=;
        b=HZy7M2u+7GpR0jjgD3VvbuWXLAZzxDhZ8MFb1aLnTzO/OdeLksVR4Sp4RcuDwi1+uV
         J8ZKCyEPW6zPmzQtYc0CBUyZG41mWqwWNMPcjBinHleStwkLACO2cXrXusHc5q4kwBQD
         wciRQn7IEeNK+1xJkLX/PTIq3NVK4yOddbKkR/kw+Hx7gbzEo0rEe6+tNOidiU1DmfkK
         xAw2isnYIzbo4J1ZCCK2TBSLIdiwDXTDjTE+ZN7fGPKU6yqNek+wg51KzWEdfn6xY9hh
         gNqWdIXaNdt5XXNDbtOGrJJe8yWtI/eqFBNTr3/MKjcJdUrn8ErZbH9hCYgQm8wQCh6t
         W3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597337; x=1749202137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHtdmIKid/axHIhLP0cCYOHEJ6hr+IyJWWADeBRNQ/E=;
        b=TeePtXTRIrhiksHe4e6d3aNgLFfmR9KwLVYMEAzvWr/cu/+N7Jn/Pd2eizlm7jKLpV
         22FbEfJbzzUerQF+/ZfNMR6p3iUw3FwpzycD60FoX9y/mp954iEH23LgtBaTec4CKOhd
         5/E6+0GkGD2b/lIzrRJTCVKj5QYf10wO58fGPlrhAwjSBICWhNkJlWs1taIoImIxO7dk
         JsEK27cpZGJNmty8g9CeZqApFxLbTZ1Pzsx089sww2xJOj3410WOKL6qqxl0OPOiKM+l
         Dj/siUosVOzIA2mLF8j62+PzCl9ex1PYnOJsr2/XpnmSpH1Spj+QbR16QiAp0e9GcpY5
         IXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa6qPzw8ghGC6qzIfIrlB3K6FqXXeEOOn1SfLCPqmIJPb1qZsbXRk32CBykM8TLJmPDDBuPDrYoIpCu/2WVq3F@vger.kernel.org
X-Gm-Message-State: AOJu0YzminZJF8Rmyf6a9ErGLJ0/XKAxAkacyt8Vuhtr/KfkI9Q3rIIJ
	loT4zoYWZvrkqL0p7AeYFQLEezBUmRteeZjsSQ7hfcJiomkecjqIvBKIXqzj2RbCXM8=
X-Gm-Gg: ASbGnctkD/hQohZ7Q0xvTwp+MS3qwQamlc4WJXGC87oZjAxxR4o+BiaWdS4XJP3NhFl
	gInCvFNuYgzhOqo6VwBnagUmG9KqsF1mbqPizsp8GN08U+6cSBrl2gfxr1KFq7jg+jX4O4j7x4Z
	YmF06CPC9qFL+Sb+EMYPfgWO87O/lra0z/5do8SU436LQJRgtoa5IrLjmWj8/oDzSoPLF6EscQA
	iTohOEUuaHAQs/MnVsUb3hp7EttSBcFrg2yk7N9BEfQq+KiBhj0gJIlu5soaDS/HieXTqECjMdW
	wEUNWI7UO63JMm33vsstgX7IJCe3eaaliC9nmsjtRs7kEBj4GRytLKGK563LWwP4pF+QZtq9kbO
	feuXQqq/INmg3IemO+yy4
X-Google-Smtp-Source: AGHT+IF0jYnDB+2g7ZGuSYnYueYT47NoQiuIJK3WP4+gDWcAJJRqzT7RDm6Iq/1/p9n6sv5YTlCMUg==
X-Received: by 2002:a17:90b:2f8c:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-31241735b7fmr4743727a91.17.1748597336731;
        Fri, 30 May 2025 02:28:56 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.28.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:28:56 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 02/35] RPAL: add struct rpal_service
Date: Fri, 30 May 2025 17:27:30 +0800
Message-Id: <58ca31eb0711ad773c19a167e6888173a64ff890.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each process that uses RPAL features is called an RPAL service.

This patch adds the RPAL header file rpal.h and defines the rpal_service
structure. The struct rpal_service uses a dedicated kmem_cache for
allocation and deallocation, and atomic variables to maintain references
to the struct rpal_service. Additionally, the patch introduces the
rpal_get_service() and rpal_put_service() interfaces to manage reference
counts.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/Makefile   |  5 ++++
 arch/x86/rpal/core.c     | 32 +++++++++++++++++++++++
 arch/x86/rpal/internal.h | 13 ++++++++++
 arch/x86/rpal/service.c  | 56 ++++++++++++++++++++++++++++++++++++++++
 include/linux/rpal.h     | 43 ++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+)
 create mode 100644 arch/x86/rpal/core.c
 create mode 100644 arch/x86/rpal/internal.h
 create mode 100644 arch/x86/rpal/service.c
 create mode 100644 include/linux/rpal.h

diff --git a/arch/x86/rpal/Makefile b/arch/x86/rpal/Makefile
index e69de29bb2d1..ee3698b5a9b3 100644
--- a/arch/x86/rpal/Makefile
+++ b/arch/x86/rpal/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_RPAL)		+= rpal.o
+
+rpal-y := service.o core.o
diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
new file mode 100644
index 000000000000..495dbc1b1536
--- /dev/null
+++ b/arch/x86/rpal/core.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#include <linux/rpal.h>
+
+#include "internal.h"
+
+int __init rpal_init(void);
+
+bool rpal_inited;
+
+int __init rpal_init(void)
+{
+	int ret = 0;
+
+	ret = rpal_service_init();
+	if (ret)
+		goto fail;
+
+	rpal_inited = true;
+	return 0;
+
+fail:
+	rpal_err("rpal init fail\n");
+	return -1;
+}
+subsys_initcall(rpal_init);
diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
new file mode 100644
index 000000000000..e44e6fc79677
--- /dev/null
+++ b/arch/x86/rpal/internal.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+extern bool rpal_inited;
+
+/* service.c */
+int __init rpal_service_init(void);
+void __init rpal_service_exit(void);
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
new file mode 100644
index 000000000000..c8e609798d4f
--- /dev/null
+++ b/arch/x86/rpal/service.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#include <linux/rpal.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+static struct kmem_cache *service_cache;
+
+static void __rpal_put_service(struct rpal_service *rs)
+{
+	kmem_cache_free(service_cache, rs);
+}
+
+struct rpal_service *rpal_get_service(struct rpal_service *rs)
+{
+	if (!rs)
+		return NULL;
+	atomic_inc(&rs->refcnt);
+	return rs;
+}
+
+void rpal_put_service(struct rpal_service *rs)
+{
+	if (!rs)
+		return;
+
+	if (atomic_dec_and_test(&rs->refcnt))
+		__rpal_put_service(rs);
+}
+
+int __init rpal_service_init(void)
+{
+	service_cache = kmem_cache_create("rpal_service_cache",
+					  sizeof(struct rpal_service), 0,
+					  SLAB_PANIC, NULL);
+	if (!service_cache) {
+		rpal_err("service init fail\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+void __init rpal_service_exit(void)
+{
+	kmem_cache_destroy(service_cache);
+}
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
new file mode 100644
index 000000000000..73468884cc5d
--- /dev/null
+++ b/include/linux/rpal.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#ifndef _LINUX_RPAL_H
+#define _LINUX_RPAL_H
+
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/atomic.h>
+
+#define RPAL_ERROR_MSG "rpal error: "
+#define rpal_err(x...) pr_err(RPAL_ERROR_MSG x)
+#define rpal_err_ratelimited(x...) pr_err_ratelimited(RPAL_ERROR_MSG x)
+
+struct rpal_service {
+	/* reference count of this struct */
+	atomic_t refcnt;
+};
+
+/**
+ * @brief get new reference to a rpal service, a corresponding
+ *  rpal_put_service() should be called later by the caller.
+ *
+ * @param rs The struct rpal_service to get.
+ *
+ * @return new reference of struct rpal_service.
+ */
+struct rpal_service *rpal_get_service(struct rpal_service *rs);
+
+/**
+ * @brief put a reference to a rpal service. If the reference count of
+ *  the service turns to be 0, then release its struct rpal_service.
+ *  rpal_put_service() may be used in an atomic context.
+ *
+ * @param rs The struct rpal_service to put.
+ */
+void rpal_put_service(struct rpal_service *rs);
+#endif
-- 
2.20.1

