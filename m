Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A961AD40E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193913; cv=none; b=N2jvLbr5rqMndXLYcY6mGvGGX5UEdvQnCsn8uypPfKDDPlMr7OCPnb+reoxEa7IAVzz/ahyfnDOzVqvs77hJnlmnM4xw24IfPhLTmWn74R5z1LgBaR+SuzYkojJQrQ//I4tmsLfPFgCBrwKtLh3tH3Yjblhmn7o3h9YA2ytqSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193913; c=relaxed/simple;
	bh=lSqkj/40NVRa02AhEWAVQazltw1LzWSoAiy67w/c2jA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VhqAFuL33Cf9ATzU+nr8wm0i4WTy5iQa5B7awfy6gAWR/CNh4uMcq01ROJRdxLIWK0CND2pwpDNmcKDS+6MnxTnxlibzXOANLRHplb+eYS3KF7sGKAJU+7ScCKEsSRaGM8xdMSuhnUY3h0s6833awVUn2RrKXQA8nGFR2Sh3sAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u0bRjuco; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0bRjuco"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4bd76f5a8so88687257b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193910; x=1727798710; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mrzvyO3a3OSC4Wwsy52IiF981940PgOYxjk5hjhaV8=;
        b=u0bRjucoLCvJcEXu1EoyoCVbkgK8rQMiwNzvPceyckTfmB+Tw2VQqz1ezQosI4DVCY
         hZPkDDB5e3MIBHsES+p3sTMUIhtqX62npRaOK01EriwYrofNjl5KsQRMy2BQcZhX0mQ6
         tHv/EAAAhLNp+RBXqZ+WMQlPsQeOijU2kkqodmopB9Pk6lK2Fot42/Gc+hLTVDeIcxmG
         mUk8ylufIGja3WyZRv01aQdG63oPprFpD9OMZhBnDXBkS2s4izboBVAHnPAXejxpAFip
         A7c8ntg1ro1Jmy0iyp56Vyi295FbHcINNLogVzl3aWA4deGwun31Eovd76NLsk/eni8w
         ajvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193910; x=1727798710;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mrzvyO3a3OSC4Wwsy52IiF981940PgOYxjk5hjhaV8=;
        b=NgoGIULfg6Rz9dUNFIpz7muvhXUZB2UE7b363PL0Ns0XecM4reuYRqehv0vXx2NN6A
         x0mwkIFcp9uBO9bwGaXKDc8ELZwv2G4sj+cKfOiGpst5p3V+9qG2HeB8v4ORUyO3Iba3
         +IX6wGW8nPTO0z4ylrN0oaVs2NMOiEK/veoARRO/i1B181rw7G41KyUPHBngyNGlp89k
         eLmPHWoTJ2cyoQph8kVuJjN3t+GVlTsyjBMdWrPq/ItiCoUn4vmGnpt4GUe2my/mKzP/
         hSydM+iRA2ZgytNqBlRy458DFeZ9jPz9lnN9Gl232x4HKd1/kiuj/4QkCuWzdTDNltxy
         4hiA==
X-Forwarded-Encrypted: i=1; AJvYcCUtjyTlfyVCyIUu2Y779vNI0Y+T25Q46BjWcx0SaX3dc78HctSTY2RQc8hHw4AprYGI6w7IFgeO0YaPTsavNb21@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22pbOTXn1cVrJExy5Ss1duBX48E10yloeMSqB0Ro5hmcfCSQq
	6XIrLF7TKtaMdkt/onX4A7XEsSphw+Na/Zjs63M+SkWl8sbjk4dXAjQVzj7gB3ojdXef7Ou+PM7
	BgfJbKw==
X-Google-Smtp-Source: AGHT+IHzudw4yuY6TVn3wkxP1TTkeRMZzkKGg3vBtDWeJ6Dx9OTkmU3CMNLrYRuGIpcBhRHcaPQxdK7MSPqw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a05:690c:2003:b0:64b:5cc7:bcb7 with SMTP
 id 00721157ae682-6dff270d4e8mr713347b3.1.1727193909918; Tue, 24 Sep 2024
 09:05:09 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:18 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS
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
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

The name dwarf can imply libunwind support, whereas
PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
make it clearer there is a libdw connection.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config         | 4 ++--
 tools/perf/arch/arm/Makefile       | 2 +-
 tools/perf/arch/arm64/Makefile     | 2 +-
 tools/perf/arch/csky/Makefile      | 2 +-
 tools/perf/arch/loongarch/Makefile | 2 +-
 tools/perf/arch/mips/Makefile      | 2 +-
 tools/perf/arch/powerpc/Makefile   | 2 +-
 tools/perf/arch/riscv/Makefile     | 2 +-
 tools/perf/arch/s390/Makefile      | 2 +-
 tools/perf/arch/sh/Makefile        | 2 +-
 tools/perf/arch/sparc/Makefile     | 2 +-
 tools/perf/arch/x86/Makefile       | 2 +-
 tools/perf/arch/xtensa/Makefile    | 2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b14430ab2898..ea9b2b315064 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -552,7 +552,7 @@ ifndef NO_LIBELF
   endif
 
   ifndef NO_LIBDW
-    ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
+    ifeq ($(origin PERF_HAVE_LIBDW_REGS), undefined)
       $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
       NO_LIBDW := 1
     else
@@ -560,7 +560,7 @@ ifndef NO_LIBELF
       LDFLAGS += $(LIBDW_LDFLAGS)
       EXTLIBS += ${DWARFLIBS}
       $(call detected,CONFIG_LIBDW)
-    endif # PERF_HAVE_DWARF_REGS
+    endif # PERF_HAVE_LIBDW_REGS
   endif # NO_LIBDW
 
   ifndef NO_LIBBPF
diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefile
index 9b164d379548..5c712fa2347b 100644
--- a/tools/perf/arch/arm/Makefile
+++ b/tools/perf/arch/arm/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 8a5ffbfe809f..66456aef91bc 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makefile
index 119b06a64bed..f9e270940919 100644
--- a/tools/perf/arch/csky/Makefile
+++ b/tools/perf/arch/csky/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 1cc5eb01f32b..fb0c55bf59f8 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
index 733f7b76f52d..5892bc310127 100644
--- a/tools/perf/arch/mips/Makefile
+++ b/tools/perf/arch/mips/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
 
 # Syscall table generation for perf
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 7672d555f6cd..86911b7505ca 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
 
 HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index 4664a78a1afd..d97fd00e43f2 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -1,5 +1,5 @@
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 3f66e2ede3f7..4b83e66c2dfb 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/sh/Makefile b/tools/perf/arch/sh/Makefile
index 119b06a64bed..f9e270940919 100644
--- a/tools/perf/arch/sh/Makefile
+++ b/tools/perf/arch/sh/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
index 7741184894c8..39108adc18f1 100644
--- a/tools/perf/arch/sparc/Makefile
+++ b/tools/perf/arch/sparc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
 
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 9aa58acb5564..901d74e85470 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/xtensa/Makefile b/tools/perf/arch/xtensa/Makefile
index 119b06a64bed..f9e270940919 100644
--- a/tools/perf/arch/xtensa/Makefile
+++ b/tools/perf/arch/xtensa/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
+PERF_HAVE_LIBDW_REGS := 1
 endif
-- 
2.46.0.792.g87dc391469-goog

