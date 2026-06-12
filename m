Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D4D3D3CF7;
	Fri, 12 Jun 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303080; cv=none; b=L9s7VF/fHXqPrNNTRxyNutQ6wwBAwprcdYe1T1MhUizgI4o8TmXY1NFyYhy5Yc6sMXYDlOif+QkpZuWCq6+Z04hI3xYFLE8M5ZImJDmghmb5zXzzIIT43w1naEcImjboL34Qgr/LiRJXTpPgMO8vov1NbClW+efZH6hVRA6x3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303080; c=relaxed/simple;
	bh=RsvTEtZFimuiOFNKX5fKD3iZu3LRkThGQChVHy9/aAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csn20IObPS6qZNyH0M/uc/d9qxJhHjr9ymyJD50wJ5C6g/Z8vDuklAwcBsBsk5x+o89CMm6ZHYwNkUbDofvuFwaxO10uG9xAUDgF30nwALkuFwulxTaxEn0BLqu1nGIcb8OxuWwLMcV7DZQ42sTDkJLZBV2LUP6FYbcGXNxvZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l024P7jm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l024P7jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F4D1F00A3A;
	Fri, 12 Jun 2026 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303079;
	bh=Lzxwb2mVIhdmIzPqJINp8NNNztvFaeNcw3B6tnJg3AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l024P7jmIGUP18NCf6zEjrBSDEJQQJHygNdO459Q8WP6Xibo6o6LjZmG7RgChu8P4
	 XagzyDb/G/lI8mQqb1i4LminKSHU0ZFXqrBVM6V2hKNVowoNxAwSjO1ynGkIEJ055Y
	 MuIpP5SjTYRpwhI2UmsY7yMq2WpmNLx/0IG/RtaSWPkSfDuTmzysKvQ5jYE5jl5pHD
	 2gzP3Sx8NMxpVHYV1nij2F/wwg3X4knV6ukfFAN3z9WumOow1TTOZGHCNEX4Ogc32V
	 6DKm9fyGBtXdS7g/Tk5mRugy6Rb/9rcC4U7j66+LSKspm4AGJs12tVhPfkk97G7Bs4
	 tv1mRLnzh+Q0Q==
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
Subject: [PATCH 05/13] perf dso: Set error code when open() fails on uncompressed fallback path
Date: Fri, 12 Jun 2026 19:24:04 -0300
Message-ID: <20260612222413.40791-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612222413.40791-1-acme@kernel.org>
References: <20260612222413.40791-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

filename__decompress() has an early return for files that are not
actually compressed, where it calls open() directly.  When open()
fails, the function returns -1 but never sets *err.  The caller chain
(decompress_kmodule → dso__decompress_kmodule_path → dso__get_filename)
then reads *dso__load_errno(dso) to set errno, but that field was never
populated, so errno gets a stale or zero value.

With errno=0, __open_dso() computes fd = -errno = 0, which is non-
negative, so callers treat fd 0 (stdin) as a valid DSO file descriptor.

Set *err = errno when open() fails on the uncompressed path, matching
the error handling on the compressed path at line 354.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 8b42b7e5e8b5692b ("perf tools: Add is_compressed callback to compressions array")
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 511921bd901d8145..1a2fc6d18da74d6c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -344,9 +344,12 @@ int filename__decompress(const char *name, char *pathname,
 	 * descriptor to the uncompressed file.
 	 */
 	if (!compressions[comp].is_compressed(name)) {
+		fd = open(name, O_RDONLY | O_CLOEXEC);
+		if (fd < 0)
+			*err = errno;
 		if (pathname && len > 0)
 			pathname[0] = '\0';
-		return open(name, O_RDONLY | O_CLOEXEC);
+		return fd;
 	}
 
 	fd = mkostemp(tmpbuf, O_CLOEXEC);
-- 
2.54.0

