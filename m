Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815138;
	b=solFA2uWcbj19aA3gOSvrFHXnreYXB45qJcydtpsQJr4ry+W9CTmJTZosEmj+E2y7LbN
	 T1CAO5OGdH0V1fMHdpHjU/KagbSacjkxmUlxhQtzCvoI36gDN7FH5GF5wV4/zQN336MF6
	 A0o1mjUNs9DSqnGPtfBUKSHiAJMuxlTpTgw8TopggUThnABpofdkYWuVfE8XQ8BCMmrQ1
	 8dW7Zvmjgw1w42mLdwVWhON0REjZLj/Cbg+TcoMTL/ATL0l4ZJMqNRWugIc50JzC5TUzF
	 /3qYWISt6X+bIa5U5Xi/tMwOk84M5QQYQrmhMzDq3qFcyFquVxh0puWommgzfrZC0XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5YthXsXAd8VW7o5g3Cgz5hmLUVfZzgZEh39rgsIIYt0=;
	b=fdzGJEnPW86rGL9W5b3Efl0WYPccp8kzy5ypCwRlW66tZkqXcqymxcfzVNkWeYHRazQG
	 Kjb4i69edft0yUXVFu3mXv2Y69kLktj3OmkBmlImOGZ3oqrrwz8Yszul0Fh414zUYm6bU
	 TPHSL0CVLnrvbKcCJApQyS1LGc0bytIm/2W5VXG4LgE4zTIxORTcOMuIBeJ5t3C2n1RrE
	 vMdAOGTt3ZuGWMKy2mPzemAQPAuF9xAm5q60CQEDWvfBfX9OokEuME/kALWzZf1dCjt03
	 dc1hCUMq5PkHcb49X8I9sPRIjAcMjzg9HKttU6qPLp8HwN8/U4EVZHL54ijSKb7ybGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JYFtF9HJ;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14560A2614
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA14560A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JYFtF9HJ
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-37549877380so4364717eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815136; x=1795419936; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5YthXsXAd8VW7o5g3Cgz5hmLUVfZzgZEh39rgsIIYt0=;
        b=JYFtF9HJe7UwZg7Qwljpmc+gTcPG1sbuyojeJzs6dMVz7iPletgMdaEOEvC1KcCeEy
         9/GK0cGj36QnNYj0hQXYpvNtAR0Ydg6t0GpmyfvrD+60A7OaZ3v+szcCYFtoSqY9fv06
         /nky7RFPmkGfuVZ4lHevwkaMdSHes0cCl6yoUM+6NUMUmz0EH40aoFTHqfY/DZLhj0k9
         W/66uoy9urMDewQtKOy3AxqJsn1l1rn3+9J0nn6fyQPCZILlGPip/3gegC9/zzmQe58D
         kjYEyhottPV3eIV3UQ0zA2kZJvPNu22JtOss8g9hKUQpYnTpyy56dz8MiLitMrAl4AJH
         TNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815136; x=1795419936;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5YthXsXAd8VW7o5g3Cgz5hmLUVfZzgZEh39rgsIIYt0=;
        b=p92Be3kjpHtgh4u8gGZoPES0Rlm4R/fvhqgKNzNTWBa/sZKQj4HcDlLbH0yM8RneG2
         Wn88x6hKuJNTbHyxHOT8aFjj0lwAsQAQjrQirFVavRT+uzy2oywpQ+r9j5kOz3JbMqjG
         3pzrhMr5eoiai3Rsh8JKx+W/SVWYgZZ6+DeNf8u6t8EawvwDU6kt7pqLQzqPh3o8o8qs
         3yPJFHqB/vStWqjy6dKwKCfYj9nSzrfOAUbNQ/YwNaGSX5RIxrOjLwkqvOcJ6tk5nOby
         KmLPCQ6gEf+LrAtlxPLnX9w6g9KAcq4oYAOdeCJ0ebEDZrtyhAZak7W0NhD5caUFMg9B
         sTJg==
