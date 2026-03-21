Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE62D94B0
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774136549; cv=none; b=Z79E0FDQ5Oy4I7dNyjCw1MhEUMjJ5ovkRl+e75Wx3KlMkCH8rXsJJj3exePVTUbLOz3XuIy9tRZfCom1z6bTqp9/iDNsIPRoHHk9+mcjc2SVVTGeHRcazDdreekJGTwAyCxlNjsuNdyF2dHvZoiaQucyF//ljdUJzxazORf77dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774136549; c=relaxed/simple;
	bh=b14ZaQ72+6G0CmOD/HSKLuceOwG2laHCqZDSSwvhkYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T2pmqHwNSBKXtiASaADnxC78NBPvJF1Vuw5wNiEcp5hT7L6WAfAeTkAeQhA1yYTz9V9rjqtmYS5+M1/Z+d9wqFD008/AJxY7uEzAIQzDFj33MVNRu5jYHvHF/ZpDqa7zOMMVVpWeVGIloc24O6OwvvCCk/uynyCgbndDARNQcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D78HZ5Du; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D78HZ5Du"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128edc72e5bso5980562c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 16:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774136546; x=1774741346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPdyZg2pRTMqSXJbw1nCFEoq74ad50B/gyYVlFTuwsM=;
        b=D78HZ5DuqsBNfPMxREz6MRg9FdyfO+erZQkMVeijxi1wMQ+CKcSS9qn6jojVU5eoUl
         TufxLJ9pstwgK4lp6HpMDOZjFPj84hTjZ/jNgo6nZd1t2HWhf444xWQhzZeujdf2quxZ
         1Wx49TNRFLxgp3Ue9je74gPUqZwbuAhBlEjEGSEn2467I1NCMqshBUMpGxNDSrsewAiv
         sNc/+Zw9MWsqYxxZr+79/vuiB+QbADP7Ih+Wfu6nlbdVDkcHABSMxl1sRxQ1tb51UiyL
         e5a1pCSRZKnJFypvL8OYxr++wvf7QHQf1AUiWPKfVkpxXh1JgjcKNCxGLVMcGM/kfwji
         ZYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774136546; x=1774741346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPdyZg2pRTMqSXJbw1nCFEoq74ad50B/gyYVlFTuwsM=;
        b=fOXZLqTT8GzX5csXHaHrOxa0bqvqEImHjw8Z1c9Uqp4mKKcdjGQPnfGL1LE+cdyYqR
         q0DdCsNxNiscHe6NteEM2GhQDPTtIoDiUmXAQtO47PLKWMozb24hyMY2Ii1E9NQlqTL0
         ePyRSVByey74pD3kGTTPCVlEOaUAhc8ZbUqhP39LXyg8LzxJ5RjrppfruuDDHbwh33+K
         e/2Y23KBGOh64ea98Iiv73dozIez8sEF/OEqmgnefMIp8Xm6Q3AxtuwTqNWKW3bUCOep
         t9QB1wO1opqClPg3qZPbkI1Ww0eUjURytQqfjaL8pL7WpnSLYwdz62Wa8TJ/R3oXpuYO
         905g==
X-Forwarded-Encrypted: i=1; AJvYcCXdBS6vRsSik+3KGrNRg81dHaqbr9MSIYLEJ6wMjESKZxOCf+NOe2yHuo1jvd4P+2ehNK/W7aqX02u7K/thFxNq@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHqu2m+FS5RESbdz97yjnY9i1dPzL9MZfSG9ExueneLgY7hXE
	jBbmZnQS8uKiPVp8qlWP9l3WtGS/xW1RU4rbjzyJpwKLSoKYaFkeAzx1G2bpXWpGhL1r9vV45RK
	UZvaJnJHhpA==
X-Received: from dlbut6.prod.google.com ([2002:a05:7022:7e06:b0:12a:771f:b414])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:62a9:b0:128:d714:3ca1
 with SMTP id a92af1059eb24-12a7266cd77mr3363354c88.5.1774136545358; Sat, 21
 Mar 2026 16:42:25 -0700 (PDT)
Date: Sat, 21 Mar 2026 16:42:19 -0700
In-Reply-To: <20260321234220.848859-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <abxs-2rozL1tBEO1@google.com> <20260321234220.848859-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260321234220.848859-2-irogers@google.com>
Subject: [PATCH v1 1/2] perf build: Remove libunwind support
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

libunwind support is deprecated and libdw is preferred for DWARF unwinding.
Remove the libunwind configuration from Makefile.config, and delete the
associated source files and architecture-specific support code.

Update the DWARF post-unwind logic to rely solely on libdw. Clean up
the HAVE_LIBUNWIND_SUPPORT and CONFIG_LIBUNWIND references across
the codebase, including the unwind_libunwind_ops structure.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-check.txt       |   1 -
 tools/perf/Documentation/perf-config.txt      |   4 +-
 tools/perf/Documentation/perf-record.txt      |   2 +-
 tools/perf/Makefile.config                    | 163 +---
 tools/perf/Makefile.perf                      |   3 -
 tools/perf/arch/arm/util/Build                |   1 -
 tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
 tools/perf/arch/loongarch/util/Build          |   1 -
 .../arch/loongarch/util/unwind-libunwind.c    |  82 --
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/unwind-libunwind.c  |  22 -
 tools/perf/arch/powerpc/util/Build            |   1 -
 .../perf/arch/powerpc/util/unwind-libunwind.c |  92 --
 tools/perf/arch/x86/util/Build                |   1 -
 tools/perf/arch/x86/util/unwind-libunwind.c   | 115 ---
 tools/perf/builtin-check.c                    |   1 -
 tools/perf/builtin-report.c                   |   4 +-
 tools/perf/tests/make                         |   2 -
 tools/perf/util/Build                         |   5 -
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/dso.h                         |   6 -
 tools/perf/util/libunwind/arm64.c             |  40 -
 tools/perf/util/libunwind/x86_32.c            |  41 -
 tools/perf/util/maps.c                        |  47 +-
 tools/perf/util/maps.h                        |   6 -
 tools/perf/util/thread.c                      |  40 +-
 tools/perf/util/thread.h                      |   1 -
 tools/perf/util/unwind-libunwind-local.c      | 832 ------------------
 tools/perf/util/unwind-libunwind.c            |  92 --
 tools/perf/util/unwind.h                      |  41 +-
 32 files changed, 19 insertions(+), 1698 deletions(-)
 delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
 delete mode 100644 tools/perf/util/libunwind/arm64.c
 delete mode 100644 tools/perf/util/libunwind/x86_32.c
 delete mode 100644 tools/perf/util/unwind-libunwind-local.c
 delete mode 100644 tools/perf/util/unwind-libunwind.c

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 09e1d35677f5..1ad30ba53bd6 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -63,7 +63,6 @@ feature::
                 libpython               /  HAVE_LIBPYTHON_SUPPORT
                 libslang                /  HAVE_SLANG_SUPPORT
                 libtraceevent           /  HAVE_LIBTRACEEVENT
