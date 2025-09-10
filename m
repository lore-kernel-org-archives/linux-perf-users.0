Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8936023ED5E;
	Wed, 10 Sep 2025 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482389; cv=none; b=sMUi+aLrFT3AuOgFCm2hlPpFmt4jAE3YeEnRmrPbVvqU/4JCDflfVXBcwzB3f0BXcEWROKY+STcMbRbi3ZKKTHmWFdOHAh0vijLGFCQFZE2jxLWKZOAcvPZAL55lTvBbSpuyOBPBAMiyTM/TVA8NWaSC9BB+tumwODkfJ0xB6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482389; c=relaxed/simple;
	bh=EgCZjLTIkqtRjqUx6K0w0F3NJZwiUfm4DLne+JUEvxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvtDZeQSAitxX0BMyBzJRt4dnAu2w1mIwUW80YwoZU5R9E6iQc7UKPTLH6BYzWGgh52o5/cSRnFFobEqJz5VdBeNky50jMj6P+NSyTv41NY0u9cYCgqO0Pr6s6HmKecLBbNuvyAH+oivZgT8edpBj1RaWOJa2zEEPxY8+HlzobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcfiEhCp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcfiEhCp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b47052620a6so196130a12.1;
        Tue, 09 Sep 2025 22:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482387; x=1758087187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hza3KqRNKGSLYWfBSKXFsxDeH0DXXBXA3429C+Yqz2A=;
        b=NcfiEhCp0kOSsyd9AMJqZx+eBeqw+Tro5zf0xNVy0aSlhhO8DCBTEqgf+HY2F1it3L
         wD8pyJj4ao0sHopxD7Vh1EOHN2LCdZbfqRYSetQDv+s3Zs+MQu8NCx4Jbqz0MLV5EbtB
         UtmPtmpXvn06Z4LMVAi2gLYMB5h7CdeuIABkK47rMms5mbeOQjy74GSzrPl94cUawwId
         vFRJoqAznudoGgSGLyw4cCWivBiRJt2ptFg/eKH71BpFRZrOpeU2blmy0pizHr/zutTr
         8KyFgnt2XIYHPrbTQ9HlUw7psd/TtjvWH7FH2FcDgkd48OFKxDtMM52jewhFU0v2ncc3
         qS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482387; x=1758087187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hza3KqRNKGSLYWfBSKXFsxDeH0DXXBXA3429C+Yqz2A=;
        b=sZdAZkPo7xi4Si5LDY8/bbDMzpYfUisGAg9o28DMdFqJcaqIQAYN3r65L09u6KRlst
         4MqBY1addxzaFpPcXa3VqzAWg9F5QdHDpFu3om81V08QLhFi9XwuoMjg/e8qdCe44snF
         G8HjDbbczps0okIJStwreQ1bAkPaXPz5S5Fk1uezRGvG4vr0P5Mzf5aX4YOph/yX2HVy
         dqZnI6comX94Mof7zw4cbTN8mF2rFVmdQuGu+GKxdgu/CHqWPby7K6mfzj3J9hE0pOVi
         8oju/6U7DGzcpFdXbpnPVOcRG2pt0GJnD/kzA3hbm7fZZXdfO+R9/X1QSEc7uEJtxDbG
         jH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVsk9TobuXVIsKGZTzIh9PBf98cl2r4o4xYehtqs1qkKcSCxnS2rvXn3D0rhoc+aDzVPs4T5ecOlZS3p0fWnIPV8Vc@vger.kernel.org, AJvYcCWfQoG4EgF762C8uy132oKblP9CjWQY7w5YO2uJtpbQJaEXgUPLeF9031fdeHO4KWf6iX2G0TdTxHK8WJexuLKE@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+3WBUtTcOG0/Kp5S+R6Ow/8LeFrJlYgw0fiuL1KKvf9j2rax
	6hdC1OW9uSSyaY5q/q9sOp4aF2583xuijtQAeBJTHmzpJ+Gc5LOJIQJn
