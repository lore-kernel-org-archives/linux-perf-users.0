Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A143597B;
	Thu, 16 Apr 2026 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298478; cv=none; b=PeDIspxXkzhkAvHiPgIoor/O64cWQNEoYx5rKSXICHg9sZBav6MRVm5JlcjVwlieZVLkLlnS/89MuR5xrQB2SOjKei7cnHkS9F8LDpPvFMqOCGg3c5tKNrgghlaO4lgcqi4czw7JdKiLN4Is2TeONK+IGHmTmqqUWAlx0n4pcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298478; c=relaxed/simple;
	bh=CIgnSUhZM+Rbymb25i8EGATOe7/4cgcm168q46PN6Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTzd5zDc4NoYIhclUE3cMSa9CywB1OfyxmBfSzyruQnrZEnsaPmsPGnEHzWO/vbejRz0Rx5AlUqtuvfg+hcV9/iK+LYhgccHZpul6/FekBFtQPrbv9BMBdxyWkRtbyYIogvxDUDcC85Q0I1ein9e7ec4vaZbecpnTiz3eJXNF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuMIzVeN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuMIzVeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E51C19424;
	Thu, 16 Apr 2026 00:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298477;
	bh=CIgnSUhZM+Rbymb25i8EGATOe7/4cgcm168q46PN6Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CuMIzVeNTE7RCppsfMLnJSGYXi9r3grijy1ELJK3cTLJiNrTTM/KIVIhPnOMYKEQ2
	 8apfG3UNAQEyseVJwjbKXpQtdxbs1WALorUYcmyGMOuwT0h3Wuo8KVbkP3fBdWzCeb
	 YnM5T4mwRECOlwBrIcDLos+UEtim/KiabLCkjzrCMfXGd6imP28e/IGHAPOlaBJkN6
	 ChqOy2BkSa027VRp+nKEW3eHAdpvZNh1tvXtrm6kDskvLYQTIGbLaNy3oFSCUiH9zd
	 DPXeSjXhntQq8bCg9RxcQxdFjZR70Wt9QhECS/1t+D98m2HB4BwS9pLCHRFXShdHvD
	 Oxr+ZfO2gOmfw==
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
Subject: [PATCH 1/5] perf header: Add section bounds checking to the fd read path
Date: Wed, 15 Apr 2026 21:14:20 -0300
Message-ID: <20260416001424.362797-2-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416001424.362797-1-acme@kernel.org>
References: <20260416001424.362797-1-acme@kernel.org>
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