-                libunwind               /  HAVE_LIBUNWIND_SUPPORT
                 lzma                    /  HAVE_LZMA_SUPPORT
                 numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
                 zlib                    /  HAVE_ZLIB_SUPPORT
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 642d1c490d9e..38b8d5c69023 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -446,8 +446,8 @@ call-graph.*::
 
 	call-graph.record-mode::
 		The mode for user space can be 'fp' (frame pointer), 'dwarf'
-		and 'lbr'.  The value 'dwarf' is effective only if libunwind
-		(or a recent version of libdw) is present on the system;
+		and 'lbr'.  The value 'dwarf' is effective only if a recent
+		version of libdw is present on the system;
 		the value 'lbr' only works for certain cpus. The method for
 		kernel space is controlled not by this option but by the
 		kernel config (CONFIG_UNWINDER_*).
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 178f483140ed..b4daa668f70a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -308,7 +308,7 @@ OPTIONS
 	In some systems, where binaries are build with gcc
 	--fomit-frame-pointer, using the "fp" method will produce bogus
 	call graphs, using "dwarf", if available (perf tools linked to
-	the libunwind or libdw library) should be used instead.
+	the libdw library) should be used instead.
 	Using the "lbr" method doesn't require any compiler options. It
 	will produce call graphs from the hardware LBR registers. The
 	main limitation is that it is only available on new Intel
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a8dc72cfe48e..90b6df4cbeca 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -65,97 +65,19 @@ $(call detected_var,SRCARCH)
 
 CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
 
-# Additional ARCH settings for ppc
-ifeq ($(SRCARCH),powerpc)
-  ifndef NO_LIBUNWIND
-    LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
-  endif
-endif
-
 # Additional ARCH settings for x86
 ifeq ($(SRCARCH),x86)
   $(call detected,CONFIG_X86)
   ifeq (${IS_64_BIT}, 1)
     CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT
     ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
-    ifndef NO_LIBUNWIND
-      LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
-    endif
     $(call detected,CONFIG_X86_64)
-  else
-    ifndef NO_LIBUNWIND
-      LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
-    endif
-  endif
-endif
-
-ifeq ($(SRCARCH),arm)
-  ifndef NO_LIBUNWIND
-    LIBUNWIND_LIBS = -lunwind -lunwind-arm
-  endif
-endif
-
-ifeq ($(SRCARCH),arm64)
-  ifndef NO_LIBUNWIND
-    LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
-  endif
-endif
-
-ifeq ($(SRCARCH),loongarch)
-  ifndef NO_LIBUNWIND
-    LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
   endif
 endif
 
 ifeq ($(ARCH),s390)
   CFLAGS += -fPIC
 endif
-
-ifeq ($(ARCH),mips)
-  ifndef NO_LIBUNWIND
-    LIBUNWIND_LIBS = -lunwind -lunwind-mips
-  endif
-endif
-
-ifneq ($(LIBUNWIND),1)
-  NO_LIBUNWIND := 1
-endif
-
-ifeq ($(LIBUNWIND_LIBS),)
-  NO_LIBUNWIND := 1
-endif
-#
-# For linking with debug library, run like:
-#
-#   make DEBUG=1 LIBUNWIND_DIR=/opt/libunwind/
-#
-
-libunwind_arch_set_flags = $(eval $(libunwind_arch_set_flags_code))
-define libunwind_arch_set_flags_code
-  FEATURE_CHECK_CFLAGS-libunwind-$(1)  = -I$(LIBUNWIND_DIR)/include
-  FEATURE_CHECK_LDFLAGS-libunwind-$(1) = -L$(LIBUNWIND_DIR)/lib
-endef
-
-ifdef LIBUNWIND_DIR
-  LIBUNWIND_CFLAGS  = -I$(LIBUNWIND_DIR)/include
-  LIBUNWIND_LDFLAGS = -L$(LIBUNWIND_DIR)/lib
-  LIBUNWIND_ARCHS = x86 x86_64 arm aarch64 debug-frame-arm debug-frame-aarch64 loongarch
-  $(foreach libunwind_arch,$(LIBUNWIND_ARCHS),$(call libunwind_arch_set_flags,$(libunwind_arch)))
-endif
-
-ifndef NO_LIBUNWIND
-  # Set per-feature check compilation flags
-  FEATURE_CHECK_CFLAGS-libunwind = $(LIBUNWIND_CFLAGS)
-  FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
-  FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
-  FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
-  
-  FEATURE_CHECK_LDFLAGS-libunwind-arm += -lunwind -lunwind-arm
-  FEATURE_CHECK_LDFLAGS-libunwind-aarch64 += -lunwind -lunwind-aarch64
-  FEATURE_CHECK_LDFLAGS-libunwind-x86 += -lunwind -llzma -lunwind-x86
-  FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64
-endif
-
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
@@ -446,7 +368,6 @@ endif
 
 ifdef NO_LIBELF
   NO_LIBDW := 1
-  NO_LIBUNWIND := 1
   NO_LIBBPF := 1
   NO_JVMTI := 1
 else
@@ -637,49 +558,6 @@ ifeq ($(SRCARCH),powerpc)
   endif
 endif
 
