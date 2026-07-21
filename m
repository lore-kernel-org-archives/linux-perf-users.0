Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0784398EB
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667492; cv=none; b=dr1BtCnKE9GwMWcvJ5AWwhsSAXPe/c665Dzb+PpwlW0OnhKOzWFTRLLoVV+209kuT61j28+dbFdUdvJOoniV926WJUQ3nxuJe0WXOoSTFHYDsBWcvkokXxau/bvaOePjJ6MXvNDi8ie4XUsT1m7MlPnoviFtVr2IImqznD/i1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667492; c=relaxed/simple;
	bh=Xm9lamjbtZi2pEr5IsDWXnNpazKGY5HtgWKN1punmzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RGQVhSyW7CKW4dbmziULpS0QLhAZdY9d+YIGEC0yL6Lo84R2mffPgK7ybx24Letf5F2wCEtfvVVXEm0TM75rBVPb87nXni67IOcudIAdTBkMwhydAxjN74mUAHFFndCafcT0VKhlizf1fT16ijBPFlPF8Qg1sxfflycnTLG6M+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIR+6QKH; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIR+6QKH"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc8bde6318so209642215ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784667474; x=1785272274; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AOo4xGNKOmTSdj62MplGbtiyCINdwG7LKPF8fve2D7Q=;
        b=vIR+6QKH2h2gdQJarVKAVFm4VgbZ4xfkMBnv/86JPF5Y3by3vlxEFJz+Vbuva0Smnj
         U7TfWfMoNW/RMDunQKskjNfVPCQ5VUeRwJLfMoXCyvkH5CJYt8HOFhBKhjBMJp5qwi3B
         8r7sBM5Wv/Sc5BK/T/WlPesCxMKK+PSG3ybjrpjU2FKde7vjdaKF2EFAsmxcA0EA1Xwi
         sqRw7JlPFQjMaaqa0zx6Nf/1F49ztByabTl0nc1/+4iuYXpuzgs2C4iquuWRDP62EA1w
         6u19Q4Fi9Me9xw8tjJ98SsBl9atbzTakIC21xG/3NKYTCgo7PKEsb4us1kgl3smX2CDr
         M1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667474; x=1785272274;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOo4xGNKOmTSdj62MplGbtiyCINdwG7LKPF8fve2D7Q=;
        b=VrCHhQ0zJS9aMEgQ6K+EGaGFSAGxArXxLiGqcGpWRQj1BmRFGrrYEXlbnmTlFoNJUG
         YfkuEZVtzNia63SoPykMdq5OGYfSpyqKuAdvubw+/Abp4jEld1p4VxpB7T8/wo3xgGhF
         iD7ItabtV1ieZ8EROUZsqW70DHp5eRnoY+ne0+KP9wHTeUJbAknawPBQ1bSkF+PSBGE4
         UZcpSJeSQbjlWZNEoLS8fR46JpyUXEj6767NSu08W05Sf5VcePkpPF35Psi3A3u1VlGV
         iORjPhBq/EC2i8XP2WebTtCVsmEjObHMvv8QuKEnZk22VV8zKn3vX23e5EFnOezui4VQ
         ZGVw==
X-Forwarded-Encrypted: i=1; AHgh+Rqg7YSeHHTxEu8/qYg8nIkekmQpz0FMCVn4+y51ot+LPQhLH/dMJhOZMyRlHaIil+w/ovHGyI/hzX+Rf1GsxnJf@vger.kernel.org
X-Gm-Message-State: AOJu0YwEecx+wxpYiv+TlXcDjqvHl5avj9QjkIo8r0lFhmJMx5pdAHoF
	XbpIoRMnG6+ps34zMswy27ORz2EnRun6sAtklS9MMrTS37ekJj4tApYN1y9/vRvDdOh9JZcPvTT
	Z2jUy/NQmkA==
X-Received: from dyp8.prod.google.com ([2002:a05:693c:65c8:b0:30e:ee3a:f2f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78c:b0:2cb:3f5b:6663
 with SMTP id d9443c01a7336-2cf348bee75mr215267295ad.11.1784667473472; Tue, 21
 Jul 2026 13:57:53 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:57:44 -0700
In-Reply-To: <20260721205746.183206-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721182150.94016-1-irogers@google.com> <20260721205746.183206-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721205746.183206-3-irogers@google.com>
Subject: [PATCH v5 2/4] perf synthetic-events: Fix line synchronization,
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
until a newline or EOF is reached. Clamp pathname extraction size to
account for trailing sample ID headers, use standard '//toolong' fallback
literal for over-length pathnames, emit timeout flags for truncated entries
securely via goto out;, and cast event buffer pointers to avoid
_FORTIFY_SOURCE array bounds aborts across synthesis handlers.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 209 ++++++++++++++++++++---------
 1 file changed, 142 insertions(+), 67 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b75f9dcf4dbf..e73f2e526e83 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -179,7 +179,8 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t ti
 
 	size = strlen(event->comm.comm) + 1;
 	size = PERF_ALIGN(size, sizeof(u64));
-	memset(event->comm.comm + size, 0, machine->id_hdr_size);
+	memset((char *)event + offsetof(struct perf_record_comm, comm) + size,
+	       0, machine->id_hdr_size);
 	event->comm.header.size = (sizeof(event->comm) -
 				(sizeof(event->comm.comm) - size) +
 				machine->id_hdr_size);
@@ -291,6 +292,18 @@ static int perf_event__synthesize_fork(const struct perf_tool *tool,
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
@@ -299,69 +312,127 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
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
@@ -463,45 +534,53 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
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
+		/* Read directly into event->mmap2.filename, clamping for id_hdr_size! */
+		if (!read_proc_maps_line(&io, &start, &end,
+					 &prot, &flags, &pgoff,
+					 &maj, &min, &ino,
+					 sizeof(event->mmap2.filename) - machine->id_hdr_size,
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
@@ -511,26 +590,26 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
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
@@ -579,7 +658,8 @@ static int perf_event__synthesize_cgroup(const struct perf_tool *tool,
 
 	event->cgroup.id = handle.cgroup_id;
 	strncpy(event->cgroup.path, path + mount_len, path_len);
-	memset(event->cgroup.path + path_len, 0, machine->id_hdr_size);
+	memset((char *)event + offsetof(struct perf_record_cgroup, path) + path_len,
+	       0, machine->id_hdr_size);
 
 	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
 		pr_debug("process synth event failed\n");
@@ -703,11 +783,6 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 
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

