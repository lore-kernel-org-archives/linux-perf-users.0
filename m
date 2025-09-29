Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7028000C
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172954; cv=none; b=m1p135SMwZAvFM9e85FjygKG3t/gKitJpmCMG7XXxNsDaCud+TrdLc2IiimUgWm19lcfAp05ipyiPqZGHkb6iXm2aKaAV3yhcrD9y94MlKvAYuguFTED40a4/87gW/vmIt2a4vTnKJ4pLrAYQLtQh1jP+2YRtVD/WUhi2UYn7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172954; c=relaxed/simple;
	bh=PDbyASb6oi0nl45LtWvyo0kRcHkCyKYVr1dxxwhi2G4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZyUxyNinfyx8ks0KqepTmkiDZx62hXri7+lAO/e7ttuYGDIDVRhnn3TSyCmcmvcUAsYbktr5tdRM/IfNtvZA9hbktaBD2ynQsOCdzjdxsXEop61kevDZPH/BaqFUU+8a8qagjm051RG4Ofp6WwBHdY68j7zprYaF1vJ1F1iCAAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDwfccL7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDwfccL7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-335276a711cso4447838a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 12:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172952; x=1759777752; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLBs8A19UY4qrfPktznrRiT2oVtJL0cBY+Wi6IC10nw=;
        b=LDwfccL7uRQgfpCEQZZPD+6l7KV4Xtx9XfOYA/jsGBZe14VB7obvt+zM/snu6FkAoh
         pxIwVnd5u3VXGRj8hq1Gvh3BF3P9Oa1RRaBlcipiArqaCFlP2ZCHC6xs/8GF+NT86xOI
         +aHuHfSf33+AE+T6kNkxOFH1iF25HZ82B8oxQUhkA0acbj1PufWvpFY4Bu7Hfy7tmaGB
         Ftcg3X3/7YF6aoVmPzqGcxWOKzNFmeK6NZkFYPNLCm+PPfZ8kkjvTw8L2glDQ/n+mt/6
         aPEiPNm28p9cMLFQa3CvrpZGYW0NYNZcVersnOSVocEqmq3eG1pv1fx8yWxSBDW954KD
         XTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172952; x=1759777752;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLBs8A19UY4qrfPktznrRiT2oVtJL0cBY+Wi6IC10nw=;
        b=V1oZUr18tLFy0El8ib1zCfuqssQajQQ+U2zj6EyluVUEEjlNtSyyu7zxfnoXqvZTyF
         FWup+DQd3Ao3f3P1hix0gZfSdvtGHygZfR7/4KJKq6RM/wmuwIWh0Mbkkt4GzMLwlw9A
         C5ufSZzUrpXax7qFRfvikSo9xnS3S20Q8dVwIDV9B2WsS7hX/V6w8sZe7ycbFzeAGa2l
         1AVXMKWeNoUUOk+LzpjumKDQHBpuoo4F79COwXY3PV0gxh3+VK+zMuYYv9wEdqcP1g4n
         Ue6A1ETQhYX9B1fQh6vzTYVlIrT4NrBeW2aZCkcQ55KMlmKBoPS9CDxYlfSDunKCbOfj
         rZBw==
X-Forwarded-Encrypted: i=1; AJvYcCXRZ49SKqU3Fe9+lUVW+K5Vjwb4RaRBxDp56hCjJhO7yuoZYIl6GHcjGpd7JccH00HNqQG37sjtcdxWtXDfJLZf@vger.kernel.org
X-Gm-Message-State: AOJu0YypZ44l3eWt/LUwELYdCXK6BURnNgMc9whYm36P777xvAQiuwxb
	j6UpwvOvGF10Wj2syXfKnmnZcZcfZ1UtLov95nHdcRwj8oNmnHw3cCqPcd28dqSp//98A3SrbIG
	JjwAh7TPDZA==
X-Google-Smtp-Source: AGHT+IEAC9a1XEUOGGyjwkk2VhXg5eHtNB/otbVrKPS7fT7pgJKU6BcOUwXrzCMoVf6kg30mhKL3QelUZQIH
X-Received: from pjbsf12.prod.google.com ([2002:a17:90b:51cc:b0:334:1935:56cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8c:b0:330:797a:f4ea
 with SMTP id 98e67ed59e1d1-3342a2e73d7mr21521918a91.29.1759172952591; Mon, 29
 Sep 2025 12:09:12 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:08:01 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-12-irogers@google.com>
Subject: [PATCH v6 11/15] perf llvm: Disassemble cleanup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
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
2.51.0.570.gb178f27e6d-goog

