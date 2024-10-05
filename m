Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48CC165EEF
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158165; cv=none; b=sZlSS+k2s3HoVNBArAvQE0++HoHFkxjoYqAUoh4XamMbJH4ir8L9YMFZBkaESYBlLJEf3zJ9cVP2wFykFtfYADrj6k4DLUgWR6acBhFg/wMJb7dDbJyph4HnWdiDWp0nuXbR8D1QEStnP8elW1RfHuk2c77kwYHVKzhwF7uspgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158165; c=relaxed/simple;
	bh=FpDVYgI9IrJgwdqYzij6DFpKW/36XS8ZvFd3RBLOWt0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SO3+/T4jQ9pp37F2lI3FIrbI8JoG2nx9KfN3NNp29f4V6Y01p9RhfSqcUIVQH+ped218Zp+iRIqGb7kxvbpYCSN/uPM/59yg27jkNfSCI1qp3pcJDu8d831NfgOAc0/+E/A2t9qx8g5XE4XvGN4GCXhR/lfYvE6bACQN2MmjX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GAU8lAiV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAU8lAiV"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2e5e376fcso4437657b3.2
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158163; x=1728762963; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LMYv3+WdvZc4gaJkJ+8/1ILPLPMhWUj3Y+GZomvDIY=;
        b=GAU8lAiVCq/qhldYnDTpnz6nMF9utYzHURAfYfxwagQOvGHlZQyYfecg9CJ/7x6t9c
         Qd4fk8pMFILSULSWCitjOowBmamvmlhW8upC3oyyylwN8rpuKSxBqxVfE7scNEYcjT28
         dNYFFHxynkxokbbhP+ooc2Qhf5+0nl4oGfw7JPvPQiL4gpAq3PrXuxqicpBR1optuLv2
         +GbhrtXsEeuY9uqn9VoKSjO9wN85Ljsrj321TI4GeEGNs5rc1DbfLlmhg9LXVLlBxLwc
         ZiryYXZ3bd3Ac5/aQvkrQORHHAoNAtK/eHhoAfJ6z8IsK8MQ1Gi7GrHpE9WzKj1woWvQ
         9nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158163; x=1728762963;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LMYv3+WdvZc4gaJkJ+8/1ILPLPMhWUj3Y+GZomvDIY=;
        b=rnSqyOIDuTBbaQEMK39Hs8OCKtoY8XCUyitDm9IWRkRMgCAW1diOscvpBoCq/Y6Lpu
         Wtc8++d+NS+7ZFBt1FZEkzpxcTqdG0Zx4U8qB909aUPilo7btH8cwzHsMZrXHa8TgsQN
         Uo4xJpRgevx/pXAhyyKrJg4KXJwCNVecjTQH52l8xzLZMIoheMAVE5Q+Qx5Y/+s0cS+8
         J5RYU4qo5garThnksFzS7islrsXPOEmS3COtcgI+qWznalO/MFPiyO8M1ugRHbdHUQh5
         YoxIO0UfjJQc9aWerqFIUsT5ODei/gfyB2TKvyWHnxZnIkD8QZz0byM9whJbbl+rSuTl
         AR3A==
X-Forwarded-Encrypted: i=1; AJvYcCVXcWTPOfY6aLS4n9RFc7OT5ajS0fGqAAA8naLLnxjZPTDxAbMpthWGLmiOxz8qIDcTOAqJMeij8y8Y5u+9w+qA@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8kFtSJUDjbUM3mqDYUqZXKPgvJYptpYK+xJAQReSwpGeVMVC
	bXe616DBlueT82yskBoHtJ41aCUDK2U1FgWACXszhZhzhq2qDKE7Z4zCX/sqme41wPBAi7jxUpH
	+5rV67g==
X-Google-Smtp-Source: AGHT+IGQHKIO34wQCQbrD8UvzGXo3ZMOZtjT5rfqvG6YFvrAHuL8IEFzPTbx87DWPLMqG36F8DvjEKtUPK2U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b8e:b0:6dd:d138:d823 with SMTP
 id 00721157ae682-6e2c72adbdamr920707b3.8.1728158162987; Sat, 05 Oct 2024
 12:56:02 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:12 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 02/31] perf build: Rename NO_DWARF to NO_LIBDW
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

NO_DWARF could mean more than NO_LIBDW support, in particular no
libunwind support. Rename to be more intention revealing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config         | 16 ++++++++--------
 tools/perf/Makefile.perf           |  2 +-
 tools/perf/arch/arm/Makefile       |  2 +-
 tools/perf/arch/arm64/Makefile     |  2 +-
 tools/perf/arch/csky/Makefile      |  2 +-
 tools/perf/arch/loongarch/Makefile |  2 +-
 tools/perf/arch/mips/Makefile      |  2 +-
 tools/perf/arch/powerpc/Makefile   |  2 +-
 tools/perf/arch/riscv/Makefile     |  2 +-
 tools/perf/arch/s390/Makefile      |  2 +-
 tools/perf/arch/sh/Makefile        |  2 +-
 tools/perf/arch/sparc/Makefile     |  2 +-
 tools/perf/arch/x86/Makefile       |  2 +-
 tools/perf/arch/xtensa/Makefile    |  2 +-
 tools/perf/builtin-probe.c         |  2 +-
 15 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5e26d3a91b36..55a39211496d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -429,7 +429,7 @@ ifeq ($(feature-file-handle), 1)
 endif
 
 ifdef NO_LIBELF
