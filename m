Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636F22A4D6
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931299; cv=none; b=gt56XgcnHGdEmzeQFZqShUX5/0JpP2r+ISRAQVLeyanG+3cGISCscD+Cz4bVmaknPP3CZRL1rM05E7pa45kLzGstVSeiGO5G3bBLD22sylrVZ+nKREwHPMgHozUR91HwV1LdFy+sn7pwP5Ce8NHui47NyM8RpS5D0/fY7FOWf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931299; c=relaxed/simple;
	bh=Erynk8+/uixEXt7BeOJQFcm6Q561j11l35I5blMdZvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Hf+2dkfpufTCoBnZF942PCBJ8S9DdddY694MwTUueHXXio+NWsVVpxgcvMopMOSzXNX6ybfmMd5EzHWAEfXn3nmdPaUmNxDygu6Sx+2MS8wjJ2Z0n8dlRmKnst2MIRTnugatQGlFkyUGAemraEa9IJxt/miB0wNjoocIkKjIyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bf8vRXlF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bf8vRXlF"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so1143024a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931297; x=1745536097; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IB6ehE4CIrRVO0upk/cDtkYMX2P2CRQHtVQu5oompks=;
        b=bf8vRXlFL73TDTj5aSdIV6q6yBtWW/K7VosyXCUI/tmOkZB8cOw+MNdpJ9ig0/NPRg
         uB61rd58BSOdrkLwVNnP+4LlhK1wra8PLzPN0rPTAQ3zMEGzgI5/qUodvPeuqKELHJvk
         J2cfRrOkxyp0VbXia5tvQGa7ewRTSLROg3Pkm1UVTuA+JfMsYTn0TZ8pQJSTjWMEixGC
         csI4tQJxzP75rEaoZydrLUsdMB4+0GvpALUPZdHlx6eA4xJb7cuk0by/QBSVgE9/hRoH
         R/Xzoa7I39jtyBCS2hTWr5D4iO6pd/jiulJt2iDuru4o7uX3u30NXJ8xXJDmuARY0zOZ
         saNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931297; x=1745536097;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IB6ehE4CIrRVO0upk/cDtkYMX2P2CRQHtVQu5oompks=;
        b=OXW9/uA9SBlzxpsXEGK+tCM/Eoi0EumyMg4ehj/Ohb8P3MrYAfIR9AspWD54skc7N0
         Fnxh6qPQ1m9JSdQGxooWlgGG0Ox4OmoHAGuLx2NEjBTrixr4layaz2ohIVpsOPH0VwP9
         Hrx8bI8FT99SPE6N+kvxJq+mc5v32DgsLck1T32ETnyejl86Bzx+NSMKos+QGpGAgI/5
         QMjVgnomMS1jnl0wG1dJI4mvuoJS6hXttzW8W8XCLwaB2mMuEkXTiVWPX3/cNnhtTI89
         /pVJbVeg4/XP211ZfDRihygifbjthi+AfXjDFsafZWln5tJMirYnZjn+OJMI6csTa2Hj
         bn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVarLf19AJt3JSd558g6Ixf6iKowXhMvzNvJNTvyR+HXhM+Ljn54nsBWRq4rB9ja2RVrjJX0eRzGCFjB46ThA7r@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtwlSzrVWA3Vx+RiQg0AvdScTPS+GRXH5oeG8xxaxVgFlPau1
	pWjqeOdP4sm4u8rUYvQ03A77pJFXfYV0tclYhw/XL5WS/tgczfESb83yehIiAntOg1Wmh06GVm8
	zVxTH7w==
X-Google-Smtp-Source: AGHT+IFSvMMY0LC4wHuomXbZ/DawwgteI1xq56I/oeBQmnsf6EEf9nYOa/akkIXnOi8k2ogjeqQdR6Ooifxj
X-Received: from pjbee3.prod.google.com ([2002:a17:90a:fc43:b0:308:6685:55e6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380b:b0:2f6:d266:f45e
 with SMTP id 98e67ed59e1d1-3087bb3e794mr1100495a91.2.1744931297373; Thu, 17
 Apr 2025 16:08:17 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:32 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-12-irogers@google.com>
Subject: [PATCH v4 11/19] perf llvm: Disassemble cleanup
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
2.49.0.805.g082f7c87e0-goog

