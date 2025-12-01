Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74626E6E4
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622532; cv=none; b=SoLeJD6w8zDUaqv4U9AIlMysP/vq2q5MStRX/x5nw5YZOGf2aXP+U964XGkB9tCXEIyuAqU9GONlST+8n5Gq8rW7wG6FeBjnI8CQbeZBdtgTnwytSLzyeLWgopM6BrCjb5jMjXosXpZ2ShoDAM/mCpYRjQWDSlmORsvRvH2S4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622532; c=relaxed/simple;
	bh=RGdmhyBYFRnGgFw20jM0roDN+95aj0Dmbo2wN7m/qV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UnCU9ZebQ680hB+D0CctwoCTyP7GJmxU9r1O9RAK6MuTbGZ5OCYfIqr/iY9OdVUYrgTcbxE3Bo1MCfhH3n20FFvZEklYAsezWR6wc+8bhM0oAoTY7uXaSjhprERKwPf1e9IqmQBIl7uKZvU9wr5t69h61UtMBxUKzhxes9rUYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4WJ96559; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4WJ96559"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc240cdb249so4157542a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622530; x=1765227330; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nuvqYDAGbb4tGYCC6QK3TUQ9PWdRvfqu3GrG0lS3IVQ=;
        b=4WJ96559VIGAaEALefJFSywyqSKX97vmrU3b8y7AuhfkssiFgamEO0w2V3IZoN04eM
         FWHhmIywjEca7SpAzKCmC0HZfLtaJF+tL5G5za4dnRd0Vc3ZXhZBYWPG6q6sJbs+ebJ3
         jEYHKaJD468Hk4CLGHTyDVCTYeJ1xkde5t6uE1OQnr1UiPdnEP5lMmLjLhAEGT4ZPXUq
         qxCneXcSHcKkI5iNFJCn2tFOmTadjMQ4k/ZAwsfbpPOK2UpBSAyJIkcTB11XXfoJFOmc
         IS0H9W5W8pTuHlBMqDBbO9yQRok0c8Haw7potcOadDRRYGu5kcAleWtxL8PhtWv9lg8K
         5LLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622530; x=1765227330;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuvqYDAGbb4tGYCC6QK3TUQ9PWdRvfqu3GrG0lS3IVQ=;
        b=buelXds7xkKSMyHqNWu48ncRXQET+w0HYpYPlGrMFLIGWIQjoxZeFPyyR6B+Q733WT
         rSQRDOfD2SQirMr5vXO9RAtI8oeamy4IQhFQA7FXUIYj+WfWFJKWBdK/eXICgj6vrQF2
         OiV4OF/pw+Uk9IFdAvpatCsdAXVl7b/efX0ioY7a/29++bXk5qoyC0U8cQLHiNytQKDK
         BLIbWvcUZ/CWEXV9q2ndJaqgt9nggd1VJh0cVkndLYEpyquRftiZhhHcfoSce5PRWkzr
         pLTyd64lqZjIbD/OA79q0T1kClucS6T10dEnFJ98Z6nITPJE52/fimoOoHsxZLiIfcRH
         DZfg==
X-Forwarded-Encrypted: i=1; AJvYcCVGU+kw6pyVcLwqIkL3HimoiC5ONCDv4WPjuiO0O/q3ThrHhofzQC3wlwvAcsfjAJU6Sp8O06vjVstWyROSsOKf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/Zmgp7bL3i4oTfRG82lmAGgXukjx+yPAk/pfTtbwARiSNABY
	cF7KOnywGojuo66yxtU2HOuGmYL4LXFd2QkWYAicwTGj06bLwxMig8SpF7yjPSZ3hdRhSsJUwcE
	koZRoY0J8rA==
X-Google-Smtp-Source: AGHT+IFFXPeFIT+moZ3s44tHExWRRKrP5myjYRtAUhgxSg5dgFVxNxqkGlXQGLrK0E1CN+rPJMvc0QOl3Lch
X-Received: from dybgu41.prod.google.com ([2002:a05:7301:22a9:b0:2a9:7031:8efc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fe46:b0:2a4:5028:342d
 with SMTP id 5a478bee46e88-2a9418914f7mr11875973eec.33.1764622529695; Mon, 01
 Dec 2025 12:55:29 -0800 (PST)
Date: Mon,  1 Dec 2025 12:55:01 -0800
In-Reply-To: <20251201205509.195451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-3-irogers@google.com>
Subject: [PATCH v2 02/10] perf symbol: Reduce scope of arch__sym_update
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than being a weak arch function, use the e_machine from the ELF
header to determine whether to update or not. This should make the
function work cross-platform, it also reduces the function's scope.

Note, the previous PPC code would compile both for 32 and 64-bit and
when _CALL_ELF==2. Similar testing could be done using the ELF file's
e_machine for PPC32 and e_flags for not EF_PPC_EMB. It can also be
done on the symbol for a non-zero st_other. Given we're just copying
the value, which would otherwise be 0, there's no need to introduce a
st_other != 0 test. The value is only used in arch__fix_tev_from_maps
on PowerPC in the PPC64_LOCAL_ENTRY_OFFSET macro, where 64-bit is
assumed.

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
index f661ea6c8ac2..99b1e060acf5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1338,8 +1338,11 @@ static u64 ref_reloc(struct kmap *kmap)
 	return 0;
 }
 
-void __weak arch__sym_update(struct symbol *s __maybe_unused,
-		GElf_Sym *sym __maybe_unused) { }
+static void arch__sym_update(int e_machine, const GElf_Sym *sym, struct symbol *s)
+{
+	if (e_machine == EM_PPC64)
+		s->arch_sym = sym->st_other;
+}
 
 static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      GElf_Sym *sym, GElf_Shdr *shdr,
@@ -1718,7 +1721,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		if (!f)
 			goto out_elf_end;
 
-		arch__sym_update(f, &sym);
+		arch__sym_update(ehdr.e_machine, &sym, f);
 
 		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
 		nr++;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 9aa0016937b7..f12bb3d0e08b 100644
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
2.52.0.158.g65b55ccf14-goog