X-Forwarded-Encrypted: i=1; AL+hErG72hLm5MMgB01ODb7WeVcsvht9JVs0HLwm5I5G6NEMdvQo3fzOSgNFkmtAdd6L2FKKnKH2q1dcXu1MMOrfcsk0@vger.kernel.org
X-Gm-Message-State: APuU4Z/VZ6fZ7ikqOMUFc4iKuNZCTLQsTDs3wC/BtLIF9+OuOgLiEc9W
	+cWP3d3kj0LG6bJBN4b3t7vSwKdxYni/UYmeDW3AGB92B2oi+dRs6/4WHSuZG+tJ5lbftfGZn4C
	lal3n+3hb1w==
X-Received: from dyax25-n1.prod.google.com ([2002:a05:693c:4199:10b0:36a:16ac:9308])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e9c5:20b0:361:167c:2364
 with SMTP id 5a478bee46e88-37966e3ab7cmr11030433eec.8.1794815135449; Sun, 15
 Nov 2026 23:45:35 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:09 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-15-irogers@google.com>
Subject: [PATCH v3 14/19] perf evsel: Parse, synthesize, and dump
 BUILD_ID_OFFSET sample types
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add fields to struct perf_sample and implement parsing, synthesis,
cross-endian byte-swapping, and raw trace dumping ('perf report -D') for
PERF_SAMPLE_BUILD_ID_OFFSET, PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET, and
PERF_RECORD_CALLCHAIN_DEFERRED with PERF_RECORD_MISC_MMAP_BUILD_ID.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c                   | 153 +++++++++++++++++++++-
 tools/perf/util/evsel.h                   |   3 +-
 tools/perf/util/perf_event_attr_fprintf.c |   3 +-
 tools/perf/util/python.c                  |  17 +++
 tools/perf/util/sample.c                  |  84 ++++++++++++
 tools/perf/util/sample.h                  |  39 ++++++
 tools/perf/util/session.c                 | 126 ++++++++++++++++--
 tools/perf/util/synthetic-events.c        |  41 ++++++
 8 files changed, 444 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 322582bb4f40..49f6bbf08160 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3445,6 +3445,89 @@ static int __set_offcpu_sample(struct perf_sample *data)
 	return -EFAULT;
 }
 