-ifndef NO_LIBUNWIND
-  have_libunwind :=
-
-  $(call feature_check,libunwind)
-
-  $(call feature_check,libunwind-x86)
-  ifeq ($(feature-libunwind-x86), 1)
-    $(call detected,CONFIG_LIBUNWIND_X86)
-    CFLAGS += -DHAVE_LIBUNWIND_X86_SUPPORT
-    LDFLAGS += -lunwind-x86
-    EXTLIBS_LIBUNWIND += -lunwind-x86
-    have_libunwind = 1
-  endif
-
-  $(call feature_check,libunwind-aarch64)
-  ifeq ($(feature-libunwind-aarch64), 1)
-    $(call detected,CONFIG_LIBUNWIND_AARCH64)
-    CFLAGS += -DHAVE_LIBUNWIND_AARCH64_SUPPORT
-    LDFLAGS += -lunwind-aarch64
-    EXTLIBS_LIBUNWIND += -lunwind-aarch64
-    have_libunwind = 1
-    $(call feature_check,libunwind-debug-frame-aarch64)
-    ifneq ($(feature-libunwind-debug-frame-aarch64), 1)
-      $(warning No debug_frame support found in libunwind-aarch64)
-      CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME_AARCH64
-    endif
-  endif
-
-  ifneq ($(feature-libunwind), 1)
-    $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR and set LIBUNWIND=1 in the make command line as it is opt-in now)
-    NO_LOCAL_LIBUNWIND := 1
-  else
-    have_libunwind := 1
-    $(call detected,CONFIG_LOCAL_LIBUNWIND)
-  endif
-
-  ifneq ($(have_libunwind), 1)
-    NO_LIBUNWIND := 1
-  endif
-else
-  NO_LOCAL_LIBUNWIND := 1
-endif
-
 ifndef NO_LIBBPF
   ifneq ($(feature-bpf), 1)
     $(warning BPF API too old. Please install recent kernel headers. BPF support in 'perf record' is disabled.)
@@ -742,17 +620,12 @@ dwarf-post-unwind := 1
 dwarf-post-unwind-text := BUG
 
 # setup DWARF post unwinder
-ifdef NO_LIBUNWIND
-  ifdef NO_LIBDW
-    $(warning Disabling post unwind, no support found.)
-    dwarf-post-unwind := 0
-  else
-    dwarf-post-unwind-text := libdw
-    $(call detected,CONFIG_LIBDW_DWARF_UNWIND)
-  endif
+ifdef NO_LIBDW
+  $(warning Disabling post unwind, no support found.)
+  dwarf-post-unwind := 0
 else
-  dwarf-post-unwind-text := libunwind
-  $(call detected,CONFIG_LIBUNWIND)
+  dwarf-post-unwind-text := libdw
+  $(call detected,CONFIG_LIBDW_DWARF_UNWIND)
 endif
 
 ifeq ($(dwarf-post-unwind),1)
@@ -760,31 +633,6 @@ ifeq ($(dwarf-post-unwind),1)
   $(call detected,CONFIG_DWARF_UNWIND)
 endif
 
-ifndef NO_LIBUNWIND
-  ifndef NO_LOCAL_LIBUNWIND
-    ifeq ($(SRCARCH),$(filter $(SRCARCH),arm arm64))
-      $(call feature_check,libunwind-debug-frame)
-      ifneq ($(feature-libunwind-debug-frame), 1)
-        $(warning No debug_frame support found in libunwind)
-        CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME
-      endif
-    else
-      # non-ARM has no dwarf_find_debug_frame() function:
-      CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME
-    endif
-    EXTLIBS += $(LIBUNWIND_LIBS)
-    LDFLAGS += $(LIBUNWIND_LIBS)
-  endif
-  ifeq ($(findstring -static,${LDFLAGS}),-static)
-    # gcc -static links libgcc_eh which contans piece of libunwind
-    LIBUNWIND_LDFLAGS += -Wl,--allow-multiple-definition
-  endif
-  CFLAGS  += -DHAVE_LIBUNWIND_SUPPORT
-  CFLAGS  += $(LIBUNWIND_CFLAGS)
-  LDFLAGS += $(LIBUNWIND_LDFLAGS)
-  EXTLIBS += $(EXTLIBS_LIBUNWIND)
-endif
-
 ifneq ($(NO_LIBTRACEEVENT),1)
   $(call detected,CONFIG_TRACE)
 endif
@@ -1273,7 +1121,6 @@ ifeq ($(VF),1)
   $(call print_var,bindir)
   $(call print_var,libdir)
   $(call print_var,sysconfdir)
-  $(call print_var,LIBUNWIND_DIR)
   $(call print_var,LIBDW_DIR)
   $(call print_var,JDIR)
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 11b63bafdb23..4b798fc53650 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -55,9 +55,6 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBELF if you do not want libelf dependency (e.g. cross-builds)
 #
-# Define LIBUNWIND if you do not want libunwind dependency for dwarf
-# backtrace post unwind.
-#
 # Define NO_BACKTRACE if you do not want stack backtrace debug feature
 #
 # Define NO_LIBNUMA if you do not want numa perf benchmark
diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index b94bf3c5279a..dbf3524773cf 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -1,3 +1,2 @@
-perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 
 perf-util-y += pmu.o auxtrace.o cs-etm.o
diff --git a/tools/perf/arch/arm/util/unwind-libunwind.c b/tools/perf/arch/arm/util/unwind-libunwind.c
deleted file mode 100644
index 438906bf0014..000000000000
--- a/tools/perf/arch/arm/util/unwind-libunwind.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <errno.h>
-#include <libunwind.h>
-#include "perf_regs.h"
-#include "../../../util/unwind.h"
-#include "../../../util/debug.h"
-
-int libunwind__arch_reg_id(int regnum)
-{
-	switch (regnum) {
-	case UNW_ARM_R0:
-		return PERF_REG_ARM_R0;
-	case UNW_ARM_R1:
-		return PERF_REG_ARM_R1;
-	case UNW_ARM_R2:
-		return PERF_REG_ARM_R2;
-	case UNW_ARM_R3:
-		return PERF_REG_ARM_R3;
-	case UNW_ARM_R4:
-		return PERF_REG_ARM_R4;
-	case UNW_ARM_R5:
-		return PERF_REG_ARM_R5;
-	case UNW_ARM_R6:
-		return PERF_REG_ARM_R6;
-	case UNW_ARM_R7:
-		return PERF_REG_ARM_R7;
-	case UNW_ARM_R8:
-		return PERF_REG_ARM_R8;
-	case UNW_ARM_R9:
-		return PERF_REG_ARM_R9;
-	case UNW_ARM_R10:
-		return PERF_REG_ARM_R10;
-	case UNW_ARM_R11:
-		return PERF_REG_ARM_FP;
-	case UNW_ARM_R12:
-		return PERF_REG_ARM_IP;
-	case UNW_ARM_R13:
-		return PERF_REG_ARM_SP;
-	case UNW_ARM_R14:
-		return PERF_REG_ARM_LR;
-	case UNW_ARM_R15:
-		return PERF_REG_ARM_PC;
-	default:
-		pr_err("unwind: invalid reg id %d\n", regnum);
-		return -EINVAL;
-	}
-
-	return -EINVAL;
-}
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 4e06a08d281a..4b70c4788c80 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,4 +1,3 @@
-perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-y += ../../arm/util/auxtrace.o
 perf-util-y += ../../arm/util/cs-etm.o
 perf-util-y += ../../arm/util/pmu.o
