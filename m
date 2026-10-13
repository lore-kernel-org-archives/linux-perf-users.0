Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AA3F4854;
	Tue, 13 Oct 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912120; cv=none; b=VXeSWkQvoz+zUELVZQs1jTUmrb4XIo4fdJmIsO/D5h4iO86mtgknY3ssgcCC9P2mfY3K7CZGQcXVh9ueGXn3iVM9O/yptw32SQsHQfng33QJ71CyLNfpxjzMZp8682DG9clQ8PPNUBkBwxm9xrSc3UObT4d22fLBn242svU6fwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912120; c=relaxed/simple;
	bh=6gmI8Q0aZuBxyuAXBtoMuKPpmn3ZtMEOhYspjVOcvXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3z7WnNCnPao9wi9XB2O8V5oPlSJT//Ai+xC1eAIDCFUz5pd71SxPabuHcDVX5O++X02SddK6M3vTcTVvqmm5fYPbIL9ohq14Uw2Jf0kbNuGH+OhP3Ymy4aU4dyzppmL9+jeo8LeFC43oif5S1Tor6gL2RPfa/KSMkCjAgzAGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXyhVj/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXyhVj/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592921F00899;
	Tue, 13 Oct 2026 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912118;
	bh=jQw/qLOs9surUT5cXAats9gIV9YEuZ96sqWXoqEYWwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IXyhVj/zBFU3JqX50ler4ukdMMIdKRJ/EyCyFErTV5eoyWyJmdNW94m6/95fiVnWh
	 wJ/iceLbhNWyTSITKEfL0NHnfEQHhBsDoKIq9FT2VMNy4dFNTcC1ldC2EqqYnnA+BE
	 Hnw/VMGWE3egJjqPw8wEgfAW1ep6FUTwkpZSQm9TvOhQ5pGhqh7ryVsKdNfzU1gd6l
	 GbXeVQYeQfzt46rOt/yXJC8hhZgwwjem51WCl05vjEMC/39C45CKmh8+RFYnZcUQUI
	 kDf38s5Hswpr5JOs1iiVS3CSCxCrUHQKT0P4WK+WcpJZ9Rf6wySQwXfJLnZFb0/GIs
	 NznNq61JejEqg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 03/11] perf tools: Try linked debug files for DSO debug info
Date: Tue, 13 Oct 2026 10:21:47 -0700
Message-ID: <20261013172155.160869-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013172155.160869-1-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dso__find_dbginfo_type() should try DSO_BINARY_TYPE__DEBUGLINK so it
can follow the .gnu_debuglink and find the debug information in the
separate file.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index df03f84c9723560e..913877b84b2d437e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2111,6 +2111,7 @@ void dso__find_dbginfo_type(struct dso *dso)
 		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
 		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
+		DSO_BINARY_TYPE__DEBUGLINK,
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	const enum dso_binary_type *type;
-- 
2.56.0.385.gd3acb90ef8-goog

