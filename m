Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742F43B3F6;
	Fri,  2 Oct 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936508; cv=none; b=Sriz2JHGNvRXtd+mHxIKDmja1oheFSVQlpnLxjmNZUX1rykFOlmmKfl23eTofnqlmNBb1vrsgQMnA/F/UXMInJQsEy2kHYGqdcqpqfhmlzy1Ye0BZpd4mtYiplzqmJ23LS7MPxcA6QWjijm/7FWFwaN0syaAJDMLP/9p+1Etf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936508; c=relaxed/simple;
	bh=xnJ0E046ME8LTvEUrOdXxLjWWji+HEg+GCi03JsverE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Epa3x1QZt5T2NSr4PQuZ2OXA8Sh66rOfKVfSRlDKiIaSELFoIMat1OFta4PpQlRkFiuVu5BTtMEK4Ga1e0CrEbNSduJ6KnH/ziXrbzGXyo+Jp3i8LsmOlBZsoLrVAzeOSU733rOBTWHmBGsg9ojpRXcdD7dGvHNyPYudRQyb0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fji9qHVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fji9qHVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4D81F000FF;
	Fri,  2 Oct 2026 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936507;
	bh=GsRS+8QUyzXT3sy05mzdqRSQVHQwC0/XHLNHgHoSuiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fji9qHVjVh1j40XYyxGfwgWTUpLQXMdk1b09asojXNPbjgJWk1k6HKW1rK1aN/L+n
	 GgLhdu/S46TRu7hD8VUCx7xAnpZzKmD0WzQ+z2ZoXBN80YyMC6rNlVN2xJrkwh0jFJ
	 +ujzM7ZkIHQA874VpgIADdoi3juHvDci7mD+WRZD8CzL+DXYmC4Y5SFMqaqrePOPkC
	 jlLcjDrKUiMMgb8giOluSH0KKkTMvUf2ilJ9TCIammDS7QmgUgWunnJ/M2NoGWwA6D
	 SDL1xS7v7yvmBiH9psz8wz1R1Awlf5YMDKEZDDJm0W366ubTrZTl3/lI1trvGQwwe0
	 9fcYHKpSU7Lew==
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
Subject: [PATCH v8 2/9] perf config: Make perf_etc_perfconfig() never return NULL
Date: Fri,  2 Oct 2026 12:21:03 +0200
Message-ID: <20261002102110.27587-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002102110.27587-1-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
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

