Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55C388385
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 23:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578862; cv=none; b=StpwxlqrgoC/+ftPBsSjrKiee0Lg1aDGApqu5ec5jrYp7q/aSzSp5X6bIU4rDxPP+3nb793IqjB+nMAk5pC4DtoNX6nhbE1XBE/FqfTX2dAddhglTLVEi6uPw2umMgcM6GGNfaL7IP7Fw2ReM9IG/BDQfdPZZgJdxrI36vmrE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578862; c=relaxed/simple;
	bh=r3BG0oLSPYciMGICd395vK2SFV+sVdRwiimHYrJFvRc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WMNius/DK0m5F8MYavEB6HkMET5R2fMsc9qHwhnpTS26QZTiAqD7YK/iy5R+YGcC2hk4s1k4o0X1keRSNqbMR0AFbshid+od95GaohMmx74jFjzAPmJccaOKiJ27ItR7/u24R/hIdsYFiPkacxYuVN1KqgBW5KGfvGLUB3VsESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Trlmj3Js; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Trlmj3Js"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdd4ce8dc3so27564493eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 15:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772578859; x=1773183659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JiZo9yNC/DMiqxyM/R63ivjQXmVcbfTK9Za74i9Ki3w=;
        b=Trlmj3JscJsVCuCNRYRZON+eeOl6nfQEQgKL/v6nxaWTxCmVpQUPE5PivWY7fJk1fd
         cHGFaNPB07dOL/E8E+WJOsrfIUFk7JZZTqYEaw1QlJANWbLG/AKwa7NnRlus8H8Q29Vu
         gTo1Aje6DMF5M4f2YJV5cj6TDkwuYxtDLhY/9Bva2SkepZ6GSXjHd2AEqazWh329INzy
         CF569qOfUTNhPJKCgXvEnvomYdHDQP4lrUptDUA9jHnAP6HAQKYR13iuPsDb/XZpIvTe
         SvrArrfVIRo7hM22sR4sbAZ43jainFA702t5PCptTysezrHgUYk1mJK+Ozfp0WMDpG6x
         ISnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772578859; x=1773183659;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiZo9yNC/DMiqxyM/R63ivjQXmVcbfTK9Za74i9Ki3w=;
        b=nlDHS2nxjkbIRjt9gLqFOat157+V16Krza9DOUqr0adofDNjkYpRcxDrZuJKRB5U+A
         HFFrykV81i0dOsxlucnt5+y1jydw0jfrcUc9sZLgyBBLcSpXzUmEKfIDpuDzEuW1dKAQ
         lxJgti+7p/OmSyY3ool7hKqcVySw4gzaO+rJ3nkZ1zzucwu/2CtZqBnxiUnP+15FTApi
         By2b4syGQuGkUFPdT8iR8QOxI5pp2wGf+mC1MP0Qjz+fx3mQ4vauMhVpLogPlXxGc5FN
         BIGKDsI7OlspGeSMgVbnatTgxMEXqWQZ3POn3KHF6rutYNxT0gmPeXA4QS9GjMxYwxJj
         PceA==
X-Forwarded-Encrypted: i=1; AJvYcCWzwg6JOHgoPCWkvFcP8DoyqHBM+X1Ztpedl+F+DkNNuiGc7zRSNg/f852tcv4RnOkPeJYUndxeLLVmklRsCrB6@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkEEgh9+w/m+doxBR1KPcVwDh6oC0d0pdDGE7LhoITXASWOgV
	YuCtWAI5qz3XeJkHmjjbKiA5ehcrysmSrLwFPDiGO6ZOr5EX+yGEr+S54F7z+Slyfqfxig==
X-Received: from dybrc12.prod.google.com ([2002:a05:7300:d80c:b0:2be:1e24:487d])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5b88:b0:2be:522:2edf
 with SMTP id 5a478bee46e88-2be0522336bmr4393185eec.39.1772578858899; Tue, 03
 Mar 2026 15:00:58 -0800 (PST)
Date: Tue,  3 Mar 2026 15:00:54 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303230056.2074898-1-pcc@google.com>
Subject: [PATCH] perf llvm: Specify features="+all" for aarch64
From: Peter Collingbourne <pcc@google.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Collingbourne <pcc@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is consistent with what llvm-objdump does (see [1]) and allows
the LLVM disassembler to disassemble instructions not in the base
instruction set.

[1] https://reviews.llvm.org/D127741

Link: https://linux-review.googlesource.com/id/I52e4fef18d2e12b45f875231fa9d3efff2538fd4
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 tools/perf/util/llvm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 87fceae8488a7..44eff99970fe2 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -153,11 +153,17 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 					  /*get_op_info=*/NULL, symbol_lookup_callback);
 	} else {
 		char triplet[64];
+		const char *features = NULL;
 
 		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
 			  args->arch->name);
-		disasm = LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
-					  /*get_op_info=*/NULL, symbol_lookup_callback);
+		if (args->arch->id.e_machine == EM_AARCH64)
+			features = "+all";
+		disasm = LLVMCreateDisasmCPUFeatures(triplet, /*cpu=*/"",
+						     features, &storage,
+						     /*tag_type=*/0,
+						     /*get_op_info=*/NULL,
+						     symbol_lookup_callback);
 	}
 
 	if (disasm == NULL)
-- 
2.53.0.473.g4a7958ca14-goog

