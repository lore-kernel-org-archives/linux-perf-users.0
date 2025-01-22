Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A21C54BF;
	Wed, 22 Jan 2025 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513130; cv=none; b=pHwyqkB1gZ7Z5xWOJC7bVqwYT3kwGCvIim/7nTHW0V+okYn6MvodVxlpjiLowsF3gxmYX7mc272JiF5f6I+q1+o1t+q4LqunY36YwR02VuOUVmCkp52RX91F0LXiTdBzgRSLZz17wdJLH40P9eYu5iZTl8ZwMCbJGeQZ73McQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513130; c=relaxed/simple;
	bh=2Ntk3c9MZ4SXlv4NsY0mftQqSrLIfAtrWvzvtb5Jf4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSiHvP2qF2TMIPZ/Oo7+MlprQNcz8EfW9MXZVNoZctw7nJYN/y2SyExbBY5aQWfBlGpVBvLUkcdXCCS0gAehFnE+x89mXaoQyhmgaEm/xD07TouLsxJCpg2bK2Rqy9mMavgHn3IQWbA+UmXLj9bHDVmnNYaGagiab6dr2hxlVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjabxiwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjabxiwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B729C4CEE6;
	Wed, 22 Jan 2025 02:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513129;
	bh=2Ntk3c9MZ4SXlv4NsY0mftQqSrLIfAtrWvzvtb5Jf4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjabxiwYNNM8iLD2jy70fXJGO+BPTrVJAKRnqrmtf568RH7Dkck4hjesGd1tKnVFU
	 wwnlsz3e0x2fwzCO2H8L5ZGXvBe28vc0LcIMuVmWDxNlm9xaW2peUvHauznlUtQI1G
	 cCAFw8zBPE1ShnrCA1Lq286q4wwXAXvCKJ/y0omrZSQoopaWiyFM4nuWGHklEm5jeE
	 4TdnzlwxHlxk2Gmefax70vDRv8wTf87xFlCl2L4qyck/aybHgznek3mJTjkZ4z0icw
	 RjsFH0fBvQcyBvD33GAOFSL5VpiMsafmkwbHjDpWw38zDvLHkvcIgW4Y73AE+HRzrN
	 quRcweQBu6/oA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 17/39] unwind_user/sframe: Add support for reading .sframe headers
Date: Tue, 21 Jan 2025 18:31:09 -0800
Message-ID: <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for unwinding user space stacks with sframe, add basic
sframe compile infrastructure and support for reading the .sframe
section header.

sframe_add_section() reads the header and unconditionally returns an
error, so it's not very useful yet.  A subsequent patch will improve
that.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig           |   3 +
 include/linux/sframe.h |  36 +++++++++++
 kernel/unwind/Makefile |   3 +-
 kernel/unwind/sframe.c | 136 +++++++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h |  71 +++++++++++++++++++++
 5 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h

diff --git a/arch/Kconfig b/arch/Kconfig
index f1f7a3857c97..23edd0e4e16a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -446,6 +446,9 @@ config HAVE_UNWIND_USER_COMPAT_FP
 	bool
 	depends on HAVE_UNWIND_USER_FP
 
+config HAVE_UNWIND_USER_SFRAME
+	bool
+
 config AS_SFRAME
 	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
 
