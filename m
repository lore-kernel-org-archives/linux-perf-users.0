Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6512253FC
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048511; cv=none; b=WxuvoBeXEnUHBtoe7SCG0NrGkrCzsm+IAg0ckfMMUmP2XVjUw5wAd/1UDHKRmT9LttSRsrVa0LoYhk680zuqkwDhMVNQ8B+LCIINNeH/4w72WRPUhvSsvABnf01he5KneybBkraP8YA7uPufx66XC9W3xQhng730dxm2B3HQgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048511; c=relaxed/simple;
	bh=h/PKK92lnr9XHZ+VErkxxdk6t6Phsh1y/t8lqIQdVWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J311JQcj9loXDOA3jQC1CIuJUiMUiOfibBZRp/nGiscxZ8gp61lgETtoCeXY6AT7ae9X7xqTyGABGzwnRwzjtyuSGr2gGmOGjphLlQpFVZojs4X8tK7qpvo/N3DKY7IaRJ2cFCgbsl4spvV8w7/5lJ29tNlukIyj7twR+kfVzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eaTxU2hA; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eaTxU2hA"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c28353912so6432534c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776048503; x=1776653303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=shRd23w8bdXWx6V2pVDn/qVhQ/PfNBTAgyQ9Yz269k8=;
        b=eaTxU2hAZWGR+uKUXwOu9DdRYSsO2FxOdgXwUe9Ng676R/i52GvQI0IobwXiSsY4w6
         3jBqJ20Mp24M3KzWK+j1yChWPaH3qEHxnD54W9sThvMzKsvL/vMwzgivTLgXIfhq6XFy
         4jIOIvB8xX5a14CU8i4iZAyCdTsneJBPn239pINHKmgsk7AgPnzOpAkqUKzHioEoI5PT
         mAh/rRvfHHAXECIOblf/MD67CeKR+G/3az3QZhn1oSV5zgt5MfuE1NfSj7qXwysA7xyF
         bW76BIW6/FtfQKmF2u1PRqYo9Gpk9I1qTJO8LV1p/hCu5uoJB/yO8+773mxceq6XIJax
         wbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776048503; x=1776653303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shRd23w8bdXWx6V2pVDn/qVhQ/PfNBTAgyQ9Yz269k8=;
        b=FUsXg1bCetzHzrtfR6pHp3z0QvAh6uBjqeZ4EZslp+ykPZ/IyAzn1bVH1hN4+xQF86
         zC8uPH7uY5/xnDN33jiiWRULj5F/Og33mF3sd+H/RPCjmna4efLLVzY17WNvyr5DeMca
         5had2jo1mYCjBlBF+Vfoa0Gk0BJ021uEboXDZALvSEDVUSeqLt7nSiiiQoDX5UCfcbn8
         5sUy/oQ57kULb+o+RFP/BOTFJJQUx80L0aj2Ymhxisy7Yt4YGDheBUmNh8SJmbg2NlR1
         nx1TymP1zU37mLMQWRZFDFJmFJWLwJ674hPiYC8oXdJHHv7gGL3DwtIQfIQylDkW23Tu
         GvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqT3ZLjiY/T8yLQ9vm1teTCxj5c6JGF/dKmTahZdgaD5pnugGHL++SV+ZOzJqxRmvIgI8WGLB/UCNLO9fWWgwK@vger.kernel.org
X-Gm-Message-State: AOJu0YxulT0knAh6ALttd/aoImintXTau1bFKCZ5X/OQPCgnVhGtShsO
	RYkvOmZugkTjhJoVu2MVH7N102zbJf5zU57MVTm9jQSGuftqnc9Eop1oWKgyBYyyzHZA89pS319
	4taSAF6wE2A==
X-Received: from dlbsw14.prod.google.com ([2002:a05:7022:3a8e:b0:12a:8440:6d03])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2528:b0:127:33e0:ea44
 with SMTP id a92af1059eb24-12c34eec8d0mr7114357c88.29.1776048503164; Sun, 12
 Apr 2026 19:48:23 -0700 (PDT)
Date: Sun, 12 Apr 2026 19:48:04 -0700
In-Reply-To: <20260413024805.1316480-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <advv6twWCEVBo_Hc@x1> <20260413024805.1316480-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413024805.1316480-8-irogers@google.com>
Subject: [PATCH v4 7/8] perf unwind-libunwind: Remove libunwind-local
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

Local unwinding only works on the machine libunwind is built for,
rather than cross platform, the APIs for remote and local unwinding
are similar but types like unw_word_t depend on the included
header. Place the architecture specific code into the appropriate
libunwind-<arch>.c file. Put generic code in unwind-libunwind.c and
use libunwind-arch to choose the correct implementation based on the
thread's e_machine. Structuring the code this way avoids including the
unwind-libunwind-local.c for each architecture of remote
unwinding. Data is moved into the struct unwind_info to simplify the
architecture and generic code, trying to keep as much code as possible
generic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build                         |   3 -
 .../perf/util/libunwind-arch/libunwind-arch.c | 184 ++++
 .../perf/util/libunwind-arch/libunwind-arch.h | 234 +++++
 .../perf/util/libunwind-arch/libunwind-arm.c  | 256 ++++++
 .../util/libunwind-arch/libunwind-arm64.c     | 255 ++++++
 .../perf/util/libunwind-arch/libunwind-i386.c | 254 ++++++
 .../util/libunwind-arch/libunwind-loongarch.c | 255 ++++++
 .../perf/util/libunwind-arch/libunwind-mips.c | 255 ++++++
 .../util/libunwind-arch/libunwind-ppc32.c     | 255 ++++++
 .../util/libunwind-arch/libunwind-ppc64.c     | 255 ++++++
 .../perf/util/libunwind-arch/libunwind-s390.c | 255 ++++++
 .../util/libunwind-arch/libunwind-x86_64.c    | 253 ++++++
 tools/perf/util/libunwind/arm64.c             |  35 -
 tools/perf/util/libunwind/x86_32.c            |  29 -
 tools/perf/util/maps.c                        |  10 -
 tools/perf/util/maps.h                        |   2 -
 tools/perf/util/unwind-libunwind-local.c      | 819 ------------------
 tools/perf/util/unwind-libunwind.c            | 654 +++++++++++++-
 tools/perf/util/unwind.h                      |   7 -
 19 files changed, 3334 insertions(+), 936 deletions(-)
 delete mode 100644 tools/perf/util/libunwind/arm64.c
 delete mode 100644 tools/perf/util/libunwind/x86_32.c
 delete mode 100644 tools/perf/util/unwind-libunwind-local.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index bf4204135ccb..2bb60f50f62d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -226,11 +226,8 @@ perf-util-$(CONFIG_LIBDW) += annotate-data.o
 perf-util-$(CONFIG_LIBDW) += libdw.o
 perf-util-$(CONFIG_LIBDW) += unwind-libdw.o
 
-perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
 perf-util-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
 perf-util-$(CONFIG_LIBUNWIND)          += libunwind-arch/
-perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
-perf-util-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
 
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-util-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
diff --git a/tools/perf/util/libunwind-arch/libunwind-arch.c b/tools/perf/util/libunwind-arch/libunwind-arch.c
index 9692e6c81492..8539b4233df4 100644
--- a/tools/perf/util/libunwind-arch/libunwind-arch.c
+++ b/tools/perf/util/libunwind-arch/libunwind-arch.c
@@ -112,3 +112,187 @@ void libunwind_arch__finish_access(struct maps *maps)
 		break;
 	}
 }
+
+void *libunwind_arch__create_addr_space(unsigned int e_machine)
+{
+	switch (e_machine) {
+	case EM_ARM:
+		return __libunwind_arch__create_addr_space_arm();
+	case EM_AARCH64:
+		return __libunwind_arch__create_addr_space_arm64();
+	case EM_LOONGARCH:
+		return __libunwind_arch__create_addr_space_loongarch();
+	case EM_MIPS:
+		return __libunwind_arch__create_addr_space_mips();
+	case EM_PPC:
+		return __libunwind_arch__create_addr_space_ppc32();
+	case EM_PPC64:
+		return __libunwind_arch__create_addr_space_ppc64();
+	case EM_S390:
+		return __libunwind_arch__create_addr_space_s390();
+	case EM_386:
+		return __libunwind_arch__create_addr_space_i386();
+	case EM_X86_64:
+		return __libunwind_arch__create_addr_space_x86_64();
+	default:
+		pr_err("ELF MACHINE %x is not supported.\n", e_machine);
+		return NULL;
+	}
+}
+
+int libunwind_arch__dwarf_search_unwind_table(unsigned int e_machine,
+					      void *as,
+					      uint64_t ip,
+					      struct libarch_unwind__dyn_info *di,
+					      void *pi,
+					      int need_unwind_info,
+					      void *arg)
+{
+	switch (e_machine) {
+	case EM_ARM:
+		return __libunwind_arch__dwarf_search_unwind_table_arm(as, ip, di, pi,
+								       need_unwind_info, arg);
+	case EM_AARCH64:
+		return __libunwind_arch__dwarf_search_unwind_table_arm64(as, ip, di, pi,
+									 need_unwind_info, arg);
+	case EM_LOONGARCH:
+		return __libunwind_arch__dwarf_search_unwind_table_loongarch(as, ip, di, pi,
+									     need_unwind_info, arg);
+	case EM_MIPS:
+		return __libunwind_arch__dwarf_search_unwind_table_mips(as, ip, di, pi,
+									need_unwind_info, arg);
+	case EM_PPC:
+		return __libunwind_arch__dwarf_search_unwind_table_ppc32(as, ip, di, pi,
+									 need_unwind_info, arg);
+	case EM_PPC64:
+		return __libunwind_arch__dwarf_search_unwind_table_ppc64(as, ip, di, pi,
+									 need_unwind_info, arg);
+	case EM_S390:
+		return __libunwind_arch__dwarf_search_unwind_table_s390(as, ip, di, pi,
+									need_unwind_info, arg);
+	case EM_386:
+		return __libunwind_arch__dwarf_search_unwind_table_i386(as, ip, di, pi,
+									need_unwind_info, arg);
+	case EM_X86_64:
+		return __libunwind_arch__dwarf_search_unwind_table_x86_64(as, ip, di, pi,
+									  need_unwind_info, arg);
+	default:
+		pr_err("ELF MACHINE %x is not supported.\n", e_machine);
+		return -EINVAL;
+	}
+}
+
+int libunwind_arch__dwarf_find_debug_frame(unsigned int e_machine,
+					   int found,
+					   struct libarch_unwind__dyn_info *di_debug,
+					   uint64_t ip,
+					   uint64_t segbase,
+					   const char *obj_name,
+					   uint64_t start,
+					   uint64_t end)
+{
+	switch (e_machine) {
+	case EM_ARM:
+		return __libunwind_arch__dwarf_find_debug_frame_arm(found, di_debug, ip, segbase,
+								    obj_name, start, end);
+	case EM_AARCH64:
+		return __libunwind_arch__dwarf_find_debug_frame_arm64(found, di_debug, ip, segbase,
+								      obj_name, start, end);
+	case EM_LOONGARCH:
+		return __libunwind_arch__dwarf_find_debug_frame_loongarch(found, di_debug, ip,
+									  segbase, obj_name,
+									  start, end);
+	case EM_MIPS:
+		return __libunwind_arch__dwarf_find_debug_frame_mips(found, di_debug, ip, segbase,
+								     obj_name, start, end);
+	case EM_PPC:
+		return __libunwind_arch__dwarf_find_debug_frame_ppc32(found, di_debug, ip, segbase,
+								      obj_name, start, end);
+	case EM_PPC64:
+		return __libunwind_arch__dwarf_find_debug_frame_ppc64(found, di_debug, ip, segbase,
+								      obj_name, start, end);
+	case EM_S390:
+		return __libunwind_arch__dwarf_find_debug_frame_s390(found, di_debug, ip, segbase,
+								     obj_name, start, end);
+	case EM_386:
+		return __libunwind_arch__dwarf_find_debug_frame_i386(found, di_debug, ip, segbase,
+								     obj_name, start, end);
+	case EM_X86_64:
+		return __libunwind_arch__dwarf_find_debug_frame_x86_64(found, di_debug, ip, segbase,
+								       obj_name, start, end);
+	default:
+		pr_err("ELF MACHINE %x is not supported.\n", e_machine);
+		return -EINVAL;
+	}
+}
+
+struct unwind_info *libunwind_arch_unwind_info__new(struct thread *thread,
+						    struct perf_sample *sample, int max_stack,
+						    bool best_effort, uint16_t e_machine,
+						    uint64_t first_ip)
+{
+	switch (e_machine) {
+	case EM_ARM:
+		return __libunwind_arch_unwind_info__new_arm(thread, sample, max_stack,
+							     best_effort, first_ip);
+	case EM_AARCH64:
+		return __libunwind_arch_unwind_info__new_arm64(thread, sample, max_stack,
+							       best_effort, first_ip);
+	case EM_LOONGARCH:
+		return __libunwind_arch_unwind_info__new_loongarch(thread, sample, max_stack,
+								   best_effort, first_ip);
+	case EM_MIPS:
+		return __libunwind_arch_unwind_info__new_mips(thread, sample, max_stack,
+							      best_effort, first_ip);
+	case EM_PPC:
+		return __libunwind_arch_unwind_info__new_ppc32(thread, sample, max_stack,
+							       best_effort, first_ip);
+	case EM_PPC64:
+		return __libunwind_arch_unwind_info__new_ppc64(thread, sample, max_stack,
+							       best_effort, first_ip);
+	case EM_S390:
+		return __libunwind_arch_unwind_info__new_s390(thread, sample, max_stack,
+							      best_effort, first_ip);
+	case EM_386:
+		return __libunwind_arch_unwind_info__new_i386(thread, sample, max_stack,
+							      best_effort, first_ip);
+	case EM_X86_64:
+		return __libunwind_arch_unwind_info__new_x86_64(thread, sample, max_stack,
+								best_effort, first_ip);
+	default:
+		pr_err("ELF MACHINE %x is not supported.\n", e_machine);
+		return NULL;
+	}
+}
+
+void libunwind_arch_unwind_info__delete(struct unwind_info *ui)
+{
+	free(ui);
+}
+
+int libunwind_arch__unwind_step(struct unwind_info *ui)
+{
+	switch (ui->e_machine) {
+	case EM_ARM:
+		return __libunwind_arch__unwind_step_arm(ui);
+	case EM_AARCH64:
+		return __libunwind_arch__unwind_step_arm64(ui);
+	case EM_LOONGARCH:
+		return __libunwind_arch__unwind_step_loongarch(ui);
+	case EM_MIPS:
+		return __libunwind_arch__unwind_step_mips(ui);
+	case EM_PPC:
+		return __libunwind_arch__unwind_step_ppc32(ui);
+	case EM_PPC64:
+		return __libunwind_arch__unwind_step_ppc64(ui);
+	case EM_S390:
+		return __libunwind_arch__unwind_step_s390(ui);
+	case EM_386:
+		return __libunwind_arch__unwind_step_i386(ui);
+	case EM_X86_64:
+		return __libunwind_arch__unwind_step_x86_64(ui);
+	default:
+		pr_err("ELF MACHINE %x is not supported.\n", ui->e_machine);
+		return -EINVAL;
+	}
+}
diff --git a/tools/perf/util/libunwind-arch/libunwind-arch.h b/tools/perf/util/libunwind-arch/libunwind-arch.h
index c00277a5e914..2bf7fc33313b 100644
--- a/tools/perf/util/libunwind-arch/libunwind-arch.h
+++ b/tools/perf/util/libunwind-arch/libunwind-arch.h
@@ -2,7 +2,36 @@
 #ifndef __LIBUNWIND_ARCH_H
 #define __LIBUNWIND_ARCH_H
 
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+struct machine;
 struct maps;
