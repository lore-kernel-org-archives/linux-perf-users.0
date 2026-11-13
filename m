Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590333;
	b=akb3Iu3I7E1Gy/oTG0ofEr7XuAWlimyvsJNC4kaf8FaolEXecVnDrXyYBB45Yv9jmbXf
	 PkKoW31nwSK1lhCUcEfc6MUKlWC8HsYfLqYulkiNFqKhYq7nb8fPV2a+5+NtclBYTo582
	 qvLrHviHBZaa2EoDChKC85v9fGVghFgYT7Nk5uQ60ZLfHR96KsH2CbZENOkNQDQCs+gsw
	 Q5jWkIfc9mAUZqiVza7my6iVbCNr0ZhGmDP1z4u7s7kdXwXqE7BeZIoLgU27tYjW3sQ89
	 WyOqH7KWFvnU2wHKQh7TKPZUbq1LMbHT/C4OihbgzmJqkKr4H7xYcUvbDfznqt3oqlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YNTwET+QcjG4TCcPzrXKvg+blZi0lOb7ZaKsPW0rbuk=;
	b=fZJ6D3/pyth7mZ2rsyGKuwNXKrI3R46qUu2h80Ky9rVlM5uf1+qKHfFiZCbCt/dTMYwR
	 5KUJkXkQqyUocUAccrJlfzzic8Xh9aAQVTyc9hPu4Qv7Xwx8D27M+wEbDhz3pzhhwml1U
	 h2jtCm9QdUz3BUIL5Pl7eoCTaB3hDt/nFeGD7KSv5a2XC4PDCu6T0HtKrPzShIhSNT8uA
	 FwV1QPQqXImM8Ne769YNh3vW2BwYW86S7TjBz9ZvG5VhfYoeYqyPKrGimbjyM2Q1MRjy4
	 sPl0vwuwTUDSFzBE+yIPFdS4rAfarD9JeWIAzeqKpvFHzuow1T8psTt3dk+HYnU25jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5YxDHaM;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1165E606D851
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1165E606D851
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5YxDHaM
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so4635427c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590332; x=1795195132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YNTwET+QcjG4TCcPzrXKvg+blZi0lOb7ZaKsPW0rbuk=;
        b=p5YxDHaMUCJQAldKj3glYm38di1Z/32YSBATvpcq3bHj5fUkMlIL9dzfaO1BO8oAzE
         HGM45Szkz2PTAR7Pe2YoQzhHXhmxMEW12I4zZMH9WVJOzjYhNbMq9fF+QqjdqY3qX+mH
         DoBXjb3hGB7vgpH3UHEYN+HqUWAXKW2JTZWjfTFhyYnbW/tl3soqvqN6zyfAjlH+0DB5
         zWSzWFUEqlTQM1zePOou/5FOEwh0pC33KeGyTklW0Sa57pz2xOcd5EtNfodd55/FpgxY
         RzU7qAmP6uZbZa7TC9VyCFtVnHeXvRoyTi7g8kaYcXnOK5V9i2eMJAnO7N280QYVnei8
         iCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590332; x=1795195132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNTwET+QcjG4TCcPzrXKvg+blZi0lOb7ZaKsPW0rbuk=;
        b=D2GEmA5JyOZ1Zw6hLQXbpOvu6FibSHafJBQWA8Ri58Vwzqj7g7T7EawcfPvQBwaNPL
         OrcP58gPrmx46kfXejC0G+BQK69NhE7PdZeoAsK5cMgolUNY9GINr2bxXwH5JwQzIMrv
         WPff3XV/x883Ar+/8xtYLyaKXBubzdzbctbHXJEZN0sbMLSCTxOLANkRQrJXv1b1H6L6
         d+OAgfM/4DUKR2wuUYVW/0kqY+2WIoQQzy6gy5DFSS89C5wbFcLdE2YmbnxhR3hkVNfo
         Nz1bMP7vglojnqrivE/oPafx/sQnWq+RQnZNIqVZplvUDVboBxpxqVghpm2qYI/jJIvW
         geMQ==
X-Forwarded-Encrypted: i=1; AL+hErG5C+KA5QgzT6lmOEUwDF1u4fJqqz6gcWKpnBPEjzYURcb0GDQm53fPX1fwEOotzkWdKm/5Iu10VM/XYGzaqCkA@vger.kernel.org
X-Gm-Message-State: APuU4Z+3vAbRqE1S4A8hdXkNCVmRQwfVYy6ZpQvRsodvXx7D4eEzIgtL
	LAdAro7vAxc4cxUQDBlWKQgt3qTA9rGKTrwz20/Jkw56hdoE+84ZhqGj/Qvm3DWVi3XFlEx5p2p
	SS3Chp/jZ1g==
X-Received: from dyay11.prod.google.com ([2002:a05:693c:62cb:b0:36f:9364:dc98])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1081:b0:154:e9d2:d741
 with SMTP id a92af1059eb24-1b503112e3amr2370063c88.8.1794590331892; Fri, 13
 Nov 2026 09:18:51 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:32 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-22-irogers@google.com>
Subject: [PATCH v4 21/23] perf session: Add dso__session() and session-scoped
 allocation wrappers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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
index 184d49935bfd..7b71fd5e48a9 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1907,6 +1907,13 @@ void dso__delete(struct dso *dso)
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
index 7f217815ec07..9b01a86526c1 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -20,6 +20,7 @@
 struct machine;
 struct map;
 struct perf_env;
+struct perf_session;
 
 #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
 #define DSO__NAME_KCORE		"[kernel.kcore]"
@@ -791,6 +792,7 @@ static inline refcount_t *dso__refcnt(struct dso *dso)
 
 bool dso__can_shrink_symbols(const struct dso *dso);
 size_t dso__shrink(struct dso *dso);
+struct perf_session *dso__session(const struct dso *dso);
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index f6868ffcc3e1..d53a8ab217e6 100644
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
index 4d5bac589aaf..d8187a374987 100644
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

