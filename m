Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C663C8719
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257306; cv=none; b=FfJ9r/FZon392CDv4G5+yiq+6yWCWgwWA/Nu6OkbWYnPx/rJzYxB0iri475xD3CJhbgVQAPH3we+V8+RSqlefczTNdiGXdJ0ktUQaQs8V3Y6sCyDw4BqjL+h+kmQzC25prxOOoKFasOTFVkUV9btzjjpejPFAgydMOOEguY5aM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257306; c=relaxed/simple;
	bh=GxArOIvto1pp6qoIBJI22Cq3xg1jqH/+vydnFspY9XU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=feHX8vldoY/ZluLICGzXnFWTgxMdV3F25vTBlnwXJx1A1kbSFoNGyEEbUoSMTDzsAkmpk7HB/yz1ADHdyUbi9RfSqmyOaRPU/nDvLkQLzaNz9xAJOEAW5YRNgzPouU1806pp7nHg5oJx8UNYS9RW5A/i3NjO5irlb7KFYtyGW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKULd+D8; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKULd+D8"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-359b81ad4e8so1355289eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792257303; x=1792862103; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6twbsj7fCGE7RjYCr+/3f8wBcq2w9//V4MEqCuNPeO4=;
        b=dKULd+D8SdtT3mcyAmhpvalwjPl3IpdzNPkLMXsPYqQbkyEQZwif8e2YyGKug0sAB3
         MSrYx2X0Q1xdii94IRYUJXj9aVC2DuRMqTS5vNKR1DN+c33epkdyUIjVZhHws9bEWVmn
         PDi2FcZzEtrcaTiBNcAZGdYvYVxy/Yv6f962n3PzoaLz0GgN+ZUqTZCc6V60KK7IM/wM
         xmjMPfeK7ol056xCsyHEKe7DHEokWqlvD3bs3cJz/9K9CxLv5aDPi+heS+ntXCr8nRNU
         7tQodB4MGV6hk1k+qGIkGJxD21XxWxIyyQEGGhlmxcJbiEqIQInyGO0Pxdves9MhibEX
         8R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792257303; x=1792862103;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6twbsj7fCGE7RjYCr+/3f8wBcq2w9//V4MEqCuNPeO4=;
        b=QEJ5SpEuHBsaue35bQ+kynrpN8zF3NQ+vqCAiiCHqYq1hVmhMj7mt9xC0Dbf5wl4C3
         sCzC11CtBbTz86tK/0BeonXxZRuZ4WnRY9jPa+9jyec3KbAHDTMACHgs7W7s0XaJSCss
         IrFYjzqEYPLaONG2z/BN9sr06hUuAWukBUDbXZrmGcrNxEOPhXob24J/gahT1oMIbPZk
         UO+mVQgiGCea+uWdYABaW2u7FTaNJXLLNAg419TIvYHjzWEL9h+YgGoXhBdg4PSogZfq
         yGQZ2B//ohmX8Bk4hQn04j+Sd6Ca0Ifjaq6e1tuAho0dx1e3koYglAn+L4uRUEC7F+8A
         Dt+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxCWBj9PwLuI0s5FXgNrBvPOXPNmQ5ciCuRNWFQ/mhLhJlS84tMrRkPGbP4u/HTPqYUVdCWm91jvEa5iT00hKBV@vger.kernel.org
X-Gm-Message-State: AFq9FYLEoo8jfcANAdo6mTOInlOEvbDtXK7zt3RsJS+4mHxKBll31BtD
	FbwhMen8G+MhNejABhrDccYkJBabQv9k/uRcNDv0AxoM+PDpsUaiZec0zfzdlts/g//sGforKRV
	BYTb6STjQlw==
X-Received: from dyep10.prod.google.com ([2002:a05:7300:428a:b0:353:8237:7213])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:dd91:b0:35b:17b9:ebc8
 with SMTP id 5a478bee46e88-361a1f50cbcmr3847175eec.19.1792257301577; Sat, 17
 Oct 2026 10:15:01 -0700 (PDT)
Date: Sat, 17 Oct 2026 10:14:37 -0700
In-Reply-To: <20261017171437.2066343-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017054555.1655407-1-irogers@google.com> <20261017171437.2066343-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017171437.2066343-7-irogers@google.com>
Subject: [PATCH v2 6/6] perf lock contention: Filter events before creating lock_stat
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In report_lock_contention_begin_event(), lock_stat_findnew() was
called before checking filters.nr_types (-Y), filters.nr_addrs (-L),
and match_callstack_filter() (-S).

When a filtered-out lock event (such as a mutex contention when
running with -Y spinlock) shared the same aggregation key as a
subsequent matching event (for example, contention on the mutex's
internal wait_lock spinlock from the same caller), the first event
created the lock_stat entry with the filtered-out lock's flags and the
second event reused that entry, causing non-spinlock entries to appear
in -Y spinlock output.

Check the type, address, and callstack filters before looking up or
creating the lock_stat entry.

Fixes: b4a7eff93c39 ("perf lock contention: Add -Y/--type-filter option")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 61 +++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index feaf1cfd08cf..a031709a2cc2 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -975,6 +975,7 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 	struct machine *machine = &session->machines.host;
 	struct map *kmap;
 	struct symbol *sym;
+	u64 *callstack = NULL;
 
 	ret = get_key_by_aggr_mode(&key, addr, sample);
 	if (ret < 0)
@@ -1010,33 +1011,6 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 		}
 	}
 
-	ls = lock_stat_find(key);
-	if (!ls) {
-		char buf[128];
-		const char *name = "";
-
-		switch (aggr_mode) {
-		case LOCK_AGGR_ADDR:
-			sym = machine__find_kernel_symbol(machine, key, &kmap);
-			if (sym)
-				name = sym->name;
-			break;
-		case LOCK_AGGR_CALLER:
-			name = buf;
-			if (lock_contention_caller(sample, buf, sizeof(buf)) < 0)
-				name = "Unknown";
-			break;
-		case LOCK_AGGR_CGROUP:
-		case LOCK_AGGR_TASK:
-		default:
-			break;
-		}
-
-		ls = lock_stat_findnew(key, name, flags);
-		if (!ls)
-			return -ENOMEM;
-	}
-
 	if (filters.nr_types) {
 		bool found = false;
 
@@ -1066,7 +1040,7 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 	}
 
 	if (needs_callstack()) {
-		u64 *callstack = get_callstack(sample, max_stack_depth);
+		callstack = get_callstack(sample, max_stack_depth);
 		if (callstack == NULL)
 			return 0;
 
@@ -1074,7 +1048,38 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 			free(callstack);
 			return 0;
 		}
+	}
+
+	ls = lock_stat_find(key);
+	if (!ls) {
+		char buf[128];
+		const char *name = "";
+
+		switch (aggr_mode) {
+		case LOCK_AGGR_ADDR:
+			sym = machine__find_kernel_symbol(machine, key, &kmap);
+			if (sym)
+				name = sym->name;
+			break;
+		case LOCK_AGGR_CALLER:
+			name = buf;
+			if (lock_contention_caller(sample, buf, sizeof(buf)) < 0)
+				name = "Unknown";
+			break;
+		case LOCK_AGGR_CGROUP:
+		case LOCK_AGGR_TASK:
+		default:
+			break;
+		}
+
+		ls = lock_stat_findnew(key, name, flags);
+		if (!ls) {
+			free(callstack);
+			return -ENOMEM;
+		}
+	}
 
+	if (callstack) {
 		if (ls->callstack == NULL)
 			ls->callstack = callstack;
 		else
-- 
2.56.0.212.g129ede20d9-goog

