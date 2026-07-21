Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA146D557
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655249; cv=none; b=NVqFkHyKrVQjFGHPGnnMSIktHjxvvIfWDiqOiX8OL+yU9oNCoLm38uq/yZ1n1tw1slZg6kQBUnP4ZOphlqnrorUD+P1xTyAUD686UoY55q2FTwdsRUrp2TPEWHHTOJp4k8Xf93EisB0lUMkTjtKAGm8K94pyY3GU+c4+Em6hNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655249; c=relaxed/simple;
	bh=5HHYV2YtuskvpVXWLLiEwNUcmcEMrY8dXvLciuEgNo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rQNno9FaWjVNvYe1uwJG2+Btb7RkCoc47oXA92neoY6t2lAKsYe3aY7FQev3gxucTKKmcymXnUQrebflESypRyFiFqk5D35BllaR3h9kdhZe4vTht9be0EHcqa8RzjxrH2cJxVyhzQugU7FWpb7efWjmc1rJd08t6MHl5zF2x/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrcWUTkH; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrcWUTkH"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9c26587e67so5743246a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784655247; x=1785260047; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVysXzCxvN0YWO4pl9MoMoRFZ8JrR13DJYNHpKFDQUI=;
        b=QrcWUTkHE114E7/73aCuWVO78Dg69vNN63FnEcdFqdB6zpCF09Hc/37JmCPGXONDr3
         9YI/tnODDZEZyqRjsrGFAA5hSLHVXedOuHx5tdXgkLC1dMLpxIuCg3CfTs7CAwHJWSpy
         J+Nte1rb53/ht8XVL1kaZclpPm9GfOPq9QBwS6hjUF6BrEns6G/Yum1d6N8jrk3+fsY2
         oK+vx3e4FR/SMoyCnAmq1iehtvZ91wgvbcFlVlCY397o3FXI+tnZbcxQ7ynsUPXDMO7E
         z8505BqumwTEIfg0ZPXsNjbWQaJ9EYVJWOc+HQHks33QOblarJTDi9DSOi++d+DjUD2F
         lYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655247; x=1785260047;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVysXzCxvN0YWO4pl9MoMoRFZ8JrR13DJYNHpKFDQUI=;
        b=nJoC6W3BQXp/eiK1iwErhjKszqyvo890lY8f/21CL7/gPL5wg1VYPH/mO9MvGrWHIY
         lqldQQ84IRwSh+KZxPtoN4yI+P9CQLl4DelY0Ry4Cmz/ZHH3xX2ZvHZ6S4tBuCdPt/HB
         QK8XO+MoQPHueQcgI+vnHD4cH0xTk9rhIwYinMXAzSgvkT8+fpRF3gVsU3c4cUOPdZeM
         gMyT1hwxT30+4ai1r/NiHwFK1YVR7E8Xu2E+RV65nRuNXcvnzNkl75L8iB7saNn6j6Di
         em+VSkIsIKPckLKSPUtlCe0JTWGR5RaDT/bpxf/syyXh1vi1xTp/7Z49ls/7C12kURlW
         RhbA==
X-Forwarded-Encrypted: i=1; AHgh+Rrvm03FFm443yhHFQUto2b/JUeBSy6QcKduvtAspJ2O1fS0lq9un7VTwBxYLh1/A+zvmP/Lqt3Xeqflapf/sIfI@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGMY81FNkmWwRvw62ihAnqn4syiAfoWqm4lQKNcpXuudJ52/w
	yKGKyBpLBVWelk4Ugn/pTjs+Nve3IU9OAcRjf7/v6nAMao742tb6HAL6gJpCt66ILK8UnoW5xpO
	Mqv+EbAr1Dw==
X-Received: from dldyq2-n2.prod.google.com ([2002:a05:701b:4542:20b0:139:ce3e:27b3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d05:b0:3bd:1cfc:1b9b
 with SMTP id adf61e73a8af0-3c4292c1e37mr586336637.10.1784655246881; Tue, 21
 Jul 2026 10:34:06 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:33:46 -0700
In-Reply-To: <20260721173347.9163-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720225200.3810501-1-irogers@google.com> <20260721173347.9163-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721173347.9163-4-irogers@google.com>
Subject: [PATCH v3 3/4] perf synthetic-events: Fix bounds, stale state, and
 misc flags in kernel module synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
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
index 9a2b4d561e9e..068323b9510d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -754,6 +754,7 @@ struct perf_event__synthesize_modules_maps_cb_args {
 	perf_event__handler_t process;
 	struct machine *machine;
 	union perf_event *event;
+	u16 misc;
 };
 
 static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
@@ -761,49 +762,78 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
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
@@ -828,13 +858,13 @@ int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__han
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