diff --git a/tools/perf/arch/arm64/util/unwind-libunwind.c b/tools/perf/arch/arm64/util/unwind-libunwind.c
deleted file mode 100644
index 871af5992298..000000000000
--- a/tools/perf/arch/arm64/util/unwind-libunwind.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-
-#ifndef REMOTE_UNWIND_LIBUNWIND
-#include <libunwind.h>
-#include "perf_regs.h"
-#include "../../../util/unwind.h"
-#endif
-#include "../../../util/debug.h"
-
-int LIBUNWIND__ARCH_REG_ID(int regnum)
-{
-	if (regnum < 0 || regnum >= PERF_REG_ARM64_EXTENDED_MAX)
-		return -EINVAL;
-
-	return regnum;
-}
diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 3ad73d0289f3..e4572b644906 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,4 +1,3 @@
 perf-util-y += header.o
 
-perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/loongarch/util/unwind-libunwind.c b/tools/perf/arch/loongarch/util/unwind-libunwind.c
deleted file mode 100644
index f693167b86ef..000000000000
--- a/tools/perf/arch/loongarch/util/unwind-libunwind.c
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <errno.h>
-#include <libunwind.h>
-#include "perf_regs.h"
-#include "../../util/unwind.h"
-#include "util/debug.h"
-
-int libunwind__arch_reg_id(int regnum)
-{
-	switch (regnum) {
-	case UNW_LOONGARCH64_R1:
-		return PERF_REG_LOONGARCH_R1;
-	case UNW_LOONGARCH64_R2:
-		return PERF_REG_LOONGARCH_R2;
-	case UNW_LOONGARCH64_R3:
-		return PERF_REG_LOONGARCH_R3;
-	case UNW_LOONGARCH64_R4:
-		return PERF_REG_LOONGARCH_R4;
-	case UNW_LOONGARCH64_R5:
-		return PERF_REG_LOONGARCH_R5;
-	case UNW_LOONGARCH64_R6:
-		return PERF_REG_LOONGARCH_R6;
-	case UNW_LOONGARCH64_R7:
-		return PERF_REG_LOONGARCH_R7;
-	case UNW_LOONGARCH64_R8:
-		return PERF_REG_LOONGARCH_R8;
-	case UNW_LOONGARCH64_R9:
-		return PERF_REG_LOONGARCH_R9;
-	case UNW_LOONGARCH64_R10:
-		return PERF_REG_LOONGARCH_R10;
-	case UNW_LOONGARCH64_R11:
-		return PERF_REG_LOONGARCH_R11;
-	case UNW_LOONGARCH64_R12:
-		return PERF_REG_LOONGARCH_R12;
-	case UNW_LOONGARCH64_R13:
-		return PERF_REG_LOONGARCH_R13;
-	case UNW_LOONGARCH64_R14:
-		return PERF_REG_LOONGARCH_R14;
-	case UNW_LOONGARCH64_R15:
-		return PERF_REG_LOONGARCH_R15;
-	case UNW_LOONGARCH64_R16:
-		return PERF_REG_LOONGARCH_R16;
-	case UNW_LOONGARCH64_R17:
-		return PERF_REG_LOONGARCH_R17;
-	case UNW_LOONGARCH64_R18:
-		return PERF_REG_LOONGARCH_R18;
-	case UNW_LOONGARCH64_R19:
-		return PERF_REG_LOONGARCH_R19;
-	case UNW_LOONGARCH64_R20:
-		return PERF_REG_LOONGARCH_R20;
-	case UNW_LOONGARCH64_R21:
-		return PERF_REG_LOONGARCH_R21;
-	case UNW_LOONGARCH64_R22:
-		return PERF_REG_LOONGARCH_R22;
-	case UNW_LOONGARCH64_R23:
-		return PERF_REG_LOONGARCH_R23;
-	case UNW_LOONGARCH64_R24:
-		return PERF_REG_LOONGARCH_R24;
-	case UNW_LOONGARCH64_R25:
-		return PERF_REG_LOONGARCH_R25;
-	case UNW_LOONGARCH64_R26:
-		return PERF_REG_LOONGARCH_R26;
-	case UNW_LOONGARCH64_R27:
-		return PERF_REG_LOONGARCH_R27;
-	case UNW_LOONGARCH64_R28:
-		return PERF_REG_LOONGARCH_R28;
-	case UNW_LOONGARCH64_R29:
-		return PERF_REG_LOONGARCH_R29;
-	case UNW_LOONGARCH64_R30:
-		return PERF_REG_LOONGARCH_R30;
-	case UNW_LOONGARCH64_R31:
-		return PERF_REG_LOONGARCH_R31;
-	case UNW_LOONGARCH64_PC:
-		return PERF_REG_LOONGARCH_PC;
-	default:
-		pr_err("unwind: invalid reg id %d\n", regnum);
-		return -EINVAL;
-	}
-
-	return -EINVAL;
-}
diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
index 818b808a8247..e69de29bb2d1 100644
--- a/tools/perf/arch/mips/util/Build
+++ b/tools/perf/arch/mips/util/Build
@@ -1 +0,0 @@
-perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/mips/util/unwind-libunwind.c b/tools/perf/arch/mips/util/unwind-libunwind.c
deleted file mode 100644
index 0d8c99c29da6..000000000000
--- a/tools/perf/arch/mips/util/unwind-libunwind.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <errno.h>
-#include <libunwind.h>
-#include "perf_regs.h"
-#include "../../util/unwind.h"
-#include "util/debug.h"
-
-int libunwind__arch_reg_id(int regnum)
-{
-	switch (regnum) {
-	case UNW_MIPS_R1 ... UNW_MIPS_R25:
-		return regnum - UNW_MIPS_R1 + PERF_REG_MIPS_R1;
-	case UNW_MIPS_R28 ... UNW_MIPS_R31:
-		return regnum - UNW_MIPS_R28 + PERF_REG_MIPS_R28;
-	case UNW_MIPS_PC:
-		return PERF_REG_MIPS_PC;
-	default:
-		pr_err("unwind: invalid reg id %d\n", regnum);
-		return -EINVAL;
-	}
-}
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index d66574cbb9a9..ae928050e07a 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -6,5 +6,4 @@ perf-util-y += evsel.o
 
 perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
 
