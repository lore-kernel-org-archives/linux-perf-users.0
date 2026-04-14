Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13E25A2C9;
	Tue, 14 Apr 2026 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199749; cv=none; b=HC2D2ncYnUNMURpNefqDzRxnbaIFTqlQKK8v4YDdEumI50GbnVik2nCjSQYc8L1Re3y00sV1TYhpJFA6w9j6Ct7+W8DU3NAr4d1LVVY4iPsvlWgg1Uy8mxvxfFWwEKPJi6kdGnscJLHHpM4hah3GqFS58l7ZppJpz/FCEtbB8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199749; c=relaxed/simple;
	bh=bm3oJ/JS6e4E9s6WCF4O1PS1zkEWdUb9lIYo23abs3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taHqVWY2oskU0hHpPZkz9cO4PNrcjZ2EeIk4zfLP7o9BbXU/1WBgbHEQgUKUYk9Fm5WsWsO/2RVtrYJMP265RBL5APxYp9FIiqDrkXFBz/qDUiyEBidlhrIxt+Lnj1QF0VFnjgyoM9sL0uK+6Zla/sVc3Cxfa8inyAM3ZW8inIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2TegSh3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2TegSh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128D2C2BCB5;
	Tue, 14 Apr 2026 20:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776199749;
	bh=bm3oJ/JS6e4E9s6WCF4O1PS1zkEWdUb9lIYo23abs3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2TegSh3T5FYP7MImASUG/enWwZ7nA9Ix44dX/F64eZ2zf9BmR/pk1Ae3xGKirZ/C
	 kvRZqxkaT7Kkm3B0m9sEFwg3P2EM/s/f9hAk9ky6kwXFq2T6CW5LnMClR4Xr0vLIu1
	 q5+Gl5Dn0fUVqbUMtMPVi4r0LsOM1HBu83cAEcElk9oHHX5fLqob63n1+MAA/Hxbjw
	 E5nwnaJc5T4UIWllzwyUYsOXanS18KWixjaUI1jtvqSsOoT1WGGln0gAh3t7CgG8bq
	 Yb32wEmom44b7yJK+6Fff70KRDeEXpYnm6tYOxPx8JwDfiCVGxsZLhWeZwPL3TS5oE
	 brxAhE7ck0CJA==
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
Subject: [PATCH 3/4] perf header: Sanity check HEADER_EVENT_DESC
Date: Tue, 14 Apr 2026 17:48:46 -0300
Message-ID: <20260414204847.293557-4-acme@kernel.org>
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

read_event_desc() reads nre (event count), sz (attr size), and nr
(IDs per event) from the file and uses them to control allocations
and loops without validating them against the section size.

A crafted perf.data could trigger large allocations or many loop
iterations before __do_read() eventually rejects the reads.

Add bounds checks:
- Reject sz == 0 or sz exceeding the section size.
- Check that nre events fit in the remaining section, using the
  minimum per-event footprint of sz + sizeof(u32).
- Check that nr IDs fit in the remaining section before allocating.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c27ed90727ea6629..3302748bac786fdf 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2141,6 +2141,13 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 	if (do_read_u32(ff, &sz))
 		goto error;
 
+	/*
+	 * The minimum section footprint per event is sz bytes for the attr
+	 * plus a u32 for the id count, check that nre events fit.
+	 */
+	if (sz == 0 || sz > ff->size || nre > (ff->size - ff->offset) / (sz + sizeof(u32)))
+		goto error;
+
 	/* buffer to hold on file attr struct */
 	buf = malloc(sz);
 	if (!buf)
@@ -2186,6 +2193,9 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		if (!nr)
 			continue;
 
+		if (nr > (ff->size - ff->offset) / sizeof(*id))
+			goto error;
+
 		id = calloc(nr, sizeof(*id));
 		if (!id)
 			goto error;
-- 
2.53.0

