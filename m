Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B82F3632;
	Thu, 13 Aug 2026 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582187; cv=none; b=roGP6WhPLKd55ioxiR+ZSxnoU+1oInK+L0svqnPhZ3j296DsuMt1/oXSBaxLn4Z7C8MdpB4lSHB7ualbOCnY4eLWzhiB0/d7BhvWwHWGauGNoyikySGhnvFYkAxK354VKHrwwuWfW5HqHIsSxZyUGkDpPfBZfPH/3GbxUfvkRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582187; c=relaxed/simple;
	bh=urUtVkjwefdOhPlZHnowKM5UrjCzAgEJuR69ITMu7Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd+a8Lf+vpaDRtY0pajQJAhdovS/rU2PMKRV5MAJ+iTrEPBnmjtnt1a4vDiPh/RB3ujG6Uc01NU6sNIkvsiAhB1PWgI2HgtA6rTMgZr9zIe6BaoZ2SxCWuslNRY9lED0wvnWvsk/mNjxeEADS61SlA9pWgepE46SYs72E3CAllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4SDcxl5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4SDcxl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD7B1F000E9;
	Thu, 13 Aug 2026 00:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582185;
	bh=tE+gD/DYiH9Bu2QyVuZtH7jbAU4uDC65mNnhgfDx+Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4SDcxl5fku3KmwHuVIwhHL2vdZNd0Cd1n+ncuJ5di8fZEFlnsAZDOXRQqgdxOXS3
	 4iajt0Eg9/n4uUp36bik7lJ6J6By7WY8kcTamlQqiAODn06VP9UmLvv3c6mtAokrb+
	 aUH8If/YcHejT1CETbAfMA+eUZu9qkgcxx7LHyJa8swY3ANGn2BgUfb8iSn0fdOo+2
	 04HVjYQgYaDW1k6KwIvWCABhLzK3K71m6j0C/Bt7Lgo4krFb0PHzbFR/GfTV9YgvPf
	 KgoVV6lnZEPFxNRsiAYvvsvfZhsnw/ADgAf3lqt+RMpI3zTGlWcWG8wS16henJqujE
	 JXwvmS7hYHvLg==
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
Subject: [PATCH 2/5] perf dso: Guard close() against invalid fd in dso__decompress_kmodule_path()
Date: Wed, 12 Aug 2026 21:49:21 -0300
Message-ID: <20260813004927.16738-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813004927.16738-1-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

dso__decompress_kmodule_path() unconditionally calls close(fd) on the
return value of decompress_kmodule().  When decompression fails or the
DSO is not compressed, decompress_kmodule() returns -1.  close(-1)
fails with EBADF and clobbers errno, which callers up the chain
(dso__get_filename → __open_dso) depend on for error propagation.

Guard the close() call with fd >= 0 so only valid file descriptors are
closed.

Fixes: 42b3fa670825 ("perf tools: Introduce dso__decompress_kmodule_{fd,path}")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index fcd4b462992be6f2..124193453675ca18 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -395,7 +395,9 @@ int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 {
 	int fd = decompress_kmodule(dso, name, pathname, len);
 
-	close(fd);
+	/* decompress_kmodule() returns -1 on failure, don't close(-1) */
+	if (fd >= 0)
+		close(fd);
 	return fd >= 0 ? 0 : -1;
 }
 
-- 
2.55.0

