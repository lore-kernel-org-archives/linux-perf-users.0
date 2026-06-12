Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650A28B4FD;
	Fri, 12 Jun 2026 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224514; cv=none; b=gon6haSIvWl/lhQkTvQc5dG3puJlSpFc/K1N6kBU6a9eZSA8E47A5fr869PjIEgBSfXVsvLqvVZJlSMmDSeoP3M6xx5nKZdFEKb6EEuExjx72fHJDPExitwXmGeJTUCzf0b97YhWzY/Jn+5dQ6taSGk2vkv0UIgmT8+6cuL/Yj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224514; c=relaxed/simple;
	bh=RsvTEtZFimuiOFNKX5fKD3iZu3LRkThGQChVHy9/aAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lf8OvXh6zZ/sRyrGQ/4433htYFDqaeRP47faOAGtdeZkYftbsS0nM0/gcEUwLhYiSm42/v/Ni/+Yzw0G0pqwVz2G77ObuihXjxdc5f7ibsu+jFBGyy6YjcZXB7/TnVavIQSGmQ6RdJaTvCUr9ikKVqg4SlWWc+Fb1MS15T4LQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRxl73Q3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRxl73Q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308FC1F000E9;
	Fri, 12 Jun 2026 00:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224513;
	bh=Lzxwb2mVIhdmIzPqJINp8NNNztvFaeNcw3B6tnJg3AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZRxl73Q3ws67epTnA/iAuu7bXp1hSDnr5m8g8ABXtjk7Lz6Rr4Ey35BcTW+2nAR9m
	 b0jBR/0ycZjEvc4hgErHH3927QxdOk916JR3jvfWGwsw/UVXFHQXU5Yr3uOlvXyRv/
	 LSNolx8oUMiRaaBByPJeUO434/HNnImmGeGr7ZyOceGPxFbJ6YJtMpMahR1+bhF02j
	 3pRexCGQgb30CFZsKVi6LccIt8LFKT/9LqNRYB4UHAfQAHxhXev1olrtdaUIwtm1cW
	 +dEi2redAwV08yiWtsuPgyFP/KF0FlXLIKSS+2dUejNgmpPggfclyRYfMC49A3YwSz
	 mqPQjTbYsph6A==
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
Subject: [PATCH 06/15] perf dso: Set error code when open() fails on uncompressed fallback path
Date: Thu, 11 Jun 2026 21:34:34 -0300
Message-ID: <20260612003444.50723-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
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

