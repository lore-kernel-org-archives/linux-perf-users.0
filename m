Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2B280CD9
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369251; cv=none; b=WF20r9xPrejU4+Eu7CtspNPW9plA2BAgaFscEPMLEXsgt+S98ONrIG4ME+E6cIyBxv1AweOMZacocmrB4sxOqrsf/qFWSYfpvIH1Iiu4ZZ/nNLgBQJmeXVj0bqLLCQxqiFv67oCCtMG+dxdNSqoTmvs6wsY8KaLLjui2PXqMQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369251; c=relaxed/simple;
	bh=gnsE73TCHXacfNt+jnheidFzg4YPcJ5undugQ3z2NwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=f1BU1L9+I5DCyDi4+GPQ2O7GweqPL00lQaP2Bx7ZIyvjxfGdllFJpGCAFJASlWU9GK7IVypoyrL69SkB7oiX0PaBnVvWMZO3t+No3HVuoPJBhkQnDnQhQmTYY8vdDdqxhzCryTaXJx8xtzzx2pT/w0XzSS1wTtO/HrQeg8LnipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IagMytWp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IagMytWp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23228c09e14so50831925ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748369249; x=1748974049; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wXMXlAyZvUvXf8QP1+5WxcJsJtq5NumQSWOq2OgGFg=;
        b=IagMytWpsKN45fhzxWepSUd+CRqhDzs2pxtfp2UUtYhdqBxshxZIUvoqxZbMQTzamS
         zHi/7jnJ7fOgLAQSXzbgFvbESTMjxpjKVA8c4GsisElAG7Zp3v/GGKoZdBnXfMAPhJxU
         WXvrD7rCav0+IyGoD26ZiIB8Mptp5szMiLrQMHvi+Afj7U6IV+Yv95kkuXDQAhmW78+8
         C9L6olmg59yAA1Qc4suMH49TNz/xTx1501f4Fmt4YwSxFsjFVOR1t884R2rijZAAqWI4
         RctNC5r8EsrsgaLNr2+NBIUOYkMWDZkA6eyGgQ7mHrcfKEG/2vZmKuF1nIuGrDJFD0El
         bLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748369249; x=1748974049;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wXMXlAyZvUvXf8QP1+5WxcJsJtq5NumQSWOq2OgGFg=;
        b=Dh1sG+cwrdbn8TpenBNXoNB8E57X0eGmPyvfmiZWkRUaBZKlU8x6gCx6nkt2zWTm+n
         d5J13bmNALn1ELkE/pTVgGLy5jj3kK77IccKjRV+2QSfOcCzbowtLeKm34Wk/EgI9XPK
         9HTraPe4vIQNh1dvE9QNDK175yWX+UauEQ56XkweklJxvjp16T0ynjQOl2Mc311RBTl3
         6PRTPBGWqCQlHAvXNjENjWPEaSt608I53uCX02FFM38s4rxrXJ+0XvyRPbpyb4N15Cw/
         DSdKv39XVIsOq9Pgrqb9nkal1M0edlOQPoEDA6VY4V05TCMSoC1Y3pDfcvgoapv0Ougo
         l1vw==
X-Forwarded-Encrypted: i=1; AJvYcCUMmHGeHWvQqU59eQYFxjwEEGjLPYv+vPFTBWhQmv9Ygvpo+/bYkF8DhXIpTH+mi9napil4ouM2tOLfp9Q/RmZe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SNYnadn8LosFW3wkKWaL19FcEb19HwoXu3X/qS2S4ksU1hVS
	YNR1o7CGzBFRaxG2vD+A+wY+19lhP1o944rCIXRDwlYZ4gIJD52enlrWND3pzvxafGHizsjkyJ1
	j4GBPDXxl+g==
X-Google-Smtp-Source: AGHT+IEvPoU4s2ajTl/FjlJUl0arj/O3MM195pyQFg60cA88dWs1gj7e6UdnPf1MO/hOFWdqepM+jxUI6G+V
X-Received: from plkb13.prod.google.com ([2002:a17:903:fad:b0:231:6301:a4a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2347:b0:234:a063:e2aa
 with SMTP id d9443c01a7336-234a063e55bmr40374805ad.52.1748369248985; Tue, 27
 May 2025 11:07:28 -0700 (PDT)
Date: Tue, 27 May 2025 11:07:01 -0700
In-Reply-To: <20250527180703.129336-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527180703.129336-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250527180703.129336-5-irogers@google.com>
Subject: [PATCH v1 4/6] perf intel-tpebs: Avoid race when evlist is being deleted
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reading through the evsel->evlist may seg fault if a sample arrives
when the evlist is being deleted. Detect this case and ignore samples
arriving when the evlist is being deleted.

Fixes: bcfab08db7fb ("perf intel-tpebs: Filter non-workload samples")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 4ad4bc118ea5..3b92ebf5c112 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -162,9 +162,17 @@ static bool is_child_pid(pid_t parent, pid_t child)
 
 static bool should_ignore_sample(const struct perf_sample *sample, const struct tpebs_retire_lat *t)
 {
-	pid_t workload_pid = t->evsel->evlist->workload.pid;
-	pid_t sample_pid = sample->pid;
+	pid_t workload_pid, sample_pid = sample->pid;
 
+	/*
+	 * During evlist__purge the evlist will be removed prior to the
+	 * evsel__exit calling evsel__tpebs_close and taking the
+	 * tpebs_mtx. Avoid a segfault by ignoring samples in this case.
+	 */
+	if (t->evsel->evlist == NULL)
+		return true;
+
+	workload_pid = t->evsel->evlist->workload.pid;
 	if (workload_pid < 0 || workload_pid == sample_pid)
 		return false;
 
-- 
2.49.0.1204.g71687c7c1d-goog

