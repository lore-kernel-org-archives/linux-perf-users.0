Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567899;
	b=roZOTrIQdLK9DceyxUjWygoVyOIvE58uKAozvbp0t87BWjM3twtUcwVTO41csByWuRd/
	 i5KUZMAr4uV64NfEH5f2E13X5mJxKuKrGBTXdjKu40XJziS5BrQMWyZsD2mBrNMk+MxOi
	 dsWf0I9qW5kh+kAh4fQh8f751mFsPGwMurbGOK3tcpWDf4lhkWlyqI+WApjsfJufS8coF
	 ewce6ji8+Ofnk14lYPvDZsOAG8Dma41m3sFDrKovGNt31wPF9reW41Khy2KudHl0OWGGq
	 L1bZd6WYGmkHnK8uAM3SGlSTs0eTlKP37o6xfqLJGgTjQuk+AVNOHyghJ4XOxPgeP3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hxdvay7U0/BBeZfYl/Gpe4NfIxkEt+dQD8AyywWI8jk=;
	b=UIcYPyem7TKkE183xGMi+3lQh4mDYyY/PLrV4wJZelTJTW+apzHR0zE6mlKPajJpnm4w
	 7gmhx9aZibXSjB+FMOs94TDVMeXNygNa+wp8UmS7eU+4EKLTRbeJz/OThG6o3Ndmv/YaN
	 iitQ7PWNkn9/FBG1oLFu6DLDhqKJEtv9V5QXyb+beL64L5N38n09dyJGOdnDwPbrOysC0
	 jivP6fmG83N5X5H+A5FK9J3nmuuIm5aXQNVQf411o/JHK2K4h+VSlp6yTb3EeWr/N/lXK
	 avt74d5G6K/lDCtvs2NqcjkjxXr3mrmEXr93rU7KEctwApRYuVe0vGjXISNuzOW2D0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nADbDIYA;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F760A2613
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E51F760A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nADbDIYA
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso8844843eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567897; x=1796172697; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxdvay7U0/BBeZfYl/Gpe4NfIxkEt+dQD8AyywWI8jk=;
        b=nADbDIYApLD3nFr+tiy67fOqxsGbBgsz1VwKTgR6NVC06Al7KSWlNVBQNwE07/HC5W
         42e6JzVGKOuBz8h9fo6RO3dP3spzLZWqjwM2aeIizD7w+Quf32gQMvL8H9yTmJm8mUQb
         kL6CIccM6AvXNTAH8jRjhjZfxCeuxZ/lNSc91o6g1NEtFZNsTxnfOsRycfujmbd/oKzv
         UYGvyUAdu4KhSTRfkbBjVSQp9k8NQaLeIKkDZKz8MO3daLJGCSkzrgrYuudqJAbsfhBK
         qImQ9TQAbM4FLHxAlHnHuFO+rK0oSri/O6NPHXMKPx4vau3A1PV99Jv9XD4sx3kzcRXf
         jI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567897; x=1796172697;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxdvay7U0/BBeZfYl/Gpe4NfIxkEt+dQD8AyywWI8jk=;
        b=AF4j3yUkbUTEzafm1bmrbrlWSe7LKj5pM+Jl0HXCxDbFRVKOUjQ20XvIu473FBS5wZ
         yd4BxtUD2+nBgN4vSIyhgT3vRKZahVjtuSlMna6JgnPmJXTCi9Ru2zwjFOmAhAvzZdxS
         q34vgtI4wDM7jcxqqAVYt8j0jAMvmKs4Igh7xUwnrE/y6rTr3uScH5KnxOgbuxqDNoBM
         9TgPnhVc/Jt65SS2uJMZD5tyAAw0LPeEUtJyNI1OyqcF4FcokU/JYZLZ+zsURVrQz1Fa
         nzvVUMsK0STL726T9Wrdi0DNX1ty49T1/1v/yhYEFvsWDl/o4/Rnr7zN1u6nWonrwYfH
         DqwQ==
