Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606582;
	b=Y4RW4Ibj6a1xu2px91rxUFvRHMwdejp2uZHWPX1m7pIMwFXjEMm0WIchQPKk8GReDGEX
	 FYd5zzmwLPqtquNy07Ththnc4zpB9KeDpaM6lcTpDddLelte3051L3HaCQsdPwK6SXg6O
	 JIaytlSoKVQtZRHxalF0SHSJOGLfS7kzPVqXIEwLxHNuZT9esxcjNds39sIbEF52lLxB/
	 4JQktIonYtUISEBg7gqOMp40AmEjnTUkRYxl1eyKt1ykD4hniI7pPahcUsY2Q1JTy6iAe
	 ZLXVnsEzkZibS0xwysfnDCvlTmh1DX6POR0od28JRRm21KdQ2LNvKH1bc0p2Uk1K4BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6TbHZoX/BlYBOr1K+nonbwDLBEmDmf3lXau0dRjbxaA=;
	b=RxgPGf4tCKcekrhp6x1V4LAME5qXJrwRnqn1Zoe8sdboshWi6PB2nm81nGMIJXFRbEOM
	 u0z9U2CNvsCYw1CYHpG2U6zZjoI/W2+puSc+ezL+Ox06KxomFKd3prG5rBXT/Dcu38DlW
	 O28Q1EEYUFBRLK4qYCF4WnknleNeOnN8AGSGsHOthZvXqKmU8mMA1dVVW1+uvWA3gZ/kA
	 ssyjjP6n32V6r27UGt5U3/+12kglHqL7Hq1VOj7nCv0kSwXsRyVjah7fODRUGUXOhn0Is
	 srV38+w0WVN8aBBVb0qpstwc0lGg59D+WJ8pFIOcrsPxa5xmBa3/XyzuNVKLZxtODxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p1HOHlJo;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58360A5BC1
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C58360A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p1HOHlJo
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-378722fd4a3so1684110eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606581; x=1795211381; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6TbHZoX/BlYBOr1K+nonbwDLBEmDmf3lXau0dRjbxaA=;
        b=p1HOHlJosggpU4ZHrS3STEbwHSMP8/zvE/U0v95nrdM1BARb4gygYpQdOUthsHFRmh
         vFxsHKM0aE64wFoZOqYp21qB4tuIOd8eXEPKAXd4nkfmyCTbiYPEveNjRmxY7TabSZts
         gsDYfWEC+L0hLUgmFEGLrZawboxN7A1DPjIPjLsMLwI3pRmO/E6MZuYmOAdkrF4JPEDm
         qAZyIV3YRIX1SbLuyKScCPYb6qb/VN1m4XB74teW1skdtj0WX5+YCHZZo3wiWju0h6Qa
         XZTLrYv9K7QnJinrbuq3XJOQ6G82azv5QqryuKqya5vxE3QN/FA0GLgt4NC6KmUK3Weq
         BGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606581; x=1795211381;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6TbHZoX/BlYBOr1K+nonbwDLBEmDmf3lXau0dRjbxaA=;
        b=HCcfe7G6AwDfM5+Hqpnzj9jshBq68j3fFBdCdJmSEQ371tX/KtiDfz04wfIYHVJshI
         oUWBIO3dLIqheFb7zP5CDfUFoniKEXXPkXkkQlZJGuDIoWslXz/XJVJAw9GJhGKC9W4P
         mTwVS5ZztBpIz/BoH7jxkOhJsBGxX/bnrBHZEbvjrIXHD3WXi+vr5QIktyKe9krA+uAI
         uhS5ys9qr6AjUWgzuOUT4NZed+jCye3s0ZpaEwodKwS8ezqpRhqiZzHs/A3iER/YVTos
         cVDZgr2VnDblCuGS/KwKqyCmEsksUBdMhHuYsPzMpAyknzGKG3Ef9qjsfED9FA0HFHXW
         +y4w==
X-Forwarded-Encrypted: i=1; AL+hErHQwSp05lyDgSfveH0AYFIItTcCSFaIWJ6zMCrLlS80XF04ibxMyQCcyFGjiav4nQi6Cu6mXasYdPT+vCxlKely@vger.kernel.org
X-Gm-Message-State: APuU4Z/DL82FkJuCt2KATHV67afg8LY/+QLozNQ28TwUKaQWtBlkPlag
	q7hNUsIluS6oNL0fUW9DDwMQ3eO7jRqvFk89Kgp01NO0bW1khFfLYUD3y1WUnl8tBjurEJHXC7s
	uxzoyDUSWRw==
X-Received: from dycaa11.prod.google.com ([2002:a05:7301:540b:b0:36d:ad72:d847])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8114:b0:36e:a321:5353
 with SMTP id 5a478bee46e88-37963371e09mr3567244eec.2.1794606579908; Fri, 13
 Nov 2026 13:49:39 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:35 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-12-irogers@google.com>
