Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210DF522EF0;
	Tue, 13 Oct 2026 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912119; cv=none; b=plbXP0IBOaSxxppr0UcUp6bMEbXQYAHQPvMWEMj2FD1C5cF7WHew7xy5P0ti91mpCYBSdyPAq9zo7WZ/GK6pQbPIMxyrYoAdce1SkjtdQV4vESjvH6EfJ39SIffTMSiGBqsrgfoQSAx7yHImylSi577JgoRayx+sNLBbrcxH5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912119; c=relaxed/simple;
	bh=s36LHh8gKa9HmJq5UT53os6RPOEgo0Yu9yMYdcbU14Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaPSLsdxZYePtrkp7NPIXUIFPqHItys065DPwr9Jb54/Kyf/dfqc66U3v23MrWBaGKf7iWC/1B+4fD4zI/pPABuyIFHqvU/TjbCzy66aHYY6gn5tn60/SJo5DgDpjiYKG3FJeJ9OwpvM+QOEDEUL7t5IDpyeZ9Jh5KvUb7FCKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qbc+Btbo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qbc+Btbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D0C1F00893;
	Tue, 13 Oct 2026 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912117;
	bh=EvfKAlmfLmTZWjmnC1MQzCa9C3gTY0EOiVM6ZpYM8Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qbc+BtbojmynnLPi09tdOeTEbPrj3hE8zSzwXcm9E8S4Tcbrc/XPH3zZNrlWKpLje
	 q2zG0VIo3+F5/OECMDc+vn7h27l0eW7c92beEGyNB0Lcq5wIf4Xo4BFvTKjnUYVmC8
	 S7uij05jAKMj4Si+oSUyS3dn1LHQXAuiAHesb3vE14yTSE07Ndzwd2E36ynOLJvuTW
	 nG0vgIkuIT5Nhlvcv94jowNUoOp5qRI3PS1EcDGnE9u5N4wrCEIV2gVJ4p3YQfvnZN
	 1mynmddOPed/mJj+bw8sp1o+rAs7Vn6TLJnUmBGv7aB2DO1zhkuxX6alfHr1ikozb5
	 jtjsoNCA3BGsg==
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
Subject: [PATCH v5 01/11] perf tools: Remove redundant dso data init
Date: Tue, 13 Oct 2026 10:21:45 -0700
Message-ID: <20261013172155.160869-2-namhyung@kernel.org>
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

The fd and status are initialized later with cache.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d3017c82ffb5f4b1..df03f84c9723560e 100644
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
2.56.0.385.gd3acb90ef8-goog