-  NO_DWARF := 1
+  NO_LIBDW := 1
   NO_LIBUNWIND := 1
   NO_LIBDW_DWARF_UNWIND := 1
   NO_LIBBPF := 1
@@ -471,9 +471,9 @@ else
       endif
     endif
     ifneq ($(feature-dwarf), 1)
-      ifndef NO_DWARF
+      ifndef NO_LIBDW
         $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
-        NO_DWARF := 1
+        NO_LIBDW := 1
       endif
     else
       ifneq ($(feature-dwarf_getlocations), 1)
@@ -496,7 +496,7 @@ ifeq ($(feature-libaio), 1)
   endif
 endif
 
-ifdef NO_DWARF
+ifdef NO_LIBDW
   NO_LIBDW_DWARF_UNWIND := 1
 endif
 
@@ -574,17 +574,17 @@ ifndef NO_LIBELF
     endif
   endif
 
-  ifndef NO_DWARF
+  ifndef NO_LIBDW
     ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
       $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
-      NO_DWARF := 1
+      NO_LIBDW := 1
     else
       CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
       LDFLAGS += $(LIBDW_LDFLAGS)
       EXTLIBS += ${DWARFLIBS}
       $(call detected,CONFIG_DWARF)
     endif # PERF_HAVE_DWARF_REGS
-  endif # NO_DWARF
+  endif # NO_LIBDW
 
   ifndef NO_LIBBPF
     ifeq ($(feature-bpf), 1)
@@ -633,7 +633,7 @@ ifdef PERF_HAVE_JITDUMP
 endif
 
 ifeq ($(SRCARCH),powerpc)
-  ifndef NO_DWARF
+  ifndef NO_LIBDW
     CFLAGS += -DHAVE_SKIP_CALLCHAIN_IDX
   endif
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9dd2e8d3f3c9..a144bfaf8aeb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -40,7 +40,7 @@ include ../scripts/utilities.mak
 #
 # Define EXTRA_PERFLIBS to pass extra libraries to PERFLIBS.
 #
-# Define NO_DWARF if you do not want debug-info analysis feature at all.
+# Define NO_LIBDW if you do not want debug-info analysis feature at all.
 #
 # Define WERROR=0 to disable treating any warnings as errors.
 #
diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefile
index 1d88fdab13bf..9b164d379548 100644
--- a/tools/perf/arch/arm/Makefile
+++ b/tools/perf/arch/arm/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 5735ed4479bb..8a5ffbfe809f 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makefile
index 88c08eed9c7b..119b06a64bed 100644
--- a/tools/perf/arch/csky/Makefile
+++ b/tools/perf/arch/csky/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index c89d6bb6b184..1cc5eb01f32b 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
index cd0b011b3be5..733f7b76f52d 100644
--- a/tools/perf/arch/mips/Makefile
+++ b/tools/perf/arch/mips/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index bf6d323574f6..7672d555f6cd 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 
diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index 90c3c476a242..4664a78a1afd 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -1,4 +1,4 @@
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 56994e63b43a..3f66e2ede3f7 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/sh/Makefile b/tools/perf/arch/sh/Makefile
index 88c08eed9c7b..119b06a64bed 100644
--- a/tools/perf/arch/sh/Makefile
+++ b/tools/perf/arch/sh/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
index 4031db72ba71..7741184894c8 100644
--- a/tools/perf/arch/sparc/Makefile
+++ b/tools/perf/arch/sparc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 67b4969a6738..9aa58acb5564 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/xtensa/Makefile b/tools/perf/arch/xtensa/Makefile
index 88c08eed9c7b..119b06a64bed 100644
--- a/tools/perf/arch/xtensa/Makefile
+++ b/tools/perf/arch/xtensa/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_DWARF
+ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 003a3bcebfdf..91672bb3047c 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -616,7 +616,7 @@ __cmd_probe(int argc, const char **argv)
 	set_option_flag(options, 'L', "line", PARSE_OPT_EXCLUSIVE);
 	set_option_flag(options, 'V', "vars", PARSE_OPT_EXCLUSIVE);
 #else
-# define set_nobuild(s, l, c) set_option_nobuild(options, s, l, "NO_DWARF=1", c)
+# define set_nobuild(s, l, c) set_option_nobuild(options, s, l, "NO_LIBDW=1", c)
 	set_nobuild('L', "line", false);
 	set_nobuild('V', "vars", false);
 	set_nobuild('\0', "externs", false);
-- 
2.47.0.rc0.187.ge670bccf7e-goog