X-Forwarded-Encrypted: i=1; AL+hErHQvNrFYMTD37Y9WXSLr0o9FnmEZ6OH8jBhwAD/rcQO65GPhsFLJkm0NZgd80hQo72XhY/2CZcvK3Sc9L9jHKPW@vger.kernel.org
X-Gm-Message-State: APuU4Z9zHWpSGcGCd2BCYhZRGv55Rescn5YJlSEnme4PfHBwLdQXX9du
	//U6lJqcbjC6vc1c5O5liEAcVbA1qYMP0lZaPsbLXFEwIApAnxiMPq2LjiKgMAKDwBqiw8eYOe8
	HelfiEAkghA==
X-Received: from dycph1.prod.google.com ([2002:a05:7300:dd41:b0:36a:ead:4dcc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e60c:b0:386:636f:c25e
 with SMTP id 5a478bee46e88-386636fc6f9mr19390158eec.12.1795567896675; Tue, 24
 Nov 2026 16:51:36 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:57 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-9-irogers@google.com>
Subject: [PATCH v4 08/19] perf session: Avoid double byte-swapping re-parsed
 deferred samples
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When perf_session__deliver_event() processes a cross-endian sample,
__evsel__parse_sample() is invoked with needs_swap=true and byte-swaps
payload regions such as PERF_SAMPLE_RAW, PERF_SAMPLE_BRANCH_STACK, and
PERF_SAMPLE_AUX in-place in the event buffer.

If the sample has a deferred callchain and merge_deferred_callchains is
enabled, machines__deliver_event() copies that already-parsed event into
de->event. Later, evlist__deliver_deferred_callchain() (potentially on
multiple iterations before finding a matching tid) and
session__flush_deferred_samples() re-parse de->event via
evlist__parse_sample(), which runs __evsel__parse_sample() again with
evsel->needs_swap still true, double-swapping in-place fields. Meanwhile,
pyrf_event__copy() re-parses copied events with needs_swap=false, which
misses PERF_SAMPLE_TID, PERF_SAMPLE_CPU, and PERF_SAMPLE_RAW's size word
because they were only unswapped into local variables.

Finish unswapping PERF_SAMPLE_TID, PERF_SAMPLE_CPU, and PERF_SAMPLE_RAW's
size prefix in-place during the initial cross-endian parse so the entire
sample buffer is in host layout afterwards, filter deferred samples by
stored tid before re-parsing, and re-parse de->event via
evlist__parse_sample_unswapped().

Fixes: 9b4525fd089d ("perf tools: Merge deferred user callchains")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c  | 38 +++++++++++++++++++++++++++++---------
 tools/perf/util/evlist.h  |  2 ++
 tools/perf/util/evsel.c   | 10 +++++++++-
 tools/perf/util/session.c | 14 +++++++-------
 4 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c2402e4791b6..ec665828d4e3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1935,17 +1935,12 @@ void evlist__cancel_workload(struct evlist *evlist)
 	}
 }
 
-int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct perf_sample *sample)
+static int __evlist__parse_sample(struct evlist *evlist, struct evsel *evsel,
+				  union perf_event *event,
+				  struct perf_sample *sample, bool needs_swap)
 {
-	struct evsel *evsel = evlist__event2evsel(evlist, event);
-	int ret;
+	int ret = __evsel__parse_sample(evsel, event, sample, needs_swap);
 
-	if (!evsel) {
-		/* Ensure the sample is okay for perf_sample__exit. */
-		perf_sample__init(sample, /*all=*/false);
-		return -EFAULT;
-	}
-	ret = evsel__parse_sample(evsel, event, sample);
 	if (ret)
 		return ret;
 	if (perf_guest && sample->id) {
@@ -1959,6 +1954,31 @@ int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct
 	return 0;
 }
 
+int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct perf_sample *sample)
+{
+	struct evsel *evsel = evlist__event2evsel(evlist, event);
+
+	if (!evsel) {
+		/* Ensure the sample is okay for perf_sample__exit. */
+		perf_sample__init(sample, /*all=*/false);
+		return -EFAULT;
+	}
+	return __evlist__parse_sample(evlist, evsel, event, sample, evsel->needs_swap);
+}
+
+int evlist__parse_sample_unswapped(struct evlist *evlist, union perf_event *event,
+				   struct perf_sample *sample)
+{
+	struct evsel *evsel = evlist__event2evsel(evlist, event);
+
+	if (!evsel) {
+		/* Ensure the sample is okay for perf_sample__exit. */
+		perf_sample__init(sample, /*all=*/false);
+		return -EFAULT;
+	}
+	return __evlist__parse_sample(evlist, evsel, event, sample, /*needs_swap=*/false);
+}
+
 int evlist__parse_sample_timestamp(struct evlist *evlist, union perf_event *event, u64 *timestamp)
 {
 	struct evsel *evsel = evlist__event2evsel(evlist, event);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 0f380421e03d..e42d590d4732 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -450,6 +450,8 @@ bool evlist__sample_id_all(struct evlist *evlist);
 u16 evlist__id_hdr_size(struct evlist *evlist);
 
 int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct perf_sample *sample);
