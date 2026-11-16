Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815126;
	b=TNXZeZ4pxqiGEOMjQK/ot3t/tNP51GY7BjUqQ7V3yr8AHddJ31MA5bnlAqHvBZQYxzba
	 uAdosD24nkP/V+jhVUFUcitwpAZpdv/jVk76ieY4PR1skguSMga99O+1mpt4iYHWuF7/S
	 vx6P2meWRUyCXmhHf5oHWzwO9+3zK9nvK6hxq3VDv+kPo0lfHZ6cJ0/yAFyLV+9Th2LS2
	 jOU4jjIZLboPJIVoWrvmvXGlnUIh4TK9gR0evLj/l8b6GXIxd2+lHfW5IuUgO4UsvkrbT
	 C/Vc1SdvR2Jk5oN5Yqrgcfobwa+P6MLD8todA7651sAEcPfWx0qdMvjbAvByKjAtHRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=IyWxbg8JfKyS9ECLJkNu4MChBueQzs+8RBXPCvcMWVo=;
	b=TgS5P7DcOEFQCtpWmyfWS9lH+NnzGcUV1bBlbJ8XJvoQsOdmZlZmQkvJllmAxfrz9mks
	 w2PdI3h7zUjNP/AtvoMrdn9RH0D+IjjuXKekjAbhwQPz8hSiquweMhrJiKMxfyQOgKDnF
	 wFqAcvXIF0pBRKsjBKblC4qadKWpItWqu/hc+ixo1BBkBzIuzOyzbhMEXeOUlGmNnGLF4
	 ZGJK5HGurW3zMgDdRJg9nWop+PDv5YOshHAss5/zUZpb69i1w8JVta0ggkNEv1ASkULSp
	 2TcFqytBrsHWdlm5CC5wSW1opURHTPZGa5/QsGEHaIPw/Alawjw1XL/95VU1RE5l+Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nwHctiAs;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD1606A896
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BFD1606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nwHctiAs
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36d1353fdcdso1873223eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815125; x=1795419925; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IyWxbg8JfKyS9ECLJkNu4MChBueQzs+8RBXPCvcMWVo=;
        b=nwHctiAsD7wB7EtEdULHadVClN2NdAZG3JO/Yhqj9hkICWwRCLKK6zuN4xJ4QxUURC
         rCIbPxI4HRx6t7OkL3U4JAqQZ1o62aewmwJwnZU60Azyi+XBf33EM3EtSrOT/fTV7W0+
         OUpb9Y5SP1HQAjY3qcHyZeZQD7ov3YZSaL2nghDShbB6BxTJo7IZQBYljT7FdFG/b61y
         gNmln/Y4+6vSZD7YSeOb0kGBfHXzk3CnPcdCucfBzQBWSvGhfbzdwdwXPgllVzBUzOzc
         u+KTgFlQi+4mfP1RXFhBT2doRP6lDLYcqOXJV32wE+6RY2/LeN5PbtR78Fdt9zYEddZw
         mvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815125; x=1795419925;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IyWxbg8JfKyS9ECLJkNu4MChBueQzs+8RBXPCvcMWVo=;
        b=Svh4Gn6PmgmbDabwyL1kOlWR5mRcS7AtCplnq+IXqhep5Doo4i8kNCrQ2Rx1oe0eyD
         pAJQRD01h4kb+10C9IzW+kQqQiOZ2c+gskBigx93BOw2Cwyq7/ZdbMyyVFB630rVrdgi
         5OsRIPleAZ+v7QGkfV3kflnr+pTg4KhlxcwUZQLdcNRCTeoGTLAKkFpWxeuki83Po+Wb
         77od6HhjUAtyOZcZ5yhQ1cgxfq6THjdRws7C09FicG6EtHHPhwyCpRExhwOyXYk9XjLX
         LztmGwJyjiF7ssx4W6FB0waXPjdoSMZO7Upa8Kws6NTYb1hngvn2aXKjv8xuNg4TkMDa
         Igug==
