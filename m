From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/5] tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
Date: Mon, 30 Jul 2018 17:50:30 -0300
Message-ID: <20180730205031.12853-5-acme@kernel.org>
References: <20180730205031.12853-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Namhyung Kim <namhyung@kernel.org>, Tony Luck <tony.luck@intel.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To cope with the changes in:

  12c89130a56a ("x86/asm/memcpy_mcsafe: Add write-protection-fault handling")
  60622d68227d ("x86/asm/memcpy_mcsafe: Return bytes remaining")
  bd131544aa7e ("x86/asm/memcpy_mcsafe: Add labels for __memcpy_mcsafe() write fault handling")
  da7bc9c57eb0 ("x86/asm/memcpy_mcsafe: Remove loop unrolling")

This needed introducing a file with a copy of the mcsafe_handle_tail()
function, that is used in the new memcpy_64.S file, as well as a dummy
mcsafe_test.h header.

Testing it:

  $ nm ~/bin/perf | grep mcsafe
  0000000000484130 T mcsafe_handle_tail
  0000000000484300 T __memcpy_mcsafe
  $
  $ perf bench mem memcpy
  # Running 'mem/memcpy' benchmark:
  # function 'default' (Default memcpy() provided by glibc)
  # Copying 1MB bytes ...

      44.389205 GB/sec
  # function 'x86-64-unrolled' (unrolled memcpy() in arch/x86/lib/memcpy_64.S)
  # Copying 1MB bytes ...

      22.710756 GB/sec
  # function 'x86-64-movsq' (movsq-based memcpy() in arch/x86/lib/memcpy_64.S)
  # Copying 1MB bytes ...

      42.459239 GB/sec
  # function 'x86-64-movsb' (movsb-based memcpy() in arch/x86/lib/memcpy_64.S)
  # Copying 1MB bytes ...

      42.459239 GB/sec
  $

This silences this perf tools build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mika Penttilä <mika.penttila@nextfour.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-igdpciheradk3gb3qqal52d0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/mcsafe_test.h |  13 ++++
 tools/arch/x86/lib/memcpy_64.S           | 112 +++++++++++++++----------------
 tools/perf/bench/Build                   |   1 +
 tools/perf/bench/mem-memcpy-x86-64-asm.S |   1 +
 tools/perf/bench/mem-memcpy-x86-64-lib.c |  24 +++++++
 5 files changed, 93 insertions(+), 58 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/mcsafe_test.h
 create mode 100644 tools/perf/bench/mem-memcpy-x86-64-lib.c

diff --git a/tools/arch/x86/include/asm/mcsafe_test.h b/tools/arch/x86/include/asm/mcsafe_test.h
new file mode 100644
index 000000000000..2ccd588fbad4
--- /dev/null
+++ b/tools/arch/x86/include/asm/mcsafe_test.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MCSAFE_TEST_H_
+#define _MCSAFE_TEST_H_
+
+.macro MCSAFE_TEST_CTL
+.endm
+
+.macro MCSAFE_TEST_SRC reg count target
+.endm
+
+.macro MCSAFE_TEST_DST reg count target
+.endm
+#endif /* _MCSAFE_TEST_H_ */
diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 9a53a06e5a3e..298ef1479240 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -3,6 +3,7 @@
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
+#include <asm/mcsafe_test.h>
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 
@@ -183,12 +184,15 @@ ENTRY(memcpy_orig)
 ENDPROC(memcpy_orig)
 
 #ifndef CONFIG_UML
+
+MCSAFE_TEST_CTL
+
 /*
- * memcpy_mcsafe_unrolled - memory copy with machine check exception handling
+ * __memcpy_mcsafe - memory copy with machine check exception handling
  * Note that we only catch machine checks when reading the source addresses.
  * Writes to target are posted and don't generate machine checks.
  */
-ENTRY(memcpy_mcsafe_unrolled)
+ENTRY(__memcpy_mcsafe)
 	cmpl $8, %edx
 	/* Less than 8 bytes? Go to byte copy loop */
 	jb .L_no_whole_words
@@ -204,58 +208,33 @@ ENTRY(memcpy_mcsafe_unrolled)
 	subl $8, %ecx
 	negl %ecx
 	subl %ecx, %edx
-.L_copy_leading_bytes:
+.L_read_leading_bytes:
 	movb (%rsi), %al
+	MCSAFE_TEST_SRC %rsi 1 .E_leading_bytes
+	MCSAFE_TEST_DST %rdi 1 .E_leading_bytes
+.L_write_leading_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_leading_bytes
+	jnz .L_read_leading_bytes
 
 .L_8byte_aligned:
-	/* Figure out how many whole cache lines (64-bytes) to copy */
-	movl %edx, %ecx
-	andl $63, %edx
-	shrl $6, %ecx
-	jz .L_no_whole_cache_lines
-
-	/* Loop copying whole cache lines */
-.L_cache_w0: movq (%rsi), %r8
-.L_cache_w1: movq 1*8(%rsi), %r9
-.L_cache_w2: movq 2*8(%rsi), %r10
-.L_cache_w3: movq 3*8(%rsi), %r11
-	movq %r8, (%rdi)
-	movq %r9, 1*8(%rdi)
-	movq %r10, 2*8(%rdi)
-	movq %r11, 3*8(%rdi)
-.L_cache_w4: movq 4*8(%rsi), %r8
-.L_cache_w5: movq 5*8(%rsi), %r9
-.L_cache_w6: movq 6*8(%rsi), %r10
-.L_cache_w7: movq 7*8(%rsi), %r11
-	movq %r8, 4*8(%rdi)
-	movq %r9, 5*8(%rdi)
-	movq %r10, 6*8(%rdi)
-	movq %r11, 7*8(%rdi)
-	leaq 64(%rsi), %rsi
-	leaq 64(%rdi), %rdi
-	decl %ecx
-	jnz .L_cache_w0
-
-	/* Are there any trailing 8-byte words? */
-.L_no_whole_cache_lines:
 	movl %edx, %ecx
 	andl $7, %edx
 	shrl $3, %ecx
 	jz .L_no_whole_words
 
