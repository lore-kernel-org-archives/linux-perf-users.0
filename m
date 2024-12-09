Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089019A2A2
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774474; cv=none; b=SO+pfPKshrq27L3TlE7wB40RjRckwQNkqhp/ULe4piGKQjpB9UfDrQQMrtdgQfcS8GcBET9jsrIRIl4FqGZcJQgopq+OqJMUHi6duwnJHWTy+SYjp9JO04UUVfjpCKunWCg38OZfymTkhOhs/qzrmv/DUcEbLvPNnt5BAaGxptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774474; c=relaxed/simple;
	bh=4kn5P6+jGONAEaVeFHT3UucZIlngMssHcP6vsMKgAjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IaKp8cna9uyhFaRNIleX9LAVqXXgJCGPaLDjCktJSVKPUQg/6EBqNugttALUV7Nq6tC3ketUf7zY7rC6ovZ6QLuECPfAjGa3DjuVKMI5vA6SuW+DGvHaU8VT9Td6fwqLYXBDBxPSZsFfRD7peFSBilDnNHb5YVQdVorelz19CKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iIMX9yIM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIMX9yIM"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee8ced572eso5037327a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 12:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733774472; x=1734379272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RY4doSMRa/VPB1R40lmMDg95HZG8vtGnsSIJ3rpFA/Y=;
        b=iIMX9yIMeEO8N2Di2hPnzYGLr9hFBb2mibsEH9VtCfNs55XyHeyUbrVn6SR0k+LwYx
         bsowee3x5PS3WaVbdWVk7+72Hw5YUlqWTgF8EVYBzP9yZDYrECYUDsFPPFVjOKpzxnp9
         hxU+JXlah8yYuzxjLoFuby4UafRvL1s+XzE82ORrKG5whc1y3VnJI/m+0zhBsQCCwsz+
         1keqUnyuMfWpXFWL69mBYwUFtHLrrxbL6mhuYPsRsTy6fLnzo5MJ0p956aEUrMlY4nLP
         xzcl+0CKCbdtPmnmOO5Vb22C3DPf5i5vjZ9tm4pf9LPoc3jhGUtBiwrlvlR4ibn6oQIi
         Ygzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733774472; x=1734379272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RY4doSMRa/VPB1R40lmMDg95HZG8vtGnsSIJ3rpFA/Y=;
        b=uUpqKVAG48IP0E/AeSlVTHQAi56IdRUfT5Q9aK/5FqWc5VZS+nh1Iv6s3Ie5LtVllr
         dZv5wiwls543g4fI0eIhOr0nherVirIIrcBCorKwGdubRrY1CRfcWxtt6viqAWVusWjW
         Kz39aflYaICqPJZiHO8eAMrFwuK0IlqgWOR+m6qpUlEhyvYZhlCAZRzqOv3j+CDs1r12
         qhQpl4JkvkSVqAVbhkoBB3yCrrGxqA58ioAwopCfmEbxR/70qKMtV49LK9GxkiQqFeeg
         05hZD6Pux9GjVQXazosOo+zuqFAub49hnEbHaa+bOF9xnU+FcUtrL+IuGKbFk1Jd8tAe
         S3fA==
X-Forwarded-Encrypted: i=1; AJvYcCVjATJNlKRQeXLxIo2Vv0Lw0zle8g9u01e0v/SpARsoGUn9UGT9l3nf7Jq0ACqiJRcQW84U7sI3LpsgwrZEWk+h@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQx/KrL8nBKlEJnJ0vNDmdQYijoQMcRMnjDFUmIchAPZD4yLK
	GUxPblVFY9Xv/4saFByX2GbGqiaWgdIe7ND6Z3KrvF5krWCp+miz6jZyl8F0jfnc9wC3owjJ+Jv
	+Cw==
X-Google-Smtp-Source: AGHT+IGGAzWBPYhdIAeXL9ZjTqrB2KVYJeGw3tfALYYm6j7bxf4141tb4wMsjCTiFyI+oiH0XIgg011lILA=
X-Received: from pjbhl7.prod.google.com ([2002:a17:90b:1347:b0:2ea:564b:dce0])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dd2:b0:2ee:693e:ed7a
 with SMTP id 98e67ed59e1d1-2efcf26e40bmr2862563a91.35.1733774471730; Mon, 09
 Dec 2024 12:01:11 -0800 (PST)
