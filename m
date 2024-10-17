Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429422CCB4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124742; cv=none; b=m1yti+qRBg7a2u3kup7x6fFHD4kf+DFs0Tce2tNHyXqyGRvfRVGbzZb2CusIBe9D7v7Ix1DG/L7NFkRf+ksoD2nAID1+MMpTVMmEDWskcDtNb/LAlc24qH1QpayZtoT2qwvgHEXpHoS4xrtnd7+UMeHauuGgE86/pD0THQmWH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124742; c=relaxed/simple;
	bh=pjIIA43SghEugoe0WZ1k1xzKHy+DAgbM7RilvHgchP8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=I//rkl2oPBGmxzzoFQ1CIN4eRS9W05CW7U8eRcLuahgGuKXJzeLzkLWTXZp7xuR4p2ShN+xCfsptUbDYx6KLszQMKfZi+H9RKd2ryxxl7oYM2oInsl/wGAjB1WqvARpd6GUiLwbGDRiZvIetcG3mrOAr6SHr7oWbTN3LCEir26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dboPLXsz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dboPLXsz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e383ba6763so9140387b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124740; x=1729729540; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48mjrfomMuomFB22b093k885CPaCWm0H0utyyG5sq/o=;
        b=dboPLXsznIf04UTRmQcpZU5l6rbK6vkdftgtHgOsAcU7xR+TFbZU4ZunKJ358yRTvo
         Ce6kJ0lks43QHmxvsA9T1d1E3wEFrbErXC4P2O35aPBAKM4Zb0jz2wvxVh/BQscGCEyw
         6816Pn2EZlO30fmMLqaYy7jUgQSRWyqMz06GdqZw2xC8gUbWmY/Mz9iAQx8GUgpbhNNs
         dSDtEvaO6a914vzwcHLIHE9r/NOfCBzIa7nRMZz1RP9R0CE1B4KsIZA6jSReQ0M9iKUY
         IpMawDvaNfQgL1Cnb+pjHRQZuh/VqsEF2zFpz4ICBN4tOTqsQ5qU4mIC358xoeDPrkHR
         ZQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124740; x=1729729540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48mjrfomMuomFB22b093k885CPaCWm0H0utyyG5sq/o=;
        b=qsVoyyaFzNEq/FaoFL+E3gg2uu5TETvHwupwMR7qZEjb1kuib76Fx+vfynBYptjcoz
         BaMRpToaT0vX0ZZsnpaZURVpfpGWlXFZo9Q5u3jTWgMcNiNeVVXXKAEGUUkuRfpdw66C
         OTIkOtXIlUgSe4Kc1ioqtRE6dSO3wpWQE0hyQUsUsfutInOHTEfHnHGhBv8+oEo8//PD
         EM108CninD07CKdJnK++CPKo6R2e7Q41k96kVBOYObAfvnkAEWOAKSISnuvV3Z9NtEfQ
         /gEYPV1gLqpvC3N0xMg/tIx2DD+Dy7Y/HeTXmrukwv32ZtM9/qI/5MDtpEPhHtwm0bAU
         IvRw==
X-Forwarded-Encrypted: i=1; AJvYcCWvYbesy51czKVpAsdzKGer9tzO8HnZwTslN7df/0L4JvMixUD3GZOTL+yNf3IeruT+Pju4sAElVenbkbz5ptmd@vger.kernel.org
X-Gm-Message-State: AOJu0YySngFLmkKGnrohGnj29nnQCSNzU5z12YPMuwpV4zaHUKz4kA0e
	Dp+OlaZPpbi/q8IhpZT2ApCVd0DSCKZRyLla8egCRJainoRuBpYHJGLTrMZJeR5lWDcegFLZnhL
	4adYo3g==
X-Google-Smtp-Source: AGHT+IG8JiIQK8uXOvPdoaWI2mxht6B92+7n0NisCZoM8iJKAkzjyBLEa7nUOj+aZg/H9XU8lHqJJagHTx/j
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:dc4e:0:b0:e28:f231:1aa8 with SMTP id
 3f1490d57ef6-e29782bbb03mr7731276.2.1729124739976; Wed, 16 Oct 2024 17:25:39
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:05 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 05/20] perf dwarf-regs: Pass accurate disassembly machine
 to get_dwarf_regnum
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
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Rather than pass 0/EM_NONE, use the value computed in the disasm
struct arch. Switch the EM_NONE case to EM_HOST, rewriting EM_NONE if
it were passed to get_dwarf_regnum. Pass a flags value as
architectures like csky need the flags to determine the ABI variant.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c           | 6 +++---
 tools/perf/util/dwarf-regs.c         | 8 ++++++--
 tools/perf/util/include/dwarf-regs.h | 5 +++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 37ce43c4eb8f..b1d98da79be8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2292,7 +2292,7 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 	if (regname == NULL)
 		return -1;
 
-	op_loc->reg1 = get_dwarf_regnum(regname, 0);
+	op_loc->reg1 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
 	free(regname);
 
 	/* Get the second register */
@@ -2305,7 +2305,7 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 		if (regname == NULL)
 			return -1;
 
-		op_loc->reg2 = get_dwarf_regnum(regname, 0);
+		op_loc->reg2 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
 		free(regname);
 	}
 	return 0;
@@ -2405,7 +2405,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 				return -1;
 
 			if (*s == arch->objdump.register_char)
-				op_loc->reg1 = get_dwarf_regnum(s, 0);
+				op_loc->reg1 = get_dwarf_regnum(s, arch->e_machine, arch->e_flags);
 			else if (*s == arch->objdump.imm_char) {
 				op_loc->offset = strtol(s + 1, &p, 0);
 				if (p && p != s + 1)
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 7c01bc4d7e5b..1321387f6948 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -70,7 +70,7 @@ __weak int get_arch_regnum(const char *name __maybe_unused)
 }
 
 /* Return DWARF register number from architecture register name */
-int get_dwarf_regnum(const char *name, unsigned int machine)
+int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags __maybe_unused)
 {
 	char *regname = strdup(name);
 	int reg = -1;
@@ -84,8 +84,12 @@ int get_dwarf_regnum(const char *name, unsigned int machine)
 	if (p)
 		*p = '\0';
 
+	if (machine == EM_NONE) {
+		/* Generic arch - use host arch */
+		machine = EM_HOST;
+	}
 	switch (machine) {
-	case EM_NONE:	/* Generic arch - use host arch */
+	case EM_HOST:
 		reg = get_arch_regnum(regname);
 		break;
 	default:
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index f4f87ded5e3d..ee0a734564c7 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -93,12 +93,13 @@ int get_arch_regnum(const char *name);
  * name: architecture register name
  * machine: ELF machine signature (EM_*)
  */
-int get_dwarf_regnum(const char *name, unsigned int machine);
+int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags);
 
 #else /* HAVE_LIBDW_SUPPORT */
 
 static inline int get_dwarf_regnum(const char *name __maybe_unused,
-				   unsigned int machine __maybe_unused)
+				   unsigned int machine __maybe_unused,
+				   unsigned int flags __maybe_unused)
 {
 	return -1;
 }
-- 
2.47.0.105.g07ac214952-goog

