Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D044D01F
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570123; cv=none; b=iZVB003laSPrjFrF7jC5rcoUyi/tLyXXEwlLaH176P1cLyNpb9CbpvT8zfmPRiZX7ppYZ/imdnmErlZWRLMHmMfBMPSvOp/wB16T72Hhz7iUlWvoMBVI1+ifq2GI7yiQ2hcWAF+eVILMU8eBH2S8lxT697xHY4rHGQZfeNWulHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570123; c=relaxed/simple;
	bh=X+XhmvcrgDFYXJ4+suxESuvZXFjd8bAHThfTS/ZKb10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZpAivAFYCRs2TShRIu0Ef7TiZuiN6TARXnPMGgdBSLIzl3yYW8tdcNFZBfs6z3XERzBOPK1XmE64spFFLy2Q1ZGkmncIbIDne71TdtXAt8lW4oZcgmAW0u1W2Q81At1GYiolWvJnGT5aJtLOpE5Cb2foXvw8AmuTbZROAHuhoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=goITaWLU; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goITaWLU"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so15057116a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784570116; x=1785174916; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKLKfwC2YgZOXdRwd5ZaICmLJk5/Gnuhh5z8C+XB7lY=;
        b=goITaWLUawCD1BnRwlbH8dUvPFfBuIcTsopozpsh0wnIAJD5rhz2Yv43OePPO97DMb
         oztvW5ibMcwR34sdUzpi15PCjJ6XfQVcBanRPD3pkLtp4xLsrl3p1IkMvyeEEyLuLWUr
         LDal+qysKF92zgZPDhUEin/J3ovyNfshRkuarxG1l/IsDFqaynpLuOFGwLg7fZRi8dQi
         jMQpxChoediBScfZGsBO7hP7dp7OifE/yljwftxajtYBN9Wwgm79tX7TfYcAxblfwhDU
         6C38qmnnKDzbjGq9ggwdfCvw37XR5stWVejiQO7keVk74YhLF5N+UKN852TLsQK/owSN
         O/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570116; x=1785174916;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JKLKfwC2YgZOXdRwd5ZaICmLJk5/Gnuhh5z8C+XB7lY=;
        b=GYp5PnCVfLdvFaHdNqNnvL/uDEC+rbZMOYriZCWfrixH43fcx6pCJX6T3hB3Kf4ewN
         zu7xADDirppI3Ajz0ZKIh5RdlYyO/tkc/rFj03CM1u4pSe3dW4zJKraBpAtJuwM53rhT
         G2khS6yc4k/afiL+dtPm6gfK6A/0nJiQlKVuSpvX/LLBiucR/j8IU3M1Tsvj+vQ7oCRC
         Ilb8SnOZK+bOs2gt9iQpSaPi9CoyfWitTe3w6hO9stZFyzf82xLgO7MhRkWDc9doldDX
         U5llTM9fGdbZsOTJyuC/c1XuWe2ss+mY4HDBB3i0HW9YaDg2qSwVuPwa9LnhlTzD81dX
         uhMA==
X-Forwarded-Encrypted: i=1; AHgh+Rpz0SrVUtxRYr8jMbIwyE0Ped5J5rMUjCls2CUcXziGTsQXgaRJrzp45w+GHeOdSKC57XsWwyyQihCqb1BLUjum@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Oj2ci46UYOffelIDtapWb9RTyFgTqYsfoODXz/x/0pldkhTQ
	OWTmMH62cuhDUmWeFFNyARtzRqn/gDE6FpmiCLysw+LlPQev54qI08WHNlRrEliAaQXkrfF4zPS
	emeLpLGVprw==
X-Received: from dycqa12.prod.google.com ([2002:a05:7300:fe4c:b0:311:5b7d:f189])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a109:b0:3bf:7110:9949
 with SMTP id adf61e73a8af0-3c3ad5d6095mr16414285637.6.1784570115701; Mon, 20
 Jul 2026 10:55:15 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:54:53 -0700
