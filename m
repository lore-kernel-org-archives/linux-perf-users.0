Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64423471266;
	Sun,  4 Oct 2026 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135021; cv=none; b=Ap+ycbmyiy6zjySvYcuOfYAkFj9Z5Rqo+xLSykXZfOWiPIhuBlUHJ75NSksBzgav4LzQRoY7ILy7hmSbnzt3rzbMVKXFuQpEtheOKZ9igOb+hAwP+w/C0VCpbXUZl+kBTE9dQBBK1rapmU6icrkQSyl+ipNJINMNnQhoWaxY36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135021; c=relaxed/simple;
	bh=xnJ0E046ME8LTvEUrOdXxLjWWji+HEg+GCi03JsverE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxII/KNImr0e6kDql4u1mQj93XpgqQBn4ODwM/dDmeqR1R7C7QOhUtGPs13x1V0C/WorXz4nAklGFNfAfsMLljOT88D5fZr2nZYvR7/ScxPYo4YOMPqMhZRnGHKSZfce+yokUeCzUz3YX7X+s6WVD4Y0voPYd/Cl/3+PwmD/UUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ3G8YKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ3G8YKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3E21F000FF;
	Sun,  4 Oct 2026 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135020;
	bh=GsRS+8QUyzXT3sy05mzdqRSQVHQwC0/XHLNHgHoSuiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aJ3G8YKgAF+0wKWOLNQa7KRO4ZKieuIe1NAPYJypU8UzZFQLoJ+J+TCELbtoJeOxQ
	 gZNrYGL7p9P2V65nryhA0G01nbXOTtZhzl8CRY4wxJWpWCmI89NQdOQw8BsLmGEkG6
	 wF5Cq0kh8kS0sjMv1Vu3PD39j08y5j+myIqE+xK8eNuxEOZRAowLa/Oy9MCmIY36Mg
	 2LueSQ9TeTg6bolwaiDSqZmpVLizT+4F3fJG2vjv1PHgiYMQC6WM0IlD5VadzxtDPv
	 agn6fgO9NWA0cbSS5GY/C4f9XNkGJ7tlF59hlvbRoO4NulYLxq5ccaMyXRj9LhgY9E
	 Q45w92WuCgO/g==
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
Subject: [PATCH v11 2/9] perf config: Make perf_etc_perfconfig() never return NULL
Date: Sun,  4 Oct 2026 19:29:53 +0200
Message-ID: <20261004173000.2863935-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004173000.2863935-1-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
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

