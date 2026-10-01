Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094842122F;
	Thu,  1 Oct 2026 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880857; cv=none; b=gW8QMCFdYt6uRePnKm71Q7+1zxw8vwkNFus0vMQRQ3sbVqh5fBU8rgiVNFUAlqCLK+oRJIVCJQUdlrNK7COx6D1N/OFvqwf25YdcreJWTF5WOguDUSUQJOEB5nzt9VTBrjcyJWHKoZqCZO6RoEPX/JWigwbMLExOtFvALcegbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880857; c=relaxed/simple;
	bh=xnJ0E046ME8LTvEUrOdXxLjWWji+HEg+GCi03JsverE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTqs+LwmmL1AJDOPF2aoUsJ+GSALlHFy6yfOaXfnVF8DJMzYWNJkRE6lSB/sqDwQCgaC/wcT7XPKZULyET3VDHWAGIV55Ij+U3MrzTKFNj7DrL7Z2LHgc6PqFRh07VkDfkm2rYHZfOFohVyLkhNUJsn+NrzS/LEM9GByIggSoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9NHOFCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9NHOFCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E881F000FF;
	Thu,  1 Oct 2026 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790880856;
	bh=GsRS+8QUyzXT3sy05mzdqRSQVHQwC0/XHLNHgHoSuiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e9NHOFCDv2lFtcoVHguSDY8o+/kU91Ua7BNoCcDrpmZCzWy3lwFnn9Zs7shl4W7dV
	 27SgIZ3la5atbrFcHxTvk9AO0w6tLFI548BqlRpzuMkVIYwCMguJ6BXLk5Bb5hZ8op
	 pT+D21vOBGWeVVgCDOVwMv2B/o2U29DF9gOKPMnZG2aNOGdzQV+8c16jVMJYuKsFYY
	 1Oh/a1+QvHv5LK9Q0kywRHXadWo3Pqg8Cx/wRHwrPttzRULoTGKxdesrhf93Fo8Le9
	 5yJWoGF8ZkVjhNc5W1vdOj64sds+cfRS7Nf1N6p3dwYqAH3V7bGKrczfGc2PFjZkjY
	 3MR/Vtv1vXu5g==
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
Subject: [PATCH v7 2/9] perf config: Make perf_etc_perfconfig() never return NULL
Date: Thu,  1 Oct 2026 20:53:53 +0200
Message-ID: <20261001185400.2754753-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001185400.2754753-1-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
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

