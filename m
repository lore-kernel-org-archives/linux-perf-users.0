Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC92C031B
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479606; cv=none; b=YR1NMgCkJw9vebN7ayPzN02pa5sU0M1kggxsT9Hq2bsKuiPFVKbNTsrQU8tuMFajVDEpqv2uEDfPoibM4RCQZ8zn6T1dQ1DYOfiaxQsdrSfNT/YCofxitb3S4i/LiijI2il9JlZOJpm4cjZ5oN/WEJiwXVJ0X5tPfcV8sFVFSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479606; c=relaxed/simple;
	bh=PnnUEuJx0jKjss4uifyewYuOFaIBO3eFZ1T/znL/tqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWY1MBlaNmC14L/gpipHagPS8c6GuGDrH49kOpzMdKH63RFPjKQyyY5ZS7jN0E7rO4uhcA0mWr3kKwoeqb9Jv5qA684pMlbyW1JLNwXuWJybMEbTUpA/5xMh+195e4ZUn5cZVHdlkggs2LajBY8eND7PrNqSegpGIwGCXlHoPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=a22DqhM9; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="a22DqhM9"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649488dc7bdso4877641d50.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479603; x=1770084403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTl5wb1AK8XRUZSHdnvm2HlirW53IlfuLRyM8cfrp3Y=;
        b=a22DqhM9vO/+zdewxZybNCmz2O+epHaw+4wNq8rlqPsijREp9zehd2QY1D4p3oml63
         xrKHZxeTx/DyQ9vZhzfnfHKQuAjPRZ2GUcWndL6P6CVaRNkcpmhS4SYkrqaWm53Z+epG
         Fn1G5t+aw7vmhxuWgCeIaEOcI/TT0Zp1OUtnEUc4oUh3oc5a4sWuwWdC03PN8wHFhM8m
         HcZXx0WTIK3IpQbCx9vIt/67Rd6VviKFjdX76A6RrTt8aocVeKW5CUqQs+3YI6GRGM++
         jtVer4nNEoB5DmN0PGoXRHdLChvfOjzsaC5aB2uYK2yuzVL9UYEPJ75DpAS+Mp03GuNv
         As8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479603; x=1770084403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTl5wb1AK8XRUZSHdnvm2HlirW53IlfuLRyM8cfrp3Y=;
        b=uvugg8TlEUl1CLyIdMDY1MSHVv5YtwaXPbdMIhmfmppwjZGnP72eidhpYvsNNxmkP5
         QpQL7NNh0k1BUsSv1lakd2SDQXpcluLRpm7TWF56xUqJm7IXF60nsZkeemcoSpk1E1mk
         rpKuN1e3tbr4AQRyC7mKdrgPYrLMIaIR5cxX8O/tURgYKvVnJPAI9Q5dpCBCluKtIx7u
         zS+oCUpKxsd53fhXOhLJXoRE6lnm7NyM3oMCcEqdJtq1dq4VxG5FWwSmOLhbliU2IrkK
         FktxX3l2NcvisAoTbvcGP1nZr1VSSOZaauFECTD5IH0d90Elg58a/VZPcpXDGGHiYvl3
         qyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg3Qo77yyhtP9Uk1MVmwlSaM31sPK8aqmLYXbHOC8DW/8XdR71UXZiSS6dxMnImdTGIRejmLLKWid4XQ7LS6zv@vger.kernel.org
X-Gm-Message-State: AOJu0YyhzTIl3cDohScBYItWJOdF8ej32oeAkqq6Kk8tRLmIoPSzUzUv
	wX2hV+BDLGZsWFjaBlPufWO+8ed3s7fcNGqaFwDNuES23tUL1n7tAsSKokvAwcRKVA==
X-Gm-Gg: AZuq6aLISatZp8MgBHuPA8mavy/yAZAppfOhiUvMaRn7v7Oq3Esn0BB+P+C1LrE63AF
	nX+Vji9aRomKy1OXZbo8qcYjkYVaPZdoeTXNvkUfRKdkjHBx1y1v3ab3IRZ6XxAfu0vcQkk/3tV
	v2POAz5ENijJFL/ASriRJOOYznB51NJ+eFQvxz4DTE2SF5IwwQOTTXp9G1MWZ2QyVr+4MtRjaFp
	1NZjksEJol3IQYFCATXUusl8QkwVQwR+EtTupMcquyH/S75fIqtuv9GU7zsLG+owoF/A24inCVI
	YU6RsBVgWbShF1uK+JnRwQqzjmuGeEmeMUEnJKeqclOTYXByhITKTHbAh3i5l2oV9FoZnA93GA0
	XLfiG0kn/iwnP8KBG6RU/+xn2KUBXYqIgZbuc2hcqZvkOKWdV78ry3Ga5ZSqt7YuZr1izVIeWOG
	b2Go0pZ1jfZA==
X-Received: by 2002:a05:690e:e8a:b0:644:4eec:222 with SMTP id 956f58d0204a3-64970d92aedmr4446515d50.85.1769479603442;
        Mon, 26 Jan 2026 18:06:43 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:42 -0800 (PST)
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
Subject: [PATCH v1 09/11] perf annotate-data: Invalidate caller-saved regs for all calls
Date: Mon, 26 Jan 2026 21:05:02 -0500
Message-ID: <20260127020617.2804780-10-zli94@ncsu.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127020617.2804780-1-zli94@ncsu.edu>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
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
 tools/perf/arch/x86/annotate/instructions.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index e033abb0667b..aba356754520 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -234,24 +234,31 @@ static void update_insn_state_x86(struct type_state *state,
 
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
2.52.0

