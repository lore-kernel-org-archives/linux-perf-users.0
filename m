Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348549;
	b=urFT1mHsoshnmn+x9Z/slgO2VZ/1m6anjDtLsPuFDmtBZhjieUhTTb5W49I7c4uQq7/o
	 LXG+xxFNfSNm9IU76Is2m9z3FfAhjACu3iDJiGSgU/UUbdtHb4sA42gkBSEWMpE/cWv4Z
	 Iiz7sEURNx8WHhc9oBfJUs3i4a3cT2Vg3NbOJzwnp9xpaTtj5FLcwhvh6utlrJla7VYQW
	 19uX5puFXlkK3Vp/Xm+887IfjSDCjc3cJlwp3xMOkz2CIlp/bLZtZFKAXrw6Cvm+CIMhh
	 Y3Hbgjzm5e1IUUvUQh2rnAaDrNwti4qhfzxH7ARKxcUnNx64bQt7Sa90SQxg/s8z/eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DK6c4Mv1slcrfPYKr6p5gvaMnuNouZYdLRcM1zyRnEY=;
	b=JR5zYwrFCnQiCR/a9ClRKrCxqFgonSxkta2iHSl1TA5M0HMk66zDTm4547Kk8UDfixUU
	 hrH/lc1kH3cE+UwjXd5cg4BAftMS2jWn6by6ANmHjg8/A7JczJOYC6vcIu53hiCEdbXGf
	 zi4I6lZLUpO42ApEIqv+ixiQ7VVUjF2yZlH4p6ruBdmATZl3NHWyYU6KeViuGtumCURUj
	 GOzS/TLuFULqrfUTuvtDlqSRm10W/CmQJgGuNfQwjjwTvnvMIIO1k4BEO7xALPTQg1fVj
	 ndi6Hct1z/Z9i/SXjiEGHFh7MpSYHQrsZ8Fo4/NhpC/8EvTw+tXV/Q9LeX5VOi6f2lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TSbp4qcW;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF9606AE2A
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32BF9606AE2A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TSbp4qcW
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b08aee6b3eso2134977a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348548; x=1794953348; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DK6c4Mv1slcrfPYKr6p5gvaMnuNouZYdLRcM1zyRnEY=;
        b=TSbp4qcW1eG0z5Qw/F7SqfuRGlcQtcIzIltsRGhT+/2qxfDZ/rQosQa66XQr0mEFdA
         /CXmWnRVpflGRpiiPRaz3f+Ypbq++MErK1u6QrGJHXuVNHrriSaz+6FnunLgKqvZC8Gq
         WOCiMWE7s2DXaPxTLFv027tlgAeEwdJT8tP2e3cOmfcW3osH/csTY2QurXTp3MmicTFo
         SqdKyIMhAzS7amPmIN0EZjKHtbQMUaqVEtJ0vzZBZfoifijALxtdKApUuXbjDoAZEDk5
         kJVgRh6bkwrXZJNOP4QRc3LWQ3CoHnfhWDX2icAYYhVDkzZ51uN8elszC6pMGh5qWbXy
         OXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348548; x=1794953348;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DK6c4Mv1slcrfPYKr6p5gvaMnuNouZYdLRcM1zyRnEY=;
        b=sCYP3pnNRpTekSzNpFo/cWFlVmZJljM78TJal32hKsGh6hRJKQXiH5EkN0IAtPXqHW
         9bbix/t4qyZo6mYe4GOohFX0SkSzg5FVB3wazbtzPo3H0OONTRCp5dI6DugP+JXuxZ/M
         aDWzA97KfAOXTfJJ66uNvK1p1adZ2M5SQ3CXk8a+ieKcfFM1LtloNiguE5Qe6SSvIrDn
         Vz9U6UcchMEp1YzqeRUF2Xlk1A6x5aWgfPJiLjvaaAK7RUUUzHXpLeiiuP2chJhHyVjH
         C3JC5BGa4+FazIM78cz98x0VthohQtaos5HM6dYGw+75Op3UlgIj6j+ESuhSA16ZX/Bx
         y5gg==
X-Forwarded-Encrypted: i=1; AL+hErF0H37KVQnZEZamcSkShdW9+CmooU04DNa18m+H0GZmnlz/WrY1pvStbTPXxwD3HBNs9gDRKix9iWOJGOFv9mHV@vger.kernel.org
X-Gm-Message-State: APuU4Z8f0FlCItuX+CsH8CzjeTVburB5CkViOGx2CWJBgHulELSrZK5Q
	887teoj4jHJprrg0m0y3/eM/3VrDPxI0dUX3mMLiR7qEKav9lzfTsBRo6Cn+cZpTCZmxXlAzaTM
	16/X70ZwuFA==
X-Received: from pjbds9.prod.google.com ([2002:a17:90b:8c9:b0:3ab:fd4b:afa8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c3:b0:39e:4c80:f67b
 with SMTP id 98e67ed59e1d1-3b182eec04dmr331818a91.26.1794348548273; Tue, 10
 Nov 2026 14:09:08 -0800 (PST)
Date: Tue, 10 Nov 2026 14:08:01 -0800
In-Reply-To: <20261110220803.2503416-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027231513.816148-1-irogers@google.com> <20261110220803.2503416-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110220803.2503416-19-irogers@google.com>
Subject: [PATCH v3 18/20] perf session: Add dso__session() and session-scoped
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
index dad06eb865e6..c89f47ba16f2 100644
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
2.56.0.542.g3ef89b7020-goog

