Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4C3EFD21;
	Wed,  5 Aug 2026 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965288; cv=none; b=gifuFoRwMSNE/rSNo8vKWp/9Zj7Xxd/5gsjAEL5qQ3NZzju7vq7bzWqeWb6aCmwynbGgr29+7OyZ4wuJz8aeSie9HBV/q6foPdnWz5uAsxYYJKk+oXW+qPJJnbtI2dk6nx37IB8JpbwioU0mal+W3KBr/6whZ46Wx+3KEOSilBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965288; c=relaxed/simple;
	bh=XsPXYUoTfryy3R2b7vz0UCgSVVqpijR0pZ48YPHUBAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7mdX8JvThKXvBQzd/iw2rGp/qPUBPiz1JVm7AuV5xhl5NuV9P83z3iE2DRqv79BauEz6fYSRyWQoBiIfo6iubh9PzGeDJ46xC/IWRSXqAQOg4+tnti503iQh90fOoYYY1AEBaPi8mClmeQ638zFNjQPouuRpT6t1tNvMt7+A6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD4rktBy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD4rktBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917CA1F000E9;
	Wed,  5 Aug 2026 21:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965287;
	bh=uG0bUCcCsV5Kuer6dfyDYUG1djfBK9KIj4YAd8oXHAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YD4rktBy2sNbWoJK5s0HIjSv0VmXUr7mGYt9Po6OqUWyyRqt+NszGRCclexnHb1oy
	 87PIMoAUNRYmgFWuNWS14gxSEWniTqZjLW0iJCfs2Aa+pdutA311QnZR5SFYq1wbQM
	 fTX6TXpS+7nXMbMMR353FoFCppW+HjOsAdRvYzNbGKt6Jzpm6acoMAojEMnFMrkB0P
	 /tZRJbwNyHylREWEmAc1//4GZQLmdIOSqr6HWYuO5oT1C9esWnZ+lMNmpf8s+ZEcof
	 P5nk/8EeYH5C9or6CBoiSOev8vxPczQNnaT//8aCCApei0yK4wqjR3sMGMW8BhnNB9
	 E8mEj3J5okHyA==
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
Subject: [PATCH 10/12] perf jitdump: Validate debug entries on native (non-swap) path
Date: Wed,  5 Aug 2026 18:27:00 -0300
Message-ID: <20260805212704.267779-11-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805212704.267779-1-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The bounds-checking and nr_entry clamping added for the byte-swap path
only runs when jd->needs_bswap is true.  On native-endian files, nr_entry
passes through unvalidated to jit_repipe_debug_info(), which stores it
as jd->nr_debug_entries.  Downstream, jit_process_debug_info() in
genelf_debug.c iterates nr_debug_entries times via debug_entry_next(),
which calls strlen() on each entry's name field — a crafted nr_entry
causes OOB reads and writes.

Add bounds-checked iteration in jit_repipe_debug_info() that validates
each debug_entry fits in the payload and its name is NUL-terminated
before calling debug_entry_next().  Clamp nr_debug_entries to the count
of valid entries.

Fixes: 598b7c6919c7bbcc ("perf jit: add source line info support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index d3de307532d55065..5a3ea2681fb37105 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -694,8 +694,10 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 
 static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 {
-	void *data;
-	size_t sz;
+	struct debug_entry *ent;
+	void *data, *end;
+	size_t sz, valid;
+	uint64_t i;
 
 	if (!(jd && jr))
 		return -1;
@@ -715,10 +717,25 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	jd->debug_data       = data;
 
 	/*
-	 * we must use nr_entry instead of size here because
-	 * we cannot distinguish actual entry from padding otherwise
+	 * Clamp nr_debug_entries to entries that actually fit in the
+	 * payload.  The byte-swap path already does this for cross-endian
+	 * files; validate on the native path too, since downstream
+	 * jit_process_debug_info() iterates via debug_entry_next() which
+	 * calls strlen() on each entry's name field.
 	 */
-	jd->nr_debug_entries = jr->info.nr_entry;
+	end = data + sz;
+	ent = data;
+	valid = 0;
+	for (i = 0; i < jr->info.nr_entry; i++) {
+		if ((void *)ent + sizeof(*ent) > end)
+			break;
+		/* name must be NUL-terminated within the payload */
+		if (!memchr(ent->name, '\0', (char *)end - ent->name))
+			break;
+		ent = debug_entry_next(ent);
+		valid++;
+	}
+	jd->nr_debug_entries = valid;
 
 	return 0;
 }
-- 
2.55.0

