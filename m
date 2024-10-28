Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36223201002;
	Mon, 28 Oct 2024 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152099; cv=none; b=CvERukqEH1dVjvat5WEZSZRUSvSHmsDGOU21DxpAh7D1rJEobDjn5E0iPN2f57gwMdGb0RVtTlAgfaSt2NQSx0SENac9CTLhD19fKCq65zTYB+2PPQ6TNN2hPd5m1XZ1L/FtEGqXNULths/s7W4pMxMqfQrDga1Mb96aHh6o4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152099; c=relaxed/simple;
	bh=rdgA2R3zqlWRjVmrhibzoJo1v1b1aQtutEA2+nGCMKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbL25kwHqlYRgJJgyWXoX2eHMNbXi4C3mKgiYnS+/roMV0PjdzeCG79wBp1K1RA5SNRYF4v2LJZR7KXuOoIPUG4p2pmcXLqIOUQ8HhRs1V0BYiKEgJHUDdwPYPGY7q3nr4mkRBLkZc+92XOMvg1xOupNrtkNS3vEjcPjT2icpME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ8krWMB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ8krWMB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E05C4CEEB;
	Mon, 28 Oct 2024 21:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152098;
	bh=rdgA2R3zqlWRjVmrhibzoJo1v1b1aQtutEA2+nGCMKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZ8krWMBdEfrED3seMS4/SD8D5pJAaKzSriA88f9y1Ti1aVw+o+R1x3/zbVLgRY8U
	 6hWSVZBWtzemBgQRHAd+H4QetTO0p0opxR18WkXLPTI53aCjU84prQjpnzpGLC374W
	 //L9jDqFxx61LfEYy1kN3XKEWexXLBpKd+IdThA9dY92p8Fjln/bCWLbm8ZmlE2uHB
	 N+EQ8VP3YrjCYVz5lKeAmtvDyvLctyx/E43X18JDEEwgN8pjmnzYFu1iMXOcmtua/t
	 kNxlOMyZaFVKRtvZwEGIvwW0xfS/+jzaYdSqeCzE1Er0PRhcxMU9ZXvBY5ScdUoMVd
	 WTHavALL4jeRg==
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
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Date: Mon, 28 Oct 2024 14:47:36 -0700
Message-ID: <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distros have started compiling frame pointers into all their
packages to enable the kernel to do system-wide profiling of user space.
Unfortunately that creates a runtime performance penalty across the
entire system.  Using DWARF instead isn't feasible due to the complexity
it would add to the kernel.

For in-kernel unwinding we solved this problem with the creation of the
ORC unwinder for x86_64.  Similarly, for user space the GNU assembler
has created the sframe format starting with binutils 2.41 for sframe v2.
Sframe is a simpler version of .eh_frame.  It gets placed in the .sframe
section.

Add support for unwinding user space using sframe.

More information about sframe can be found here:

  - https://lwn.net/Articles/932209/
  - https://lwn.net/Articles/940686/
  - https://sourceware.org/binutils/docs/sframe-spec.html

Glibc support is needed to implement the prctl() calls to tell the
kernel where the .sframe segments are.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                |   4 +
 arch/x86/include/asm/mmu.h  |   2 +-
 fs/binfmt_elf.c             |  35 +++-
 include/linux/mm_types.h    |   3 +
 include/linux/sframe.h      |  41 ++++
 include/linux/unwind_user.h |   2 +
 include/uapi/linux/elf.h    |   1 +
 include/uapi/linux/prctl.h  |   3 +
 kernel/fork.c               |  10 +
 kernel/sys.c                |  11 ++
 kernel/unwind/Makefile      |   3 +-
 kernel/unwind/sframe.c      | 380 ++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h      | 215 ++++++++++++++++++++
 kernel/unwind/user.c        |  24 ++-
 mm/init-mm.c                |   6 +
 15 files changed, 732 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h

diff --git a/arch/Kconfig b/arch/Kconfig
index ee8ec97ea0ef..e769c39dd221 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -442,6 +442,10 @@ config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
 
+config HAVE_UNWIND_USER_SFRAME
+	bool
+	select UNWIND_USER
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index ce4677b8b735..12ea831978cc 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -73,7 +73,7 @@ typedef struct {
 	.context = {							\
 		.ctx_id = 1,						\
 		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
-	}
+	},
 
 void leave_mm(void);
 #define leave_mm leave_mm
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 06dc4a57ba78..434c548f0837 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -47,6 +47,7 @@
 #include <linux/dax.h>
 #include <linux/uaccess.h>
 #include <linux/rseq.h>
