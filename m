Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA42459D4
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774136550; cv=none; b=qstuBN97kizjfAvXWCMFZ3JOT1LBocVJmjWGlmbzq5o1fC76QPgIMLFI53MV2R0N6sZPx8LUmjMyBVFGZ0T17MwVIp5tz1l/hfvwqlDVnPZv9vt3t2ghZ3ePAKcPCW1pL1aaurI97e/C5PaYNSave5BGoGOiMD6kcT55pZo3Auk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774136550; c=relaxed/simple;
	bh=nN5sSn0LYIxPN0XI3Sgb4WnlGszT6wCW80ieYvC2J0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TkQU8hWhn3ZjpJNlYO1nZiRKMbevERiVox3pEGRzRlqnfclHu8/BaQmt9KzZ2MMdD5BRaEawG2FfeEwaG4eEdHdsYaU5HPetrGV2CqxuZWKpi6aOyKMBtKTM+USva7uf/q8ekkoZ/Qn9rYwo46Et4DNAwlIE6SVLf07UYBZKSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3mCgUqh; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3mCgUqh"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12776bebeb3so459082c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 16:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774136548; x=1774741348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lt+rwRrqT065vfUOo6yVpO/YAP7pOX34Tn4qVl2j8c=;
        b=F3mCgUqhLhKYrs09N529NoLgd+3/XneVjJEvvs2eUW6offO1SXc9sUwXnanDwyEq79
         DHTSJp+AQYQw51v8hGTBpRiphulCU7ZcAMGiWy3hx9qNn+iOHDRHt8Q4rIr0NnZIpfSg
         l+fCREiYZrUzl6oPsE9hjYsnV6nUdZMqTYSKRTdjNd4QQYiYyanxC9RxCxbv2oDg9pSc
         1vRwqxWTRAIariZTzUQGCdxFgyieIb5e4yb9u/yVQOP+xUQVEVHDtS5x1NjbIbgVHbM7
         2+w7Aowh2Htekb3CI6SKUDq2Z2/oz1kpVhWL/MpqFqeFjsH4fsvQqEWOliZSzSLMM3rK
         aAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774136548; x=1774741348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lt+rwRrqT065vfUOo6yVpO/YAP7pOX34Tn4qVl2j8c=;
        b=PYYpAkkbf11iHqdNsej2Of1uo8AjGUIGDzelrDoEnkx+nei2OshxWP3+dPpFxfLxSw
         0v9VbBTFpx2l5sX3dxcjaeSA00DnPb2hY8ga0Xv7dUhLWecedJQwVcGGUD1ja5h/Inm/
         LzwKIq0RCpSbgsNo+eCIOtjYKj09HmbbXzHgL/16o8YcVDBLsHCghzQAsh4ZflJhiPzD
         cEunFVH1d6iiGZXURoDDmhTo1x3AKASH/wAx4LWQQOHqX+DuObMee5ePPw4dKeRwSetd
         oXNLy6lf7QMYW+MU25EmG2ds+bWX9xMahidyHIJYam8llreUG2mjYNE/wfb9qgzISOeU
         A0tA==
X-Forwarded-Encrypted: i=1; AJvYcCXLfDQLCq3a9G/IqzShcRvya4UeOFX68ufzli09j0QaeOH33tYUv1SkR/J6f7M+X2Zypayaf+Ig/Sk4Eej37Enw@vger.kernel.org
X-Gm-Message-State: AOJu0YwswCjOLsC0YJDAd5fhxqJSILTREoHIlQv/AAQixEJaS9wXiRn1
	60pKRY5KHUlD3WD9GZaqCrSjov7Zcbzl+jVSAELCUFvCfbfgohQwahDfKvKaRfq3DrCZBbEzOSu
	CAe2KHqSh5w==
