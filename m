Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463533556D;
	Tue, 11 Aug 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470723; cv=none; b=cvv4rvkpvWlaJeyegmzs+DLZ0VF5gDRJyjXlUfuotpHwSQKsJNE+TgbfugpelT/hXw/TYybqBsmMivLovrD7KjiMIJns9Xtbamy3Gi4HJWN+OJ3Rig/0ta5jdB+lJ+VMvinjsWycifyjLJ37a7ZF1LjdussOGM63v56ZMJBWtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470723; c=relaxed/simple;
	bh=513k8sIZ237IGTqrF3M0HFNOnoTZ/diJNj70c/sLgH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiD4AGwXRo18fAYiUTat1AGYj0YfUhnyCqSLJvFh+SsjF6e74y6wmrprCM8MALpo4vNY+z6IWbS3GMGSoPHJedA5r7IM3ejq1xYruHYXO+7tDn8r8b95fdSkckBUqr5pRtpDluRmNFgW2FFZ4elJ543l9sI9e48GnHzIHDf0Qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tmq2xqse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tmq2xqse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8A71F00A3A;
	Tue, 11 Aug 2026 17:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470721;
	bh=3aK21HaVMQJEhw+/RMJH82RbKAMYsMk3KdXl+tIUVxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tmq2xqseoiAd6CVFGFvM7hLHZXOmhPqr9OQj9ZVqy+NKMCgnooCfnuAvFTjlYuh3R
	 7afauzNgkBSMMuCPQxggfcT4XqpgTGuWcPlDsfZr89av70Q3vJZppqHD48fv7EY9ub
	 sNGmU6nA2WXe3trAMtM941oxqQ2Lm6QdNJJD7dWiiBFtfV4lTqYQPLpamAWosNjtcc
	 XltRjtyQG0bG48it/jTLdW/vLz0IZ0cW3zjoon4P7D83qXbB2hBEEuzyP+JFTKiQP2
	 rGe4pAv3vK6/2QxjS90X8/yW9Hs5ZVAwM+Gf3CIDP3aAORIae+GMd8sGXHJih8pGV5
	 yx3kGBjFC806A==
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
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 3/5] perf dso: Use stored fd error instead of stale errno in file_read() and file_size()
Date: Tue, 11 Aug 2026 14:51:32 -0300
Message-ID: <20260811175140.7235-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811175140.7235-1-acme@kernel.org>
References: <20260811175140.7235-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

file_read() and file_size() use ret = -errno when
dso__data(dso)->fd is negative after try_to_open_dso() fails.  By this
point errno has been through mutex_lock(), nsinfo__mountns_enter(), and
multiple open() attempts inside try_to_open_dso() — it no longer
reflects the actual open failure.  If errno happens to be 0, ret = 0
looks like EOF rather than an error, and file_size() callers like
dso__data_size() would then report a zero-sized file instead of
failing.

dso__data(dso)->fd is always negative on failure — -errno from
__open_dso() when no filename could be built (e.g. -EINVAL, -ENOENT),
or -1 when do_open() itself failed — and never 0, so use it directly
instead of reading the stale global errno.

Fixes: 33bdedcea2d7 ("perf tools: Protect dso cache fd with a mutex")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 124193453675ca18..32ae5c78cdb906e6 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1029,7 +1029,8 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 	if (dso__data(dso)->fd < 0) {
 		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
-		ret = -errno;
+		/* fd is always negative here: -errno or -1, never 0 */
+		ret = dso__data(dso)->fd;
 		goto out;
 	}
 
@@ -1151,8 +1152,9 @@ static int file_size(struct dso *dso, struct machine *machine)
 	try_to_open_dso(dso, machine);
 
 	if (dso__data(dso)->fd < 0) {
-		ret = -errno;
 		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
+		/* fd is always negative here: -errno or -1, never 0 */
+		ret = dso__data(dso)->fd;
 		goto out;
 	}
 
-- 
2.55.0

