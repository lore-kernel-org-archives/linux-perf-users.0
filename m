Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522993A0B09
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943394; cv=none; b=ONMYHJi6kd7PV+/2oBcao5rhzExYngL82tVMmJznFkdnqqjOpNnOh7SNd5YaahTQtoYw7MQPrzE5I5+GU4btCDL0THHjI0WvueOGOg2haMLqyBOM2yqTDSebbo/FXg9RJglAn1NtIA9axvzBtFNLaavf5vi2O5XM0Oo6wyv6nxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943394; c=relaxed/simple;
	bh=3N895u+2tlaQb85Zb8QwBo8mu6vlTBkoztDSjnXlzWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MCcAxA9Op3SFNDgm/7KCrx0j0jS+t8qgDp69bS6Y9nUQPaTtqcvicC9EiDTavJepz/GruPZcLZfTa2qJJDDOgyoOJnfyiR7ymjP3u3+41Pf94irRZe57MUNniapqws5ILeXv+H3Ju1AXXCwiaIxBZY2NKS5HphqZuTQVjOCHDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evhb+Mcm; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evhb+Mcm"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda4fd1dd0so15664598eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 06:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771943392; x=1772548192; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6zGB6KXVZgGBJvevzesELin0ooFg0kJVSoJ6gwXlmk=;
        b=evhb+Mcm1AZ034S4cgcO0f0bu8gkn+oqY1jMdJwLGN2JOq2dnT4uT/q3cHM/UiuL0v
         Ua9WzF5vsxU1AwGks7VLjagN/6UO2x5NDZatVhIvGMby73Imi7CKPEiXpHlx0RlGrjir
         MwK5XnXNpEUFGeGvq/+/T5/00IMDetAzZrnllCXe9OXgFYvNPiyoJR/MonxuyhBhMnxT
         vjiSBTzTaQJEI02bXe3W/K6TAAnsYq+Vt1uuyp2n9Q3Lvr1VeNXgWHocHpj3ERlrVxTz
         dVlXfo0HTCNXy6PtBfnfteh9mWc6PyFgna3F90Ai/0Y7Aqd1VAJ16qf0Gx8BxQSlBzLQ
         6D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771943392; x=1772548192;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6zGB6KXVZgGBJvevzesELin0ooFg0kJVSoJ6gwXlmk=;
        b=KR4Ems/JcDa2rSBmFtyrdlcvoYE4TfXeEpGV5pVB2UxjtGgw0zkAdtvbGe2SwYkfNz
         T6XBII822d0Xqr/BkiYYOzN9D0OIJmTBDnE9A7yQJuHjLAZDSeubhSiwf7nOQ7ob7nDc
         DNYrAizFmh/yHNyhKPqvnAyymCxQepo6MFBqF5o9WqcHKRZNhTSEooqC8wCbUSLzIHhT
         QBARzhudE9lRrh2pg77uF6x8ZiVNh553Z6FbWrYLouuWqdZN3EZx1wWXJ0WbWfxMT5G8
         UWcVD/7t260amVuoOD/pkB3h100Mmu9R/v0K4B12Gkm3JWO2tSlPjJPpm46nbxmy3J6b
         0qBg==
X-Forwarded-Encrypted: i=1; AJvYcCWhPWWOrBJ6k5e7dGAEYKz2//upARJE/FY/ZafX8/ugOXShg9Lv9O7QeK3blhkmj2OUEpVkFDxds7Wn80SGpgTl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2U3GiHE04zIF9YlIW+SgvN9lAWVasjVcAmbMNvttAGrRnjaRG
	dIBzW6/2Yuzgslyur16PO4byR+QiHHzOztk9s8lhsx5BQm/LbIMkaS0s9KmvtZP03Ld2Y3E/ir9
	l2uDG9S9+WQ==
