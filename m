Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD98376A00;
	Wed, 10 Jun 2026 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121157; cv=none; b=DjBJO4EHmo9P8vbozDXSs7tSc8Q7yljACjcTJzzJNtecG8f0BD0rfUlKgVkrKL9t8+dvjbhJqTGmbsbpedRav+hYQ7W+sYy8gpAy9azFdxvAFZjvPEwN926LuMHkLYklMI+tp/oUQnoFKaMfXVRlTQOPfG+fRFusVF0aRClxSE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121157; c=relaxed/simple;
	bh=mf+Hq9FwyrY80r93BYHFzMl7OKCW92+VAgTDFKjpiIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0trvC7Y3yo/chpFXevhmfEekt+jOJAP3zTYu9onP3bNK2mltKmEjZGMppWjxOFOjiXidNd9JY7dGfqFpo0SE+MSPkkF5LfaMlIlNN1/KtXEcZGc8bgQUB8vJrtGxozb7DWWlrJzlqFy5bR3NjbH4AGmrC6dL9B0I+NZBWTuz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7TAcfY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7TAcfY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31051F00893;
	Wed, 10 Jun 2026 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121156;
	bh=4bEXNYfpWgEaTWw3q4LhS+3jJ+lKIyrF2mVKlBE+bX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W7TAcfY5TTl3n3A7Ty5doqDmWWaaAR+f9LoY3QfFc8g6PPJbpKC2ogMY3+cuLuAFY
	 cjD2pzowoOND0sbzUK4oPct3sKb7f3yPD/Q/t+rsy7fB750JjqggRcX4yT5KCjc2oK
	 0rwcW73pYkjwhEOAjSqLvxCxlRt/GBb+RxSvjrePaIxbq4LYro6J5sajXLPvu3KHDJ
	 oJ8bbzoBpJocXYcz8ml8/wnK8OiBx+YDelVIDCe+wv5SMVmKVZKCEINkXz7PFLrcWj
	 CLE5VJLRH2Dl/BS3UsI4ktKIN1uzd5BTEXSvKMUsMdCRxfsaYuwKjwsT7qpqx320WI
	 dHB843zs81TAw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 06/23] perf tools: Use mkostemp() for O_CLOEXEC on temporary files
Date: Wed, 10 Jun 2026 16:51:39 -0300
Message-ID: <20260610195157.2091137-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

mkstemp() creates file descriptors without the close-on-exec flag.
These fds leak to child processes spawned during symbol resolution
(addr2line, objdump), wasting descriptors and potentially exposing
temporary file contents.

Replace mkstemp() with mkostemp(tmpbuf, O_CLOEXEC) at all three
call sites:

  - filename__decompress() in dso.c
  - read_gnu_debugdata() in symbol-elf.c
  - kcore__init() in symbol-elf.c

Fixes: 42b3fa670825983f ("perf tools: Introduce dso__decompress_kmodule_{fd,path}")
Fixes: b10f74308e130527 ("perf symbol: Support .gnu_debugdata for symbols")
Fixes: afba19d9dc8eba66 ("perf symbols: Workaround objdump difficulties with kcore")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c        | 2 +-
 tools/perf/util/symbol-elf.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index fb2e78fe2aa8eb94..ee06a252a54d338d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -346,7 +346,7 @@ int filename__decompress(const char *name, char *pathname,
 	if (!compressions[comp].is_compressed(name))
 		return open(name, O_RDONLY | O_CLOEXEC);
 
-	fd = mkstemp(tmpbuf);
+	fd = mkostemp(tmpbuf, O_CLOEXEC);
 	if (fd < 0) {
 		*err = errno;
 		return -1;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 51e7cfe0f5934875..36a0304707e13138 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1119,9 +1119,9 @@ static Elf *read_gnu_debugdata(struct dso *dso, Elf *elf, const char *name, int
 		return NULL;
 	}
 
-	temp_fd = mkstemp(temp_filename);
+	temp_fd = mkostemp(temp_filename, O_CLOEXEC);
 	if (temp_fd < 0) {
-		pr_debug("%s: mkstemp: %m\n", __func__);
+		pr_debug("%s: mkostemp: %m\n", __func__);
 		*dso__load_errno(dso) = -errno;
 		fclose(wrapped);
 		return NULL;
@@ -1993,7 +1993,7 @@ static int kcore__init(struct kcore *kcore, char *filename, int elfclass,
 	kcore->elfclass = elfclass;
 
 	if (temp)
-		kcore->fd = mkstemp(filename);
+		kcore->fd = mkostemp(filename, O_CLOEXEC);
 	else
 		kcore->fd = open(filename, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0400);
 	if (kcore->fd == -1)
-- 
2.54.0