+struct perf_sample;
+struct thread;
+
+struct unwind_info {
+	struct machine		*machine;
+	struct thread		*thread;
+	struct perf_sample	*sample;
+	void			*cursor;
+	uint64_t		*ips;
+	int			 cur_ip;
+	int			 max_ips;
+	unsigned int		 unw_word_t_size;
+	uint16_t		 e_machine;
+	bool			 best_effort;
+};
+
+struct libarch_unwind__dyn_info {
+	uint64_t start_ip;
+	uint64_t end_ip;
+	uint64_t segbase;
+	uint64_t table_data;
+	uint64_t table_len;
+};
+struct libarch_unwind__proc_info;
 
 int __get_perf_regnum_for_unw_regnum_arm(int unw_regnum);
 int __get_perf_regnum_for_unw_regnum_arm64(int unw_regnum);
@@ -37,4 +66,209 @@ void __libunwind_arch__finish_access_i386(struct maps *maps);
 void __libunwind_arch__finish_access_x86_64(struct maps *maps);
 void libunwind_arch__finish_access(struct maps *maps);
 
+void *__libunwind_arch__create_addr_space_arm(void);
+void *__libunwind_arch__create_addr_space_arm64(void);
+void *__libunwind_arch__create_addr_space_loongarch(void);
+void *__libunwind_arch__create_addr_space_mips(void);
+void *__libunwind_arch__create_addr_space_ppc32(void);
+void *__libunwind_arch__create_addr_space_ppc64(void);
+void *__libunwind_arch__create_addr_space_s390(void);
+void *__libunwind_arch__create_addr_space_i386(void);
+void *__libunwind_arch__create_addr_space_x86_64(void);
+void *libunwind_arch__create_addr_space(unsigned int e_machine);
+
+int __libunwind__find_proc_info(void *as, uint64_t ip, void *pi, int need_unwind_info, void *arg);
+int __libunwind__access_mem(void *as, uint64_t addr, void *valp_word, int __write, void *arg);
+int __libunwind__access_reg(void *as, int regnum, void *valp_word, int __write, void *arg);
+
+int __libunwind_arch__dwarf_search_unwind_table_arm(void *as, uint64_t ip,
+						    struct libarch_unwind__dyn_info *di,
+						    void *pi,
+						    int need_unwind_info,
+						    void *arg);
+int __libunwind_arch__dwarf_search_unwind_table_arm64(void *as, uint64_t ip,
+						      struct libarch_unwind__dyn_info *di,
+						      void *pi,
+						      int need_unwind_info,
+						      void *arg);
+int __libunwind_arch__dwarf_search_unwind_table_loongarch(void *as, uint64_t ip,
+							  struct libarch_unwind__dyn_info *di,
+							  void *pi,
+							  int need_unwind_info,
+							  void *arg);
+int __libunwind_arch__dwarf_search_unwind_table_mips(void *as, uint64_t ip,
+						     struct libarch_unwind__dyn_info *di,
+						     void *pi,
+						     int need_unwind_info,
+						     void *arg);
+int __libunwind_arch__dwarf_search_unwind_table_ppc32(void *as, uint64_t ip,
+						      struct libarch_unwind__dyn_info *di,
+						      void *pi,
+						      int need_unwind_info,
+						      void *arg);
+int __libunwind_arch__dwarf_search_unwind_table_ppc64(void *as, uint64_t ip,
+						      struct libarch_unwind__dyn_info *di,
+						      void *pi,
+						      int need_unwind_info,
+						      void *arg);
+int __libunwind_arch__dwarf_search_unwind_table_s390(void *as, uint64_t ip,
+						     struct libarch_unwind__dyn_info *di,
+						     void *pi,
+						     int need_unwind_info,
+						     void *arg);
+int __libunwind_arch__dwarf_search_unwind_table_i386(void *as, uint64_t ip,
+						     struct libarch_unwind__dyn_info *di,
+						     void *pi,
+						     int need_unwind_info,
+						     void *arg);
+int __libunwind_arch__dwarf_search_unwind_table_x86_64(void *as, uint64_t ip,
+						       struct libarch_unwind__dyn_info *di,
+						       void *pi,
+						       int need_unwind_info,
+						       void *arg);
+int libunwind_arch__dwarf_search_unwind_table(unsigned int e_machine,
+					      void *as,
+					      uint64_t ip,
+					      struct libarch_unwind__dyn_info *di,
+					      void *pi,
+					      int need_unwind_info,
+					      void *arg);
+
+int __libunwind_arch__dwarf_find_debug_frame_arm(int found,
+						 struct libarch_unwind__dyn_info *di_debug,
+						 uint64_t ip,
+						 uint64_t segbase,
+						 const char *obj_name,
+						 uint64_t start,
+						 uint64_t end);
+int __libunwind_arch__dwarf_find_debug_frame_arm64(int found,
+						   struct libarch_unwind__dyn_info *di_debug,
+						   uint64_t ip,
+						   uint64_t segbase,
+						   const char *obj_name,
+						   uint64_t start,
+						   uint64_t end);
+int __libunwind_arch__dwarf_find_debug_frame_loongarch(int found,
+						       struct libarch_unwind__dyn_info *di_debug,
+						       uint64_t ip,
+						       uint64_t segbase,
+						       const char *obj_name,
+						       uint64_t start,
+						       uint64_t end);
+int __libunwind_arch__dwarf_find_debug_frame_mips(int found,
+						  struct libarch_unwind__dyn_info *di_debug,
+						  uint64_t ip,
+						  uint64_t segbase,
+						  const char *obj_name,
+						  uint64_t start,
+						  uint64_t end);
+int __libunwind_arch__dwarf_find_debug_frame_ppc32(int found,
+						   struct libarch_unwind__dyn_info *di_debug,
+						   uint64_t ip,
+						   uint64_t segbase,
+						   const char *obj_name,
+						   uint64_t start,
+						   uint64_t end);
+int __libunwind_arch__dwarf_find_debug_frame_ppc64(int found,
+						   struct libarch_unwind__dyn_info *di_debug,
+						   uint64_t ip,
+						   uint64_t segbase,
+						   const char *obj_name,
+						   uint64_t start,
+						   uint64_t end);
+int __libunwind_arch__dwarf_find_debug_frame_s390(int found,
+						  struct libarch_unwind__dyn_info *di_debug,
+						  uint64_t ip,
+						  uint64_t segbase,
+						  const char *obj_name,
+						  uint64_t start,
+						  uint64_t end);
+int __libunwind_arch__dwarf_find_debug_frame_i386(int found,
+						  struct libarch_unwind__dyn_info *di_debug,
+						  uint64_t ip,
+						  uint64_t segbase,
+						  const char *obj_name,
+						  uint64_t start,
+						  uint64_t end);
+int __libunwind_arch__dwarf_find_debug_frame_x86_64(int found,
+						    struct libarch_unwind__dyn_info *di_debug,
+						    uint64_t ip,
+						    uint64_t segbase,
+						    const char *obj_name,
+						    uint64_t start,
+						    uint64_t end);
+int libunwind_arch__dwarf_find_debug_frame(unsigned int e_machine,
+					   int found,
+					   struct libarch_unwind__dyn_info *di_debug,
+					   uint64_t ip,
+					   uint64_t segbase,
+					   const char *obj_name,
+					   uint64_t start,
+					   uint64_t end);
+
+struct unwind_info *__libunwind_arch_unwind_info__new_arm(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
+struct unwind_info *__libunwind_arch_unwind_info__new_arm64(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
+struct unwind_info *__libunwind_arch_unwind_info__new_loongarch(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
+struct unwind_info *__libunwind_arch_unwind_info__new_mips(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
+struct unwind_info *__libunwind_arch_unwind_info__new_ppc32(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
+struct unwind_info *__libunwind_arch_unwind_info__new_ppc64(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
+struct unwind_info *__libunwind_arch_unwind_info__new_s390(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
+struct unwind_info *__libunwind_arch_unwind_info__new_i386(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
+struct unwind_info *__libunwind_arch_unwind_info__new_x86_64(struct thread *thread,
+							struct perf_sample *sample,
+							   int max_stack,
+							   bool best_effort,
+							uint64_t first_ip);
+struct unwind_info *libunwind_arch_unwind_info__new(struct thread *thread,
+						struct perf_sample *sample,
+						int max_stack,
+						bool best_effort,
+						uint16_t e_machine,
+						uint64_t first_ip);
+
+void libunwind_arch_unwind_info__delete(struct unwind_info *ui);
+
+int __libunwind_arch__unwind_step_arm(struct unwind_info *ui);
+int __libunwind_arch__unwind_step_arm64(struct unwind_info *ui);
+int __libunwind_arch__unwind_step_loongarch(struct unwind_info *ui);
+int __libunwind_arch__unwind_step_mips(struct unwind_info *ui);
+int __libunwind_arch__unwind_step_ppc32(struct unwind_info *ui);
+int __libunwind_arch__unwind_step_ppc64(struct unwind_info *ui);
+int __libunwind_arch__unwind_step_s390(struct unwind_info *ui);
+int __libunwind_arch__unwind_step_i386(struct unwind_info *ui);
+int __libunwind_arch__unwind_step_x86_64(struct unwind_info *ui);
+int libunwind_arch__unwind_step(struct unwind_info *ui);
+
 #endif /* __LIBUNWIND_ARCH_H */
diff --git a/tools/perf/util/libunwind-arch/libunwind-arm.c b/tools/perf/util/libunwind-arch/libunwind-arm.c
index bbaf01406c52..b31aeeab1663 100644
--- a/tools/perf/util/libunwind-arch/libunwind-arm.c
+++ b/tools/perf/util/libunwind-arch/libunwind-arm.c
@@ -2,8 +2,12 @@
 #include "libunwind-arch.h"
 #include "../debug.h"
 #include "../maps.h"
+#include "../thread.h"
 #include "../../../arch/arm/include/uapi/asm/perf_regs.h"
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
 #include <errno.h>
 
 #ifdef HAVE_LIBUNWIND_ARM_SUPPORT
@@ -32,3 +36,255 @@ void __libunwind_arch__finish_access_arm(struct maps *maps __maybe_unused)
 	unw_destroy_addr_space(maps__addr_space(maps));
 #endif
 }
+
+
+#ifdef HAVE_LIBUNWIND_ARM_SUPPORT
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
+void *__libunwind_arch__create_addr_space_arm(void)
+{
+#ifdef HAVE_LIBUNWIND_ARM_SUPPORT
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
+#ifdef HAVE_LIBUNWIND_ARM_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_arm(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_ARM_SUPPORT
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
+#if defined(HAVE_LIBUNWIND_ARM_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_ARM)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_arm(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_ARM_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_ARM)
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
+struct unwind_info *__libunwind_arch_unwind_info__new_arm(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_ARM_SUPPORT
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
+	ui->ui.e_machine = EM_ARM;
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
+int __libunwind_arch__unwind_step_arm(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_ARM_SUPPORT
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
diff --git a/tools/perf/util/libunwind-arch/libunwind-arm64.c b/tools/perf/util/libunwind-arch/libunwind-arm64.c
index 8ba510089736..ceeae2d0f8e9 100644
--- a/tools/perf/util/libunwind-arch/libunwind-arm64.c
+++ b/tools/perf/util/libunwind-arch/libunwind-arm64.c
@@ -2,8 +2,12 @@
 #include "libunwind-arch.h"
 #include "../debug.h"
 #include "../maps.h"
+#include "../thread.h"
 #include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
 #include <errno.h>
 
 #ifdef HAVE_LIBUNWIND_AARCH64_SUPPORT
@@ -32,3 +36,254 @@ void __libunwind_arch__finish_access_arm64(struct maps *maps __maybe_unused)
 	unw_destroy_addr_space(maps__addr_space(maps));
 #endif
 }
+
+#ifdef HAVE_LIBUNWIND_AARCH64_SUPPORT
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
+void *__libunwind_arch__create_addr_space_arm64(void)
+{
+#ifdef HAVE_LIBUNWIND_AARCH64_SUPPORT
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
+#ifdef HAVE_LIBUNWIND_ARM64_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_arm64(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_ARM64_SUPPORT
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
+#if defined(HAVE_LIBUNWIND_ARM64_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_ARM64)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_arm64(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_ARM64_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_ARM64)
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
+struct unwind_info *__libunwind_arch_unwind_info__new_arm64(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_ARM64_SUPPORT
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
+	ui->ui.e_machine = EM_AARCH64;
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
+int __libunwind_arch__unwind_step_arm64(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_ARM64_SUPPORT
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
diff --git a/tools/perf/util/libunwind-arch/libunwind-i386.c b/tools/perf/util/libunwind-arch/libunwind-i386.c
index 45ff30c95c1b..fde40872a610 100644
--- a/tools/perf/util/libunwind-arch/libunwind-i386.c
+++ b/tools/perf/util/libunwind-arch/libunwind-i386.c
@@ -2,9 +2,12 @@
 #include "libunwind-arch.h"
 #include "../debug.h"
 #include "../maps.h"
+#include "../thread.h"
 #include "../../../arch/x86/include/uapi/asm/perf_regs.h"
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
 #include <errno.h>
 
 #ifdef HAVE_LIBUNWIND_X86_SUPPORT
@@ -56,3 +59,254 @@ void __libunwind_arch__finish_access_i386(struct maps *maps __maybe_unused)
 	unw_destroy_addr_space(maps__addr_space(maps));
 #endif
 }
+
+#ifdef HAVE_LIBUNWIND_X86_SUPPORT
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
+void *__libunwind_arch__create_addr_space_i386(void)
+{
+#ifdef HAVE_LIBUNWIND_X86_SUPPORT
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
+#ifdef HAVE_LIBUNWIND_X86_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_i386(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_X86_SUPPORT
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
+#if defined(HAVE_LIBUNWIND_X86_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_X86)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_i386(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_X86_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_X86)
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
+struct unwind_info *__libunwind_arch_unwind_info__new_i386(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_X86_SUPPORT
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
+	ui->ui.e_machine = EM_I386;
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
+int __libunwind_arch__unwind_step_i386(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_X86_SUPPORT
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
diff --git a/tools/perf/util/libunwind-arch/libunwind-loongarch.c b/tools/perf/util/libunwind-arch/libunwind-loongarch.c
index 837aa11e2b9f..d86397598a9d 100644
--- a/tools/perf/util/libunwind-arch/libunwind-loongarch.c
+++ b/tools/perf/util/libunwind-arch/libunwind-loongarch.c
@@ -2,8 +2,12 @@
 #include "libunwind-arch.h"
 #include "../debug.h"
 #include "../maps.h"
+#include "../thread.h"
 #include "../../../arch/loongarch/include/uapi/asm/perf_regs.h"
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
 #include <errno.h>
 
 #ifdef HAVE_LIBUNWIND_LOONGARCH64_SUPPORT
@@ -40,3 +44,254 @@ void __libunwind_arch__finish_access_loongarch(struct maps *maps __maybe_unused)
 	unw_destroy_addr_space(maps__addr_space(maps));
 #endif
 }
+
+#ifdef HAVE_LIBUNWIND_LOONGARCH64_SUPPORT
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
+void *__libunwind_arch__create_addr_space_loongarch(void)
+{
+#ifdef HAVE_LIBUNWIND_LOONGARCH64_SUPPORT
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
+#ifdef HAVE_LIBUNWIND_LOONGARCH_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_loongarch(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_LOONGARCH_SUPPORT
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
+#if defined(HAVE_LIBUNWIND_LOONGARCH_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_LOONGARCH)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_loongarch(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_LOONGARCH_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_LOONGARCH)
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
+struct unwind_info *__libunwind_arch_unwind_info__new_loongarch(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_LOONGARCH_SUPPORT
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
+	ui->ui.e_machine = EM_LOONGARCH;
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
+int __libunwind_arch__unwind_step_loongarch(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_LOONGARCH_SUPPORT
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
diff --git a/tools/perf/util/libunwind-arch/libunwind-mips.c b/tools/perf/util/libunwind-arch/libunwind-mips.c
index 1fa81742ff4a..91ee3c27d159 100644
--- a/tools/perf/util/libunwind-arch/libunwind-mips.c
+++ b/tools/perf/util/libunwind-arch/libunwind-mips.c
@@ -2,8 +2,12 @@
 #include "libunwind-arch.h"
 #include "../debug.h"
 #include "../maps.h"
+#include "../thread.h"
 #include "../../../arch/mips/include/uapi/asm/perf_regs.h"
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
 #include <errno.h>
 
 #ifdef HAVE_LIBUNWIND_MIPS_SUPPORT
@@ -42,3 +46,254 @@ void __libunwind_arch__finish_access_mips(struct maps *maps __maybe_unused)
 	unw_destroy_addr_space(maps__addr_space(maps));
 #endif
 }
+
+#ifdef HAVE_LIBUNWIND_MIPS_SUPPORT
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
+void *__libunwind_arch__create_addr_space_mips(void)
+{
+#ifdef HAVE_LIBUNWIND_MIPS_SUPPORT
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
+#ifdef HAVE_LIBUNWIND_MIPS_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_mips(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_MIPS_SUPPORT
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
+#if defined(HAVE_LIBUNWIND_MIPS_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_MIPS)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_mips(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_MIPS_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_MIPS)
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
+struct unwind_info *__libunwind_arch_unwind_info__new_mips(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_MIPS_SUPPORT
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
+	ui->ui.e_machine = EM_MIPS;
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
+int __libunwind_arch__unwind_step_mips(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_MIPS_SUPPORT
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
diff --git a/tools/perf/util/libunwind-arch/libunwind-ppc32.c b/tools/perf/util/libunwind-arch/libunwind-ppc32.c
index fa8471c74bf3..b80d3184a28d 100644
--- a/tools/perf/util/libunwind-arch/libunwind-ppc32.c
+++ b/tools/perf/util/libunwind-arch/libunwind-ppc32.c
@@ -2,8 +2,12 @@
 #include "libunwind-arch.h"
 #include "../debug.h"
 #include "../maps.h"
+#include "../thread.h"
 #include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
 #include <errno.h>
 
 #ifdef HAVE_LIBUNWIND_PPC32_SUPPORT
@@ -44,3 +48,254 @@ void __libunwind_arch__finish_access_ppc32(struct maps *maps __maybe_unused)
 	unw_destroy_addr_space(maps__addr_space(maps));
 #endif
 }
+
+#ifdef HAVE_LIBUNWIND_PPC32_SUPPORT
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
+void *__libunwind_arch__create_addr_space_ppc32(void)
+{
+#ifdef HAVE_LIBUNWIND_PPC32_SUPPORT
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
+#ifdef HAVE_LIBUNWIND_PPC32_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_ppc32(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_PPC32_SUPPORT
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
+#if defined(HAVE_LIBUNWIND_PPC32_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_PPC32)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_ppc32(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_PPC32_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_PPC32)
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
+struct unwind_info *__libunwind_arch_unwind_info__new_ppc32(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_PPC32_SUPPORT
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
+	ui->ui.e_machine = EM_PPC;
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
+int __libunwind_arch__unwind_step_ppc32(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_PPC32_SUPPORT
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
diff --git a/tools/perf/util/libunwind-arch/libunwind-ppc64.c b/tools/perf/util/libunwind-arch/libunwind-ppc64.c
index 2f746e347336..cbe3b476203f 100644
--- a/tools/perf/util/libunwind-arch/libunwind-ppc64.c
+++ b/tools/perf/util/libunwind-arch/libunwind-ppc64.c
@@ -2,8 +2,12 @@
 #include "libunwind-arch.h"
 #include "../debug.h"
 #include "../maps.h"
+#include "../thread.h"
 #include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
 #include <errno.h>
 
 #ifdef HAVE_LIBUNWIND_PPC64_SUPPORT
@@ -46,3 +50,254 @@ void __libunwind_arch__finish_access_ppc64(struct maps *maps __maybe_unused)
 	unw_destroy_addr_space(maps__addr_space(maps));
 #endif
 }
+
+#ifdef HAVE_LIBUNWIND_PPC64_SUPPORT
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
+void *__libunwind_arch__create_addr_space_ppc64(void)
+{
+#ifdef HAVE_LIBUNWIND_PPC64_SUPPORT
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
+#ifdef HAVE_LIBUNWIND_PPC64_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_ppc64(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_PPC64_SUPPORT
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
+#if defined(HAVE_LIBUNWIND_PPC64_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_PPC64)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_ppc64(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_PPC64_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_PPC64)
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
+struct unwind_info *__libunwind_arch_unwind_info__new_ppc64(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_PPC64_SUPPORT
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
+	ui->ui.e_machine = EM_PPC64;
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
+int __libunwind_arch__unwind_step_ppc64(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_PPC64_SUPPORT
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
diff --git a/tools/perf/util/libunwind-arch/libunwind-s390.c b/tools/perf/util/libunwind-arch/libunwind-s390.c
index 9f68d15438b2..ce3788e86d1f 100644
--- a/tools/perf/util/libunwind-arch/libunwind-s390.c
+++ b/tools/perf/util/libunwind-arch/libunwind-s390.c
@@ -2,8 +2,12 @@
 #include "libunwind-arch.h"
 #include "../debug.h"
 #include "../maps.h"
+#include "../thread.h"
 #include "../../../arch/s390/include/uapi/asm/perf_regs.h"
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
 #include <errno.h>
 
 #ifdef HAVE_LIBUNWIND_S390X_SUPPORT
@@ -42,3 +46,254 @@ void __libunwind_arch__finish_access_s390(struct maps *maps __maybe_unused)
 	unw_destroy_addr_space(maps__addr_space(maps));
 #endif
 }
+
+#ifdef HAVE_LIBUNWIND_S390X_SUPPORT
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
+void *__libunwind_arch__create_addr_space_s390(void)
+{
+#ifdef HAVE_LIBUNWIND_S390X_SUPPORT
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
+#ifdef HAVE_LIBUNWIND_S390X_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_s390(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_S390X_SUPPORT
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
+#if defined(HAVE_LIBUNWIND_S390X_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_S390X)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_s390(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_S390X_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_S390X)
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
+struct unwind_info *__libunwind_arch_unwind_info__new_s390(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_S390X_SUPPORT
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
+	ui->ui.e_machine = EM_S390;
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
+int __libunwind_arch__unwind_step_s390(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_S390X_SUPPORT
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
diff --git a/tools/perf/util/libunwind-arch/libunwind-x86_64.c b/tools/perf/util/libunwind-arch/libunwind-x86_64.c
index 25e326bd3e15..8ca66d442ffc 100644
--- a/tools/perf/util/libunwind-arch/libunwind-x86_64.c
+++ b/tools/perf/util/libunwind-arch/libunwind-x86_64.c
@@ -2,9 +2,12 @@
 #include "libunwind-arch.h"
 #include "../debug.h"
 #include "../maps.h"
+#include "../thread.h"
 #include "../../../arch/x86/include/uapi/asm/perf_regs.h"
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <elf.h>
 #include <errno.h>
 
 #ifdef HAVE_LIBUNWIND_X86_64_SUPPORT
@@ -65,3 +68,253 @@ void __libunwind_arch__finish_access_x86_64(struct maps *maps __maybe_unused)
 	unw_destroy_addr_space(maps__addr_space(maps));
 #endif
 }
+
+#ifdef HAVE_LIBUNWIND_X86_64_SUPPORT
+static int find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
+			  int need_unwind_info, void *arg)
+{
+	return __libunwind__find_proc_info(as, ip, pi, need_unwind_info, arg);
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
+	return __libunwind__access_mem(as, addr, valp, __write, arg);
+}
+
+static int access_reg(unw_addr_space_t as, unw_regnum_t regnum, unw_word_t *valp,
+		      int __write, void *arg)
+{
+	return __libunwind__access_reg(as, regnum, valp, __write, arg);
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
+void *__libunwind_arch__create_addr_space_x86_64(void)
+{
+#ifdef HAVE_LIBUNWIND_X86_64_SUPPORT
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
+#ifdef HAVE_LIBUNWIND_X86_64_SUPPORT
+extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
+					       unw_word_t ip,
+					       unw_dyn_info_t *di,
+					       unw_proc_info_t *pi,
+					       int need_unwind_info, void *arg);
+#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
+#endif
+
+int __libunwind_arch__dwarf_search_unwind_table_x86_64(void *as __maybe_unused,
+						       uint64_t ip __maybe_unused,
+						       struct libarch_unwind__dyn_info *_di __maybe_unused,
+						       void *pi __maybe_unused,
+						       int need_unwind_info __maybe_unused,
+						       void *arg __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_X86_64_SUPPORT
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
+#if defined(HAVE_LIBUNWIND_X86_64_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_X86_64)
+extern int UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
+					    unw_word_t ip,
+					    unw_word_t segbase,
+					    const char *obj_name, unw_word_t start,
+					    unw_word_t end);
+#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
+#endif
+
+int __libunwind_arch__dwarf_find_debug_frame_x86_64(int found __maybe_unused,
+						 struct libarch_unwind__dyn_info *_di __maybe_unused,
+						 uint64_t ip __maybe_unused,
+						 uint64_t segbase __maybe_unused,
+						 const char *obj_name __maybe_unused,
+						 uint64_t start __maybe_unused,
+						 uint64_t end __maybe_unused)
+{
+#if defined(HAVE_LIBUNWIND_X86_64_SUPPORT) && !defined(NO_LIBUNWIND_DEBUG_FRAME_X86_64)
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
+struct unwind_info *__libunwind_arch_unwind_info__new_x86_64(struct thread *thread __maybe_unused,
+							     struct perf_sample *sample  __maybe_unused,
+							     int max_stack __maybe_unused,
+							     bool best_effort  __maybe_unused,
+							     uint64_t first_ip  __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_X86_64_SUPPORT
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
+	ui->ui.e_machine = EM_X86_64;
+	ui->ui.best_effort = best_effort;
+
+	ret = unw_init_remote(&ui->_cursor, addr_space, &ui->ui);
+	if (ret) {
+		if (!best_effort)
+			pr_err("libunwind: %s\n", unw_strerror(ret));
+		free(ui);
+		return NULL;
+	}
+	return &ui->ui;
+#else
+	return NULL;
+#endif
+}
+
+int __libunwind_arch__unwind_step_x86_64(struct unwind_info *ui __maybe_unused)
+{
+#ifdef HAVE_LIBUNWIND_X86_64_SUPPORT
+	int ret;
+
+	if (ui->cur_ip >= ui->max_ips)
+		return 0;
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
diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
deleted file mode 100644
index 15670a964495..000000000000
--- a/tools/perf/util/libunwind/arm64.c
+++ /dev/null
@@ -1,35 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This file setups defines to compile arch specific binary from the
- * generic one.
- *
- * The function 'LIBUNWIND__ARCH_REG_ID' name is set according to arch
- * name and the definition of this function is included directly from
- * 'arch/arm64/util/unwind-libunwind.c', to make sure that this function
- * is defined no matter what arch the host is.
- *
- * Finally, the arch specific unwind methods are exported which will
- * be assigned to each arm64 thread.
- */
-
-#define REMOTE_UNWIND_LIBUNWIND
-
-#include "unwind.h"
-#include "libunwind-aarch64.h"
-#define perf_event_arm_regs perf_event_arm64_regs
-#include <../../../arch/arm64/include/uapi/asm/perf_regs.h>
-#undef perf_event_arm_regs
-#include "../../arch/arm64/util/unwind-libunwind.c"
-
-/* NO_LIBUNWIND_DEBUG_FRAME is a feature flag for local libunwind,
- * assign NO_LIBUNWIND_DEBUG_FRAME_AARCH64 to it for compiling arm64
- * unwind methods.
- */
-#undef NO_LIBUNWIND_DEBUG_FRAME
-#ifdef NO_LIBUNWIND_DEBUG_FRAME_AARCH64
-#define NO_LIBUNWIND_DEBUG_FRAME
-#endif
-#include "util/unwind-libunwind-local.c"
-
-struct unwind_libunwind_ops *
-arm64_unwind_libunwind_ops = &_unwind_libunwind_ops;
diff --git a/tools/perf/util/libunwind/x86_32.c b/tools/perf/util/libunwind/x86_32.c
deleted file mode 100644
index 1e9fb8bfec44..000000000000
--- a/tools/perf/util/libunwind/x86_32.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This file setups defines to compile arch specific binary from the
- * generic one.
- *
- * The function 'LIBUNWIND__ARCH_REG_ID' name is set according to arch
- * name and the definition of this function is included directly from
- * 'arch/x86/util/unwind-libunwind.c', to make sure that this function
- * is defined no matter what arch the host is.
- *
- * Finally, the arch specific unwind methods are exported which will
- * be assigned to each x86 thread.
- */
-
-#define REMOTE_UNWIND_LIBUNWIND
-
-#include "unwind.h"
-#include "libunwind-x86.h"
-
-/* Explicitly define NO_LIBUNWIND_DEBUG_FRAME, because non-ARM has no
- * dwarf_find_debug_frame() function.
- */
-#ifndef NO_LIBUNWIND_DEBUG_FRAME
-#define NO_LIBUNWIND_DEBUG_FRAME
-#endif
-#include "util/unwind-libunwind-local.c"
-
-struct unwind_libunwind_ops *
-x86_32_unwind_libunwind_ops = &_unwind_libunwind_ops;
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 213288d6387d..76628019361b 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -198,16 +198,6 @@ void maps__set_addr_space(struct maps *maps, void *addr_space)
 	RC_CHK_ACCESS(maps)->addr_space = addr_space;
 }
 
-const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->unwind_libunwind_ops;
-}
-
-void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libunwind_ops *ops)
-{
-	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = ops;
-}
-
 uint16_t maps__e_machine(const struct maps *maps)
 {
 	return RC_CHK_ACCESS(maps)->e_machine;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 6469f62c41a8..5b80b199685e 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -49,8 +49,6 @@ refcount_t *maps__refcnt(struct maps *maps); /* Test only. */
 #ifdef HAVE_LIBUNWIND_SUPPORT
 void *maps__addr_space(const struct maps *maps);
 void maps__set_addr_space(struct maps *maps, void *addr_space);
-const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps);
-void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libunwind_ops *ops);
 uint16_t maps__e_machine(const struct maps *maps);
 void maps__set_e_machine(struct maps *maps, uint16_t e_machine);
 #endif
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
deleted file mode 100644
index d4b5a5fa6606..000000000000
--- a/tools/perf/util/unwind-libunwind-local.c
+++ /dev/null
@@ -1,819 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Post mortem Dwarf CFI based unwinding on top of regs and stack dumps.
- *
- * Lots of this code have been borrowed or heavily inspired from parts of
- * the libunwind 0.99 code which are (amongst other contributors I may have
- * forgotten):
- *
- * Copyright (C) 2002-2007 Hewlett-Packard Co
- *	Contributed by David Mosberger-Tang <davidm@hpl.hp.com>
- *
- * And the bugs have been added by:
- *
- * Copyright (C) 2010, Frederic Weisbecker <fweisbec@gmail.com>
- * Copyright (C) 2012, Jiri Olsa <jolsa@redhat.com>
- *
- */
-
-#include <elf.h>
-#include <errno.h>
-#include <gelf.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <linux/list.h>
-#ifndef REMOTE_UNWIND_LIBUNWIND
-#include <libunwind.h>
-#include <libunwind-ptrace.h>
-#endif
-#include "callchain.h"
-#include "thread.h"
-#include "session.h"
-#include "perf_regs.h"
-#include "unwind.h"
-#include "map.h"
-#include "symbol.h"
-#include "debug.h"
-#include "asm/bug.h"
-#include "dso.h"
-#include "libunwind-arch/libunwind-arch.h"
-
-extern int
-UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
-				    unw_word_t ip,
-				    unw_dyn_info_t *di,
-				    unw_proc_info_t *pi,
-				    int need_unwind_info, void *arg);
-
-#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
-
-extern int
-UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
-				 unw_word_t ip,
-				 unw_word_t segbase,
-				 const char *obj_name, unw_word_t start,
-				 unw_word_t end);
-
-#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
-
-#define DW_EH_PE_FORMAT_MASK	0x0f	/* format of the encoded value */
-#define DW_EH_PE_APPL_MASK	0x70	/* how the value is to be applied */
-
-/* Pointer-encoding formats: */
-#define DW_EH_PE_omit		0xff
-#define DW_EH_PE_ptr		0x00	/* pointer-sized unsigned value */
-#define DW_EH_PE_udata4		0x03	/* unsigned 32-bit value */
-#define DW_EH_PE_udata8		0x04	/* unsigned 64-bit value */
-#define DW_EH_PE_sdata4		0x0b	/* signed 32-bit value */
-#define DW_EH_PE_sdata8		0x0c	/* signed 64-bit value */
-
-/* Pointer-encoding application: */
-#define DW_EH_PE_absptr		0x00	/* absolute value */
-#define DW_EH_PE_pcrel		0x10	/* rel. to addr. of encoded value */
-
-/*
- * The following are not documented by LSB v1.3, yet they are used by
- * GCC, presumably they aren't documented by LSB since they aren't
- * used on Linux:
- */
-#define DW_EH_PE_funcrel	0x40	/* start-of-procedure-relative */
-#define DW_EH_PE_aligned	0x50	/* aligned pointer */
-
-/* Flags intentionally not handled, since they're not needed:
- * #define DW_EH_PE_indirect      0x80
- * #define DW_EH_PE_uleb128       0x01
- * #define DW_EH_PE_udata2        0x02
- * #define DW_EH_PE_sleb128       0x09
- * #define DW_EH_PE_sdata2        0x0a
- * #define DW_EH_PE_textrel       0x20
- * #define DW_EH_PE_datarel       0x30
- */
-
-struct unwind_info {
-	struct perf_sample	*sample;
-	struct machine		*machine;
-	struct thread		*thread;
-	uint16_t		 e_machine;
-	bool			 best_effort;
-};
-
-#define dw_read(ptr, type, end) ({	\
-	type *__p = (type *) ptr;	\
-	type  __v;			\
-	if ((__p + 1) > (type *) end)	\
-		return -EINVAL;		\
-	__v = *__p++;			\
-	ptr = (typeof(ptr)) __p;	\
-	__v;				\
-	})
-
-static int __dw_read_encoded_value(u8 **p, u8 *end, u64 *val,
-				   u8 encoding)
-{
-	u8 *cur = *p;
-	*val = 0;
-
-	switch (encoding) {
-	case DW_EH_PE_omit:
-		*val = 0;
-		goto out;
-	case DW_EH_PE_ptr:
-		*val = dw_read(cur, unsigned long, end);
-		goto out;
-	default:
-		break;
-	}
-
-	switch (encoding & DW_EH_PE_APPL_MASK) {
-	case DW_EH_PE_absptr:
-		break;
-	case DW_EH_PE_pcrel:
-		*val = (unsigned long) cur;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if ((encoding & 0x07) == 0x00)
-		encoding |= DW_EH_PE_udata4;
-
-	switch (encoding & DW_EH_PE_FORMAT_MASK) {
-	case DW_EH_PE_sdata4:
-		*val += dw_read(cur, s32, end);
-		break;
-	case DW_EH_PE_udata4:
-		*val += dw_read(cur, u32, end);
-		break;
-	case DW_EH_PE_sdata8:
-		*val += dw_read(cur, s64, end);
-		break;
-	case DW_EH_PE_udata8:
-		*val += dw_read(cur, u64, end);
-		break;
-	default:
-		return -EINVAL;
-	}
-
- out:
-	*p = cur;
-	return 0;
-}
-
-#define dw_read_encoded_value(ptr, end, enc) ({			\
-	u64 __v;						\
-	if (__dw_read_encoded_value(&ptr, end, &__v, enc)) {	\
-		return -EINVAL;                                 \
-	}                                                       \
-	__v;                                                    \
-	})
-
-static int elf_section_address_and_offset(int fd, const char *name, u64 *address, u64 *offset)
-{
-	Elf *elf;
-	GElf_Ehdr ehdr;
-	GElf_Shdr shdr;
-	int ret = -1;
-
-	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
-	if (elf == NULL)
-		return -1;
-
-	if (gelf_getehdr(elf, &ehdr) == NULL)
-		goto out_err;
-
-	if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
-		goto out_err;
-
-	*address = shdr.sh_addr;
-	*offset = shdr.sh_offset;
-	ret = 0;
-out_err:
-	elf_end(elf);
-	return ret;
-}
-
-#ifndef NO_LIBUNWIND_DEBUG_FRAME
-static u64 elf_section_offset(int fd, const char *name)
-{
-	u64 address, offset = 0;
-
-	if (elf_section_address_and_offset(fd, name, &address, &offset))
-		return 0;
-
-	return offset;
-}
-#endif
-
-static u64 elf_base_address(int fd)
-{
-	Elf *elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
-	GElf_Phdr phdr;
-	u64 retval = 0;
-	size_t i, phdrnum = 0;
-
-	if (elf == NULL)
-		return 0;
-	(void)elf_getphdrnum(elf, &phdrnum);
-	/* PT_LOAD segments are sorted by p_vaddr, so the first has the minimum p_vaddr. */
-	for (i = 0; i < phdrnum; i++) {
-		if (gelf_getphdr(elf, i, &phdr) && phdr.p_type == PT_LOAD) {
-			retval = phdr.p_vaddr & -getpagesize();
-			break;
-		}
-	}
-
-	elf_end(elf);
-	return retval;
-}
-
-#ifndef NO_LIBUNWIND_DEBUG_FRAME
-static int elf_is_exec(int fd, const char *name)
-{
-	Elf *elf;
-	GElf_Ehdr ehdr;
-	int retval = 0;
-
-	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
-	if (elf == NULL)
-		return 0;
-	if (gelf_getehdr(elf, &ehdr) == NULL)
-		goto out;
-
-	retval = (ehdr.e_type == ET_EXEC);
-
-out:
-	elf_end(elf);
-	pr_debug("unwind: elf_is_exec(%s): %d\n", name, retval);
-	return retval;
-}
-#endif
-
-struct table_entry {
-	u32 start_ip_offset;
-	u32 fde_offset;
-};
-
-struct eh_frame_hdr {
-	unsigned char version;
-	unsigned char eh_frame_ptr_enc;
-	unsigned char fde_count_enc;
-	unsigned char table_enc;
-
-	/*
-	 * The rest of the header is variable-length and consists of the
-	 * following members:
-	 *
-	 *	encoded_t eh_frame_ptr;
-	 *	encoded_t fde_count;
-	 */
-
-	/* A single encoded pointer should not be more than 8 bytes. */
-	u64 enc[2];
-
-	/*
-	 * struct {
-	 *    encoded_t start_ip;
-	 *    encoded_t fde_addr;
-	 * } binary_search_table[fde_count];
-	 */
-	char data[];
-} __packed;
-
-static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
-			       u64 offset, u64 *table_data_offset, u64 *fde_count)
-{
-	struct eh_frame_hdr hdr;
-	u8 *enc = (u8 *) &hdr.enc;
-	u8 *end = (u8 *) &hdr.data;
-	ssize_t r;
-
-	r = dso__data_read_offset(dso, machine, offset,
-				  (u8 *) &hdr, sizeof(hdr));
-	if (r != sizeof(hdr))
-		return -EINVAL;
-
-	/* We dont need eh_frame_ptr, just skip it. */
-	dw_read_encoded_value(enc, end, hdr.eh_frame_ptr_enc);
-
-	*fde_count  = dw_read_encoded_value(enc, end, hdr.fde_count_enc);
-	*table_data_offset = enc - (u8 *) &hdr;
-	return 0;
-}
-
-struct read_unwind_spec_eh_frame_maps_cb_args {
-	struct dso *dso;
-	u64 base_addr;
-};
-
-static int read_unwind_spec_eh_frame_maps_cb(struct map *map, void *data)
-{
-
-	struct read_unwind_spec_eh_frame_maps_cb_args *args = data;
-
-	if (map__dso(map) == args->dso && map__start(map) - map__pgoff(map) < args->base_addr)
-		args->base_addr = map__start(map) - map__pgoff(map);
-
-	return 0;
-}
-
-
-static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
-				     u64 *table_data, u64 *segbase,
-				     u64 *fde_count)
-{
-	struct read_unwind_spec_eh_frame_maps_cb_args args = {
-		.dso = dso,
-		.base_addr = UINT64_MAX,
-	};
-	int ret, fd;
-
-	if (dso__data(dso)->eh_frame_hdr_offset == 0) {
-		if (!dso__data_get_fd(dso, ui->machine, &fd))
-			return -EINVAL;
-
-		/* Check the .eh_frame section for unwinding info */
-		ret = elf_section_address_and_offset(fd, ".eh_frame_hdr",
-						     &dso__data(dso)->eh_frame_hdr_addr,
-						     &dso__data(dso)->eh_frame_hdr_offset);
-		dso__data(dso)->elf_base_addr = elf_base_address(fd);
-		dso__data_put_fd(dso);
-		if (ret || dso__data(dso)->eh_frame_hdr_offset == 0)
-			return -EINVAL;
-	}
-
-	maps__for_each_map(thread__maps(ui->thread), read_unwind_spec_eh_frame_maps_cb, &args);
-
-	args.base_addr -= dso__data(dso)->elf_base_addr;
-	/* Address of .eh_frame_hdr */
-	*segbase = args.base_addr + dso__data(dso)->eh_frame_hdr_addr;
-	ret = unwind_spec_ehframe(dso, ui->machine, dso__data(dso)->eh_frame_hdr_offset,
-				   table_data, fde_count);
-	if (ret)
-		return ret;
-	/* binary_search_table offset plus .eh_frame_hdr address */
-	*table_data += *segbase;
-	return 0;
-}
-
-#ifndef NO_LIBUNWIND_DEBUG_FRAME
-static int read_unwind_spec_debug_frame(struct dso *dso,
-					struct machine *machine, u64 *offset)
-{
-	int fd;
-	u64 ofs = dso__data(dso)->debug_frame_offset;
-
-	/* debug_frame can reside in:
-	 *  - dso
-	 *  - debug pointed by symsrc_filename
-	 *  - gnu_debuglink, which doesn't necessary
-	 *    has to be pointed by symsrc_filename
-	 */
-	if (ofs == 0) {
-		if (dso__data_get_fd(dso, machine, &fd)) {
-			ofs = elf_section_offset(fd, ".debug_frame");
-			dso__data_put_fd(dso);
-		}
-
-		if (ofs <= 0) {
-			fd = open(dso__symsrc_filename(dso), O_RDONLY);
-			if (fd >= 0) {
-				ofs = elf_section_offset(fd, ".debug_frame");
-				close(fd);
-			}
-		}
-
-		if (ofs <= 0) {
-			char *debuglink = malloc(PATH_MAX);
-			int ret = 0;
-
-			if (debuglink == NULL) {
-				pr_err("unwind: Can't read unwind spec debug frame.\n");
-				return -ENOMEM;
-			}
-
-			ret = dso__read_binary_type_filename(
-				dso, DSO_BINARY_TYPE__DEBUGLINK,
-				machine->root_dir, debuglink, PATH_MAX);
-			if (!ret) {
-				fd = open(debuglink, O_RDONLY);
-				if (fd >= 0) {
-					ofs = elf_section_offset(fd,
-							".debug_frame");
-					close(fd);
-				}
-			}
-			if (ofs > 0) {
-				if (dso__symsrc_filename(dso) != NULL) {
-					pr_warning(
-						"%s: overwrite symsrc(%s,%s)\n",
-							__func__,
-							dso__symsrc_filename(dso),
-							debuglink);
-					dso__free_symsrc_filename(dso);
-				}
-				dso__set_symsrc_filename(dso, debuglink);
-			} else {
-				free(debuglink);
-			}
-		}
-
-		dso__data(dso)->debug_frame_offset = ofs;
-	}
-
-	*offset = ofs;
-	if (*offset)
-		return 0;
-
-	return -EINVAL;
-}
-#endif
-
-static struct map *find_map(unw_word_t ip, struct unwind_info *ui)
-{
-	struct addr_location al;
-	struct map *ret;
-
-	addr_location__init(&al);
-	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
-	ret = map__get(al.map);
-	addr_location__exit(&al);
-	return ret;
-}
-
-static int
-find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
-	       int need_unwind_info, void *arg)
-{
-	struct unwind_info *ui = arg;
-	struct map *map;
-	struct dso *dso;
-	unw_dyn_info_t di;
-	u64 table_data, segbase, fde_count;
-	int ret = -EINVAL;
-
-	map = find_map(ip, ui);
-	if (!map)
-		return -EINVAL;
-
-	dso = map__dso(map);
-	if (!dso) {
-		map__put(map);
-		return -EINVAL;
-	}
-
-	pr_debug("unwind: find_proc_info dso %s\n", dso__name(dso));
-
-	/* Check the .eh_frame section for unwinding info */
-	if (!read_unwind_spec_eh_frame(dso, ui, &table_data, &segbase, &fde_count)) {
-		memset(&di, 0, sizeof(di));
-		di.format   = UNW_INFO_FORMAT_REMOTE_TABLE;
-		di.start_ip = map__start(map);
-		di.end_ip   = map__end(map);
-		di.u.rti.segbase    = segbase;
-		di.u.rti.table_data = table_data;
-		di.u.rti.table_len  = fde_count * sizeof(struct table_entry)
-				      / sizeof(unw_word_t);
-		ret = dwarf_search_unwind_table(as, ip, &di, pi,
-						need_unwind_info, arg);
-	}
-
-#ifndef NO_LIBUNWIND_DEBUG_FRAME
-	/* Check the .debug_frame section for unwinding info */
-	if (ret < 0 &&
-	    !read_unwind_spec_debug_frame(dso, ui->machine, &segbase)) {
-		int fd;
-		u64 start = map__start(map);
-		unw_word_t base = start;
-		const char *symfile;
-
-		if (dso__data_get_fd(dso, ui->machine, &fd)) {
-			if (elf_is_exec(fd, dso__name(dso)))
-				base = 0;
-			dso__data_put_fd(dso);
-		}
-
-		symfile = dso__symsrc_filename(dso) ?: dso__name(dso);
-
-		memset(&di, 0, sizeof(di));
-		if (dwarf_find_debug_frame(0, &di, ip, base, symfile, start, map__end(map)))
-			ret = dwarf_search_unwind_table(as, ip, &di, pi,
-							need_unwind_info, arg);
-	}
-#endif
-	map__put(map);
-	return ret;
-}
-
-static int access_fpreg(unw_addr_space_t __maybe_unused as,
-			unw_regnum_t __maybe_unused num,
-			unw_fpreg_t __maybe_unused *val,
-			int __maybe_unused __write,
-			void __maybe_unused *arg)
-{
-	pr_err("unwind: access_fpreg unsupported\n");
-	return -UNW_EINVAL;
-}
-
-static int get_dyn_info_list_addr(unw_addr_space_t __maybe_unused as,
-				  unw_word_t __maybe_unused *dil_addr,
-				  void __maybe_unused *arg)
-{
-	return -UNW_ENOINFO;
-}
-
-static int resume(unw_addr_space_t __maybe_unused as,
-		  unw_cursor_t __maybe_unused *cu,
-		  void __maybe_unused *arg)
-{
-	pr_err("unwind: resume unsupported\n");
-	return -UNW_EINVAL;
-}
-
-static int
-get_proc_name(unw_addr_space_t __maybe_unused as,
-	      unw_word_t __maybe_unused addr,
-		char __maybe_unused *bufp, size_t __maybe_unused buf_len,
-		unw_word_t __maybe_unused *offp, void __maybe_unused *arg)
-{
-	pr_err("unwind: get_proc_name unsupported\n");
-	return -UNW_EINVAL;
-}
-
-static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
-			  unw_word_t *data)
-{
-	struct map *map;
-	struct dso *dso;
-	ssize_t size;
-
-	map = find_map(addr, ui);
-	if (!map) {
-		pr_debug("unwind: no map for %lx\n", (unsigned long)addr);
-		return -1;
-	}
-
-	dso = map__dso(map);
-
-	if (!dso) {
-		map__put(map);
-		return -1;
-	}
-
-	size = dso__data_read_addr(dso, map, ui->machine,
-				   addr, (u8 *) data, sizeof(*data));
-	map__put(map);
-	return !(size == sizeof(*data));
-}
-
-static int access_mem(unw_addr_space_t __maybe_unused as,
-		      unw_word_t addr, unw_word_t *valp,
-		      int __write, void *arg)
-{
-	struct unwind_info *ui = arg;
-	struct stack_dump *stack = &ui->sample->user_stack;
-	u64 start, end;
-	int offset;
-	int ret;
-
-	/* Don't support write, probably not needed. */
-	if (__write || !stack || !ui->sample->user_regs || !ui->sample->user_regs->regs) {
-		*valp = 0;
-		return 0;
-	}
-
-	ret = perf_reg_value(&start, perf_sample__user_regs(ui->sample),
-			     perf_arch_reg_sp(ui->e_machine));
-	if (ret)
-		return ret;
-
-	end = start + stack->size;
-
-	/* Check overflow. */
-	if (addr + sizeof(unw_word_t) < addr)
-		return -EINVAL;
-
-	if (addr < start || addr + sizeof(unw_word_t) >= end) {
-		ret = access_dso_mem(ui, addr, valp);
-		if (ret) {
-			pr_debug("unwind: access_mem %p not inside range"
-				 " 0x%" PRIx64 "-0x%" PRIx64 "\n",
-				 (void *) (uintptr_t) addr, start, end);
-			*valp = 0;
-			return ret;
-		}
-		return 0;
-	}
-
-	offset = addr - start;
-	*valp  = *(unw_word_t *)&stack->data[offset];
-	pr_debug("unwind: access_mem addr %p val %lx, offset %d\n",
-		 (void *) (uintptr_t) addr, (unsigned long)*valp, offset);
-	return 0;
-}
-
-static int access_reg(unw_addr_space_t __maybe_unused as,
-		      unw_regnum_t regnum, unw_word_t *valp,
-		      int __write, void *arg)
-{
-	struct unwind_info *ui = arg;
-	int id, ret;
-	u64 val;
-
-	/* Don't support write, I suspect we don't need it. */
-	if (__write) {
-		pr_err("unwind: access_reg w %d\n", regnum);
-		return 0;
-	}
-
-	if (!ui->sample->user_regs || !ui->sample->user_regs->regs) {
-		*valp = 0;
-		return 0;
-	}
-
-	id = get_perf_regnum_for_unw_regnum(ui->e_machine, regnum);
-	if (id < 0)
-		return -EINVAL;
-
-	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample), id);
-	if (ret) {
-		if (!ui->best_effort)
-			pr_err("unwind: can't read reg %d\n", regnum);
-		return ret;
-	}
-
-	*valp = (unw_word_t) val;
-	pr_debug("unwind: reg %d, val %lx\n", regnum, (unsigned long)*valp);
-	return 0;
-}
-
-static void put_unwind_info(unw_addr_space_t __maybe_unused as,
-			    unw_proc_info_t *pi __maybe_unused,
-			    void *arg __maybe_unused)
-{
-	pr_debug("unwind: put_unwind_info called\n");
-}
-
-static int entry(u64 ip, struct thread *thread,
-		 unwind_entry_cb_t cb, void *arg)
-{
-	struct unwind_entry e;
-	struct addr_location al;
-	int ret;
-
-	addr_location__init(&al);
-	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
-	e.ip     = ip;
-	e.ms.map = al.map;
-	e.ms.thread = thread__get(al.thread);
-
-	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
-		 al.sym ? al.sym->name : "''",
-		 ip,
-		 al.map ? map__map_ip(al.map, ip) : (u64) 0);
-
-	ret = cb(&e, arg);
-	addr_location__exit(&al);
-	return ret;
-}
-
-static void display_error(int err)
-{
-	switch (err) {
-	case UNW_EINVAL:
-		pr_err("unwind: Only supports local.\n");
-		break;
-	case UNW_EUNSPEC:
-		pr_err("unwind: Unspecified error.\n");
-		break;
-	case UNW_EBADREG:
-		pr_err("unwind: Register unavailable.\n");
-		break;
-	default:
-		break;
-	}
-}
-
-static unw_accessors_t accessors = {
-	.find_proc_info		= find_proc_info,
-	.put_unwind_info	= put_unwind_info,
-	.get_dyn_info_list_addr	= get_dyn_info_list_addr,
-	.access_mem		= access_mem,
-	.access_reg		= access_reg,
-	.access_fpreg		= access_fpreg,
-	.resume			= resume,
-	.get_proc_name		= get_proc_name,
-};
-
-static int _unwind__prepare_access(struct maps *maps)
-{
-	void *addr_space = unw_create_addr_space(&accessors, 0);
-
-	maps__set_addr_space(maps, addr_space);
-	if (!addr_space) {
-		pr_err("unwind: Can't create unwind address space.\n");
-		return -ENOMEM;
-	}
-
-	unw_set_caching_policy(addr_space, UNW_CACHE_GLOBAL);
-	return 0;
-}
-
-static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
-		       void *arg, int max_stack)
-{
-	u64 val;
-	unw_word_t ips[max_stack];
-	unw_addr_space_t addr_space;
-	unw_cursor_t c;
-	int ret, i = 0;
-
-	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample),
-			     perf_arch_reg_ip(ui->e_machine));
-	if (ret)
-		return ret;
-
-	ips[i++] = (unw_word_t) val;
-
-	/*
-	 * If we need more than one entry, do the DWARF
-	 * unwind itself.
-	 */
-	if (max_stack - 1 > 0) {
-		WARN_ONCE(!ui->thread, "WARNING: ui->thread is NULL");
-		addr_space = maps__addr_space(thread__maps(ui->thread));
-
-		if (addr_space == NULL)
-			return -1;
-
-		ret = unw_init_remote(&c, addr_space, ui);
-		if (ret && !ui->best_effort)
-			display_error(ret);
-
-		while (!ret && (unw_step(&c) > 0) && i < max_stack) {
-			unw_get_reg(&c, UNW_REG_IP, &ips[i]);
-
-			/*
-			 * Decrement the IP for any non-activation frames.
-			 * this is required to properly find the srcline
-			 * for caller frames.
-			 * See also the documentation for dwfl_frame_pc(),
-			 * which this code tries to replicate.
-			 */
-			if (unw_is_signal_frame(&c) <= 0)
-				--ips[i];
-
-			++i;
-		}
-
-		max_stack = i;
-	}
-
-	/*
-	 * Display what we got based on the order setup.
-	 */
-	for (i = 0; i < max_stack && !ret; i++) {
-		int j = i;
-
-		if (callchain_param.order == ORDER_CALLER)
-			j = max_stack - i - 1;
-		ret = ips[j] ? entry(ips[j], ui->thread, cb, arg) : 0;
-	}
-
-	return ret;
-}
-
-static int _unwind__get_entries(unwind_entry_cb_t cb, void *arg,
-			struct thread *thread,
-			struct perf_sample *data, int max_stack,
-			bool best_effort)
-{
-	struct unwind_info ui = {
-		.sample       = data,
-		.thread       = thread,
-		.machine      = maps__machine(thread__maps(thread)),
-		.e_machine    = thread__e_machine(thread, /*machine=*/NULL, /*e_flags=*/NULL),
-		.best_effort  = best_effort
-	};
-
-	if (!data->user_regs || !data->user_regs->regs)
-		return -EINVAL;
-
-	if (max_stack <= 0)
-		return -EINVAL;
-
-	return get_entries(&ui, cb, arg, max_stack);
-}
-
-static struct unwind_libunwind_ops
-_unwind_libunwind_ops = {
-	.prepare_access = _unwind__prepare_access,
-	.get_entries    = _unwind__get_entries,
-};
-
-#ifndef REMOTE_UNWIND_LIBUNWIND
-struct unwind_libunwind_ops *
-local_unwind_libunwind_ops = &_unwind_libunwind_ops;
-#endif
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index eaee7b78d87c..66e7b7a26aad 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -1,23 +1,557 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "unwind.h"
+#include "callchain.h"
+#include "debug.h"
 #include "dso.h"
+#include "env.h"
 #include "map.h"
-#include "thread.h"
+#include "perf_regs.h"
 #include "session.h"
-#include "debug.h"
-#include "env.h"
-#include "callchain.h"
+#include "symbol.h"
+#include "thread.h"
+#include "unwind.h"
 #include "libunwind-arch/libunwind-arch.h"
 #include <dwarf-regs.h>
 #include <elf.h>
+#include <fcntl.h>
+#include <gelf.h>
+#include <inttypes.h>
+
+#define DW_EH_PE_FORMAT_MASK	0x0f	/* format of the encoded value */
+#define DW_EH_PE_APPL_MASK	0x70	/* how the value is to be applied */
+
+/* Pointer-encoding formats: */
+#define DW_EH_PE_omit		0xff
+#define DW_EH_PE_ptr		0x00	/* pointer-sized unsigned value */
+#define DW_EH_PE_udata4		0x03	/* unsigned 32-bit value */
+#define DW_EH_PE_udata8		0x04	/* unsigned 64-bit value */
+#define DW_EH_PE_sdata4		0x0b	/* signed 32-bit value */
+#define DW_EH_PE_sdata8		0x0c	/* signed 64-bit value */
+
+/* Pointer-encoding application: */
+#define DW_EH_PE_absptr		0x00	/* absolute value */
+#define DW_EH_PE_pcrel		0x10	/* rel. to addr. of encoded value */
+
+/*
+ * The following are not documented by LSB v1.3, yet they are used by
+ * GCC, presumably they aren't documented by LSB since they aren't
+ * used on Linux:
+ */
+#define DW_EH_PE_funcrel	0x40	/* start-of-procedure-relative */
+#define DW_EH_PE_aligned	0x50	/* aligned pointer */
+
+/* Flags intentionally not handled, since they're not needed:
+ * #define DW_EH_PE_indirect      0x80
+ * #define DW_EH_PE_uleb128       0x01
+ * #define DW_EH_PE_udata2        0x02
+ * #define DW_EH_PE_sleb128       0x09
+ * #define DW_EH_PE_sdata2        0x0a
+ * #define DW_EH_PE_textrel       0x20
+ * #define DW_EH_PE_datarel       0x30
+ */
+
+#define dw_read(ptr, type, end) ({	\
+	type *__p = (type *) ptr;	\
+	type  __v;			\
+	if ((__p + 1) > (type *) end)	\
+		return -EINVAL;		\
+	__v = *__p++;			\
+	ptr = (typeof(ptr)) __p;	\
+	__v;				\
+	})
+
+static int __dw_read_encoded_value(u8 **p, u8 *end, u64 *val,
+				   u8 encoding)
+{
+	u8 *cur = *p;
+	*val = 0;
+
+	switch (encoding) {
+	case DW_EH_PE_omit:
+		*val = 0;
+		goto out;
+	case DW_EH_PE_ptr:
+		*val = dw_read(cur, unsigned long, end);
+		goto out;
+	default:
+		break;
+	}
+
+	switch (encoding & DW_EH_PE_APPL_MASK) {
+	case DW_EH_PE_absptr:
+		break;
+	case DW_EH_PE_pcrel:
+		*val = (unsigned long) cur;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if ((encoding & 0x07) == 0x00)
+		encoding |= DW_EH_PE_udata4;
+
+	switch (encoding & DW_EH_PE_FORMAT_MASK) {
+	case DW_EH_PE_sdata4:
+		*val += dw_read(cur, s32, end);
+		break;
+	case DW_EH_PE_udata4:
+		*val += dw_read(cur, u32, end);
+		break;
+	case DW_EH_PE_sdata8:
+		*val += dw_read(cur, s64, end);
+		break;
+	case DW_EH_PE_udata8:
+		*val += dw_read(cur, u64, end);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+ out:
+	*p = cur;
+	return 0;
+}
+
+#define dw_read_encoded_value(ptr, end, enc) ({			\
+	u64 __v;						\
+	if (__dw_read_encoded_value(&ptr, end, &__v, enc)) {	\
+		return -EINVAL;                                 \
+	}                                                       \
+	__v;                                                    \
+	})
+
+static u64 elf_base_address(int fd)
+{
+	Elf *elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
+	GElf_Phdr phdr;
+	u64 retval = 0;
+	size_t i, phdrnum = 0;
+
+	if (elf == NULL)
+		return 0;
+	(void)elf_getphdrnum(elf, &phdrnum);
+	/* PT_LOAD segments are sorted by p_vaddr, so the first has the minimum p_vaddr. */
+	for (i = 0; i < phdrnum; i++) {
+		if (gelf_getphdr(elf, i, &phdr) && phdr.p_type == PT_LOAD) {
+			retval = phdr.p_vaddr & -getpagesize();
+			break;
+		}
+	}
+
+	elf_end(elf);
+	return retval;
+}
+
+static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
+			       u64 offset, u64 *table_data_offset, u64 *fde_count)
+{
+	struct eh_frame_hdr {
+		unsigned char version;
+		unsigned char eh_frame_ptr_enc;
+		unsigned char fde_count_enc;
+		unsigned char table_enc;
+
+		/*
+		 * The rest of the header is variable-length and consists of the
+		 * following members:
+		 *
+		 *	encoded_t eh_frame_ptr;
+		 *	encoded_t fde_count;
+		 */
+
+		/* A single encoded pointer should not be more than 8 bytes. */
+		u64 enc[2];
+
+		/*
+		 * struct {
+		 *    encoded_t start_ip;
+		 *    encoded_t fde_addr;
+		 * } binary_search_table[fde_count];
+		 */
+		char data[];
+	} __packed hdr;
+	u8 *enc = (u8 *) &hdr.enc;
+	u8 *end = (u8 *) &hdr.data;
+	ssize_t r;
+
+	r = dso__data_read_offset(dso, machine, offset, (u8 *) &hdr, sizeof(hdr));
+	if (r != sizeof(hdr))
+		return -EINVAL;
+
+	/* We dont need eh_frame_ptr, just skip it. */
+	dw_read_encoded_value(enc, end, hdr.eh_frame_ptr_enc);
+
+	*fde_count  = dw_read_encoded_value(enc, end, hdr.fde_count_enc);
+	*table_data_offset = enc - (u8 *) &hdr;
+	return 0;
+}
+
+struct read_unwind_spec_eh_frame_maps_cb_args {
+	struct dso *dso;
+	u64 base_addr;
+};
+
+static int read_unwind_spec_eh_frame_maps_cb(struct map *map, void *data)
+{
+
+	struct read_unwind_spec_eh_frame_maps_cb_args *args = data;
+
+	if (map__dso(map) == args->dso && map__start(map) - map__pgoff(map) < args->base_addr)
+		args->base_addr = map__start(map) - map__pgoff(map);
+
+	return 0;
+}
+
+static int elf_section_address_and_offset(int fd, const char *name, u64 *address, u64 *offset)
+{
+	Elf *elf;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	int ret = -1;
+
+	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
+	if (elf == NULL)
+		return -1;
 
-struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
-struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
-struct unwind_libunwind_ops __weak *arm64_unwind_libunwind_ops;
+	if (gelf_getehdr(elf, &ehdr) == NULL)
+		goto out_err;
+
+	if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
+		goto out_err;
+
+	*address = shdr.sh_addr;
+	*offset = shdr.sh_offset;
+	ret = 0;
+out_err:
+	elf_end(elf);
+	return ret;
+}
+
+static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
+				     u64 *table_data, u64 *segbase,
+				     u64 *fde_count)
+{
+	struct read_unwind_spec_eh_frame_maps_cb_args args = {
+		.dso = dso,
+		.base_addr = UINT64_MAX,
+	};
+	int ret, fd;
+
+	if (dso__data(dso)->eh_frame_hdr_offset == 0) {
+		if (!dso__data_get_fd(dso, ui->machine, &fd))
+			return -EINVAL;
+
+		/* Check the .eh_frame section for unwinding info */
+		ret = elf_section_address_and_offset(fd, ".eh_frame_hdr",
+						     &dso__data(dso)->eh_frame_hdr_addr,
+						     &dso__data(dso)->eh_frame_hdr_offset);
+		dso__data(dso)->elf_base_addr = elf_base_address(fd);
+		dso__data_put_fd(dso);
+		if (ret || dso__data(dso)->eh_frame_hdr_offset == 0)
+			return -EINVAL;
+	}
+
+	maps__for_each_map(thread__maps(ui->thread), read_unwind_spec_eh_frame_maps_cb, &args);
+
+	args.base_addr -= dso__data(dso)->elf_base_addr;
+	/* Address of .eh_frame_hdr */
+	*segbase = args.base_addr + dso__data(dso)->eh_frame_hdr_addr;
+	ret = unwind_spec_ehframe(dso, ui->machine, dso__data(dso)->eh_frame_hdr_offset,
+				   table_data, fde_count);
+	if (ret)
+		return ret;
+	/* binary_search_table offset plus .eh_frame_hdr address */
+	*table_data += *segbase;
+	return 0;
+}
+
+static u64 elf_section_offset(int fd, const char *name)
+{
+	u64 address, offset = 0;
+
+	if (elf_section_address_and_offset(fd, name, &address, &offset))
+		return 0;
+
+	return offset;
+}
+
+static int read_unwind_spec_debug_frame(struct dso *dso,
+					struct machine *machine, u64 *offset)
+{
+	int fd;
+	u64 ofs = dso__data(dso)->debug_frame_offset;
+
+	/* debug_frame can reside in:
+	 *  - dso
+	 *  - debug pointed by symsrc_filename
+	 *  - gnu_debuglink, which doesn't necessary
+	 *    has to be pointed by symsrc_filename
+	 */
+	if (ofs == 0) {
+		if (dso__data_get_fd(dso, machine, &fd)) {
+			ofs = elf_section_offset(fd, ".debug_frame");
+			dso__data_put_fd(dso);
+		}
+
+		if (ofs <= 0) {
+			fd = open(dso__symsrc_filename(dso), O_RDONLY);
+			if (fd >= 0) {
+				ofs = elf_section_offset(fd, ".debug_frame");
+				close(fd);
+			}
+		}
+
+		if (ofs <= 0) {
+			char *debuglink = malloc(PATH_MAX);
+			int ret = 0;
+
+			if (debuglink == NULL) {
+				pr_err("unwind: Can't read unwind spec debug frame.\n");
+				return -ENOMEM;
+			}
+
+			ret = dso__read_binary_type_filename(
+				dso, DSO_BINARY_TYPE__DEBUGLINK,
+				machine->root_dir, debuglink, PATH_MAX);
+			if (!ret) {
+				fd = open(debuglink, O_RDONLY);
+				if (fd >= 0) {
+					ofs = elf_section_offset(fd,
+							".debug_frame");
+					close(fd);
+				}
+			}
+			if (ofs > 0) {
+				if (dso__symsrc_filename(dso) != NULL) {
+					pr_warning(
+						"%s: overwrite symsrc(%s,%s)\n",
+							__func__,
+							dso__symsrc_filename(dso),
+							debuglink);
+					dso__free_symsrc_filename(dso);
+				}
+				dso__set_symsrc_filename(dso, debuglink);
+			} else {
+				free(debuglink);
+			}
+		}
+
+		dso__data(dso)->debug_frame_offset = ofs;
+	}
+
+	*offset = ofs;
+	if (*offset)
+		return 0;
+
+	return -EINVAL;
+}
+
+static struct map *find_map(uint64_t ip, struct unwind_info *ui)
+{
+	struct addr_location al;
+	struct map *ret;
+
+	addr_location__init(&al);
+	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	ret = map__get(al.map);
+	addr_location__exit(&al);
+	return ret;
+}
+
+static int elf_is_exec(int fd, const char *name)
+{
+	Elf *elf;
+	GElf_Ehdr ehdr;
+	int retval = 0;
+
+	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
+	if (elf == NULL)
+		return 0;
+	if (gelf_getehdr(elf, &ehdr) == NULL)
+		goto out;
+
+	retval = (ehdr.e_type == ET_EXEC);
+
+out:
+	elf_end(elf);
+	pr_debug3("unwind: elf_is_exec(%s): %d\n", name, retval);
+	return retval;
+}
+
+int __libunwind__find_proc_info(void *as, uint64_t ip, void *pi, int need_unwind_info, void *arg)
+{
+	struct unwind_info *ui = arg;
+	struct map *map;
+	struct dso *dso;
+	u64 table_data, segbase, fde_count;
+	int ret = -EINVAL;
+
+	map = find_map(ip, ui);
+	if (!map)
+		return -EINVAL;
+
+	dso = map__dso(map);
+	if (!dso) {
+		map__put(map);
+		return -EINVAL;
+	}
+
+	pr_debug3("unwind: find_proc_info dso %s\n", dso__name(dso));
+
+	/* Check the .eh_frame section for unwinding info */
+	if (!read_unwind_spec_eh_frame(dso, ui, &table_data, &segbase, &fde_count)) {
+		struct table_entry {
+			u32 start_ip_offset;
+			u32 fde_offset;
+		};
+		struct libarch_unwind__dyn_info di = {
+			.start_ip = map__start(map),
+			.end_ip   = map__end(map),
+			.segbase    = segbase,
+			.table_data = table_data,
+			.table_len  = fde_count * sizeof(struct table_entry) / ui->unw_word_t_size,
+		};
+
+		ret = libunwind_arch__dwarf_search_unwind_table(ui->e_machine, as, ip, &di, pi,
+								need_unwind_info, arg);
+	}
+
+	/* Check the .debug_frame section for unwinding info */
+	if (ret < 0 && !read_unwind_spec_debug_frame(dso, ui->machine, &segbase)) {
+		int fd;
+		u64 start = map__start(map);
+		u64 base = start;
+		const char *symfile;
+		struct libarch_unwind__dyn_info di = {};
+
+		if (dso__data_get_fd(dso, ui->machine, &fd)) {
+			if (elf_is_exec(fd, dso__name(dso)))
+				base = 0;
+			dso__data_put_fd(dso);
+		}
+
+		symfile = dso__symsrc_filename(dso) ?: dso__name(dso);
+
+		if (libunwind_arch__dwarf_find_debug_frame(ui->e_machine, /*found=*/0, &di, ip,
+							   base, symfile, start, map__end(map))) {
+			ret = libunwind_arch__dwarf_search_unwind_table(ui->e_machine, as, ip, &di, pi,
+									need_unwind_info, arg);
+		}
+	}
+	map__put(map);
+	return ret;
+}
+
+static int access_dso_mem(struct unwind_info *ui, uint64_t addr, void *data_word)
+{
+	struct map *map;
+	struct dso *dso;
+	ssize_t size;
+
+	map = find_map(addr, ui);
+	if (!map) {
+		pr_debug("unwind: no map for %lx\n", (unsigned long)addr);
+		return -1;
+	}
+
+	dso = map__dso(map);
+
+	if (!dso) {
+		map__put(map);
+		return -1;
+	}
+
+	size = dso__data_read_addr(dso, map, ui->machine,
+				   addr,
+				   (u8 *) data_word,
+				   ui->unw_word_t_size);
+	map__put(map);
+	return !((size_t)size == ui->unw_word_t_size);
+}
+
+int __libunwind__access_mem(void *as __maybe_unused, uint64_t addr, void *valp_word,
+			    int __write, void *arg)
+{
+	struct unwind_info *ui = arg;
+	struct stack_dump *stack = &ui->sample->user_stack;
+	u64 start, end;
+	int offset;
+	int ret;
+
+	/* Don't support write, probably not needed. */
+	if (__write || !stack || !ui->sample->user_regs || !ui->sample->user_regs->regs) {
+		uint64_t zero = 0;
+
+		memcpy(valp_word, &zero, ui->unw_word_t_size);
+		return 0;
+	}
+
+	ret = perf_reg_value(&start, perf_sample__user_regs(ui->sample),
+			     perf_arch_reg_sp(ui->e_machine));
+	if (ret)
+		return ret;
+
+	end = start + stack->size;
+
+	/* Check overflow. */
+	if (addr + ui->unw_word_t_size < addr)
+		return -EINVAL;
+
+	if (addr < start || addr + ui->unw_word_t_size >= end) {
+		ret = access_dso_mem(ui, addr, valp_word);
+		if (ret) {
+			pr_debug3("unwind: access_mem %p not inside range"
+				  " 0x%" PRIx64 "-0x%" PRIx64 "\n",
+				  (void *) (uintptr_t) addr, start, end);
+			memset(valp_word, 0, ui->unw_word_t_size);
+			return ret;
+		}
+		return 0;
+	}
+
+	offset = addr - start;
+	memcpy(valp_word, &stack->data[offset], ui->unw_word_t_size);
+	pr_debug3("unwind: access_mem addr %p val %lx, offset %d\n",
+		  (void *) (uintptr_t) addr, *((unsigned long *)valp_word), offset);
+	return 0;
+}
+
+int __libunwind__access_reg(void *as __maybe_unused, int regnum, void *valp_word, int __write,
+			    void *arg)
+{
+	struct unwind_info *ui = arg;
+	int id, ret;
+	u64 val;
+
+	/* Don't support write, I suspect we don't need it. */
+	if (__write) {
+		pr_err("unwind: access_reg w %d\n", regnum);
+		return 0;
+	}
+
+	if (!ui->sample->user_regs || !ui->sample->user_regs->regs) {
+		memset(valp_word, 0, ui->unw_word_t_size);
+		return 0;
+	}
+
+	id = get_perf_regnum_for_unw_regnum(ui->e_machine, regnum);
+	if (id < 0)
+		return -EINVAL;
+
+	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample), id);
+	if (ret) {
+		if (!ui->best_effort)
+			pr_err("unwind: can't read reg %d\n", regnum);
+		return ret;
+	}
+
+	memcpy(valp_word, &val, ui->unw_word_t_size);
+	pr_debug3("unwind: reg %d, val %lx\n", regnum, val);
+	return 0;
+}
 
 int unwind__prepare_access(struct maps *maps, uint16_t e_machine)
 {
-	struct unwind_libunwind_ops *ops = local_unwind_libunwind_ops;
+	void *addr_space;
 
 	if (!dwarf_callchain_users)
 		return 0;
@@ -27,25 +561,16 @@ int unwind__prepare_access(struct maps *maps, uint16_t e_machine)
 		return 0;
 	}
 
