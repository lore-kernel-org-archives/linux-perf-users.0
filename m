Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D42D24B6;
	Thu, 11 Dec 2025 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765491497; cv=none; b=d7U452+Uv6lMK/hv+o2umK1msZbl9P4GsfwKvy99KJqJ93GJUBHJRksIdl35njXO0rQwQAuUN8F60PS/C7E2b0sCFgywoD/FuOv1EIlq9D56mMdUqE05BZA2avnz4lRgPyjoJCL0xSOLgazr6UHAvKRTATwPM7kjG9SJZ1DgTQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765491497; c=relaxed/simple;
	bh=C0V5aOJ0cXE0jisK65iUMGF3ss0ur1ph4+wirWwNY3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcvKr2ztWQScYgVl2/C1XdqS1qF8SVqHSH1N4wsRMkjcmEU2V9MX6JJDbdzIfa9fQ1zC/awGMG728Cy7E6yXKo2iLmvkNaBIxB2jb+P4Pte51IbP0k7bPpAxBDP2bH2XM/WN8+YedeZrLkP4apKmIy5+YXioiXJH/7yKU/tVMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4J3nVtF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4J3nVtF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682A3C16AAE;
	Thu, 11 Dec 2025 22:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765491497;
	bh=C0V5aOJ0cXE0jisK65iUMGF3ss0ur1ph4+wirWwNY3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4J3nVtFdfVFu/37oO5Df0vujoyDQYTZSP1P6VnUbFgRYSCKPUmWqelXEWDm3H/SO
	 1RzXTKxgKl0bOeucvR42AICjAoooOgZYlUEnZjA62bCthhp4UGfMIuosF46yClLmd/
	 vvT+3Yc+s9Q+hdfWleqc/iKBGDQQx3ccb4MnLEPxB04U5jSVs0KOKhyFbjXJYhdLES
	 Uu4Ed1k6PNLYg5OX+D7mHls5ohfOfSL5uDr/ikKXQZ0o4nB/wYZ17mjJuNWlwIRSsH
	 c9Fs2hFTPuh/F1I8+JAH2ZYubNkZYudCGcmnLddGWvHUNSafbKvZduyikrFy5Cr6nM
	 3cpN3zh8Qmiow==
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
Subject: [PATCH 4/4] perf trace: Don't change const char strings
Date: Thu, 11 Dec 2025 19:17:56 -0300
Message-ID: <20251211221756.96294-5-acme@kernel.org>
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

We got away with this so far but now with fedora 44 complaining about
the return value of strchr et all, lets use strdup for good measure.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index baee1f6956001d86..d49c1ae409d77df1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5173,8 +5173,8 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 				      int unset __maybe_unused)
 {
 	struct trace *trace = (struct trace *)opt->value;
-	const char *s = str;
-	char *sep = NULL, *lists[2] = { NULL, NULL, };
+	const char *s;
+	char *strd, *sep = NULL, *lists[2] = { NULL, NULL, };
 	int len = strlen(str) + 1, err = -1, list, idx;
 	char *strace_groups_dir = system_path(STRACE_GROUPS_DIR);
 	char group_name[PATH_MAX];
@@ -5183,6 +5183,10 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	if (strace_groups_dir == NULL)
 		return -1;
 
+	s = strd = strdup(str);
+	if (strd == NULL)
+		return -1;
+
 	if (*s == '!') {
 		++s;
 		trace->not_ev_qualifier = true;
@@ -5257,8 +5261,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	free(strace_groups_dir);
 	free(lists[0]);
 	free(lists[1]);
-	if (sep)
-		*sep = ',';
+	free(strd);
 
 	return err;
 }
-- 
2.52.0

