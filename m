Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E146DFE5
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658126; cv=none; b=jycezNmP70QcPIx0jbEwnWh2+UJ14hEBzA07A9whw5Cb9U/X1QOvC1Id/qvkX1o+ikdWdFfpaX17OmZm3ndr2f8A71/O1FaGUHVZ6vYszelL2N/LzeRb0RhWqfQnICBfUYJKJlgE1oKurwh9dkftiy80lxO1l1hlOixAAjSDjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658126; c=relaxed/simple;
	bh=kVLUTo+ptXzuTq9tddNzRpgNOze6Hvci7+fPDEacyB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tOkvRYCLdv70+iGt0/xjb+fg7XBBL2OePTajvSzr6ZMyyrvAF6J+Xa/hE36a0FmJxtURzTYTXR9G2X8tqvU5/zhGVGQ7on62CbSAuWNms3+oBsqXblrLoWCIR1CWfbgPloC2XRlYdtMXKJH0nNNI1sGlpdA8WzQsFQLYMIme+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tg2e+tiP; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tg2e+tiP"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so12635224a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784658124; x=1785262924; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pT1AGjFPyNgQFLzuI9oR5+KrNSsEKTbIXaPPVdP/DAs=;
        b=tg2e+tiPc8U1y+03tvJIQZveqqb8dIgOslRC/RHYbnEoeGB+xBSN+uL1Yroxvm1ZPO
         Kbkv4sbDL3EmhBwd3dEEx2VfrwRzBinidVuPz49rHUnihFH/7WyTb7VXdNIpw0jhZp0V
         M64i4XBmZss7TZfIwjyI/wPtZsrXQKNyJFOVBlXt2BSDnJNYydiCNr7JxfqyiKBS1aqX
         iRMQO4cxUV+KiQ61TobdYck7JzBSrkbfB2Afvyyy5oddM4qqFJvA5vmaeaE6OV5gBu1z
         pe+fqrKTG/mgL/TFKcZofpniwlgi/x3BGjwK2guYH4mi3Xn0QGMNwTi12QZypYetLbMG
         Q41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658124; x=1785262924;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pT1AGjFPyNgQFLzuI9oR5+KrNSsEKTbIXaPPVdP/DAs=;
        b=mrR1ZoLpkbfZHpWBrLQrYSW32yV0vxtuJMpZGBlPKdz69R7Zw6reH+SGQkjMgoCtW/
         nznOOCOkNKeEn56wBfI5+WWAMdzuZSyNBJtIoBEkuIRXF1CJ59OKz/xZygfJ+jwBbIcp
         OMceNaHGuefDcqZTU6etp5Om3cHtuL2HgpQP2XJNWpcF6LDBwfdeGjBVS+FVVGkc5U7l
         ZBa/fzZAv0vZtQ2hd9B5QqkeEC8nbbuwOTvQCC8Wstg8RiQ2QCUT+SlmFhlJX3vOW23+
         Vr+nN5/pU/+sM+RUTL0aAMqRvzgqen4GcmrYe5taXJIZ3Wc1mATIDAUDHHdq2XnlGnxX
         fwwg==
X-Forwarded-Encrypted: i=1; AHgh+RpYGs8uN/s2sbk9Ee1kPe5lqZMrRNymMZk8B9XJtGTjNlwK4okNEywAv2BSrM2gmcZiRwdGHHgm1zQ2NIdREqzt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JuKizF3o6KzZwFgpgjCWjjW+AxJMz93yJrSP/WxWEBQx0vwW
	Az6wx2FBuGCZdDy+V9tuG5IICFwkmYf+Gzeo5FCwSsQ29P+5wHlykIq9EbzmvUwvJLXj5vFI05R
	UwFEbFw/uww==
