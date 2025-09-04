Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01141C5485;
	Thu,  4 Sep 2025 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945428; cv=none; b=tS2COpICteMrdpqm4khMEH/psnOe8217nKNakpXa7lZrPhEgjWs6scaz4egA/UX0LSWLH+ev2Zyge5gT0HwVRK2aVicMw59ehaucitZKbQcvOXOInWuu8502zkBdlX+KG6/lX9Gfxeq8WhUotA5XxGpFtx3ms6lXudbjVU9ZJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945428; c=relaxed/simple;
	bh=qkcftcj0fqlwmdDkYmum8il+ZDjAfjmbv7Do9ex3a28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9qtyFpgrTkWzvzJzZ6uUIg+XrNBBbzcRHx9iTyhWkAMU3rl5jp6ECXjc8mjDevLeG9zOLp5bjMoDQFQGoc9S3/OH23PeoFr/WhFDgJU47aCG3P0Zxz4r/eF52Azkz0FpCNX44+dt5QF97NkJHGF2fKJbAZj110mTR1h7bd6SSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3PPhdrO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3PPhdrO"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77269d19280so448210b3a.3;
        Wed, 03 Sep 2025 17:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945426; x=1757550226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEG4bH5cgwUC7a1orTI7hmUJnz956GpzDiyDWs45yMQ=;
        b=D3PPhdrOpbTz8iap4nBY6XtGhmMUgBnDgezx5H/fbpbPt+CTAQyzJuDYhN0UbnqNOL
         PCZhGsX3SrpQojEyv63hf58UO67y96GhZ2hUAEuawbiAA0/dzghIYdhL4J2e3NwhteW8
         5HYt/VZ9Ib6ghCn/wx/E3m+9Xb4RJqr+5B/XWv09ZWiwJcdiJ6+aTWWhDVz7cb86VKYl
         y79fI8lH7v6wWMuaBSjEZ+Abr4pCgfCgFsr3/fJaBWemud/0VcIRFGqdnB1RTCon+r/y
         EqweQSM6jvrmmwL06FmJdRKFkQ+FFUL1Ff033fRuFFs8dKFSagpj1JQe2O79XHvS6aAd
         nV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945426; x=1757550226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEG4bH5cgwUC7a1orTI7hmUJnz956GpzDiyDWs45yMQ=;
        b=DFyV5qZPpDxZUq1uHBbvPudei0gocGyZTGRadO3LGa7lQQjDWE31B5gugKkMp8e+w6
         i1lSFzz4zVWsmIzbu1swffjFlRhzKcV7GIdARpLyIzwEN5s6nfxKgG3qxTdauOA1o4XX
         HU4AUy+KcgMDx0Dw4/342/I/lrV+T00DNEKKaE1Bg+m2uWNu53SvU+42VvCgTWj4Ua+q
         5DvxHqCtTwEm+GaugODtI99xpo9Gncbarr8tFM8UVRqgJnOMhgEmZMqJjVxiyl66kW6q
         OwdTgcVUZ41JDxL3sxF3cXXSAdC9LhBWe+p68Ga/KvVta6+pIT/hbV8+/QZDZVQElOn5
         JiAw==
X-Forwarded-Encrypted: i=1; AJvYcCUNJbsPLvjcA+Jj6Ycr08CSDG/KfRLHZQ4R+dbuqPl5AREZBvVDWD5z8XnlJPx45UAlnugiTYC3Aa5pw8s6h0nx@vger.kernel.org, AJvYcCWk3X0DXZLwdo/0rYv7A4BVUhTH5Zy+m+lTFOWoEDCheKwBhDGXGW2fpbhvnG8wct5HWaa9xH62slRW4c4rNbmECtz6@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/YrieKm6u90QL/qmOPSLeDNksOGUeN3/fhf9xAhwTSJ6PMbJ
	qYTVUN1TT1tzfId1eIEmLF8JmHpmcwM2DNA0rNfDgHic8lsd4K7wnX/v
X-Gm-Gg: ASbGncuMKKPMMf1cD/eLpbhnIX6+N/yiymhUznk/WA0PnY+aVe37etamOktbwwdeeA2
	x6URsQ39WwTakpC35wGz3G53aq/hIGpm9YTTsF8UlWzeS4BWpmGRrrEgElzqED8APaFvyR9r0f3
	MN4XX6U4ZcteNt4DRE9cKkIMxyoWKpC9xh16RaVoS7V+pOrWvIPF0CpEsgTHBxG1KV1cDmMFp0E
	zCj/To6xrZrRA7ud06RXzptUyEQM5VBU+r1K0M7lhpTRRgVg2+nJM7AfCny9k6HphgkzQCI/YXM
	Y2m8nHFt1uAR4DBSRCo0LFQ24CzNhAgMsmesfAJGK7zo57HQXqMa4qlsD2LhDfb3/iCctj4qU9s
	0na7eaMtTV9++rwuVP7PPEjtTDprktcD7WvFZQMhMj/QDhPOPpHRX0ieNYuTNvwr8bhg1cXz6UA
	==
X-Google-Smtp-Source: AGHT+IEr/C81GB/BuP4Yk9gK7yApaaYJOMu3ISoyiOcC/P42G0UqOztnrGwzfHBNa2zOn5PIjEynzg==
X-Received: by 2002:a05:6a20:9187:b0:24a:b2eb:6676 with SMTP id adf61e73a8af0-24ab2eb699emr1717825637.17.1756945425818;
        Wed, 03 Sep 2025 17:23:45 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:23:45 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 13/18] mm/ksw: add test module
