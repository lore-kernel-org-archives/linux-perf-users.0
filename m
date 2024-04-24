Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52F16EBEF;
	Wed, 24 Apr 2024 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999616; cv=none; b=p5VJTRQ7lAJjNcaNGH7k+Y1BoI/7P0mRS634gHIXKCDdnPa6tctssQqHbprm/PmQsk81+XdK6Wb0OELJP6XJK74dDIgw2okOm/7GZgpViAAkGJW9Cin2VZwIr43cI6yotbbXp/EHHzyxRSPMMln2CAg3xG8o4KrZf6nXwet5yYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999616; c=relaxed/simple;
	bh=9CcOa0hUVvEuNYn5qr9p8DH151WKe0SGbjU1e0KFA7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tf5KACBGGdFuDe/vhibB/vc1SBxM40SwVPee38wotwKqFaebMZi7vDKNBZ9vLq7QaR4AIKcFwBIDYjKMsjwBvBzTaQNqa1bKAjxqZLFslMIAtv/slvtnURBvbVfJ0mK3FEpKLAZ8U4babaOlTBvk+jLopM0sJP25zdGILsznJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0IXeXrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0IXeXrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC5DC113CE;
	Wed, 24 Apr 2024 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713999616;
	bh=9CcOa0hUVvEuNYn5qr9p8DH151WKe0SGbjU1e0KFA7k=;
	h=From:To:Cc:Subject:Date:From;
	b=Q0IXeXrRsJ11NTSZXEY0JT6G3/yX0cVA4nHl7OVl21biOq0jrRNhvdrkiV4QLXUU0
	 fg+t89/HgchVzlgqTlD9l7bofRzSsxavD8d683xc4M1jMoUZRsttMwX0w/i2FNxkoU
	 AEPhf3j1ZrcrnBQGlBo/7cUgnyOAFg00OVEXjLTahNfzjX7KBfT+bWbaDMiV9csKme
	 HOQQjM7KNm4DJ3nFHz27txczNCOagCiF2K1wPJh2KuiU0bdEVgbBezfbw1y16oPPEO
	 yAWqe0aipXH6GyDKUVnktGhHuOxJAp86uNYh6rVYczcDjX4VhUece2LSXMrXZ1WpyR
	 7CmruK6rlzZLA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf annotate-data: Check annotation on perf report TUI
Date: Wed, 24 Apr 2024 16:00:15 -0700
Message-ID: <20240424230015.1054013-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As it removed the sample accounting for code when no symbol sort key is
given for perf report TUI, it might not allocate the annotated_source
yet.  Let's check if it's NULL first.

Fixes: 6cdd977ec24e1 ("perf report: Do not collect sample histogram unnecessarily")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index dca2c08ab8c5..f5b6b5e5e757 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -906,7 +906,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (parch)
 		*parch = arch;
 
-	if (!list_empty(&notes->src->source))
+	if (notes->src && !list_empty(&notes->src->source))
 		return 0;
 
 	args.arch = arch;
-- 
2.44.0.769.g3c40516874-goog

