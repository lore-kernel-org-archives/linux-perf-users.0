Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6F43B483
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587941; cv=none; b=KbSPRgebT2WECtOF7MK9O3RduFFEFaCzeZGiO/sd1hlFCxvNt8ywsEGLiOirDrTCu5ijuVb161cIJI/xBiLBy01e9O0WBN/O/MYJv/Li6omFp0ZpQPiU/EmLevjfNFibpRO95GBw8koo9UgndtC4Hv3/8ywHMOeZ+8bxhtpbMLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587941; c=relaxed/simple;
	bh=3wWG303Mi00lwKOloAJVM+64fgwc2/pnNdIhwKqSm6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=baxGxS3Jf0HCu2XmqfUlhE4u9vfhXIZRGiVirsHCyihSp+tduAjeZ6HW6OdGZpXMtpdJxjcLQmSNwInZ92Ttx4H3gk6EOCpoM2MqKujiHwtoB7OUSI++OPWFnPAM6lIaDkWhmjyoauM3pkCX1U0FuTlb+9upjXcRt+jTUqagXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWpdXQJi; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWpdXQJi"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3811279d51aso13886062a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 15:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784587939; x=1785192739; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKteTyvHt7cD2g0v/QB2yYzZKHYzZC0yeBK3kqeJla0=;
        b=eWpdXQJiXxyQ8uobgU9g7D/7l0SP/45AlE1sTC9G3MHkhuFEtZOp4tu0jRJzeBR74j
         4MtbJxazB4a2gC+/yD3OGpBjRKKK0x2+SOl1jiW8x1Vhp2GxwyZBz7tqvP2YRPcwg490
         64wB2Vc9w5P+uyiSJrFqOjz4kj42SaXtGqhofoTpTf8mnNliViHOKZlgYBO2SWf/oJL5
         +DPPra7jcl84ALpnZcbAm4Yllc1NHdFolMR0yiQBj2OMqJDdikhex95QjV6rRNNxcbdu
         vU1AtlLDgi0aBsv/Wfoh3vCxTrh259F/v6GhXYk2R+El6RCdUYMmXmvJNqjVcNziIa22
         w0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587939; x=1785192739;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKteTyvHt7cD2g0v/QB2yYzZKHYzZC0yeBK3kqeJla0=;
        b=Rz1ngKGD6tijMAF3D7n1RYaJCN5WNjL34ojt1/je+WFrC5ny2DCy8dIkbI1bs06RfN
         EkDvUkdUp9n2faeZQlPRfDI0xpv8zTGqHz8eN9SJbH8II6l3nLWtckst7jLranHvEB0s
         +4/8XraSa8o8U5Ej5xF005U50f0w9apGONp57WQK6fQW7E9mnMaboZRG2IdSrC+QQNag
         cf5MirCM8w2k+cv7VMyR7BhzvPFBNm3X2w/pH5GUbQmkYButYHBP8V6WB/9MO7dyYo+K
         TK1OnM7RUEiD6B5eTFK3B3xHGJR/Fg+E3nVIXQW3gpi0djM1erYa3L6rrx/j4pclwrj3
         LPaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWtuerD+fmLFJhgz4H6tzrPldAkyFAaDR5Y6bLxZi4AYdGfBJkyH3G/qdnGBI9CAbowxBwJct4BcDZpLYm+PiL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ue/mGm7lZwOCtV3DiIXN/AOujzQ2lGK8+ORJW+/YOpRI+P8J
	J8ePW2GPbth5tIby3gsBB9/LnIOz5wdA+RQ0EaUuy0a0UXQLIr2zs9uWy0UMb5M+wPKA+nXT03V
	p2dZuGdSENQ==
X-Received: from dlea18-n1.prod.google.com ([2002:a05:701b:4212:10b0:139:afc8:5acc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52ce:b0:38e:655c:6516
 with SMTP id 98e67ed59e1d1-38e655c657emr8275212a91.0.1784587938540; Mon, 20
 Jul 2026 15:52:18 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:51:58 -0700
In-Reply-To: <20260720225200.3810501-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720175455.3645946-1-irogers@google.com> <20260720225200.3810501-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720225200.3810501-3-irogers@google.com>
Subject: [PATCH v2 2/4] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, Ian Rogers <irogers@google.com>
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