Date: Thu,  4 Sep 2025 08:21:10 +0800
Message-ID: <20250904002126.1514566-14-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904002126.1514566-1-wangjinchao600@gmail.com>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a separate test module to validate KStackWatch functionality in
controlled scenarios, such as stack canary writes and simulated corruption.

The module provides a proc interface (/proc/kstackwatch_test) that allows
triggering specific test cases via simple commands:

 - test0: directly corrupt the canary to verify watch/fire behavior

This helps development and validation of KStackWatch without affecting
normal kernel operation. Test module is built with optimizations disabled
to ensure predictable behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug                  |  10 +++
 mm/kstackwatch/Makefile           |   6 +-
 mm/kstackwatch/kstackwatch_test.c | 118 ++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 mm/kstackwatch/kstackwatch_test.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index c2cc8c7b595f..7fdf7b03d458 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -319,3 +319,13 @@ config KSTACK_WATCH
 	  the recursive depth of the monitored function.
 
 	  If unsure, say N.
+
+config KSTACK_WATCH_TEST
+	tristate "KStackWatch Test Module"
+	depends on KSTACK_WATCH
+	help
+	  This module provides controlled stack exhaustion and overflow scenarios
+	  to verify the functionality of KStackWatch. It is particularly useful
+	  for development and validation of the KStachWatch mechanism.
+
+	  If unsure, say N.
diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
index d422f0e114dd..c04c0780da01 100644
--- a/mm/kstackwatch/Makefile
+++ b/mm/kstackwatch/Makefile
@@ -1,4 +1,8 @@
 obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
 kstackwatch-y := kernel.o stack.o watch.o
 
-CFLAGS_kernel.o := -Wno-error=unused-function
+obj-$(CONFIG_KSTACK_WATCH_TEST)	+= kstackwatch_test.o
+CFLAGS_kstackwatch_test.o := -fno-ipa-sra -fno-inline \
+                             -fno-optimize-sibling-calls \
+                             -fno-section-anchors \
+                             -fno-pic -fno-pie -O0 -Og
diff --git a/mm/kstackwatch/kstackwatch_test.c b/mm/kstackwatch/kstackwatch_test.c
new file mode 100644
index 000000000000..bba2ab8530ed
--- /dev/null
+++ b/mm/kstackwatch/kstackwatch_test.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/prandom.h>
+#include <linux/printk.h>
+#include <linux/proc_fs.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "kstackwatch.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Simple KStackWatch Test Module");
+
+static struct proc_dir_entry *test_proc;
+#define BUFFER_SIZE 4
+#define MAX_DEPTH 4
+
+/*
+ * Test Case 0: Write to the canary position directly (Canary Test)
+ * use a u64 buffer array to ensure the canary will be placed
+ * corrupt the stack canary using the debug function
+ */
+static void canary_test_write(void)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("KSW: test: starting %s with u64 write\n", __func__);
+	ksw_watch_show();
+	ksw_watch_fire();
+
+	buffer[0] = 0;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+	pr_info("KSW: test: canary write test completed\n");
+}
+
+static ssize_t test_proc_write(struct file *file, const char __user *buffer,
+			       size_t count, loff_t *pos)
+{
+	char cmd[256];
+	int test_num;
+
+	if (count >= sizeof(cmd))
+		return -EINVAL;
+
+	if (copy_from_user(cmd, buffer, count))
+		return -EFAULT;
+
+	cmd[count] = '\0';
+	strim(cmd);
+
+	pr_info("KSW: test: received command: %s\n", cmd);
+
+	if (sscanf(cmd, "test%d", &test_num) == 1) {
+		switch (test_num) {
+		case 0:
+			pr_info("KSW: test: triggering canary write test\n");
+			canary_test_write();
+			break;
+
+		default:
+			pr_err("KSW: test: Unknown test number %d\n", test_num);
+			return -EINVAL;
+		}
+	} else {
+		pr_err("KSW: test: invalid command format. Use 'test1', 'test2', or 'test3'.\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t test_proc_read(struct file *file, char __user *buffer,
+			      size_t count, loff_t *pos)
+{
+	static const char usage[] =
+		"KStackWatch Simplified Test Module\n"
+		"==================================\n"
+		"Usage:\n"
+		"  echo 'test0' > /proc/kstackwatch_test  - canary write test\n";
+
+	return simple_read_from_buffer(buffer, count, pos, usage,
+				       strlen(usage));
+}
+
+static const struct proc_ops test_proc_ops = {
+	.proc_read = test_proc_read,
+	.proc_write = test_proc_write,
+};
+
+static int __init kstackwatch_test_init(void)
+{
+	test_proc = proc_create("kstackwatch_test", 0644, NULL, &test_proc_ops);
+	if (!test_proc) {
+		pr_err("KSW: test: Failed to create proc entry\n");
+		return -ENOMEM;
+	}
+	pr_info("KSW: test: Module loaded, use 'cat /proc/kstackwatch_test' for usage\n");
+	return 0;
+}
+
+static void __exit kstackwatch_test_exit(void)
+{
+	if (test_proc)
+		remove_proc_entry("kstackwatch_test", NULL);
+	pr_info("KSW: test: Module unloaded\n");
+}
+
+module_init(kstackwatch_test_init);
+module_exit(kstackwatch_test_exit);
-- 
2.43.0

