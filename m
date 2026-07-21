Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B945DF7C
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667489; cv=none; b=BLT8juUExnAm3sCuuU4gSW82JzwlWl9/f4T+BsZUfL2Yf0gWC428hEc5F17Bqek178i9WNSgKBsfVZGP5km25gtIyZzyx6lAJFGs7P06u0xXclxXRRgYc3mEvwhLHAENdDQw9TVoH2F3Qm7Jy6tTYTdYEcJDJ6BzrUh4/3HidNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667489; c=relaxed/simple;
	bh=ilTt+lqSIVDLcJl1GrKDA8A9dhWw9mAcR6hEJFlXgzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ki4gtEfSSJyuCfKfLbk+FDq1eMw7aAaNLvhmfGgFq0xk1rbd63MRAf55xXfSIzGvbt2nAaYJrtskvAv0Vx1casTzawCvX2E33EqQgZ1pqOMIouDljrfboxo+h2ZCI+8FnBvlSSfEIXJbioQ3eh6GhJRO9v9tC9r0Xim5Xh7KZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5dXfDkM; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5dXfDkM"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso7795660a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784667476; x=1785272276; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDtnweH9LMafsFo8ScEZrEnImvWALolTWFbjTPI5axQ=;
        b=q5dXfDkMH+rilyVq7me202/bObbkmj0jkfl8/KVm0a+/EEk+oGtBrCVjF+OAOiEXQb
         y7ES32w3W081sxA1cdCUUv9GMBrt2ohDMOP8m0o8NR5DDJ41uWnX4KgdP4cOXaG3WXaA
         qrEjyvFWjBLk3uDqwNWwkavFWybC+kV1fG9JONvg9FcSbu5aqAsj8Vvf4fRjL5hdTXGw
         LOeM3PAXhq6begqiIkQEIKnUDG8FGpYKpT770o6O95bqzsr4/hbMersewD0RZsdtnzbL
         eT4GUr1SUY62pzeq2wWFzvuoXSO5VVNxBR/RGnkAoBGIWHvRj62VLK/v7vRqVTfY8rod
         c1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667476; x=1785272276;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDtnweH9LMafsFo8ScEZrEnImvWALolTWFbjTPI5axQ=;
        b=iRSgriAOOrkbAZEF++BhVEwN5Q9KKizL066beJYOCBXMcrtq/RT2L9aP6+kD7T+778
         pyPaZvRKRBgGRhNWXM4kPbiGFIoWf1Sii0JX4cSMjuhFic2Td3fkOzHB34BdMbEMgPzg
         7EhQa0KbiceJxRTlWm5kEaZ5NsSPcSKW1egPwGzQeAKYsx2OuPnci/tSaEy4cKwzJ99z
         zLz8lmpTNJr2Icnj3JNHIP/bbPfxk6tWfhjSUo/HfySg5FXcxjysSEP6chBiwchTBpbh
         h6xtCL4WsHhDt2WIJQ5I5qVzGGWmDjVuxgbJWg4N/e5+pEsyknALDypzxDOxwPhF+sG2
         FbAw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7ZMWBcKHlVIOy2+2j2JUz6qp5/NDPfLrSzVQbs21El0sR3ITS35OWrx77vfrrEcnMGTedkpHgXWpbH1+SyLfr@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlb7Aj11vvjWy/dt0oTG6N8AR1rVd6PeSgzAtNjJcdolF39PZ
	bF1uQrlzrky16WZ7IMfZ23ObLDLoRunX5bOMSYVVAR86++7rhAUAftBLr9HUBLi21wKcJCe8D5U
	rDfNWNVzIGw==
X-Received: from dlcio4.prod.google.com ([2002:a05:7023:c004:b0:13b:8bb2:7330])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4f:b0:38d:c50a:714
 with SMTP id 98e67ed59e1d1-38e4b56dd7amr21978322a91.27.1784667475588; Tue, 21
 Jul 2026 13:57:55 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:57:45 -0700
In-Reply-To: <20260721205746.183206-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721182150.94016-1-irogers@google.com> <20260721205746.183206-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721205746.183206-4-irogers@google.com>
Subject: [PATCH v5 3/4] perf synthetic-events: Fix bounds, stale state, and
 misc flags in kernel module synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

Clamp long DSO names to mmap/mmap2 filename boundaries accounting for
sample ID headers to prevent buffer overruns in
perf_event__synthesize_modules_maps_cb(). Explicitly clear misc flags and
union padding to prevent stale Build-ID state from leaking between module
synthesis events, and cast event buffer pointers to avoid _FORTIFY_SOURCE
array bounds aborts when zeroing padding trailers.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 71 ++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index e73f2e526e83..4043d17a6140 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -757,6 +757,7 @@ struct perf_event__synthesize_modules_maps_cb_args {
 	perf_event__handler_t process;
 	struct machine *machine;
 	union perf_event *event;
+	u16 misc;
 };
 
 static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
@@ -764,44 +765,78 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
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
+		if (size >= sizeof(event->mmap2.filename) - args->machine->id_hdr_size)
+			size = sizeof(event->mmap2.filename) - args->machine->id_hdr_size - 1;
+
+		strlcpy(event->mmap2.filename, long_name,
+			sizeof(event->mmap2.filename) - args->machine->id_hdr_size);
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
+		if (size >= sizeof(event->mmap.filename) - args->machine->id_hdr_size)
+			size = sizeof(event->mmap.filename) - args->machine->id_hdr_size - 1;
+
+		strlcpy(event->mmap.filename, long_name,
+			sizeof(event->mmap.filename) - args->machine->id_hdr_size);
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
@@ -826,13 +861,13 @@ int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__han
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