X-Gm-Gg: ASbGncvwfgxE4e3yui/sxlU4WVrgJ2gs0RLEX3ft9dybJ6TW8uKRUk9ITEtMlgk3zjN
	poTh+P4gN+4ctwa1slcnYt16coaV9snMFderrEe8R6yiB62kxCINNChQk3R84vNn93CACIM+L9+
	pYcX7jlPVlbOtI+LDFHu+YVy8KGNDA6FTHj+DSKZIlXg+3DkePC+yiW2mn6LpsBngjk+uhlFO5H
	LrlU7ehKS4NoXogQZIPsjCGW0IZmsfaTf5oJrBY79Nhkn0A4LJ9RD6ccDwlWmefEE3CmWBbWzh0
	QkGHDYgjrY55ZZgKGvk2t1p7nIXC/lSDQ5JyJzkedzU4eepzYNf6vpfMj9aZTPjcRfxYreT9i+R
	Ez5i0N770QFGp+5Y5IgtAtnu4HfjZvR7iHw2fmQcxFWJg460Drg==
X-Google-Smtp-Source: AGHT+IGhIbrZfnqfbfJB3+5EAqaGoHeuKueESgd0Xq2xxOkj6PyWasntgL70p+IZyUYcH6qZd5vW4w==
X-Received: by 2002:a17:90b:2396:b0:32b:b514:3936 with SMTP id 98e67ed59e1d1-32bbe214925mr16978278a91.13.1757482386624;
        Tue, 09 Sep 2025 22:33:06 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:33:06 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 14/19] mm/ksw: add test module
Date: Wed, 10 Sep 2025 13:31:12 +0800
Message-ID: <20250910053147.1152253-6-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053147.1152253-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
 <20250910053147.1152253-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a separate test module to validate functionality in controlled
scenarios, such as stack canary writes and simulated corruption.

The module provides a proc interface (/proc/kstackwatch_test) that allows
triggering specific test cases via simple commands:

 - test0: directly corrupt the canary to verify watch/fire behavior

Test module is built with optimizations disabled to ensure predictable
behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug        |  10 ++++
 mm/kstackwatch/Makefile |   6 +++
 mm/kstackwatch/test.c   | 115 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 mm/kstackwatch/test.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index fdfc6e6d0dec..46c280280980 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -320,3 +320,13 @@ config KSTACK_WATCH
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
index 84a46cb9a766..d007b8dcd1c6 100644
--- a/mm/kstackwatch/Makefile
+++ b/mm/kstackwatch/Makefile
@@ -1,2 +1,8 @@
 obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
 kstackwatch-y := kernel.o stack.o watch.o
+
+obj-$(CONFIG_KSTACK_WATCH_TEST)	+= kstackwatch_test.o
+kstackwatch_test-y := test.o
+CFLAGS_test.o := -fno-inline \
+		-fno-optimize-sibling-calls \
+		-fno-pic -fno-pie -O0 -Og
diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
new file mode 100644
index 000000000000..76dbfb042067
--- /dev/null
+++ b/mm/kstackwatch/test.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/prandom.h>
+#include <linux/printk.h>
+#include <linux/proc_fs.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "kstackwatch.h"
+
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Simple KStackWatch Test Module");
+MODULE_LICENSE("GPL");
+
+static struct proc_dir_entry *test_proc;
+#define BUFFER_SIZE 4
+#define MAX_DEPTH 6
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
+	pr_info("starting %s\n", __func__);
+	ksw_watch_show();
+	ksw_watch_fire();
+
+	buffer[0] = 0;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+	pr_info("canary write test completed\n");
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
+	pr_info("received command: %s\n", cmd);
+
+	if (sscanf(cmd, "test%d", &test_num) == 1) {
+		switch (test_num) {
+		case 0:
+			pr_info("triggering canary write test\n");
+			canary_test_write();
+			break;
+		default:
+			pr_err("Unknown test number %d\n", test_num);
+			return -EINVAL;
+		}
+	} else {
+		pr_err("invalid command format. Use 'test1', 'test2', or 'test3'.\n");
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
+		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n";
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
+	test_proc = proc_create("kstackwatch_test", 0600, NULL, &test_proc_ops);
+	if (!test_proc) {
+		pr_err("Failed to create proc entry\n");
+		return -ENOMEM;
+	}
+	pr_info("module loaded\n");
+	return 0;
+}
+
+static void __exit kstackwatch_test_exit(void)
+{
+	if (test_proc)
+		remove_proc_entry("kstackwatch_test", NULL);
+	pr_info("module unloaded\n");
+}
+
+module_init(kstackwatch_test_init);
+module_exit(kstackwatch_test_exit);
-- 
2.43.0

