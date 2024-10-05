Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136518CBEC
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158228; cv=none; b=X7anY7PnVWVzT00F4b+w8UOnaI1RUdK7mwdePSv/T+Cpjnvo+gCyH7jJAoIrEO4Csmus0luePkaCJoY053I+utSeQGrb8b23zob/0+P62z+Bs2ooA513z+1tOLEIhkzpilzH95iDRiuI+acdUl1uqs132Cn//T66Ty9gK4a4chc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158228; c=relaxed/simple;
	bh=1/eilS3aKIVw4rN484yjxzHSBP1TB/2GhMWJ1EUyEi4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oQw+xRQXnHMXZ/VI6D7b3jQLeJpjWg+P/V0+GWTr97z+eNh5H+kGG+A5RUNNQCQPFHBj087oHFXdtebVf1P9qT3BHC8q8bW8Xzdbdib/4JMpQJ3OafRChStE4zvYZqcFDFwXsud394qm3GfzTcBk+MGpJKf4rNXbLyrCVRF/IWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbQqB8Hk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbQqB8Hk"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2acec0109so55184637b3.3
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158226; x=1728763026; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSNh7O2trPUtVrtwxznrhYE09HyCzuCy8rukfDtx/KY=;
        b=TbQqB8Hk7SUNrHD3kla2nJh/36C8hN+xsB36nd+CY/RYznXT4XgCK44qovrRmLtP00
         +1KIh7wYwbD82Ty6fE0mK5G86DOoEW+saiyVr8KketUAflMaeJo/99TbcAs68zL3g6/F
         oxB2n5T/e+E3TrGmtkxfYq4A7UZ16cLcEocgjSpvXpQTFPc0NsVQW7meQJ3zIGpoAqqr
         D8LAxQGAW1Ja7wOuIXVnxHWkvLaJy9gb4rlSc0WclhBURWXSMXao5hnwn8pD6TnkGWeV
         K1DZahNHZB2nMIjB3tPRC6sEnzvihSPUpTq9VrTCTsFFW9Hi92Db/0xtmqksf1MJZHYQ
         9fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158226; x=1728763026;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSNh7O2trPUtVrtwxznrhYE09HyCzuCy8rukfDtx/KY=;
        b=PM5e+i2J/LVEtVqC/uqJYMbboSi5154qIX3lgBqfEyHQDEdeixcVS7XbSvWBxKI8Ie
         oAYJGE7f47usICfBkxKBHn7jiLHT6dEm3r/bXajNymLPjlFNN56bV96OON2RCmSYo7um
         IJ2vdwwLa465bBRnmz5b7ssKnWUgkrwvnRYUHwFd9e+KKYeCFpk/Razgpa24B1NOCjgI
         MPsLNPZxOOMLEcbqfznRSFBCT0HD7dOQaxKaoqPMzVIsVaoPit1yP+3pPp36sT/+NMN/
         e2o/VNjG0acMmb6xdRTUBF9C2h1U8/eTxtDAs+iZfI2tw8hqIfTw6NwzzWjRFdLVlrDE
         Wmcw==
X-Forwarded-Encrypted: i=1; AJvYcCUIe0i1gsyPItI4m5bbuGbO2pJfZHpraFPjUHX8Qb0usrbKftDWuMC/GNkrnx77/N4KaROQU+6BWlamGugnI075@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBmhZgEtTHqSBcK24LmSf7ZUG23eHMvI75FUDtZSf5UurisO+
	t31sNwq7l0RCcw2GRzldQYo9eaQM1+6NrglU0Hg55pfhIN4W7GmCBEwwObpete3D2jsjvZjhrBF
	xpDZLTA==
X-Google-Smtp-Source: AGHT+IHa7tzQlt8ZfJU9HM6CpUwYm+2RPIugXPlK83fzJL4/DRA+kOB4v30bsPjrBffyPaLJb/8aQ0jYC2TM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b8e:b0:6dd:d138:d823 with SMTP
 id 00721157ae682-6e2c72adbdamr920947b3.8.1728158225532; Sat, 05 Oct 2024
 12:57:05 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:40 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-31-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 30/31] perf dwarf-regs: Remove get_arch_regstr code
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

get_arch_regstr no longer exists so remove declaration. Associated ifs
and switches are made unconditional.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs.c         | 12 ------------
 tools/perf/util/include/dwarf-regs.h |  7 -------
 2 files changed, 19 deletions(-)

diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 05fff75a8f59..28a1cfdf26d4 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,23 +32,11 @@
 /* Return architecture dependent register string (for kprobe-tracer) */
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
-#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
-    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH \
-    || EM_HOST == EM_SPARC || EM_HOST == EM_SPARCV9 || EM_HOST == EM_XTENSA
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
 	}
-#endif
 	switch (machine) {
-#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
-    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH \
-    && EM_HOST != EM_SPARC && EM_HOST != EM_SPARCV9 && EM_HOST != EM_XTENSA
-	case EM_NONE:	/* Generic arch - use host arch */
-		return get_arch_regstr(n);
-#endif
 	case EM_386:
 		return __get_dwarf_regstr(x86_32_regstr_tbl, n);
 	case EM_X86_64:
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 9dfc9abfdddd..6ee95cc69917 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -79,13 +79,6 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
-#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
-    && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__) \
-    && !defined(__sparc64__) && !defined(__sparc__) && !defined(__xtensa__)
-const char *get_arch_regstr(unsigned int n);
-#endif
-
 const char *get_csky_regstr(unsigned int n, unsigned int flags);
 
 /**
-- 
2.47.0.rc0.187.ge670bccf7e-goog

