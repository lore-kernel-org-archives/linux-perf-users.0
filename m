Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD2443ABE
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587943; cv=none; b=ZrbpmccNLNujBkVRiiR9dy0n3i8Sw9lHuMuhbP2YN22hA0i6yD92kbKFnVsYSwytJ+XZWXtMih+Z+xgKVyCn2TG0elFPnDbIrcNEwBtxE7wk06Mq3XzApqCqZGqIgTBvhZbHD4nI2+YQlR+dQB0kdl0Oh45s+/9tNLeYQkZz6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587943; c=relaxed/simple;
	bh=5HHYV2YtuskvpVXWLLiEwNUcmcEMrY8dXvLciuEgNo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tmn8E2ITfcmTa35vEyzekbjb3xXNGnX/XqbZyhKv3DqWLy1+1u7GyIxf5a2IPwpNWCSqu1orRoQwG5rjVCi9eKeeDR7ixmhWlRj6z6WI/p9beHqQFo/3hUlE68iNqRC6T9CQHBFI4/KuTDIxym1pOc9TL+KKVTKPXIuCeoj0vdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qF5cvBcy; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qF5cvBcy"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so13692955a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784587941; x=1785192741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVysXzCxvN0YWO4pl9MoMoRFZ8JrR13DJYNHpKFDQUI=;
        b=qF5cvBcy0kCfy5nN8czq+tZ560rQj+xUPI1Rox8gFtbZzIhEbKyJTvF9phe9y3lwLW
         4S0z4DN40DU4hdoBeatBfPpwce5TS7hkigXSf6WsCz0yiX5YwyPMvA4xG1Pr28iQZQ//
         /2+RV7+iMEpkwQz8RuPNYaQWxr86mf/N5PgBrlhI7Acd/Ly9aPx1aJnmmgjQSaxTm3Fx
         Ts3QK7vW0uWCBx0CXer6ZgacDBy2gZWGqRevkgIzBXtkq8gmW0OdhGuq4ZRXRFhENOsg
         7jdBRRfZzlUEa0glnAssmxUyqh53xOHFPzCR53ttOG/1VUQTC/mm5tMH0gt9J3Icj8l/
         8hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587941; x=1785192741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVysXzCxvN0YWO4pl9MoMoRFZ8JrR13DJYNHpKFDQUI=;
        b=mofN1eaJ+iyPLh0ca7pW2OsuvZZmbhUF8HVC9M4thSvNWG4SKMv1NqO6vIfuXEKI55
         9zr4lEG8Z6pBnIDO8Rd1KIom/F8wwF3aAPYQtapJntk+s6NsABPi4OXq/zKCFRp1B5/x
         BdAD+iFUzHTmyXQN1CM29p9+BhvsnW09mT6IsAlSAi8EPRik79YKY+DJ+B5JJBYSPCtp
         kC/hiEah4yXhmA+kNreLOhFrrlfqg8gsoe+8ByrOQX7FOPAWPUQ9ElkwryKLUU7tLplq
         /NOJhWDge+BE6XBHTum0L8KcNTCSkiWVvBJEpd9EaBXIsFdC+aXh4oQyOuk2FTnsIMTe
         WByQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnMsTHNfAklj37sas+u3i/xrbS31euJKAvSYzwWCNl/MCk86Ph0cBSu4wC5OuSQiUnksKcQLygEVJUE1YsI4Tj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi13COqCX3xS+3rHUHu37RpKlq6vO0N1aORDdws2/v7sxtdQc6
	ysHNqfB2qXjNNp75LSIifrVpdQbOhO6B9x6r46OPpFOdwMO1w5Z/V4NjivBjixebO0YqAwbYmH4
	xToJ/ab1evA==
X-Received: from dleb4-n2.prod.google.com ([2002:a05:701b:4244:20b0:13b:962e:3bc8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2807:b0:37e:9e9:6ffc
 with SMTP id 98e67ed59e1d1-38e4b532703mr16779161a91.25.1784587940457; Mon, 20
 Jul 2026 15:52:20 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:51:59 -0700
In-Reply-To: <20260720225200.3810501-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720175455.3645946-1-irogers@google.com> <20260720225200.3810501-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720225200.3810501-4-irogers@google.com>
Subject: [PATCH v2 3/4] perf synthetic-events: Fix bounds, stale state, and
 misc flags in kernel module synthesis
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, Ian Rogers <irogers@google.com>
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