+#include <linux/sframe.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
@@ -633,11 +634,13 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 		unsigned long no_base, struct elf_phdr *interp_elf_phdata,
 		struct arch_elf_state *arch_state)
 {
-	struct elf_phdr *eppnt;
+	struct elf_phdr *eppnt, *sframe_phdr = NULL;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
 	unsigned long error = ~0UL;
 	unsigned long total_size;
+	unsigned long start_code = ~0UL;
+	unsigned long end_code = 0;
 	int i;
 
 	/* First of all, some simple consistency checks */
@@ -659,7 +662,8 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 
 	eppnt = interp_elf_phdata;
 	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
-		if (eppnt->p_type == PT_LOAD) {
+		switch (eppnt->p_type) {
+		case PT_LOAD: {
 			int elf_type = MAP_PRIVATE;
 			int elf_prot = make_prot(eppnt->p_flags, arch_state,
 						 true, true);
@@ -688,7 +692,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 			/*
 			 * Check to see if the section's size will overflow the
 			 * allowed task size. Note that p_filesz must always be
-			 * <= p_memsize so it's only necessary to check p_memsz.
+			 * <= p_memsz so it's only necessary to check p_memsz.
 			 */
 			k = load_addr + eppnt->p_vaddr;
 			if (BAD_ADDR(k) ||
@@ -698,9 +702,24 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				error = -ENOMEM;
 				goto out;
 			}
+
+			if ((eppnt->p_flags & PF_X) && k < start_code)
+				start_code = k;
+
+			if ((eppnt->p_flags & PF_X) && k + eppnt->p_filesz > end_code)
+				end_code = k + eppnt->p_filesz;
+			break;
+		}
+		case PT_GNU_SFRAME:
+			sframe_phdr = eppnt;
+			break;
 		}
 	}
 
+	if (sframe_phdr)
+		sframe_add_section(load_addr + sframe_phdr->p_vaddr,
+				   start_code, end_code);
+
 	error = load_addr;
 out:
 	return error;
@@ -823,7 +842,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	int first_pt_load = 1;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
-	struct elf_phdr *elf_property_phdata = NULL;
+	struct elf_phdr *elf_property_phdata = NULL, *sframe_phdr = NULL;
 	unsigned long elf_brk;
 	int retval, i;
 	unsigned long elf_entry;
@@ -931,6 +950,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 
+		case PT_GNU_SFRAME:
+			sframe_phdr = elf_ppnt;
+			break;
+
 		case PT_LOPROC ... PT_HIPROC:
 			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
 						  bprm->file, false,
@@ -1321,6 +1344,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 					    task_pid_nr(current), retval);
 	}
 