-	/* Copy trailing words */
-.L_copy_trailing_words:
+.L_read_words:
 	movq (%rsi), %r8
-	mov %r8, (%rdi)
-	leaq 8(%rsi), %rsi
-	leaq 8(%rdi), %rdi
+	MCSAFE_TEST_SRC %rsi 8 .E_read_words
+	MCSAFE_TEST_DST %rdi 8 .E_write_words
+.L_write_words:
+	movq %r8, (%rdi)
+	addq $8, %rsi
+	addq $8, %rdi
 	decl %ecx
-	jnz .L_copy_trailing_words
+	jnz .L_read_words
 
 	/* Any trailing bytes? */
 .L_no_whole_words:
@@ -264,38 +243,55 @@ ENTRY(memcpy_mcsafe_unrolled)
 
 	/* Copy trailing bytes */
 	movl %edx, %ecx
-.L_copy_trailing_bytes:
+.L_read_trailing_bytes:
 	movb (%rsi), %al
+	MCSAFE_TEST_SRC %rsi 1 .E_trailing_bytes
+	MCSAFE_TEST_DST %rdi 1 .E_trailing_bytes
+.L_write_trailing_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_trailing_bytes
+	jnz .L_read_trailing_bytes
 
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
 	xorq %rax, %rax
 	ret
-ENDPROC(memcpy_mcsafe_unrolled)
-EXPORT_SYMBOL_GPL(memcpy_mcsafe_unrolled)
+ENDPROC(__memcpy_mcsafe)
+EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 
 	.section .fixup, "ax"
-	/* Return -EFAULT for any failure */
-.L_memcpy_mcsafe_fail:
-	mov	$-EFAULT, %rax
+	/*
+	 * Return number of bytes not copied for any failure. Note that
+	 * there is no "tail" handling since the source buffer is 8-byte
+	 * aligned and poison is cacheline aligned.
+	 */
+.E_read_words:
+	shll	$3, %ecx
+.E_leading_bytes:
+	addl	%edx, %ecx
+.E_trailing_bytes:
+	mov	%ecx, %eax
 	ret
 
+	/*
+	 * For write fault handling, given the destination is unaligned,
+	 * we handle faults on multi-byte writes with a byte-by-byte
+	 * copy up to the write-protected page.
+	 */
+.E_write_words:
+	shll	$3, %ecx
+	addl	%edx, %ecx
+	movl	%ecx, %edx
+	jmp mcsafe_handle_tail
+
 	.previous
 
-	_ASM_EXTABLE_FAULT(.L_copy_leading_bytes, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w0, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w1, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w2, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w3, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w4, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w5, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w6, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w7, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_words, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_bytes, .L_memcpy_mcsafe_fail)
+	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE_FAULT(.L_read_words, .E_read_words)
+	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .E_trailing_bytes)
+	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE(.L_write_words, .E_write_words)
+	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
 #endif
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 60bf11943047..eafce1a130a1 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -7,6 +7,7 @@ perf-y += futex-wake-parallel.o
 perf-y += futex-requeue.o
 perf-y += futex-lock-pi.o
 
+perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
 
diff --git a/tools/perf/bench/mem-memcpy-x86-64-asm.S b/tools/perf/bench/mem-memcpy-x86-64-asm.S
index b43f8d2a34ec..9ad015a1e202 100644
--- a/tools/perf/bench/mem-memcpy-x86-64-asm.S
+++ b/tools/perf/bench/mem-memcpy-x86-64-asm.S
@@ -6,6 +6,7 @@
 #define altinstr_replacement text
 #define globl p2align 4; .globl
 #define _ASM_EXTABLE_FAULT(x, y)
+#define _ASM_EXTABLE(x, y)
 
 #include "../../arch/x86/lib/memcpy_64.S"
 /*
diff --git a/tools/perf/bench/mem-memcpy-x86-64-lib.c b/tools/perf/bench/mem-memcpy-x86-64-lib.c
new file mode 100644
index 000000000000..4130734dde84
--- /dev/null
+++ b/tools/perf/bench/mem-memcpy-x86-64-lib.c
@@ -0,0 +1,24 @@
+/*
+ * From code in arch/x86/lib/usercopy_64.c, copied to keep tools/ copy
+ * of the kernel's arch/x86/lib/memcpy_64.s used in 'perf bench mem memcpy'
+ * happy.
+ */
+#include <linux/types.h>
+
+unsigned long __memcpy_mcsafe(void *dst, const void *src, size_t cnt);
+unsigned long mcsafe_handle_tail(char *to, char *from, unsigned len);
+
+unsigned long mcsafe_handle_tail(char *to, char *from, unsigned len)
+{
+	for (; len; --len, to++, from++) {
+		/*
+		 * Call the assembly routine back directly since
+		 * memcpy_mcsafe() may silently fallback to memcpy.
+		 */
+		unsigned long rem = __memcpy_mcsafe(to, from, 1);
+
+		if (rem)
+			break;
+	}
+	return len;
+}
-- 
2.14.4
