Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3546D569
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655247; cv=none; b=tpQeKxl1NJOQUZ81/2yTPOF8jndLqkkp91EUoi/yQCxUF+B6RUStzIYgK5vyaIUI1h+gYQAEnlkanliNiBopQLBs7IpxBYNoBlUMyR5wNW0MyofFzYDdWpf6bJWGg4Lx8bFvawnXYGCLj3C40ep8p/t/glPPTPH0uXBfysbcsUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655247; c=relaxed/simple;
	bh=3wWG303Mi00lwKOloAJVM+64fgwc2/pnNdIhwKqSm6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UiM5rMv3qasM4fNBXb4PzCy78WFJx96gXIBU6Ni6FiAEULY1e/OZhHN6ecFTnGsawO7PKX+J/I6jUMdQ9kRy0eEf8w+MLLhdIowMASBISQHHufuCN+RlkwwKo8WbIFCfQUxBV61L7rdtLsw8WMItTRze6jOTvvIryeVKUCoLKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGIUPG5T; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGIUPG5T"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so15000646a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784655245; x=1785260045; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKteTyvHt7cD2g0v/QB2yYzZKHYzZC0yeBK3kqeJla0=;
        b=JGIUPG5Tr5EnTE1ERHDU1h99j4tJCtW6VeqCjySyvOANEY+2mn4+odMUP8VAOeAzSU
         9c01fCimKFzqW00O+mp6ESbFWrlw6kTnesFvjciXKwjIuXXiopAGmzJ8dXGad1cMB6kM
         VV5dR/1T0aXu/DedHg2wiQccr+TdgAiY1cWWy+c11XrJbId7Imv8rMAcvJ0qOEWrjR/t
         tMLrrC80leTQ6qhf4mFGM+prbLY+xWEq9EE5ZlGMbi3VpMIKY9qZO930cTJIeZwkcn0H
         Fb7qRBMyUEwSrlwxekf3i5AsIxFQi3lk9/ouqR4p/q6Bof/4th8ANP5IoAg8XmDmGlcZ
         Bg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655245; x=1785260045;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKteTyvHt7cD2g0v/QB2yYzZKHYzZC0yeBK3kqeJla0=;
        b=OpWiO72jc2tnyCNVeNR0LuLZVg6AuX5uRxgoZtGCrao3a0EWqraZbGm8OnDkFmcF5a
         QUpOVhopCICl6L8SRGdP404DchD9mX33qk2oJJeI2wDIzzx+jFF0+aQ3I/G7I1yzoWk2
         qU2pR5KQshby21NQIrZKj5Q3VxyWdIMIivkkb4GM52y3BtmdXDVItWBFRCLnttt+Qh3V
         SwCQPcD4DKGPKi/OmXYA4Eqh3J1s0OH/W6k76EWr++nkogS8uV3OMUqRmU1bPdEBMUXL
         9lG3PqjCOEYmI3gSsQwNMWoOXQYcO74EegQ+v5hE29Q1O3ZVApi19dqKNWlC/NbKL6Fo
         k29w==
X-Forwarded-Encrypted: i=1; AHgh+RrlrY0k5hLAMhhQCRIFPPEfjWoxGNnS3BjCH3cSypOSSv9B5sKrg12Hs8cu2G3NW8NwPVr0cty5TUsZ8/xA+VSg@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPpZNum9okPu/877iN94ziM9A0DTuiEYYjod0lrHY8wTS87Y8
	llMCFKNBRjD6VL9pHicHnB+sgatnNxPK16HJnH/9fsoIl//MZ06DISlJq9CZmYTWJRtspU4X1ho
	EycCvDqKxkQ==
X-Received: from dlbuy7.prod.google.com ([2002:a05:7022:1e07:b0:13c:f3ec:de27])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d52:b0:38e:dc4:3f64
 with SMTP id 98e67ed59e1d1-38e4b5860f9mr20056726a91.38.1784655244846; Tue, 21
 Jul 2026 10:34:04 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:33:45 -0700
In-Reply-To: <20260721173347.9163-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720225200.3810501-1-irogers@google.com> <20260721173347.9163-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721173347.9163-3-irogers@google.com>
Subject: [PATCH v3 2/4] perf synthetic-events: Fix line synchronization,
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
safely, ignoring already-consumed newlines to preserve synchronization
for subsequent map entries. Use standard '//toolong' fallback literal
for over-length pathnames, and emit timeout flags for truncated entries
securely via goto out;.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 197 ++++++++++++++++++++---------
 1 file changed, 137 insertions(+), 60 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b75f9dcf4dbf..9a2b4d561e9e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -291,6 +291,17 @@ static int perf_event__synthesize_fork(const struct perf_tool *tool,
 	return 0;
 }
 
+static void io__drain_line(struct io *io, int ch)
+{
+	if (ch == '\n')
+		return;
+	if (ch == -2 && io->data > io->buf && io->data[-1] == '\n')
+		return;
+
+	while (ch >= 0 && ch != '\n')
+		ch = io__get_char(io);
+}
+
 static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
 				u32 *prot, u32 *flags, __u64 *offset,
 				u32 *maj, u32 *min,
@@ -299,69 +310,127 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
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
@@ -463,45 +532,53 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
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
@@ -511,26 +588,26 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
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
+		memset(event->mmap2.filename + size, 0,
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
-- 
2.55.0.229.g6434b31f56-goog

