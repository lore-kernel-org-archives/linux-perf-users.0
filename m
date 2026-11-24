Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490995;
	b=O2ARiLevjAg4st+P9P0xrxS6TC1bunQ8ndP7noKeuncWYUeAfbhxrnvLps1o+0hA+VfA
	 6Rjf5nGQaRuQpuEeW5idxH383V3x416Bl1ZWtfF6IzQuuNiynqms9QS5Xe/Cc+Ow9TLYK
	 m4XAWsCGPKN2isaU/1ALDsMQClxr/mZqMLXp4sg91NNulIxPnW/ZkRnz9do41iRcXMOdK
	 XZ4r7zWvF/nAw/ev4n4vpWZAwVFxQSz7R1MGw5mWR3QxoE0aCl6Wy6hA1qh+HnUhuZE7T
	 PsWyj+CI7SGYC1QE8FxsamibHD42SIXZiV8BXQGdYyr7HwLsGDoyoLVMUOJyeAEdwLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=y6IiJs/DMF6EfGohMMzJwSUIi3XIZn9ABEzl61p3zSk=;
	b=A74wZYFRzP7vcWQ2BLftTxeX/nqJf6U5PFDXbhD7N2IuFsVbi6xpAJ5LvtIDxRCr/sx7
	 38C5pTt6o+fz5BwA2rXKgqB3j9vyud0GQC1Zb5x0zjFlm4yuypB0kcKqk4gDhTPmvKLWh
	 FoZ2WFbjOyst78jBHcBoLQrHVHVH47RF37l8QM5YhpZVFP7DYz2lalB6OD3DY7v3DW2T2
	 SzXHXUs58lNkKwxx3JiveCKYvaH8jq7ABLvrfGrtgE3eYPXIABrGdO9Oaoee5WPH61uqk
	 5z0LQZa8L3Hnkp2uL362tDhdFU+7TalelJxBnpETCo8JjLP+qLd2hv/N0O67yE3TxSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T0dqIfDF;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C0606A330
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A8C0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T0dqIfDF
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4e937c5bd4fso3534193b6e.2
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490994; x=1796095794; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y6IiJs/DMF6EfGohMMzJwSUIi3XIZn9ABEzl61p3zSk=;
        b=T0dqIfDFe7oB6QtLppNI2vBPpk5n2plu1YR5OLmUMw2lnYYO5frOsef/48tzmTEsOw
         vI3jlIchKPVJa9GfFhaG/Do5kdfS5RWkVErErww/LWvFp0HCyjvjwfwoRd49fKKBHgld
         Dha4h3zWGTlDnU3SAwY7KOFNSpLSxPICWvhevZk6LyAVtH/R9o7QczftPW6sek6COAdt
         bzX/2RVCRahGOV5xvkKQjkODmr9gwvFtAz+BguSRahNM8meyuhd1kejH5TClWnvqSm8c
         Fi5KW0z4cDzxlnkD8x8BIRCP4PLfOZeSPP0I63WAjUo7ng9Ly32ju+98IBmd4qyU7s6m
         /Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490994; x=1796095794;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y6IiJs/DMF6EfGohMMzJwSUIi3XIZn9ABEzl61p3zSk=;
        b=WEOfNzCQs25maDr3mbDZqZCdshPbGp/yawANB+MtPBMizEtUVikMwCjbBasl2AHS/K
         mjIBMjrQjfMwjMx7eFxwvl/rVJldGhE/r/GEWk5zt8zFRBO00/L1p0bL0MBbATw9yRkZ
         NG4P+TxyGSAcOlQvZd3LVCPkDhW7xWqUMTXGIZNoHWBpU3ESBvacTprbPaUPuP24HKin
         m6XnIHFKi3csTkYdKGiXf/2oQkulkDmi03Shb4s5Xc496o43q5i4pQl1zM5oDr2mJ90A
         6duV61sY+VXO8oWSq9KnT1OyU5D2Zh8ma9mOO5jdeYRFP2vnYTD35hj5Pe2sc/hjgvck
         Y3Ow==
