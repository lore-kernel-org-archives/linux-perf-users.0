Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CE497380;
	Thu, 17 Sep 2026 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686562; cv=none; b=FFXZ9AHfl0SN7YNriCUKMSJyCBE3+UZVAUcvfns6owqAwS49zzeG8Mo7x82dSAKEfzQYVsDFRuZGb7+o8wRKQD8nJbOr96b49Zj48nznWFK7VJlmCYPggsLnJOxBS9sV2da3wVxFzljrn0mAu4ohzNUfEr68Qz5ws5NY4aVRvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686562; c=relaxed/simple;
	bh=6BoZw9e7LsBmykesJsGuoupooeM2+els5btjdg+TKgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiTqljTNEQTxvzpJn7/1xHJcMx4NRHJbx2ePXdbZRJWVpQYCTB5C1D0s35lcyYjcGQZvxT81aLbdt9AdAnvwdMmNmcrWP12KbCBbNC/2XmyRps/aIUhd1vXe8PiBRV4WTVnpuVSjO6QPdlxTSxVf17qG9TV2PjHsq95AroLS3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 1E56F5E8A1;
	Fri, 18 Sep 2026 01:01:52 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 7E8E71622A2; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	tglx@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC PATCH v2 03/11] ptwrite uprobes: Add a sample module to exercise interface
Date: Thu, 17 Sep 2026 16:00:30 -0700
Message-ID: <20260917230127.924985-4-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917230127.924985-1-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic test module and a test program for uprobes ptwrite.

The module allows to configure and register a ptwrite uprobe in a
executable.

Use this for testing. It is not intended as a production interface.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 samples/Kconfig                              |   9 ++
 samples/Makefile                             |   1 +
 samples/uprobe-ptwrite/Makefile              |   9 ++
 samples/uprobe-ptwrite/test_prog.c           |  38 +++++
 samples/uprobe-ptwrite/uprobe_ptwrite_test.c | 153 +++++++++++++++++++
 5 files changed, 210 insertions(+)
 create mode 100644 samples/uprobe-ptwrite/Makefile
 create mode 100644 samples/uprobe-ptwrite/test_prog.c
 create mode 100644 samples/uprobe-ptwrite/uprobe_ptwrite_test.c

diff --git a/samples/Kconfig b/samples/Kconfig
index a75e8e78330d..79da903edb62 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -322,6 +322,15 @@ config SAMPLE_HUNG_TASK
 	  Reading these files with multiple processes triggers hung task
 	  detection by holding locks for a long time (256 seconds).
 
+config SAMPLE_UPROBE_PTWRITE
+	tristate "Build ptwrite uprobe test module -- loadable module only"
+	depends on UPROBES && X86_64 && m
+	help
+	  Builds a prototype ptwrite uprobe driver for testing Intel PTWRITE
+	  support. Use the module parameters to select a file, offset, arguments,
+	  and event ID. This interface is for testing and is not intended for
+	  production use.
+
 source "samples/rust/Kconfig"
 
 source "samples/damon/Kconfig"
diff --git a/samples/Makefile b/samples/Makefile
index 07641e177bd8..0c970d46653e 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -44,4 +44,5 @@ obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_MTIER)	+= damon/
 obj-$(CONFIG_SAMPLE_HUNG_TASK)		+= hung_task/
+obj-$(CONFIG_SAMPLE_UPROBE_PTWRITE)	+= uprobe-ptwrite/
 obj-$(CONFIG_SAMPLE_TSM_MR)		+= tsm-mr/