-perf-util-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
 perf-util-y += auxtrace.o
diff --git a/tools/perf/arch/powerpc/util/unwind-libunwind.c b/tools/perf/arch/powerpc/util/unwind-libunwind.c
deleted file mode 100644
index 90a6beda20de..000000000000
--- a/tools/perf/arch/powerpc/util/unwind-libunwind.c
+++ /dev/null
@@ -1,92 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2016 Chandan Kumar, IBM Corporation.
- */
-
-#include <errno.h>
-#include <libunwind.h>
-#include <asm/perf_regs.h>
-#include "../../util/unwind.h"
-#include "../../util/debug.h"
-
-int libunwind__arch_reg_id(int regnum)
-{
-	switch (regnum) {
-	case UNW_PPC64_R0:
-		return PERF_REG_POWERPC_R0;
-	case UNW_PPC64_R1:
-		return PERF_REG_POWERPC_R1;
-	case UNW_PPC64_R2:
-		return PERF_REG_POWERPC_R2;
-	case UNW_PPC64_R3:
-		return PERF_REG_POWERPC_R3;
-	case UNW_PPC64_R4:
-		return PERF_REG_POWERPC_R4;
-	case UNW_PPC64_R5:
-		return PERF_REG_POWERPC_R5;
-	case UNW_PPC64_R6:
-		return PERF_REG_POWERPC_R6;
-	case UNW_PPC64_R7:
-		return PERF_REG_POWERPC_R7;
-	case UNW_PPC64_R8:
-		return PERF_REG_POWERPC_R8;
-	case UNW_PPC64_R9:
-		return PERF_REG_POWERPC_R9;
-	case UNW_PPC64_R10:
-		return PERF_REG_POWERPC_R10;
-	case UNW_PPC64_R11:
-		return PERF_REG_POWERPC_R11;
-	case UNW_PPC64_R12:
-		return PERF_REG_POWERPC_R12;
-	case UNW_PPC64_R13:
-		return PERF_REG_POWERPC_R13;
-	case UNW_PPC64_R14:
-		return PERF_REG_POWERPC_R14;
-	case UNW_PPC64_R15:
-		return PERF_REG_POWERPC_R15;
-	case UNW_PPC64_R16:
-		return PERF_REG_POWERPC_R16;
-	case UNW_PPC64_R17:
-		return PERF_REG_POWERPC_R17;
-	case UNW_PPC64_R18:
-		return PERF_REG_POWERPC_R18;
-	case UNW_PPC64_R19:
-		return PERF_REG_POWERPC_R19;
-	case UNW_PPC64_R20:
-		return PERF_REG_POWERPC_R20;
-	case UNW_PPC64_R21:
-		return PERF_REG_POWERPC_R21;
-	case UNW_PPC64_R22:
-		return PERF_REG_POWERPC_R22;
-	case UNW_PPC64_R23:
-		return PERF_REG_POWERPC_R23;
-	case UNW_PPC64_R24:
-		return PERF_REG_POWERPC_R24;
-	case UNW_PPC64_R25:
-		return PERF_REG_POWERPC_R25;
-	case UNW_PPC64_R26:
-		return PERF_REG_POWERPC_R26;
-	case UNW_PPC64_R27:
-		return PERF_REG_POWERPC_R27;
-	case UNW_PPC64_R28:
-		return PERF_REG_POWERPC_R28;
-	case UNW_PPC64_R29:
-		return PERF_REG_POWERPC_R29;
-	case UNW_PPC64_R30:
-		return PERF_REG_POWERPC_R30;
-	case UNW_PPC64_R31:
-		return PERF_REG_POWERPC_R31;
-	case UNW_PPC64_LR:
-		return PERF_REG_POWERPC_LINK;
-	case UNW_PPC64_CTR:
-		return PERF_REG_POWERPC_CTR;
-	case UNW_PPC64_XER:
-		return PERF_REG_POWERPC_XER;
-	case UNW_PPC64_NIP:
-		return PERF_REG_POWERPC_NIP;
-	default:
-		pr_err("unwind: invalid reg id %d\n", regnum);
-		return -EINVAL;
-	}
-	return -EINVAL;
-}
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index b94c91984c66..5045457ae39c 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -9,7 +9,6 @@ perf-util-y += mem-events.o
 perf-util-y += evsel.o
 perf-util-y += iostat.o
 
-perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 
 perf-util-y += auxtrace.o
 perf-util-y += intel-pt.o
