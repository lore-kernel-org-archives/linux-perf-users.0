Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBCC44210A
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675404; cv=none; b=XjBxMUJFULvHSJn5CR6e54gmM63ge6OPEdDG13O1Gk0HFNt+OS2iClpF61Iz6JicbI8ccxK0JjFWXrN+m+VZP4x4yP2LePQRhoSIzsdM3T9X2xjLmpUZFPauiHb34zgjqVNNwMq5iwEbw+ylWBUpSX8vhv/FVu4hnOt0kBtcP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675404; c=relaxed/simple;
	bh=tf8a7E3zLZPXOo8wdboL07PVGKzbNs86Kz6VLzQ5/MM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N68Z3Emc+ZvsIygivPkO7HpYdsBWtgMrA8Q03/uXIlfimIMpeDCxsbrlROJL9Tk9IB/H9Q9ndzLEn+/eULlqOcBBKXjOIy3xjMUNZiw8IhXai+HWJ1kECBVFGjv34cdmLZzW/L0wviMOZmIDudeT4pA+EnpxMHbTebZR7uZUOCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mD5c94lN; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mD5c94lN"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccbb61893fso249260705ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675402; x=1785280202; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nCcmiUW+ScGTENgJGOrWJXCdaGzQrQOCf0avkLvcTWM=;
        b=mD5c94lNj6VdqupV/SPPHPqtxF0Pk0DgLM0YZCzvT6bZhJbjo5zdF2nYkGpy0+lM76
         uDTytnVnG0q0YThevAdzDLq26vzZ6/NFzPb7Guoce3eB3l4bQ1dQgyDrDXE4SuGdYqVV
         EAh3gjfDRtEzF/89n5Mi3f8uoLcOH/wC46OcJLWf3/+JpT2bCrcLA7+WthvHIqQwwztu
         s3wcsbqRGY+M3gmTEKvaaNiCJdyaRUsBx+bQyqFKmfHTIJUmGU1+AxBK72T2bk8ajABu
         W7vxXdkwccLL8a669KLtiXQL1WhvqqJiR8GAJpNhVZ8VcyuHlT1ojJJbTdg93VlIZaiA
         oyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675402; x=1785280202;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nCcmiUW+ScGTENgJGOrWJXCdaGzQrQOCf0avkLvcTWM=;
        b=NjFJJw/fsDfUIFt+dGtiijOCWgpbvR8DJCJj0hX4hMU81uFir4GVOnQL1ryDl9z61U
         on4G499Rdq7mHfNgq9PxzObEUVxuD2KNsXHjPp4KLKqYsxe8L7CG1h3XLDN8W1f3mQib
         TUoqprrJRHZWPFgY+4zOpvYkDhOcth8pV58O7QN2bR4EhW2psj+B0wqf7zz25wNnWz9j
         jr5Cwz4LvPFCNlLCxoTdwM7LPKDwSrcE90Z9mbIfTs9byx4vAEsXd5X7U1oLc2rbP6kE
         xSpMruv2hu9DsmmEF0wGVmUo+viNgDqteu4dJFAHTw8kqaEe4mna/sNWNk/AKolll+et
         VvwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnPsNJcUgepMhPC69dw+sht5f4s92H8UyE9oBkc0bTRoe53rIQ2OP+r3isenlPXvQmdAiSPLJA4I6rXf/g/5u/@vger.kernel.org
X-Gm-Message-State: AOJu0YyToMyNBJhACKbRJI7aEw9rWP24CmnjcRWRsXlhbTFeep5l9OSb
	UqHGOW+cJbgzzM9H1F41Ks5Dr4QjePqhot4W5FFw066qZdpHqVuuhU+0EAiFLwBKVjYYVcbmOHt
	DO2nsT8EIJg==
X-Received: from dygg9.prod.google.com ([2002:a05:693c:80c9:b0:313:d984:da01])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0a:b0:3b4:7d99:a23f
 with SMTP id adf61e73a8af0-3c3ad8b3abbmr24843081637.45.1784675401631; Tue, 21
 Jul 2026 16:10:01 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:09:51 -0700
In-Reply-To: <20260721230952.267754-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721205746.183206-1-irogers@google.com> <20260721230952.267754-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721230952.267754-4-irogers@google.com>
Subject: [PATCH v6 3/4] perf synthetic-events: Fix bounds, stale state, and
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
index 832b74ffb4db..4043d17a6140 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -757,6 +757,7 @@ struct perf_event__synthesize_modules_maps_cb_args {
 	perf_event__handler_t process;
 	struct machine *machine;
 	union perf_event *event;
+	u16 misc;
 };
 
 static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
@@ -764,49 +765,78 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
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
@@ -831,13 +861,13 @@ int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__han
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

