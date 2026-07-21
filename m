Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23E46DFEA
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658128; cv=none; b=HpVaN74aO0W9MBDqut7cdn862DY64WoJXiYYeGniB8LddFyL/mm8InzNyNlonJqnx47VRJ1zSu8XAEHCQCfyvB8e51iDDD0OoBT13R6SWVYzGDRoPcMZMPyi8ZcPM7md3owtcmxOiuryoyzmfAzPM2yNKY4UYzfnSHI26GZczjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658128; c=relaxed/simple;
	bh=8rV2W76OrLho3Awr1l5RlnvfGj9upiyT+0adcR62kcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sJ7/SvKQ9v6T7fwW0Yx0bkZ7v1wRE1Yaco0lGu9zkKbtKlBNj6/tx8I2vN6tYGMpZeqwz3nXNx/TyLgH8OUTTuKII4B4NH+kslOqeK+fkKZERLFb0vefkVr44p95Xl5Q+bqcpUZmPOPWLJFhAxT+Heq2aRhnuBD8IRn7ZrkNkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihO6tUlQ; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihO6tUlQ"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso4886899a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784658126; x=1785262926; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Psg2Kwj8r8r+xedYt30c9/NPeC/qe6QwRI5erzuXc+M=;
        b=ihO6tUlQgL89xySnv0OKKEhswzWwk1yKvHkS5Zg9HXrSFZiYwiusM76jDqt1ftczXU
         22BqyUSvTc9g3OfWg0TmZXEm9l+tM0n+z6HBgYV/B3GYzfofunYVkq5O3b4+/5GoLxoP
         hSXxSUZnMWbFWmhq+gHTUniXQPJaPtW53z80YFcdMGY/qUuxm2FLQ6tIByVJeeWSv5ID
         9fl4rR9tRzeU2WbsILeoY1u0snjZvUXbB6qAut61PGmJ3aZ6vlkix7zsKHhLQg6Nl17G
         iL8v/qTJVQV34f72OQ2hnXUnCtOwoFJ9Q7CC5pB4Pt0MFxAL6n1wfvGvD6YQ4Wl99UyW
         p2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658126; x=1785262926;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Psg2Kwj8r8r+xedYt30c9/NPeC/qe6QwRI5erzuXc+M=;
        b=im/he/RghpWDFQdUS7g9HEXfP0BDPVx8KPAJy821KHz/v3dDFI+rpVHRDVY9tUV7Gm
         HnBCMKZze6TPZTcezVwEfzNPkc/5HAz/lr1y98cAe8Cj9lyMjmzU8KJg775bXWoYCxcT
         Mnd45fHbseOzG2zV5xIbCnQs6wdRlXlmHcw8POJ32OJNKfq0yK6bRTYvVgEh/wEHAByW
         AH+wZiZ7WxGYpzCqoDoIE4dROQy5ExdbehpL9E2FVonCH09XTaxocKCN9M1iBk9xDu8e
         REcwyEBO5dchyHbvb1jnDs+tF8tvDtBPoWJsnBAlbvbAFc8PTdeVeRuDIIPIZcf7iaR3
         xnVw==
X-Forwarded-Encrypted: i=1; AHgh+Rpf15TiggY6u9xyoOgq3Hd2WKT7j6DvDwyBTzssdq6pju+L+UXWR2QJvRCy9MZl8IofqPpeJaEACft4MZAQfDg5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DTl4SPWSX7ltrTkNraJCCjPpBd2tuYfbVtkjM+Yzi5biYESj
	f89kiyRfw3GhLXKKBBc7tnS71zrKNG79ZxhBhkKyJt8SXGlfAJ6A5yX55RNeTKTaTK+VDTP1R8a
	+8CQO75gg9Q==
X-Received: from dlf19.prod.google.com ([2002:a05:7022:413:b0:138:4fdd:447])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510b:b0:38e:7aa3:df25
 with SMTP id 98e67ed59e1d1-38e7aa3e19emr9741695a91.43.1784658125688; Tue, 21
 Jul 2026 11:22:05 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:21:49 -0700
In-Reply-To: <20260721182150.94016-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721173347.9163-1-irogers@google.com> <20260721182150.94016-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721182150.94016-4-irogers@google.com>
Subject: [PATCH v4 3/4] perf synthetic-events: Fix bounds, stale state, and
 misc flags in kernel module synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

