Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257746AA8E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665128; cv=none; b=DQjFsFMtNGMCz36fdLvBeEIqb/uWjQZD1P10jb+MgxHAcil7WNWXSGmAgTcKBYkaytuKX5PAnWW+/7uyMncsxcuW7T69dyrp4KtguSkYbrbn5bVgLFNU+9aVPl7Cllbg7Nd315O1NLpYFkP4uhuela1+VWMSP7BOEkFHNQaPX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665128; c=relaxed/simple;
	bh=LIT+Mj37AFxcZ2d9dpxAPCt7wuvSBRTDOaeA5wZ8cyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOr9RJPBOPvEevBkMlhicTAQKPBNiuftefI51tv/GjiFk8jYGzvqj9qqC+6VdkXqYG5iGbLMKyDVlE1VsCvtuambml6+skz6xh2mZzRhakuZ0yui4wJLtkCovyMbRrvkOGUj/jvj8U2WTMD8j5xZJGF+qIRjM/QnTjWNuZZA1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sgdh49fs; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sgdh49fs"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-349ffa249bdso2632845eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790665126; x=1791269926; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dL1YrJB9DStko+tZvm0pEZrXZbvhA+kH5+rHsbWDgE8=;
        b=sgdh49fsgqqTQQxlPxJhCJOq7kzaYP+iuFBovCfsflZHt8Q8RziTNOSB4H2ttv0gw9
         Cq7Xdii3vIcxf/01EtiCbchikzCMqV50F79kBdjoxVdzqvGzyQiFSu7b97DjYHQ9KT2l
         B6ckiVjhvwrnfTzF/d3QvCb+MwB7o8H8o1XnoJNPTfZJukXL/y73tuedZR51fU216AfP
         GAF3V5EzGCKfye21MBiN4mJojOFkutKVoV4+E+sUWa0Lw94UrLyLYT5FAc25LfvMiyBv
         bu3KIRM4dI7MKqqxdeHHOUfj2y8h0inaH+QGiWQ3sxO6x4iEFUow5gJ22UVY/NhGsPoc
         ymUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665126; x=1791269926;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dL1YrJB9DStko+tZvm0pEZrXZbvhA+kH5+rHsbWDgE8=;
        b=m41N6GiNp/WvfuycvW//vfZceVH9OTjiK7PsJ6XY5bEyxUQ9BszwPRhp91vGN/5+2m
         GvKZAu1Q6VFbZRnKVLvQLnJgafX9kpogEvcUYZVOREiHejgq8yzlWPlwkzlFMlumdS9K
         Si43UC1kfdoP00ivFZ5K8wARoI77QXfH1Swp2Jr7hwC2LLrw7EViLDSO4jULxs1/IAm0
         5skPpej3dUFfWFgBspmgcbNW3tc9fAKqjv9dZZ6i4L7qby8VCT3GbamU8HoKKvO26Xb5
         YElBSOjVtIz53fPHAif22t/sxw2WcH3QZW6i1UHloHurNMZV934q5evl0c88SeyI4+JE
         wGew==
X-Forwarded-Encrypted: i=1; AKwUvBz9qY2aGVZEZnWp4cxxvcIog29Ql1iz2thT8BlfoejYxRGU6aoIsE3k1qzU4FgZudi79mbMm1/I9bI5dZBENaK3@vger.kernel.org
X-Gm-Message-State: AFq9FYLOqwLS51ngS57kvoWvcbbbQ833DCRBv7npjm73YxlAGOdCWMgB
	tEeEfJ2OqwcdhJvv9cYr5fNy/vxi0enpSSCXzKUAsqlKLc21TpdYBuFuNzETRCc0JZiQRf88XJ4
	p7hVTQjN5mg==
X-Received: from dyjo40.prod.google.com ([2002:a05:7300:33a8:b0:341:6552:8c35])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8189:b0:342:e7a0:2829
 with SMTP id 5a478bee46e88-342e7a0534dmr16465081eec.26.1790665125886; Mon, 28
 Sep 2026 23:58:45 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:58:31 -0700
In-Reply-To: <20260929065839.407062-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929062937.374137-1-irogers@google.com> <20260929065839.407062-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929065839.407062-2-irogers@google.com>
Subject: [PATCH v3 1/9] perf evsel: Clamp sample_id size for ksymbol, bpf, and
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

