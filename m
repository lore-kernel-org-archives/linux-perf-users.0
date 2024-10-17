Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A118BBA5
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124777; cv=none; b=nnV15pQ95KB4Cp9F89FxpidXosJYqWbA51BztIAeFIeH//uSqhstQtHrMAmlYYsdQY6UY0j+/DX5x6cKWIm6GrsTsoPHSE9h1QOwsLYe+oofj4lQyAOEeVr2kRxb+FocqfBs97r800z/3Rhq0M5wT8eVAL9Q2msqILdZ9Spz9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124777; c=relaxed/simple;
	bh=h5ZjFR6J5gfi5loliw4Qrm4otdLI+fjevlxZlm5oU1I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=F3Ef6U8tlzEPIA8DO4N4+43HoSUPWJld/cXIT8y39n1WkqUkEdczbMCigC09kvlbijqYjRR1Fy4cNNvB5/rO0MLe9zKtC8RpT9O9316zcGci/F15e7pfp3oEaI0+nixb/bQ4dR/3uFsqIvq7PWwiE70V+tzFJ7mZgakjH5LhXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAhaN/iV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAhaN/iV"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d660a1afso9876297b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124775; x=1729729575; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNbBqi1saNqYXEAAo8guTprpDL0iavWB2aVE9Nn4lPM=;
        b=kAhaN/iVQsPEX+dLCTmBZu+PJa6xauchoYyv2xtoUJP6y5gWhHU+T5sBH2ql+ev3dy
         dFEqhlOKWZZn/hMDD30xPEjGHzZOOR77QQmQn11M1yGSTkNWQXmCUGwk8pMDac9gSWiA
         KkusRLYUSg0MaswIU/SvZ7eDgrUyzyMjkBCGxgUrcIDVQF61cTV+pDUIIidH19iJItEC
         ytlOrlgsexwcSApqro0ge9cbzyJFFj/xyNNj3swALCkvWJJBDnFtz31UoyuzhJO154t8
         uTi6UjOFbm4A9CGvybeZzKYB7d6QxuaU+4yGRvS6iUM/ZwJsVIiJyKg/yya/Tf2hZGn5
         6UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124775; x=1729729575;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNbBqi1saNqYXEAAo8guTprpDL0iavWB2aVE9Nn4lPM=;
        b=wd/PyaujX5Fy1MTuoRv8j3GE6ReLW5gqRl0Ob4ocOUrHV4h78fxnfwa64hgXyUnHEH
         EusfrNKNYUfcZWtZWejqCqXlEFM0+qYyyPAONshCQ/8rcK1fnU/7zGmCxU6O+wm6dEmz
         8g89lvPXVKuSzj327tZvFeSPDWPH2G6hHyFPwBtAsRU4j2ZSgb1PVPsAqEy27tR1/dMO
         bgngqb3dkcV88PseWa6isgGSOJZK07S0KJKfvr6grLDxoXIHeZf5SQPkYODN07RgSr3W
         u9ldnBQ/IytU+wtCkuFOOS2Mdi0APoOyCNdzjFcOE7yufnPEFTOP2c+24jVPOHBTg188
         dMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyMsHdQHnZ/yuh0j+4nWKhqmq67KO10D/scICMXAt2whX4RIgbeEDkFKeCqsN81ejo2bQXPHhUJo4B3xHj2dcy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2op2Jbl5nc/yLrVBG3bqWgT7kPglYWPNyiwDFfzhDB2loNeN
	TeQq9QMsqDB8FMpMGSuDYQjyOk2hCguUOVskJC7Z7xiAB1honxWhuveU4BYsrWwqSxhPb759XZB
	fh1jBxQ==
X-Google-Smtp-Source: AGHT+IEbHtnjVfs/XyOXwRVtcImn7Ac6sTdT7J05MnwMea9QA/h1ss5WMT/c3lNVvH8+kCZUWXSdbtC8V8yG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:dc02:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e29782c757dmr2976276.1.1729124774808; Wed, 16 Oct 2024 17:26:14
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:19 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 19/20] perf dwarf-regs: Remove get_arch_regstr code
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
2.47.0.105.g07ac214952-goog

