Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A51D63F1
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737071940; cv=none; b=FP0EHXqZc/iR/7shkqbdcoqd+DKnG1syWKgT2ivtSEIxp+CRjoCk3DEycWSW0R4QkPTy030f5yZI0x6qqx8ThbGow8PO2mp917tkTT9jSwY7t1Ap7rBCy8kSrBAwSA/FNxmSlhmWxCLwwszIntnH3At9juDr3qfWH26yfAM9/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737071940; c=relaxed/simple;
	bh=lSWyD/qthJNvuR6K/ttW5S1wvtWder6O5O2madtb56Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yr+PBzOLEJMZ88rZBXYHQW07RZtQIWY41yExnADUOUSYnxhGeuu1HB9GFR2v642k9U+YjZ0CIE6Kc/x/PV7K+0TD+NzpommTAQmH8AMiPzhxGu+jaemi/F3Tg8yj7sbAlSN1cc701gWnFrnlB9fCwsoF2D5cAcYWVjZ+ZQ4mbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+jXuobT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+jXuobT"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so3050142a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737071938; x=1737676738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqogRIyeQOm1mH/zmM0P3EKwYUxaCmfpaPw6D9lhje4=;
        b=S+jXuobT8+W3TRT30cbfytI04sYUUv+dgs9+aDNS7+SAfVUoQvcYnsFghtJPs6CFLv
         1oZMXwFgEWFI1jzqBo4uviXWQ3O7JJ5ZVsc+Kqsag1L8n8FFvyYfSX70ImvBwGqulpmt
         33vwKqxMwjgbTSajIwFwi6LlypV2QoIf/958v8csbvYuMrrznSM/I5iTda6QoMrZY6Q9
         i8CpygJGanRx6voXfE57GePoiyjwX1roWynufAjxCNoRDe8J2RDZXR7BFBCRi+YPlSR9
         Aw+1S6dd5wrJy8LuC4nDyDjYAEUEI6yoh+LWpVZ/gz7Ts+g9d2bHicmn5v43BthX1IPA
         jlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737071938; x=1737676738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqogRIyeQOm1mH/zmM0P3EKwYUxaCmfpaPw6D9lhje4=;
        b=cgeuvdGYmjPn/RsuLbnR9ed1MsqDm/Br4KrA4R5G4rYwivjUFEkOwr0qcN2dB6DFrG
         uMKqL+BqQl5irpve6tZWnWUmSkpC56p+LqYqsDdy+vXd20UUL2lJNkhWT86w6OglevmI
         kzRBBDpsYgpBCmPzWt5NO07U1OjhZ5gJoC5hJI2spbTSlcHiRa//fDzg05fpRpdEnoA0
         UtjP7Dn14sHGIm2hVZOn7ZWxO5+atat3QCj6abp5TJNt1dmu7cxLSkQqR1575g8LsjO3
         0QjuY+qosu+TMG5iqX3frAYcSmmdkqH3t64heLd2AoYfjxk/aZMMsaV8e+UPaHUY2SHu
         YkcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo8RP8tpl+tjBSIDF8VVHAdudqyptQrNWB3cSc0AS32A34Kw9XD0iO1d4F0+IMunTE03xoB8MH0I1KhatNd5ou@vger.kernel.org
X-Gm-Message-State: AOJu0Yyihe6HJ+N50C/yH7auttf3joLA0CsaN85kER16j4BF2vzk6AB1
	kVXlU2JJ8ERGV4Fj7/1Gm40rykmybyDYSM01J+N3TJgbOzVFg9cVeuMs6Dytqi8vtIoewzfhQH+
	SAg==
X-Google-Smtp-Source: AGHT+IEyihWI8y6L5DN+UGBhQ6yzTdTRW2GumkO1gsT8gI+W3VZuAU/3F6QmzJzFO2mgkH7hGcgKnP1mchs=
X-Received: from pfblm15.prod.google.com ([2002:a05:6a00:3c8f:b0:729:427:8d73])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6812:b0:72d:b36a:4497
 with SMTP id d2e1a72fcca58-72db36a45eemr122321b3a.3.1737071938474; Thu, 16
 Jan 2025 15:58:58 -0800 (PST)
Date: Thu, 16 Jan 2025 15:58:16 -0800
In-Reply-To: <20250116235838.2769691-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250116235838.2769691-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250116235838.2769691-3-ctshao@google.com>
Subject: [PATCH v6 3/3] perf lock: Rename fields in lock_type_table
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`lock_type_table` contains `name` and `str` which can be confusing.
Rename them to `flags_name` and `lock_name` and add descriptions to
enhance understanding.
Tested by building perf for x86.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
Note:
  Rebased on tmp.perf-tools-next

 tools/perf/builtin-lock.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 258c4ccb96af..ea3a62ba95d4 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1468,8 +1468,13 @@ static void sort_result(void)

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
@@ -1487,24 +1492,24 @@ static const struct {
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex-spin" },
 };

-static const char *get_type_str(unsigned int flags)
+static const char *get_type_flags_name(unsigned int flags)
 {
 	flags &= LCB_F_TYPE_MASK;

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
 	flags &= LCB_F_TYPE_MASK;

 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
-			return lock_type_table[i].name;
+			return lock_type_table[i].lock_name;
 	}
 	return "unknown";
 }
@@ -1617,7 +1622,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat

 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "  %10s   %s\n", get_type_str(st->flags), st->name);
+		fprintf(lock_output, "  %10s   %s\n", get_type_flags_name(st->flags), st->name);
 		break;
 	case LOCK_AGGR_TASK:
 		pid = st->addr;
@@ -1627,7 +1632,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
-			st->name, get_type_name(st->flags));
+			st->name, get_type_lock_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "  %s\n", st->name);
@@ -1668,7 +1673,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s

 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "%s%s %s", get_type_str(st->flags), sep, st->name);
+		fprintf(lock_output, "%s%s %s", get_type_flags_name(st->flags), sep, st->name);
 		if (verbose <= 0)
 			fprintf(lock_output, "\n");
 		break;
@@ -1680,7 +1685,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
-			st->name, sep, get_type_name(st->flags));
+			st->name, sep, get_type_lock_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "%s\n",st->name);
@@ -2243,10 +2248,10 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
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
@@ -2263,14 +2268,14 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 		}

 		/*
-		 * Otherwise `tok` is `name` in `lock_type_table`.
+		 * Otherwise `tok` is a lock name.
 		 * Single lock name could contain multiple flags.
 		 * Replace alias `pcpu-sem` with actual name `percpu-rwsem.
 		 */
 		if (!strcmp(tok, "pcpu-sem"))
 			tok = (char *)"percpu-rwsem";
 		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-			if (!strcmp(lock_type_table[i].name, tok)) {
+			if (!strcmp(lock_type_table[i].lock_name, tok)) {
 				if (add_lock_type(lock_type_table[i].flags)) {
 					found = true;
 				} else {
--
2.48.0.rc2.279.g1de40edade-goog

