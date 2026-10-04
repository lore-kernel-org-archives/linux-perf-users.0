Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8363F54AA;
	Sun,  4 Oct 2026 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093916; cv=none; b=HzMOvsO3HnGYQUiETP7mEJzy4h8SsxgGQ+456Ytxnh3uz0Z5ODL2zZO8VJbANHgvX+zSlXowag6BhMMSUkwD2i1A3FjRXNQ5k5nfwdVXpSJRuSDpxVu3EHXZCwLrSf9SMUJnQh3grO/6BdPnhMADMGDPSdtIUMG3OL/stIkLrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093916; c=relaxed/simple;
	bh=xnJ0E046ME8LTvEUrOdXxLjWWji+HEg+GCi03JsverE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7TGhzeCOARpr6/IW4sB9e3UeZ1Q3hbyVCT33Lkos8u1cu2AOUxvoisOVIXM++E3pywnEJwx1L96DKY/YXLHxGzENwzv3Qg8RWB6oIDTjO8Tlc4hPV8wPDgyTBUlJXXC49biQZV3ldMyZd4amlM4BFcifluGlkve7o/KX69qbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7UaJyQl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7UaJyQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612251F000FF;
	Sun,  4 Oct 2026 06:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791093915;
	bh=GsRS+8QUyzXT3sy05mzdqRSQVHQwC0/XHLNHgHoSuiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7UaJyQliVoGRMmru8gwgyZuUDyoqhypa4jcoT83m8OVVWCvorM6Qd/BQJ6RHMMHp
	 CZpvPmd15bP89n7XSxFpfQqCMNHOGUSwyqKN5qSYq2CUTVORcvRmUt2knGMBmUKm6I
	 bA92HxKL+0jLeLkW2DnRe6dmnnEXZi++teDuTGXu1UQAIBdwAUfyLBHq7n2Me2iq5e
	 xxBy6PkOGARV1WhVqUjUlo4jGfpERJAt2mbod7Uj4Bmpyxc6YMdLFDGBUoqsIFRIdV
	 AT1sDlDDVbJd9UwcPskUWrXKnHresjrHgqIl0ePGwEdVk2R/6LZUV+eoEKuFqcBfsd
	 ultcpx5JiM/ZQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 2/9] perf config: Make perf_etc_perfconfig() never return NULL
Date: Sun,  4 Oct 2026 08:04:49 +0200
Message-ID: <20261004060457.3353-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004060457.3353-1-acme@kernel.org>
References: <20261004060457.3353-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf_etc_perfconfig() returns what system_path() gives, and that
allocates, so on failure every caller dereferenced NULL, the
pre-existing ones in perf_config_set__init() and in the daemon
included.  For the usual absolute ETC_PERFCONFIG system_path() just
returns a strdup of it, so use ETC_PERFCONFIG itself when that fails.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/config.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 85e50d0a25580da0..6e0ff8a9140ccf96 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -571,8 +571,14 @@ static int perf_config_from_file(config_fn_t fn, const char *filename, void *dat
 const char *perf_etc_perfconfig(void)
 {
 	static const char *system_wide;
+
 	if (!system_wide)
-		system_wide = system_path(ETC_PERFCONFIG);
+		/*
+		 * ETC_PERFCONFIG is absolute, so its unresolved path is
+		 * the same string, better than the callers crashing.
+		 */
+		system_wide = system_path(ETC_PERFCONFIG) ?: ETC_PERFCONFIG;
+
 	return system_wide;
 }
 
-- 
2.55.0

