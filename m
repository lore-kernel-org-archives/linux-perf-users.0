Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37262F7462
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139100; cv=none; b=IJKjJTJQDrspNkxliuymsyAvIsextYFX30RtCtd+jWi8tIVU7EdW/VttDzyUNPoQ1yzSkkmwFBNWwXzvn+/ToUKL8E5nscXvPTETrqr3hnf5VkU+IDEGbsQlTKgVlwH0xr3gs6wkZtFuj8aaMuTGDhJczsO51AGj/D+vUaXTUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139100; c=relaxed/simple;
	bh=aIrH08/y/Z/lAxV9n78mPynZXsloFUItlzemt8D+ugs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fQ4WcRl4SCp5jbeLpB6H/FqD+8jX3hwRvdfPXaSk/rKwjAM7sjpKKhe4jgnLw0cByKxe3F398P2Qd1PCofXCV0IxOz3yzXXvB3enYxjb+mwesv7J5RCXCheb4ZENdSMTWWk4cFNkanFxQfS8U+ncMPUZ2B8AbdfOuI2UsWMGYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKSSt5QW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKSSt5QW"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-733110f4a4eso3562497b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139098; x=1758743898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3P6BaHAlTLMS5IFeUPZbOJc6tY1Tw9ZwhFGASaPvcU=;
        b=DKSSt5QWroHxZXXs7JbkfPbwvFHZa5uMziZkWeS74l7jJAMVXcTp9QQttE5ZFhhFSo
         ieujNqaMWMbuSP7SxXDiagWbTUHg0R8Tt3Xttb9MLp6x3HL0OLfOHwkfiQ8uBdvySgXZ
         pDpRojTmWGd4/djCEG11jKU8eCRinXHl0wYL2lxvTpSbiwSR9/sHOS4kc13vqVzkJS3K
         FSbZJIgEjWBOadJFJU6cR0CVQFGdyLisJVaVso0d9nMSzUR2cB4RB8qMXR7HUJ6d18OD
         /CMjX29/n57PXKXaf9h3ue3qCzjg14uJP/49t0dVipdjAMH1fAk2xo5zCA8hvLhYPSfi
         JsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139098; x=1758743898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3P6BaHAlTLMS5IFeUPZbOJc6tY1Tw9ZwhFGASaPvcU=;
        b=oEQtE/QTm+KPg8WXINbNH8Y5CfWlVfC4MUlHiJlcyKrCS6GZbmru0xIlXCmzsKa5U7
         lylbovwO0mvGIEYfGT8kvQ7oLMJbu2Sy6pG35rfHkbaLppVoFUwLMCUjlAs4up2rid8B
         YFxurIkDb+Q10hpEQ1YqwVGvsoWdbI0/RxRYVElmOr0H/rSp80brp0xFxEppWy108H9f
         /NHpuUxQVQdnQbX5dxc7LOfFXIff2/3f8lCFvbXPOIeY2ptVwnrf9eFnrCxyiagDKJWa
         RzVayHzfp8+dG6mH4Hqmqw//I0a5AzKTZVrPCDCqgW2XqmD2hClHxa6WKT4iC/Sa2f8x
         uU4g==
X-Forwarded-Encrypted: i=1; AJvYcCXz11TeLjz8PveH0IeJe9tatKzXnEPMvMt87yt0jwdZLwpyUMDXagVo9F2wDMi2YpZZh2Mu9jv5X7NJlURwHuqw@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFBogFhNzGtvg0RaBHOumehd9pAgQBzuVn+1Ba21dCfR6lrLv
	KGDbjWaudrTPaSKwtRGOc/ggyBSS5mlFwx8MrMIzMXKfaEpwmDHGUVve7V8z1n8XwIOcd/zjuv/
	x93ZKkLn9sw==
X-Google-Smtp-Source: AGHT+IGDVHCwR/ebkkI0VupWyBime1xijFWaHj0znQ9HxK/8v7g94HpHXf9Wicz8r0Su7cYSlnTECY0TYxAG
X-Received: from ywv5.prod.google.com ([2002:a05:690c:9b05:b0:71b:ff19:8cf5])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:6483:b0:729:ad49:dafb
 with SMTP id 00721157ae682-738920668a5mr33365047b3.33.1758139097843; Wed, 17
 Sep 2025 12:58:17 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:04 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-7-zecheng@google.com>
Subject: [PATCH v3 06/10] perf annotate: Invalidate register states for
 untracked instructions
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

When tracking variable types, instructions that modify a pointer value
in an untracked way can lead to incorrect type propagation. To prevent
this, invalidate the register state when encountering such instructions.

This change invalidates pointer types for various arithmetic and bitwise
operations that current pointer offset tracking doesn't support, like
imul, shl, and, inc, etc.

A special case is added for 'xor reg, reg', which is a common idiom for
zeroing a register. For this, the register state is updated to be a
constant with a value of 0.

This could introduce slight regressions if a variable is zeroed and then
reused. This can be addressed in the future by using all DWARF locations
for instruction tracking instead of only the first one.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 709c6f7efe82..3c98f72c423f 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -411,6 +411,35 @@ static void update_insn_state_x86(struct type_state *state,
 		return;
 	}
 
+	/* Invalidate register states for other ops which may change pointers */
+	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
+	    dwarf_tag(&state->regs[dst->reg1].type) == DW_TAG_pointer_type) {
+		if (!strncmp(dl->ins.name, "imul", 4) || !strncmp(dl->ins.name, "mul", 3) ||
+		    !strncmp(dl->ins.name, "idiv", 4) || !strncmp(dl->ins.name, "div", 3) ||
+		    !strncmp(dl->ins.name, "shl", 3)  || !strncmp(dl->ins.name, "shr", 3) ||
+		    !strncmp(dl->ins.name, "sar", 3)  || !strncmp(dl->ins.name, "and", 3) ||
+		    !strncmp(dl->ins.name, "or", 2)   || !strncmp(dl->ins.name, "neg", 3) ||
+		    !strncmp(dl->ins.name, "inc", 3)  || !strncmp(dl->ins.name, "dec", 3)) {
+			pr_debug_dtp("%s [%x] invalidate reg%d\n",
+						dl->ins.name, insn_offset, dst->reg1);
+			state->regs[dst->reg1].ok = false;
+			state->regs[dst->reg1].copied_from = -1;
+			return;
+		}
+
+		if (!strncmp(dl->ins.name, "xor", 3) && dst->reg1 == src->reg1) {
+			/* xor reg, reg clears the register */
+			pr_debug_dtp("xor [%x] clear reg%d\n",
+				     insn_offset, dst->reg1);
+
+			state->regs[dst->reg1].kind = TSR_KIND_CONST;
+			state->regs[dst->reg1].imm_value = 0;
+			state->regs[dst->reg1].ok = false;
+			state->regs[dst->reg1].copied_from = -1;
+			return;
+		}
+	}
+
 	if (strncmp(dl->ins.name, "mov", 3))
 		return;
 
-- 
2.51.0.384.g4c02a37b29-goog