-	if (e_machine != EM_HOST) {
-		/* If not live/local mode. */
-		switch (e_machine) {
-		case EM_386:
-			ops = x86_32_unwind_libunwind_ops;
-			break;
-		case EM_AARCH64:
-			ops = arm64_unwind_libunwind_ops;
-			break;
-		default:
-			pr_warning_once("unwind: ELF machine type %d is not supported\n",
-					e_machine);
-		return 0;
-		}
-	}
-	maps__set_unwind_libunwind_ops(maps, ops);
 	maps__set_e_machine(maps, e_machine);
+	addr_space = libunwind_arch__create_addr_space(e_machine);
+
+	maps__set_addr_space(maps, addr_space);
+	if (!addr_space) {
+		pr_err("unwind: Can't create unwind address space.\n");
+		return -ENOMEM;
+	}
 
-	return maps__unwind_libunwind_ops(maps)->prepare_access(maps);
+	return 0;
 }
 
 void unwind__flush_access(struct maps *maps)
@@ -58,14 +583,81 @@ void unwind__finish_access(struct maps *maps)
 	libunwind_arch__finish_access(maps);
 }
 
+static int entry(uint64_t ip, struct thread *thread, unwind_entry_cb_t cb, void *arg)
+{
+	struct unwind_entry e;
+	struct addr_location al;
+	int ret;
+
+	addr_location__init(&al);
+	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
+	e.ip     = ip;
+	e.ms.map = al.map;
+	e.ms.thread = thread__get(al.thread);
+
+	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
+		 al.sym ? al.sym->name : "''",
+		 ip,
+		 al.map ? map__map_ip(al.map, ip) : (u64) 0);
+
+	ret = cb(&e, arg);
+	addr_location__exit(&al);
+	return ret;
+}
+
 int libunwind__get_entries(unwind_entry_cb_t cb, void *arg,
 			 struct thread *thread,
-			 struct perf_sample *data, int max_stack,
+			 struct perf_sample *sample, int max_stack,
 			 bool best_effort)
 {
-	const struct unwind_libunwind_ops *ops = maps__unwind_libunwind_ops(thread__maps(thread));
+	struct unwind_info *ui;
+	uint64_t first_ip;
+	int ret, i = 0;
+	uint16_t e_machine;
 
-	if (ops)
-		return ops->get_entries(cb, arg, thread, data, max_stack, best_effort);
-	return 0;
+	if (!sample->user_regs || !sample->user_regs->regs)
+		return -EINVAL;
+
+	if (max_stack <= 0)
+		return -EINVAL;
+
+	if (!thread) {
+		pr_warning_once("WARNING: thread is NULL");
+		return -EINVAL;
+	}
+
+	e_machine = thread__e_machine(thread, /*machine=*/NULL, /*e_flags=*/NULL);
+	ret = perf_reg_value(&first_ip, perf_sample__user_regs(sample),
+			     perf_arch_reg_ip(e_machine));
+	if (ret)
+		return ret;
+
+	if (max_stack == 1) {
+		/* Special case for a single entry. */
+		return entry(first_ip, thread, cb, arg);
+	}
+
+	ui = libunwind_arch_unwind_info__new(thread, sample, max_stack, best_effort, e_machine, first_ip);
+	if (!ui)
+		return -1;
+
+	do {
+		ret = libunwind_arch__unwind_step(ui);
+		if (ret < 0)
+			goto out;
+
+	} while (ret);
+
+	/*
+	 * Display what we got based on the order setup.
+	 */
+	for (i = 0; i < ui->cur_ip; i++) {
+		int j = callchain_param.order == ORDER_CALLEE ? i : ui->cur_ip - i - 1;
+
+		if (ui->ips[j])
+			ret = entry(ui->ips[j], thread, cb, arg);
+	}
+out:
+	libunwind_arch_unwind_info__delete(ui);
+	return ret;
 }
diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index ad610c5a241c..47ce12408c66 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -19,13 +19,6 @@ struct unwind_entry {
 
 typedef int (*unwind_entry_cb_t)(struct unwind_entry *entry, void *arg);
 
-struct unwind_libunwind_ops {
-	int (*prepare_access)(struct maps *maps);
-	int (*get_entries)(unwind_entry_cb_t cb, void *arg,
-			   struct thread *thread,
-			   struct perf_sample *data, int max_stack, bool best_effort);
-};
-
 int unwind__configure(const char *var, const char *value, void *cb);
 int unwind__option(const struct option *opt, const char *arg, int unset);
 
-- 
2.53.0.1213.gd9a14994de-goog

