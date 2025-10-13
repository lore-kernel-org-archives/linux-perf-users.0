Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06122D77E7
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379388; cv=none; b=MCqJFw0iDVt+GQ3fdrL7m8nSim8SJ7j8PUH1VVDLN5tlZIMKUoMlp5c2C82aj1N2JBoNCl/7uxdIvOG0AbQvn1/W+LTYeukGGilv51J8Mv8nxDZhv+omhdzpxuD4ezUg3tXpK8tnDEA9V4keZA4NOLQYJHjXSQfHVVYY7Oa5Tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379388; c=relaxed/simple;
	bh=3BrbxhGE4yqjfkMIrwpUID8JM2NrZJ3o8ooF589Xsjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fQhAIxoCeNxwOLjPYbFln5AqHhd10BNBty9u0PsmDyC5+KE68fu+RicNKEBQnS7b8T/L0BaUm+B2saZl8CEOkbnTdMEVSLUq4ghmM8bRjLN+6OMptG72iGvFOsfe85WYhTzgaEltw9KQbf1NotW/dbpWZ1I9eudaRNxSC2lPOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CK+DZNfS; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CK+DZNfS"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8892285b436so693122985a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379386; x=1760984186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKOoHqMAU4k1gwIwyn/I5QYGpjwICe+6Dwq5OwyxdxA=;
        b=CK+DZNfSZVyu6Ohnb8WjbASIux5ClzkoIvA9BXrQpMv5qe6v3nW4fTXG8F9az0XMWI
         fzayDqYNZ/1ctAmrt596lPGQLV86Jlkf+Z9qWTFirEeZyU8L9VySSRRpwGvZIiQ3SG+y
         HTM7CiGA9s0nrgsIeXCTWxz0A8ND0Dmt+eL/12RSicEZtfLoQSwrm7HPAI/cCOh4/ESl
         T59b4WCFMsh7jWrDm7UiK1o1uaCyKVLpne0m6w3P8TQCzMjB8c8NEwWmugI0Me1BmlSR
         Odxcd0VjXXulQgIJ7O5s6xbBfGo6WLHSiBL4w4lrbXHqXpAPPvT7BVk+TvPaLQfLKEgf
         U5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379386; x=1760984186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKOoHqMAU4k1gwIwyn/I5QYGpjwICe+6Dwq5OwyxdxA=;
        b=wi6EtAcWlOd5hL2KyZCcAJSpFLU1gZmkGZ0GQ4JNplVz5shxEvFqd9MxVT/JDyvjOP
         E36rF0kNJpxyuD1Uuj95DAveYuW5eBOpSFfAjWgwJshLIktzw+HtKMWArxYdvbrc179A
         7/2WEvsXaXRmU+0290fDEKp/Ik6f1foXSnRDWH38fmnyG/h2q/EsXH0g7Ql5+6btGKPC
         Rsw43D0+lo5xgC+EOH7quKSekN4COvoEWxAJZpp2N410TyVe/hN1PWS6qumBhnEeg1AI
         nsDwvjhvfANffMMhsTUo91dUbQnMjHJuKDaqgFJ1BPCywxThCOEB3o87K6aMusBVOXdB
         +zLA==
X-Forwarded-Encrypted: i=1; AJvYcCUF3DvZEgO14Y9iBcOoJzi9wMpmPBPRDyXZDMpaOz8SgdSlMJ5bqk1hAVoMghqc5mOsIp3gPtQgTAHA0CVmezO2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/G0/cLhOm4Yy1flp86217tqRAZbmOoj7kPmKXF7l5FuNtPEHM
	Db4ogU+HXHSCa5aTUj0urpjjBcXtVR2RrgjXxkXUcNRISikepAowsWkbIF/HCil+iWfHFlpGfCK
	hsmjIhKrFow==
X-Google-Smtp-Source: AGHT+IFtj5TmlV8iuUhz1jUNMXRrn+Em++O/km8PRo7zhXilShSzUHGovoDLR+AuQa9habqMXi0sBvR21TrE
X-Received: from qknsw10.prod.google.com ([2002:a05:620a:4bca:b0:865:eaed:1168])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:1917:b0:7e3:397c:8c24
 with SMTP id af79cd13be357-883521dc1a0mr2886568285a.48.1760379385985; Mon, 13
 Oct 2025 11:16:25 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:16:05 +0000
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013181607.2745653-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-9-zecheng@google.com>
Subject: [PATCH v4 8/9] perf annotate: Improve type comparison from different scopes
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

When comparing types from different scopes, first compare their type
offsets. A larger offset means the field belongs to an outer
(enclosing) struct. This helps resolve cases where a pointer is found
in an inner scope, but a struct containing that pointer exists in an
outer scope. Previously, is_better_type would prefer the pointer type,
but the struct type is actually more complete and should be chosen.

Prefer types from outer scopes when is_better_type cannot determine
a better type. This sometimes helps pick a more complete type.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate-data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4b08331b9dd3..4b510eb29a5f 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1629,7 +1629,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 				pr_debug_dtp("type_offset=%#x\n", type_offset);
 			}
 
-			if (!found || is_better_type(type_die, &mem_die)) {
+			if (!found || dloc->type_offset < type_offset ||
+				(dloc->type_offset == type_offset &&
+				 !is_better_type(&mem_die, type_die))) {
 				*type_die = mem_die;
 				dloc->type_offset = type_offset;
 				found = true;
-- 
2.51.0.788.g6d19910ace-goog

