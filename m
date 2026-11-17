Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941607;
	b=DEEv1vnh00EGgEmrnZaTjfKvwDq2E/fCiHYor3BpzhZ1nkpYrox6cuNboVrhyIvxrV5L
	 LWHk0eiBZP6Cjv7OQqQVyG5fzDFREaOufOyDukawReVY3WfNoga0lkogrDO6arVlmR9ox
	 QNLTlp1jZvoHXm1Bb1rLP9Fxn1Nm4flqv0BkJwW87l10z0iLDMSSD00sb3r4Vfwjhw79T
	 z7lo0TUFDwNZFdfNklVN2uXNOFHk+S3e/iZ3VjRsCN8VeyOnH+BHF5J6k6gKspAoyJ8ga
	 U9z6bMvzMAAGX3hKeu5mHeD5I7BWAIhzOqaEogdiopKBP+rSJzheEVvkbcouT49ZrpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Xd/CRfq+mPZ3eeX9W7RU30z+MWQTl3VecADLhMsBmpE=;
	b=klciio+8yGurzF3uIGIDohaFGrnGJXyRzzv3aqSkQVz0JJwAMbuZpalaGeBZdZOx9ng3
	 9t+VaIgTfN7K+5gtpMxDh+KsI7RY4zvkRcNWQIwE9Ki+Z40tToQo/yYZaXcCjCwjM8oYC
	 Vty0lW3/fK0RAZkSkRmkjEMxle1YqBf2n6tN8Id9F9YAc/B+JRyzlf0Tnk+bds/CwQymA
	 5uHLSA9xFpHLq/0ofIAu9WdnFuq+dLnHJBoHi6KiVbbBuxPuYsA/+sL847/j8pjLmq3P3
	 1tMogm/CPlca2VJ4s8LU0WHec4HynZ84agqAfRyAbjQjTV8AyPuCWYg3USA9CCYouPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OWY1JVBe;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF117606A33D
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF117606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OWY1JVBe
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a5005fd0f8so230666c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941606; x=1795546406; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xd/CRfq+mPZ3eeX9W7RU30z+MWQTl3VecADLhMsBmpE=;
        b=OWY1JVBetB0Bllyg9X+d6azkUhIwIhwrmpMBGlPZPBYcNb7BnIeKY5jzzHbeP00/fW
         wL2cvQz4JqjzuVi76uPl1PY5LsdpAsQmx4F/1E6N1xsbbynVwyrKjftAocKb+zWNBjOq
         X35FKHf3/1g2bSOq/0PZEpdfVqQR/ggFP6VXxdBvoGo2b3puKZhEopiMmzLkfy7qb9M6
         SZTBWRQhqbYCXsuTXsMTVCIUwSHiXjya6Dx1n2R1e+j+4PgLRdAi1ujvgzfuhqrjAk6J
         /1805bZy9EePigc2qZvuc/A9mIx1WGdwIt81A2vojJ4i+X9rsvjkyKIoxMPg4kzfpPjV
         MSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941606; x=1795546406;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xd/CRfq+mPZ3eeX9W7RU30z+MWQTl3VecADLhMsBmpE=;
        b=NjJQwuh4TGYqo6llCfWGBPihKxYDHt+ucPcG6BHkJ/AsvwOVGakunz0u887rKMAMhq
         2ZNa7nHozpt3xE7eSdyki6NPua2oQNRC9xGPkfKT6faQtQUqsptMscR+F35D31V2JwTT
         vpjT2M4B5KkfJKTxhOcIOprusPbvURae1xE85AjlMpfPmi+7wV8qdZyL5PZD020D2ZDc
         ZYM/mfdzh5ht8s7fqBAx0wMCC5SrmGEH1zOghZv+9/B7VIDJobD3gfi1HXAE5AiWHiP2
         1THMtj26g4jghsih7QtfbopqeEQeSqX1MWmmFCPR0GQabtn1vKKLs7xagiBBfdRcPYNO
         OHWg==
X-Forwarded-Encrypted: i=1; AL+hErHHp1kWTp55Xjgpt5oDG0BuZ3W9T73SjfW7MNqKVVXxDnT47n7fV4YtOdY4ihGR142F6QWn+1ODC9qUPQCTOeZC@vger.kernel.org
X-Gm-Message-State: APuU4Z84Z7RnMnCVUHR3//SHbq2bsZQiQ20lND3xxnztznnNzW9wbVUb
	xANVw2iVD6H3x2wwea7Gms1QwKxMhMiGQGgpz6oz/Iu9304p/7sL8DzmZgjV3IEfnzf/gokRbly
	QeBKuEExXiQ==
X-Received: from dlaj6.prod.google.com ([2002:a05:701b:2806:b0:194:c5c4:fa82])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:cca2:20b0:1b5:31ed:e235
 with SMTP id a92af1059eb24-1b543c4645emr489193c88.44.1794941605438; Tue, 17
 Nov 2026 10:53:25 -0800 (PST)
Date: Tue, 17 Nov 2026 10:53:04 -0800
In-Reply-To: <20261117185305.108003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117185305.108003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117185305.108003-9-irogers@google.com>
Subject: [PATCH v6 8/9] perf session: Add dso__session() and session-scoped
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
index 962e1ad0c463..0991a5ab7c8d 100644
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
2.56.1.703.gf848ed807c-goog

