Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6D3B7749
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293591; cv=none; b=qqzzPYb4tD82usX5h4BEZJ1ls1a6oDbIXlKd6Xq2FrfDelAatJ8w8YeFP62n2M4DVkcPDfswYXJ7S3xEn0Js9MXf6nR5fxxilCkZDqLaj1/Vpe4b9jl+JjRcb/X2kYPXEIEvOFoAcZMR5MW4SEONe4dm2gDBqQjuFEPbNwKeQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293591; c=relaxed/simple;
	bh=EZAvJ5i0NW+Kg4ruSRBOsnEDn2AFbFSgVSv6jhiiLDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0RFDLGdnY/Q2ykANKsBaAu+Zj/Be6VPi1EC7e6XdBe0Vl3aYAc2gepgzrRm9J3BbOf/GM629tGDssNFOE5LgFgW0Z0avcOflrLV+cmTmpMaXCGOSmEJOqj6M4YPpjt8OKptacPg7XNolhGVj1AImhNvdtJdlgpuYDQLXW46eO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpsK9HBA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpsK9HBA"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca80d708489so1237514a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293590; x=1784898390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEU9n4OqT0ozu0Vj195yfeupUKeUqzKPFRIVzbMgbeQ=;
        b=TpsK9HBAckMRtpTGNKK8yuyMPojyb6uzVp8p1fIGX9YeSaX5J/N6tOJSyeRwdWFhQ3
         B/p0BN2J1p47lNRzE7w7Si3ZQjMM7bC8dHknSHW5i6yC1sG42iVNe96s07glkHuzfR1o
         DeyoB0TeahpxfnxhCPHsiMF7BFIOcKFCoFuyJiHyu5s8LO8qT6Kp5QxHyfsTufpfj+yy
         Vv+lrXt0onqkPCUJ+qBbaqZZKh8+P5kCVKTLDs5Ey179EjuNE4aVG8n8dQc/O2c/nqgO
         P7kXcLDmu16OQisEatsq7OOvt9YSqnryThr2HbLNSHbZXtg0xL0avniR57xd4HLI+A9Q
         qw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293590; x=1784898390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TEU9n4OqT0ozu0Vj195yfeupUKeUqzKPFRIVzbMgbeQ=;
        b=gg+pbqU75LSTMrIofTGKasklk0IGWZoPQTgMm7ZS0p+rMMu9K1BEROd640PfHvqQzF
         hVwsys6X4gQFWHi6gNz0gvXpv58HAQuVAusR0P60KoZECGl5OOZRXC25jRnkZTaIlL9O
         wihS774N8OvHwgxJDxqRTdCDDJwDyJzm1VEp+qT7Ue4UiozAb3VKAj38trNdkzc7aMkH
         dgTQ4K1KvDF+qe6ARt7Psj4rOYAWvGm2OFLgXf8Jc89ZpQvzvTdpTGxCHKjTs9a0boOB
         YCnWXGFLCzhwUPQCYYQAlnuk8WOUsjaOV/Mp+eKpnn+8C5HS+rVPg4ON+25eURiDAeWL
         zj2g==
X-Forwarded-Encrypted: i=1; AHgh+Rq7JQAqV4Hq0skCUK44iAEl41FvOezp77tm42RZsM/atwDnJIO77ohykbWsLljN0sFIPAydj+JYMwEU/Sz89gRC@vger.kernel.org
X-Gm-Message-State: AOJu0YwCm/ADyJGa8lJwSe9cuS3WFqpwk408qh7sO7iED1A5VUydsX4v
	3GXrY9UmqCQ6BK/ofnlsEXvCOjhs60WaUkbdXHlwId+nhmo4yWLcyg3l
X-Gm-Gg: AfdE7cmQBrLhgkmLa52ZBeBjfX+qjwwdwJfAFeSr5BLqbCWF1A+aP4PNMcr5XAOL6PC
	H6DNxWiJu+jOW0l2zfXuYnEfLaMzWz1Z8opgOqoaZfmEB076jHIknbs4PehXY8UtvJkY64AuavE
	jo6Nbf6F8pvZFRsz74Y1h/aw+SqfQS/p6/pyY0OqXVEpELG307djTbiAoVYDniALeuWeQ58Cj2J
	QdyiURt+k7iLtv6IdWCgNjXO+oa1DevrWWO5SRcJsCaeMyuYcRldfSUzTk8wFWTvHnXZ6PE4xpk
	joPf5tDT1GC/TusVSwN9/nqFUamjDp/540V+gNuU/D6u1MtRnjkA1ULy7uaZBT19AHGvXGd8uYD
	GGaHDfq1mjcASZnKkWqJDPt3/QWA6DW4lmzzNWuG+miGwrs+j3e7lgIFXKaDDlo4po6mSw3CNxy
	MHAA==
