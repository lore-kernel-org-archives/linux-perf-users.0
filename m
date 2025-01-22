Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC01C175A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527120; cv=none; b=uS26P+CD5b9pW0Bv2to98wcmu2OIORDtPMjloftFIpyE1asmEo8hKL2uZAkqUEj3mETD8lXN1ovz0kSd00gswwlCnHVzdDuNhs0KiD8cndeJ2K2y+QQ11nS33ve+c4/Molim0y4TOIBHsMgWrNjuVMJyXv7Sjx7kq4lrgb0e1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527120; c=relaxed/simple;
	bh=fslZfMEltprSZcTKlHEcI81MzAYEcQiKGjjQrOFeeQs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VKY/V++0WNLl9R04ugFQTI/aC9/u1u7/r2aEA1iiSotBhBjb/Qd7Wxc+uIIOw3kLAZC9c3+iFarwHhSQNbj1C/f3Jctq0DQxZdJ8rxccUaGwMHyd47k7DrCHA/vXNFjZTF1cEuDFXKGzO6tVAFolk0IJH8Jn4DU8QSnztl5NeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ijyAVgO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ijyAVgO"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3fea893dc5so1439191276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 22:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527118; x=1738131918; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifAh4z9tkFouiScWwWQSL99thftn0z74dbeCX/fEfD8=;
        b=4ijyAVgOgmNWOI0u5LeNsDEhFDkMNtAzjr00Xc5nYgmBo/id2uy5pVM31oDTG03O6U
         0HYTfJVlIp21M4qY1Ala6X44oORXfL8r/uMFgFxHSJU7mPsQKONeTQ3jjQaJnlEVAkM6
         siWiBBpHmRaML1O5tvxbkEfUce+IDia6LtoZNEy90a1ekylk96CleKRzn9MRakvpu81y
         bhkTJKjuEfF56lGjesvnnrNw4L8GG+g4LCc1p4k6u7tPtPuIMwW66r29xQWQRshHw5Gu
         v21TcHET73uPCNvT7nvNuyEeVqQh5TqlgefHNSplceN9q7OWimVhq1LVsfbjMT/8GMw2
         Ekwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527118; x=1738131918;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifAh4z9tkFouiScWwWQSL99thftn0z74dbeCX/fEfD8=;
        b=oOG8NZNVg1ChGiZ3DVIj0BXFVyJnvwDz3DGe4jUeNsi9KjgpSMzx+wL+4CRQaQoMVn
         ojE3bG17C1RC2HyYefzkeaROq/cfz8MX8ojmCT95VFBlJGSaFCJ8LiUkfmn3Hv4r792Q
         s8JmZCj9hqoH7KKKWJnnQPyI+zVyqmxJfTcXAWRCOqMqC0jROLQALJz0hj26SNURCKk5
         m9BZcpH33SCMoIsGwyFGdFb0xBxb5rqcn5xgv2kSJ4567F6yufE9cDmMm5WYrnbeMWDQ
         iA/uf8uyvrKHFr3rKXgmp3gzdD69tL0+UE+WflXu7KvZWC37UXKoLm4WmOPfrASzFys7
         yLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCnXWsu4ZAd452nkoq9PmVhNDBc16Cl3311DwANfrMpnGAjDXHUh8zZkrsDhGOpZrD6lKuFFyTwNz4xJPag+Ia@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4hRtRM1W2MotSmtX2wzzI5OXNM6appsmY5WvUh0Rg2GuP7/0
	0NfCVgn68RI3UTxv7MIGjvPhNh3yzUt/wvMzBOdfF5xhRsS9+p5ksPLuHNmlZ76mC3e4Te1s62G
	Y/e31Gw==
X-Google-Smtp-Source: AGHT+IHYRcdPxQUE7RFn1o5mEQhJrq8PAszt9Jv65BlBcEciA0rf2Yi2TG/Nx4Vi1nxNKr4a7TSmsVRBAdUi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:d0b:b0:6ee:a2b0:a803 with SMTP id
 00721157ae682-6f6c98438a8mr1261387b3.1.1737527118189; Tue, 21 Jan 2025
 22:25:18 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:26 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 11/17] perf llvm: Disassemble cleanup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
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
2.48.0.rc2.279.g1de40edade-goog