X-Received: from dycjv4.prod.google.com ([2002:a05:7301:fa84:b0:314:53e1:705f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a109:b0:3c0:9c1b:d0be
 with SMTP id adf61e73a8af0-3c3ad9ff336mr21017749637.73.1784658123631; Tue, 21
 Jul 2026 11:22:03 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:21:48 -0700
In-Reply-To: <20260721182150.94016-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721173347.9163-1-irogers@google.com> <20260721182150.94016-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721182150.94016-3-irogers@google.com>
Subject: [PATCH v4 2/4] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

Fix critical logic and boundary bugs in read_proc_maps_line() and caller.
Ensure any mid-line hex/dec/char parsing failure invokes io__drain_line()
safely, using a do-while loop to read and discard remaining characters
until a newline or EOF is reached. Use standard '//toolong' fallback
literal for over-length pathnames, emit timeout flags for truncated
entries securely via goto out;, and cast event buffer pointers to avoid
_FORTIFY_SOURCE array bounds aborts when zeroing trailers.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 203 ++++++++++++++++++++---------
 1 file changed, 138 insertions(+), 65 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b75f9dcf4dbf..60bdf2d918ea 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -291,6 +291,18 @@ static int perf_event__synthesize_fork(const struct perf_tool *tool,
 	return 0;
 }
 
+static void io__drain_line(struct io *io, int ch)
+{
+	if (ch == '\n')
+		return;
+	if (ch == -2 && io->data > io->buf && io->data[-1] == '\n')
+		return;
+
+	do {
+		ch = io__get_char(io);
+	} while (ch >= 0 && ch != '\n');
+}
+
 static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
 				u32 *prot, u32 *flags, __u64 *offset,
 				u32 *maj, u32 *min,
@@ -299,69 +311,127 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
 {
 	__u64 temp;
 	int ch;
-	char *start_pathname = pathname;
+	size_t written = 0;
+	bool overflowed = false;
 
-	if (io__get_hex(io, start) != '-')
+	ch = io__get_hex(io, start);
+	if (ch != '-') {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
-	if (io__get_hex(io, end) != ' ')
+	}
+	ch = io__get_hex(io, end);
+	if (ch != ' ') {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
+	}
 
 	/* map protection and flags bits */
 	*prot = 0;
 	ch = io__get_char(io);
 	if (ch == 'r')
 		*prot |= PROT_READ;
-	else if (ch != '-')
+	else if (ch != '-') {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
+	}
 	ch = io__get_char(io);
 	if (ch == 'w')
 		*prot |= PROT_WRITE;
-	else if (ch != '-')
+	else if (ch != '-') {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
+	}
 	ch = io__get_char(io);
 	if (ch == 'x')
 		*prot |= PROT_EXEC;
-	else if (ch != '-')
+	else if (ch != '-') {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
+	}
 	ch = io__get_char(io);
 	if (ch == 's')
 		*flags = MAP_SHARED;
 	else if (ch == 'p')
 		*flags = MAP_PRIVATE;
-	else
+	else {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
-	if (io__get_char(io) != ' ')
+	}
+	ch = io__get_char(io);
+	if (ch != ' ') {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
+	}
 
-	if (io__get_hex(io, offset) != ' ')
+	ch = io__get_hex(io, offset);
+	if (ch != ' ') {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
+	}
 
-	if (io__get_hex(io, &temp) != ':')
+	ch = io__get_hex(io, &temp);
+	if (ch != ':') {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
+	}
 	*maj = temp;
-	if (io__get_hex(io, &temp) != ' ')
+	ch = io__get_hex(io, &temp);
+	if (ch != ' ') {
+		if (!io->eof)
+			io__drain_line(io, ch);
 		return false;
+	}
 	*min = temp;
 
 	ch = io__get_dec(io, inode);
 	if (ch != ' ') {
-		*pathname = '\0';
-		return ch == '\n';
+		if (ch == '\n') {
+			pathname[0] = '\0';
+			return true;
+		}
+		if (!io->eof)
+			io__drain_line(io, ch);
+		return false;
 	}
+
 	do {
 		ch = io__get_char(io);
 	} while (ch == ' ');
+
 	while (true) {
-		if (ch < 0)
-			return false;
-		if (ch == '\0' || ch == '\n' ||
-		    (pathname + 1 - start_pathname) >= pathname_size) {
-			*pathname = '\0';
-			return true;
+		if (ch < 0) {
+			if (overflowed) {
+				strlcpy(pathname, "//toolong", pathname_size);
+				return true;
+			}
+			pathname[written] = '\0';
+			return written > 0;
 		}
-		*pathname++ = ch;
+		if (ch == '\0' || ch == '\n')
+			break;
+
+		if (written < (size_t)pathname_size - 1)
+			pathname[written++] = (char)ch;
+		else
+			overflowed = true;
 		ch = io__get_char(io);
 	}
+
+	if (overflowed)
+		strlcpy(pathname, "//toolong", pathname_size);
+	else
+		pathname[written] = '\0';
+
+	return true;
 }
 
 static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
@@ -463,45 +533,53 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
 	while (!io.eof) {
 		static const char anonstr[] = "//anon";
 		size_t size, aligned_size;
-
-		/* ensure null termination since stack will be reused. */
-		event->mmap2.filename[0] = '\0';
+		__u64 start, end, pgoff, ino;
+		u32 prot, flags, maj, min;
 
 		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
-		if (!read_proc_maps_line(&io,
-					&event->mmap2.start,
-					&event->mmap2.len,
-					&event->mmap2.prot,
-					&event->mmap2.flags,
-					&event->mmap2.pgoff,
-					&event->mmap2.maj,
-					&event->mmap2.min,
-					&event->mmap2.ino,
-					sizeof(event->mmap2.filename),
-					event->mmap2.filename))
+		/* Read directly into event->mmap2.filename! */
+		if (!read_proc_maps_line(&io, &start, &end,
+					 &prot, &flags, &pgoff,
+					 &maj, &min, &ino,
+					 sizeof(event->mmap2.filename),
+					 event->mmap2.filename)) {
+			if (io.eof)
+				break;
 			continue;
+		}
 
-		if ((rdclock() - t) > timeout) {
-			pr_warning("Reading %s/proc/%d/task/%d/maps time out. "
-				   "You may want to increase "
-				   "the time limit by --proc-map-timeout\n",
-				   machine->root_dir, pid, pid);
-			truncation = true;
-			goto out;
+		if (!strcmp(event->mmap2.filename, ""))
+			strcpy(event->mmap2.filename, anonstr);
+
+		if (hugetlbfs_mnt_len &&
+		    !strncmp(event->mmap2.filename, hugetlbfs_mnt, hugetlbfs_mnt_len)) {
+			strcpy(event->mmap2.filename, anonstr);
+			flags |= MAP_HUGETLB;
 		}
 
-		event->mmap2.ino_generation = 0;
+		size = strlen(event->mmap2.filename) + 1;
+		aligned_size = PERF_ALIGN(size, sizeof(u64));
+
+		event->mmap2.header.type = PERF_RECORD_MMAP2;
 
 		/*
-		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
+		 * Just like the kernel, see perf_misc_flags() in
+		 * kernel/events/core.c
 		 */
 		if (machine__is_host(machine))
 			event->header.misc = PERF_RECORD_MISC_USER;
 		else
 			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
 
-		if ((event->mmap2.prot & PROT_EXEC) == 0) {
-			if (!mmap_data || (event->mmap2.prot & PROT_READ) == 0)
+		if ((rdclock() - t) > timeout) {
+			pr_warning("Reading %s/proc/%d/task/%d/maps time out. You may want to increase the time limit by --proc-map-timeout\n",
+				   machine->root_dir, pid, pid);
+			truncation = true;
+			goto out;
+		}
+
+		if ((prot & PROT_EXEC) == 0) {
+			if (!mmap_data || (prot & PROT_READ) == 0)
 				continue;
 
 			event->header.misc |= PERF_RECORD_MISC_MMAP_DATA;
@@ -511,26 +589,26 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
 		if (truncation)
 			event->header.misc |= PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT;
 
-		if (!strcmp(event->mmap2.filename, ""))
-			strcpy(event->mmap2.filename, anonstr);
+		event->mmap2.header.size =
+			offsetof(struct perf_record_mmap2, filename) +
+			aligned_size;
 
-		if (hugetlbfs_mnt_len &&
-		    !strncmp(event->mmap2.filename, hugetlbfs_mnt,
-			     hugetlbfs_mnt_len)) {
-			strcpy(event->mmap2.filename, anonstr);
-			event->mmap2.flags |= MAP_HUGETLB;
-		}
+		/* Zero the padding and ID header trailer safely! */
+		memset((char *)event + offsetof(struct perf_record_mmap2, filename) + size, 0,
+		       (aligned_size - size) + machine->id_hdr_size);
 
-		size = strlen(event->mmap2.filename) + 1;
-		aligned_size = PERF_ALIGN(size, sizeof(u64));
-		event->mmap2.len -= event->mmap.start;
-		event->mmap2.header.size = (sizeof(event->mmap2) -
-					(sizeof(event->mmap2.filename) - aligned_size));
-		memset(event->mmap2.filename + size, 0, machine->id_hdr_size +
-			(aligned_size - size));
 		event->mmap2.header.size += machine->id_hdr_size;
+		event->mmap2.start = start;
+		event->mmap2.len = end - start;
+		event->mmap2.pgoff = pgoff;
+		event->mmap2.maj = maj;
+		event->mmap2.min = min;
+		event->mmap2.ino = ino;
+		event->mmap2.ino_generation = 0;
 		event->mmap2.pid = tgid;
 		event->mmap2.tid = pid;
+		event->mmap2.prot = prot;
+		event->mmap2.flags = flags;
 
 		if (!symbol_conf.no_buildid_mmap2)
 			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
@@ -703,11 +781,6 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 
 		memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
 
-		/* Clear stale build ID from previous module iteration */
-		event->mmap2.header.misc &= ~PERF_RECORD_MISC_MMAP_BUILD_ID;
-		memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
-		event->mmap2.build_id_size = 0;
-
 		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
 	} else {
 		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
-- 
2.55.0.229.g6434b31f56-goog