+/*
+ * Before __evsel__parse_sample() is called on a cross-endian perf.data file,
+ * perf_event__all64_swap() has already byte-swapped the entire PERF_RECORD_SAMPLE
+ * payload in 64-bit chunks. That leaves 64-bit fields (like offset, ip, cookie)
+ * in host endianness, but scrambles the 24-byte struct perf_build_id (which
+ * contains a 16-bit reserved field, a 1-byte size, and a 20-byte byte array).
+ * Undo the 64-bit chunk swap on struct perf_build_id and byte-swap its 16-bit
+ * field.
+ */
+static void perf_build_id__undo_bswap_64(struct perf_build_id *bid)
+{
+	mem_bswap_64(bid, sizeof(*bid));
+	bid->__reserved_2 = bswap_16(bid->__reserved_2);
+}
+
+static int parse_callchain_build_id_offset(const __u64 **arrayp, const void *endp,
+					   struct perf_sample *data, bool swapped)
+{
+	const __u64 *array = *arrayp;
+	__u64 *hdr;
+	union u64_swap u;
+	u32 nr_build_ids, nr_offsets;
+	u32 pos = 0, aligned_bids_len;
+	u8 *raw_bytes;
+	u8 *build_ids = NULL;
+	u64 *offsets = NULL;
+
+	if ((const void *)(array + 1) > endp)
+		return -EFAULT;
+
+	hdr = (__u64 *)array++;
+	u.val64 = *hdr;
+	if (swapped) {
+		/* undo swap of words, then swap_32 */
+		u.val64 = bswap_64(u.val64);
+		u.val32[0] = bswap_32(u.val32[0]);
+		u.val32[1] = bswap_32(u.val32[1]);
+	}
+	nr_build_ids = u.val32[0];
+	nr_offsets = u.val32[1];
+	if (nr_build_ids > 254)
+		return -EFAULT;
+
+	raw_bytes = (u8 *)array;
+	for (u32 i = 0; i < nr_build_ids; i++) {
+		u32 byte_idx = swapped ? (pos ^ 7) : pos;
+		u8 bid_size;
+
+		if ((const void *)(raw_bytes + (pos | 7) + 1) > endp)
+			return -EFAULT;
+		bid_size = raw_bytes[byte_idx];
+		if (bid_size == 0 || bid_size > 20)
+			return -EFAULT;
+		pos += 1 + bid_size;
+	}
+	aligned_bids_len = ALIGN(pos, sizeof(u64));
+	if ((const void *)(raw_bytes + aligned_bids_len) > endp)
+		return -EFAULT;
+
+	array += aligned_bids_len / sizeof(u64);
+	if (nr_offsets > (size_t)((const u8 *)endp - (const u8 *)array) / sizeof(u64))
+		return -EFAULT;
+
+	if (swapped) {
+		*hdr = u.val64;
+		if (aligned_bids_len > 0)
+			mem_bswap_64(raw_bytes, aligned_bids_len);
+	}
+	if (aligned_bids_len > 0)
+		build_ids = raw_bytes;
+	if (nr_offsets > 0)
+		offsets = (u64 *)array;
+	array += nr_offsets;
+
+	data->callchain_bid.nr_build_ids = nr_build_ids;
+	data->callchain_bid.nr_offsets = nr_offsets;
+	data->callchain_bid.build_ids_len = aligned_bids_len;
+	data->callchain_bid.build_ids = build_ids;
+	data->callchain_bid.offsets = offsets;
+	*arrayp = array;
+	return 0;
+}
+
 int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			  struct perf_sample *data, bool needs_swap)
 {
@@ -3472,14 +3555,21 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->vcpu = -1;
 
 	if (event->header.type == PERF_RECORD_CALLCHAIN_DEFERRED) {
-		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
-
 		OVERFLOW_CHECK_u64(&event->callchain_deferred.nr);
-		data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
-		if (data->callchain->nr > max_callchain_nr)
-			goto out_efault;
-		OVERFLOW_CHECK(event->callchain_deferred.ips,
-			       data->callchain->nr * sizeof(u64), max_size);
+		if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
+			array = (const __u64 *)&event->callchain_deferred.nr_build_ids;
+			if (parse_callchain_build_id_offset(&array, endp, data,
+							    /*swapped=*/false))
+				goto out_efault;
+		} else {
+			const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
+
+			data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
+			if (data->callchain->nr > max_callchain_nr)
+				goto out_efault;
+			OVERFLOW_CHECK(event->callchain_deferred.ips,
+				       data->callchain->nr * sizeof(u64), max_size);
+		}
 
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
@@ -3918,6 +4008,55 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		const struct perf_sample_build_id_offset *entry =
+			(const struct perf_sample_build_id_offset *)array;
+
+		OVERFLOW_CHECK(array, sizeof(*entry), max_size);
+		if (evsel->core.attr.defer_callchain && entry->zero == 0 &&
+		    entry->context == PERF_CONTEXT_USER_DEFERRED) {
+			data->deferred_bid = true;
+			data->deferred_callchain = true;
+			data->deferred_cookie = entry->cookie;
+			data->bid.bid = (struct perf_build_id *)&entry->bid;
+			data->bid.offset = entry->ip;
+		} else {
+			struct perf_build_id *bid =
+				(struct perf_build_id *)&entry->bid;
+
+			/*
+			 * perf_event__all64_swap() already swapped the sample
+			 * in 64-bit chunks, so entry->offset is already in host
+			 * endianness; undo the 64-bit swap on the build ID
+			 * bytes in-place so re-parsing with needs_swap=false
+			 * sees host layout.
+			 */
+			if (swapped)
+				perf_build_id__undo_bswap_64(bid);
+			data->bid.bid = bid;
+			data->bid.offset = entry->offset;
+		}
+		if (!(type & PERF_SAMPLE_IP))
+			data->ip = data->bid.offset;
+		array += sizeof(*entry) / sizeof(u64);
+	} else {
+		data->bid.bid = NULL;
+		data->bid.offset = 0;
+	}
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		if (parse_callchain_build_id_offset(&array, endp, data, swapped))
+			goto out_efault;
+		if (evsel->core.attr.defer_callchain &&
+		    data->callchain_bid.nr_offsets >= 2 &&
+		    data->callchain_bid.offsets[data->callchain_bid.nr_offsets - 2] ==
+			    PERF_CONTEXT_USER_DEFERRED) {
+			data->deferred_cookie =
+				data->callchain_bid.offsets[data->callchain_bid.nr_offsets - 1];
+			data->deferred_callchain = true;
+		}
+	}
+
 	if (evsel__is_offcpu_event(evsel)) {
 		if (__set_offcpu_sample(data))
 			goto out_efault;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 53f3641b66e1..858c32bb02e2 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -570,7 +570,8 @@ static inline bool evsel__has_callchain(const struct evsel *evsel)
 	 * For reporting purposes, an evsel sample can have a recorded callchain
 	 * or a callchain synthesized from AUX area data.
 	 */
-	return evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN ||
+	return evsel->core.attr.sample_type & (PERF_SAMPLE_CALLCHAIN |
+				       PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) ||
 	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 2e8be9a357dc..dd653da923c4 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -40,7 +40,8 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
 		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(CODE_PAGE_SIZE),
-		bit_name(WEIGHT_STRUCT),
+		bit_name(WEIGHT_STRUCT), bit_name(BUILD_ID_OFFSET),
+		bit_name(CALLCHAIN_BUILD_ID_OFFSET),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f5d9e7152ef4..bf892b3a8736 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1747,6 +1747,18 @@ static int pyrf_event__copy(struct pyrf_event *pevent)
 				       sizeof(pevent->sample_storage.insn));
 				pevent->sample_storage.insn_len = orig_sample->insn_len;
 			}