diff --git a/tools/perf/arch/x86/util/unwind-libunwind.c b/tools/perf/arch/x86/util/unwind-libunwind.c
deleted file mode 100644
index 47357973b55b..000000000000
--- a/tools/perf/arch/x86/util/unwind-libunwind.c
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <errno.h>
-#include "../../util/debug.h"
-#ifndef REMOTE_UNWIND_LIBUNWIND
-#include <libunwind.h>
-#include "perf_regs.h"
-#include "../../util/unwind.h"
-#endif
-
-#ifdef HAVE_ARCH_X86_64_SUPPORT
-int LIBUNWIND__ARCH_REG_ID(int regnum)
-{
-	int id;
-
-	switch (regnum) {
-	case UNW_X86_64_RAX:
-		id = PERF_REG_X86_AX;
-		break;
-	case UNW_X86_64_RDX:
-		id = PERF_REG_X86_DX;
-		break;
-	case UNW_X86_64_RCX:
-		id = PERF_REG_X86_CX;
-		break;
-	case UNW_X86_64_RBX:
-		id = PERF_REG_X86_BX;
-		break;
-	case UNW_X86_64_RSI:
-		id = PERF_REG_X86_SI;
-		break;
-	case UNW_X86_64_RDI:
-		id = PERF_REG_X86_DI;
-		break;
-	case UNW_X86_64_RBP:
-		id = PERF_REG_X86_BP;
-		break;
-	case UNW_X86_64_RSP:
-		id = PERF_REG_X86_SP;
-		break;
-	case UNW_X86_64_R8:
-		id = PERF_REG_X86_R8;
-		break;
-	case UNW_X86_64_R9:
-		id = PERF_REG_X86_R9;
-		break;
-	case UNW_X86_64_R10:
-		id = PERF_REG_X86_R10;
-		break;
-	case UNW_X86_64_R11:
-		id = PERF_REG_X86_R11;
-		break;
-	case UNW_X86_64_R12:
-		id = PERF_REG_X86_R12;
-		break;
-	case UNW_X86_64_R13:
-		id = PERF_REG_X86_R13;
-		break;
-	case UNW_X86_64_R14:
-		id = PERF_REG_X86_R14;
-		break;
-	case UNW_X86_64_R15:
-		id = PERF_REG_X86_R15;
-		break;
-	case UNW_X86_64_RIP:
-		id = PERF_REG_X86_IP;
-		break;
-	default:
-		pr_err("unwind: invalid reg id %d\n", regnum);
-		return -EINVAL;
-	}
-
-	return id;
-}
-#else
-int LIBUNWIND__ARCH_REG_ID(int regnum)
-{
-	int id;
-
-	switch (regnum) {
-	case UNW_X86_EAX:
-		id = PERF_REG_X86_AX;
-		break;
-	case UNW_X86_EDX:
-		id = PERF_REG_X86_DX;
-		break;
-	case UNW_X86_ECX:
-		id = PERF_REG_X86_CX;
-		break;
-	case UNW_X86_EBX:
-		id = PERF_REG_X86_BX;
-		break;
-	case UNW_X86_ESI:
-		id = PERF_REG_X86_SI;
-		break;
-	case UNW_X86_EDI:
-		id = PERF_REG_X86_DI;
-		break;
-	case UNW_X86_EBP:
-		id = PERF_REG_X86_BP;
-		break;
-	case UNW_X86_ESP:
-		id = PERF_REG_X86_SP;
-		break;
-	case UNW_X86_EIP:
-		id = PERF_REG_X86_IP;
-		break;
-	default:
-		pr_err("unwind: invalid reg id %d\n", regnum);
-		return -EINVAL;
-	}
-
-	return id;
-}
-#endif /* HAVE_ARCH_X86_64_SUPPORT */
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 3641d263b345..e6b4016305a6 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -56,7 +56,6 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
 	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
 	FEATURE_STATUS("libtraceevent", HAVE_LIBTRACEEVENT),
-	FEATURE_STATUS_TIP("libunwind", HAVE_LIBUNWIND_SUPPORT, "Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it"),
 	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
 	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 343c0ada5ea1..c5abf507cdac 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -460,9 +460,9 @@ static int report__setup_sample_type(struct report *rep)
 	if (!(evlist__combined_branch_type(session->evlist) & PERF_SAMPLE_BRANCH_ANY))
 		rep->nonany_branch_mode = true;
 
-#if !defined(HAVE_LIBUNWIND_SUPPORT) && !defined(HAVE_LIBDW_SUPPORT)
+#ifndef HAVE_LIBDW_SUPPORT
 	if (dwarf_callchain_users) {
-		ui__warning("Please install libunwind or libdw "
+		ui__warning("Please install libdw "
 			    "development packages during the perf build.\n");
 	}
 #endif
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 6587dc326d1b..3fd505ddd3f9 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -83,7 +83,6 @@ make_no_ui          := NO_SLANG=1 NO_GTK2=1
 make_no_demangle    := NO_DEMANGLE=1
 make_no_libelf      := NO_LIBELF=1
 make_no_libdw       := NO_LIBDW=1
-make_libunwind      := LIBUNWIND=1
 make_no_backtrace   := NO_BACKTRACE=1
 make_no_libcapstone := NO_CAPSTONE=1
 make_libcapstone_dlopen := LIBCAPSTONE_DLOPEN=1
@@ -158,7 +157,6 @@ run += make_no_ui
 run += make_no_demangle
 run += make_no_libelf
 run += make_no_libdw
-run += make_libunwind
 run += make_no_libdw_dwarf_unwind
 run += make_no_backtrace
 run += make_no_libcapstone
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..220c1951c508 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -225,11 +225,6 @@ perf-util-$(CONFIG_LIBDW) += annotate-data.o
 perf-util-$(CONFIG_LIBDW) += libdw.o
 perf-util-$(CONFIG_LIBDW) += unwind-libdw.o
 
-perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
-perf-util-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
-perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
-perf-util-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
-
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-util-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
 endif
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index f879b84f8ff9..18bf42c99c1d 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1742,7 +1742,7 @@ void callchain_param_setup(u64 sample_type, uint16_t e_machine)
 	}
 
 	/*
-	 * It's necessary to use libunwind to reliably determine the caller of
+	 * It's necessary to use libdw to reliably determine the caller of
 	 * a leaf function on aarch64, as otherwise we cannot know whether to
 	 * start from the LR or FP.
 	 *
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ede691e9a249..b559daf36a4e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -233,12 +233,6 @@ struct dso_data {
 	int		 status;
 	u32		 status_seen;
 	u64		 file_size;
-#ifdef HAVE_LIBUNWIND_SUPPORT
-	u64		 elf_base_addr;
-	u64		 debug_frame_offset;
-	u64		 eh_frame_hdr_addr;
-	u64		 eh_frame_hdr_offset;
-#endif
 };
 
 struct dso_bpf_prog {
diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
deleted file mode 100644
index 37ecef0c53b9..000000000000
--- a/tools/perf/util/libunwind/arm64.c
+++ /dev/null
@@ -1,40 +0,0 @@
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
-/* Define arch specific functions & regs for libunwind, should be
- * defined before including "unwind.h"
- */
-#define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
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
index 1697dece1b74..000000000000
--- a/tools/perf/util/libunwind/x86_32.c
+++ /dev/null
@@ -1,41 +0,0 @@
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
-/* Define arch specific functions & regs for libunwind, should be
- * defined before including "unwind.h"
- */
-#define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__x86_reg_id(regnum)
-
-#include "unwind.h"
-#include "libunwind-x86.h"
-#include <../../../../arch/x86/include/uapi/asm/perf_regs.h>
-
-/* HAVE_ARCH_X86_64_SUPPORT is used in'arch/x86/util/unwind-libunwind.c'
- * for x86_32, we undef it to compile code for x86_32 only.
- */
-#undef HAVE_ARCH_X86_64_SUPPORT
-#include "../../arch/x86/util/unwind-libunwind.c"
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
index 4092211cff62..b78ca3c0e6ea 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -37,10 +37,6 @@ DECLARE_RC_STRUCT(maps) {
 	 */
 	struct map	 **maps_by_name;
 	struct machine	 *machine;
-#ifdef HAVE_LIBUNWIND_SUPPORT
-	void		*addr_space;
-	const struct unwind_libunwind_ops *unwind_libunwind_ops;
-#endif
 #ifdef HAVE_LIBDW_SUPPORT
 	void		*libdw_addr_space_dwfl;
 #endif
@@ -186,27 +182,6 @@ refcount_t *maps__refcnt(struct maps *maps)
 	return &RC_CHK_ACCESS(maps)->refcnt;
 }
 