+	if (sframe_phdr)
+		sframe_add_section(load_bias + sframe_phdr->p_vaddr,
+				   start_code, end_code);
+
 	regs = current_pt_regs();
 #ifdef ELF_PLAT_INIT
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 381d22eba088..6e7561c1a5fc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1052,6 +1052,9 @@ struct mm_struct {
 #endif
 		} lru_gen;
 #endif /* CONFIG_LRU_GEN_WALKS_MMU */
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+		struct maple_tree sframe_mt;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/sframe.h b/include/linux/sframe.h
new file mode 100644
index 000000000000..d167e01817c4
--- /dev/null
+++ b/include/linux/sframe.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SFRAME_H
+#define _LINUX_SFRAME_H
+
+#include <linux/mm_types.h>
+
+struct unwind_user_frame;
+
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+
+#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0),
+
+extern void sframe_free_mm(struct mm_struct *mm);
+
+/* text_start, text_end, file_name are optional */
+extern int sframe_add_section(unsigned long sframe_addr, unsigned long text_start,
+			      unsigned long text_end);
+
+extern int sframe_remove_section(unsigned long sframe_addr);
+extern int sframe_find(unsigned long ip, struct unwind_user_frame *frame);
+
+static inline bool current_has_sframe(void)
+{
+	struct mm_struct *mm = current->mm;
+
+	return mm && !mtree_empty(&mm->sframe_mt);
+}
+
+#else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
+
+static inline void sframe_free_mm(struct mm_struct *mm) {}
+
+static inline int sframe_add_section(unsigned long sframe_addr, unsigned long text_start, unsigned long text_end) { return -EINVAL; }
+static inline int sframe_remove_section(unsigned long sframe_addr) { return -EINVAL; }
+static inline int sframe_find(unsigned long ip, struct unwind_user_frame *frame) { return -EINVAL; }
+
+static inline bool current_has_sframe(void) { return false; }
+
+#endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
+
+#endif /* _LINUX_SFRAME_H */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 9d28db06f33f..cde0fde4923e 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -5,7 +5,9 @@
 #include <linux/types.h>
 
 enum unwind_user_type {
+	UNWIND_USER_TYPE_NONE,
 	UNWIND_USER_TYPE_FP,
+	UNWIND_USER_TYPE_SFRAME,
 };
 
 struct unwind_stacktrace {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b9935988da5c..4dc3f0ca5af5 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -39,6 +39,7 @@ typedef __s64	Elf64_Sxword;
 #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
 #define PT_GNU_RELRO	(PT_LOOS + 0x474e552)
 #define PT_GNU_PROPERTY	(PT_LOOS + 0x474e553)
+#define PT_GNU_SFRAME	(PT_LOOS + 0x474e554)
 
 
 /* ARM MTE memory tag segment type */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879..69511077c910 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,7 @@ struct prctl_mm_map {
 # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
 # define PR_PPC_DEXCR_CTRL_MASK		0x1f
 
+#define PR_ADD_SFRAME			74
+#define PR_REMOVE_SFRAME		75
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index c056ea95fe8c..60f14fbab956 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <linux/rseq.h>
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
+#include <linux/sframe.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -924,6 +925,7 @@ void __mmdrop(struct mm_struct *mm)
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
+	sframe_free_mm(mm);
 
 	free_mm(mm);
 }
@@ -1251,6 +1253,13 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 #endif
 }
 
+static void mm_init_sframe(struct mm_struct *mm)
+{
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+	mt_init(&mm->sframe_mt);
+#endif
+}
+
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
@@ -1282,6 +1291,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->pmd_huge_pte = NULL;
 #endif
 	mm_init_uprobes_state(mm);
