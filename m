Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AA47604C
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677989; cv=none; b=MP9v3jUuxZ2RKwjmK62pTkm6wliz969FNjs3IqVhoenaLkMnuxzN2y5wSVm5d3K+1qSW8sYAPWlhqYpm6oRVpv+gymuUKZ/WydmeOIOtp36tAyZMRs9C/uSCH9q+/++yfeNMGhuMjMqKOpcB7kCFh9OtKN7V5gYuyab1pZTzjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677989; c=relaxed/simple;
	bh=paepAH2E0jLufHogFip8cAVfpDUXNWbxACpeWg+pSWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YunsT5zE++dCafR9FY60R1n3829BVXw7Ctv9Qh0fyFWQ/jqrBcQs0hhddkhWu9Fa1XX3+SRJMtyjMNnadW5tDWgn300rCHk01lS27M2Qbsv589HT/HkfwCFUUy3lxygfJKXicSZTs5UfKlzLIF0MlVNg9NWrwWyKDRJMktsWUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Adzc6vZj; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Adzc6vZj"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb733fc5024so4241616a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784677987; x=1785282787; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKPG9XIny/RZplkPYLo3KKeMyTZgRDdgY2/iWOu0y/A=;
        b=Adzc6vZjNMdwH/pes8Ye2rbcLC/JdUNqkdW/FXsx38oB1S5GAphm0vKynoDx3/0rbe
         8+1fgZLbKKsXqhWd+F47F6vriXePoSGRjkSmz5iYM8phE0QdeJTDR2dj2RIwIJgTNUAx
         /5kssFcTAZrz/kZTwdwnciNpTJMR2MTMvvFcR9HQKmRbALSwQYEEj5f3F97jkAXxsx3v
         ZwO6AptyR6vdBjXbHCWIVkDrjJFH4CofmMEUhvSCh08Xq7BQh+VzQazrc3hzjFeuNQq3
         EityEM5KYGJpgM+AFgG3IniXNQOmK58bHtVwnJUwo9M0cBJ4NTmdKnkd8AZuYoNDD1NR
         Hwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677987; x=1785282787;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKPG9XIny/RZplkPYLo3KKeMyTZgRDdgY2/iWOu0y/A=;
        b=Z/mnTmGzwRGdcX+MR7ANDiqxefwJq0d9olTfoWER8ow0sZ2bA32Yeztr+ZTLfDrTvb
         gL9Bvn4LWEdteEGCSEsOAFREnIiY3mEPJ3bprejZSaNQFnheyQ9LcKSgaVdA22skoQTZ
         +XAxeUVDnMn8lw9GFo9lYI3zAytAG786WcfHIcEIfJso+wUwMGTsE3AIAOgJT0sTqGbt
         Zv3gTu9TWYKUbAR4v0yxB1y6YUOS1+/DVataKpanXGRFKcx0zwhiqssmxfj172te6PZK
         2dH3gZzide6MZzeX+vOSd+BhJAp3qP2jPcX/SZd0Mtwp5SyUaf6fqcIEyh6qaFrR6ya+
         zxrA==
X-Forwarded-Encrypted: i=1; AHgh+Rpn2C3/BVZzE0i7ODNJzso8+QSARxxVVRbl6ev0QSAFh21nZZipU5YoQKTz58ZhBZP++90ttc1sbxzEG5xeb0PX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3bx83qVDauK+K2mYHpJUQ7gRQ2Wx9xde5O3OowGb2FA22fQV
	jQAfo5AYCdWcFPbM4JN7VPYo45wzghhNfXhU8RnAosYkeIHvRrkwVJVBtb3tkDmeZSZCEeP44JG
	n3+GsqwAf5g==
X-Received: from dygg9.prod.google.com ([2002:a05:693c:80c9:b0:313:d984:da01])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6a17:b0:3c4:2cf9:2896
 with SMTP id adf61e73a8af0-3c42cf939b3mr779017637.45.1784677986715; Tue, 21
 Jul 2026 16:53:06 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:52:53 -0700
In-Reply-To: <20260721235254.294053-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721230952.267754-1-irogers@google.com> <20260721235254.294053-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721235254.294053-5-irogers@google.com>
Subject: [PATCH v7 4/5] perf synthetic-events: Fix bounds, stale state, and
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
 tools/perf/util/synthetic-events.c | 70 +++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 05075840707c..5bbf024ad606 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -764,6 +764,7 @@ struct perf_event__synthesize_modules_maps_cb_args {
 	perf_event__handler_t process;
 	struct machine *machine;
 	union perf_event *event;
+	u16 misc;
 };
 
 static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
@@ -771,49 +772,78 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
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
@@ -838,13 +868,13 @@ int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__han
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