+int evlist__parse_sample_unswapped(struct evlist *evlist, union perf_event *event,
+				   struct perf_sample *sample);
 int evlist__parse_sample_timestamp(struct evlist *evlist, union perf_event *event, u64 *timestamp);
 
 bool evlist__valid_sample_type(struct evlist *evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 737a8680aaae..322582bb4f40 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3520,6 +3520,7 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			u.val64 = bswap_64(u.val64);
 			u.val32[0] = bswap_32(u.val32[0]);
 			u.val32[1] = bswap_32(u.val32[1]);
+			*(__u64 *)array = u.val64;
 		}
 
 		data->pid = u.val32[0];
@@ -3554,6 +3555,8 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			/* undo swap of u64, then swap on individual u32s */
 			u.val64 = bswap_64(u.val64);
 			u.val32[0] = bswap_32(u.val32[0]);
+			u.val32[1] = bswap_32(u.val32[1]);
+			*(__u64 *)array = u.val64;
 		}
 
 		data->cpu = u.val32[0];
@@ -3665,7 +3668,12 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			/* mem_bswap_64() accesses complete 64-bit words. */
 			sz = roundup((u64)data->raw_size, sizeof(u64));
 			OVERFLOW_CHECK(raw, sz, max_size);
-			mem_bswap_64((void *)raw, data->raw_size);
+			if (data->raw_size) {
+				mem_bswap_64((void *)raw, data->raw_size);
+				*(u32 *)raw = data->raw_size;
+			} else {
+				*(__u64 *)raw = u.val64;
+			}
 		}
 		data->raw_data = (void *)array;
 		array = (void *)array + data->raw_size;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4e11eabbbe6f..07e1befb5feb 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1933,6 +1933,7 @@ struct deferred_event {
 	struct list_head list;
 	union perf_event *event;
 	u64 file_offset;
+	u32 tid;
 };
 
 /*
@@ -1964,8 +1965,11 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 		struct perf_sample orig_sample;
 		struct evsel *new_evsel;
 
+		if (sample->tid != de->tid)
+			continue;
+
 		perf_sample__init(&orig_sample, /*all=*/false);
-		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
+		ret = evlist__parse_sample_unswapped(evlist, de->event, &orig_sample);
 		if (ret < 0) {
 			pr_err("failed to parse original sample\n");
 			perf_sample__exit(&orig_sample);
@@ -1973,11 +1977,6 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 		}
 		orig_sample.file_offset = de->file_offset;
 
-		if (sample->tid != orig_sample.tid) {
-			perf_sample__exit(&orig_sample);
-			continue;
-		}
-
 		if (event->callchain_deferred.cookie == orig_sample.deferred_cookie)
 			sample__merge_deferred_callchain(&orig_sample, sample);
 		else
@@ -2027,7 +2026,7 @@ static int session__flush_deferred_samples(struct perf_session *session,
 		}
 
 		perf_sample__init(&sample, /*all=*/false);
-		ret = evlist__parse_sample(evlist, de->event, &sample);
+		ret = evlist__parse_sample_unswapped(evlist, de->event, &sample);
 		if (ret < 0) {
 			pr_err("failed to parse original sample\n");
 			perf_sample__exit(&sample);
@@ -2120,6 +2119,7 @@ static int machines__deliver_event(struct machines *machines,
 			}
 			memcpy(de->event, event, sz);
 			de->file_offset = sample->file_offset;
+			de->tid = sample->tid;
 			list_add_tail(&de->list, evlist__deferred_samples(evlist));
 			return 0;
 		}
-- 
2.56.1.831.g720f3f5937-goog