+	mm_init_sframe(mm);
 	hugetlb_count_init(mm);
 
 	if (current->mm) {
diff --git a/kernel/sys.c b/kernel/sys.c
index 4da31f28fda8..7d05a67727db 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -64,6 +64,7 @@
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
+#include <linux/sframe.h>
 
 #include <linux/nospec.h>
 
@@ -2784,6 +2785,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
 		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
 		break;
+	case PR_ADD_SFRAME:
+		if (arg5)
+			return -EINVAL;
+		error = sframe_add_section(arg2, arg3, arg4);
+		break;
+	case PR_REMOVE_SFRAME:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = sframe_remove_section(arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
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
index 000000000000..933e47696e29
--- /dev/null
+++ b/kernel/unwind/sframe.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt)	"sframe: " fmt
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/srcu.h>
+#include <linux/uaccess.h>
+#include <linux/mm.h>
+#include <linux/sframe.h>
+#include <linux/unwind_user.h>
+
+#include "sframe.h"
+
+#define SFRAME_FILENAME_LEN 32
+
+struct sframe_section {
+	struct rcu_head rcu;
+
+	unsigned long sframe_addr;
+	unsigned long text_addr;
+
+	unsigned long fdes_addr;
+	unsigned long fres_addr;
+	unsigned int  fdes_nr;
+	signed char   ra_off;
+	signed char   fp_off;
+};
+
+DEFINE_STATIC_SRCU(sframe_srcu);
+
+#define __SFRAME_GET_USER(out, user_ptr, type)				\
+({									\
+	type __tmp;							\
+	if (get_user(__tmp, (type __user *)user_ptr))			\
+		return -EFAULT;						\
+	user_ptr += sizeof(__tmp);					\
+	out = __tmp;							\
+})
+
+#define SFRAME_GET_USER(out, user_ptr, size)				\
+({									\
+	switch (size) {							\
+	case 1:								\
+		__SFRAME_GET_USER(out, user_ptr, u8);			\
+		break;							\
+	case 2:								\
+		__SFRAME_GET_USER(out, user_ptr, u16);			\
+		break;							\
+	case 4:								\
+		__SFRAME_GET_USER(out, user_ptr, u32);			\
+		break;							\
+	default:							\
+		return -EINVAL;						\
+	}								\
+})
+
+static unsigned char fre_type_to_size(unsigned char fre_type)
+{
+	if (fre_type > 2)
+		return 0;
+	return 1 << fre_type;
+}
+
+static unsigned char offset_size_enum_to_size(unsigned char off_size)
+{
+	if (off_size > 2)
+		return 0;
+	return 1 << off_size;
+}
+
+static int find_fde(struct sframe_section *sec, unsigned long ip,
+		    struct sframe_fde *fde)
+{
+	struct sframe_fde __user *first, *last, *found = NULL;
+	u32 ip_off, func_off_low = 0, func_off_high = -1;
+
+	ip_off = ip - sec->sframe_addr;
+
+	first = (void __user *)sec->fdes_addr;
+	last = first + sec->fdes_nr;
+	while (first <= last) {
+		struct sframe_fde __user *mid;
+		u32 func_off;
+
+		mid = first + ((last - first) / 2);
+
+		if (get_user(func_off, (s32 __user *)mid))
+			return -EFAULT;
+
+		if (ip_off >= func_off) {
+			/* validate sort order */
+			if (func_off < func_off_low)
+				return -EINVAL;
+
+			func_off_low = func_off;
+
+			found = mid;
+			first = mid + 1;
+		} else {
+			/* validate sort order */
+			if (func_off > func_off_high)
+				return -EINVAL;
+
+			func_off_high = func_off;
+
+			last = mid - 1;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	if (copy_from_user(fde, found, sizeof(*fde)))
+		return -EFAULT;
+
+	/* check for gaps */
+	if (ip_off < fde->start_addr || ip_off >= fde->start_addr + fde->size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int find_fre(struct sframe_section *sec, struct sframe_fde *fde,
+		    unsigned long ip, struct unwind_user_frame *frame)
+{
+	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
+	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
+	unsigned char offset_count, offset_size;
+	s32 cfa_off, ra_off, fp_off, ip_off;
+	void __user *f, *last_f = NULL;
+	unsigned char addr_size;
+	u32 last_fre_ip_off = 0;
+	u8 fre_info = 0;
+	int i;
+
+	addr_size = fre_type_to_size(fre_type);
+	if (!addr_size)
+		return -EINVAL;
+
+	ip_off = ip - (sec->sframe_addr + fde->start_addr);
+
+	f = (void __user *)sec->fres_addr + fde->fres_off;
+
+	for (i = 0; i < fde->fres_num; i++) {
+		u32 fre_ip_off;
+
+		SFRAME_GET_USER(fre_ip_off, f, addr_size);
+
+		if (fre_ip_off < last_fre_ip_off)
+			return -EINVAL;
+
+		last_fre_ip_off = fre_ip_off;
+
+		if (fde_type == SFRAME_FDE_TYPE_PCINC) {
+			if (ip_off < fre_ip_off)
+				break;
+		} else {
+			/* SFRAME_FDE_TYPE_PCMASK */
+			if (ip_off % fde->rep_size < fre_ip_off)
+				break;
+		}
+
+		SFRAME_GET_USER(fre_info, f, 1);
+
+		offset_count = SFRAME_FRE_OFFSET_COUNT(fre_info);
+		offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(fre_info));
+
+		if (!offset_count || !offset_size)
+			return -EINVAL;
+
+		last_f = f;
+		f += offset_count * offset_size;
+	}
+
+	if (!last_f)
+		return -EINVAL;
+
+	f = last_f;
+
+	SFRAME_GET_USER(cfa_off, f, offset_size);
+	offset_count--;
+
+	ra_off = sec->ra_off;
+	if (!ra_off) {
+		if (!offset_count--)
+			return -EINVAL;
+
+		SFRAME_GET_USER(ra_off, f, offset_size);
+	}
+
+	fp_off = sec->fp_off;
+	if (!fp_off && offset_count) {
+		offset_count--;
+		SFRAME_GET_USER(fp_off, f, offset_size);
+	}
+
+	if (offset_count)
+		return -EINVAL;
+
+	frame->cfa_off = cfa_off;
+	frame->ra_off = ra_off;
+	frame->fp_off = fp_off;
+	frame->use_fp = SFRAME_FRE_CFA_BASE_REG_ID(fre_info) == SFRAME_BASE_REG_FP;
+
+	return 0;
+}
+
+int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
+{
+	struct mm_struct *mm = current->mm;
+	struct sframe_section *sec;
+	struct sframe_fde fde;
+	int ret = -EINVAL;
+
+	if (!mm)
+		return -EINVAL;
+
+	guard(srcu)(&sframe_srcu);
+
+	sec = mtree_load(&mm->sframe_mt, ip);
+	if (!sec)
+		return ret;
+
+	ret = find_fde(sec, ip, &fde);
+	if (ret)
+		return ret;
+
+	ret = find_fre(sec, &fde, ip, frame);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int __sframe_add_section(unsigned long sframe_addr,
+				unsigned long text_start,
+				unsigned long text_end)
+{
+	struct maple_tree *sframe_mt = &current->mm->sframe_mt;
+	struct sframe_section *sec;
+	struct sframe_header shdr;
+	unsigned long header_end;
+	int ret;
+
+	if (copy_from_user(&shdr, (void __user *)sframe_addr, sizeof(shdr)))
+		return -EFAULT;
+
+	if (shdr.preamble.magic != SFRAME_MAGIC ||
+	    shdr.preamble.version != SFRAME_VERSION_2 ||
+	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
+	    shdr.auxhdr_len || !shdr.num_fdes || !shdr.num_fres ||
+	    shdr.fdes_off > shdr.fres_off) {
+		return -EINVAL;
+	}
+
+	sec = kmalloc(sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return -ENOMEM;
+
+	header_end = sframe_addr + SFRAME_HDR_SIZE(shdr);
+
+	sec->sframe_addr	= sframe_addr;
+	sec->text_addr		= text_start;
+	sec->fdes_addr		= header_end + shdr.fdes_off;
+	sec->fres_addr		= header_end + shdr.fres_off;
+	sec->fdes_nr		= shdr.num_fdes;
+	sec->ra_off		= shdr.cfa_fixed_ra_offset;
+	sec->fp_off		= shdr.cfa_fixed_fp_offset;
+
+	ret = mtree_insert_range(sframe_mt, text_start, text_end, sec, GFP_KERNEL);
+	if (ret) {
+		kfree(sec);
+		return ret;
+	}
+
+	return 0;
+}
+
+int sframe_add_section(unsigned long sframe_addr, unsigned long text_start,
+		       unsigned long text_end)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *sframe_vma;
+
+	mmap_read_lock(mm);
+
+	sframe_vma = vma_lookup(mm, sframe_addr);
+	if (!sframe_vma)
+		goto err_unlock;
+
+	if (text_start && text_end) {
+		struct vm_area_struct *text_vma;
+
+		text_vma = vma_lookup(mm, text_start);
+		if (!(text_vma->vm_flags & VM_EXEC))
+			goto err_unlock;
+
+		if (PAGE_ALIGN(text_end) != text_vma->vm_end)
+			goto err_unlock;
+	} else {
+		struct vm_area_struct *vma, *text_vma = NULL;
+		VMA_ITERATOR(vmi, mm, 0);
+
+		for_each_vma(vmi, vma) {
+			if (vma->vm_file != sframe_vma->vm_file ||
+			    !(vma->vm_flags & VM_EXEC))
+				continue;
+
+			if (text_vma) {
+				pr_warn_once("%s[%d]: multiple EXEC segments unsupported\n",
+					     current->comm, current->pid);
+				goto err_unlock;
+			}
+
+			text_vma = vma;
+		}
+
+		if (!text_vma)
+			goto err_unlock;
+
+		text_start = text_vma->vm_start;
+		text_end   = text_vma->vm_end;
+	}
+
+	mmap_read_unlock(mm);
+
+	return __sframe_add_section(sframe_addr, text_start, text_end);
+
+err_unlock:
+	mmap_read_unlock(mm);
+	return -EINVAL;
+}
+
+static void sframe_free_srcu(struct rcu_head *rcu)
+{
+	struct sframe_section *sec = container_of(rcu, struct sframe_section, rcu);
+
+	kfree(sec);
+}
+
+static int __sframe_remove_section(struct mm_struct *mm,
+				   struct sframe_section *sec)
+{
+	sec = mtree_erase(&mm->sframe_mt, sec->text_addr);
+	if (!sec)
+		return -EINVAL;
+
+	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);
+
+	return 0;
+}
+
+int sframe_remove_section(unsigned long sframe_addr)
+{
+	struct mm_struct *mm = current->mm;
+	struct sframe_section *sec;
+	unsigned long index = 0;
+
+	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
+		if (sec->sframe_addr == sframe_addr)
+			return __sframe_remove_section(mm, sec);
+	}
+
+	return -EINVAL;
+}
+
+void sframe_free_mm(struct mm_struct *mm)
+{
+	struct sframe_section *sec;
+	unsigned long index = 0;
+
+	if (!mm)
+		return;
+
+	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX)
+		kfree(sec);
+
+	mtree_destroy(&mm->sframe_mt);
+}
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
new file mode 100644
index 000000000000..11b9be7ad82e
--- /dev/null
+++ b/kernel/unwind/sframe.h
@@ -0,0 +1,215 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023, Oracle and/or its affiliates.
+ *
+ * This file contains definitions for the SFrame stack tracing format, which is
+ * documented at https://sourceware.org/binutils/docs
+ */
+#ifndef _SFRAME_H
+#define _SFRAME_H
+
+#include <linux/types.h>
+
+#define SFRAME_VERSION_1	1
+#define SFRAME_VERSION_2	2
+#define SFRAME_MAGIC		0xdee2
+
+/* Function Descriptor Entries are sorted on PC. */
+#define SFRAME_F_FDE_SORTED	0x1
+/* Frame-pointer based stack tracing. Defined, but not set. */
+#define SFRAME_F_FRAME_POINTER	0x2
+
+#define SFRAME_CFA_FIXED_FP_INVALID 0
+#define SFRAME_CFA_FIXED_RA_INVALID 0
+
+/* Supported ABIs/Arch. */
+#define SFRAME_ABI_AARCH64_ENDIAN_BIG	    1 /* AARCH64 big endian. */
+#define SFRAME_ABI_AARCH64_ENDIAN_LITTLE    2 /* AARCH64 little endian. */
+#define SFRAME_ABI_AMD64_ENDIAN_LITTLE	    3 /* AMD64 little endian. */
+
+/* SFrame FRE types. */
+#define SFRAME_FRE_TYPE_ADDR1	0
+#define SFRAME_FRE_TYPE_ADDR2	1
+#define SFRAME_FRE_TYPE_ADDR4	2
+
+/*
+ * SFrame Function Descriptor Entry types.
+ *
+ * The SFrame format has two possible representations for functions. The
+ * choice of which type to use is made according to the instruction patterns
+ * in the relevant program stub.
+ */
+
+/* Unwinders perform a (PC >= FRE_START_ADDR) to look up a matching FRE. */
+#define SFRAME_FDE_TYPE_PCINC	0
+/*
+ * Unwinders perform a (PC & FRE_START_ADDR_AS_MASK >= FRE_START_ADDR_AS_MASK)
+ * to look up a matching FRE. Typical usecases are pltN entries, trampolines
+ * etc.
+ */
+#define SFRAME_FDE_TYPE_PCMASK	1
+
+/**
+ * struct sframe_preamble - SFrame Preamble.
+ * @magic: Magic number (SFRAME_MAGIC).
+ * @version: Format version number (SFRAME_VERSION).
+ * @flags: Various flags.
+ */
+struct sframe_preamble {
+	u16 magic;
+	u8  version;
+	u8  flags;
+} __packed;
+
+/**
+ * struct sframe_header - SFrame Header.
+ * @preamble: SFrame preamble.
+ * @abi_arch: Identify the arch (including endianness) and ABI.
+ * @cfa_fixed_fp_offset: Offset for the Frame Pointer (FP) from CFA may be
+ *	  fixed for some ABIs ((e.g, in AMD64 when -fno-omit-frame-pointer is
+ *	  used). When fixed, this field specifies the fixed stack frame offset
+ *	  and the individual FREs do not need to track it. When not fixed, it
+ *	  is set to SFRAME_CFA_FIXED_FP_INVALID, and the individual FREs may
+ *	  provide the applicable stack frame offset, if any.
+ * @cfa_fixed_ra_offset: Offset for the Return Address from CFA is fixed for
+ *	  some ABIs. When fixed, this field specifies the fixed stack frame
+ *	  offset and the individual FREs do not need to track it. When not
+ *	  fixed, it is set to SFRAME_CFA_FIXED_FP_INVALID.
+ * @auxhdr_len: Number of bytes making up the auxiliary header, if any.
+ *	  Some ABI/arch, in the future, may use this space for extending the
+ *	  information in SFrame header. Auxiliary header is contained in bytes
+ *	  sequentially following the sframe_header.
+ * @num_fdes: Number of SFrame FDEs in this SFrame section.
+ * @num_fres: Number of SFrame Frame Row Entries.
+ * @fre_len:  Number of bytes in the SFrame Frame Row Entry section.
+ * @fdes_off: Offset of SFrame Function Descriptor Entry section.
+ * @fres_off: Offset of SFrame Frame Row Entry section.
+ */
+struct sframe_header {
+	struct sframe_preamble preamble;
+	u8  abi_arch;
+	s8  cfa_fixed_fp_offset;
+	s8  cfa_fixed_ra_offset;
+	u8  auxhdr_len;
+	u32 num_fdes;
+	u32 num_fres;
+	u32 fre_len;
+	u32 fdes_off;
+	u32 fres_off;
+} __packed;
+
+#define SFRAME_HDR_SIZE(sframe_hdr)	\
+	((sizeof(struct sframe_header) + (sframe_hdr).auxhdr_len))
+
+/* Two possible keys for executable (instruction) pointers signing. */
+#define SFRAME_AARCH64_PAUTH_KEY_A    0 /* Key A. */
+#define SFRAME_AARCH64_PAUTH_KEY_B    1 /* Key B. */
+
+/**
+ * struct sframe_fde - SFrame Function Descriptor Entry.
+ * @start_addr: Function start address. Encoded as a signed offset,
+ *	  relative to the current FDE.
+ * @size: Size of the function in bytes.
+ * @fres_off: Offset of the first SFrame Frame Row Entry of the function,
+ *	  relative to the beginning of the SFrame Frame Row Entry sub-section.
+ * @fres_num: Number of frame row entries for the function.
+ * @info: Additional information for deciphering the stack trace
+ *	  information for the function. Contains information about SFrame FRE
+ *	  type, SFrame FDE type, PAC authorization A/B key, etc.
+ * @rep_size: Block size for SFRAME_FDE_TYPE_PCMASK
+ * @padding: Unused
+ */
+struct sframe_fde {
+	s32 start_addr;
+	u32 size;
+	u32 fres_off;
+	u32 fres_num;
+	u8  info;
+	u8  rep_size;
+	u16 padding;
+} __packed;
+
+/*
+ * 'func_info' in SFrame FDE contains additional information for deciphering
+ * the stack trace information for the function. In V1, the information is
+ * organized as follows:
+ *   - 4-bits: Identify the FRE type used for the function.
+ *   - 1-bit: Identify the FDE type of the function - mask or inc.
+ *   - 1-bit: PAC authorization A/B key (aarch64).
+ *   - 2-bits: Unused.
+ * ---------------------------------------------------------------------
+ * |  Unused  |  PAC auth A/B key (aarch64) |  FDE type |   FRE type   |
+ * |          |        Unused (amd64)       |           |              |
+ * ---------------------------------------------------------------------
+ * 8          6                             5           4              0
+ */
+
+/* Note: Set PAC auth key to SFRAME_AARCH64_PAUTH_KEY_A by default.  */
+#define SFRAME_FUNC_INFO(fde_type, fre_enc_type) \
+	(((SFRAME_AARCH64_PAUTH_KEY_A & 0x1) << 5) | \
+	 (((fde_type) & 0x1) << 4) | ((fre_enc_type) & 0xf))
+
+#define SFRAME_FUNC_FRE_TYPE(data)	  ((data) & 0xf)
+#define SFRAME_FUNC_FDE_TYPE(data)	  (((data) >> 4) & 0x1)
+#define SFRAME_FUNC_PAUTH_KEY(data)	  (((data) >> 5) & 0x1)
+
+/*
+ * Size of stack frame offsets in an SFrame Frame Row Entry. A single
+ * SFrame FRE has all offsets of the same size. Offset size may vary
+ * across frame row entries.
+ */
+#define SFRAME_FRE_OFFSET_1B	  0
+#define SFRAME_FRE_OFFSET_2B	  1
+#define SFRAME_FRE_OFFSET_4B	  2
+
+/* An SFrame Frame Row Entry can be SP or FP based.  */
+#define SFRAME_BASE_REG_FP	0
+#define SFRAME_BASE_REG_SP	1
+
+/*
+ * The index at which a specific offset is presented in the variable length
+ * bytes of an FRE.
+ */
+#define SFRAME_FRE_CFA_OFFSET_IDX   0
+/*
+ * The RA stack offset, if present, will always be at index 1 in the variable
+ * length bytes of the FRE.
+ */
+#define SFRAME_FRE_RA_OFFSET_IDX    1
+/*
+ * The FP stack offset may appear at offset 1 or 2, depending on the ABI as RA
+ * may or may not be tracked.
+ */
+#define SFRAME_FRE_FP_OFFSET_IDX    2
+
+/*
+ * 'fre_info' in SFrame FRE contains information about:
+ *   - 1 bit: base reg for CFA
+ *   - 4 bits: Number of offsets (N). A value of up to 3 is allowed to track
+ *   all three of CFA, FP and RA (fixed implicit order).
+ *   - 2 bits: information about size of the offsets (S) in bytes.
+ *     Valid values are SFRAME_FRE_OFFSET_1B, SFRAME_FRE_OFFSET_2B,
+ *     SFRAME_FRE_OFFSET_4B
+ *   - 1 bit: Mangled RA state bit (aarch64 only).
+ * ---------------------------------------------------------------
+ * | Mangled-RA (aarch64) |  Size of   |   Number of  | base_reg |
+ * |  Unused (amd64)      |  offsets   |    offsets   |          |
+ * ---------------------------------------------------------------
+ * 8                      7             5             1          0
+ */
+
+/* Note: Set mangled_ra_p to zero by default. */
+#define SFRAME_FRE_INFO(base_reg_id, offset_num, offset_size) \
+	(((0 & 0x1) << 7) | (((offset_size) & 0x3) << 5) | \
+	 (((offset_num) & 0xf) << 1) | ((base_reg_id) & 0x1))
+
+/* Set the mangled_ra_p bit as indicated. */
+#define SFRAME_FRE_INFO_UPDATE_MANGLED_RA_P(mangled_ra_p, fre_info) \
+	((((mangled_ra_p) & 0x1) << 7) | ((fre_info) & 0x7f))
+
+#define SFRAME_FRE_CFA_BASE_REG_ID(data)	  ((data) & 0x1)
+#define SFRAME_FRE_OFFSET_COUNT(data)		  (((data) >> 1) & 0xf)
+#define SFRAME_FRE_OFFSET_SIZE(data)		  (((data) >> 5) & 0x3)
+#define SFRAME_FRE_MANGLED_RA_P(data)		  (((data) >> 7) & 0x1)
+
+#endif /* _SFRAME_H */
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 54b989810a0e..8e47c80e3e54 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -8,12 +8,17 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
+#include <linux/sframe.h>
 #include <linux/uaccess.h>
-#include <asm/unwind_user.h>
 
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+#include <asm/unwind_user.h>
 static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
 };
+#else
+static struct unwind_user_frame fp_frame;
+#endif
 
 int unwind_user_next(struct unwind_user_state *state)
 {
@@ -30,6 +35,16 @@ int unwind_user_next(struct unwind_user_state *state)
 	case UNWIND_USER_TYPE_FP:
 		frame = &fp_frame;
 		break;
+	case UNWIND_USER_TYPE_SFRAME:
+		if (sframe_find(state->ip, frame)) {
+			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+				goto the_end;
+
+			frame = &fp_frame;
+		}
+		break;
+	case UNWIND_USER_TYPE_NONE:
+		goto the_end;
 	default:
 		BUG();
 	}
@@ -68,7 +83,12 @@ int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
-	state->type = UNWIND_USER_TYPE_FP;
+	if (current_has_sframe())
+		state->type = UNWIND_USER_TYPE_SFRAME;
+	else if (IS_ENABLED(CONFIG_UNWIND_USER_FP))
+		state->type = UNWIND_USER_TYPE_FP;
+	else
+		state->type = UNWIND_USER_TYPE_NONE;
 
 	state->sp = user_stack_pointer(regs);
 	state->ip = instruction_pointer(regs);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 24c809379274..8eb1b122b7bf 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -11,12 +11,17 @@
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
 #include <linux/iommu.h>
+#include <linux/sframe.h>
 #include <asm/mmu.h>
 
 #ifndef INIT_MM_CONTEXT
 #define INIT_MM_CONTEXT(name)
 #endif
 
+#ifndef INIT_MM_SFRAME
+#define INIT_MM_SFRAME
+#endif
+
 const struct vm_operations_struct vma_dummy_vm_ops;
 
 /*
@@ -45,6 +50,7 @@ struct mm_struct init_mm = {
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
 	INIT_MM_CONTEXT(init_mm)
+	INIT_MM_SFRAME
 };
 
 void setup_initial_init_mm(void *start_code, void *end_code,
-- 
2.47.0

