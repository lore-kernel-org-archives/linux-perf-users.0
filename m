Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A183B6BE5;
	Thu, 13 Aug 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633922; cv=none; b=BZPPv/KO7SZbUoJHCeNfbVv63IEoBaf6WSzz7n2XQ9EwjKn/GLwLY/uVHErcMepYMZQEQOMcuxEyX2eYY7aE01LmCpk+7H+PYdrrPgYB8jGy85IanJe99sx8E7nbMUxig5rY6JYqWqsSmwgkoB1bB/s0HLdFd8PDsjPu46UjYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633922; c=relaxed/simple;
	bh=nrJuzIScqO4BLESZmtMB5DweqQmx1akHlCW8z/DKZ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKTCwIxmlIgexZUeLbMTQVBGcCQS0yzvfSWG6geWqE+m3atwpJufc7cIUwGNDQYbL8zJUwMcIkVAIceZU4zh4nzNGqBOxfjm/QhrYZ2t6gSc6PRkxxXq0hnZumKig6CkDcAWPMI7vYDjN7wOTb3HVK4rUBtQJKsZXKN0ncwiqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCZgJ184; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCZgJ184"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393A81F00A3A;
	Thu, 13 Aug 2026 15:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633921;
	bh=9xTgEY+RhaI+JvCVLK3SoMsdrx5fyfqj91XI7HnDn9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GCZgJ184NzECzlipJ8Q54mBAz0cgfCW4HMrRjuUN8y6cEmCh7+0+C4zujcbrphO3A
	 zcMttt+6wQBaqVnk34u1TQwPh9t8eamAqFv4SXG+vmY8LrN3a+lqm1YfI/rngSxYhm
	 OUucaL1LmIrJ5jjQvZA8x9eCWAreTBvLvbGthLdeLj7i+syI4mGK/5iMEaZ6WA/O+b
	 JYOs7P+P1a3akI8+0j335Ivv1fbP289PEPY/9b9w6tqoI1Hyo1YFULYOeXNLAa9fz5
	 Yw04ip/MxmrGZ4PhhRWrmibqbEBHNjanDm5qje0c1MelA5GKIQ7Ri7k1EWgVnjAJ2D
	 XLzWzXtkaXhQA==
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
Date: Thu, 13 Aug 2026 12:11:43 -0300
Message-ID: <20260813151148.23169-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813151148.23169-1-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index b86969dc6e81e96e..41bbc8f994e41a3d 100644
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

