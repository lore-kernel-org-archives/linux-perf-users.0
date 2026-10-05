Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF2352C2C;
	Mon,  5 Oct 2026 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182058; cv=none; b=MjqmDZOmwli4aiJPEmGR2QCkK0vJ8Rtm3CtqOyptvkpPLSs7QFowa8rNss1EXD7ReN0l7nNlr/rO4yyYIy4DNxq7Sa+B0k4IjnGmBY+PnWcmhUGyvTNa5flYq0O64DsOb/AmpbwWC4O70Q00CjNFPnAK5bopqh30qnoGh04DPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182058; c=relaxed/simple;
	bh=7yeRNAC/KLRvlwLEBccoWF2LVTNPYXrMle2WZf4Wu/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE+CJxAwVYEfm0tfgD6JxmhjKGpjKoMDXXv2Ry4a/ElAiUvk81xktKVIAIRrIhGSvepiUphE6DsB28Ao8vnUqwvt19LBEwyuUgC/grPH0oG/ndFeF9wKq2wK/qctVf+ovt5c1ZKeM/52vPGeoC0jFgEHtcWHwA5+GqeiA0Can1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEEmP9Rx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEEmP9Rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619A41F0089B;
	Mon,  5 Oct 2026 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182057;
	bh=rWiI20AzFW8ig1nI6C/Eq5hqRy855Pkib5Qvnl0VrdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEEmP9Rx7zqa7fpd1f59+L8p85OkJwBuRrA47+n7D7pjJpCRf3+VwwDXNDM2/sGCT
	 tjijLSv37v+VqHjxxbRlYMtm2yBzXn2I2DBIvlGpAJY/72KGewUGkMgVIEUTHdHbTi
	 JFd1MWFrEI2ed4/CkBrCjKpGyvg/PcraVZVompQg5FDBSvBIGqUGrASiYSDMx/3/pr
	 Nf6y5J3yXc52ya6ACPxqhWUFlVCMcvCp3Dp/j5ak45HY8nBQwmdcDf/IYgVOacpYn0
	 5+0+ibxht7qnvHbMdfZjr5Z7E/v8bKoUxX6eBzij+/4PPoAv1+hCNBMri3+MaySmmo
	 NYBF7Lwlno4AQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 1/7] perf tools: Remove redundant dso data init
Date: Sun,  4 Oct 2026 23:34:05 -0700
Message-ID: <20261005063411.114244-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005063411.114244-1-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fd and status are initialized later with cache.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 563a8f854c13bc21..7f389b913edb5ec7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1722,8 +1722,6 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->srclines = RB_ROOT_CACHED;
 		dso->data_types = RB_ROOT;
 		dso->global_vars = RB_ROOT;
-		dso->data.fd = -1;
-		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
-- 
2.55.0