diff --git a/include/linux/sframe.h b/include/linux/sframe.h
new file mode 100644
index 000000000000..3bfaf21869c2
--- /dev/null
+++ b/include/linux/sframe.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SFRAME_H
+#define _LINUX_SFRAME_H
+
+#include <linux/mm_types.h>
+#include <linux/unwind_user_types.h>
+
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+
+struct sframe_section {
+	unsigned long	sframe_start;
+	unsigned long	sframe_end;
+	unsigned long	text_start;
+	unsigned long	text_end;
+
+	unsigned long	fdes_start;
+	unsigned long	fres_start;
+	unsigned long	fres_end;
+	unsigned int	num_fdes;
+
+	signed char	ra_off;
+	signed char	fp_off;
+};
+
+extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
+			      unsigned long text_start, unsigned long text_end);
+extern int sframe_remove_section(unsigned long sframe_addr);
+
+#else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
+
+static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end, unsigned long text_start, unsigned long text_end) { return -ENOSYS; }
+static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
+
+#endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
+
+#endif /* _LINUX_SFRAME_H */
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index 349ce3677526..f70380d7a6a6 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1 +1,2 @@
- obj-$(CONFIG_UNWIND_USER) += user.o
+ obj-$(CONFIG_UNWIND_USER)		+= user.o
+ obj-$(CONFIG_HAVE_UNWIND_USER_SFRAME)	+= sframe.o
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
new file mode 100644
index 000000000000..20287f795b36
--- /dev/null
+++ b/kernel/unwind/sframe.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace sframe access functions
+ */
+
+#define pr_fmt(fmt)	"sframe: " fmt
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/srcu.h>
+#include <linux/uaccess.h>
+#include <linux/mm.h>
+#include <linux/string_helpers.h>
+#include <linux/sframe.h>
+#include <linux/unwind_user_types.h>
+
+#include "sframe.h"
+
+#define dbg(fmt, ...)							\
+	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+
+static void free_section(struct sframe_section *sec)
+{
+	kfree(sec);
+}
+
+static int sframe_read_header(struct sframe_section *sec)
+{
+	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
+	struct sframe_header shdr;
+	unsigned int num_fdes;
+
+	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
+		dbg("header usercopy failed\n");
+		return -EFAULT;
+	}
+
+	if (shdr.preamble.magic != SFRAME_MAGIC ||
+	    shdr.preamble.version != SFRAME_VERSION_2 ||
+	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
+	    shdr.auxhdr_len) {
+		dbg("bad/unsupported sframe header\n");
+		return -EINVAL;
+	}
+
+	if (!shdr.num_fdes || !shdr.num_fres) {
+		dbg("no fde/fre entries\n");
+		return -EINVAL;
+	}
+
+	header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
+	if (header_end >= sec->sframe_end) {
+		dbg("header doesn't fit in section\n");
+		return -EINVAL;
+	}
+
+	num_fdes   = shdr.num_fdes;
+	fdes_start = header_end + shdr.fdes_off;
+	fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde));
+
+	fres_start = header_end + shdr.fres_off;
+	fres_end   = fres_start + shdr.fre_len;
+
+	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
+		dbg("inconsistent fde/fre offsets\n");
+		return -EINVAL;
+	}
+
+	sec->num_fdes		= num_fdes;
+	sec->fdes_start		= fdes_start;
+	sec->fres_start		= fres_start;
+	sec->fres_end		= fres_end;
+
+	sec->ra_off		= shdr.cfa_fixed_ra_offset;
+	sec->fp_off		= shdr.cfa_fixed_fp_offset;
+
+	return 0;
+}
+
+int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
+		       unsigned long text_start, unsigned long text_end)
+{
+	struct maple_tree *sframe_mt = &current->mm->sframe_mt;
+	struct vm_area_struct *sframe_vma, *text_vma;
+	struct mm_struct *mm = current->mm;
+	struct sframe_section *sec;
+	int ret;
+
+	if (!sframe_start || !sframe_end || !text_start || !text_end) {
+		dbg("zero-length sframe/text address\n");
+		return -EINVAL;
+	}
+
+	scoped_guard(mmap_read_lock, mm) {
+		sframe_vma = vma_lookup(mm, sframe_start);
+		if (!sframe_vma || sframe_end > sframe_vma->vm_end) {
+			dbg("bad sframe address (0x%lx - 0x%lx)\n",
+			    sframe_start, sframe_end);
+			return -EINVAL;
+		}
+
+		text_vma = vma_lookup(mm, text_start);
+		if (!text_vma ||
+		    !(text_vma->vm_flags & VM_EXEC) ||
+		    text_end > text_vma->vm_end) {
+			dbg("bad text address (0x%lx - 0x%lx)\n",
+			    text_start, text_end);
+			return -EINVAL;
+		}
+	}
+
+	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return -ENOMEM;
+
+	sec->sframe_start	= sframe_start;
+	sec->sframe_end		= sframe_end;
+	sec->text_start		= text_start;
+	sec->text_end		= text_end;
+
+	ret = sframe_read_header(sec);
+	if (ret)
+		goto err_free;
+
+	/* TODO nowhere to store it yet - just free it and return an error */
+	ret = -ENOSYS;
+
+err_free:
+	free_section(sec);
+	return ret;
+}
+
+int sframe_remove_section(unsigned long sframe_start)
+{
+	return -ENOSYS;
+}
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
new file mode 100644
index 000000000000..e9bfccfaf5b4
--- /dev/null
+++ b/kernel/unwind/sframe.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * From https://www.sourceware.org/binutils/docs/sframe-spec.html
+ */
+#ifndef _SFRAME_H
+#define _SFRAME_H
+
+#include <linux/types.h>
+
+#define SFRAME_VERSION_1			1
+#define SFRAME_VERSION_2			2
+#define SFRAME_MAGIC				0xdee2
+
+#define SFRAME_F_FDE_SORTED			0x1
+#define SFRAME_F_FRAME_POINTER			0x2
+
+#define SFRAME_ABI_AARCH64_ENDIAN_BIG		1
+#define SFRAME_ABI_AARCH64_ENDIAN_LITTLE	2
+#define SFRAME_ABI_AMD64_ENDIAN_LITTLE		3
+
+#define SFRAME_FDE_TYPE_PCINC			0
+#define SFRAME_FDE_TYPE_PCMASK			1
+
+struct sframe_preamble {
+	u16	magic;
+	u8	version;
+	u8	flags;
+} __packed;
+
+struct sframe_header {
+	struct sframe_preamble preamble;
+	u8	abi_arch;
+	s8	cfa_fixed_fp_offset;
+	s8	cfa_fixed_ra_offset;
+	u8	auxhdr_len;
+	u32	num_fdes;
+	u32	num_fres;
+	u32	fre_len;
+	u32	fdes_off;
+	u32	fres_off;
+} __packed;
+
+#define SFRAME_HEADER_SIZE(header) \
+	((sizeof(struct sframe_header) + header.auxhdr_len))
+
+#define SFRAME_AARCH64_PAUTH_KEY_A		0
+#define SFRAME_AARCH64_PAUTH_KEY_B		1
+
+struct sframe_fde {
+	s32	start_addr;
+	u32	func_size;
+	u32	fres_off;
+	u32	fres_num;
+	u8	info;
+	u8	rep_size;
+	u16 padding;
+} __packed;
+
+#define SFRAME_FUNC_FRE_TYPE(data)		(data & 0xf)
+#define SFRAME_FUNC_FDE_TYPE(data)		((data >> 4) & 0x1)
+#define SFRAME_FUNC_PAUTH_KEY(data)		((data >> 5) & 0x1)
+
+#define SFRAME_BASE_REG_FP			0
+#define SFRAME_BASE_REG_SP			1
+
+#define SFRAME_FRE_CFA_BASE_REG_ID(data)	(data & 0x1)
+#define SFRAME_FRE_OFFSET_COUNT(data)		((data >> 1) & 0xf)
+#define SFRAME_FRE_OFFSET_SIZE(data)		((data >> 5) & 0x3)
+#define SFRAME_FRE_MANGLED_RA_P(data)		((data >> 7) & 0x1)
+
+#endif /* _SFRAME_H */
-- 
2.48.1

