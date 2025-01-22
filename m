Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C1219A97
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567820; cv=none; b=Fw8SAyiHuo1/amMnsihxdJosdFUwlFxE3uv06r0kni6SYQCeAdeHYKzXZXlvtauIJI/t0p2p4MPwq4R9QohzPQf1jTqFWJ3ArAbZAMOZeI78M0x5vWiae4vc8fPRX3mG1dn/qilNRzcaGhMaBfUbpmoPGUfWoPaH5F80/VfzyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567820; c=relaxed/simple;
	bh=kDPZieV753RfxEW3g95h7KoixXzw6FB20XkbY1RgS+g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gAShi4/82zeuii1AU494BQ5G/08HjPhpJzsouaOj4oekPznDbgpQeK/6F3lyBvF34TOasxpiihLAqra5nFeRagwUppD3FLqWppHZ4+7+N0Z3YJ0Rn6NwWjfw0lnYjKMS1jOwJAb6yV/Hx8hY9khBGa5U3TGjn8ZpuhH76xotzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t71GcmpM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t71GcmpM"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e399d4ef55cso18461195276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 09:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567817; x=1738172617; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBnZLegK4hXXWUBGagpTjqGV+Qxsfz86HdVgb3CS2Ho=;
        b=t71GcmpM3Ux57i8RXCL2sW6foUTzOtvLuU/w1+So3bsOOSwXm0GoVr6eSeACLdPFCe
         8dA0HQ715qm/6/G+K+n0BgbAOU1N715Y50syTGu3d7yo9NWJ2MvKHfEehHKWQ3CNunWX
         GBD5VsWi2HrPokPcjkujgaaOyWQdWt7+0mrZhRrWoaqR5qDCCwsM8RU4REPzztROC/jG
         cbzSAOGqCN0gYvkiAT+Mwjs5eNeMT1gUCQdHOnA/0zif2FXwT3L7HydkHnygEHXN5JxB
         y35l+SarkBPsbbgA8nKH0L2fCddyoLHYRhsZ9j7Sfq5qou9zLy7t7cbJWcsd1LsRcwFY
         UmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567817; x=1738172617;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBnZLegK4hXXWUBGagpTjqGV+Qxsfz86HdVgb3CS2Ho=;
        b=t8n5nIdYUD6f18mhrapECtVMLGXy6pKERZ0HV14cs8N8eh+izKOvxujH72DsVvQO5I
         eh/JfEHz/CRHbNTzWYFo2M07VlhT+60OIuh/pr1TNUUyIcXiZzom6gIonG5r8YIllpX0
         RI552v+sEgEN+v1p2r+A7BXBzBjuwSiaAvo1J7rVR1xDNCLu1yTm83n5hom3R9wa+Snh
         LV4ega19Y+PTvYyeFots0ccqpRh7Iwt3p+VEojZhEBNZ3Lho6rwl5dAOjhSxw/AwrDCx
         Z+OPJEPf27t/MGOqny1l5OiUEbI8/0X0wkByJBtQA2KBrkPeBTJhBezEjAAecb7oT6iH
         2+pg==
X-Forwarded-Encrypted: i=1; AJvYcCXOKefJ87Ye4gLAUQ6J42XESbn0MPKwMaKUkwU+OQDKyS9Mt2nsw8XnQixb/l/HL0c1GRQGk/4SGkOl6nPJzDF8@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDtChlrOPyPOCMlqOQFmlzQXKOlkJ6G4dUtP/cpq56OeMXf3h
	i2hnasVTgfc5HXR0KA7kwTQycMl9a7pgY7d2i+UGY8O+Tk07k3Gpfwp3Iuwhef+odW3Vr3cmLYL
	qP4IcYg==
X-Google-Smtp-Source: AGHT+IGB7+rABtqUapFzM6mMVzt4bJxTdpznrcrdqGaG2ny6jkrW7YnxkjJRMXuW4bZ/it4hQr5mIhsy3+Go
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:b21e:0:b0:e39:95ea:f37 with SMTP id
 3f1490d57ef6-e57b138d496mr40794276.8.1737567817021; Wed, 22 Jan 2025 09:43:37
 -0800 (PST)
Date: Wed, 22 Jan 2025 09:43:01 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 11/18] perf llvm: Disassemble cleanup
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
2.48.1.262.g85cc9f2d1e-goog