diff --git a/samples/uprobe-ptwrite/Makefile b/samples/uprobe-ptwrite/Makefile
new file mode 100644
index 000000000000..0b81311dd4b8
--- /dev/null
+++ b/samples/uprobe-ptwrite/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ptwrite uprobe prototype sample.
+#
+# Module build (in-tree or via make M=samples/uprobe-ptwrite).
+# The userspace test target is built by the in-tree selftest harness in
+# tools/testing/selftests/uprobes.
+
+obj-$(CONFIG_SAMPLE_UPROBE_PTWRITE) += uprobe_ptwrite_test.o
diff --git a/samples/uprobe-ptwrite/test_prog.c b/samples/uprobe-ptwrite/test_prog.c
new file mode 100644
index 000000000000..1b57c522e215
--- /dev/null
+++ b/samples/uprobe-ptwrite/test_prog.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * test_prog - userspace target for the ptwrite uprobe test.
+ *
+ * target() carries a 5-byte NOP (nopl 0(%rax,%rax,1) = 0f 1f 44 00 00) at
+ * its entry. A probe installed at that file offset emits rdi/rsi (a, b)
+ * via PTWRITE. In the test loop a == i and b == i + 1.
+ */
+#include <stdio.h>
+
+#ifndef noinline
+#define noinline __attribute__((noinline))
+#endif
+
+static noinline unsigned long
+target(unsigned long a, unsigned long b)
+{
+	/*
+	 * 5-byte NOP: nopl 0(%rax,%rax,1) = 0f 1f 44 00 00.
+	 * Emitted as raw bytes: the assembler would otherwise shrink
+	 * "nopl (%rax,%rax,1)" to the 4-byte form (0f 1f 04 00), which
+	 * the probe site validation rejects (jmp rel32 needs 5 bytes).
+	 */
+	asm volatile(".globl target_site\n\t"
+		     "target_site:\n\t"
+		     ".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
+	return a * 31 + b;
+}
+
+int main(void)
+{
+	unsigned long i, acc = 0;
+
+	for (i = 0; i < 2000; i++)
+		acc += target(i, i + 1);
+	printf("acc=%lu\n", acc);
+	return 0;
+}
diff --git a/samples/uprobe-ptwrite/uprobe_ptwrite_test.c b/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
new file mode 100644
index 000000000000..94d01bf18faa
--- /dev/null
+++ b/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * uprobe_ptwrite_test - minimal ptwrite uprobe prototype driver.
+ *
+ * Registers a trap-free ptwrite uprobe at a user-specified file offset and
+ * emits the requested live registers / immediates into an externally
+ * configured Intel PT stream (no kernel entry at probe-hit time):
+ *
+ *   perf record -e intel_pt/ptw=1,fup_on_ptw=1//u -o perf.data ./test_prog
+ *
+ * Usage (module params):
+ *   path=/path/to/prog   file to probe
+ *   offset=0xADDR        file offset of the probe site
+ *   args="r0,r1,i0x42"             comma-separated;
+ *                        r<N> = x86-64 GPR index 0..15,
+ *                        i<hex> = immediate constant,
+ *   event_id=0x1234      identifier carried in the PTW header word
+ */
+#include <linux/module.h>
+#include <linux/uprobes.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+static char *path = "/nonexistent";
+module_param(path, charp, 0444);
+MODULE_PARM_DESC(path, "path of the binary to probe");
+
+static ulong offset;
+module_param(offset, ulong, 0444);
+MODULE_PARM_DESC(offset, "file offset of the 5-byte NOP to probe");
+
+static ushort event_id = 0x1234;
+module_param(event_id, ushort, 0444);
+MODULE_PARM_DESC(event_id, "event id carried in the PTW header word");
+
+static char *args = "r0";
+module_param(args, charp, 0444);
+MODULE_PARM_DESC(args, "comma-separated args: r<N> GPR, i<hex> immediate, m<N>[:disp][:4|8] memory");
+
+static struct file *probe_file;
+static struct uprobe *probe;
+static struct uprobe_consumer consumer;
+static struct uprobe_ptwrite_desc desc;
+
+static int parse_probe_args(void)
+{
+	char *s, *p, *tok;
+	unsigned int n = 0;
+
+	s = kstrdup(args, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	p = s;
+	while ((tok = strsep(&p, ",")) != NULL) {
+		struct uprobe_ptwrite_arg *a;
+
+		if (n >= UPROBE_PTWRITE_MAX_ARGS) {
+			pr_err("too many args\n");
+			goto err;
+		}
+		a = &desc.args[n];
+
+		a->size = 8;
+		if (tok[0] == 'r') {
+			unsigned long reg;
+
+			if (kstrtoul(tok + 1, 10, &reg) || reg > 15) {
+				pr_err("bad reg '%s'\n", tok);
+				goto err;
+			}
+			a->src = UPROBE_PTW_SRC_REG;
+			a->reg = reg;
+		} else if (tok[0] == 'i') {
+			unsigned long long v;
+
+			if (kstrtoull(tok + 1, 0, &v)) {
+				pr_err("bad imm '%s'\n", tok);
+				goto err;
+			}
+			a->src = UPROBE_PTW_SRC_IMM;
+			a->val = v;
+
+		} else {
+			pr_err("bad arg '%s'\n", tok);
+			goto err;
+		}
+		n++;
+	}
+	if (!n) {
+		pr_err("need 1..%d args\n", UPROBE_PTWRITE_MAX_ARGS);
+		goto err;
+	}
+	desc.nargs = n;
+	kfree(s);
+	return 0;
+err:
+	kfree(s);
+	return -EINVAL;
+}
+
+static int __init uprobe_ptwrite_test_init(void)
+{
+	struct inode *inode;
+	int ret;
+
+	desc.event_id = event_id;
+	ret = parse_probe_args();
+	if (ret)
+		return ret;
+
+	probe_file = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(probe_file))
+		return PTR_ERR(probe_file);
+
+	inode = file_inode(probe_file);
+	if (!inode->i_mapping->a_ops->read_folio &&
+	    !shmem_mapping(inode->i_mapping)) {
+		pr_err("unsupported mapping\n");
+		ret = -EIO;
+		goto out_file;
+	}
+
+	probe = uprobe_register_ptwrite(inode, probe_file, offset, &consumer, &desc);
+	if (IS_ERR(probe)) {
+		ret = PTR_ERR(probe);
+		pr_err("register failed: %d\n", ret);
+		goto out_file;
+	}
+
+	pr_info("probe %s+0x%lx, %u args, event_id=0x%x\n",
+		path, offset, desc.nargs, desc.event_id);
+	return 0;
+
+out_file:
+	fput(probe_file);
+	return ret;
+}
+
+static void __exit uprobe_ptwrite_test_exit(void)
+{
+	uprobe_unregister_nosync(probe, &consumer);
+	uprobe_unregister_sync();
+	fput(probe_file);
+	pr_info("unregistered\n");
+}
+
+module_init(uprobe_ptwrite_test_init);
+module_exit(uprobe_ptwrite_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ptwrite uprobes testing driver");
-- 
2.54.0

