Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0FF2750F0
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151879; cv=none; b=XWUeyKtBe1p0eSpH/voz09uirGGTxJp6Y+2RhGjgDorLxG83pUYXOqQArAo5tQNTOGWsGaH3y8iziv1M1bOzVHd8FJhLj6AxP4xUjXjrkoWeLiKEQ3y8M+lcyzCuk5/oJPgmYomrBfTngEzRpKGrP84BQoZZJ9mJo1PYM+4w6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151879; c=relaxed/simple;
	bh=KYZlwoGa5vbIQE/Fb7QwYBnfnpW4ntT0hmF6r0Mz8BI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bs3LX1X1GFZNViYqcp1uUUiOUOiYWudlnz+X/t0cy6n9ugsIMtv8h+D7j8nv/QdMX8dCi8jYrNrqxtAUg4fKO2cRcXs616rotrlUj2X781awalCO9paribGz+7LB09NQh1vhfw2gc6SG+spCpu6QaCiWNyNa1+hE5KI4QNlRdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcPKebOF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcPKebOF"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e94dfb23622so5903516276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151876; x=1756756676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=08dXmPghU0JnpjE+T8fIsEuZwVOSefbIYQFBh5AwU3k=;
        b=JcPKebOFge+0MHBFR+6fpZPendn2HWfARdfjL9upH9aUMyo7yDOSWDiqD2/lcO+tmu
         uXKpKtlAWkVe7KHCCsMMnVeRGNP6sEr92R9mGEejEeHbWXDjOm6bU6H4t6MnRQkKbYPs
         8R7GLwVd/N4sbzP8tKfzwX/O3clmuUYY7V4bHKkkbH6etRQWrEo3w3PXCVzq2OW67lQJ
         9Wc8wfac7wNZyw6ZyrDqBrSLv7iJUMcyI6J0c7Rz40WXtpELtF6caBe9SNthViqk0Vul
         U2aBOovn4UYES880v9I6dbm4tPK5DiOHzJRkyupR1GnVHQ7U0gChF+Da8MpdJGdoPSzK
         Qz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151876; x=1756756676;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08dXmPghU0JnpjE+T8fIsEuZwVOSefbIYQFBh5AwU3k=;
        b=wQwaMzcXAU96gTbInaKr75nKZURv9JpWgylDsxrYnQVX6IpbQOrfCSAKmfk4use51Q
         ZfkDBclDwKscB0m+U+JLpbK9i5/g3NTJrn4d8A4S6iuqUYXEwUuJaCrtfN1XcLD9mavs
         gydQJRUVqCGkWl2xBS8Uh3wI3IZVY5FBqK1hvQMjo8ClDSu7owcNvUDU9NDR+iVLPU8h
         CzgElVPOUNXx1b32jyoTzeKerQqUUYD8iBOm9jCzunufFTcK9J+pgeUZqYmKY2gWkPOj
         VMbPWL1GTO2yc6JaNO676aYLA9eqLB+fwITPFtUsbYmpWrR1pI+RrcIYCe5XxwVkLq70
         leww==
X-Forwarded-Encrypted: i=1; AJvYcCX0Q8gajSnYzKjyi2a3pNGz95dYl8v0zLZbNHrFwF1PNW7QotJvXungel7CImyrbAjA7slIhIljFJ+NXfgNrr0w@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5iFsWyG7f6iqCasnZ/zLi9xXeHF0dJOxX+GF8yvlI9GTBICZ
	8d0EO+FRoZIdNCmbMWzB0izdgJhQX0BftrTDacdX0VbIN98m5wHy572rYCfLyVFVHuQ1y3LL+u7
	K9eMvaJD7Vg==
X-Google-Smtp-Source: AGHT+IE9h0wFaOrKq20+90BthWPtHEhHk8f0cNSEDfB0Ct7aebwLRpU9TQbWHL7KK18wcHahRhdmPzgdCybD
X-Received: from ybji33.prod.google.com ([2002:a25:b221:0:b0:e93:4d62:5f9b])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:120e:b0:e96:c67d:c61c
 with SMTP id 3f1490d57ef6-e96c67dcbafmr3656988276.8.1756151876619; Mon, 25
 Aug 2025 12:57:56 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:57:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195748.226052-1-zecheng@google.com>
Subject: [PATCH v2 07/10] perf annotate: Invalidate register states for
 unsupported instructions
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

Invalidate register states when encountering unsupported instructions
that modify pointers, to prevent propagating incorrect pointer types.

On x86, the 'xor' instruction may appear in a predecessor basic block
and zero out a register that invalidates the target register state. This
sometimes relates to tagged pointers and normal programs should not
dereference NULL pointers, so we assume such execution paths are invalid
and do not invalidate states for 'xor' instructions.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 540b4d0a01af..03df52a5266d 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -413,6 +413,23 @@ static void update_insn_state_x86(struct type_state *state,
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
+	}
+
 	if (strncmp(dl->ins.name, "mov", 3))
 		return;
 
-- 
2.51.0.261.g7ce5a0a67e-goog