Clamp long DSO names to mmap/mmap2 filename boundaries to prevent
buffer overruns in perf_event__synthesize_modules_maps_cb(). Explicitly
clear misc flags and union padding to prevent stale Build-ID state from
leaking between module synthesis events, and cast event buffer pointers
to avoid _FORTIFY_SOURCE array bounds aborts when zeroing padding
trailers.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 71 ++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 60bdf2d918ea..e547874b77b2 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -755,6 +755,7 @@ struct perf_event__synthesize_modules_maps_cb_args {
 	perf_event__handler_t process;
 	struct machine *machine;
 	union perf_event *event;
+	u16 misc;
 };
 
 static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
@@ -762,44 +763,78 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 	struct perf_event__synthesize_modules_maps_cb_args *args = data;
 	union perf_event *event = args->event;
 	struct dso *dso;
-	size_t size;
+	size_t size, aligned_size;
+	int rc = 0;
 
 	if (!__map__is_kmodule(map))
 		return 0;
 
 	dso = map__dso(map);
 	if (!symbol_conf.no_buildid_mmap2) {
-		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
+		const char *long_name = dso__long_name(dso);
+
+		size = strlen(long_name);
+		if (size >= sizeof(event->mmap2.filename))
+			size = sizeof(event->mmap2.filename) - 1;
+
+		strlcpy(event->mmap2.filename, long_name,
+			sizeof(event->mmap2.filename));
+
+		aligned_size = PERF_ALIGN(size + 1, sizeof(u64));
 		event->mmap2.header.type = PERF_RECORD_MMAP2;
-		event->mmap2.header.size = (sizeof(event->mmap2) -
-					(sizeof(event->mmap2.filename) - size));
-		memset(event->mmap2.filename + size, 0, args->machine->id_hdr_size);
+		event->mmap2.header.misc = args->misc;
+		event->mmap2.header.size =
+			offsetof(struct perf_record_mmap2, filename) +
+			aligned_size;
+
+		/* Zero the padding and ID header trailer safely! */
+		memset((char *)event + offsetof(struct perf_record_mmap2, filename) + size, 0,
+		       (aligned_size - size) + args->machine->id_hdr_size);
+
 		event->mmap2.header.size += args->machine->id_hdr_size;
 		event->mmap2.start = map__start(map);
 		event->mmap2.len   = map__size(map);
 		event->mmap2.pid   = args->machine->pid;
 
-		memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
+		/* Clear stale build ID and entire union from previous module iteration */
+		event->mmap2.header.misc &= ~PERF_RECORD_MISC_MMAP_BUILD_ID;
+		memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
+		event->mmap2.build_id_size = 0;
+		event->mmap2.__reserved_1 = 0;
+		event->mmap2.__reserved_2 = 0;
 
 		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
 	} else {
-		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
+		const char *long_name = dso__long_name(dso);
+
+		size = strlen(long_name);
+		if (size >= sizeof(event->mmap.filename))
+			size = sizeof(event->mmap.filename) - 1;
+
+		strlcpy(event->mmap.filename, long_name,
+			sizeof(event->mmap.filename));
+
+		aligned_size = PERF_ALIGN(size + 1, sizeof(u64));
 		event->mmap.header.type = PERF_RECORD_MMAP;
-		event->mmap.header.size = (sizeof(event->mmap) -
-					(sizeof(event->mmap.filename) - size));
-		memset(event->mmap.filename + size, 0, args->machine->id_hdr_size);
+		event->mmap.header.misc = args->misc;
+		event->mmap.header.size =
+			offsetof(struct perf_record_mmap, filename) +
+			aligned_size;
+
+		/* Zero the padding and ID header trailer safely! */
+		memset((char *)event + offsetof(struct perf_record_mmap, filename) + size, 0,
+		       (aligned_size - size) + args->machine->id_hdr_size);
+
 		event->mmap.header.size += args->machine->id_hdr_size;
 		event->mmap.start = map__start(map);
 		event->mmap.len   = map__size(map);
 		event->mmap.pid   = args->machine->pid;
-
-		memcpy(event->mmap.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
 	}
 
 	if (perf_tool__process_synth_event(args->tool, event, args->machine, args->process) != 0)
-		return -1;
+		rc = -1;
 
-	return 0;
+	return rc;
 }
 
 int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__handler_t process,
@@ -824,13 +859,13 @@ int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__han
 	}
 
 	/*
-	 * kernel uses 0 for user space maps, see kernel/perf_event.c
-	 * __perf_event_mmap
+	 * Just like the kernel, see perf_misc_flags() in
+	 * kernel/events/core.c
 	 */
 	if (machine__is_host(machine))
-		args.event->header.misc = PERF_RECORD_MISC_KERNEL;
+		args.misc = PERF_RECORD_MISC_KERNEL;
 	else
-		args.event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
+		args.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
 	rc = maps__for_each_map(maps, perf_event__synthesize_modules_maps_cb, &args);
 
-- 
2.55.0.229.g6434b31f56-goog

