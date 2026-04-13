Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3512264D9
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 02:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048508; cv=none; b=sgj/2bhnq+AlMJxy8D+2gS2BvqCybgTFNtOCB/LLra58vrZmpGWKVZb9kaYc3CbH9VuEpbqr3nHAITGh/DAjd+TTN42n3YjqR3uWPP2hj0Aqfcf3RmaM8RY2gTJ2x4ZJhH/pvgLBj1yxgi2SkzeidRyZ7DaY8jkqwZ6uoe/Yo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048508; c=relaxed/simple;
	bh=tratQNx+xvzaTcpiB/+muqN8WpoxS6TuizqLn1CKw7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPIUD4wksOZ5IPy7F9e14ijRQGF7XIMBmAu6TzIrS/uFd3tPe9qOHZRrMJPsIt+OYjEhWM8kFN3/IdbjUl6750XmIAwJBB7J7tUpMRwnBvodpce+LDa3HS+X9paJ/j8A6ZmtX/tbHa7dHjqkzhzOE32MvjiiFF+mb6vc1UWVt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bptWN40V; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bptWN40V"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so6151635a12.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 19:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776048505; x=1776653305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQVkcwEiLCnN6dwxfewA2WuOZTkC+/YHvO/Den3A6Hw=;
        b=bptWN40ViA8CdhxT0axMOhMjt36l7MYuPXPnNsa4xtQbSqSJwnEJQ6jU45B1VvzATm
         7WCNFfj7JK6lEPLuJQZbMkz7BQPdIwaGrLkcx3aWDycG+FE+FcFjmTNllG+j+e22/XTY
         /D5uxM6idqQBxJ/xUjIrtTXGz/5Ylo+ktZv0Nt1pdmpHlIuqb6WRKqBBmURU1YY8a3aP
         j4R4bZQuUHFFMBWund5XycBYXa6B2bFzC2fVR1B9xHdJUEwDNEk9sAgIkjy4816tEQ0Y
         DUgv50QF8+pjs3dgLMoJ9+6dwZ5DLIediT5o+uRLbReSo09cg7TEhm9Ecjyzbe2RlMkx
         4RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776048505; x=1776653305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQVkcwEiLCnN6dwxfewA2WuOZTkC+/YHvO/Den3A6Hw=;
        b=R0t9hq/kAQCr7vrehNqBS7Y/TVHXFsCjg/iBqMGaDzMqoZcvGxir60M+V5yuKNKZec
         EpcXKUDRQQDYKTQulqC6ohjdF0u9IfL4l5TJXt8nAQxYHIPaDghBRjysoUBgclNPUoPM
         32rszbizuc7xU1+YD4b3DTnDVsuDF1XNc7Gn/aJVgMuwJP+0m+dbKYJV7dqe6xCsy5ia
         2+6PrXejRDG3Y8yBeN4071mRmgNV4jYVWDEnQ18TOE3yohw9GSr0x2rpqUlX9Srevg95
         JFuzPzB0UmcVaVH/HCixCvwC3pzv0GM88ca3YTPjjev+NA3uCM8VeOEZZnqx5f2GnXWM
         TD0w==
X-Forwarded-Encrypted: i=1; AFNElJ9769IUQRyKRsLGzJwVaRw8RVxml2QdwyOvBeyHyzKxGCSV4Anoqys0lvGiZk+e0vnvFwJ4GfwRNkqu2pCeA8rt@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNrjmbk73zS8g8gSdFfM2chFMEVo4aYCo8c1xz3OOjZC5kdgy
	OjTkuHIrHNoQ31FiEQOfSjEmFpqEaiHqYcps0EvHsYEnClUvWQkNC/feXBKX4E5T2YGTqxqSS06
	/FyrzgDoQYg==
X-Received: from pfud7.prod.google.com ([2002:a05:6a00:10c7:b0:82f:2efd:4158])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1888:b0:823:998:95b0
 with SMTP id d2e1a72fcca58-82f0c29e529mr12961253b3a.35.1776048505252; Sun, 12
 Apr 2026 19:48:25 -0700 (PDT)
