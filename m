Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70BB32E730
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627802; cv=none; b=L5rm9sF0pbGTlUwQGEhD/6CD9T6wOm8Er86jN9bILSR9uDnIB/9ecalKZECDyXeSqP6Q8RDKeVzb0FxUDjptZxSIwAF32efTHKzq8Sfc/dXQlV5/NXhoZ8i+CDQ3ZGb2iKsGfDRG4DHlp8qfXSyn/OWCNegShIFXQTCI8jDyIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627802; c=relaxed/simple;
	bh=0CymPKudGe+KI6Wn4idJryFK+62VhKG4sXlkbqlHNWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=U2vtr0MrN9w2aLFrxhVtA4QM5NYrkwLHP7LLBlYYWfVB9jXwM3l+47fudjTAmK6E6drMzaSqCB5ziQpgkT9bqA+YgYvogcpTSUmkpZR49lHN44JiOpLkOY3onh//qhtPS2SNE77oed1xsPRyQgNqdXfcxeH0HkBnFBE3mIpRnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dviA2s7A; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dviA2s7A"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b04f8c5e84so3156799eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627799; x=1769232599; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/cI6wzc88dPba4Z3EWyEhx9YKJRNqyLJPumk+e8HfU=;
        b=dviA2s7AH5fqbMQ6hvsAk7KOaRULGBQ0N8z4yu8Ws4rg8x//KfiUTaf+LJ4w+LDOI5
         b4/MDS1AbZrB0Vn/vTxE5M3xFaqQF2fEV5jcLxA1cqCuyW6BixNRlS5EREenT59ra+w/
         KFKP0/7hvIGRYxYilpX+q0CL45R7V8h+FERgnL2IrathkiMQJgYFE5hbqEAXJHVKBQt+
         rw+WYemS4wVFaX5gKeKGN12bG3wrMXWofKFJInTtViRR40DUbxNB+hCbGajzebql83/Y
         r65AjR30r0cor19+W3CC/3+iunaT5XubBYB4uSIdDmQnEPp3rnOlx9rLr5vJuHJXL/9F
         lyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627799; x=1769232599;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/cI6wzc88dPba4Z3EWyEhx9YKJRNqyLJPumk+e8HfU=;
        b=qwt5OpjcYiRKGLI9TzsHujnfv+wBeza/bdnY+75mrl7q/g2ZeVXPy3dvoUfCoMdxPH
         h2WHmlIzdMNIO5C/ojq+eJRWiTGMpf740CtwsmCxBIfnCnlLDgP7AcqYJ7N1enIRxPjB
         2j80KhScUOpBwz0HfxvQi3ddYXbDp0wqT+5qLQvNxiZvayckgI3dPB2a2Hke2VInTfDJ
         tocmHfbT5vUVoAjE6Hf2LIY794hVrTcKkLYY643o9tciXmbZo/yE7n0ehJgWZi9XhpOk
         rkrlE5r9g7TVzJBpk/6gSyOYCiTswOZcVxgud4XD+wHB4JdfA2MsnSqPIKtHzUpGX82v
         4M0g==
X-Forwarded-Encrypted: i=1; AJvYcCVSIK52tdXrYoDF+5xkkHL9BD2s59vXVtb0qI+u7jWOjG7u45TqcmHPOVILdK1x9NdZC4CwD29of8YDJDrARwX0@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaPBidW+IevH6wIRx3Ne78Ug6LQ8d/KBe5gybl9anbxR6BW8X
	ho/9cAZkMIv5mUdPOKUdWWFZQnAuIoEdcp+hHq13fUS4RVKzFRWwM6TfOVp6bG9NF2Q1qQqfwkn
	pNyEC3do7fQ==
