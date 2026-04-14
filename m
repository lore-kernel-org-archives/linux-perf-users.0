Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA92472A2;
	Tue, 14 Apr 2026 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199741; cv=none; b=uFtFdt1bJ1JRzimk2Ta7CEzXlEZ1A0Fg7DkoeB651870ofF+v4+GxWVEBKnwqedpuAaxI0Z+FuIEC2rrM206eIfyYTHFxDasnaB1vhJIPbKzIbjx/RFQOWraqiZPmPVvJU9UZykIbsPPk0XhVW8c8vv38UgfM7ROJveZYsE2mos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199741; c=relaxed/simple;
	bh=CIgnSUhZM+Rbymb25i8EGATOe7/4cgcm168q46PN6Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TT6Q9O7ZT19rpIFp6ejR6SVmIh09aQ5WyZwYqS2MWTT23BZFc6nO9F51+eHo/BTdrW+UeONvRBCkwGXScheYoZXToZKSMtjUY8nfoEkVFQ6R+OQ7rj5nVy9jMO9IPS+T2NJgZ6QeZAbLHyCebiRDmeejzUR/EtCJHwQNCxEMdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgQwuaLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgQwuaLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47560C19425;
	Tue, 14 Apr 2026 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776199740;
	bh=CIgnSUhZM+Rbymb25i8EGATOe7/4cgcm168q46PN6Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgQwuaLP7V1wOrxvS2JTLI26NuPEIxnlcSDYZvp7j+MkU6OyUSY9e1IDxb6VCMIgu
	 FytBWA7g0xXw3D1cfNlhw/JawrvQ+9QyyLj0/QNjlX8K3CeOF4Wfa/zql1Jd35hc9B
	 eIUO5CzCym1MM8BBVR+1LkYM8U5meSU1ESRNRyjbzEgkatZgFA8XwVNQpJCTUFN0v0
	 hAz/TTeK3MFBN1fXgQQ9TMlwrRyoIiyCji6xe80CMyKdfzJArrg0mSI09TzIkuD0aF
	 FdP4gRulM29kcRHVeDZFRnMSaCxHSFbkLnk5YnEyIQJoYMzMjUgnzyZFSujepOK8jd
	 KPUYy/tq0rPNw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/4] perf header: Add section bounds checking to the fd read path
Date: Tue, 14 Apr 2026 17:48:44 -0300
Message-ID: <20260414204847.293557-2-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414204847.293557-1-acme@kernel.org>
References: <20260414204847.293557-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

__do_read_buf() validates reads against ff->size (section size), but
__do_read_fd() had no such check, so a malformed perf.data with an
understated section size could cause reads past the end of the current
section into the next section's data.

Add the bounds check in __do_read(), the common caller of both helpers,
so it is enforced uniformly for both the fd and buf paths.

This requires two supporting changes:

- perf_file_section__process(): initialize ff->offset to 0 so it
  tracks bytes consumed from the section start (consistent with the
  buf path), rather than the absolute file position.

- process_build_id(): use lseek(ff->fd, 0, SEEK_CUR) to discover
  the current file position instead of reading ff->offset.

Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f30e48eb3fc32da2..13bbf8df15f66cab 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -213,23 +213,23 @@ static int __do_read_fd(struct feat_fd *ff, void *addr, ssize_t size)
 
 	if (ret != size)
 		return ret < 0 ? (int)ret : -1;
+	ff->offset += size;
 	return 0;
 }
 
 static int __do_read_buf(struct feat_fd *ff, void *addr, ssize_t size)
 {
-	if (size > (ssize_t)ff->size - ff->offset)
-		return -1;
-
 	memcpy(addr, ff->buf + ff->offset, size);
 	ff->offset += size;
 
 	return 0;
-
 }
 
 static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
 {
+	if (size > (ssize_t)ff->size - ff->offset)
+		return -1;
+
 	if (!ff->buf)
 		return __do_read_fd(ff, addr, size);
 	return __do_read_buf(ff, addr, size);
@@ -2713,7 +2713,12 @@ static int process_tracing_data(struct feat_fd *ff __maybe_unused, void *data __
 
 static int process_build_id(struct feat_fd *ff, void *data __maybe_unused)
 {
-	if (perf_header__read_build_ids(ff->ph, ff->fd, ff->offset, ff->size))
+	off_t offset = lseek(ff->fd, 0, SEEK_CUR);
+
+	if (offset == (off_t)-1)
+		return -1;
+
+	if (perf_header__read_build_ids(ff->ph, ff->fd, offset, ff->size))
 		pr_debug("Failed to read buildids, continuing...\n");
 	return 0;
 }
@@ -4687,7 +4692,7 @@ static int perf_file_section__process(struct perf_file_section *section,
 		.fd	= fd,
 		.ph	= ph,
 		.size	= section->size,
-		.offset	= section->offset,
+		.offset	= 0,
 	};
 
 	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
-- 
2.53.0

