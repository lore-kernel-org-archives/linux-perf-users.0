Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D7471D1B;
	Wed,  5 Aug 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936717; cv=none; b=mpzNxuAUYxFDwIWLXvGY8JRekBmIn57JGZEO3bSTC2BkgdLin4CkIFd7SLo1yqMHnKGTC7MTtMHXC7g+CB83qX5pKmFgSa1HJA5NeVwB9Ba1lSS5U9j0OULJ9xrokNxQYkjusmM1eYpsxKjq+DpcaMzmxbkF6F3epYUQ6afg3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936717; c=relaxed/simple;
	bh=bta2pOcbWdz9aAjl0CLXJRXhtW4lkAh8toFj4jLc0wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXSXkplYRvMd6KBaUxqukRqPgf4KY9v1bjO8tHgY32oIkUPL50awyZSj2AV8AIxlHiEGXtZDHBY1g+wBmRVTS7QeqX7KqtMmkf6lXynVUINh0PGh4DITYGc6RvmtFy4Sii85CgA3znX/Ro/H275ycd0bWfiHTXdnsyJy5KYT36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4eXu8Nw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4eXu8Nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9D91F000E9;
	Wed,  5 Aug 2026 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936715;
	bh=gVACmEeIsofelsaO+fkSZT0+60oC4q8ndjcwBqEGF8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4eXu8NwX5e0wxNOQ2A0uw3QZ8sSu3sxnk0DcIwaRWrIwv3pu32oy06XMRKoN119l
	 3TeUgI2iXXS2PE0G7C9aemLMrAGNeOyWXeEhUhZsQ5BtEA4a0DdGBdng11qp2B8plj
	 9dcP4HwkPoZgB96yZJfN6JXLQQB8qx3XQK+72lDTGY1oYp1WZes/ZbeOStzBsaukbo
	 lMTy5hxV5BZr+Pg7fm7y9rOjfhE+8r1Uyl2PIEcdtptSt5TAEB3vrRnuQ//V4LlzOa
	 Ecy8MkPUdchkel50OnzPSCXrP85ddSBBWTrWoZqMndpuDaPYvzCK6GpEaRi4EPYzUg
	 WWEatasF9aFiw==
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
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 08/12] perf jitdump: Fix debug_data and unwinding_data leaks
Date: Wed,  5 Aug 2026 10:30:07 -0300
Message-ID: <20260805133013.235016-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805133013.235016-1-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_debug_info() overwrites jd->debug_data without freeing the
previous allocation.  If two consecutive JIT_CODE_DEBUG_INFO records
appear without an intervening LOAD record consuming the data, the first
allocation leaks.

The sibling jit_repipe_unwinding_info() already frees the old
jd->unwinding_data before reassignment — add the same pattern to
jit_repipe_debug_info() using zfree().

Also add cleanup of both buffers in jit_close() so they are freed when
the jitdump session ends, even if no LOAD record consumed them.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 4f52b143cd0da296..3085091b95a517ae 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -118,6 +118,8 @@ jit_close(struct jit_buf_desc *jd)
 	funlockfile(jd->in);
 	fclose(jd->in);
 	jd->in = NULL;
+	zfree(&jd->debug_data);
+	zfree(&jd->unwinding_data);
 }
 
 static int
@@ -706,6 +708,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	memcpy(data, &jr->info.entries, sz);
 
+	zfree(&jd->debug_data);
 	jd->debug_data       = data;
 
 	/*
-- 
2.55.0