X-Received: from dybmj1.prod.google.com ([2002:a05:7301:e01:b0:2ac:3545:743c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6d1f:b0:2b0:4e86:8157
 with SMTP id 5a478bee46e88-2b6b46eb100mr4487390eec.17.1768627798660; Fri, 16
 Jan 2026 21:29:58 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:47 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-22-irogers@google.com>
Subject: [PATCH v1 21/23] perf build: Remove NO_LIBDW_DWARF_UNWIND option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

Libdw unwinding support is present for every architecture that has a
perf_regs.h - perf registers are needed for the initial frame to
unwind. Elfutils also supports sparc, arc and m68k but there is no
support in the Linux kernel for perf registers on these
architectures. As the perf supported dwarf unwinding architectures are
a subset of the elfutils ones, remove NO_LIBDW_DWARF_UNWIND as there
isn't a case of elfutils lacking the support need for perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 19 +------------------
 tools/perf/tests/make      |  3 +--
 tools/perf/util/Build      |  3 +--
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6f2c7bd36e74..5e4ae775987f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -118,14 +118,6 @@ ifeq ($(ARCH),mips)
   endif
 endif
 
-# So far there's only x86 and arm libdw unwind support merged in perf.
-# Disable it on all other architectures in case libdw unwind
-# support is detected in system. Add supported architectures
-# to the check.
-ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky riscv loongarch))
-  NO_LIBDW_DWARF_UNWIND := 1
-endif
-
 ifneq ($(LIBUNWIND),1)
   NO_LIBUNWIND := 1
 endif
@@ -456,7 +448,6 @@ endif
 ifdef NO_LIBELF
   NO_LIBDW := 1
   NO_LIBUNWIND := 1
-  NO_LIBDW_DWARF_UNWIND := 1
   NO_LIBBPF := 1
   NO_JVMTI := 1
 else
@@ -504,10 +495,6 @@ ifeq ($(feature-libaio), 1)
   endif
 endif
 
-ifdef NO_LIBDW
-  NO_LIBDW_DWARF_UNWIND := 1
-endif
-
 ifeq ($(feature-scandirat), 1)
   # Ignore having scandirat with memory sanitizer that lacks an interceptor.
   ifeq ($(filter s% -fsanitize=memory%,$(EXTRA_CFLAGS),),)
@@ -757,7 +744,7 @@ dwarf-post-unwind-text := BUG
 
 # setup DWARF post unwinder
 ifdef NO_LIBUNWIND
-  ifdef NO_LIBDW_DWARF_UNWIND
+  ifdef NO_LIBDW
     $(warning Disabling post unwind, no support found.)
     dwarf-post-unwind := 0
   else
@@ -767,10 +754,6 @@ ifdef NO_LIBUNWIND
 else
   dwarf-post-unwind-text := libunwind
   $(call detected,CONFIG_LIBUNWIND)
-  # Enable libunwind support by default.
-  ifndef NO_LIBDW_DWARF_UNWIND
-    NO_LIBDW_DWARF_UNWIND := 1
-  endif
 endif
 
 ifeq ($(dwarf-post-unwind),1)
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 36411b4b6d2b..767ad9e147a8 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -83,7 +83,6 @@ make_no_demangle    := NO_DEMANGLE=1
 make_no_libelf      := NO_LIBELF=1
 make_no_libdw       := NO_LIBDW=1
 make_libunwind      := LIBUNWIND=1
-make_no_libdw_dwarf_unwind := NO_LIBDW_DWARF_UNWIND=1
 make_no_backtrace   := NO_BACKTRACE=1
 make_no_libcapstone := NO_CAPSTONE=1
 make_no_libnuma     := NO_LIBNUMA=1
@@ -120,7 +119,7 @@ make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX3
 make_minimal        := NO_LIBPYTHON=1 NO_GTK2=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
-make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_LIBBPF=1
+make_minimal        += NO_LIBBPF=1
 make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
 make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 3cb1edd263cf..c30ff257f8b4 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -223,9 +223,8 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-arch/
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
 perf-util-$(CONFIG_LIBDW) += libdw.o
+perf-util-$(CONFIG_LIBDW) += unwind-libdw.o
 
-perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
-perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-arch/
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
 perf-util-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
 perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
-- 
2.52.0.457.g6b5491de43-goog

