Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611EC28FF;
	Tue,  1 Oct 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742030; cv=none; b=a/gfBaGhNhkc8NIseHWzNcYOV7vnCB9EFelGiKd62s7wZQgmcIrhuo5FYmJM1xib3f7u5CJg8DmmgNRxUB9HYpVKqgRi1eq7HTu3OPzu3n81WR9Xtsi+giMWx4chkwWEKC2ITHCQnnh/E8SiglJ8pnmpjU/07zazGGSkvskU0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742030; c=relaxed/simple;
	bh=SCiLTiO0cp8e6Kfe5pAOVI5Gp/s3ui2/Ngx6XNpetHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxXpDPU2IQ/xHiK/+gzscHsrX0En/tsVsbTmy6K47GJ87J2G5ydfoEGNfCKkvovU/PerPrInhCw7RJOP1o8sGahccPlsig3qoxRBoX5vhsc+Xkk/2PdG87PZHXicW56WupxYwZtOAEBUkgjgt12mZciRoGcr1h8nLKA1SvvtibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL/ITFIG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL/ITFIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5DAC4CED1;
	Tue,  1 Oct 2024 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727742029;
	bh=SCiLTiO0cp8e6Kfe5pAOVI5Gp/s3ui2/Ngx6XNpetHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GL/ITFIGKEEtS/vA1OKYEn2ivPHkLfsUsztWdOo+kYZDUObsmVazQeWF/dP92ulpq
	 4niEVmfYJ0b4KaELgTd1Fprh6BQO4Y9cTzoe3MpY37tiEcfqzRag6vB2XT/TIk19/W
	 t6DABt+V7j9kblxhPflchpUYcIl6LUKzzyxYAruncWWTmOZRyQI6Lg8gwuTwTQVNj6
	 6TBdXkK40KHdkp5h33mRNVUk5nzInzL/qBTqW7Wnt8CO+Dr4GfdJc+f1NDjbtn+nPK
	 u8rkCVIV7WnX+pGJikkjnC2Kuu4inGuLu8+vrva6Q7nseIucqB3UG/i+abT8yPNfBH
	 Nv3guNupkCRYA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 1/8] perf tools: Add fallback for exclude_guest
Date: Mon, 30 Sep 2024 17:20:20 -0700
Message-ID: <20241001002027.1272889-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001002027.1272889-1-namhyung@kernel.org>
References: <20241001002027.1272889-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
changed to parse "cycles:P" event instead of creating a new cycles
event for perf record.  But it also changed the way how modifiers are
handled so it doesn't set the exclude_guest bit by default.

It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
if not.  Let's add a fallback so that it can work with default events.

Fixes: 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 18 +++++++++++++++---
 tools/perf/util/evsel.c   | 21 +++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1521b6df26065ccf..fd9ea15f6b1c0809 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -639,8 +639,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 	 * (behavior changed with commit b0a873e).
 	 */
 	if (errno == EINVAL || errno == ENOSYS ||
-	    errno == ENOENT || errno == EOPNOTSUPP ||
-	    errno == ENXIO) {
+	    errno == ENOENT || errno == ENXIO) {
 		if (verbose > 0)
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
@@ -658,7 +657,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
-	} else if (target__has_per_thread(&target) &&
+	} else if (target__has_per_thread(&target) && errno != EOPNOTSUPP &&
 		   evsel_list->core.threads &&
 		   evsel_list->core.threads->err_thread != -1) {
 		/*
@@ -679,6 +678,19 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		return COUNTER_SKIP;
 	}
 
+	if (errno == EOPNOTSUPP) {
+		if (verbose > 0) {
+			ui__warning("%s event is not supported by the kernel.\n",
+				    evsel__name(counter));
+		}
+		counter->supported = false;
+		counter->errored = true;
+
+		if ((evsel__leader(counter) != counter) ||
+		    !(counter->core.leader->nr_members > 1))
+			return COUNTER_SKIP;
+	}
+
 	evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
 	ui__error("%s\n", msg);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index da0bada62140d9b0..0ddd77c139e89a2e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3259,6 +3259,27 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 		evsel->core.attr.exclude_kernel = 1;
 		evsel->core.attr.exclude_hv     = 1;
 
+		return true;
+	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
+		   !evsel->exclude_GH) {
+		const char *name = evsel__name(evsel);
+		char *new_name;
+		const char *sep = ":";
+
+		/* Is there already the separator in the name. */
+		if (strchr(name, '/') ||
+		    (strchr(name, ':') && !evsel->is_libpfm_event))
+			sep = "";
+
+		if (asprintf(&new_name, "%s%sH", name, sep) < 0)
+			return false;
+
+		free(evsel->name);
+		evsel->name = new_name;
+		/* Apple M1 requires exclude_guest */
+		scnprintf(msg, msgsize, "trying to fall back to excluding guest samples");
+		evsel->core.attr.exclude_guest = 1;
+
 		return true;
 	}
 
-- 
2.46.1.824.gd892dcdcdd-goog

