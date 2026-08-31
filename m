Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43951E434;
	Mon, 31 Aug 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188834; cv=none; b=bFObyd//tBKrxx4YyoPnLKR6yZgmP9geVZXTg8Gb1qT/Y/nsQ7wPdpVuU2IM2bo/F1lux2Sv0+crZRHCIWLLXxJIE081FfevBtXQ2USr2boiCV3UUJDpLNMrdMkNNnpW+Rf+3SiSg5J8UW4guEZnG/XqMIYMSVlNCjopnSUj6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188834; c=relaxed/simple;
	bh=3mC+caGRf+f/0b51Gt9CZ3eMuviqKDBVm8omEevmghY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECYwAhzGp/pI0m44XP1x/l0rjFcd/g06LDYWv9Ddz0eJXIwd23jQVISzxdHrJWqmuC+n9T7ZUoaO0u2vP9/Cb79yOoWGOMA2tofakBjoz5xaZsefgNvRrNI9NfESeA0Jsgw+f8i1lFJ/xztTUAKxkVZv9T894nbn+bOBmMTp6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 7FFB663F86;
	Mon, 31 Aug 2026 17:07:08 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 0C65B162265; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC v1 06/19] ptwrite uprobes: Add a sample module to exercise interface
Date: Mon, 31 Aug 2026 08:04:42 -0700
Message-ID: <20260831150651.1134594-7-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831150651.1134594-1-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
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

This for testing and not intended as a production interface.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 samples/Kconfig                              |  13 ++
 samples/Makefile                             |   1 +
 samples/uprobe-ptwrite/Makefile              |  13 ++
 samples/uprobe-ptwrite/test_prog.c           |  35 ++++
 samples/uprobe-ptwrite/uprobe_ptwrite_test.c | 163 +++++++++++++++++++
 5 files changed, 225 insertions(+)
 create mode 100644 samples/uprobe-ptwrite/Makefile
 create mode 100644 samples/uprobe-ptwrite/test_prog.c
 create mode 100644 samples/uprobe-ptwrite/uprobe_ptwrite_test.c

diff --git a/samples/Kconfig b/samples/Kconfig
index a75e8e78330d..47bbef5d3e76 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -322,6 +322,19 @@ config SAMPLE_HUNG_TASK
 	  Reading these files with multiple processes triggers hung task
 	  detection by holding locks for a long time (256 seconds).
 
+config SAMPLE_UPROBE_PTWRITE
+	tristate "Build ptwrite uprobe test module -- loadable module only"
+	depends on UPROBES && X86_64 && m
+	help
+	  Builds the minimal ptwrite uprobe prototype driver. It replaces
+	  a 5-byte NOP at a user-specified file offset with a jmp to a per-mm
+	  user-mode stub that emits the requested live registers / immediates
+	  with the PTWRITE instruction into an externally configured Intel PT
+	  stream (no kernel entry, no syscall, no single-step at probe-hit
+	  time). The companion userspace target is test_prog.c in the same
+	  directory; the module params (path/offset/args/event_id) select the
+	  probe site and the emitted values.
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
index 000000000000..086d84be6ad2
--- /dev/null
+++ b/samples/uprobe-ptwrite/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ptwrite uprobe prototype sample.
+#
+# Module build (in-tree or via make M=samples/uprobe-ptwrite):
+#   obj-$(CONFIG_SAMPLE_UPROBE_PTWRITE) += uprobe_ptwrite_test.o
+#
+# The userspace test target (test_prog) is built by the out-of-tree test
+# harness (see /home/oc/uprobe-ptwrite-test); the harness computes the file
+# offset of target()'s 5-byte NOP and passes it to the module's offset
+# parameter.
+
+obj-$(CONFIG_SAMPLE_UPROBE_PTWRITE) += uprobe_ptwrite_test.o
diff --git a/samples/uprobe-ptwrite/test_prog.c b/samples/uprobe-ptwrite/test_prog.c
new file mode 100644
index 000000000000..813841ce5020
--- /dev/null
+++ b/samples/uprobe-ptwrite/test_prog.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * test_prog - userspace target for the ptwrite uprobe test.
+ *
+ * target() carries a 5-byte NOP (nopl 0(%rax,%rax,1) = 0f 1f 44 00 00) at
+ * its entry. A probe installed at that file offset emits rdi/rsi (a, b)
+ * via PTWRITE. In the test loop a == i and b == i + 1.
+ */
+#ifndef noinline
+#define noinline __attribute__((noinline))
+#endif
+
+#include <stdio.h>
+
+static noinline unsigned long
+target(unsigned long a, unsigned long b)
+{
+	/* 5-byte NOP: nopl 0(%rax,%rax,1) = 0f 1f 44 00 00.
+	 * Emitted as raw bytes: the assembler would otherwise shrink
+	 * "nopl (%rax,%rax,1)" to the 4-byte form (0f 1f 04 00), which
+	 * the probe site validation rejects (jmp rel32 needs 5 bytes).
+	 */
+	asm volatile(".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
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
index 000000000000..c3b9dd6bec16
--- /dev/null
+++ b/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
@@ -0,0 +1,163 @@
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
+/* Never invoked: ptwrite probes do not trap. Satisfies the core contract. */
+static int noop_handler(struct uprobe_consumer *self, struct pt_regs *regs,
+			__u64 *data)
+{
+	return 0;
+}
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
+			pr_err("uprobe_ptwrite_test: too many args\n");
+			goto err;
+		}
+		a = &desc.args[n];
+
+		a->size = 8;
+		if (tok[0] == 'r') {
+			unsigned long reg;
+
+			if (kstrtoul(tok + 1, 10, &reg) || reg > 15) {
+				pr_err("uprobe_ptwrite_test: bad reg '%s'\n", tok);
+				goto err;
+			}
+			a->src = UPROBE_PTW_SRC_REG;
+			a->reg = reg;
+		} else if (tok[0] == 'i') {
+			unsigned long long v;
+
+			if (kstrtoull(tok + 1, 0, &v)) {
+				pr_err("uprobe_ptwrite_test: bad imm '%s'\n", tok);
+				goto err;
+			}
+			a->src = UPROBE_PTW_SRC_IMM;
+			a->val = v;
+		} else {
+			pr_err("uprobe_ptwrite_test: bad arg '%s'\n", tok);
+			goto err;
+		}
+		n++;
+	}
+	if (!n || n > UPROBE_PTWRITE_MAX_ARGS) {
+		pr_err("uprobe_ptwrite_test: need 1..%d args\n",
+		       UPROBE_PTWRITE_MAX_ARGS);
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
+		pr_err("uprobe_ptwrite_test: unsupported mapping\n");
+		ret = -EIO;
+		goto out_file;
+	}
+
+	consumer.handler = noop_handler;
+	consumer.ret_handler = NULL;
+	consumer.filter = NULL;
+
+	probe = uprobe_register_ptwrite(inode, probe_file, offset, &consumer, &desc);
+	if (IS_ERR(probe)) {
+		ret = PTR_ERR(probe);
+		pr_err("uprobe_ptwrite_test: register failed: %d\n", ret);
+		goto out_file;
+	}
+
+	pr_info("uprobe_ptwrite_test: probe %s+0x%lx, %u args, event_id=0x%x\n",
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
+	pr_info("uprobe_ptwrite_test: unregistered\n");
+}
+
+module_init(uprobe_ptwrite_test_init);
+module_exit(uprobe_ptwrite_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ptwrite uprobes testing driver");
-- 
2.54.0