Date: Mon,  9 Dec 2024 12:01:02 -0800
In-Reply-To: <20241209200104.870531-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209200104.870531-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209200104.870531-3-ctshao@google.com>
Subject: [PATCH v4 3/3] perf lock: Rename fields in lock_type_table
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`lock_type_table` contains `name` and `str` which can be confusing.
Rename them to `flags_name` and `lock_name` and add descriptions to
enhance understanding.
Tested by building perf for x86.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 264acfa648e4..991de468e0f1 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1575,8 +1575,13 @@ static void sort_result(void)
 
 static const struct {
 	unsigned int flags;
-	const char *str;
-	const char *name;
+	/*
+	 * Name of the lock flags (access), with delimeter ':'.
+	 * For example, rwsem:R of rwsem:W.
+	 */
+	const char *flags_name;
+	/* Name of the lock (type), for example, rwlock or rwsem. */
+	const char *lock_name;
 } lock_type_table[] = {
 	{ 0,				"semaphore",	"semaphore" },
 	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
@@ -1593,24 +1598,24 @@ static const struct {
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
 };
 
-static const char *get_type_str(unsigned int flags)
+static const char *get_type_flags_name(unsigned int flags)
 {
 	flags &= LCB_F_MAX_FLAGS - 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
-			return lock_type_table[i].str;
+			return lock_type_table[i].flags_name;
 	}
 	return "unknown";
 }
 
-static const char *get_type_name(unsigned int flags)
+static const char *get_type_lock_name(unsigned int flags)
 {
 	flags &= LCB_F_MAX_FLAGS - 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
-			return lock_type_table[i].name;
+			return lock_type_table[i].lock_name;
 	}
 	return "unknown";
 }
@@ -1717,7 +1722,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "  %10s   %s\n", get_type_str(st->flags), st->name);
+		fprintf(lock_output, "  %10s   %s\n", get_type_flags_name(st->flags), st->name);
 		break;
 	case LOCK_AGGR_TASK:
 		pid = st->addr;
@@ -1727,7 +1732,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
-			st->name, get_type_name(st->flags));
+			st->name, get_type_lock_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "  %s\n", st->name);
@@ -1768,7 +1773,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "%s%s %s", get_type_str(st->flags), sep, st->name);
+		fprintf(lock_output, "%s%s %s", get_type_flags_name(st->flags), sep, st->name);
 		if (verbose <= 0)
 			fprintf(lock_output, "\n");
 		break;
@@ -1780,7 +1785,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
-			st->name, sep, get_type_name(st->flags));
+			st->name, sep, get_type_lock_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "%s\n",st->name);
@@ -2343,10 +2348,10 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
 		bool found = false;
 
-		/* `tok` is `str` in `lock_type_table` if it contains ':'. */
+		/* `tok` is a flags name if it contains ':'. */
 		if (strchr(tok, ':')) {
 			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-				if (!strcmp(lock_type_table[i].str, tok) &&
+				if (!strcmp(lock_type_table[i].flags_name, tok) &&
 				    add_lock_type(lock_type_table[i].flags)) {
 					found = true;
 					break;
@@ -2363,7 +2368,7 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 		}
 
 		/*
-		 * Otherwise `tok` is `name` in `lock_type_table`.
+		 * Otherwise `tok` is a lock name.
 		 * Single lock name could contain multiple flags.
 		 * By documentation, `percpu-rwmem` should be `pcpu-sem`.
 		 * For backward compatibility, we replace `percpu-rwmem` with `pcpu-sem`.
@@ -2371,7 +2376,7 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 		if (!strcmp(tok, "percpu-rwsem"))
 			tok = (char *)"pcpu-sem";
 		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-			if (!strcmp(lock_type_table[i].name, tok)) {
+			if (!strcmp(lock_type_table[i].lock_name, tok)) {
 				if (add_lock_type(lock_type_table[i].flags)) {
 					found = true;
 				} else {
-- 
2.47.0.338.g60cca15819-goog

