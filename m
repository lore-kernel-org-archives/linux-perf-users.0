Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142960;
	b=TPun/TDEertDdGq1IViJij2lMcgPqJPia8shr+4690pIsKdoe5K32wFWBRpTh+WKxtjk
	 rRPhX2dZgo3FoXIcyZ5v+2bIoE88J863q5kmB4j1Pu5DgYNx9BQ97oe28yYESkUUyiqt9
	 tkZs+hCm+ftJ0i+FGjSo8qwMxYKHFhZc1cwRGoLrvanZgdtwzunKHH0gJ5kudP3TEiFYd
	 qW83+XPcrvi7YelGQ1RQhyfyTmAZgN/86BnSBCaLHIvxAHaCFkbbdvZsMsOr2qLU4RxcB
	 jbTA07C4X0YW3aC5JeEjkes4pmCWvu3QgO6ZUGVNilxaHGq2uH6f9bPe2h4biSEInhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=PSRUuYVScs5YDAdK/rEKoIJPWiUmEgBEIyRrE4KDdTg=;
	b=3MimNTYeyYIQ2AQgFVByOK7HUkBWc8Vwh/6Q1eAPG03OKEnbtG2lXzNXa/H3DCplnPiP
	 iluqF02CXhzAw9179J7YaCTzpRMTjLdDJ8CuOhjv3dZH/QDyBNKjjsdM0B8HqcSdilJNV
	 XB29h6WrPMXhXm3dEWgOd+Bo1ibqX0HXgYwPC+5EuJK9J6kY3WsDgvQh+1EWUWI0OSq87
	 eNvuvm3DaXYv/0vCICfVJg/eQ33Nw3DXN1QYF96P7f0Bq52178LH2VHsF8ofx+tWfMoAn
	 6NFpehjJLGJHJpe/+WS0EgmBZ4n8Vnx48uGXp4qo2FIhlwewNZpOrJG3qQ7jihA3wiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G+zw5RHx;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF563606A323
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF563606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G+zw5RHx
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso619447eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142959; x=1793747759; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSRUuYVScs5YDAdK/rEKoIJPWiUmEgBEIyRrE4KDdTg=;
        b=G+zw5RHxOHYfSJzAcBvtcAUgySKLTQduT2upslEslEB7TTMyvHcpWf8HJPktoM3YVb
         8vP6LnP5JvDum/9bEb+YFh1lGRgDTB2sF+tHRSYsapBUAhYHgXvV11Di4rd6PF0qUqnL
         GGCZCs5z+1ngsadFJzQYQoqekNTcI6oCBP4Bp9pbRMrnPT8Bz3WiNmGHLpXvKnCg4bpO
         B7nCY2KagweXZRTYfNGJ03K9WLHtahWlTEo0Rg5m9YiK+XYo8ez/u2qMX9JsYCpuWDpY
         kpnHa+e+MlknAFXK4LVFAM5pCJQr+mObD7FVGUcAgQ/zgobu5kebn1LkfagPGXGB8zNN
         V/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142959; x=1793747759;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSRUuYVScs5YDAdK/rEKoIJPWiUmEgBEIyRrE4KDdTg=;
        b=vruM6kERwls/NaLNNodcU72xg6n+dfgeMIz1VGfj1LrPy0W+1SJcP0mpimsQOtzJXr
         byc53HoVVmACJOOBc+lCa7KtSpWW2AMLAKLSjHatj/mtAgcg7EfojGU3xtsOP+nDxX3K
         ENDqQws8X9ZNg5zzlndWicgK7vMmUvHsra0i0SsDd9t6x36B3McwT1mKvGPrUeplX/tF
         gYIabYBHDzDZRzXxsYLwZQvQ62Dsia+smwbcpbbiEaq3RwAdaltIXzujOnXcre4hLD8D
         BETVlTcIHagZU2zfE36WKX+rvKUwFJ3io+icFBaMqZIhOJVg+x88ybGMo6exIMvhN2QE
         8JlA==
X-Forwarded-Encrypted: i=1; AKwUvBzcjYEN6czRiiNZsV1JJuXRMVh6Ps0VwoZRC1uwEoL1CPiRZODSmLuEAjy8xvedHOGn8twx7OFqxskFBJQf9cKX@vger.kernel.org
X-Gm-Message-State: AFq9FYKcDcSgmlgNyB3zuAu74BwCh/wrzyIV+b45X1xuP3ZiMWMUAQbl
	bbzfev4fxJxmMjX+asV/87Tezly2/QAiGFikl45M7YS1FAzwr1CsCsMYXt5RT92oXn7ruGoZpWp
	C4xVSbk5C6g==
X-Received: from dyclv11-n2.prod.google.com ([2002:a05:7301:618b:20b0:353:41aa:1e9d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d508:b0:369:7c:bfce
 with SMTP id 5a478bee46e88-36a2014adcfmr1777430eec.14.1793142958527; Tue, 27
 Oct 2026 16:15:58 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:10 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-17-irogers@google.com>
Subject: [PATCH v2 16/18] perf session: Add dso__session() and session-scoped
 allocation wrappers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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
index be257c77ab0a..c19de9ab4b24 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1911,6 +1911,13 @@ void dso__delete(struct dso *dso)
 	RC_CHK_FREE(dso);
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
index 64a118ea2524..5fa059ba6cf1 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -19,6 +19,7 @@
 struct machine;
 struct map;
 struct perf_env;
+struct perf_session;
 
 #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
 #define DSO__NAME_KCORE		"[kernel.kcore]"
@@ -802,6 +803,7 @@ static inline refcount_t *dso__refcnt(struct dso *dso)
 
 bool dso__can_shrink_symbols(const struct dso *dso);
 size_t dso__shrink(struct dso *dso);
+struct perf_session *dso__session(const struct dso *dso);
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 30ecc9a19244..8f3e3f3c6ce3 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -18,6 +18,7 @@ void dsos__init(struct dsos *dsos)
 {
 	init_rwsem(&dsos->lock);
 
+	dsos->machine = NULL;
 	dsos->cnt = 0;
 	dsos->allocated = 0;
 	dsos->dsos = NULL;
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 151efdba2aa4..d636e4c5cbaf 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -19,6 +19,7 @@ struct machine;
  */
 struct dsos {
 	struct rw_semaphore lock;
+	struct machine *machine;
 	struct dso **dsos;
 	unsigned int cnt;
 	unsigned int allocated;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8d0c545ee544..3e0d68fd5efe 100644
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
index 1d1f46a01a38..ab67cef67c80 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -164,6 +164,11 @@ static inline struct perf_session *machines__session(struct machines *machines)
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
index 3f35c7affc29..3d4bc9c0063a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4274,3 +4274,73 @@ size_t perf_session__shrink(struct perf_session *session)
 
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
index fdec65fcfee6..90ae16a631b0 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -219,4 +219,10 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 
 size_t perf_session__shrink(struct perf_session *session);
 
+void *perf_session__malloc(struct perf_session *session, size_t size);
+void *perf_session__zalloc(struct perf_session *session, size_t size);
+void *perf_session__calloc(struct perf_session *session, size_t nmemb, size_t size);
+void *perf_session__realloc(struct perf_session *session, void *ptr, size_t size);
+char *perf_session__strdup(struct perf_session *session, const char *s);
+
 #endif /* __PERF_SESSION_H */
-- 
2.56.0.313.g2479322e68-goog