X-Received: from dybgx25.prod.google.com ([2002:a05:7301:2419:b0:2ba:7b4a:c331])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7491:b0:2b7:2f29:648c
 with SMTP id 5a478bee46e88-2bd7b9efb89mr5937089eec.8.1771943392130; Tue, 24
 Feb 2026 06:29:52 -0800 (PST)
Date: Tue, 24 Feb 2026 06:29:31 -0800
In-Reply-To: <20260224142938.26088-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224142938.26088-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260224142938.26088-2-irogers@google.com>
Subject: [RFC PATCH v1 1/7] tools build: Deduplicate test-libunwind for
 different architectures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Blake Jones <blakejones@google.com>, Tomas Glozar <tglozar@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Shimin Guo <shimin.guo@skydio.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Thomas Richter <tmricht@linux.ibm.com>, 
	libunwind-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

The separate test files only exist to pass a different #include,
instead have a single source file and pass -include to $(CC) to
include the relevant header file for the architecture being
tested. Generate the rules using a foreach loop. Include tests for all
current libunwind architectures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile                  | 38 +++++++++----------
 tools/build/feature/test-libunwind-aarch64.c  | 27 -------------
 tools/build/feature/test-libunwind-arm.c      | 28 --------------
 .../test-libunwind-debug-frame-aarch64.c      | 17 ---------
 .../feature/test-libunwind-debug-frame-arm.c  | 17 ---------
 .../feature/test-libunwind-debug-frame.c      |  1 -
 tools/build/feature/test-libunwind-x86.c      | 28 --------------
 tools/build/feature/test-libunwind-x86_64.c   | 28 --------------
 tools/build/feature/test-libunwind.c          |  1 -
 9 files changed, 19 insertions(+), 166 deletions(-)
 delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-x86.c
 delete mode 100644 tools/build/feature/test-libunwind-x86_64.c

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1fbcb3ce74d2..a0b40e826688 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -204,27 +204,27 @@ $(OUTPUT)test-numa_num_possible_cpus.bin:
 	$(BUILD) -lnuma
 
 $(OUTPUT)test-libunwind.bin:
-	$(BUILD) -lelf -llzma
+	$(BUILD) -include libunwind.h -lelf -llzma -lunwind
 
 $(OUTPUT)test-libunwind-debug-frame.bin:
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
+	$(BUILD) -include libunwind.h -lelf -llzma -lunwind
+
+LIBUNWIND_ARCHS:=aarch64 arm loongarch64 mips ppc32 ppc64 riscv s390x x86 x86_64
+define LIBUNWIND_RULE
+$$(OUTPUT)test-libunwind-$(1).bin:
+	$$(CC) $$(CFLAGS) -MD -Wall -Werror -include libunwind-$(1).h -o $$@ \
+		test-libunwind.c $$(LDFLAGS) -lelf -llzma -lunwind-$(1) \
+		> $$(@:.bin=.make.output) 2>&1
+
+$$(OUTPUT)test-libunwind-debug-frame-$(1).bin:
+	$$(CC) $$(CFLAGS) -MD -Wall -Werror -include libunwind-$(1).h -o $$@ \
+		test-libunwind-debug-frame.c $$(LDFLAGS) -lelf -llzma -lunwind-$(1) \
+		> $$(@:.bin=.make.output) 2>&1
+
+endef
+$(foreach arch,$(LIBUNWIND_ARCHS), \
+    $(eval $(call LIBUNWIND_RULE,$(arch))) \
+)
 
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
index efb55cdd8d01..4c57e37004b3 100644
--- a/tools/build/feature/test-libunwind-debug-frame.c
+++ b/tools/build/feature/test-libunwind-debug-frame.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <libunwind.h>
 #include <stdlib.h>
 
 extern int
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
index 53fd26614ff0..5af5dc3a73d4 100644
--- a/tools/build/feature/test-libunwind.c
+++ b/tools/build/feature/test-libunwind.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <libunwind.h>
 #include <stdlib.h>
 
 extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-- 
2.53.0.371.g1d285c8824-goog

