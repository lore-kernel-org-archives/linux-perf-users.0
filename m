Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3B20E005
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865154; cv=none; b=p2AzS988eLJv11YzLtaWV1P1fUG/A5i7t/3NP6VPuPf6WbFlAG8PLZeOnnrdWoFIH+c5neTiZffZ8JoGdLBn9iTsMOiy29UP6T2FM0oDyGK2W0CW/KUuxxE52i54fd87lUvZoirKt4FSCg9ZFsBih3gfSFXSmmyMUUha+4HY7bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865154; c=relaxed/simple;
	bh=AIOFFfn1a4wuAIU5AeQadsr3Kz3VlSrCRDahCs/SE08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uSjNDIqeS3KVfbz2SQ0VO4ZUDt/t/xig8MYXzA5jpd7bJCWgRuBZudBK99xDDaEJ2DAKvJ78vfCWCN7mOcAXlYOYMA0WYxJdAlSGABoQBTwjDrT6HQdCsARPziLTo8WbVWh0OE9p4z1exmUj9waMRWt4wv4XgRsFRJLq9W4FmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXfDFLZq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXfDFLZq"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b609c0f6522so6154897a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 18:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763865153; x=1764469953; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXAHOA2dBofuW+6TFI6lLyA+tJ+ZKr1M8T35iNKkIls=;
        b=XXfDFLZqh3krUEJTkvTa1k5sRR5Exi2Ty3SkmnThFi2GRuHQ0Udq78impI+V7Tt+KR
         GsLm87EoXhu+rMJj56AJjjzKZXNvoP6yeYxJgbu/w6rU+2ba7BnowLJuxgkm2g2xQBCQ
         Uy2vAc3ReN+9NUkRe2azBRM2YUbojIV3Ktzib2WpJzhEJfr6zO6BXNXUXEx5SjmgPF4S
         M4Lc3hosIYtFydUmAiKuGLgbeG5FK4rKnl5Y9GzLNiVFdLnoPoMm7RlTw2G/DtALtzio
         1raBfuPFMwu0sKRncPAwybZEzuY8UROj3eL6nZXFhmlqbOEi/kmV4ZCRFfi61VQ9cD12
         Sr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865153; x=1764469953;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXAHOA2dBofuW+6TFI6lLyA+tJ+ZKr1M8T35iNKkIls=;
        b=Qv0PHnsC9K2kb/SDjNRinYrr55Mkxkcmo3R+SUtaVOgH/CNmPKMLZaLGK4BURXBBIL
         VoWFZAdSRRKlMHVYfNXukDnlYnF0lVuwsYpK7W3B34HFWBhihRq5jk85ZjNuLjdhQL9/
         Bu/0hf8rFba4IPmgtt+Ck0hr+ipP5PnJY4W6aKfLJ90CB1FO4vNS/VtusfgKAT+aN1d6
         sgarB7msldzovrK2XClqEFAMrpDKV4O7KIdNurJahmjCoYtkC3olWBMUi6gEdM9SdTrx
         FgJ5umt9J2AZDnuHKRoYAm7vULgZqH5AFRQvWIytaGRs7/RVxlHEX7hdxo6f3oBWGrOq
         Rmpw==
X-Forwarded-Encrypted: i=1; AJvYcCUowbqZLgJrZTYkVLIRk43sOBjak4Yys8gABJHC4WIY16cLPg1kpUQGM3f55MfmDs6YiiN0GYJDH+F30JkAbpwP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/1wvQ2pT8b5e7KXYiYK/cMnUjixBCRKhklK3VkvNHkbZR3+x
	opO2I/aYVrX+L1j0s6YBJZeAo7rk4w4qIoGtyj3gO/nImuvsi6+UE+lzt4ynLSB2xkIPrbyNzqN
	zRHJkU8SXIA==
X-Google-Smtp-Source: AGHT+IG0+th98zEo0nte2Be3vxkhSzkU0BgoA2iKtM/9oG06MZQAnFG14NRSDuqKLCrKOcFqPu/aKHUiUa70
X-Received: from dlbrh6.prod.google.com ([2002:a05:7022:f306:b0:11a:26c7:567d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f07:b0:11b:aca4:be1f
 with SMTP id a92af1059eb24-11c9d712cd4mr2415052c88.17.1763865152648; Sat, 22
 Nov 2025 18:32:32 -0800 (PST)
Date: Sat, 22 Nov 2025 18:32:18 -0800
In-Reply-To: <20251123023225.8069-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123023225.8069-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251123023225.8069-3-irogers@google.com>
Subject: [PATCH v1 2/9] perf symbol: Reduce scope of arch__sym_update
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than being a weak arch function, use the e_machine from the ELF
header to determine whether to update or not. This should make the
function work cross-platform, it also reduces the function's scope.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 7 -------
 tools/perf/util/symbol-elf.c                | 9 ++++++---
 tools/perf/util/symbol.h                    | 4 ----
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 947bfad7aa59..afefa9bd0c93 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -66,13 +66,6 @@ const char *arch__normalize_symbol_name(const char *name)
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
 
-#ifdef HAVE_LIBELF_SUPPORT
-void arch__sym_update(struct symbol *s, GElf_Sym *sym)
-{
-	s->arch_sym = sym->st_other;
-}
-#endif
-
 #define PPC64LE_LEP_OFFSET	8
 
 void arch__fix_tev_from_maps(struct perf_probe_event *pev,
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 5cd4844f9bb4..629b272e0a13 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1337,8 +1337,11 @@ static u64 ref_reloc(struct kmap *kmap)
 	return 0;
 }
 
-void __weak arch__sym_update(struct symbol *s __maybe_unused,
-		GElf_Sym *sym __maybe_unused) { }
+static void arch__sym_update(int e_machine, const GElf_Sym *sym, struct symbol *s)
+{
+	if (e_machine == EM_PPC64 || e_machine == EM_PPC)
+		s->arch_sym = sym->st_other;
+}
 
 static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      GElf_Sym *sym, GElf_Shdr *shdr,
@@ -1717,7 +1720,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		if (!f)
 			goto out_elf_end;
 
-		arch__sym_update(f, &sym);
+		arch__sym_update(ehdr.e_machine, &sym, f);
 
 		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
 		nr++;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d91dc89386e2..78fb2ba69f65 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -216,10 +216,6 @@ int setup_list(struct strlist **list, const char *list_str,
 int setup_intlist(struct intlist **list, const char *list_str,
 		  const char *list_name);
 
-#ifdef HAVE_LIBELF_SUPPORT
-void arch__sym_update(struct symbol *s, GElf_Sym *sym);
-#endif
-
 const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
-- 
2.52.0.rc2.455.g230fcf2819-goog