Date: Sun, 12 Apr 2026 19:48:05 -0700
In-Reply-To: <20260413024805.1316480-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <advv6twWCEVBo_Hc@x1> <20260413024805.1316480-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413024805.1316480-9-irogers@google.com>
Subject: [PATCH v4 8/8] perf unwind-libunwind: Add RISC-V libunwind support
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, howardchu95@gmail.com, 
	irogers@google.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"

Add a RISC-V implementation for unwinding.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/libunwind-arch/Build          |   1 +
 .../perf/util/libunwind-arch/libunwind-arch.c |  21 ++
 .../perf/util/libunwind-arch/libunwind-arch.h |  22 ++
 .../util/libunwind-arch/libunwind-riscv.c     | 297 ++++++++++++++++++
 4 files changed, 341 insertions(+)
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-riscv.c

diff --git a/tools/perf/util/libunwind-arch/Build b/tools/perf/util/libunwind-arch/Build
index 87fd657a3248..80d3571918b1 100644
--- a/tools/perf/util/libunwind-arch/Build
+++ b/tools/perf/util/libunwind-arch/Build
@@ -5,6 +5,7 @@ perf-util-$(CONFIG_LIBUNWIND) += libunwind-loongarch.o
 perf-util-$(CONFIG_LIBUNWIND) += libunwind-mips.o
 perf-util-$(CONFIG_LIBUNWIND) += libunwind-ppc32.o
 perf-util-$(CONFIG_LIBUNWIND) += libunwind-ppc64.o
+perf-util-$(CONFIG_LIBUNWIND) += libunwind-riscv.o
 perf-util-$(CONFIG_LIBUNWIND) += libunwind-s390.o
 perf-util-$(CONFIG_LIBUNWIND) += libunwind-i386.o
 perf-util-$(CONFIG_LIBUNWIND) += libunwind-x86_64.o
diff --git a/tools/perf/util/libunwind-arch/libunwind-arch.c b/tools/perf/util/libunwind-arch/libunwind-arch.c
index 8539b4233df4..9a74cf3c8729 100644
--- a/tools/perf/util/libunwind-arch/libunwind-arch.c
+++ b/tools/perf/util/libunwind-arch/libunwind-arch.c
@@ -20,6 +20,8 @@ int get_perf_regnum_for_unw_regnum(unsigned int e_machine, int unw_regnum)
 		return __get_perf_regnum_for_unw_regnum_ppc32(unw_regnum);
 	case EM_PPC64:
 		return __get_perf_regnum_for_unw_regnum_ppc64(unw_regnum);
+	case EM_RISCV:
+		return __get_perf_regnum_for_unw_regnum_riscv(unw_regnum);
 	case EM_S390:
 		return __get_perf_regnum_for_unw_regnum_s390(unw_regnum);
 	case EM_386:
@@ -58,6 +60,9 @@ void libunwind_arch__flush_access(struct maps *maps)
 	case EM_PPC64:
 		__libunwind_arch__flush_access_ppc64(maps);
 		break;
+	case EM_RISCV:
+		__libunwind_arch__flush_access_riscv(maps);
+		break;
 	case EM_S390:
 		__libunwind_arch__flush_access_s390(maps);
 		break;
@@ -98,6 +103,9 @@ void libunwind_arch__finish_access(struct maps *maps)
 	case EM_PPC64:
 		__libunwind_arch__finish_access_ppc64(maps);
 		break;
+	case EM_RISCV:
+		__libunwind_arch__finish_access_riscv(maps);
+		break;
 	case EM_S390:
 		__libunwind_arch__finish_access_s390(maps);
 		break;
@@ -128,6 +136,8 @@ void *libunwind_arch__create_addr_space(unsigned int e_machine)
 		return __libunwind_arch__create_addr_space_ppc32();
 	case EM_PPC64:
 		return __libunwind_arch__create_addr_space_ppc64();
+	case EM_RISCV:
+		return __libunwind_arch__create_addr_space_riscv();
 	case EM_S390:
 		return __libunwind_arch__create_addr_space_s390();
 	case EM_386:
@@ -167,6 +177,9 @@ int libunwind_arch__dwarf_search_unwind_table(unsigned int e_machine,
 	case EM_PPC64:
 		return __libunwind_arch__dwarf_search_unwind_table_ppc64(as, ip, di, pi,
 									 need_unwind_info, arg);
+	case EM_RISCV:
+		return __libunwind_arch__dwarf_search_unwind_table_riscv(as, ip, di, pi,
+									need_unwind_info, arg);
 	case EM_S390:
 		return __libunwind_arch__dwarf_search_unwind_table_s390(as, ip, di, pi,
 									need_unwind_info, arg);
@@ -211,6 +224,9 @@ int libunwind_arch__dwarf_find_debug_frame(unsigned int e_machine,
 	case EM_PPC64:
 		return __libunwind_arch__dwarf_find_debug_frame_ppc64(found, di_debug, ip, segbase,
 								      obj_name, start, end);
+	case EM_RISCV:
+		return __libunwind_arch__dwarf_find_debug_frame_riscv(found, di_debug, ip, segbase,
+								     obj_name, start, end);
 	case EM_S390:
 		return __libunwind_arch__dwarf_find_debug_frame_s390(found, di_debug, ip, segbase,
 								     obj_name, start, end);
@@ -250,6 +266,9 @@ struct unwind_info *libunwind_arch_unwind_info__new(struct thread *thread,
 	case EM_PPC64:
 		return __libunwind_arch_unwind_info__new_ppc64(thread, sample, max_stack,
 							       best_effort, first_ip);
+	case EM_RISCV:
+		return __libunwind_arch_unwind_info__new_riscv(thread, sample, max_stack,
+							      best_effort, first_ip);
 	case EM_S390:
 		return __libunwind_arch_unwind_info__new_s390(thread, sample, max_stack,
 							      best_effort, first_ip);
@@ -285,6 +304,8 @@ int libunwind_arch__unwind_step(struct unwind_info *ui)
 		return __libunwind_arch__unwind_step_ppc32(ui);
 	case EM_PPC64:
 		return __libunwind_arch__unwind_step_ppc64(ui);
+	case EM_RISCV:
+		return __libunwind_arch__unwind_step_riscv(ui);
 	case EM_S390:
 		return __libunwind_arch__unwind_step_s390(ui);
 	case EM_386:
diff --git a/tools/perf/util/libunwind-arch/libunwind-arch.h b/tools/perf/util/libunwind-arch/libunwind-arch.h
index 2bf7fc33313b..74a09cd58f38 100644
--- a/tools/perf/util/libunwind-arch/libunwind-arch.h
+++ b/tools/perf/util/libunwind-arch/libunwind-arch.h
@@ -39,6 +39,7 @@ int __get_perf_regnum_for_unw_regnum_loongarch(int unw_regnum);
 int __get_perf_regnum_for_unw_regnum_mips(int unw_regnum);
 int __get_perf_regnum_for_unw_regnum_ppc32(int unw_regnum);
 int __get_perf_regnum_for_unw_regnum_ppc64(int unw_regnum);
+int __get_perf_regnum_for_unw_regnum_riscv(int unw_regnum);
 int __get_perf_regnum_for_unw_regnum_s390(int unw_regnum);
 int __get_perf_regnum_for_unw_regnum_i386(int unw_regnum);
 int __get_perf_regnum_for_unw_regnum_x86_64(int unw_regnum);
@@ -50,6 +51,7 @@ void __libunwind_arch__flush_access_loongarch(struct maps *maps);
 void __libunwind_arch__flush_access_mips(struct maps *maps);
 void __libunwind_arch__flush_access_ppc32(struct maps *maps);
 void __libunwind_arch__flush_access_ppc64(struct maps *maps);
+void __libunwind_arch__flush_access_riscv(struct maps *maps);
 void __libunwind_arch__flush_access_s390(struct maps *maps);
 void __libunwind_arch__flush_access_i386(struct maps *maps);
 void __libunwind_arch__flush_access_x86_64(struct maps *maps);
@@ -61,6 +63,7 @@ void __libunwind_arch__finish_access_loongarch(struct maps *maps);
 void __libunwind_arch__finish_access_mips(struct maps *maps);
 void __libunwind_arch__finish_access_ppc32(struct maps *maps);
 void __libunwind_arch__finish_access_ppc64(struct maps *maps);
+void __libunwind_arch__finish_access_riscv(struct maps *maps);
 void __libunwind_arch__finish_access_s390(struct maps *maps);
 void __libunwind_arch__finish_access_i386(struct maps *maps);
 void __libunwind_arch__finish_access_x86_64(struct maps *maps);
@@ -72,6 +75,7 @@ void *__libunwind_arch__create_addr_space_loongarch(void);
 void *__libunwind_arch__create_addr_space_mips(void);
 void *__libunwind_arch__create_addr_space_ppc32(void);
 void *__libunwind_arch__create_addr_space_ppc64(void);
+void *__libunwind_arch__create_addr_space_riscv(void);
 void *__libunwind_arch__create_addr_space_s390(void);
 void *__libunwind_arch__create_addr_space_i386(void);
 void *__libunwind_arch__create_addr_space_x86_64(void);
@@ -111,6 +115,11 @@ int __libunwind_arch__dwarf_search_unwind_table_ppc64(void *as, uint64_t ip,
 						      void *pi,
 						      int need_unwind_info,
 						      void *arg);
+int __libunwind_arch__dwarf_search_unwind_table_riscv(void *as, uint64_t ip,
+						     struct libarch_unwind__dyn_info *di,
+						     void *pi,
+						     int need_unwind_info,
+						     void *arg);
 int __libunwind_arch__dwarf_search_unwind_table_s390(void *as, uint64_t ip,
 						     struct libarch_unwind__dyn_info *di,
 						     void *pi,
@@ -176,6 +185,13 @@ int __libunwind_arch__dwarf_find_debug_frame_ppc64(int found,
 						   const char *obj_name,
 						   uint64_t start,
 						   uint64_t end);
+int __libunwind_arch__dwarf_find_debug_frame_riscv(int found,
+						  struct libarch_unwind__dyn_info *di_debug,
+						  uint64_t ip,
+						  uint64_t segbase,
+						  const char *obj_name,
+						  uint64_t start,
+						  uint64_t end);
 int __libunwind_arch__dwarf_find_debug_frame_s390(int found,
 						  struct libarch_unwind__dyn_info *di_debug,
 						  uint64_t ip,
@@ -236,6 +252,11 @@ struct unwind_info *__libunwind_arch_unwind_info__new_ppc64(struct thread *threa
 							   int max_stack,
 							   bool best_effort,
 							uint64_t first_ip);
+struct unwind_info *__libunwind_arch_unwind_info__new_riscv(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
 struct unwind_info *__libunwind_arch_unwind_info__new_s390(struct thread *thread,
 							struct perf_sample *sample,
 							   int max_stack,
@@ -266,6 +287,7 @@ int __libunwind_arch__unwind_step_loongarch(struct unwind_info *ui);
 int __libunwind_arch__unwind_step_mips(struct unwind_info *ui);
 int __libunwind_arch__unwind_step_ppc32(struct unwind_info *ui);
 int __libunwind_arch__unwind_step_ppc64(struct unwind_info *ui);
+int __libunwind_arch__unwind_step_riscv(struct unwind_info *ui);
 int __libunwind_arch__unwind_step_s390(struct unwind_info *ui);
 int __libunwind_arch__unwind_step_i386(struct unwind_info *ui);
 int __libunwind_arch__unwind_step_x86_64(struct unwind_info *ui);
diff --git a/tools/perf/util/libunwind-arch/libunwind-riscv.c b/tools/perf/util/libunwind-arch/libunwind-riscv.c
new file mode 100644
index 000000000000..a70a2ea96644
--- /dev/null
+++ b/tools/perf/util/libunwind-arch/libunwind-riscv.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "libunwind-arch.h"
+#include "../debug.h"
+#include "../maps.h"
+#include "../thread.h"
+#include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
+#include <errno.h>
+
+#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
+#include <libunwind-riscv.h>
+#endif
+
+int __get_perf_regnum_for_unw_regnum_riscv(int unw_regnum __maybe_unused)
+{
+#ifndef HAVE_LIBUNWIND_RISCV_SUPPORT
+	return -EINVAL;
+#else
+	switch (unw_regnum) {
+	case UNW_RISCV_X1 ... UNW_RISCV_X31:
+		return unw_regnum - UNW_RISCV_X1 + PERF_REG_RISCV_RA;
+	case UNW_RISCV_PC:
+		return PERF_REG_RISCV_PC;
+	default:
+		pr_err("unwind: invalid reg id %d\n", unw_regnum);
+		return -EINVAL;
+	}
+#endif // HAVE_LIBUNWIND_RISCV_SUPPORT
+}
+
+void __libunwind_arch__flush_access_riscv(struct maps *maps __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
+	unw_flush_cache(maps__addr_space(maps), 0, 0);
+#endif
+}
+
+void __libunwind_arch__finish_access_riscv(struct maps *maps __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
+	unw_destroy_addr_space(maps__addr_space(maps));
+#endif
+}
+
+#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
+static int find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
+			  int need_unwind_info, void *arg)
+{
+	return __libunwind__find_proc_info(as, ip, pi, need_unwind_info, arg, sizeof(unw_word_t));
+}
+
+static void put_unwind_info(unw_addr_space_t __maybe_unused as,
+			    unw_proc_info_t *pi __maybe_unused,
+			    void *arg __maybe_unused)
+{
+	pr_debug("unwind: put_unwind_info called\n");
+}
+
+static int get_dyn_info_list_addr(unw_addr_space_t __maybe_unused as,
+				  unw_word_t __maybe_unused *dil_addr,
+				  void __maybe_unused *arg)
+{
+	return -UNW_ENOINFO;
+}
+
+static int access_mem(unw_addr_space_t as, unw_word_t addr, unw_word_t *valp,
+		      int __write, void *arg)
+{
+	return __libunwind__access_mem(as, addr, valp, __write, arg, sizeof(unw_word_t));
+}
+
+static int access_reg(unw_addr_space_t as, unw_regnum_t regnum, unw_word_t *valp,
+		      int __write, void *arg)
+{
+	return __libunwind__access_reg(as, regnum, valp, __write, arg, sizeof(unw_word_t));
+}
+
+static int access_fpreg(unw_addr_space_t __maybe_unused as,
+			unw_regnum_t __maybe_unused num,
+			unw_fpreg_t __maybe_unused *val,
+			int __maybe_unused __write,
+			void __maybe_unused *arg)
+{
+	pr_err("unwind: access_fpreg unsupported\n");
+	return -UNW_EINVAL;
+}
+
+static int resume(unw_addr_space_t __maybe_unused as,
+		  unw_cursor_t __maybe_unused *cu,
+		  void __maybe_unused *arg)
+{
+	pr_err("unwind: resume unsupported\n");
+	return -UNW_EINVAL;
+}
+
+static int get_proc_name(unw_addr_space_t __maybe_unused as,
+			 unw_word_t __maybe_unused addr,
+			 char __maybe_unused *bufp, size_t __maybe_unused buf_len,
+			 unw_word_t __maybe_unused *offp, void __maybe_unused *arg)
+{
+	pr_err("unwind: get_proc_name unsupported\n");
+	return -UNW_EINVAL;
+}
+#endif
+
+void *__libunwind_arch__create_addr_space_riscv(void)
+{
+#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
+	static unw_accessors_t accessors = {
+		.find_proc_info		= find_proc_info,
+		.put_unwind_info	= put_unwind_info,
+		.get_dyn_info_list_addr	= get_dyn_info_list_addr,
+		.access_mem		= access_mem,
+		.access_reg		= access_reg,
+		.access_fpreg		= access_fpreg,
+		.resume			= resume,
+		.get_proc_name		= get_proc_name,
+	};
+	unw_addr_space_t addr_space;
+
+	addr_space = unw_create_addr_space(&accessors, /*byte_order=*/0);
+	unw_set_caching_policy(addr_space, UNW_CACHE_GLOBAL);
+	return addr_space;
+#else
+	return NULL;
+#endif
+}
+
+#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_riscv(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
+	unw_dyn_info_t di = {
+		.format     = UNW_INFO_FORMAT_REMOTE_TABLE,
+		.start_ip   = _di->start_ip,
+		.end_ip     = _di->end_ip,
+		.u = {
+			.rti = {
+				.segbase    = _di->segbase,
+				.table_data = _di->table_data,
+				.table_len  = _di->table_len,
+			},
+		},
+	};
+	int ret = dwarf_search_unwind_table(as, ip, &di, pi, need_unwind_info, arg);
+
+	_di->start_ip = di.start_ip;
+	_di->end_ip = di.end_ip;
+	_di->segbase = di.u.rti.segbase;
+	_di->table_data = di.u.rti.table_data;
+	_di->table_len = di.u.rti.table_len;
+	return ret;
+#else
+	return -EINVAL;
+#endif
+}
+
+#if defined(HAVE_LIBUNWIND_RISCV_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_RISCV)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_riscv(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_RISCV_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_RISCV)
+	unw_dyn_info_t di = {
+		.format     = UNW_INFO_FORMAT_REMOTE_TABLE,
+		.start_ip   = _di->start_ip,
+		.end_ip     = _di->end_ip,
+		.u = {
+			.rti = {
+				.segbase    = _di->segbase,
+				.table_data = _di->table_data,
+				.table_len  = _di->table_len,
+			},
+		},
+	};
+	int ret = dwarf_find_debug_frame(found, &di, ip, segbase, obj_name, start, end);
+
+	_di->start_ip = di.start_ip;
+	_di->end_ip = di.end_ip;
+	_di->segbase = di.u.rti.segbase;
+	_di->table_data = di.u.rti.table_data;
+	_di->table_len = di.u.rti.table_len;
+	return ret;
+#else
+	return -EINVAL;
+#endif
+}
+
+struct unwind_info *__libunwind_arch_unwind_info__new_riscv(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
+	struct arch_unwind_info {
+		struct unwind_info ui;
+		unw_cursor_t _cursor;
+		uint64_t _ips[];
+	};
+
+	struct maps *maps = thread__maps(thread);
+	void *addr_space = maps__addr_space(maps);
+	struct arch_unwind_info *ui;
+	int ret;
+
+	if (addr_space == NULL)
+		return NULL;
+
+	ui = zalloc(sizeof(*ui) + sizeof(ui->_ips[0]) * max_stack);
+	if (!ui)
+		return NULL;
+
+	ui->ui.machine = maps__machine(maps);
+	ui->ui.thread = thread;
+	ui->ui.sample = sample;
+	ui->ui.cursor = &ui->_cursor;
+	ui->ui.ips = &ui->_ips[0];
+	ui->ui.ips[0] = first_ip;
+	ui->ui.cur_ip = 1;
+	ui->ui.max_ips = max_stack;
+	ui->ui.unw_word_t_size = sizeof(unw_word_t);
+	ui->ui.e_machine = EM_RISCV;
+	ui->ui.best_effort = best_effort;
+
+	ret = unw_init_remote(&ui->_cursor, addr_space, &ui->ui);
+	if (ret) {
+		if (!best_effort)
+			pr_err("libunwind: %s\n", unw_strerror(ret));
+		free(ui);
+		return NULL;
+	}
+
+	return &ui->ui;
+#else
+	return NULL;
+#endif
+}
+
+int __libunwind_arch__unwind_step_riscv(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
+	int ret;
+
+	if (ui->cur_ip >= ui->max_ips)
+		return -1;
+
+	ret = unw_step(ui->cursor);
+	if (ret > 0) {
+		uint64_t ip;
+
+		unw_get_reg(ui->cursor, UNW_REG_IP, &ip);
+
+		if (unw_is_signal_frame(ui->cursor) <= 0) {
+			/*
+			 * Decrement the IP for any non-activation frames. This
+			 * is required to properly find the srcline for caller
+			 * frames.  See also the documentation for
+			 * dwfl_frame_pc(), which this code tries to replicate.
+			 */
+			--ip;
+		}
+		ui->ips[ui->cur_ip++] = ip;
+	}
+	return ret;
+#else
+	return -EINVAL;
+#endif
+}
-- 
2.53.0.1213.gd9a14994de-goog

