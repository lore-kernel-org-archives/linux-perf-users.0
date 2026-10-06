Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C148640B;
	Tue,  6 Oct 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298669; cv=none; b=b4DBGEb8ZtftXK+x2Iy1otfR1f6Ia1boa68cArNDjiqouYjwdmaAbokY1TfvKCCAgIOAqH/LpQFE0nSIondf0xLRA/Ih2I+MYs8VC1cxYP3vyx6oB8E/40EJi5RREMzPMnouVJt5gs/iHIkfrgOLvXOamsL6UyXMds/XQvwme74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298669; c=relaxed/simple;
	bh=xnJ0E046ME8LTvEUrOdXxLjWWji+HEg+GCi03JsverE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIa3vCz4sU+EC7XLwPTvYOfY18VCFCogiEBGo3KWpLuwsnbOa5d6OY9c225HYmc1jixvZbx5yN7uXdI/J9Zaai15lNWuNFLErOHhSP7/eJrs8VwaVRL9j5J4haL0lf/YoanYc1esMTzKnjtRAmKg6vwf8gDYfGOYF41xSw6As/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu72sqJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu72sqJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8194A1F0089B;
	Tue,  6 Oct 2026 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298667;
	bh=GsRS+8QUyzXT3sy05mzdqRSQVHQwC0/XHLNHgHoSuiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zu72sqJ4U4JHLXjNFkNzZD5UPT2EWFqKGvxzk0dA+eckaFybmqsLAHPA/XPQVMlsu
	 h2gARIlihk4lAEtgSi1hjgiExLZzWPv0L9vp9o+JJc2/gWjYZsWUPEvO+YR2kSH4oR
	 CJIIgYnrDirgEHnNoxfnz3q8+3yqcP7Xv4oUNFz3quOJ+Bot45DfkY5SwhNi8B0N8k
	 d1BO1vCKFOobjeF+FGOxhx6RroYZtWHtFNMW5jl2jA4bgGBN1J34oNFAx7IRVmA4QB
	 BrpQ1yInNRGsyl2OiiiSlsXDaNDCEhThhOmmdUlxLIRvvailH2Oa6LYi5w8DuAYYOr
	 Wjy8gyWn/BnxA==
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
Subject: [PATCH 2/8] perf config: Make perf_etc_perfconfig() never return NULL
Date: Tue,  6 Oct 2026 16:57:23 +0200
Message-ID: <20261006145729.3028247-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006145729.3028247-1-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
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

