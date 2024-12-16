Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577A80C0C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313617; cv=none; b=u6Fke1vnuDumNtZ5KMm8AJ2JBPKjTo4IKQ0ZP+cX8UrAtx98tpCFWlY0B/ZllzNFTePRr5RAW5AFpZRfZR9pRcYhwLWBK4F7PDOAgj+tbnJnb6csPwsKmluPYGYk6t7cwdRCOQgxVHXGWJK2PqgpZdz5U4hjatWp0zeQeW9lxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313617; c=relaxed/simple;
	bh=6N1g9uANonuB1X5ujQfQoFLZ8OgRQZPDGmKT28hZDMg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gHbLdy7/YcbmbdkacnzDKgDQ3yLwsOZmNpoHAH6ADu4YqcteYHX1cbrfMUQapo0T4sOh4wX1Qv8B3xH6TJ0ow52c+bgSRavcM1gAaZIRaQR5J6Q0NE/+XtDsYzM3Ilsgq+M1w08XyOQM34FuutwkFuuoAJ8NVhbDkW2Wvuxr6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqCXimzf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqCXimzf"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3c61a11a40so5250112276.2
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Dec 2024 17:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734313614; x=1734918414; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvACGcoM6KJ0hrZi/+tcGlPsYcMWSS3N/4SFXVszCzA=;
        b=fqCXimzfZNOpAJwcasNf/cGSulePMvyaVFsQv39RcXGS9L901P/0NdyqMWkmLPFCcJ
         M4ZtoHiPJHLaxu0sj2Q8eZRt6tTJA65WSMOiJA2i1HRL6qFNJKskrEwkCNq4msq8Ye6t
         B6CuDkh0fr6/DHFKxEiOt9cpd3hnFaEZ2a0EbLucoTPnuBGStpIWVRbngSe5rIrbyA5G
         DJ+wOmslVOYeD5jkgoAsR7Jeq7VC4qtA6mxvodX8z38id4ecykoMBhZi+bekt4AAOuxT
         DHJs/g7Wigy0fQ9dVw9RQQdokPKgOsQeVbgPtzXu4jcI66XHswzudMG41LAeBryX0wfM
         RwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313614; x=1734918414;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvACGcoM6KJ0hrZi/+tcGlPsYcMWSS3N/4SFXVszCzA=;
        b=XrSR+aJGY4mxUYbZb2Z+ArtoQ/H6AfCHz1oMhDZxuND/yv7K614EVAkDFZ3UE9srap
         SRAo9t/ha7a3r+eykxrtfuZYjNu9d2J32AdzHw2LUvEnwsRCh+x/MBnajxzqNhq7+nkU
         rs+sjpI2oNe4S4Ez3XK3GGuIUwrlaJt4WuZE9+1A2tw0wWtqbF04wXyYHzel2rKRH5Ku
         nnCx+FiWKJoJ31sDEW81B62YEoDNrA1F5njVusse8l0liR/AVqQVWQp16AtxiJ1M6Por
         apt5/sedH0cKC1K+40PLRaTNXLhnu7aY/boFKPLWmUYtYMm9rh8iLlIsgaSA1mQUb5fN
         CBzw==
X-Forwarded-Encrypted: i=1; AJvYcCUiH32duNgHAb2OTrx4g78SOX5Gc21zVto5OQjhaIm5H8t/v6D0+hlP+V1OxUM53CXXVhGHPqpeRb69HooHyRCh@vger.kernel.org
X-Gm-Message-State: AOJu0YxgS35UUllfBgB7DZ28+VIn6CNZpHXz6cM9zRfXwndwIu+G7luw
	JpQxeLuxnQ1xNhhD8S6OdV/SgqQYs6/aBetc9CeBJM1FQkQNWOopVkXJQ84l9fxPwnE8j2mTosW
	iZaY2Nw==
X-Google-Smtp-Source: AGHT+IEJI4OnjwPwIbrmZcw/cre+ES3OYknRsW/w05Ns/lgKMyEqnXJlq9KI1hfL6zbr00Cql871xgXmUp+t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:175d:4db2:deb4:d450])
 (user=irogers job=sendgmr) by 2002:a25:adc1:0:b0:e3a:512a:dca7 with SMTP id
 3f1490d57ef6-e4349ba1ccemr5441276.3.1734313614042; Sun, 15 Dec 2024 17:46:54
 -0800 (PST)
Date: Sun, 15 Dec 2024 17:46:36 -0800
In-Reply-To: <20241216014637.304761-1-irogers@google.com>
Message-Id: <20241216014637.304761-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216014637.304761-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 3/4] perf machine: Avoid UB by delaying computing branch entries
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the branch_stack is NULL then perf_sample__branch_entries may
return NULL+1 which triggers ubsan (undefined behavior
sanitizer). Avoid this by making the computation conditional on branch
existing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 84661d950104..7b1e1c254c17 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2670,7 +2670,6 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					    bool symbols)
 {
 	struct branch_stack *branch = sample->branch_stack;
-	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
@@ -2712,6 +2711,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	 */
 
 	if (branch && callchain_param.branch_callstack) {
+		struct branch_entry *entries = perf_sample__branch_entries(sample);
 		int nr = min(max_stack, (int)branch->nr);
 		struct branch_entry be[nr];
 		struct iterations iter[nr];
-- 
2.47.1.613.gc27f4b7a9f-goog

