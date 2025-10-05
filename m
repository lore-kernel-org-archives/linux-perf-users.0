Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336762C0F81
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699355; cv=none; b=DAqFr4VDWMdIEGD0hEpaXieNBauLl42PrSpAhifZ+1nySfZnEJUbHZdB83cEUsbwShktr+cjWqIf9a5eCCE81/xe6qHTJquD0UZNmRSJmw6Y104Gu4YBnpXJWaoKi1Fc6rW8zAZEYA9ObCi+kaj1tAxyGy4811TdspGbgKtivkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699355; c=relaxed/simple;
	bh=WlZay7JBScKarmUmUW5W4rt0ZQNci9N/og2V+ODkwEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pEWwu1zWSbPHX+wEXkM1ZspYdKyUeMFfGtMGTvvKNEyoYZbXTU6H0NZG5cgQ1vuvYYtbupqcbi4uC7J5wfIx3voT4BrRxQWy25GbxzkZDCwXfDF6xNEHJM5CBz3X5aeNsVMaGcN4jS001lc841MasLRVQJIxef2XZ5J2vf0l5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rfF4aoE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rfF4aoE"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b552f91033cso4977700a12.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699353; x=1760304153; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wulS2NGvKURng0Egd2IGwMyFIkt/Pg3ipSmNBN6RrB4=;
        b=0rfF4aoEG5vsKg6z2lCfbHy9iPfb3X2nhejGwhUaXIG+h+SpERjF6P3elhAr+nDhsJ
         EI+/RtNRXreFDg1y7vX6uhLARYWQ8i73rqKfCIdzaEGERKx4bzk9jM+PCiR8xyQcNLAj
         7OgXIMiGWKGxbBOcj1ojnO9rngadVW5aToVN0KJZCmMDqLNccZc669fZW1qrcJ5fNwQh
         YUaeI/XpU/eBqi+wJdyv+74rhGSWTduWYAXfpJ6NscnPSa2w28lLEk6RFiOY/37pRwBo
         lKHJaTxfFP5DrjF6+bpC+yk2eutH5/jeBPPsCoWzT+ASCGba4BQ8ghdT3zkzJn/xGZKu
         Ed4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699353; x=1760304153;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wulS2NGvKURng0Egd2IGwMyFIkt/Pg3ipSmNBN6RrB4=;
        b=bsKmsfsnxX6rsezPS5f1+U8u0jRgOvmxOauRqeak/XLQSTOe8XxkZeb7rUxCTpmMVm
         nnGXuz56yRSq/p831dErhQL2DC1Vg8FSzslBTGfNCNQcU4Cd4itgNrx8T6RigEaHMQW+
         a8menBi93tXdAHUWGsK8DjXg3Hy9nf+PHFUqU25xGWkqJouoJztOnpYY5jOM9gtXkh3I
         s5pVS5l2Zr5h4o4uri6E03dVQJ974wTJA6XFPPt23W4iRiGkSbVpxuV20ejFRNV+QWdC
         LaP07WZs1NZVZAGKX3qBeWTda91bShXwO9g5NLBzrPns03Kd9tZc13m+uRhMmGiNAz9h
         uCYg==
X-Forwarded-Encrypted: i=1; AJvYcCWeyJxmWk70J/95f4frF3eJ5oe0x4Xfsx9NH4XHjeWPhzqISSvLzqzW4Cfz5aGGge2W5xOHbgNNPvrB91OX0VR/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68deEk5/b1BYsp8kLu+pdHBqcKDLOBJohSsFkfK/1zK2iJPcB
	6x5wxODqIBTjbodLkypTwgFvNKK7lb7MUKz1HejUGA2pdA7v730qArZ14f5hm2x3KWZShdo7tQd
	4CALhCtv+bQ==
X-Google-Smtp-Source: AGHT+IGisVDrX4jLxBH+/IAg/iMlAvXEniLcqb7zAD7YH4cEtUgSeVtwpZqI4UICoBZYGGFSpiSyYOt983pn
X-Received: from pgnr5.prod.google.com ([2002:a63:8f45:0:b0:b62:8092:7d58])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f90:b0:2c0:227b:13ea
 with SMTP id adf61e73a8af0-32b61e5c57emr14386613637.22.1759699353384; Sun, 05
 Oct 2025 14:22:33 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:07 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-7-irogers@google.com>
Subject: [PATCH v7 06/11] perf disasm: Make ins__scnprintf and ins__is_nop static
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
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

Reduce the scope of ins__scnprintf and ins__is_nop that aren't used
outside of disasm.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 6 +++---
 tools/perf/util/disasm.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index e64902e520ab..50b9433f3f8e 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -247,8 +247,8 @@ static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name)
+static int ins__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
 		return ins->ops->scnprintf(ins, bf, size, ops, max_ins_name);
@@ -828,7 +828,7 @@ static struct ins_ops ret_ops = {
 	.scnprintf = ins__raw_scnprintf,
 };
 
-bool ins__is_nop(const struct ins *ins)
+static bool ins__is_nop(const struct ins *ins)
 {
 	return ins->ops == &nop_ops;
 }
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 2cb4e1a6bd30..09c86f540f7f 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -110,13 +110,10 @@ struct arch *arch__find(const char *name);
 bool arch__is(struct arch *arch, const char *name);
 
 struct ins_ops *ins__find(struct arch *arch, const char *name, struct disasm_line *dl);
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name);
 
 bool ins__is_call(const struct ins *ins);
 bool ins__is_jump(const struct ins *ins);
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
-bool ins__is_nop(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
 
-- 
2.51.0.618.g983fd99d29-goog

