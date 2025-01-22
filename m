Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4751B21B9
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527172; cv=none; b=Q6wEH4KD5LBsdgHkSSDcijZd1c/T0+i0ejMEraVxzs01duVnsoSFAdKuoRroBXvNli8ilS0GhCabeHS/u0Mbhd+pZlWZRg21A7pFxbLl8r/EPUzjTo5wPKSeX3tcIPvZhq/eLD5tHm+nwPuWNLrgb8Pi6TVuscNlUqIb/E9USO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527172; c=relaxed/simple;
	bh=BfQOAR1G+at7pRYGYXzHQjPEnrcQ33cHSvtWSYC7XKw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ca0qa61+5RWTUJKiD+0uqAT96nRZUSMVjpwm2EzgkRrtaUkjdKBIoHkXLChhqpOOQzhRFBxrizq3T0q0Snh+0oZSYdZVIZjKLHX7eC6UF36UzqfoNeAwEd7n4YeLORZe2Q48h+GIexbAR6JlTokcdkflt7rrGDxZq0IVXeCKq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EO4DABGB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO4DABGB"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e53bf9e60e4so15780208276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 22:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527169; x=1738131969; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgqdWXIgH31oO69HT02RtwzG7MxuXhHOOr55YpEQGAs=;
        b=EO4DABGB9M5LH0lBfxs+nYZ3Iz/nFBetOUEARsxxJEg0B5zbSzZFbJtoAlFcpiBhYq
         oYFGSwmYzsTv6D8qdQMVbyNC9DxM2RczL3JHXtwKOWP7cKZCdF1JkQOHNRpV126iKsoJ
         t5bTwlCVRZBd8wS6k5YJyjOB8qXRxI19JMH6MSYJKLBl6ZVEN8VRb2FRCYR95ih6F3A8
         s/FUteA9lJvOxpY9sd1HSFfVOam4PMTNiIm88FHrtvrClCKj3ITkY9JjKe1D+ydTV+5v
         aoxGxWH1/2l+0WxiAsM8iwWm3EmnnAInrLuOxH8UqixMeHMkwwC6z9EHeOdb3mwbvEo4
         BwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527169; x=1738131969;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgqdWXIgH31oO69HT02RtwzG7MxuXhHOOr55YpEQGAs=;
        b=WiX2Feq4uMUMHQHNGJ6ebB2LY9yAkWdKyTqARKfRItUhTx3yzjzSc5+EA3++0ey8Gn
         yfI1VESd500YEVX5DoWJ+7yRaiAvlqlISttE1ZGdduumyEllZhXS0nCI9N8mIvq5Sf/I
         A+ppvrSlQAk7WOT77m8wDMKcMtJcz7yLfWYSC9ml4b38bJgkW0Qtts5sPsIm7bsC+SZe
         kWMF/rKG5eyWSiu3w+Ski+sZf83aIsPZl1sjfBhmNO8oQcGvmkx/MPSfpFnoJx6WHpuG
         nMnjPbyGEIYewaWcGbyGrlZPd0xSq/sdL6E7M7vtFas06FkITHAjE1siNbCotrwqJsIQ
         iodA==
X-Forwarded-Encrypted: i=1; AJvYcCUcLW5UcqFu8DoYZE1l43JeaImQLY473zLeIWEqGHWuLLgGlKtax7WK4CTRqwjgqa31RGp76tKhpNt1DeSuUWFM@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOxK/OE2+vxpGBqsdjdhmE6SCKLPPsuufqsh9taAloOjWidod
	wkdC1yAxj0gexe+KBmv9gFireZ4wBqGmG/oteuoreI3FM9CePZwGJby9luxNKtKWZW2W6kd89Lk
	GfRoiKg==
X-Google-Smtp-Source: AGHT+IF6rwzVNy8tbQ12mHzbRHmKpJHEzsK35EPLx3KJfYalflkJcjMfzIoyWZyP5IcEbo2YvBdof+rOLPE0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:3005:b0:6e9:f188:8638 with SMTP
 id 00721157ae682-6f6eb9475efmr341777b3.7.1737527169492; Tue, 21 Jan 2025
 22:26:09 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:32 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 17/17] perf disasm: Make ins__scnprintf and ins__is_nop static
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

Reduce the scope of ins__scnprintf and ins__is_nop that aren't used
outside of disasm.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 6 +++---
 tools/perf/util/disasm.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index ebd86691acf8..b2dfd40588ef 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -246,8 +246,8 @@ static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name)
+static int ins__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
 		return ins->ops->scnprintf(ins, bf, size, ops, max_ins_name);
@@ -824,7 +824,7 @@ static struct ins_ops ret_ops = {
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
2.48.0.rc2.279.g1de40edade-goog

