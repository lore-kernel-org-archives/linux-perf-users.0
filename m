Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C02931E9;
	Sun,  2 Aug 2026 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680437; cv=none; b=RjqipHA5gTu9AizaqXOICd6hoHfQlops6zpk9ACeBHnZh9hM82UgGS7vLuJ1N1Lmmj2Yq+p4ZSv2DI9kCmT6AYD/sPG2AJAGwlC5V5kIE9RfgEkR0Dn3TFSpc20nvFWEYEQvQ/Cn5sQ2m+jw6OZcPLdpAn4ZRWlK2+X7M281YFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680437; c=relaxed/simple;
	bh=n1QmrkenUqO3WkREjTlLTszPnas3fHNaLp3UhQYWC+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDLKWRQCqSibpDgkJ7G2XE5MOE6XLMjeDTOh3WCeq1Nk4p6Yq0lS62WPyvtfZKRpkgKMZQze7ICQ9gFsbgo9PJpQ7Z4w7NtPvXDGACW/bM3sMGf6vx/ah0jK1tYbt47hYB3VucHwmW5peJKdYmapZAGAnWJXSIhCaCGBU3YVrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPCVsQt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPCVsQt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737701F000E9;
	Sun,  2 Aug 2026 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680436;
	bh=CgtmxRD/mwQTFtenYmEuWnKNKZuIi1hpoSEM9ZDXMKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oPCVsQt2Lp4SeDVQkc3A6FuKryV0KGVSzRguKvUn/ia30DWV4pnNXmw+QYR1f6BbT
	 1Ct3HsFkAIvNGN/ZMgFatkaWArQ5Ogsr0NUWQC4BlIPVKYHjMXnc3rCbTVVpHN9c/J
	 iwYJI9kynr0VFwLxyB2WGc6yHAKt4d/RqV8avjHkFIT+Q/BLlwrwHBHDKkq37mO4sN
	 vjjv/HZgnH/9Xu8S8F8oisjy9fKBxPmpjkAyZaZsOncTfdxR7posLGW9A6NRi4ASDt
	 33T8bv6oFkxNanH6yrsPD60fhzVQT2rOpOHGhpNY9bXJQsSRw2ONGYR4VBGbWcd8SS
	 5zMXXOw2b0wJw==
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
Date: Sun,  2 Aug 2026 11:20:19 -0300
Message-ID: <20260802142022.154219-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142022.154219-1-acme@kernel.org>
References: <20260802142022.154219-1-acme@kernel.org>
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
---
 tools/perf/util/dso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e087a89066bdbc02..d9c008465f377e79 100644
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

