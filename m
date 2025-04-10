Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726D1A5BA9;
	Thu, 10 Apr 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243893; cv=none; b=uwgmC2LZ7j/LuVPI+ryn/OhCd7enXwdi83/Ams3eEtQs7a9fZS+Wb1ADHovGHj64Ymj92krMuFheBJmqeY8n0EafnutrqAcIJZVHx+JI9EgK2sY5ktgHYGlWcXslQ24p+9RRRXXLDjLo0uu+Dvaj3FHWPGA1K8C7NYmf3AaxbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243893; c=relaxed/simple;
	bh=T20OlLQN6t8NjiZOs1TLZ6/pvAdfjxkFgUg0j9VVE5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsbO6M72hViWzSsDMtOmnif9vxh+bi0heXgq3zkOQTjDaCyW2Q8s9oLl91ekHNwQanpypKqO9f4yDQwtUSjZetfprpDSQGPHrTpSdZIBysAE1gAyRkslGwEnSqQHtwOv867lO9JNZo9Pjdu2RpJvi/2EzcK3G7gUGuEpn92UfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJZZ0T9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJZZ0T9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE7FC4CEE9;
	Thu, 10 Apr 2025 00:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243892;
	bh=T20OlLQN6t8NjiZOs1TLZ6/pvAdfjxkFgUg0j9VVE5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJZZ0T9kWDDhzcxxLMi/YSws1E6k+9grd87wjHAw5SOJAypp52zS0vPRWfHBqSdLY
	 GFeGIskvein8Gi9gWmX7w5TemRF66AwmUdjhIzKHywkv17VvwEY+WQn0+Zc7KJfvO6
	 Zy3cpoRIVRWDwh/3/vWlY2ovhBRMFdqFO3j8qNGmiGuxKONjHSogZWYYFVta7irv/L
	 wtk7WlL7PG9tSf053Pdc85osJt+atRtjLg8y+dVkaK7jBFkpLL0pxM4t3nc7ahy82J
	 si85RUpVoiCq50v2XppQBSwOuuwF9QLWpqeCSvoFMsyDwRjS19VxExQliwJOpiz7Gw
	 zrzZI2lXhYCtA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 10/10] tools headers: Update the arch/x86/lib/memset_64.S copy with the kernel sources
Date: Wed,  9 Apr 2025 17:11:25 -0700
Message-ID: <20250410001125.391820-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in:

  2981557cb0408e14 x86,kcfi: Fix EXPORT_SYMBOL vs kCFI

That required adding a copy of include/linux/cfi_types.h and its checking
in tools/perf/check-headers.h.

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

Please see tools/include/uapi/README for further details.

Cc: x86@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/x86/lib/memset_64.S  |  3 ++-
 tools/include/linux/cfi_types.h | 45 +++++++++++++++++++++++++++++++++
 tools/perf/check-headers.sh     |  1 +
 3 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/linux/cfi_types.h

diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index 0199d56cb479d88c..d66b710d628f8865 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -3,6 +3,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
@@ -28,7 +29,7 @@
  * only for the return value that is the same as the source input,
  * which the compiler could/should do much better anyway.
  */
-SYM_FUNC_START(__memset)
+SYM_TYPED_FUNC_START(__memset)
 	ALTERNATIVE "jmp memset_orig", "", X86_FEATURE_FSRS
 
 	movq %rdi,%r9
diff --git a/tools/include/linux/cfi_types.h b/tools/include/linux/cfi_types.h
new file mode 100644
index 0000000000000000..6b87136757655c05
--- /dev/null
+++ b/tools/include/linux/cfi_types.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Clang Control Flow Integrity (CFI) type definitions.
+ */
+#ifndef _LINUX_CFI_TYPES_H
+#define _LINUX_CFI_TYPES_H
+
+#ifdef __ASSEMBLY__
+#include <linux/linkage.h>
+
+#ifdef CONFIG_CFI_CLANG
+/*
+ * Use the __kcfi_typeid_<function> type identifier symbol to
+ * annotate indirectly called assembly functions. The compiler emits
+ * these symbols for all address-taken function declarations in C
+ * code.
+ */
+#ifndef __CFI_TYPE
+#define __CFI_TYPE(name)				\
+	.4byte __kcfi_typeid_##name
+#endif
+
+#define SYM_TYPED_ENTRY(name, linkage, align...)	\
+	linkage(name) ASM_NL				\
+	align ASM_NL					\
+	__CFI_TYPE(name) ASM_NL				\
+	name:
+
+#define SYM_TYPED_START(name, linkage, align...)	\
+	SYM_TYPED_ENTRY(name, linkage, align)
+
+#else /* CONFIG_CFI_CLANG */
+
+#define SYM_TYPED_START(name, linkage, align...)	\
+	SYM_START(name, linkage, align)
+
+#endif /* CONFIG_CFI_CLANG */
+
+#ifndef SYM_TYPED_FUNC_START
+#define SYM_TYPED_FUNC_START(name) 			\
+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
+#endif /* __ASSEMBLY__ */
+#endif /* _LINUX_CFI_TYPES_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index a4499e5a6f9cb00c..857f6646cc23e949 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -20,6 +20,7 @@ FILES=(
   "include/uapi/linux/stat.h"
   "include/linux/bits.h"
   "include/vdso/bits.h"
+  "include/linux/cfi_types.h"
   "include/linux/const.h"
   "include/vdso/const.h"
   "include/vdso/unaligned.h"
-- 
2.49.0.504.g3bcea36a83-goog

