Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CD42046B
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663388; cv=none; b=LKm51nr7mxL6l07IZoD1cMkREnaFSt/v3dgJdqg3nn9RENcyjiwNsnu4MjusKbJPhvDVWdwkD81UiLwwhV5JOQYbV1wZ91cSMf2gkjWBgcY/1GKz+y5qoXjuCIRYYCs6qHqmynQkVIiQ+i3EZZkdak4mwFx+fQKCckImFQQJxxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663388; c=relaxed/simple;
	bh=LIT+Mj37AFxcZ2d9dpxAPCt7wuvSBRTDOaeA5wZ8cyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=afGM6J0IqfYfU3+pe52nO5XE58RcQv5Fyio+0fXeybmViPnB6gmU1StXLK0hUukFkzHa7q+VbWPHQH+efuTT9mwaPcEegOuKrvRJ19+Z1NuvZZ6CO4RccrWjz6xgT0RS4nZVSXe5RyFaeABqZKditTdnFTo/X3ssQrqQcJ6RNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GPbRnJrQ; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPbRnJrQ"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1384427c3efso5846286c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790663386; x=1791268186; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dL1YrJB9DStko+tZvm0pEZrXZbvhA+kH5+rHsbWDgE8=;
        b=GPbRnJrQwk4eLSyz57b03OZ8H6r6SL2L4TBEk3AQgLz374XgYEAfBegF3326c/28Uu
         xOwUBjzme6vAfgjfK0ZmdwR7PMLsCQvAU+nxu2Ci04ASlH16nllJ/6CZdQu2SNN3fkV8
         JA6Bdq8GjLLaX7bgzctZ8oM+w/eR4TbZed3tR0dGNs1Ofz/cVPfBCJ3M/yyWED7MHWWK
         FOmHWKw4Ql8KepvD28b9m04n4+ZtKgIB7K9OZr8J+5CF7ArphLExBlM+dqRlFMZtjeN9
         0YA7Z55BASZr7hfCYupURvppFplxAw/EN48buoG0HO+jDohXO+zeuyuHMdvMK0+D11PP
         iWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790663386; x=1791268186;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dL1YrJB9DStko+tZvm0pEZrXZbvhA+kH5+rHsbWDgE8=;
        b=nGTUnYYy/6ksvwnvmkUlwrh+1yeZbzrJe4FSScje4pa48CmQgECM+lFf6zV1wTsVa1
         l8mIuQokWZ2vhHwS92FkBfwUMApjAiyZo2cGAChfY8ouJ2tbVBTdaE6D3YBQFZwWxbiv
         2evCgMfZ5VrJMsno7ljMGGSocmDeeaq2Yv2SZDt9XtANRaFUkSquQuGDReK5/c8cbIjB
         Q0Fc+uE1K548fJba2+9HR8oPb7qrZzkjuMglx8+UnKiYU/8HI5EQtPbi3lN8LWuUeeIT
         3t6Ix2cuN5cQ7kXmU22Wdn6COrYURg8B4UwxHjaQHCLHI6dJFKWTFoSR4nTKv9XIWTs4
         9y+g==
X-Forwarded-Encrypted: i=1; AKwUvBxo7BjFj6li4kQr8VYmUx8BNWCZ3eCZDFmAyEE++CS+EfSJ5nrBlNCNFerYT2zKoGyyAbGGSJ9hxIonxHpZ9TwQ@vger.kernel.org
X-Gm-Message-State: AFuF++nuaZdAm+poZbw/DYvUqLvZWMXB0XmSA9l3c74a+wWBVx04GM+G
	tSGoi3nLVKnEAfZJguqAuXy7aXHT5kDIxBB6YNXEjq1mzOKWWqK+y2LWilcxzso+CsZgKjcpQEr
	JLz+Tt3hj/A==
