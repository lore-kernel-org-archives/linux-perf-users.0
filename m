Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA08F9E8;
	Fri, 10 Apr 2026 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781671; cv=none; b=mCEbzava0Ys2WtzX0gsYPwrJOYPS4LSUzq68sOpdSlQMgYbi0+068nL+DXmkjsfuIIprBtt06Tr/Nh9tuDqrRpcLWOOHXH5guzQqMJUQncwpE5jIQS/clRhB+6TEgGXa77c4txkyZHffV6BFZRtsncYnsX2fmWEF8afTio2HXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781671; c=relaxed/simple;
	bh=zbjev4o8ff7AtZRO8LAMGt/VrUTSo8XGaRWLhgsNGag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufhZ1vzK1ID6l5E5qkwEagL6BlWtkN8BDsRtn9degE9N8+V4qyL+rVQlyO7gAgaK2EWeKPjoM0dO+dcwQtOYM+cUzHMMjkLArHpWKd29+6KZdLq4ejDsUhSeeO038crhOx2Mqo+R1cXsEBZE5NofSfCy2A3520Xh/6pf0YPQg/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crvv7SHO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crvv7SHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296C5C4CEF7;
	Fri, 10 Apr 2026 00:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781670;
	bh=zbjev4o8ff7AtZRO8LAMGt/VrUTSo8XGaRWLhgsNGag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crvv7SHO0KpTrAs7U9epXQczzegxxHD9wY8K7ELvJVPG6R6Cl1pSgfRvKy6aCvXlf
	 IRXoaNsaEfuTCzUyYX1RgEZR6X23/oUTX6+0pAAF7bjaSo7dAr7Xs6ad7X6U/JHmw8
	 uIEpeOC9uYasUyJEr4U9CqCvML+NTntR1tdbQBVdWQ2xo1m2B2D5z9rjGFi4VigzDZ
	 t5dBXvNbX0Ex18dlxtvJFjgWFgdbz86hWr/TpjArCprheA18vrgcNPdBfpauRCC1vN
	 Z5fw9cuFlph/xJZf/U/OXJh6v4i7SL5gLc0DdDokc6bANivIklR3g84WcajDcOTlm6
	 Wg73jaQ0t4QTQ==
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
Subject: [PATCH 09/13] perf header: Sanity check HEADER_CACHE
Date: Thu,  9 Apr 2026 21:39:56 -0300
Message-ID: <20260410004000.148138-10-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410004000.148138-1-acme@kernel.org>
References: <20260410004000.148138-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add upper bound check on cache entry count in process_cache() to harden
against malformed perf.data files (max 32768).

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 8e3f4655fbacc6dd..494206faeb250956 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3241,6 +3241,19 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &cnt))
 		return -1;
 
+#define MAX_CACHE_ENTRIES 32768
+	if (cnt > MAX_CACHE_ENTRIES) {
+		pr_err("Invalid HEADER_CACHE: cnt (%u) > %u\n",
+		       cnt, MAX_CACHE_ENTRIES);
+		return -1;
+	}
+
+	if (ff->size < 2 * sizeof(u32) + cnt * 7 * sizeof(u32)) {
+		pr_err("Invalid HEADER_CACHE: section too small (%zu) for %u entries\n",
+		       ff->size, cnt);
+		return -1;
+	}
+
 	caches = calloc(cnt, sizeof(*caches));
 	if (!caches)
 		return -1;
-- 
2.53.0