-#ifdef HAVE_LIBUNWIND_SUPPORT
-void *maps__addr_space(const struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->addr_space;
-}
-
-void maps__set_addr_space(struct maps *maps, void *addr_space)
-{
-	RC_CHK_ACCESS(maps)->addr_space = addr_space;
-}
-
-const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->unwind_libunwind_ops;
-}
-
-void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libunwind_ops *ops)
-{
-	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = ops;
-}
-#endif
 #ifdef HAVE_LIBDW_SUPPORT
 void *maps__libdw_addr_space_dwfl(const struct maps *maps)
 {
@@ -230,10 +205,6 @@ static void maps__init(struct maps *maps, struct machine *machine)
 	RC_CHK_ACCESS(maps)->maps_by_address = NULL;
 	RC_CHK_ACCESS(maps)->maps_by_name = NULL;
 	RC_CHK_ACCESS(maps)->machine = machine;
-#ifdef HAVE_LIBUNWIND_SUPPORT
-	RC_CHK_ACCESS(maps)->addr_space = NULL;
-	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = NULL;
-#endif
 #ifdef HAVE_LIBDW_SUPPORT
 	RC_CHK_ACCESS(maps)->libdw_addr_space_dwfl = NULL;
 #endif
@@ -257,7 +228,6 @@ static void maps__exit(struct maps *maps)
 	}
 	zfree(&maps_by_address);
 	zfree(&maps_by_name);
-	unwind__finish_access(maps);
 #ifdef HAVE_LIBDW_SUPPORT
 	libdw__invalidate_dwfl(maps, maps__libdw_addr_space_dwfl(maps));
 #endif
@@ -1067,14 +1037,11 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 			if (!new)
 				err = -ENOMEM;
 			else {
-				err = unwind__prepare_access(dest, new, NULL);
-				if (!err) {
-					dest_maps_by_address[i] = new;
-					map__set_kmap_maps(new, dest);
-					if (dest_maps_by_name)
-						dest_maps_by_name[i] = map__get(new);
-					RC_CHK_ACCESS(dest)->nr_maps = i + 1;
-				}
+				dest_maps_by_address[i] = new;
+				map__set_kmap_maps(new, dest);
+				if (dest_maps_by_name)
+					dest_maps_by_name[i] = map__get(new);
+				RC_CHK_ACCESS(dest)->nr_maps = i + 1;
 			}
 			if (err)
 				map__put(new);
@@ -1099,9 +1066,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 			if (!new)
 				err = -ENOMEM;
 			else {
-				err = unwind__prepare_access(dest, new, NULL);
-				if (!err)
-					err = __maps__insert(dest, new);
+				err = __maps__insert(dest, new);
 			}
 			map__put(new);
 		}
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 20c52084ba9e..7f7f56d39f25 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -46,12 +46,6 @@ struct machine *maps__machine(const struct maps *maps);
 unsigned int maps__nr_maps(const struct maps *maps); /* Test only. */
 refcount_t *maps__refcnt(struct maps *maps); /* Test only. */
 
-#ifdef HAVE_LIBUNWIND_SUPPORT
-void *maps__addr_space(const struct maps *maps);
-void maps__set_addr_space(struct maps *maps, void *addr_space);
-const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps);
-void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libunwind_ops *ops);
-#endif
 #ifdef HAVE_LIBDW_SUPPORT
 void *maps__libdw_addr_space_dwfl(const struct maps *maps);
 void maps__set_libdw_addr_space_dwfl(struct maps *maps, void *dwfl);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 22be77225bb0..046cacb67129 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -263,9 +263,6 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
 		if (!new)
 			return -ENOMEM;
 		list_add(&new->list, thread__comm_list(thread));
-
-		if (exec)
-			unwind__flush_access(thread__maps(thread));
 	}
 
 	thread__set_comm_set(thread, true);
@@ -357,49 +354,14 @@ size_t thread__fprintf(struct thread *thread, FILE *fp)
 
 int thread__insert_map(struct thread *thread, struct map *map)
 {
-	int ret;
-
-	ret = unwind__prepare_access(thread__maps(thread), map, NULL);
-	if (ret)
-		return ret;
-
 	return maps__fixup_overlap_and_insert(thread__maps(thread), map);
 }
 
