Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794339CCF2;
	Sun,  4 Oct 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109310; cv=none; b=fbca2S9XJ+Q4juyTANh2co90BHzu4fZDJIhkCljGbAT6hDT6WU3hiYkiQQCmqYEq/oJAhNkWKaBaKVIPy8NxU9ISZ49/jhw5hFlK5JvfgZ/6JbXsSnoruphYtl7TcwRviD71sd8MNLvm0btmB6bQttSuVLdK327+ASarudb3Pyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109310; c=relaxed/simple;
	bh=xnJ0E046ME8LTvEUrOdXxLjWWji+HEg+GCi03JsverE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbKGWsUEb3mDh5rI4A1+lDJQ1kdsNKiZ6Zt/lgbZzYRy4nFw5O1pbJwCdn9BWEF2un4LjhzawPhgl0BO1gvpn4oa7lebcVOMO6Kb0Pg0U88AAIebU9fnB7KD2ih3ZWKdKtQTypKqS4TXVk2fbHUj90Q9XeZeNrESP5n/Av8OB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaFjjj56; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaFjjj56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA12C1F000FF;
	Sun,  4 Oct 2026 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109309;
	bh=GsRS+8QUyzXT3sy05mzdqRSQVHQwC0/XHLNHgHoSuiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XaFjjj56Ki9C+/v6c+Gxzs5NMp7K/nMD3A7qWhJMFNyJz1wChhWWrKfyVW5Gkgtm+
	 8NEry5rqPaFyfQ3SWlCJwFIav3OoDerFtEVO3+g7gcCdQtvuWirfee/7yX97APsPOq
	 upDno6voiyU5rXoUJaGSq3vDDpcezTMTYYY7AeoM7WTb41G1Tl3iicye8TOVfp6qq4
	 CaWsaKg8frwdNYN8ndslqDzx9QmpswVMOFplE1wOIsV2zN8Qh6QtBDAqQ1mYq9cXLG
	 jzDWyZ00hOBdv2+y8jj0LhgbEnIJzxckd5gKIPzm5dxH4MTAYAXfPGCF4ivcgCEfVw
	 63BLB5BBX0lTw==
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
Subject: [PATCH v10 2/9] perf config: Make perf_etc_perfconfig() never return NULL
Date: Sun,  4 Oct 2026 12:21:26 +0200
Message-ID: <20261004102133.26392-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004102133.26392-1-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
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