X-Forwarded-Encrypted: i=1; AL+hErHHH1b7v0E7Z4RSjwqEPyWXz4YJyShfuVw7b+n7tDhvP8gSqxix1gKlyOcZXsuPUP8EgRqvSgPoIf7woZe0l/Fr@vger.kernel.org
X-Gm-Message-State: APuU4Z+rzRiGBdOgaL0TfNVtwriVVJ+UtdwdaRAGa23CSleJYODB5TeB
	WfG56bMWwmrt7Zeu0+tRXPXYzzpIBTkpHuVW0owlTAbc6MTs9JHp1MYiuSmKP+II7umYAizo+Y7
	T902In0SPSg==
X-Received: from iobdq9.prod.google.com ([2002:a05:6602:1b89:b0:9c3:dedd:2a97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:660e:b0:4f4:b5ba:a241
 with SMTP id 5614622812f47-57a0b048d65mr14053472b6e.39.1795490994095; Mon, 23
 Nov 2026 19:29:54 -0800 (PST)
Date: Mon, 23 Nov 2026 19:29:01 -0800
In-Reply-To: <20261124032902.3859564-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124032902.3859564-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124032902.3859564-11-irogers@google.com>
Subject: [PATCH v9 10/11] perf session: Add dso__session() and session-scoped
 allocation wrappers
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add explicit session-scoped memory allocation wrappers:
- perf_session__malloc(session, size)
- perf_session__zalloc(session, size)
- perf_session__calloc(session, nmemb, size)
- perf_session__realloc(session, ptr, size)
- perf_session__strdup(session, s)

When an allocation fails and returns NULL, if a non-NULL struct
perf_session is provided, the wrapper invokes perf_session__shrink() to
evict unreferenced symbols, DSOs, and cached debuginfo across the
session's machines and then retries the allocation once. This avoids
the thrashing overhead of periodic heuristic shrinking while allowing
perf to recover from memory exhaustion.

Also plumb a back-pointer from struct dsos to its owning struct machine
so machine__session(machine) and dso__session(dso) can resolve the
active perf_session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c     |  7 ++++
 tools/perf/util/dso.h     |  2 ++
 tools/perf/util/dsos.c    |  1 +
 tools/perf/util/dsos.h    |  1 +
 tools/perf/util/machine.c |  1 +
 tools/perf/util/machine.h |  5 +++
 tools/perf/util/session.c | 70 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/session.h |  6 ++++
 8 files changed, 93 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index b6217c49dd14..43b1ad44d165 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1915,6 +1915,13 @@ void dso__delete(struct dso *dso)
 	__dso__delete(dso, /*close_data=*/true);
 }
 
+struct perf_session *dso__session(const struct dso *dso)
+{
+	struct dsos *dsos = dso ? RC_CHK_ACCESS(dso)->dsos : NULL;
+
+	return dsos ? machine__session(dsos->machine) : NULL;
+}
+
 bool dso__can_shrink_symbols(const struct dso *dso)
 {
 	const char *name;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index b0ee45a53f40..eb56bf9fb4d1 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -20,6 +20,7 @@
 struct machine;
 struct map;
 struct perf_env;
+struct perf_session;
 
 #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
 #define DSO__NAME_KCORE		"[kernel.kcore]"
@@ -797,6 +798,7 @@ static inline refcount_t *dso__refcnt(struct dso *dso)
 bool dso__can_shrink_symbols(const struct dso *dso);
 bool dso__try_evict(struct dso *dso);
 size_t dso__shrink(struct dso *dso);
+struct perf_session *dso__session(const struct dso *dso);
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 77f668d7557c..43605daedba6 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -19,6 +19,7 @@ void dsos__init(struct dsos *dsos)
 {
 	init_rwsem(&dsos->lock);
 
+	dsos->machine = NULL;
 	dsos->cnt = 0;
 	dsos->allocated = 0;
 	dsos->dsos = NULL;
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index de10a10de777..87002b25a3bb 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -19,6 +19,7 @@ struct machine;
  */
 struct dsos {
 	struct rw_semaphore lock;
+	struct machine *machine;
 	struct dso **dsos __pt_guarded_by(&lock) __guarded_by(&lock);
 	unsigned int cnt __guarded_by(&lock);
 	unsigned int allocated __guarded_by(&lock);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f4108cc725fc..20215c12819e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -81,6 +81,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	memset(machine, 0, sizeof(*machine));
 	RB_CLEAR_NODE(&machine->rb_node);
 	dsos__init(&machine->dsos);
+	machine->dsos.machine = machine;
 	threads__init(&machine->threads);
 
 	machine->kmaps = maps__new(machine);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index b42c363723c9..80ef16384aa5 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -165,6 +165,11 @@ static inline struct perf_session *machines__session(struct machines *machines)
 	return machines->session;
 }
 
+static inline struct perf_session *machine__session(const struct machine *machine)
+{
+	return machine && machine->machines ? machine->machines->session : NULL;
+}
+
 void machines__process_guests(struct machines *machines,
 			      machine__process_t process, void *data);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9f16bff1b72f..610bbc769ef7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4278,3 +4278,73 @@ size_t perf_session__shrink(struct perf_session *session)
 
 	return machines__shrink(&session->machines);
 }
+
+static __thread bool perf_session__in_shrink;
+
+static bool perf_session__try_shrink(struct perf_session *session)
+{
+	size_t freed;
+
+	if (!session || perf_session__in_shrink)
+		return false;
+
+	perf_session__in_shrink = true;
+	freed = perf_session__shrink(session);
+	perf_session__in_shrink = false;
+
+	return freed > 0;
+}
+
+void *perf_session__malloc(struct perf_session *session, size_t size)
+{
+	void *ptr = malloc(size);
+
+	if (unlikely(!ptr && size != 0) && perf_session__try_shrink(session))
+		ptr = malloc(size);
+
+	return ptr;
+}
+
+void *perf_session__zalloc(struct perf_session *session, size_t size)
+{
+	void *ptr = zalloc(size);
+
+	if (unlikely(!ptr && size != 0) && perf_session__try_shrink(session))
+		ptr = zalloc(size);
+
+	return ptr;
+}
+
+void *perf_session__calloc(struct perf_session *session, size_t nmemb, size_t size)
+{
+	void *ptr = calloc(nmemb, size);
+
+	if (unlikely(!ptr && nmemb != 0 && size != 0) && perf_session__try_shrink(session))
+		ptr = calloc(nmemb, size);
+
+	return ptr;
+}
+
+void *perf_session__realloc(struct perf_session *session, void *ptr, size_t size)
+{
+	void *new_ptr = realloc(ptr, size);
+
+	if (unlikely(!new_ptr && size != 0) && perf_session__try_shrink(session))
+		new_ptr = realloc(ptr, size);
+
+	return new_ptr;
+}
+
+char *perf_session__strdup(struct perf_session *session, const char *s)
+{
+	char *dup;
+
+	if (!s)
+		return NULL;
+
+	dup = strdup(s);
+	if (unlikely(!dup) && perf_session__try_shrink(session))
+		dup = strdup(s);
+
+	return dup;
+}
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index cbea6792a008..c6157eddcc43 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -213,4 +213,10 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 
 size_t perf_session__shrink(struct perf_session *session);
 
+void *perf_session__malloc(struct perf_session *session, size_t size);
+void *perf_session__zalloc(struct perf_session *session, size_t size);
+void *perf_session__calloc(struct perf_session *session, size_t nmemb, size_t size);
+void *perf_session__realloc(struct perf_session *session, void *ptr, size_t size);
+char *perf_session__strdup(struct perf_session *session, const char *s);
+
 #endif /* __PERF_SESSION_H */
-- 
2.56.1.809.ga0b61035b5-goog