+			if (orig_sample->bid.bid ==
+			    (const struct perf_build_id *)orig_sample->bid.deferred_storage) {
+				memcpy(pevent->sample_storage.bid.deferred_storage,
+				       orig_sample->bid.deferred_storage,
+				       sizeof(pevent->sample_storage.bid.deferred_storage));
+				pevent->sample_storage.bid.bid =
+					(struct perf_build_id *)
+					pevent->sample_storage.bid.deferred_storage;
+				pevent->sample_storage.bid.offset = orig_sample->bid.offset;
+				pevent->sample_storage.ip = orig_sample->ip;
+				pevent->sample_storage.deferred_bid = false;
+			}
 		}
 		pevent->sample = &pevent->sample_storage;
 	} else if (orig_sample != &pevent->sample_storage) {
@@ -1763,6 +1775,11 @@ static int pyrf_event__copy(struct pyrf_event *pevent)
 				evsel__get(pevent->sample_storage.evsel);
 		pevent->sample_storage.callchain = NULL;
 		pevent->sample_storage.merged_callchain = false;
+		pevent->sample_storage.bid.bid = NULL;
+		memset(&pevent->sample_storage.callchain_bid, 0,
+		       sizeof(pevent->sample_storage.callchain_bid));
+		pevent->sample_storage.allocated_callchain_bids = false;
+		pevent->sample_storage.merged_callchain_bids = false;
 		pevent->sample_storage.raw_data = NULL;
 		pevent->sample_storage.raw_size = 0;
 		pevent->sample_storage.branch_stack = NULL;
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index 4abb689132bc..0becb78d70d6 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -5,7 +5,9 @@
 #include <string.h>
 
 #include <elf.h>
+#include <linux/bits.h>
 #include <linux/zalloc.h>
+#include <perf/event.h>
 
 #include "../../arch/x86/include/asm/insn.h"
 #include "debug.h"
@@ -24,12 +26,16 @@ void perf_sample__init(struct perf_sample *sample, bool all)
 	if (all) {
 		memset(sample, 0, sizeof(*sample));
 	} else {
+		sample->ip = 0;
 		sample->evsel = NULL;
 		sample->user_regs = NULL;
 		sample->intr_regs = NULL;
 		sample->merged_callchain = false;
 		sample->callchain = NULL;
 		sample->ret_addr = 0;
+		sample->allocated_callchain_bids = false;
+		sample->merged_callchain_bids = false;
+		memset(&sample->callchain_bid, 0, sizeof(sample->callchain_bid));
 	}
 }
 