X-Received: from dlbsi8.prod.google.com ([2002:a05:7022:b888:b0:144:bbd4:62e0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:603:b0:144:f47b:d31a
 with SMTP id a92af1059eb24-146ce29fdc4mr17148626c88.1.1790663385981; Mon, 28
 Sep 2026 23:29:45 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:29:29 -0700
In-Reply-To: <20260929062937.374137-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com> <20260929062937.374137-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929062937.374137-2-irogers@google.com>
Subject: [PATCH v2 1/9] perf evsel: Clamp sample_id size for ksymbol, bpf, and
 text_poke events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On kernels without the fix ("perf/core: Restore header fields in
sideband output callbacks") to restore event_id.header.size in
perf_event_ksymbol_output(), perf_event_bpf_output(), and
perf_event_text_poke_output(), concurrent perf sessions cause those
sideband records to be emitted with header.size inflated by multiple
id_header_size increments while the single id_sample is written
immediately after the event payload. Indexing backwards from
event->header.size reads uninitialized ring-buffer bytes at the end of
the record, causing evlist__event2evsel() to fail with -EFAULT.

Add evsel__event_size() to clamp the effective size used to locate the
trailing id_sample for PERF_RECORD_KSYMBOL, PERF_RECORD_BPF_EVENT, and
PERF_RECORD_TEXT_POKE to payload + id_hdr_size while leaving
event->header.size intact for advancing the ring-buffer/file stream.

Fixes: 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
Fixes: 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
Fixes: 246eba8e9041 ("perf tools: Add support for PERF_RECORD_TEXT_POKE")
Link: https://lore.kernel.org/r/20260929014206.4175245-1-irogers@google.com
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c |  6 ++--
 tools/perf/util/evsel.c  | 59 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h  |  1 +
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9392d912d254..c2402e4791b6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -973,13 +973,15 @@ static int evlist__event2id(struct evlist *evlist, union perf_event *event, u64
 	const __u64 *array = event->sample.array;
 	ssize_t n;
 
-	n = (event->header.size - sizeof(event->header)) >> 3;
-
 	if (event->header.type == PERF_RECORD_SAMPLE) {
+		n = (event->header.size - sizeof(event->header)) >> 3;
 		if (evlist__id_pos(evlist) >= n)
 			return -1;
 		*id = array[evlist__id_pos(evlist)];
 	} else {
+		u16 size = evsel__event_size(evlist__first(evlist), event);
+
+		n = (size - sizeof(event->header)) >> 3;
 		if (evlist__is_pos(evlist) > n)
 			return -1;
 		n -= evlist__is_pos(evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3367242c5764..9c5e7510f0c0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3216,7 +3216,7 @@ static int perf_evsel__parse_id_sample(const union perf_event *event,
 	const __u64 *array = event->sample.array;
 	bool swapped = evsel->needs_swap;
 	union u64_swap u;
-	int i = ((event->header.size - sizeof(event->header)) / sizeof(u64)) - 1;
+	int i = ((evsel__event_size(evsel, event) - sizeof(event->header)) / sizeof(u64)) - 1;
 
 	if (type & PERF_SAMPLE_IDENTIFIER) {
 		if (i < 0)
@@ -3966,6 +3966,63 @@ u16 evsel__id_hdr_size(const struct evsel *evsel)
 	return size;
 }
 
+/*
+ * Prior to kernel fix, perf_event_ksymbol_output(), perf_event_bpf_output(),
+ * and perf_event_text_poke_output() in kernel/events/core.c did not save and
+ * restore event_id.header.size across perf_iterate_sb() iterations. When
+ * multiple perf_events had attr.ksymbol, attr.bpf_event, or attr.text_poke
+ * enabled, header.size was incremented by id_header_size for each matching
+ * event while only a single id_sample was written immediately after the event
+ * payload. Clamp the effective size used to locate the trailing id_sample to
+ * payload + id_hdr_size so events recorded on unpatched kernels can be parsed
+ * without reading uninitialized ring-buffer bytes.
+ */
+u16 evsel__event_size(const struct evsel *evsel, const union perf_event *event)
+{
+	u16 size = event->header.size;
+	u16 id_hdr_size;
+	size_t payload;
+
+	if (!evsel->core.attr.sample_id_all)
+		return size;
+
+	switch (event->header.type) {
+	case PERF_RECORD_KSYMBOL: {
+		const char *name = event->ksymbol.name;
+		size_t fixed = offsetof(struct perf_record_ksymbol, name);
+		size_t max_len, len;
+
+		if (size <= fixed)
+			return size;
+		max_len = size - fixed;
+		len = strnlen(name, max_len);
+		if (len == max_len)
+			return size;
+		payload = fixed + PERF_ALIGN(len + 1, sizeof(u64));
+		break;
+	}
+	case PERF_RECORD_BPF_EVENT:
+		payload = sizeof(struct perf_record_bpf_event);
+		break;
+	case PERF_RECORD_TEXT_POKE: {
+		size_t fixed = offsetof(struct perf_record_text_poke_event, bytes);
+
+		if (size < fixed)
+			return size;
+		payload = PERF_ALIGN(fixed + (size_t)event->text_poke.old_len +
+				     event->text_poke.new_len, sizeof(u64));
+		break;
+	}
+	default:
+		return size;
+	}
+
+	id_hdr_size = evsel__id_hdr_size(evsel);
+	if (payload + id_hdr_size < size)
+		return payload + id_hdr_size;
+	return size;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name)
 {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5c5799cee601..174f3414fd3c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -469,6 +469,7 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 				  u64 *timestamp);
 
 u16 evsel__id_hdr_size(const struct evsel *evsel);
+u16 evsel__event_size(const struct evsel *evsel, const union perf_event *event);
 
 static inline struct evsel *evsel__next(struct evsel *evsel)
 {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

