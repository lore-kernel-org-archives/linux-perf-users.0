Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C34185922
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158197; cv=none; b=Vq6uQdrAhZ/AsnuQV7b7KaE6HJmLY1t/5YeGtBuKgar0DDNqu4fuiCd0hex6B5/w0JDcIafhQCuZlcVrzZMxoD45QWFAPwPvEUwdLN21vMghpLXfbf/B/yaOwmPGRvbbaCI4h+2Ncb484g8ZNTzrSlDV9REljcA8/KzXyYFn0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158197; c=relaxed/simple;
	bh=sqjYeUBtOtCRSdlNzXYxYIxgSm4fv2DQ8Uitzp9jNUg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fBCof0hSFHzwMB4454Rcx7uPAgkCLbjeyBmWqlueXEtAEV8TsA/TWz6f+ydcK6wkLog44b4fms/aOF21Hns9baC4Tm2GOtyg70C3OHFWjEgrT9pVm3l65/ejfqpJ46bmR0CZXbaHbv0cB2Ej+MGXx8RxuHgwiR3uu06evomLDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxyxW3+B; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxyxW3+B"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25ccea54e0so4339943276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158195; x=1728762995; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3VGAHxB6IOEew1cgpVav9xummXJdWF/G2mjihEztk4=;
        b=XxyxW3+BBXBCuBJg7Ey2kKv+1iT8HREdPXEC6JKB4zK74PutIIU0W92mVPmAyww2dx
         chkJi/WcBljr74mG9nLiSt6hSkLwEH3ciCET0nIxGhj3R1jTmupg8Vz9zHYgyzbyl8d8
         7OgeO4S+b0rzBuWEFqEalN89CzKat739EjW8TPXv/UksaCWhFdlZcCNSsNxWlCnsHy5v
         C/8kQoZdercbQD3KEa4LT6/uXfkR1leIaXYxOC8lSXsSRCYqncSBhSvCvNdOQ5qsB+qo
         sCfdHnWfhKaiFx9WCOCM3o27XzwMjya41MOgriRMBP9gsgS0nOStU/rUH3MInA7RKHWj
         YKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158195; x=1728762995;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3VGAHxB6IOEew1cgpVav9xummXJdWF/G2mjihEztk4=;
        b=UPjW/yfvZhjpir8CFhkmApZ3eX5KLB/NfEWeIhY9pwZuPG2YYY/XrfZe81sCi+lQxs
         c+ak2LkDAyZ7C8UZW/8eclWaqoevzpt0VJuz81xY7Y6OLPab4YaiAmNL0Q6SNoVtuIRK
         qEixMmu4sBPVodDK55gOeAkKixXTGkPxJQInexUITBYFetf25Bpy+ExgSzDRtD+o12DY
         FF6YmbNoDXyWuKiZI9oeunnFFp8sRWRL98zrvFz9tG9NVxEpbki+tPoilA5FicyFlSSa
         6Mjp2d43IeDOu+0Sk/KapYl0fm3T1zoy92AZMsuZ2L/R43j3KV15EQqwc/9BvhmHGZ0v
         5n3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbv15h0j4029pccUfFK5AEmFcoajT3jpRwpSTBaTLmkO18sPFovLS2KlbysVGqO5BLeufXUO8QlwfMrKvITBLY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1VxoXmQJaUleAGPjvFXuNTtMkUVwKlR6GaXtPECox+c8jE81
	xt1AE2r4lAbblvmtW+ky3b/MZ0XOhW8R9VG47Hp0jd3EkQcAur5gGUojYPqIFpaRXv9rnLJIvJ2
	OhPzzaQ==
X-Google-Smtp-Source: AGHT+IG2eBp7Cu4lY01+7ZMESWgL5KUK/mw9BioburAuOGjyC47kH+1lSGq6Y6HvKQiIl3R4nAeP9k3OlHFV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:6902:1817:b0:e24:9f58:dd17 with SMTP
 id 3f1490d57ef6-e28936bf5d1mr12928276.1.1728158191755; Sat, 05 Oct 2024
 12:56:31 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:25 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 15/31] perf disasm: Add e_machine/e_flags to struct arch
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

Currently functions like get_dwarf_regnum only work with the host
architecture. Carry the elf machine and flags in struct arch so that
in disassembly these can be used to allow cross platform disassembly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arc/annotate/instructions.c       | 2 ++
 tools/perf/arch/arm/annotate/instructions.c       | 2 ++
 tools/perf/arch/arm64/annotate/instructions.c     | 2 ++
 tools/perf/arch/csky/annotate/instructions.c      | 7 ++++++-
 tools/perf/arch/loongarch/annotate/instructions.c | 2 ++
 tools/perf/arch/mips/annotate/instructions.c      | 2 ++
 tools/perf/arch/powerpc/annotate/instructions.c   | 2 ++
 tools/perf/arch/riscv64/annotate/instructions.c   | 2 ++
 tools/perf/arch/s390/annotate/instructions.c      | 2 ++
 tools/perf/arch/sparc/annotate/instructions.c     | 2 ++
 tools/perf/arch/x86/annotate/instructions.c       | 3 ++-
 tools/perf/util/disasm.h                          | 4 ++++
 12 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/arch/arc/annotate/instructions.c
index 2f00e995c7e3..e5619770a1af 100644
--- a/tools/perf/arch/arc/annotate/instructions.c
+++ b/tools/perf/arch/arc/annotate/instructions.c
@@ -5,5 +5,7 @@ static int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	arch->initialized = true;
 	arch->objdump.comment_char = ';';
