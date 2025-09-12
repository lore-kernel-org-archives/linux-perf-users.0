Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80C2E7F35
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671995; cv=none; b=VSphvMXA1z/W9T7I90GZ0IlKrXRTA2qHioTi73mx8lsYnVcbJrHfc4SaalWRlUXYFojoT5/1mi0px8s4glbIKPAOoDyj4yAAUQETIHmomaOdIPMrEZ1FaGvU+frCHlMNNINLspGaBL/YTZCoL/gtqe9mCJvZvwmO0959/tugAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671995; c=relaxed/simple;
	bh=EgCZjLTIkqtRjqUx6K0w0F3NJZwiUfm4DLne+JUEvxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKBvpbYXS9XZWVY5AG9LuqFTq3q2K6T5Yxd9pyd0PuJYzPdH+WPtlC6vs/I174e4o7iLqF/PwsIPMeQTNJfw9nh7RpT36miW8sszp0FYjqJZG5AaslMcRplyPhMW8n/vSbxTsAqD0RJ8Xq4Uc77LXkhvvyNlbtlpqieRL0sid94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnx3N7Q0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnx3N7Q0"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so1046234a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671993; x=1758276793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hza3KqRNKGSLYWfBSKXFsxDeH0DXXBXA3429C+Yqz2A=;
        b=lnx3N7Q0UCWOROsQKLiSqOofasuN5O1eJ4c42khTCR4SEMDK2067Qp/33iXYQx6hI3
         YPicD5Fl1RMw8sMdO+I5KMPG9sc70SRlTYhEGOtoYeE98QWBBgCAe9YqnhAH/krec7zT
         TOfBgS1VaAmH+Q6qSrXNhRxnx2ueTuLupH3V+jeJwr4KxVc2sEW0XQP6HUgIMk+48yON
         3d+EYV6YFCxNn0liAtsoXz5Ukr9z9E+izbPH62lZn0vKsXk6FMU8iyeujm3mbygQdVfy
         GzI01wxXBiir9AuSZMeC7AvRtv+TKFMvvy6ChfuZNcseus/t1vmSTaasF7YcKfQZ4Iql
         rSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671993; x=1758276793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hza3KqRNKGSLYWfBSKXFsxDeH0DXXBXA3429C+Yqz2A=;
        b=ZfrJ3rXSRo0EkUqwJarHEN4SoMD2EVwQMdYCIPdGL7tmO6iEf1sL27hOGY33nS0Mxr
         PVO/J7YLh88IuDwiiDh9zM44PxNkrQ7VqVUm+UzF1oNSB/dOIwYGlvkeC3GhaNO6RBGI
         ExeOy4atkv3Ofo03jVGD/V0CyxGaLjw4WOblBCzafRcuM94iumK2StK0K/z9918WBNfi
         0MEwBWWJz5DlLrEDxXBoEup72b+rvA4CqcK6l1pNWZgYLGMusYfKZOsPrKMWwMMy5XJD
         yU7TVElzJs22wTqW2Jx/WW82paldjzUF3ySCLQfIkRk48GqPip/+hjp6TF9EodpCqvm9
         4tVg==
X-Forwarded-Encrypted: i=1; AJvYcCX99ryvzVaWZveDdbUTiSR+0in1w9k/TH8JCUdFYe0/Y82oYcQf/VKrxIem+6rl9jCUOzcR/UCFYVVDQtPP8Gib@vger.kernel.org
X-Gm-Message-State: AOJu0YywbjrIff169rm7d4trhiEQi7ckdqhzMfl5OrQjP8OwJtrHuNBp
	VM7iT9kn2QMBGyf4tWRa9fQNhDcIyCQn+wdGNfZ9hsj9HAb9GLlehsDx
X-Gm-Gg: ASbGncsuTF7/RP+u11NP1Eua2mwpm0O7mI1+BpkpldnOSPkfhccRgdBAenqGz1kDHwy
	UjJhhnhHS46Uw8Ma7NbqnAn9KSsWOf2odyp3SOMFlnuO/e5WHALX0+hbYF7Q3/XQsBSlENpjHJ9
	p/2Lt+WiafoDJlcsV7PZJlK0jb51B04G/8BhjHmncY++5QaBt12FVl7bp6db0JoaWTPzAWjZMsm
	vB5N4Yz+pJ2ljKfK4NPSHzo1veCLq+krvaSWYHAXhM3upnayraeBG+KqiLSTjev94bXkB5KSKOb
	fFg30ZsQ6VGhrPlKeqTywYzIofqdVypKVbZ2x/Yx5ehmSMieY+1NxS1lPLNC5VcI6WWiQfKfozu
	gHZ7n6kbO4g8khjjltF1LI4lfcwjzC7uIzt8=
X-Google-Smtp-Source: AGHT+IG7f8OaGED6NtpM7NPcRiOM1jQkAe90+ggoUOI4OH0YlfR6qug9mcoSa6nxv/Hl/BMuWG/tLg==
X-Received: by 2002:a17:902:c407:b0:24c:784c:4a90 with SMTP id d9443c01a7336-25d24cac4e3mr30450705ad.1.1757671992780;
        Fri, 12 Sep 2025 03:13:12 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad33ed7sm45397685ad.102.2025.09.12.03.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:12 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
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
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v4 15/21] mm/ksw: add test module
Date: Fri, 12 Sep 2025 18:11:25 +0800
Message-ID: <20250912101145.465708-16-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
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

