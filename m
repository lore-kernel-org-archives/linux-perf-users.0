Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245459;
	b=wx/6XRzI/lsc0ISefsMzS5kIJMx6nf1bUzMqPQpU4ah+RMmHWHRaueoUZRkqe/NBbn7b
	 5IgZO6EMccf9AMEu7cpxrZPHDN0n9Qqb6hvDCx1oO1oVE5nJoJNlGSd4ZNMl/fxkpaJR1
	 atG8oFvl72CaiFr4+s1/vgBjHTQtPYbgC67km+CXt6puSqSRFHmi8YUbDBjgI49+5sv87
	 AjxiNOlVOZw0CFrve6FCsegxQWr+N8Gh9mcREvQvZ1XqWlhtmuUgm4F7wY0UKavxK/BXU
	 IJoiBX7OLlAxX47XRS/xGQLOh0VEO2VfWNuzNxuse8JdZQOlP1IyUEsbvSdMmThwjCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=IeTGPzI4maC83QTx1YRaKrTXNXS/iGl6uwLAUWG8Zrg=;
	b=09m3e7e76YrnfNiSci/PK/jrGPljsITyy0Uac3IrO/wd6etoUm6iYG2qj2B1I9KaRqlt
	 dsHeZn8IIdTCzt1vl6O9kGdLPrQWI2nOex3fCg5l91OBljB/wgxU/T+9+viHSD7bmkG1o
	 19bzskKeQu6jQ3PoiVnvLA1SKmaex/z2SaB9q8pSU830IYnO1y6L8elVLdpfYUygXkF9k
	 NEbOFwPQetrk9GrIFer8TW3e8SpTQdHfEYPTVffAEbD4wt3VCK0haAoeVcORI0bL1hfs3
	 f3DWV9Lsy6uucF5puc13+zNaewAOGtfi0CkW2dr4Mxtve5KZ92mmtx2Yt9wkCji9Dgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PrS0tu29;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A77606A32C
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A77606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PrS0tu29
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-38531c1a566so4091002eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 23:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795245458; x=1795850258; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IeTGPzI4maC83QTx1YRaKrTXNXS/iGl6uwLAUWG8Zrg=;
        b=PrS0tu29NJ6dqMFgXCrdGcYfzIAMKskZ8RFB+tjNn/PSXKdvkQxWBzGE3btr4g4WiL
         NWX/73GbZjKvmSZcjJz41ZuPmVYx/RzcLkgsxoNoaDbFtEPfSTMjKzg1BimO6x0QWNL6
         S5YVELktvCMknOwu/1hNy3hTVqTH5TS4ETrf6t//ZIZLgyAFF7StkyQYxZghmX7T5YU8
         POqmwIZSpx58jt5VjD2c+YzRpfG0PSMBiYCMaUCS0WgrEaZp0b1UZ2N1KY9mmTS0kDWN
         rOEMBZRAlAWmCymZ4ichUiWdRfQ/ce7mDxIyDPBsxO9Vj9uG9KBW+cB0ev3NTiIf/aZn
         inUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245458; x=1795850258;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IeTGPzI4maC83QTx1YRaKrTXNXS/iGl6uwLAUWG8Zrg=;
        b=H5bwFiLe4gMpwb6k6KN5Q0Kia5QNuTL6xHyaSQsavsiyRBoMxhjxQNW5LdtjYwGXsN
         O11WHHacMnOG44ELVJrCdw0yfi0QhK6z0vNettbXvlDGYuTF7m98HC9Y3XlNCGMLe5C3
         3gXDnSr1skcOUivH2dGxzUz2yqZIw1RME6Y7CKPj42/9TYAa32+jKlbl0e+p1xjlBVcQ
         L6fs1aci2QSRcUTcQmQt+aDuoKxbRgGpjQZyELgElqwNLSagTR67Ax13aNB+EI1sK47m
         J73SE7jP8PMRkJu/ygbjcM32k72D8nu2g7QGNgZjWyrYiI/bM4Ey8o6oHIlhUqT6RNs0
         sj4A==
X-Forwarded-Encrypted: i=1; AL+hErHJ3onCQ4vuYinGFxOMkf/ah5v7EXYUYoFPZYcdLAstGO44UbsLL9KE3iUzdHE/H35pIAmNiNGRYMesUZtyixCR@vger.kernel.org
X-Gm-Message-State: APuU4Z8NU1x4YbGH3YMwYQPq6b4FjpHgyqturuX/6P8/6ma8sr4xTuzV
	afDOaT13MXM8LfbNKLwbabd//8olzbOCzy3WWjJ13CyifkHEJTUBOmLZJUnKKt+3gwNxaWxLcY+
	au4/tocsReQ==
X-Received: from dycne3.prod.google.com ([2002:a05:7301:c83:b0:36c:99b8:3ed7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c695:b0:37f:73f9:aee7
 with SMTP id 5a478bee46e88-3856c9a6408mr6002266eec.5.1795245457874; Fri, 20
 Nov 2026 23:17:37 -0800 (PST)
Date: Fri, 20 Nov 2026 23:16:50 -0800
In-Reply-To: <20261121071651.67118-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121071651.67118-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121071651.67118-10-irogers@google.com>
Subject: [PATCH v7 09/10] perf session: Add dso__session() and session-scoped
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
index 0d205015c6dc..ba070611c18a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1933,6 +1933,13 @@ void dso__delete(struct dso *dso)
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
index 0a8df19383e8..d4360a6ed8e0 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -20,6 +20,7 @@
 struct machine;
 struct map;
 struct perf_env;
+struct perf_session;
 
 #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
 #define DSO__NAME_KCORE		"[kernel.kcore]"
@@ -792,6 +793,7 @@ static inline refcount_t *dso__refcnt(struct dso *dso)
 bool dso__can_shrink_symbols(const struct dso *dso);
 bool dso__try_evict(struct dso *dso);
 size_t dso__shrink(struct dso *dso);
+struct perf_session *dso__session(const struct dso *dso);
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 52d80219ac2f..343c79c7ee37 100644
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
index 60eed6ae3ba1..d3a93e8a4743 100644
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
index 0f4c0ae5b56d..6192bd3e33bb 100644
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
index d5cb5e94a54a..0f3e44fa4486 100644
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
2.56.1.750.gf70dc682cf-goog