X-Forwarded-Encrypted: i=1; AL+hErFcgh94todw/aMtkhBQwQagyAbSaTdevSuGcIDRNykxFVQZDAyZGOlRcKOEQVwgtJX9Z25BlofTax6g6/ao2xyD@vger.kernel.org
X-Gm-Message-State: APuU4Z/nMIRGqVHaiSg8nE/NRfRHgCWKlsDHKksgDmrZenki8avJGPFt
	pC6KBv08kBypVicf9caTDfqe5290BbTvPA628k+LCbmUMXqRVCpqaGM2p4J6YMWtAhyCseK69+C
	9r2mfFKb3Pg==
X-Received: from dlbrs1.prod.google.com ([2002:a05:7022:f681:b0:184:6cc9:b13c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2706:b0:1b5:126c:eb88
 with SMTP id a92af1059eb24-1b5126cec12mr6665964c88.45.1794815125098; Sun, 15
 Nov 2026 23:45:25 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:04 -0800
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
Message-ID: <20261116074414.3174737-10-irogers@google.com>
Subject: [PATCH v3 09/19] perf inject: Fix PERF_SAMPLE_READ layout and bounds
 checks in aslr_tool__process_sample()
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

In aslr_tool__process_sample(), PERF_SAMPLE_READ only copied the id word
when evsel->core.attr.read_format had PERF_FORMAT_ID set, whereas the
kernel and __evsel__parse_sample() unconditionally include the id word in
both single-counter and PERF_FORMAT_GROUP modes. When PERF_FORMAT_ID was
not explicitly set in attr.read_format, in_array[i] became desynchronized
with subsequent sample fields.

In addition, CHECK_BOUNDS() used addition (i + required_i > max_i) which
could overflow, and the dropped PERF_SAMPLE_RAW, PERF_SAMPLE_STACK_USER,
and PERF_SAMPLE_AUX handlers copied word-rounded lengths into out_array
before discarding the sample.

Unconditionally copy the id word in PERF_SAMPLE_READ using
sample_read_value_size() with division-based bounds checks, make
CHECK_BOUNDS() subtraction-based, and drop RAW/STACK_USER/AUX samples
directly without dead copies.

Fixes: 575c6d2bc470 ("perf inject/aslr: Implement sample address remapping")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/aslr.c | 95 +++++++++---------------------------------
 1 file changed, 20 insertions(+), 75 deletions(-)

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index dee077cca5fe..e236d5287043 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -8,6 +8,7 @@
 #include "evlist.h"
 #include "machine.h"
 #include "map.h"
+#include "sample.h"
 #include "thread.h"
 #include "tool.h"
 #include "session.h"
@@ -780,7 +781,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	out_array = &new_event->sample.array[0];
 
 #define CHECK_BOUNDS(required_i, required_j) \
-	(i + (required_i) > max_i || j + (required_j) > max_j)
+	((required_i) > max_i - i || (required_j) > max_j - j)
 
 #define COPY_U64() \
 	do { \
@@ -835,18 +836,20 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	if (orig_sample_type & PERF_SAMPLE_PERIOD)
 		COPY_U64(); /* period */
 	if (orig_sample_type & PERF_SAMPLE_READ) {
-		if ((evsel->core.attr.read_format & PERF_FORMAT_GROUP) == 0) {
+		u64 read_format = evsel->core.attr.read_format;
+
+		if ((read_format & PERF_FORMAT_GROUP) == 0) {
 			COPY_U64(); /* value */
-			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+			if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 				COPY_U64(); /* time_enabled */
-			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+			if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 				COPY_U64(); /* time_running */
-			if (evsel->core.attr.read_format & PERF_FORMAT_ID)
-				COPY_U64(); /* id */
-			if (evsel->core.attr.read_format & PERF_FORMAT_LOST)
+			/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
+			COPY_U64(); /* id */
+			if (read_format & PERF_FORMAT_LOST)
 				COPY_U64(); /* lost */
 		} else {
-			u64 nr;
+			u64 nr, entry_words;
 
 			if (CHECK_BOUNDS(1, 1)) {
 				ret = -EFAULT;
@@ -854,17 +857,18 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			}
 			nr = in_array[i];
 			COPY_U64();
-			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+			if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 				COPY_U64(); /* time_enabled */
-			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+			if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 				COPY_U64(); /* time_running */
-			for (u64 cntr = 0; cntr < nr; cntr++) {
-				COPY_U64(); /* value */
-				if (evsel->core.attr.read_format & PERF_FORMAT_ID)
-					COPY_U64(); /* id */
-				if (evsel->core.attr.read_format & PERF_FORMAT_LOST)
-					COPY_U64(); /* lost */
+			entry_words = sample_read_value_size(read_format) / sizeof(u64);
+			if (nr > (max_i - i) / entry_words ||
+			    nr > (max_j - j) / entry_words) {
+				ret = -EFAULT;
+				goto out_put;
 			}
+			for (u64 cntr = 0; cntr < nr * entry_words; cntr++)
+				out_array[j++] = in_array[i++];
 		}
 	}
 	if (orig_sample_type & PERF_SAMPLE_CALLCHAIN) {
@@ -934,16 +938,6 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		}
 	}
 	if (orig_sample_type & PERF_SAMPLE_RAW) {
-		size_t bytes = sizeof(u32) + sample->raw_size;
-		size_t u64_words = (bytes + 7) / 8;
-
-		if (i + u64_words > max_i || j + u64_words > max_j) {
-			ret = -EFAULT;
-			goto out_put;
-		}
-		memcpy(&out_array[j], &in_array[i], bytes);
-		i += u64_words;
-		j += u64_words;
 		/*
 		 * TODO: certain raw samples can be remapped, such as
 		 * tracepoints by examining their fields.
@@ -1041,30 +1035,6 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		}
 	}
 	if (orig_sample_type & PERF_SAMPLE_STACK_USER) {
-		u64 size;
-
-		if (CHECK_BOUNDS(1, 1)) {
-			ret = -EFAULT;
-			goto out_put;
-		}
-		size = in_array[i];
-		COPY_U64();
-		if (size > 0) {
-			size_t u64_words = size / 8 + (size % 8 ? 1 : 0);
-
-			if (u64_words > max_i - i || u64_words > max_j - j) {
-				ret = -EFAULT;
-				goto out_put;
-			}
-			memcpy(&out_array[j], &in_array[i], size);
-			if (size % 8) {
-				size_t pad = 8 - (size % 8);
-
-				memset(((char *)&out_array[j]) + size, 0, pad);
-			}
-			i += u64_words;
-			j += u64_words;
-		}
 		/* TODO: can this be less conservative? */
 		pr_debug("Dropping stack user sample as possible ASLR leak\n");
 		ret = 0;
@@ -1110,31 +1080,6 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		COPY_U64(); /* code_page_size */
 
 	if (orig_sample_type & PERF_SAMPLE_AUX) {
-		u64 size;
-
-		if (CHECK_BOUNDS(1, 1)) {
-			ret = -EFAULT;
-			goto out_put;
-		}
-		out_array[j] = in_array[i];
-		size = out_array[j++];
-		i++;
-		if (size > 0) {
-			size_t u64_words = size / 8 + (size % 8 ? 1 : 0);
-
-			if (u64_words > max_i - i || u64_words > max_j - j) {
-				ret = -EFAULT;
-				goto out_put;
-			}
-			memcpy(&out_array[j], &in_array[i], size);
-			if (size % 8) {
-				size_t pad = 8 - (size % 8);
-
-				memset(((char *)&out_array[j]) + size, 0, pad);
-			}
-			i += u64_words;
-			j += u64_words;
-		}
 		/* TODO: can this be less conservative? */
 		pr_debug("Dropping aux sample as possible ASLR leak\n");
 		ret = 0;
-- 
2.56.1.703.gf848ed807c-goog

