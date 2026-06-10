Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4903563EB;
	Wed, 10 Jun 2026 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121133; cv=none; b=cxUpQhFa73vvrjcHyJ90y9o+bsMezn4JllcAsel4wrmOym/tbAYMkXcS51FiPx50MMsIvVASYeZ4bSvjgKbA00OW8txKrgZAUGztgoDVRrX3zAnwlC7eNu8LHtJbFXRPz8Nw19PlzwBYAfAxGDq9LnikfT/byuAi7K6yBK36r4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121133; c=relaxed/simple;
	bh=O0Dtxbmqmg5SsLxZvRn1WAM0OeWLF7pKO/xCCRzOqd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXyVUJBN0ZJfR/InCe8BQDzdtWdTdc4+SzS9AKFxtY8xN2w/3hR072qXl5MtHnBTUDe7anlegLTR2/xcW/lPWYzDxEHuK28lh4UtSVWbweoy4y0IbdgtJSx5Zouwg30BB/b9iM5RlUTDR/yNbdh3wKVWf7APln+qcocnuIsOEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aar3ct34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aar3ct34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D578A1F00898;
	Wed, 10 Jun 2026 19:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121131;
	bh=eENy2ZlFCVyv+8IP8P4annXXIisHYDKYYMIoq6fi9Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aar3ct340RqJsqS8kJC9snqd9VMz71y7pOOVY6fFNBEBFVTyUBnyhELNUCmN3fsX6
	 qKgHvHLe6aOj92tRzXWYcTiAULfzr5V5IcMwKSWDkjxjIxIA9O5jHMk4o72xsqbuGB
	 UXXEE62B+6e1YO3EZjHqOMziSdemCYjeM7o515qfYDmrv4zGW8WKana/LxgK6PYYdt
	 EthRmC8cZ6W4KmOUiknQH+77+qUCgqyeS4oXtD5IAvaAQD5lQ3B7Gj+qagGxp71Z94
	 oXtYB0EyByuPXDbpdWvj6s8mkl4/A9qVUSO/SnRuvrNOO+ngmnTfGkbtjSk0gc8GXE
	 yXnM51hWCmMBw==
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
	John Garry <john.g.garry@oracle.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 01/23] perf pmu: Fix pmu_id() heap underwrite on empty identifier file
Date: Wed, 10 Jun 2026 16:51:34 -0300
Message-ID: <20260610195157.2091137-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

pmu_id() calls filename__read_str() then strips the trailing newline
via str[len - 1] = 0.  If the PMU identifier file is empty,
filename__read_str() succeeds with len = 0.  len - 1 underflows
size_t to SIZE_MAX, writing a null byte before the heap allocation.

Add a len == 0 check before the newline stripping.

Fixes: 51d548471510843e ("perf pmu: Add pmu_id()")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9994709ef12be9ee..50f54674430e6206 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -865,6 +865,12 @@ static char *pmu_id(const char *name)
 	if (filename__read_str(path, &str, &len) < 0)
 		return NULL;
 
+	/* empty identifier file — nothing useful */
+	if (len == 0) {
+		free(str);
+		return NULL;
+	}
+
 	str[len - 1] = 0; /* remove line feed */
 
 	return str;
-- 
2.54.0