@@ -43,6 +49,84 @@ void perf_sample__exit(struct perf_sample *sample)
 		zfree(&sample->callchain);
 		sample->merged_callchain = false;
 	}
+	if (sample->allocated_callchain_bids) {
+		zfree(&sample->callchain_bid.build_ids);
+		memset(&sample->callchain_bid, 0, sizeof(sample->callchain_bid));
+		sample->allocated_callchain_bids = false;
+		sample->merged_callchain_bids = false;
+	}
+}
+
+void perf_sample__callchain_bid_entry(const struct perf_sample *sample,
+				      u32 idx, struct perf_build_id *bid_out,
+				      u64 *offset_out)
+{
+	bool is_user_ctx = true;
+	u64 raw_offset;
+	u8 bid_idx;
+	u32 pos = 0;
+	u8 sz;
+
+	if (bid_out)
+		memset(bid_out, 0, sizeof(*bid_out));
+	if (idx >= sample->callchain_bid.nr_offsets ||
+	    !sample->callchain_bid.offsets) {
+		*offset_out = 0;
+		return;
+	}
+
+	raw_offset = sample->callchain_bid.offsets[idx];
+	if (raw_offset >= PERF_CONTEXT_MAX) {
+		*offset_out = raw_offset;
+		return;
+	}
+
+	for (u32 k = 0; k < idx; k++) {
+		u64 v = sample->callchain_bid.offsets[k];
+
+		if (v < PERF_CONTEXT_MAX)
+			continue;
+		if (v == PERF_CONTEXT_USER_DEFERRED) {
+			is_user_ctx = true;
+			if (!sample->merged_callchain_bids) {
+				if (k + 1 == idx) {
+					*offset_out = raw_offset;
+					return;
+				}
+				k++;
+			}
+		} else if (v == PERF_CONTEXT_USER ||
+			   v == PERF_CONTEXT_GUEST_USER) {
+			is_user_ctx = true;
+		} else {
+			is_user_ctx = false;
+		}
+	}
+
+	if (!is_user_ctx) {
+		*offset_out = raw_offset;
+		return;
+	}
+
+	bid_idx = raw_offset >> 56;
+	if (bid_idx == 0 || bid_idx == 0xff ||
+	    bid_idx > sample->callchain_bid.nr_build_ids ||
+	    !sample->callchain_bid.build_ids) {
+		*offset_out = raw_offset;
+		return;
+	}
+
+	if (bid_out) {
+		for (u32 b = 0; b < (u32)(bid_idx - 1); b++)
+			pos += 1 + sample->callchain_bid.build_ids[pos];
+
+		sz = sample->callchain_bid.build_ids[pos];
+		if (sz > sizeof(bid_out->data))
+			sz = sizeof(bid_out->data);
+		bid_out->size = sz;
+		memcpy(bid_out->data, &sample->callchain_bid.build_ids[pos + 1], sz);
+	}
+	*offset_out = raw_offset & GENMASK_ULL(55, 0);
 }
 
 struct regs_dump *perf_sample__user_regs(struct perf_sample *sample)
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 865ed18200f1..d5c52df508c4 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -8,6 +8,7 @@
 struct evsel;
 struct machine;
 struct thread;
+struct perf_build_id;
 
 /* number of register is bound by the number of bits in regs_dump::mask (64) */
 #define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
