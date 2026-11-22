Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323893;
	b=FLsc1E0P7LOfBrSwo+51Onvnsqsfg09pe7gXYPCwztD5VM5W9y0UBuY78OMYjBnI4R94
	 SfwvuEOeOI+Xa+M1Kq0XlYpBDWzhCftTN6erktOK6aG9ksOi9e+edDXAWCqatfT7JBfoq
	 a0kOfreqyvE2hgepCUCshYIv911QT45UpFC2lN5P0j1iytdZ6XdPRSCOFjQ46xlqMZz1h
	 YwIXer7JxZC2HDr5ynCCBrrqvCqZ/xbbdAfOR46zFvtEzLE6UuyEY/3Y+qrwEgrz+Cmyi
	 Sc+tY8G0pEPXN9DW4dIOZejnHCd883hrYGzQ0oMRLtD70yxgR3ygyXCzdPgVkJERd7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9+9nQInNjKHi9FhFczD5gPabpM6jI6Q6X78w4bQJNUk=;
	b=pAHv/uTr5CiU8dKyCr6FpTvoyxhpXZYp1oLBeFHAuGvMU9aqDqimxfY5o4rvDWFmbOF+
	 YHuZj31/zE4OIsPU0zpEfTSH0U0ejThrOQfgQPoKmE36F/+7LWAP1zejbycrY2v54DYSR
	 949CAoK9ZF5D+e+BINRSuMZ50cizNtc7szGRsLuRQZCP0pWt9HmtkhAdvVH9re3xDyl7C
	 xUqF6qwj3Ih9PXnDDYvm56LorV6YXbpu+xaoFAd6X0u+NlslRdyl3ABqRU2voL9iUO56N
	 6sbTkEvbBG9ecQqAzh73zePEV+AXfLsqNo6d/thMWG9MwrcXlVKCqlHmjiHi1MBfLhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aOuWn5uR;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C251606A33E
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 05:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C251606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aOuWn5uR
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386177b0516so6165015eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 21:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795323892; x=1795928692; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+9nQInNjKHi9FhFczD5gPabpM6jI6Q6X78w4bQJNUk=;
        b=aOuWn5uRfTPBUqxtMY8qqNpZ/9Sez9AwzIxTMM4CEBb2A8bj1Zp29FHOoHwPTGG7W+
         q+sTY0vyOg8q2j4niO5vMN2NbxvJ0Or7jZsyGXzH/BMDb0sW278PUDZW4eU/m6BRKC39
         UZJofEfoahZCVXou7wwiu9kEOvkYT7q0YIzz8Klg+lJXAT2z9TkU/JTcNhrlgOTAIRoZ
         CmE5/0P4NnhtIrY1j0xgweR4g+pkU95QQMTuNplhaisJqjpG7J/9Vzv73l9EykKcigmY
         CyEF1TctuLLdoX4WU5e6dbeRgWs9aGXyESYVvWNc3TUMsWO6zzuangEraKyvcDEPPUuU
         PURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323892; x=1795928692;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+9nQInNjKHi9FhFczD5gPabpM6jI6Q6X78w4bQJNUk=;
        b=rLQW/kuerX9OzT4nvRTExA3ZbtNdFiJojp9ohEA/boIDmmZhWGuVDp9WnsuRtTP5ko
         HlyzDREGE/ojpWkH7+5TAHMhKUougOdxysJIJxHr2XwHJOR4zkwFv3qU+7T/HCqAoE5l
         gb/NdzshcAeblRWWHBtbLU+P2cmvPpe447v6yRZ2Ty3PHTzdAPjctM1p1/dX/CK7qJMw
         J/B9u2ZTsvOkQ6rLkuTIrFHpoALijiQ6lmU8sNjZXU5a4I1tePIUYj8GbLpGYO6bpaB+
         v8o10HEpBQBuZtf6lyhPhASMbyob3X2TcwzF20SBN9cnkZjKO6kxVVPQxU9WML5GpSbM
         /e0g==
X-Forwarded-Encrypted: i=1; AL+hErGB8nEUUBaRthbFW7w8WLsHQaAmvqGMg4RNE7lQEp5s967lGpV5JoE05lC3UOBvf6pngOBW4Y2nHzdn3R8cvIrA@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZYA9IWpSQ+Sj7KNkv+cswVeEB4NTOj1i6S+l/ZWl40gvcnCTe
	78UNtLa99VmcgduTOO5f6waGt/Ltc2kAyJXeEvuGQvMM+i4wnMs6P6oGq41pPTOTCp+JuhICq8u
	744rbwoydtA==
X-Received: from dybfe10.prod.google.com ([2002:a05:7300:bf8a:b0:385:416a:7356])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:f02:b0:384:ce59:5e21
 with SMTP id 5a478bee46e88-3856f6503d8mr8265867eec.32.1795323892076; Sat, 21
 Nov 2026 21:04:52 -0800 (PST)
Date: Sat, 21 Nov 2026 21:04:04 -0800
In-Reply-To: <20261122050405.80335-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122050405.80335-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122050405.80335-10-irogers@google.com>
Subject: [PATCH v8 09/10] perf session: Add dso__session() and session-scoped
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
index dce9d8d7838c..5ee30964b3df 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1912,6 +1912,13 @@ void dso__delete(struct dso *dso)
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
2.56.1.750.gf70dc682cf-goog

