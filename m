Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763718455E
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158196; cv=none; b=ZH16H+lfpcFyP7b3Tgqt2NOe63GxYeks9hAVqDUeB+xifGaHRGSs8+j7NqqeC6vP+QFSMBAbXG5yytz3Ike0shbUb8uiyK+SyQFLFFKY113izW01AwfYjbpZHJ6o6jwnE6YKcGxTsJ9kK9KAM45+QoCtDpQZyREzLrjxiX3COEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158196; c=relaxed/simple;
	bh=ZXckq9/5rBlLdDdPjIGQW8xHKpySzPV+gMGHrENNoZg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=D8s0rQuVOK3p9JwQk1x7NX93SU1tPemLj4kvuC6+JFljvRVXkWMdtLGiofOqLUgGHm3tapulR4qmz/dpxzrFLssWGLi5PE2+7agsTJZAqNgW19tFtgHobV2RlE5R1TqQBbtqKsUA1NP2I4zeDb4Y+qdWvJNjEW8CPNHoyAVTZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T1+uWp65; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1+uWp65"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e25b39871fso57100757b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158194; x=1728762994; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2ESjB2YIGNr0kAF0x/rOVXxJN2WJ7SSqyQKEEmQuJA=;
        b=T1+uWp65CMTQrH+EuM2H41rh+/iKOFuJeCeLU3NaoD00220fTqUUyCUL8IYVOD9b8q
         QthROhhcP1fIBljIHpgDIEyFbF+B+u/C+ofIOnCJUWmfPs/gGIxtVPtqST2/EwkhaLiN
         YygXZEuSVNbCGbHC1Ye9ZCNUYZrNcHEo0peuaUTNPGrTdw03tezGnyj3zPvuCKQ1JDaZ
         SobyzjLs9lk0ppE7j2s+nRn2uxX/HA5AANpX0a4KxntG30K+c2lAdxJcSnUOpwRf3xCe
         6RWs3RY6hkEsUng/k3NWKSBRrXgr49vMoDpYI+QI1U32FIwGgCVaMMqNTUipM4DuERvZ
         3OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158194; x=1728762994;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2ESjB2YIGNr0kAF0x/rOVXxJN2WJ7SSqyQKEEmQuJA=;
        b=FBsgFjten+rsa+B2y/2Cd8Y4OVznC4K35ZNO0BUKSoIGRL1pLR4pmveI3ca/uPb+wx
         M3Jy0Cti5i8hk3MghSQIdEOrGL1Hnifex64rV3SEsOb6tqGtWAR2nP7lgTy4JIZMIJcR
         gnAHJNAXpWxx4/yDVS8WrsRMx8Ei8fc/04DG96l9fKD1RMcTett+da0GqbSeXTWGOMoG
         v2ANJAarKEtfJ4JQdHd9XZAMe00HTET6mlQaVs/pV8iJCXeqYI08gpQ5cWbGg+vHuBJy
         1zcyRDePNFgeGZpu1nfpd4a2oqrQ590wKQ7HuEb8AK1U7npreiZnRVOyWT1vxkDP2fj4
         BmWw==
X-Forwarded-Encrypted: i=1; AJvYcCViQimwOQawZ6+szRKGeTAjTjiaGfy19/iwRpQCKnImkTfNIoepIcqoUVzfqbuXW8lIVzdUpQFFaW8a7W+Fy3lk@vger.kernel.org
X-Gm-Message-State: AOJu0YxMtT1NnojG8Sv47vO52O6AkkGg27QU8uGOkhiNVQ8OQQUNETio
	wKqa4Xw00XVEfEtRI+Zh2uI2I9S7fdIZpsvbjBMFR7CZW/re7MiPXdch2nshWuAPVvWO51IBZDk
	a+QXdwA==
X-Google-Smtp-Source: AGHT+IHEbD4MRwZ2PKCjAUCVKxtlz40qrMSN6DbbdIeVTb8C/0Bd+XGDjYe2Dr3Ix5YBR4/AVrrPnEznaGld
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:c512:0:b0:e28:8f62:e735 with SMTP id
 3f1490d57ef6-e28936c055bmr5227276.1.1728158193972; Sat, 05 Oct 2024 12:56:33
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:26 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 16/31] perf dwarf-regs: Pass accurate disassembly machine
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
2.47.0.rc0.187.ge670bccf7e-goog