+	arch->e_machine = EM_ARC;
+	arch->e_flags = 0;
 	return 0;
 }
diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
index 2ff6cedeb9c5..cf91a43362b0 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/arch/arm/annotate/instructions.c
@@ -53,6 +53,8 @@ static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	arch->associate_instruction_ops   = arm__associate_instruction_ops;
 	arch->objdump.comment_char	  = ';';
 	arch->objdump.skip_functions_char = '+';
+	arch->e_machine = EM_ARM;
+	arch->e_flags = 0;
 	return 0;
 
 out_free_call:
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index f86d9f4798bd..d465d093e7eb 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -113,6 +113,8 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 	arch->objdump.comment_char	  = '/';
 	arch->objdump.skip_functions_char = '+';
+	arch->e_machine = EM_AARCH64;
+	arch->e_flags = 0;
 	return 0;
 
 out_free_call:
diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/arch/csky/annotate/instructions.c
index 5337bfb7d5fc..14270311d215 100644
--- a/tools/perf/arch/csky/annotate/instructions.c
+++ b/tools/perf/arch/csky/annotate/instructions.c
@@ -43,6 +43,11 @@ static int csky__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	arch->initialized = true;
 	arch->objdump.comment_char = '/';
 	arch->associate_instruction_ops = csky__associate_ins_ops;
-
+	arch->e_machine = EM_CSKY;
+#if defined(__CSKYABIV2__)
+	arch->e_flags = EF_CSKY_ABIV2;
+#else
+	arch->e_flags = EF_CSKY_ABIV1;
+#endif
 	return 0;
 }
diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
index ab43b1ab51e3..70262d5f1444 100644
--- a/tools/perf/arch/loongarch/annotate/instructions.c
+++ b/tools/perf/arch/loongarch/annotate/instructions.c
@@ -131,6 +131,8 @@ int loongarch__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 		arch->associate_instruction_ops = loongarch__associate_ins_ops;
 		arch->initialized = true;
 		arch->objdump.comment_char = '#';
+		arch->e_machine = EM_LOONGARCH;
+		arch->e_flags = 0;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/mips/annotate/instructions.c b/tools/perf/arch/mips/annotate/instructions.c
index 340993f2a897..b50b46c613d6 100644
--- a/tools/perf/arch/mips/annotate/instructions.c
+++ b/tools/perf/arch/mips/annotate/instructions.c
@@ -40,6 +40,8 @@ int mips__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 		arch->associate_instruction_ops = mips__associate_ins_ops;
 		arch->initialized = true;
 		arch->objdump.comment_char = '#';
+		arch->e_machine = EM_MIPS;
+		arch->e_flags = 0;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index 54478cf5cccc..ca567cfdcbdb 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -309,6 +309,8 @@ static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 		arch->associate_instruction_ops = powerpc__associate_instruction_ops;
 		arch->objdump.comment_char      = '#';
 		annotate_opts.show_asm_raw = true;
+		arch->e_machine = EM_PPC;
+		arch->e_flags = 0;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/riscv64/annotate/instructions.c b/tools/perf/arch/riscv64/annotate/instructions.c
index 869a0eb28953..55cf911633f8 100644
--- a/tools/perf/arch/riscv64/annotate/instructions.c
+++ b/tools/perf/arch/riscv64/annotate/instructions.c
@@ -28,6 +28,8 @@ int riscv64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 		arch->associate_instruction_ops = riscv64__associate_ins_ops;
 		arch->initialized = true;
 		arch->objdump.comment_char = '#';
+		arch->e_machine = EM_RISCV;
+		arch->e_flags = 0;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index eeac25cca699..c61193f1e096 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -166,6 +166,8 @@ static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 			if (s390__cpuid_parse(arch, cpuid))
 				err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
 		}
+		arch->e_machine = EM_S390;
+		arch->e_flags = 0;
 	}
 
 	return err;
diff --git a/tools/perf/arch/sparc/annotate/instructions.c b/tools/perf/arch/sparc/annotate/instructions.c
index 2614c010c235..68c31580ccfc 100644
--- a/tools/perf/arch/sparc/annotate/instructions.c
+++ b/tools/perf/arch/sparc/annotate/instructions.c
@@ -163,6 +163,8 @@ static int sparc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 		arch->initialized = true;
 		arch->associate_instruction_ops = sparc__associate_instruction_ops;
 		arch->objdump.comment_char = '#';
+		arch->e_machine = EM_SPARC;
+		arch->e_flags = 0;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index c869abe3c31d..ae94b1f0b9cc 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -202,7 +202,8 @@ static int x86__annotate_init(struct arch *arch, char *cpuid)
 		if (x86__cpuid_parse(arch, cpuid))
 			err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
 	}
-
+	arch->e_machine = EM_X86_64;
+	arch->e_flags = 0;
 	arch->initialized = true;
 	return err;
 }
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 486c269b29ba..c135db2416b5 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -44,6 +44,10 @@ struct arch {
 				struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				struct disasm_line *dl);
 #endif
+	/** @e_machine: ELF machine associated with arch. */
+	unsigned int e_machine;
+	/** @e_flags: Optional ELF flags associated with arch. */
+	unsigned int e_flags;
 };
 
 struct ins {
-- 
2.47.0.rc0.187.ge670bccf7e-goog

