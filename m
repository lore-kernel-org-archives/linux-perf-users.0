Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F844DB95
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570127; cv=none; b=u7hl7GzXsc1BFxczwLNysCVegQueZYuXJ3umZIlPcjnTaaQhFA343Xdy0tqCwYRZSlLKpAVfDXxMPwg0s6H1y26pWJknLyGn6EOMh1dJpFcY75K1p+5SWsohsqNHE4hUbUQw7GcXXAGYAv/NezwkX/4DOWk2KDfqFnZCZ6bQsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570127; c=relaxed/simple;
	bh=3aX1EaAr1sbEmdIn9uz/KO4l+FvPsH+GN6jP8P1ep6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e6sEvs+qeDCm+6yMIBRnc7cseNNvfdZtuVHjuBa5DE9cKYWP6juPioBTBV2yz1uyPqnaFMOiJg3IbNeC5WexAlGojV4VQRZIQ74H8kLxzVW20LSzSzWCcskKAznesZJbuwfwNQU6lr8n+irLUyJx6mf4S1wlIHsmlgqLbRyLLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVmNwouI; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVmNwouI"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so4656542a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784570118; x=1785174918; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RNdBnXJ5fF64ccDFnBustZkitp/xg6+f0zdlczyZFc=;
        b=FVmNwouIOiiv+j4iXpTvuHjBU/Hg/K+eeVJPXPNA9Ae12paQfo2w3lF4j6jRgJTJkd
         V56eJZ+ratMUZeWFD8R+SDOF3O5z2aoc4WUISBSoGSh7jGOrfoWA9n3ty5OLZ0suVvLd
         XW8tvzB5uqieSSQysDLJuAzlnskwqf98H/srox2zXUrZQdvAqqRoaJ6ly7gRouWsQw3v
         kAlw1sVmvCTIfzTxDMXVPB5NykGuukqhN/5FIyTHl1GvVm8HTLXoK4iLzwjvBnvyETo/
         L6nGC9o3Ylmm3sr9eBw3SwJfqF89O9t/YDpIpjzanH0kvEzIn053cpPt+s47yVbAqHXb
         VvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570118; x=1785174918;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RNdBnXJ5fF64ccDFnBustZkitp/xg6+f0zdlczyZFc=;
        b=cT7roBEv6cqFV+TAg83gbsxokA+gHMAAMJNsBk9BneoBz6CVTURGb9gg9djR0Dp35J
         cjXu/ajU4oy9GNo2s76m5FAxFUycJuuQttISAk5sz6wKBCwCdDXVGlKIDxyKBKtnxnp0
         6TNSONDQL35uzid3G2mij1wJf7Z3wfT0T2pw4dsMxMkp4y5I4+8Vg0P9FvOUKZYkSOhI
         6iKxn9I1LEnREfr2zSWCpHfTxk22FnQ3Y+a7UvAe30fVcaMTomourLPSrc6PivT2zWoz
         4a0kusOnaX0JW84mvTor6c9aV3Pu8juiA/wNlLwDhvKJaB7RnzpmDYVJwIjP8vsk5Ulg
         cWiA==
X-Forwarded-Encrypted: i=1; AHgh+RoN0ppyzOqJz1VVocwo8yZH95m3FvrZxOju/uXtyZq2lBbPWooWwQkxb9Zolcb38mtO2Ni/3aK+loDYHl0uMTC5@vger.kernel.org
X-Gm-Message-State: AOJu0YxnezUo77gIW+nChSZwMlNlIWq60GlmRaeTMnLX1C0CUXDADoBS
	k8oN+NxJgM5AS8Bz1KbhSqUMeRD/qwH48e8r4L0W+j9oa7x+ago+y9VzITDVUjFJHqFY2MqlCW0
	FfMliRn3WUw==
X-Received: from dlec16-n2.prod.google.com ([2002:a05:701b:4290:20b0:13c:ce0f:370f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c46:b0:387:e0db:bc23
 with SMTP id 98e67ed59e1d1-38e4b5536d4mr15288594a91.35.1784570117345; Mon, 20
 Jul 2026 10:55:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:54:54 -0700
In-Reply-To: <20260720175455.3645946-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720175455.3645946-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720175455.3645946-4-irogers@google.com>
Subject: [PATCH v1 3/4] perf synthetic-events: Fix bounds, stale state, and
 misc flags in kernel module synthesis
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix potential buffer overruns in perf_event__synthesize_modules_maps_cb()
by safely clamping long DSO names to the mmap/mmap2 filename boundaries.
Explicitly assign and clear the misc flags and union padding across all
iterations to prevent stale Build-ID state from leaking between module
synthesis events.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 70 +++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 9161dc728e6e..aab958cb3bc5 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -748,6 +748,7 @@ struct perf_event__synthesize_modules_maps_cb_args {
 	perf_event__handler_t process;
 	struct machine *machine;
 	union perf_event *event;
+	u16 misc;
 };
 
 static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
@@ -755,49 +756,78 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
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
+		memset(event->mmap2.filename + size, 0,
+		       (aligned_size - size) + args->machine->id_hdr_size);
+
 		event->mmap2.header.size += args->machine->id_hdr_size;
 		event->mmap2.start = map__start(map);
 		event->mmap2.len   = map__size(map);
 		event->mmap2.pid   = args->machine->pid;
 
-		memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
-
-		/* Clear stale build ID from previous module iteration */
+		/* Clear stale build ID and entire union from previous module iteration */
 		event->mmap2.header.misc &= ~PERF_RECORD_MISC_MMAP_BUILD_ID;
 		memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
 		event->mmap2.build_id_size = 0;
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
+		memset(event->mmap.filename + size, 0,
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
@@ -822,13 +852,13 @@ int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__han
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

