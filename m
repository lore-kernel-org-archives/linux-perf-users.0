Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D6952CCEB
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766391; cv=none; b=s5ooqZlwpPKhF3FPnBmTEq7e92IQVC97QiCIZpAPXv1aEnTdNKSX0fWpqHQH2sd0qAMESpKOV06zjU+GechBjm0YFBfaf2n/SEy/AVMo+E4YLt05ycAcVE+FEyvajI3QjOvZ2/eMXBHMLXfhGtYzfZEH45W1RISLyFtUfq1Ta1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766391; c=relaxed/simple;
	bh=GPdTrvCkiHU3/coaruf9IhbjFFcf1z7GDHB3eC+nIgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DL+S3OsFhts+49pplaBDhxa0vZAx4a+nVGoOWRR5iOMqlcoHYOqc0fYjjRKXQMruWM+yXIoa7NSr0boa7+EEaW7qLQ0LBr6fzD70pcNgloYju53Ir/K1GrTbG7hV5IXtZSYlmdkBZkspiCCDrln3lZg3CpU+VEqlc6uwFb6ceyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cI46M6o+; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cI46M6o+"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b6416441eso1936411a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789766389; x=1790371189; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ajb49arDbZGSllkSDDxIszaTKHNJOa78okU0Ays49S8=;
        b=cI46M6o+DhpnnuJiYG9Fh/4gS52Rev41Q8/7iZR+vE1bs37u3UPqofHerJl5pmzOHO
         jYYkcu+5RToJGiAdnrg3HvVrVZGqUFOB6D26sJcN6O9Tb3fdY+OWuABw4eWyB0jHyaZP
         FJ1UCIq45EEk/IyJ1r+iQlZF8ON+kS+3kasB3Qdf6ksdmm5F5LaB9hADJjrn6Xjit+3f
         hwSNz2DmEL/AtKvnk6Tfqm7ydGLJdOvgsCHN6O8C+mEnn0t6IDBzqNOpVVsQhdeHDmJ9
         BbpRM3A8iduOu/C/cilw7lfbK/ve5Bb8nOdmU+/3EZK+GQ2kM9PrCDv3rZMq8u9RHsj5
         anVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766389; x=1790371189;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ajb49arDbZGSllkSDDxIszaTKHNJOa78okU0Ays49S8=;
        b=pLqs0AvNOO8ij5LopOBHDlOT8jLxHGKLUYvZhMqKVlXT/FRMEUzgmZ3A0wPq6L5v0e
         iywyeCRBNYnwF93miVxEuxH3pW4LI984bdn3yytnfj5g5hxhKvguKeSOnhJf+VIGVsYE
         gS/2/QINwmafvr9NBE7aBLsf6oY8k7zmPNIE5nwTiXkNqhwqaCzkpeiraMIWe/I34tQM
         1ADIowZV+yh9wfSUX/2RD52uFhyXORpH9Mfq6u9Pg66fJHAabNh4FLsr99yYWdtVeZUL
         T4C3MjM/bubuBNDTERKezZaMnB2LQpKVPyQIGRcdwNmm3pK3mZ1KYQOMnN8QEt/XgI7H
         1w7Q==
X-Forwarded-Encrypted: i=1; AKwUvByLPbSB7g4aFb2eF1KcpY9gRFW6QUqM8yN+hTYvPLArPWljZOZf+M9reGFjzdDCMhgBiFsUOE481gOD22xOEJzj@vger.kernel.org
X-Gm-Message-State: AFuF++kUOEea1Zlf/WOOwXH79vJkUjJqWHBAiWXpxrhrHZ3lkJDx5DBR
	5flaZbnDa89vUD2mNtLeN56crVIZ1NEc8czw7sBnyv41m3ZHlEC7ftIXLrgwJtFelci2PNoAkYb
	cn7GUv6827A==
X-Received: from dleb12-n2.prod.google.com ([2002:a05:701b:424c:20b0:13c:fe05:89a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0c:b0:39e:6c68:c77d
 with SMTP id 98e67ed59e1d1-39e6c68ca07mr1266795a91.51.1789766388741; Fri, 18
 Sep 2026 14:19:48 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:19:16 -0700
In-Reply-To: <20260918211932.2966061-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918211932.2966061-3-irogers@google.com>
Subject: [PATCH v4 02/18] perf trace: Free the whole evsel_trace in evsel__put_and_free_priv
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Every evsel->priv in builtin-trace.c is a struct evsel_trace, allocated
by evsel_trace__new(). It holds a syscall_arg_fmt array in its fmt
member, which evsel__syscall_arg_fmt() allocates on demand for the
syscalls:sys_{enter,exit}_SYSCALL tracepoints and for every other
tracepoint that gets its arguments pretty printed.

evsel__put_and_free_priv() only did zfree(&evsel->priv), releasing the
evsel_trace itself and leaking that array. Use evsel_trace__delete(),
which frees fmt first, exactly as the out_delete path of
evsel__syscall_arg_fmt() already does.

The current callers are all error paths that run before fmt can have
been allocated, so nothing leaks in practice today, but the helper is
the obvious thing to reach for whenever an evsel is discarded and it
should be safe for that.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 20fffc24507b..f67557e7a254 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -464,7 +464,13 @@ static int evsel__init_tp_ptr_field(struct evsel *evsel, struct tp_field *field,
 
 static void evsel__put_and_free_priv(struct evsel *evsel)
 {
-	zfree(&evsel->priv);
+	/*
+	 * evsel->priv is always a struct evsel_trace here, so it has to go
+	 * through evsel_trace__delete(): zfree() on its own would release the
+	 * struct while leaking the syscall_arg_fmt array hanging off it.
+	 */
+	evsel_trace__delete(evsel->priv);
+	evsel->priv = NULL;
 	evsel__put(evsel);
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

