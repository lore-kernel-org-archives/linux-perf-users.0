Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660098287E
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874840; cv=none; b=nIW48tgQKBLGz+mgxtraQTEytt/1oSvGnHihObNJwejC7xSgVZpByRhUKhOqJB0DkkhOiXMiGJb0tBcCPOHQFp5ayzuvFlIi+sA74X+Sy/9Lb2lCE9+E5v3rSFjDqjy7dNrpIsUtGgkg0SLUhcl3xe5n4irqfAnisWPwN2UwMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874840; c=relaxed/simple;
	bh=dmBpq3/7O/v41r+GDh+rnnlXPTGB3FAZAyg8cX0y2xw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=QOa1jKeq6l0wW4SrqA+YHIQk8x5KWrEL4tVBAzLosqvB5Ic5+/5tm1Vbzq+NU23JwuZ1K8OPf75tPwe/Ysvgak5OzbCRqVfTFRbYCBUkXmU+QvoNsJAUlBMoc5uPBQeaq4TS0OAJKnHWQVyuupTT9fxoiVJ5X+xV9JXokbg5l0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvnIkiOP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvnIkiOP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2659a7488a2so7538815ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874838; x=1758479638; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wN2iccbVuVBwktRQK01qZKdZc7wUELk9NMoe4QbKLb8=;
        b=tvnIkiOPQlZ0+J2taqiJ19RVylVtaBSwRtVHFbWDENDa3vVsycGkAhM9CQCPjbyQJH
         d75/YTw+LZm/En8iBpXHRJqto2illYNmi6GfNX+UYJYkZtTORVrsxaGIORzr2UE4q7KC
         DjQ+QztOie+S03YI2az2R0ODmClS+DDxj6XqPwm5Azobr2SCnM0p3owSP3PwKgjo+5Dr
         AVUqYK8kGcT7pEKoK1cEslQl2KuB6F1DZr2WeyLx92Oqlz/YD5qLtr96cifJoWl8fOv6
         RsUCmfLE2lccr7Y37DHIwiYCJyf/hmIFdOt69XtzETpEl3zhCETFoxB+vO74qAmWxLVv
         S/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874838; x=1758479638;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wN2iccbVuVBwktRQK01qZKdZc7wUELk9NMoe4QbKLb8=;
        b=OuKWVNcYukyd9Mdm1pZZiq1/bu6IaAvDgMzA9nJ1ETy75XZ7JTK8qWiy5G/woKlE86
         B9aSCffw+86DOOZ/Lb+xhQx5KBRC4jIjqeZIi1u1woU4LRQYKNFc0jxV3qjIhkhKSwcz
         pcDJ0G6HZoz8oe9xSqwEEVCklapeNFidgxTWdTk1+0EUGO02AiQUqi3QsVZfbQDMjHdl
         SZ8EXjh4PQbkuavfcIFqH4SpQkuZQaYcMewesidBlnJ88/KHTTmJG5VJ93HlxdpryoC1
         sMI1S+Csg49Tod+GH0FonyHasqCrfnNDIgF5WumQDtQwiWvSZtkaq+oJ2VQEu9NWwpUq
         wQHw==
X-Forwarded-Encrypted: i=1; AJvYcCXIzwCcXHfYjmjqIgcFNpk2rYaUFnGVfO7ah0NwEy/r3dTJdKIBNi4wgG/N0WbzTpaS6xRTqVwwpP1tQ8pKeNLX@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTX7PXDFZkMG75/OrlDdaJGxbA1t3fkS1LE2Hjz0aNMNdglVf
	EZGtPkZCyCA6hk1942/ZWz4IHtq5o3U5Ue5eN9CuKFG04zPz/WRALFv84NZYemJgR8Qs1GlfCWr
	jhjVuCkYKRg==
X-Google-Smtp-Source: AGHT+IF5F7RkNRcG5yv3XsFGcxWPT1s6w1jEj6xSWNSgWac2TDVnOvfsv/01vPbaqPE58WtPgrCmaFZ8kLx3
X-Received: from plkh5.prod.google.com ([2002:a17:903:19e5:b0:24b:12ba:f799])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aa4:b0:24b:15b3:223d
 with SMTP id d9443c01a7336-25d24da6cf9mr129138075ad.16.1757874838626; Sun, 14
 Sep 2025 11:33:58 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:33:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914183353.1962899-1-irogers@google.com>
Subject: [PATCH v1] perf sched: Avoid union type punning undefined behavior
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A union is used to set the priv value in thread (a void*) to a boolean
value through type punning. Undefined behavior sanitizer fails on this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index f166d6cbc083..eca3b1c58c4b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1532,35 +1532,24 @@ static int process_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unus
 	return 0;
 }
 
-union map_priv {
-	void	*ptr;
-	bool	 color;
-};
-
 static bool thread__has_color(struct thread *thread)
 {
-	union map_priv priv = {
-		.ptr = thread__priv(thread),
-	};
-
-	return priv.color;
+	return thread__priv(thread) != NULL;
 }
 
 static struct thread*
 map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid, pid_t tid)
 {
 	struct thread *thread = machine__findnew_thread(machine, pid, tid);
-	union map_priv priv = {
-		.color = false,
-	};
+	bool color = false;
 
 	if (!sched->map.color_pids || !thread || thread__priv(thread))
 		return thread;
 
 	if (thread_map__has(sched->map.color_pids, tid))
-		priv.color = true;
+		color = true;
 
-	thread__set_priv(thread, priv.ptr);
+	thread__set_priv(thread, color ? ((void*)1) : NULL);
 	return thread;
 }
 
-- 
2.51.0.384.g4c02a37b29-goog