In-Reply-To: <20260720175455.3645946-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720175455.3645946-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720175455.3645946-3-irogers@google.com>
Subject: [PATCH v1 2/4] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix critical logic and boundary bugs in read_proc_maps_line() and caller.
Ensure any mid-line hex/dec/char parsing failure invokes io__drain_line()
to preserve line synchronization for subsequent map entries. Replace the
truncation bug (which improperly cleared over-length pathnames to an empty
string) with the kernel's standard '//toolong' fallback literal, and clamp
and pad structure size boundaries safely.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 183 ++++++++++++++++++++---------
 1 file changed, 127 insertions(+), 56 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b75f9dcf4dbf..9161dc728e6e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -291,6 +291,15 @@ static int perf_event__synthesize_fork(const struct perf_tool *tool,
 	return 0;
 }
 
+static void io__drain_line(struct io *io)
+{
+	int ch;
+
+	do {
+		ch = io__get_char(io);
+	} while (ch >= 0 && ch != '\n');
+}
+
 static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
 				u32 *prot, u32 *flags, __u64 *offset,
 				u32 *maj, u32 *min,
@@ -299,69 +308,121 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
 {
 	__u64 temp;
 	int ch;
-	char *start_pathname = pathname;
+	size_t written = 0;
+	bool overflowed = false;
 
-	if (io__get_hex(io, start) != '-')
+	if (io__get_hex(io, start) != '-') {
+		if (!io->eof)
+			io__drain_line(io);
 		return false;
-	if (io__get_hex(io, end) != ' ')
+	}
+	if (io__get_hex(io, end) != ' ') {
+		if (!io->eof)
+			io__drain_line(io);
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
+			io__drain_line(io);
 		return false;
+	}
 	ch = io__get_char(io);
 	if (ch == 'w')
 		*prot |= PROT_WRITE;
-	else if (ch != '-')
+	else if (ch != '-') {
+		if (!io->eof)
+			io__drain_line(io);
 		return false;
+	}
 	ch = io__get_char(io);
 	if (ch == 'x')
 		*prot |= PROT_EXEC;
-	else if (ch != '-')
+	else if (ch != '-') {
+		if (!io->eof)
+			io__drain_line(io);
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
+			io__drain_line(io);
 		return false;
-	if (io__get_char(io) != ' ')
+	}
+	if (io__get_char(io) != ' ') {
+		if (!io->eof)
+			io__drain_line(io);
 		return false;
+	}
 
-	if (io__get_hex(io, offset) != ' ')
+	if (io__get_hex(io, offset) != ' ') {
+		if (!io->eof)
+			io__drain_line(io);
 		return false;
+	}
 
-	if (io__get_hex(io, &temp) != ':')
+	if (io__get_hex(io, &temp) != ':') {
+		if (!io->eof)
+			io__drain_line(io);
 		return false;
+	}
 	*maj = temp;
-	if (io__get_hex(io, &temp) != ' ')
+	if (io__get_hex(io, &temp) != ' ') {
+		if (!io->eof)
+			io__drain_line(io);
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
+			io__drain_line(io);
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
@@ -457,29 +518,25 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
 	}
 	io__init(&io, io.fd, bf, sizeof(bf));
 
-	event->header.type = PERF_RECORD_MMAP2;
 	t = rdclock();
 
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
 
 		if ((rdclock() - t) > timeout) {
 			pr_warning("Reading %s/proc/%d/task/%d/maps time out. "
@@ -487,50 +544,64 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
 				   "the time limit by --proc-map-timeout\n",
 				   machine->root_dir, pid, pid);
 			truncation = true;
-			goto out;
 		}
 
-		event->mmap2.ino_generation = 0;
+		if (!strcmp(event->mmap2.filename, ""))
+			strcpy(event->mmap2.filename, anonstr);
+
+		if (hugetlbfs_mnt_len &&
+		    !strncmp(event->mmap2.filename, hugetlbfs_mnt, hugetlbfs_mnt_len)) {
+			strcpy(event->mmap2.filename, anonstr);
+			flags |= MAP_HUGETLB;
+		}
+
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
+		if ((prot & PROT_EXEC) == 0) {
+			if (!mmap_data || (prot & PROT_READ) == 0) {
+				if (truncation)
+					break;
 				continue;
+			}
 
 			event->header.misc |= PERF_RECORD_MISC_MMAP_DATA;
 		}
 
-out:
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

