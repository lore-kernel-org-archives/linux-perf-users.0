Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77C301012
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465163; cv=none; b=Yrfr0e3WvSQBnlqW0n15552Yr75QwhAPDjthxjXpsGmB8xEdiV6e8pIQWGQNUM4J3HUV7ziPFaZKeEBQhAqXbTQOsdaDNFM8SOApBSm+sjjDD/Bfs9Lrswi87CLhqi38mK8Z/5mG+78BN1gC6mAjodDebzKb5boZBIy0Eh+8WME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465163; c=relaxed/simple;
	bh=38ko2KHDWi/gZ4iTRLKTLFlc37YFOdOAQ51KN2SHR0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lNhjQqv6qthDfj07WN0c+Li56Hr5HIPOtaQ6n0xwufAQJ9mSN9PUm81A0+IucOJY6tcMz+JSucrZt9jtlc0hgvVOdYe6Gp3IxUSIIUQxQEeJ1z2loKMZB94HRgI6LANfRKUkdhSd8s3PdGnlNvbzgREdxIzYGfLu/jk905KJMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FjmcWBec; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FjmcWBec"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b71bdcd037so3072208eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769465161; x=1770069961; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvPUN1XCezqfBWMGY+HqHwWXFtyxQ+bm96S5E8YV+DI=;
        b=FjmcWBechZ55hORxJFKv0WmzMe7VAe4at+kIDybZVdBZPtZUqZCaz8Sv16q4yH1JtW
         LPNzNd2cRPQ1uu/6JCF7rs9BRGGfSRuDNHT3gA9tTYz3tz9BIQyWnHHJdi++xNkdBzrs
         ZxE1U2E01S1J3bOrLyZRfKLS8NO25skCrkO8zGSv4M1CwhSn3Nw3BlnVllzY0XJwp8gf
         ogycSUl30pl5tWob3gYmtZRYkPsy2ziUZT5yycdnF16e8Nd6FXNtbTK4hhVGEv8CWnGk
         P5q4ZHvrouUts0219t4etfJBBqSBeHejC50jsg4FPsJBIJ8jr8irvfLSkcZW/xId8JPc
         SepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465161; x=1770069961;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvPUN1XCezqfBWMGY+HqHwWXFtyxQ+bm96S5E8YV+DI=;
        b=LlWobYAnfc7n88cML5ozBSIt684Lv9g4vVUgS5Tb9w436Lzmdg51QrukSchOSUhx2f
         voj1PG1LdtgK0zphVFod//oXB0rlpPXA3QfjSgIErarTIZNPI0DBivi8zMHa9B+5qahx
         Wy4j8bmHEL5O0+WQ8F31x0ukzhQKneIaclusG7f6sFFcs05zlRENN8vDbLp+SXRlbXVw
         b8hKuD4xMDwPTRTYP3/kJmnTkH7jrm96Nmat86HD/3bhuPMcCFtwpTLoo1Z38CydpigA
         3jmsj1mjtkCsWcTICdATKTqyONakSTUJhLIt90Bl4sLhkHdiIWLfz3y1s09s8SdDLvto
         J7gg==
X-Forwarded-Encrypted: i=1; AJvYcCVCOBvncbcPovcuugtQnqhG6nzBtU4EFOmwdTcmeqpfQTBEhZpdD3eOenK/8mUwezJ8dC08hlygCBWNtC7OU7Ig@vger.kernel.org
X-Gm-Message-State: AOJu0YzcbTuf/nn9pSYXsBeE//KwCW4RqAOV/AiYTdyt4B6MGXsME8w6
	D37R+HfF+ZeP7elAhag3/J/potU/xwGXb6AD87yXgJ6YmNOGVSrmd6erQKZfYEfgkNCYdYk05EX
	aWo37m7Xdcg==
X-Received: from dyaw18-n1.prod.google.com ([2002:a05:693c:4152:10b0:2b7:53fc:fbb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ec16:b0:2b7:4f83:9a84
 with SMTP id 5a478bee46e88-2b7639b902dmr2600044eec.17.1769465161226; Mon, 26
 Jan 2026 14:06:01 -0800 (PST)
Date: Mon, 26 Jan 2026 14:05:50 -0800
In-Reply-To: <20260126220550.2573257-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126220550.2573257-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126220550.2573257-4-irogers@google.com>
Subject: [PATCH v2 3/3] perf thread-stack: Switch thread_stack__init to use e_machine
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The architecture type is used to set the retpoline state. Rather than
use the arch string switch to using the ELF machine that's readily
available within the thread.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread-stack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c6a0a27b12c2..c5ce741b0744 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -157,10 +157,10 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 
 	if (thread__maps(thread) && maps__machine(thread__maps(thread))) {
 		struct machine *machine = maps__machine(thread__maps(thread));
-		const char *arch = perf_env__arch(machine->env);
+		uint16_t e_machine = thread__e_machine(thread, machine, /*e_flags=*/NULL);
 
 		ts->kernel_start = machine__kernel_start(machine);
-		if (!strcmp(arch, "x86"))
+		if (e_machine == EM_X86_64 || e_machine == EM_386)
 			ts->rstate = X86_RETPOLINE_POSSIBLE;
 	} else {
 		ts->kernel_start = 1ULL << 63;
-- 
2.52.0.457.g6b5491de43-goog