X-Received: from dlbrh17.prod.google.com ([2002:a05:7022:f311:b0:128:d4d5:93c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b14:b0:128:e2a9:d97b
 with SMTP id a92af1059eb24-12a726dd9b5mr3614344c88.42.1774136547707; Sat, 21
 Mar 2026 16:42:27 -0700 (PDT)
Date: Sat, 21 Mar 2026 16:42:20 -0700
In-Reply-To: <20260321234220.848859-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <abxs-2rozL1tBEO1@google.com> <20260321234220.848859-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260321234220.848859-3-irogers@google.com>
Subject: [PATCH v1 2/2] tools build: Remove libunwind feature tests
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	howardchu95@gmail.com, irogers@google.com, james.clark@linaro.org, 
	john.g.garry@oracle.com, jolsa@kernel.org, leo.yan@linux.dev, 
	libunwind-devel@nongnu.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, mingo@redhat.com, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, amadio@gentoo.org, 
	yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"

Libunwind support has been removed from perf, so the feature tests
used to detect its presence are no longer needed. Remove the
test-libunwind-*.c files and their references in the feature Makefile.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile                  | 31 -------------------
 tools/build/feature/test-libunwind-aarch64.c  | 27 ----------------
 tools/build/feature/test-libunwind-arm.c      | 28 -----------------
 .../test-libunwind-debug-frame-aarch64.c      | 17 ----------
 .../feature/test-libunwind-debug-frame-arm.c  | 17 ----------
 .../feature/test-libunwind-debug-frame.c      | 17 ----------
 tools/build/feature/test-libunwind-x86.c      | 28 -----------------
 tools/build/feature/test-libunwind-x86_64.c   | 28 -----------------
 tools/build/feature/test-libunwind.c          | 28 -----------------
 9 files changed, 221 deletions(-)
 delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame.c
 delete mode 100644 tools/build/feature/test-libunwind-x86.c
 delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
 delete mode 100644 tools/build/feature/test-libunwind.c

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1fbcb3ce74d2..37b972526987 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -36,14 +36,6 @@ FILES=                                          \
          test-libtraceevent.bin                 \
          test-libcpupower.bin                   \
          test-libtracefs.bin                    \
-         test-libunwind.bin                     \
-         test-libunwind-debug-frame.bin         \
-         test-libunwind-x86.bin                 \
-         test-libunwind-x86_64.bin              \
-         test-libunwind-arm.bin                 \
-         test-libunwind-aarch64.bin             \
-         test-libunwind-debug-frame-arm.bin     \
-         test-libunwind-debug-frame-aarch64.bin \
          test-pthread-attr-setaffinity-np.bin   \
          test-pthread-barrier.bin		\
          test-stackprotector-all.bin            \
@@ -203,29 +195,6 @@ $(OUTPUT)test-libnuma.bin:
 $(OUTPUT)test-numa_num_possible_cpus.bin:
 	$(BUILD) -lnuma
 
-$(OUTPUT)test-libunwind.bin:
-	$(BUILD) -lelf -llzma
-
-$(OUTPUT)test-libunwind-debug-frame.bin:
-	$(BUILD) -lelf -llzma
-$(OUTPUT)test-libunwind-x86.bin:
-	$(BUILD) -lelf -llzma -lunwind-x86
-
-$(OUTPUT)test-libunwind-x86_64.bin:
-	$(BUILD) -lelf -llzma -lunwind-x86_64
-
-$(OUTPUT)test-libunwind-arm.bin:
-	$(BUILD) -lelf -llzma -lunwind-arm
-
-$(OUTPUT)test-libunwind-aarch64.bin:
-	$(BUILD) -lelf -llzma -lunwind-aarch64
-
-$(OUTPUT)test-libunwind-debug-frame-arm.bin:
-	$(BUILD) -lelf -llzma -lunwind-arm
-
-$(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
-	$(BUILD) -lelf -llzma -lunwind-aarch64
-
 $(OUTPUT)test-libslang.bin:
 	$(BUILD) -lslang
 
diff --git a/tools/build/feature/test-libunwind-aarch64.c b/tools/build/feature/test-libunwind-aarch64.c
deleted file mode 100644
index 323803f49212..000000000000
--- a/tools/build/feature/test-libunwind-aarch64.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-aarch64.h>
-#include <stdlib.h>
-
-extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-					       unw_word_t ip,
-					       unw_dyn_info_t *di,
-					       unw_proc_info_t *pi,
-					       int need_unwind_info, void *arg);
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-static unw_accessors_t accessors;
-
-int main(void)
-{
-	unw_addr_space_t addr_space;
-
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (addr_space)
-		return 0;
-
-	unw_init_remote(NULL, addr_space, NULL);
-	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
-
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-arm.c b/tools/build/feature/test-libunwind-arm.c
deleted file mode 100644
index cb378b7d6866..000000000000
--- a/tools/build/feature/test-libunwind-arm.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-arm.h>
-#include <stdlib.h>
-
-extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-					       unw_word_t ip,
-					       unw_dyn_info_t *di,
-					       unw_proc_info_t *pi,
-					       int need_unwind_info, void *arg);
-
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-static unw_accessors_t accessors;
-
-int main(void)
-{
-	unw_addr_space_t addr_space;
-
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (addr_space)
-		return 0;
-
-	unw_init_remote(NULL, addr_space, NULL);
-	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
-
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-debug-frame-aarch64.c b/tools/build/feature/test-libunwind-debug-frame-aarch64.c
deleted file mode 100644
index 36d6646c185e..000000000000
--- a/tools/build/feature/test-libunwind-debug-frame-aarch64.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-aarch64.h>
-#include <stdlib.h>
-
-extern int
-UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
-				 unw_word_t ip, unw_word_t segbase,
-				 const char *obj_name, unw_word_t start,
-				 unw_word_t end);
-
-#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
-
-int main(void)
-{
-	dwarf_find_debug_frame(0, NULL, 0, 0, NULL, 0, 0);
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-debug-frame-arm.c b/tools/build/feature/test-libunwind-debug-frame-arm.c
deleted file mode 100644
index 8696e48e1268..000000000000
--- a/tools/build/feature/test-libunwind-debug-frame-arm.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-arm.h>
-#include <stdlib.h>
-
-extern int
-UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
-				 unw_word_t ip, unw_word_t segbase,
-				 const char *obj_name, unw_word_t start,
-				 unw_word_t end);
-
-#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
-
-int main(void)
-{
-	dwarf_find_debug_frame(0, NULL, 0, 0, NULL, 0, 0);
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-debug-frame.c b/tools/build/feature/test-libunwind-debug-frame.c
deleted file mode 100644
index efb55cdd8d01..000000000000
--- a/tools/build/feature/test-libunwind-debug-frame.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind.h>
-#include <stdlib.h>
-
-extern int
-UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
-				 unw_word_t ip, unw_word_t segbase,
-				 const char *obj_name, unw_word_t start,
-				 unw_word_t end);
-
-#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
-
-int main(void)
-{
-	dwarf_find_debug_frame(0, NULL, 0, 0, NULL, 0, 0);
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-x86.c b/tools/build/feature/test-libunwind-x86.c
deleted file mode 100644
index e5e0f6c89637..000000000000
--- a/tools/build/feature/test-libunwind-x86.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-x86.h>
-#include <stdlib.h>
-
-extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-					       unw_word_t ip,
-					       unw_dyn_info_t *di,
-					       unw_proc_info_t *pi,
-					       int need_unwind_info, void *arg);
-
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-static unw_accessors_t accessors;
-
-int main(void)
-{
-	unw_addr_space_t addr_space;
-
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (addr_space)
-		return 0;
-
-	unw_init_remote(NULL, addr_space, NULL);
-	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
-
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind-x86_64.c b/tools/build/feature/test-libunwind-x86_64.c
deleted file mode 100644
index 62ae4db597dc..000000000000
--- a/tools/build/feature/test-libunwind-x86_64.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind-x86_64.h>
-#include <stdlib.h>
-
-extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-					       unw_word_t ip,
-					       unw_dyn_info_t *di,
-					       unw_proc_info_t *pi,
-					       int need_unwind_info, void *arg);
-
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-static unw_accessors_t accessors;
-
-int main(void)
-{
-	unw_addr_space_t addr_space;
-
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (addr_space)
-		return 0;
-
-	unw_init_remote(NULL, addr_space, NULL);
-	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
-
-	return 0;
-}
diff --git a/tools/build/feature/test-libunwind.c b/tools/build/feature/test-libunwind.c
deleted file mode 100644
index 53fd26614ff0..000000000000
--- a/tools/build/feature/test-libunwind.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libunwind.h>
-#include <stdlib.h>
-
-extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-                                      unw_word_t ip,
-                                      unw_dyn_info_t *di,
-                                      unw_proc_info_t *pi,
-                                      int need_unwind_info, void *arg);
-
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-static unw_accessors_t accessors;
-
-int main(void)
-{
-	unw_addr_space_t addr_space;
-
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (addr_space)
-		return 0;
-
-	unw_init_remote(NULL, addr_space, NULL);
-	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
-
-	return 0;
-}
-- 
2.53.0.959.g497ff81fa9-goog

