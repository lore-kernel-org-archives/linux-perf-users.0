Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD11F17E8
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Aug 2025 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909174; cv=none; b=b7a6NjIKbwsWAmkc/UeDAO6S2Fy89yAJEtfi4WpGgh2voVAD3pgioMzwzKvm3F97gnjPQ73RnNGmVBU5i1q6WKkqtovQM3HscSEzB8dkEjWvd3zYp8v9jd2dUOyghl5AIVCl2Ah/bL8gPz1xZICuQA1VbUg8AFF0olTdOtzIu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909174; c=relaxed/simple;
	bh=Fd29IYX/xpHAqMQkc8EyODPN9XEe5UxH0NFcKN/ROns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lqmOAq/MlxAxC9/1dmq136qd88vOmdk81uyhnFBfrgyZrEfaaz8FQnIyPXIeOG/4J622v9GowIDssy3/NFBRQiFqfA0WLfQ/ZNpur9b3X2AcQV1wqSoaG7oShRqtHLrL5fkLJwvGUN9yw15CIRlloKGiv0dxzTZESoVbVAjrfgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7J1V0/B; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7J1V0/B"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458027f67so58169145ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909173; x=1756513973; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrnABPnhnjLPpde8R8ZKcXd7aM+wSVwyXCweNa59YQ0=;
        b=H7J1V0/Bp12ff7OSD+bmvjEZQmhx5i7dN11ZlPldtnznuAVfhfNo6Ga2mJB1hwW3PA
         nTyiH8BGRtSga+niQoM3c998YG531EoNnrGmVpRUA3901rBH0ns/OuQKi4iX8GRTJeuk
         xZQBnm1QqE9R0f2cTugLVRmthEWKFD2vNX9LC0t1Pbod1dCGAJnSTd1SXv1ZP7kt1qzD
         iV5GqQlv73tZCohzsdZoY6+uqE2FMb431i3/ZGiQvNSG/61HYlkEXk327JnFgwqntaPu
         rSm6owa+veH2t0JUlLHw6Iu6uMtGT0J15SgXy+qTrBRH/hy7xHM+i/N7OwhFARXCQ0/y
         FXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909173; x=1756513973;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrnABPnhnjLPpde8R8ZKcXd7aM+wSVwyXCweNa59YQ0=;
        b=feI6xAzycsyWUEZ3Lw3qw2kj38c+OC/QnIyjtNdhRY9bFaLsHKpqfVUbDLLvsad4du
         Nagc1WsJIeDkG0bCVchcoPSd2hepAbLJPlcUcF1e/BIBFAYYiClDE1/lzxm1UeUY4tKz
         YfZthWZL8qlQJTivfs12AUbIzYZhOjFXC8hz1jWpwbibMxdGlbZcRndkDI2TOf2rtZLO
         +W8sX2X90Lt1X/aJA/Exuq6w8AxlvoC5+9+xvPamWUTk8Sut2ieW8s7zHEW20cG0ajsG
         Q+4i+xwmBS430z/NGppYJzfqAXtImV/r5A0YPrMtbHIb3LHXwr7B41oFjV53Yc+U6kaA
         9QEw==
X-Forwarded-Encrypted: i=1; AJvYcCUmtG+yhV0vegq31KilgluK63EnBct+cpcKLHE0QbfYM9F1LjSGG0j05QxTacpjsK6of8KyJi4HBKDlO6wbWLww@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhQgc8JD0h9Qnvb91U59nt098tmuy4F0OTIueUw7KmXu0VEf2
	sQzqi5AdUcq2HRAqTRDUVIEGoBfi/OtnVORiFdibXE+BgA81eD0AKTtsHEqDNacxl6sujyJ9Hjs
	ey/ZG4FUdsA==
X-Google-Smtp-Source: AGHT+IGAPuABV5wfdKDsaJ74CXJ2o+DPzp2QEHBI9R/mhtkFS1teUu4D5SJTofX9u3uOZBKi8+3TSgReDnK6
X-Received: from pljc15.prod.google.com ([2002:a17:903:3b8f:b0:243:31a:f8e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc6:b0:243:485:26a5
 with SMTP id d9443c01a7336-2462eeb70abmr66268945ad.34.1755909172541; Fri, 22
 Aug 2025 17:32:52 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:07 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-12-irogers@google.com>
Subject: [PATCH v5 11/19] perf llvm: Disassemble cleanup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the 3 LLVM initialization routines to be called in a single
init_llvm function that has its own bool to avoid repeated
initialization. Reduce the scope of triplet and avoid copying strings
for x86.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/llvm.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a0774373f0d6..a28f130c8951 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -244,6 +244,17 @@ static void perf_LLVMDisasmDispose(LLVMDisasmContextRef context)
 #endif
 }
 
+static void init_llvm(void)
+{
+	static bool init;
+
+	if (!init) {
+		perf_LLVMInitializeAllTargetInfos();
+		perf_LLVMInitializeAllTargetMCs();
+		perf_LLVMInitializeAllDisassemblers();
+		init = true;
+	}
+}
 
 static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
 				    int num_frames)
@@ -339,7 +350,6 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	u64 buf_len;
 	u64 pc;
 	bool is_64bit;
-	char triplet[64];
 	char disasm_buf[2048];
 	size_t disasm_len;
 	struct disasm_line *dl;
@@ -352,27 +362,25 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	if (args->options->objdump_path)
 		return -1;
 
-	perf_LLVMInitializeAllTargetInfos();
-	perf_LLVMInitializeAllTargetMCs();
-	perf_LLVMInitializeAllDisassemblers();
-
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
 		return -1;
 
+	init_llvm();
 	if (arch__is(args->arch, "x86")) {
-		if (is_64bit)
-			scnprintf(triplet, sizeof(triplet), "x86_64-pc-linux");
-		else
-			scnprintf(triplet, sizeof(triplet), "i686-pc-linux");
+		const char *triplet = is_64bit ? "x86_64-pc-linux" : "i686-pc-linux";
+
+		disasm = perf_LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					       /*get_op_info=*/NULL, symbol_lookup_callback);
 	} else {
+		char triplet[64];
+
 		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
 			  args->arch->name);
+		disasm = perf_LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					       /*get_op_info=*/NULL, symbol_lookup_callback);
 	}
-
-	disasm = perf_LLVMCreateDisasm(triplet, &storage, 0, NULL,
-				       symbol_lookup_callback);
 	if (disasm == NULL)
 		goto err;
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

