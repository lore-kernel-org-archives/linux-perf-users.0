Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64D3B38AE;
	Mon, 31 Aug 2026 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181929; cv=none; b=NR214SSjMTFFKbT7Bq4DoAR9iyyCK5o2wIj1NnFvBgD5z332/gKZWzwKMfiv26erUpZayYmw4+CYdd8lDJReRBL7wPFMzaaHriP96WamAkB5hTF/VfAa9fc4uKfLqB2+gt4gdntMqRh5/9Bf1hPwnZSmIYtSfWqNzhJ91y4S99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181929; c=relaxed/simple;
	bh=RIXWK5Xpq0hJvX+WdUlbqftFt9dH/fDLM1WdS9XQQwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dY7hAb/FJZkc0yWxn1GqOQohcPeRbe8WbxFBFBS5OaNxxUtemYQ19EYvNzG4+/WW8S5l71eAPtqlQB3j4HWyMzCQp+N8DC+DcDHovcrLDcAlwem35IO9TyLdWVCBTTunOkpV8ok8V8WTrXuBoIMMZ8OmwlLjmYXOdw5uanHfg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTJVfQcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTJVfQcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F941F000E9;
	Mon, 31 Aug 2026 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181928;
	bh=juj34A/JJwl6fZUb9XHua0ZaT+7EiiUokYzKnpwu/Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTJVfQcKdauO8dnbl9cBsB1/cNAL9eCRYtsQUejZGj4ssYr+o8jzhjZXgZ04C3n5S
	 pY667X38TapWKlBXe9WXJf1cHr889XWIQpu2g7SrLxytB005vGZuI2ytNLceDRwiaJ
	 mrL9Wvb7evUpiWJDGlxRNPQrJQ1QfVOoN8vUFQin8heqndrQH/pgsUGi+KUY1P6pls
	 gAAdcfy6t6ywi+dQ4JbXgsyC5pCXnDqSnKJewnvvLJX6AWTBVBdoSd/UzroxMs5lh0
	 qEPOnhFzTgulN3SPzSchwy+r+aHUuiCCJJCiO2rlWoxGEULQbigofHRPG8Hkn7+GSg
	 9z8VoiZzNFCxQ==
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
Date: Mon, 31 Aug 2026 10:11:06 -0300
Message-ID: <20260831131110.4681-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831131110.4681-1-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
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