X-Received: by 2002:a05:6a20:430f:b0:3c3:8315:80b6 with SMTP id adf61e73a8af0-3c38dbff098mr7615722637.32.1784293589583;
        Fri, 17 Jul 2026 06:06:29 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29ffb13sm5473497c88.6.2026.07.17.06.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:06:25 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 10/13] mm/kwatch: add anchor thread for global watchpoints
Date: Fri, 17 Jul 2026 09:06:09 -0400
Message-ID: <20260717130609.1903443-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global variables have no function whose execution can bound the
watch window. Provide one: a kernel thread sleeps for the configured
duration inside a dedicated noinline function,
kwatch_global_anchor(), and the probe runtime hooks that function
like any other target.

When the duration expires the thread schedules a work item that
tears the session down; the expired flag is cleared under the
control-plane mutex so a stale work item from a previous session
cannot stop a new one.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kwatch/Makefile |  2 +-
 mm/kwatch/anchor.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 mm/kwatch/anchor.c

diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
index f04673cc5b1c..b196c794619a 100644
--- a/mm/kwatch/Makefile
+++ b/mm/kwatch/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_KWATCH) += kwatch.o
 
-kwatch-y := deref.o task_ctx.o hwbp.o probe.o
+kwatch-y := deref.o task_ctx.o hwbp.o probe.o anchor.o
diff --git a/mm/kwatch/anchor.c b/mm/kwatch/anchor.c
new file mode 100644
index 000000000000..e87eb5e813ff
--- /dev/null
+++ b/mm/kwatch/anchor.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kthread.h>
+#include <linux/wait.h>
+#include <linux/jiffies.h>
+#include <linux/err.h>
+#include <linux/workqueue.h>
+
+#include "kwatch.h"
+
+static DECLARE_WAIT_QUEUE_HEAD(kwatch_anchor_wq);
+static struct task_struct *kwatch_anchor_tsk;
+static bool kwatch_anchor_expired;
+
+bool kwatch_anchor_has_expired(void)
+{
+	return READ_ONCE(kwatch_anchor_expired);
+}
+
+void kwatch_anchor_clear_expired(void)
+{
+	WRITE_ONCE(kwatch_anchor_expired, false);
+}
+
+static void kwatch_auto_stop_handler(struct work_struct *work)
+{
+	kwatch_auto_stop();
+}
+
+static DECLARE_WORK(kwatch_auto_stop_work, kwatch_auto_stop_handler);
+
+noinline void kwatch_global_anchor(unsigned long duration_sec)
+{
+	/* TASK_IDLE: a long timed sleep must not inflate loadavg or trip the
+	 * hung-task detector the way TASK_UNINTERRUPTIBLE would.
+	 */
+	wait_event_idle_timeout(kwatch_anchor_wq, kthread_should_stop(),
+				duration_sec * HZ);
+}
+
+static int kwatch_anchor_thread_fn(void *data)
+{
+	unsigned long duration = (unsigned long)data;
+
+	kwatch_global_anchor(duration);
+
+	if (!kthread_should_stop()) {
+		/* mark before scheduling; cleared under the control mutex */
+		WRITE_ONCE(kwatch_anchor_expired, true);
+		schedule_work(&kwatch_auto_stop_work);
+	}
+
+	while (!kthread_should_stop())
+		schedule_timeout_idle(HZ);
+
+	return 0;
+}
+
+int kwatch_anchor_start(u16 duration)
+{
+	kwatch_anchor_tsk = kthread_run(kwatch_anchor_thread_fn,
+					(void *)(unsigned long)duration,
+					"kwatch_anchor");
+	if (IS_ERR(kwatch_anchor_tsk)) {
+		int ret = PTR_ERR(kwatch_anchor_tsk);
+
+		kwatch_anchor_tsk = NULL;
+		return ret;
+	}
+	return 0;
+}
+
+void kwatch_anchor_stop(void)
+{
+	if (kwatch_anchor_tsk) {
+		kthread_stop(kwatch_anchor_tsk);
+		kwatch_anchor_tsk = NULL;
+	}
+}
+
+void kwatch_anchor_cancel_work(void)
+{
+	cancel_work_sync(&kwatch_auto_stop_work);
+}
-- 
2.53.0

