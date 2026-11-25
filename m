Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567900;
	b=4pT2x7P1t+u63Puk3E7PeubtvRCPTODvJXIi8zNhAxH2kqhTef68fJO2lQIM7CzfPDoP
	 rkBTlF+iT8Axvyb8+XbotSPfvPC2ox5lVvnm6Oo0hcUbiIxknJR5jVGfoyANzU1mLaZed
	 elPYPWx2+f5JDpCl6TIVhkxgIBDx1+7YWkZOkwpjdaoWLWLNCcS18GFyxJLiLUG81ZpRT
	 xFiUFD86pk0lTROZYQ87MeBO/NhKjMHKoBDLOfrfOAk4e6QS5aaw9djgAJYWGWLGBawlR
	 ikI+L+hyAwyB6WUFRS/COK3y5yh+zDLYYzznfWi8lFta0KIly6qdaVtamO3yK5E01eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KDJssrbblMIXLxqZHq4dpt6VPGkkcM9Xr78+BDrvgt0=;
	b=Snvi/rlttmKNa8ZGqbbR00iuzfyMALxqMSdwNK4oem86jfGG3qs0YfLzpeUllPzjjYMN
	 sVI3l6vtflvdNn8DfX1Z1ObMpqHdShLVNV8W730WjOEY1ozlNuphOea7F+lQsaERfB4eW
	 9Zi5SkFcbFfV75YMhfUQFgsZLHExKkKBByY9+KQToIvxgBFbfzceLvIVU4iAJm1gTqpML
	 uRcpKmeO5ohuVEtRD1bA35udU74/czi/zTEVjy0HRXwJCW0u0dWxHXWGVDiC0dm2t9KYy
	 wbhM7gMRd3+OnoLgoAhjgBQpG0Tc2X5m/ZGNQV7pxFtl6wdHt+cx1a+47UxSrPxp+Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UzwoeVZG;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C9E606A688
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C9E606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UzwoeVZG
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-38355b03cb8so5055836eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567899; x=1796172699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KDJssrbblMIXLxqZHq4dpt6VPGkkcM9Xr78+BDrvgt0=;
        b=UzwoeVZG+VFmMVFicAYWGsNuvN18UrWrkxeEh1VuCloRQpd0QawqTbbrCu+G1WawA8
         pX7noBzG85cg30arCMST+LBgaaZjIiE0Ed+yIqaRhDmSjvTJYyc6nnCd4JMzxPvVwI32
         lYFQtXTiQBkeyV/xmjmQ5zuxt+mpGkHF/mN7sz2g8ImhLRZ5eFCODsxaJZZ56DQcY7Kw
         /Aw1WeslAXcvls0BGGKUDVEHHts3KXzaG1ryNgp6oiVrQHd6HTnHPAGjvcUZoU7Z8r3t
         H1r79ytRJaJ2VrrmXSvIPcMr1IksMrRl/zV5COexg18FJxXxyWo5sXRlUxgP7rkUIBSg
         +CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567899; x=1796172699;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDJssrbblMIXLxqZHq4dpt6VPGkkcM9Xr78+BDrvgt0=;
        b=rXTNnVaItfD53inw3muK0JlztpFNLuhzD/AgyKoLWVX7xYMQ0eY+8DY14VfFhzgL47
         i3yNU3OxtPwVlaBh+lNZd8wCb5PIZ6FL2GcKrD7/dpYt8fYLf32HV6m9vv29gD2NyLqw
         kZlOoA63CND7ZxCQKbPGCJ5L4oRWk+qiRQP7zW/m/b2nWSNsyJLy8rPrAUOITuaXDK9P
         KQEPuicjm58XwP07FrM1QoQWvdYUrbp3OXj46+fWBhJXUaxwYTaoCNgmrfPMVQ297dtY
         YwdcRmgrDphiET6DEidIW5z86iHAfpMmPaBYti+drNtmmz9mS70SL4+SfzK+UhK0EB+o
         xHpA==
X-Forwarded-Encrypted: i=1; AL+hErEgP/TEJ/YX8LGzvGfcpJ+cb7g0AA68lReyJyD8ZIXTw1N6t6oZmLOjFSJEIJeI+HA2hjmZkeLF2dLAZED5EHa9@vger.kernel.org
X-Gm-Message-State: APuU4Z+7eTchJWILJSgYEPM3GAW24Lg5OSG1GiovpgGfNNjYkLC5WQp/
	hvCgk6h+1aWSl+osqltmiva0uxElcmAFU30rSehWPrDczN+2AI1Px3RrCDtv8Js93Tac8ZDA9DC
	1hbbg5jhHgg==
X-Received: from dyib9.prod.google.com ([2002:a05:7300:79c9:b0:386:b9bf:ecab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d205:b0:36a:1f8:a56e
 with SMTP id 5a478bee46e88-3856fe564a1mr16408220eec.23.1795567898888; Tue, 24
 Nov 2026 16:51:38 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:58 -0800
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
Message-ID: <20261125005108.1020003-10-irogers@google.com>
Subject: [PATCH v4 09/19] perf inject: Fix PERF_SAMPLE_READ layout and bounds
 checks in aslr_tool__process_sample()
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
index 03d6fe064559..ae7ffdc56b4d 100644
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
@@ -782,7 +783,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	out_array = &new_event->sample.array[0];
 
 #define CHECK_BOUNDS(required_i, required_j) \
-	(i + (required_i) > max_i || j + (required_j) > max_j)
+	((required_i) > max_i - i || (required_j) > max_j - j)
 
 #define COPY_U64() \
 	do { \
@@ -837,18 +838,20 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -856,17 +859,18 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -936,16 +940,6 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -1043,30 +1037,6 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -1112,31 +1082,6 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
2.56.1.831.g720f3f5937-goog