@@ -168,6 +169,26 @@ struct perf_sample {
 	u64 code_page_size;
 	/** @cgroup: The sample event PERF_SAMPLE_CGROUP value. */
 	u64 cgroup;
+	/** @bid: The sample event PERF_SAMPLE_BUILD_ID_OFFSET value. */
+	struct {
+		struct perf_build_id *bid;
+		union {
+			u64 offset;
+			u64 ip;
+		};
+		u64 deferred_storage[3];
+	} bid;
+	/**
+	 * @callchain_bid: Build IDs and offsets for the callchain when
+	 * PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET is set.
+	 */
+	struct {
+		u32 nr_build_ids;
+		u32 nr_offsets;
+		u32 build_ids_len;
+		u8 *build_ids;
+		u64 *offsets;
+	} callchain_bid;
 	/** @file_offset: Byte offset of this event in the perf.data file. */
 	u64 file_offset;
 	/** @flags: Extra flag data from auxiliary events like intel-pt. */
@@ -210,11 +231,26 @@ struct perf_sample {
 	 *                      user callchain marker was encountered.
 	 */
 	bool deferred_callchain;
+	/**
+	 * @deferred_bid: When processing PERF_SAMPLE_BUILD_ID_OFFSET a deferred
+	 *                user marker was encountered.
+	 */
+	bool deferred_bid;
 	/**
 	 * @merged_callchain: A synthesized merged callchain that is allocated
 	 *                    and needs freeing.
 	 */
 	bool merged_callchain;
+	/**
+	 * @allocated_callchain_bids: callchain_bid.build_ids is heap-allocated
+	 *                            and needs freeing.
+	 */
+	bool allocated_callchain_bids;
+	/**
+	 * @merged_callchain_bids: PERF_CONTEXT_USER_DEFERRED in callchain_bid
+	 *                         has been merged with its deferred callchain.
+	 */
+	bool merged_callchain_bids;
 	/**
 	 * @deferred_cookie: Identifier of the deferred callchain in the later
 	 *                   PERF_RECORD_CALLCHAIN_DEFERRED event.
@@ -261,6 +297,9 @@ void perf_sample__init(struct perf_sample *sample, bool all);
 void perf_sample__exit(struct perf_sample *sample);
 struct regs_dump *perf_sample__user_regs(struct perf_sample *sample);
 struct regs_dump *perf_sample__intr_regs(struct perf_sample *sample);
+void perf_sample__callchain_bid_entry(const struct perf_sample *sample,
+				      u32 idx, struct perf_build_id *bid_out,
+				      u64 *offset_out);
 
 void perf_sample__fetch_insn(struct perf_sample *sample,
 			     struct thread *thread,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ec1ea510ae61..a332a83dd60e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -21,6 +21,7 @@
 
 #include "map_symbol.h"
 #include "branch.h"
+#include "build-id.h"
 #include "debug.h"
 #include "dwarf-regs.h"
 #include "env.h"
@@ -1186,6 +1187,59 @@ static int perf_event__header_feature_swap(union perf_event *event,
 	return 0;
 }
 
+static int perf_event__callchain_deferred_swap(union perf_event *event,
+					       bool sample_id_all)
+{
+	u32 nr_build_ids, nr_offsets, pos = 0, aligned_bids_len;
+	const void *endp = (void *)event + event->header.size;
+	u8 *build_ids;
+	u64 *offsets;
+
+	if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID))
+		return perf_event__all64_swap(event, sample_id_all);
+
+	if (event->header.size < sizeof(event->callchain_deferred))
+		return -1;
+
+	event->callchain_deferred.cookie = bswap_64(event->callchain_deferred.cookie);
+	event->callchain_deferred.nr_build_ids =
+		bswap_32(event->callchain_deferred.nr_build_ids);
+	event->callchain_deferred.nr_offsets =
+		bswap_32(event->callchain_deferred.nr_offsets);
+
+	nr_build_ids = event->callchain_deferred.nr_build_ids;
+	nr_offsets = event->callchain_deferred.nr_offsets;
+	if (nr_build_ids > 254)
+		return -1;
+
+	build_ids = event->callchain_deferred.build_ids;
+	for (u32 i = 0; i < nr_build_ids; i++) {
+		u8 bid_size;
+
+		if ((void *)(build_ids + pos + 1) > endp)
+			return -1;
+		bid_size = build_ids[pos];
+		if (bid_size == 0 || bid_size > 20 ||
+		    (void *)(build_ids + pos + 1 + bid_size) > endp)
+			return -1;
+		pos += 1 + bid_size;
+	}
+	aligned_bids_len = ALIGN(pos, sizeof(u64));
+	if ((void *)(build_ids + aligned_bids_len) > endp)
+		return -1;
+
+	offsets = (u64 *)(build_ids + aligned_bids_len);
+	if (nr_offsets > (size_t)((const u8 *)endp - (const u8 *)offsets) / sizeof(u64))
+		return -1;
+
+	for (u32 i = 0; i < nr_offsets; i++)
+		offsets[i] = bswap_64(offsets[i]);
+
+	if (sample_id_all)
+		swap_sample_id_all(event, &offsets[nr_offsets]);
+	return 0;
+}
+
 typedef int (*perf_event__swap_op)(union perf_event *event,
 				   bool sample_id_all);
 
@@ -1211,7 +1265,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_BPF_EVENT]		  = perf_event__bpf_event_swap,
 	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  = perf_event__all64_swap,
-	[PERF_RECORD_CALLCHAIN_DEFERRED]  = perf_event__all64_swap,
+	[PERF_RECORD_CALLCHAIN_DEFERRED]  = perf_event__callchain_deferred_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
@@ -1294,11 +1348,18 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 	struct ip_callchain *callchain = sample->callchain;
 	struct branch_stack *lbr_stack = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
-	u64 kernel_callchain_nr = callchain->nr;
+	u64 kernel_callchain_nr = callchain ? callchain->nr : sample->callchain_bid.nr_offsets;
 	unsigned int i;
 
 	for (i = 0; i < kernel_callchain_nr; i++) {
-		if (callchain->ips[i] == PERF_CONTEXT_USER)
+		u64 ip = 0;
+
+		if (callchain)
+			ip = callchain->ips[i];
+		else
+			perf_sample__callchain_bid_entry(sample, i, NULL, &ip);
+
+		if (ip == PERF_CONTEXT_USER)
 			break;
 	}
 
@@ -1325,9 +1386,16 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 
 		printf("... LBR call chain: nr:%" PRIu64 "\n", total_nr);
 
-		for (i = 0; i < kernel_callchain_nr; i++)
-			printf("..... %2d: %016" PRIx64 "\n",
-			       i, callchain->ips[i]);
+		for (i = 0; i < kernel_callchain_nr; i++) {
+			u64 ip = 0;
+
+			if (callchain)
+				ip = callchain->ips[i];
+			else
+				perf_sample__callchain_bid_entry(sample, i, NULL, &ip);
+
+			printf("..... %2d: %016" PRIx64 "\n", i, ip);
+		}
 
 		printf("..... %2d: %016" PRIx64 "\n",
 		       (int)(kernel_callchain_nr), entries[0].to);
@@ -1368,12 +1436,33 @@ static void callchain__printf(struct evsel *evsel,
 	if (evsel__has_branch_callstack(evsel))
 		callchain__lbr_callstack_printf(sample);
 
-	printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
-
-	for (i = 0; i < callchain->nr; i++)
-		printf("..... %2d: %016" PRIx64 "%s\n",
-		       i, callchain->ips[i],
-		       callchain_context_str(callchain->ips[i]));
+	if (callchain) {
+		printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
+
+		for (i = 0; i < callchain->nr; i++)
+			printf("..... %2d: %016" PRIx64 "%s\n",
+			       i, callchain->ips[i],
+			       callchain_context_str(callchain->ips[i]));
+	} else if (sample->callchain_bid.nr_offsets) {
+		printf("... FP chain (build ID + offset): nr:%u (build IDs:%u)\n",
+		       sample->callchain_bid.nr_offsets,
+		       sample->callchain_bid.nr_build_ids);
+
+		for (i = 0; i < sample->callchain_bid.nr_offsets; i++) {
+			struct perf_build_id bid;
+			u64 offset = 0;
+			u8 bid_idx = sample->callchain_bid.offsets[i] >> 56;
+
+			perf_sample__callchain_bid_entry(sample, i, &bid, &offset);
+			if (bid.size > 0) {
+				printf("..... %2d: %016" PRIx64 " (build ID %u)\n",
+				       i, offset, bid_idx - 1);
+			} else {
+				printf("..... %2d: %016" PRIx64 "%s\n",
+				       i, offset, callchain_context_str(offset));
+			}
+		}
+	}
 
 	if (sample->deferred_callchain)
 		printf("...... (deferred)\n");
@@ -1698,6 +1787,17 @@ static void dump_sample(struct machine *machine, union perf_event *event,
 	       event->header.misc, sample->pid, sample->tid, sample->ip,
 	       sample->period, sample->addr);
 
+	if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		struct build_id bid;
+		char sbuild_id[SBUILD_ID_SIZE] = "";
+
+		if (sample->bid.bid) {
+			build_id__init(&bid, sample->bid.bid->data, sample->bid.bid->size);
+			build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
+		}
+		printf("... build_id: %s offset: %#" PRIx64 "\n", sbuild_id, sample->bid.offset);
+	}
+
 	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
@@ -1751,7 +1851,7 @@ static void dump_deferred_callchain(union perf_event *event, struct perf_sample
 	printf("(IP, 0x%x): %d/%d: %#" PRIx64 "\n",
 	       event->header.misc, sample->pid, sample->tid, sample->deferred_cookie);
 
-	if (evsel__has_callchain(evsel))
+	if (evsel__has_callchain(evsel) || sample->callchain_bid.nr_offsets)
 		callchain__printf(evsel, sample);
 }
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 57d6efe9e5f5..288a2122101b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1717,6 +1717,15 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		result += sample->aux_sample.size;
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET)
+		result += sizeof(struct perf_build_id) + sizeof(u64);
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		result += sizeof(u64) +
+			  ALIGN(sample->callchain_bid.build_ids_len, sizeof(u64)) +
+			  sample->callchain_bid.nr_offsets * sizeof(u64);
+	}
+
 	return result;
 }
 
@@ -1973,6 +1982,38 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array = (void *)array + sz;
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		if (sample->bid.bid) {
+			memcpy(array, sample->bid.bid, sizeof(struct perf_build_id));
+			array += sizeof(struct perf_build_id) / sizeof(u64);
+			*array++ = sample->bid.offset;
+		} else {
+			memset(array, 0, sizeof(struct perf_build_id));
+			array += sizeof(struct perf_build_id) / sizeof(u64);
+			*array++ = sample->ip;
+		}
+	}
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		u32 aligned_bids_len =
+			ALIGN(sample->callchain_bid.build_ids_len, sizeof(u64));
+
+		u.val32[0] = sample->callchain_bid.nr_build_ids;
+		u.val32[1] = sample->callchain_bid.nr_offsets;
+		*array++ = u.val64;
+		if (aligned_bids_len && sample->callchain_bid.build_ids) {
+			memset(array, 0, aligned_bids_len);
+			memcpy(array, sample->callchain_bid.build_ids,
+			       sample->callchain_bid.build_ids_len);
+			array += aligned_bids_len / sizeof(u64);
+		}
+		if (sample->callchain_bid.nr_offsets && sample->callchain_bid.offsets) {
+			sz = sample->callchain_bid.nr_offsets * sizeof(u64);
+			memcpy(array, sample->callchain_bid.offsets, sz);
+			array += sample->callchain_bid.nr_offsets;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.56.1.703.gf848ed807c-goog

