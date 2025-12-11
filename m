Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602A21423C;
	Thu, 11 Dec 2025 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765491488; cv=none; b=J2P/BD4X+OetXWrLjc6FRCha9nSmSH7lOykBHFucnATWw8oQN+9EGgKcC4vFN8Ob82UgAtHLn0F1UVEjKrLrKsQFxDvLEgvbWHq1RcxEWkRL5czdxXu/60niF+73DVGBMHvMthAtrb3nLFMVeXmCocfq689TDhj9LOqMVmMnaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765491488; c=relaxed/simple;
	bh=nOH1ZX9DzwGUJ1whuJFT388Azu1H/+zQWlzIVUweQSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgcD35Gp4zDDihgY0xnh9cRQrKsWtCry7QQRhzd6R2Gvj/GduIuoCV/X7UG81wLrgyF9++arBqzP/zwmdn68r/GnNjevLgtIc84hEfc2GW8pPTUZiIKCINjD1G/bFXbRbH99G4oBaEdQ2QueuGIARypopO5yZbEwcmSFliXbKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXO8i/xO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXO8i/xO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0B0C19422;
	Thu, 11 Dec 2025 22:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765491487;
	bh=nOH1ZX9DzwGUJ1whuJFT388Azu1H/+zQWlzIVUweQSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXO8i/xOQSuc4SEjAdkvm8Aw0I+9Q1pUcjr9sN109KNryy5TeR/ElJmvgbzYBDj5a
	 SR+CQJ8IeFTpnjdaLgg+gINYoPKRre6KIp0MfhMxmWuxdqT/LdwggGGFeCaeN7jteY
	 BzuuaXxrHoRT3UVGcs4QAHBa6r7m/x+z3rJpdeu8QvHJX25jQPi8wowWLQCrhLW92S
	 xslcr9zKuT8SfrNeAhSVvslqBEumgKhPGZuY/b5WYpYfCBXwDdTsQMjlKZ9fhe7mHr
	 HOK4yJ+W1WVW9FAG8FVuNNqJRORcbsiGyVPhKoSiLzFqpv1peNgkiejo5nIQPqJyKw
	 5XjJtbS1N7OTA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/4] perf list: Remove unused 'sep' variable
Date: Thu, 11 Dec 2025 19:17:53 -0300
Message-ID: <20251211221756.96294-2-acme@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211221756.96294-1-acme@kernel.org>
References: <20251211221756.96294-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is just being set to the return of strchr() but never used, just
ditch it and with it get rid of a warning about it not being const on
fedora 44.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 5cbca0bacd35237e..ac7bd0e41aa1d5d6 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -648,7 +648,7 @@ int cmd_list(int argc, const char **argv)
 	}
 
 	for (i = 0; i < argc; ++i) {
-		char *sep, *s;
+		char *s;
 
 		if (strcmp(argv[i], "tracepoint") == 0) {
 			char *old_pmu_glob = default_ps.pmu_glob;
@@ -720,7 +720,7 @@ int cmd_list(int argc, const char **argv)
 		else if (strcmp(argv[i], "pfm") == 0)
 			print_libpfm_events(&print_cb, ps);
 #endif
-		else if ((sep = strchr(argv[i], ':')) != NULL) {
+		else if (strchr(argv[i], ':') != NULL) {
 			char *old_pmu_glob = ps->pmu_glob;
 			char *old_event_glob = ps->event_glob;
 
-- 
2.52.0

