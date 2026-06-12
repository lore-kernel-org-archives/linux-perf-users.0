Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9039A806;
	Fri, 12 Jun 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303068; cv=none; b=sJ2n6n93hBCL4ZqMS1zlaau3ZaCnfrGg0+KQKGCPKrPf1XD/WG8PBhfZKuoOyHI63FlG6PLM0C85gU5gBqT948bL6xMvlEOsLLOsQcBKEAAdUPrR72NJU9uwESpZSazm1wnTeAnWgyigKHTCjWiwWzyhZYKu3PlmdMYGgEHZ3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303068; c=relaxed/simple;
	bh=LPfqgijeLC1IhUy/+y6OUmNFlDsUd0sJjAwzsLer54s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aASpXQs6tRrABnAhJ8jr4nnG8s8iDZ2yVkr9sno1qU743tib7gUTWUTMGdxIPmpY1AqgJHV6+IMRl/nqxMIEO3/mhQsnGfLleaNeOYT5xy6eTOwVYOLNvGgFm/r4PZxfDLc3UVM/p3WFnIKGC8My4+SZPBksyMat9L7zyxrIHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCQ6DYeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCQ6DYeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F701F000E9;
	Fri, 12 Jun 2026 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303067;
	bh=3yySncgWe3MwM9qPjrXV0BV1fEsK543HDSbXQn4f+3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCQ6DYeRyE5m9oB76p7vRmkd7Na9oFfFM/yuMVeyiBmT2gK0XpiFcVjQX5lYFcmOV
	 JitGojRuWiYS0d8eiQyXNGOPmbrYVQmwPAk5sqhX5lTdbU/Td8Ut1LsVaCShkN60On
	 pBfklCGwJIAPbxNmwl8e3YALgHBq02Taq8T1lmguDXwSq0CQUvlwbOAaFATCl/IOAn
	 a4Eka8PVpvrt4hCc24Q8PvKiw2JyFvRowAro4FoylvxZBCNqiXQWNIdOQ2dht6s6zK
	 luSLvLOuE+j04zj0Ugzr/WqJsPAidIO9Xv/ThLSwvy2nsMjcqpvUkePGVuArMMXv3D
	 ozFEvhIbKsqBg==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 02/13] perf symbols: Validate p_filesz before use in filename__read_build_id()
Date: Fri, 12 Jun 2026 19:24:01 -0300
Message-ID: <20260612222413.40791-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612222413.40791-1-acme@kernel.org>
References: <20260612222413.40791-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

filename__read_build_id() stores ELF p_filesz in a ssize_t variable.
A crafted 32-bit ELF with p_filesz = 0xFFFFFFFF produces ssize_t value
-1.  The comparison `p_filesz > buf_size` evaluates false because signed
-1 is less than any non-negative buf_size, so the realloc is skipped and
buf remains NULL.

The subsequent read(fd, NULL, -1) returns -1, which equals p_filesz,
passing the error check.  read_build_id() then dereferences the NULL
buffer.

Add an explicit check for p_filesz <= 0 before using the value,
catching both zero-length and sign-wrapped negative sizes from crafted
ELF files.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: ba0b7081f7a521d7 ("perf symbol-minimal: Fix ehdr reading in filename__read_build_id")
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-minimal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index f4b0a711a62cf3de..0a71d146395271a6 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -186,6 +186,9 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			continue;
 
 		p_filesz = elf32 ? hdrs.phdr32[i].p_filesz : hdrs.phdr64[i].p_filesz;
+		/* ssize_t can go negative with crafted ELF p_filesz values */
+		if (p_filesz <= 0)
+			continue;
 		if (p_filesz > buf_size) {
 			void *tmp;
 
-- 
2.54.0

