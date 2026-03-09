Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01140148E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078967; cv=none; b=NofLvGbvcd/KWXCtMqkg03G9aI7djvrEOhlOxIqVvGJItyka6J45Ryw6JRd6JaSjfayivAf1ILSJJIPiJgKCJP5li2EipZonhoEZTMafJc6DsPGDt/nmLeJWV1RQhkdrZVwGbWC0Qv7GAY3gOy7GAHXpYNsl6MozvlOMNMQEOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078967; c=relaxed/simple;
	bh=Srv1ikITokT9OVyx2gFl2fZqBR0h7zamS7/rBlEZHVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIbYloUU4ogT6ABI7c4il7AVPsYhYb36xz0BYar6YQUTrx4t+ZGgZQVgICH0u9mtQD/aDl5qGImC82SYB82r/6wT7rarjfsz4ubtbzd2JNBBmg6RwqjwaIq3zzv0WerR+TEQnDB11TqvMO0yn5f6YVjWFR2jkRFFv2kpOSAqpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=APEpG2+K; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="APEpG2+K"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ca09f2056so8802242d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078961; x=1773683761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS3bf96XLrwY4W7aIs+xdKEyTPWgsbIOpYmGdzST5mA=;
        b=APEpG2+KCeYIz1dHuRl7ldzSW0xmfgd/+q82tjpX7xAWbKfR5byHIHHVYMc57MDkaz
         6i6FLK5dhOkrAd4DCCN2sWwb6+LMGUe6rccILLrFRWoxE4rlTJkN6VJCbtYIhdbDnLVZ
         E6h5bwbPN1x7RvH61KhfO5YZk0ADlQkaxRxSf/aiP6/cfteogfaSqyEGv2+kcbMse1PQ
         K5YXochunxONnbPzqwyO2+CQS1gNPjbwjnaHJ1b4hiLYISxHGPbuiXT1uXYsJx2h6/zF
         KJJV/eR8KBX8sthup01ELzWZ1E4LmEt3CTZFgIf24QO1g/pQHYR6AA8cTElruLyjAqID
         KcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078961; x=1773683761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lS3bf96XLrwY4W7aIs+xdKEyTPWgsbIOpYmGdzST5mA=;
        b=kBqfTq+AE6CrVSy77GhDo9uUpTnkRqGCsqPyl7Rwcvv12aJ7HIxyVuvbhRCsLpM4zY
         5t8egl7kfiTxcWJL5XDeh/Ry/E4fSuhuvZtMWnSft3USSi26+0/wxjrvSKdSUWOZUtlL
         BeanQ1DEOCrXKMQpZdtCC9x3rxiehnbgrIhdkVNmApQhpZyIuoEE1ceRYiulxHs+ji/T
         ULbgSyrYGRLLn/g1sBb4f2dbRJhJxiG4B/MvQouU9yfdlon4YgO75rEU7/ffxNabEch7
         2kGWrxN6BtuOfBNODt7iKGCoO5HAmz6aOpaPlEqSarYz0goN+vZJrcgMPtHdMXnzGh4+
         8ctQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJJuvEg+pn1RRbT3XnYAhL805MNsSuNlf3LujEacrHCdEN8/BbJa3Fxj00wB47FNJ7VgtUwNYET0GSokoYOA/4@vger.kernel.org
X-Gm-Message-State: AOJu0YzODgH8Yv3Fn74CSCdT9Bd/MB4t8QMmfJvHngvaz/AWf+OC7Hmk
	wT0Sk6VRRZQNsypQg6u3tp+LIqK6dJ6yQsKJQ4B5QzA54VdilLWxIaRrySljzPkcTg==
X-Gm-Gg: ATEYQzwKibrV2LlrDeA4zZoiwYmijf7QE54Kys/vwJK/QZAP3DfiyNrnPyFWjignUYp
	y+bz2uB2AbVdfYf+icYX0ndp4SoIkfcet5/UjvKI52l3cv4Z8bn4pEBJGjbWtAOWlK8RHORwtF3
	tRt+GAuaQePAP5ItBEkN30ld3fo7wmx9hyQ9oSt2uTSFc6sAAHVAa32jJv90AX0TxCl+CVmhdZ/
	mz1xsVQccFnX9yIFRFXqZu8HDXJp9YKxz13ucQX8jK/zkZEYXAuQUs/LBlackfmj/wjETEprVwi
	ed5eONBQz4J8cVk345lVMkYdlXvkT8KIa/wtgrZNa7H5vA3/XN+AOxS8+RuZ94Q/GYkO/gm6HXv
	qM2DUS3cZ4OQUiKrlyjdKD7r5S6St/Xsw0ly/0alXChgy6p08GoFGBglMFlYtlsUecHB9i6uOfB
	SVml/2hFeR/SECcnLnGVPQk/H6j9xoe2W4E2knuByvGtLHYB6UmIAqa/+X
X-Received: by 2002:a05:690e:e11:b0:64c:b44e:dfe0 with SMTP id 956f58d0204a3-64d1407f8c9mr9466801d50.13.1773078961107;
        Mon, 09 Mar 2026 10:56:01 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:56:00 -0700 (PDT)
From: Zecheng Li <zli94@ncsu.edu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	xliuprof@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] perf annotate-data: Invalidate caller-saved regs for all calls
Date: Mon,  9 Mar 2026 13:55:22 -0400
Message-ID: <20260309175546.916039-10-zli94@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309175546.916039-1-zli94@ncsu.edu>
References: <20260309175546.916039-1-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the x86 call handler returned early without invalidating
caller-saved registers when the call target symbol could not be resolved
(func == NULL). This violated the ABI which requires caller-saved
registers to be considered clobbered after any call instruction.

Fix this by:
1. Always invalidating caller-saved registers for any call instruction
   (except __fentry__ which preserves registers)
2. Using dl->ops.target.name as fallback when func->name is unavailable,
   allowing return type lookup for more call targets

This is a conservative change that may reduce type coverage for indirect
calls (e.g., callq *(%rax)) where we cannot determine the return type
but it ensures correctness.

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index eb390a253d71..df9fc0a51b39 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -229,24 +229,31 @@ static void update_insn_state_x86(struct type_state *state,
 
 	if (ins__is_call(&dl->ins)) {
 		struct symbol *func = dl->ops.target.sym;
+		const char *call_name;
 
-		if (func == NULL)
-			return;
+		/* Try to resolve the call target name */
+		if (func)
+			call_name = func->name;
+		else
+			call_name = dl->ops.target.name;
 
 		/* __fentry__ will preserve all registers */
-		if (!strcmp(func->name, "__fentry__"))
+		if (call_name && !strcmp(call_name, "__fentry__"))
 			return;
 
-		pr_debug_dtp("call [%x] %s\n", insn_offset, func->name);
+		if (call_name)
+			pr_debug_dtp("call [%x] %s\n", insn_offset, call_name);
+		else
+			pr_debug_dtp("call [%x] <unknown>\n", insn_offset);
 
-		/* Otherwise invalidate caller-saved registers after call */
+		/* Invalidate caller-saved registers after call (ABI requirement) */
 		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
 			if (state->regs[i].caller_saved)
 				invalidate_reg_state(&state->regs[i]);
 		}
 
 		/* Update register with the return type (if any) */
-		if (die_find_func_rettype(cu_die, func->name, &type_die)) {
+		if (call_name && die_find_func_rettype(cu_die, call_name, &type_die)) {
 			tsr = &state->regs[state->ret_reg];
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
-- 
2.53.0