Subject: [PATCH v1 11/26] perf trace: Use generic hashmap for syscall_stats
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert trace and thread_trace syscall_stats maps in builtin-trace.c to
DECLARE_HASHMAP(syscall_stats_map, long, struct syscall_stats *) and
replace direct struct hashmap_entry and map->sz accesses with
hashmap__for_each() and hashmap__size().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 43 ++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 128efe1be8c3..dcd7890db8ac 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -141,6 +141,9 @@ struct syscall_fmt {
 	bool	   hexret;
 };
 
+struct syscall_stats;
+DECLARE_HASHMAP(syscall_stats_map, long, struct syscall_stats *);
+
 struct trace {
 	struct perf_env		host_env;
 	struct perf_tool	tool;
@@ -187,7 +190,7 @@ struct trace {
 	 * into the key, but this would make the code inconsistent with the
 	 * per-thread version.
 	 */
-	struct hashmap		*syscall_stats;
+	struct syscall_stats_map	*syscall_stats;
 	double			duration_filter;
 	double			runtime_ms;
 	unsigned long		pfmaj, pfmin;
@@ -1658,7 +1661,7 @@ struct thread_trace {
 		struct file   *table;
 	} files;
 
-	struct hashmap *syscall_stats;
+	struct syscall_stats_map *syscall_stats;
 };
 
 static size_t syscall_id_hash(long key, void *ctx __maybe_unused)
@@ -1671,22 +1674,22 @@ static bool syscall_id_equal(long key1, long key2, void *ctx __maybe_unused)
 	return key1 == key2;
 }
 
-static struct hashmap *alloc_syscall_stats(void)
+static struct syscall_stats_map *alloc_syscall_stats(void)
 {
-	return hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
+	return syscall_stats_map__new(syscall_id_hash, syscall_id_equal, NULL);
 }
 
-static void delete_syscall_stats(struct hashmap *syscall_stats)
+static void delete_syscall_stats(struct syscall_stats_map *syscall_stats)
 {
-	struct hashmap_entry *pos;
-	size_t bkt;
+	long key;
+	struct syscall_stats *val;
 
 	if (!syscall_stats)
 		return;
 
-	hashmap__for_each_entry(syscall_stats, pos, bkt)
-		zfree(&pos->pvalue);
-	hashmap__free(syscall_stats);
+	hashmap__for_each(syscall_stats, key, val)
+		free(val);
+	syscall_stats_map__free(syscall_stats);
 }
 
 static struct thread_trace *thread_trace__new(struct trace *trace)
@@ -2865,7 +2868,7 @@ static void thread__update_stats(struct thread *thread, struct thread_trace *ttr
 				 int id, struct perf_sample *sample, long err,
 				 struct trace *trace)
 {
-	struct hashmap *syscall_stats = ttrace->syscall_stats;
+	struct syscall_stats_map *syscall_stats = ttrace->syscall_stats;
 	struct syscall_stats *stats = NULL;
 	u64 duration = 0;
 
@@ -5210,25 +5213,25 @@ static int entry_cmp(const void *e1, const void *e2)
 	return entry1->msecs > entry2->msecs ? -1 : 1;
 }
 
-static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
+static struct syscall_entry *syscall__sort_stats(struct syscall_stats_map *syscall_stats)
 {
 	struct syscall_entry *entry;
-	struct hashmap_entry *pos;
-	unsigned bkt, i, nr;
+	unsigned int i, nr;
+	long id;
+	struct syscall_stats *ss;
 
-	nr = syscall_stats->sz;
+	nr = hashmap__size(syscall_stats);
 	entry = malloc(nr * sizeof(*entry));
 	if (entry == NULL)
 		return NULL;
 
 	i = 0;
-	hashmap__for_each_entry(syscall_stats, pos, bkt) {
-		struct syscall_stats *ss = pos->pvalue;
+	hashmap__for_each(syscall_stats, id, ss) {
 		struct stats *st = &ss->stats;
 
 		entry[i].stats = ss;
 		entry[i].msecs = (u64)st->n * (avg_stats(st) / NSEC_PER_MSEC);
-		entry[i].syscall = pos->key;
+		entry[i].syscall = id;
 		i++;
 	}
 	assert(i == nr);
@@ -5238,7 +5241,7 @@ static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
 }
 
 static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
-				  struct hashmap *syscall_stats)
+				  struct syscall_stats_map *syscall_stats)
 {
 	size_t printed = 0;
 	int lines = 0;
@@ -5255,7 +5258,7 @@ static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
 	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
 	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
 
-	for (size_t i = 0; i < syscall_stats->sz; i++) {
+	for (size_t i = 0; i < hashmap__size(syscall_stats); i++) {
 		struct syscall_entry *entry = &entries[i];
 		struct syscall_stats *stats = entry->stats;
 
-- 
2.56.1.703.gf848ed807c-goog