-struct thread__prepare_access_maps_cb_args {
-	int err;
-	struct maps *maps;
-};
-
-static int thread__prepare_access_maps_cb(struct map *map, void *data)
-{
-	bool initialized = false;
-	struct thread__prepare_access_maps_cb_args *args = data;
-
-	args->err = unwind__prepare_access(args->maps, map, &initialized);
-
-	return (args->err || initialized) ? 1 : 0;
-}
-
-static int thread__prepare_access(struct thread *thread)
-{
-	struct thread__prepare_access_maps_cb_args args = {
-		.err = 0,
-	};
-
-	if (dwarf_callchain_users) {
-		args.maps = thread__maps(thread);
-		maps__for_each_map(thread__maps(thread), thread__prepare_access_maps_cb, &args);
-	}
-
-	return args.err;
-}
-
 static int thread__clone_maps(struct thread *thread, struct thread *parent, bool do_maps_clone)
 {
 	/* This is new thread, we share map groups for process. */
 	if (thread__pid(thread) == thread__pid(parent))
-		return thread__prepare_access(thread);
+		return 0;
 
 	if (maps__equal(thread__maps(thread), thread__maps(parent))) {
 		pr_debug("broken map groups on thread %d/%d parent %d/%d\n",
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index f5792d3e8a16..7bc5f41be0a5 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -19,7 +19,6 @@ struct addr_location;
 struct map;
 struct perf_record_namespaces;
 struct thread_stack;
-struct unwind_libunwind_ops;
 
 struct lbr_stitch {
 	struct list_head		lists;
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
deleted file mode 100644
index 5b39ce21e333..000000000000
--- a/tools/perf/util/unwind-libunwind-local.c
+++ /dev/null
@@ -1,832 +0,0 @@
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
-#include <linux/zalloc.h>
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
-			     perf_arch_reg_sp(thread__e_machine(ui->thread,
-								ui->machine,
-								/*e_flags=*/NULL)));
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
-	id = LIBUNWIND__ARCH_REG_ID(regnum);
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
-static void _unwind__flush_access(struct maps *maps)
-{
-	unw_flush_cache(maps__addr_space(maps), 0, 0);
-}
-
-static void _unwind__finish_access(struct maps *maps)
-{
-	unw_destroy_addr_space(maps__addr_space(maps));
-}
-
-static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
-		       void *arg, int max_stack)
-{
-	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine, /*e_flags=*/NULL);
-	u64 val;
-	unw_word_t ips[max_stack];
-	unw_addr_space_t addr_space;
-	unw_cursor_t c;
-	int ret, i = 0;
-
-	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample),
-			     perf_arch_reg_ip(e_machine));
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
-	.flush_access   = _unwind__flush_access,
-	.finish_access  = _unwind__finish_access,
-	.get_entries    = _unwind__get_entries,
-};
-
-#ifndef REMOTE_UNWIND_LIBUNWIND
-struct unwind_libunwind_ops *
-local_unwind_libunwind_ops = &_unwind_libunwind_ops;
-#endif
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
deleted file mode 100644
index cb8be6acfb6f..000000000000
--- a/tools/perf/util/unwind-libunwind.c
+++ /dev/null
@@ -1,92 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "unwind.h"
-#include "dso.h"
-#include "map.h"
-#include "thread.h"
-#include "session.h"
-#include "debug.h"
-#include "env.h"
-#include "callchain.h"
-
-struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
-struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
-struct unwind_libunwind_ops __weak *arm64_unwind_libunwind_ops;
-
-int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized)
-{
-	const char *arch;
-	enum dso_type dso_type;
-	struct unwind_libunwind_ops *ops = local_unwind_libunwind_ops;
-	struct dso *dso = map__dso(map);
-	struct machine *machine;
-	int err;
-
-	if (!dwarf_callchain_users)
-		return 0;
-
-	if (maps__addr_space(maps)) {
-		pr_debug("unwind: thread map already set, dso=%s\n", dso__name(dso));
-		if (initialized)
-			*initialized = true;
-		return 0;
-	}
-
-	machine = maps__machine(maps);
-	/* env->arch is NULL for live-mode (i.e. perf top) */
-	if (!machine->env || !machine->env->arch)
-		goto out_register;
-
-	dso_type = dso__type(dso, machine);
-	if (dso_type == DSO__TYPE_UNKNOWN)
-		return 0;
-
-	arch = perf_env__arch(machine->env);
-
-	if (!strcmp(arch, "x86")) {
-		if (dso_type != DSO__TYPE_64BIT)
-			ops = x86_32_unwind_libunwind_ops;
-	} else if (!strcmp(arch, "arm64") || !strcmp(arch, "arm")) {
-		if (dso_type == DSO__TYPE_64BIT)
-			ops = arm64_unwind_libunwind_ops;
-	}
-
-	if (!ops) {
-		pr_warning_once("unwind: target platform=%s is not supported\n", arch);
-		return 0;
-	}
-out_register:
-	maps__set_unwind_libunwind_ops(maps, ops);
-
-	err = maps__unwind_libunwind_ops(maps)->prepare_access(maps);
-	if (initialized)
-		*initialized = err ? false : true;
-	return err;
-}
-
-void unwind__flush_access(struct maps *maps)
-{
-	const struct unwind_libunwind_ops *ops = maps__unwind_libunwind_ops(maps);
-
-	if (ops)
-		ops->flush_access(maps);
-}
-
-void unwind__finish_access(struct maps *maps)
-{
-	const struct unwind_libunwind_ops *ops = maps__unwind_libunwind_ops(maps);
-
-	if (ops)
-		ops->finish_access(maps);
-}
-
-int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
-			 struct thread *thread,
-			 struct perf_sample *data, int max_stack,
-			 bool best_effort)
-{
-	const struct unwind_libunwind_ops *ops = maps__unwind_libunwind_ops(thread__maps(thread));
-
-	if (ops)
-		return ops->get_entries(cb, arg, thread, data, max_stack, best_effort);
-	return 0;
-}
diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index 9f7164c6d9aa..782aaeedd923 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -17,15 +17,6 @@ struct unwind_entry {
 
 typedef int (*unwind_entry_cb_t)(struct unwind_entry *entry, void *arg);
 
-struct unwind_libunwind_ops {
-	int (*prepare_access)(struct maps *maps);
-	void (*flush_access)(struct maps *maps);
-	void (*finish_access)(struct maps *maps);
-	int (*get_entries)(unwind_entry_cb_t cb, void *arg,
-			   struct thread *thread,
-			   struct perf_sample *data, int max_stack, bool best_effort);
-};
-
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 /*
  * When best_effort is set, don't report errors and fail silently. This could
@@ -36,27 +27,6 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 			struct thread *thread,
 			struct perf_sample *data, int max_stack,
 			bool best_effort);
-/* libunwind specific */
-#ifdef HAVE_LIBUNWIND_SUPPORT
-#ifndef LIBUNWIND__ARCH_REG_ID
-#define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arch_reg_id(regnum)
-#endif
-
-int LIBUNWIND__ARCH_REG_ID(int regnum);
-int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized);
-void unwind__flush_access(struct maps *maps);
-void unwind__finish_access(struct maps *maps);
-#else
-static inline int unwind__prepare_access(struct maps *maps __maybe_unused,
-					 struct map *map __maybe_unused,
-					 bool *initialized __maybe_unused)
-{
-	return 0;
-}
-
-static inline void unwind__flush_access(struct maps *maps __maybe_unused) {}
-static inline void unwind__finish_access(struct maps *maps __maybe_unused) {}
-#endif
 #else
 static inline int
 unwind__get_entries(unwind_entry_cb_t cb __maybe_unused,
@@ -68,15 +38,6 @@ unwind__get_entries(unwind_entry_cb_t cb __maybe_unused,
 {
 	return 0;
 }
-
-static inline int unwind__prepare_access(struct maps *maps __maybe_unused,
-					 struct map *map __maybe_unused,
-					 bool *initialized __maybe_unused)
-{
-	return 0;
-}
-
-static inline void unwind__flush_access(struct maps *maps __maybe_unused) {}
-static inline void unwind__finish_access(struct maps *maps __maybe_unused) {}
 #endif /* HAVE_DWARF_UNWIND_SUPPORT */
+
 #endif /* __UNWIND_H */
-- 
2.53.0.959.g497ff81fa9-goog

