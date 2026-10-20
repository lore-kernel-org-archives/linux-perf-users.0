Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529958;
	b=APkeGOyfL7e/dUHc2nhjXJ+z8NDB8afS1f98FuxGT/hDU20u8golHhzyd2nmlm9Qp6Wx
	 rY4hqcbXzW9roZKytN6mDyEHs1GYPlbsNHvBVP8Q/ZlEZbgJu43gBJccajRrnfvEYpN40
	 CkBCtFP9ua2BPH2qIw/EsTWlx959oOKuw4+6GbxLI2/06BaW4GUILjHTzMFN/TwIKjmGl
	 fQV0/pOW1C/uLecl02wA0ikHDOBlwlnR5Dw/kb+rHvNt7wMH3Aa595EthLtse/B5HxBGF
	 qrZCUpd3eRu+9Q7Bge01ZPa3njG88z4mHzJwmK7mL3YhtUVd1a8SW6oOo2LnN6o+nUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=N2qanCyCB4wF+VeUcB92quptg8ph71hHc9UNhycwS8A=;
	b=q8wqGREDuNr+G/0+2NHwiXeJ/Evv9STL8EqNe12zEPB93YSk31PdjBoHXbHzOWvuBKXK
	 BEDhfJTMJMT2h7FCyVNYBD0UdDCnYlKCgw1UHmuUO1YFBVWA0g6L6y6HcoboV19xHAX5f
	 eaiPdsnbPotFDgEEQg4Z5VEQfOpuh45hKV4cK3ter0Xepq+FFUk5geD+cSWavIXFudgwo
	 le0tzno03PJcdboJGdCdbbsulQzSDWWrtlP3TbQ3i2x+GRkWSNyc/KR+tgVR1WI36t3Ut
	 GvuejXKX3MM9XKo5bP9vF7ooFA2fe73CVAW7Y52voCkjiAvfXhbjyOSyB8IBn/VG2mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AY8qpXwL;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F46606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 20:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F46606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AY8qpXwL
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-186c1aae818so100101c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792529956; x=1793134756; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2qanCyCB4wF+VeUcB92quptg8ph71hHc9UNhycwS8A=;
        b=AY8qpXwL36PexW/e1AxUNktCFLv+opVByRmFWFpezDMwVrRGpBgJBa+rIGtOd9A3Kx
         +zmL+3J15aWqZIhlurvVna4Fq6NND4E90sAS3GRsUp0siz38WXWvw2WGm/kcwR3ZOIJR
         wgNdf2ZRhVKmzS3jqmwwhyUgsxVztsd/ORNULc68Nasu9ZoAlYRITuxZRafk/mN4mc0X
         9L7c65wxcNF/yKIM2kmVTq7a1ksE4D+IU1lyCFAEW3qzZXWW/M4ENdn4ukXImqz9tQ33
         wSO1tuYsV/J1IimK1MWPRYxvtYjZGvmevlJ+hHDaOgO5sJBJAUUzdF7uifVebdf5Vd4u
         Qf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529956; x=1793134756;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2qanCyCB4wF+VeUcB92quptg8ph71hHc9UNhycwS8A=;
        b=D1+Ao+B0PF3pZZP1qmpzF9difDJ64gX6XwQfLLsyRAyObfyC8J2o6kGX1QdR5dPHVm
         KjIshE/p07TaKb3/qzzMXAl2IX5F0kJiNtNti0sc/NovKGNvORSl6zhFv1WQi7jOmo0p
         8mwwtPo2vXy/FPvUPzHVb+w1MtefqzU22ppoZGeNANlH/fCoCUDtF5O2O6UYxQcTy2sr
         1Rx1hKcM2yu5rFH7BDzv5tAjnH0EWadTQvsYTm3e61fxxbgtFoaxZLRrJAoKH39y8sj7
         ACyAp2UQ/2O2zRPoZ1g+Xm4C0oxUqB9WhamyyJvAjG06VtkskhRaDvLHXCmHD/fOMMpP
         8/hA==
X-Forwarded-Encrypted: i=1; AKwUvBzzRbj7P45di2Rmc01JLznizGosOjOEgY8bAqOwRHILtx00i6nkCPRMhMY5tTZq4uVpr6f9YL3VPO+CQFiVqpHl@vger.kernel.org
X-Gm-Message-State: AFq9FYJNjdoPPMtT6SK6uuBl+O41zac3pixc2Ch72oW/muBevFm27JC5
	tkpbVw5r7SH+3NtGsbalf7qqOMVz6MpUa5+c9vOb44tn3i0ZmGJG0M2vQBa9f0oBPBqxKOog2/Z
	8t5S4AB57aQ==
X-Received: from dlbvs4.prod.google.com ([2002:a05:7022:3f04:b0:17e:6ff3:49a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eb45:10b0:16b:fdbf:4a9c
 with SMTP id a92af1059eb24-190a599a3c5mr19499c88.23.1792529955721; Tue, 20
 Oct 2026 13:59:15 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:58:51 -0700
In-Reply-To: <20261020205859.1080743-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019220915.3943592-1-irogers@google.com> <20261020205859.1080743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020205859.1080743-2-irogers@google.com>
Subject: [PATCH v5 1/8] perf lock contention: Filter events before creating lock_stat
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
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
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 61 +++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index d5c0d55cb82d..778923c92f42 100644
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

