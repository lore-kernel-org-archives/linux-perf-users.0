Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965A4E3229;
	Tue,  6 Oct 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330198; cv=none; b=bEzJMPLoycH3YYhb7ezjZeROT2LRTkXx8AZtokccwWyhiy3Kd1gD0nqG2qQjnw/XGOmIWC0PCrBDZATSZU+T3bgKshV8QyjHWeyUM7FwvPn/so62DC5s8pYcX2xkh8gtCfqbDUWPWV25xXSE8DNPAVeFJ8PFJb/qHCLK40bJxc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330198; c=relaxed/simple;
	bh=vSQQbUZBwsHCX/C2qZ3hQXjFPEWOd8WAs3hYFzK7kJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bv+ln6WthQVNHzarVk8bTey7joPChHD2z9/PygAmgHsuol2PxFgknvkuIWJr6eqZa+ry1DKxQDXPT1sqm8aygBqLjZo7ouCJbyjjh20BXiB4zM5ZZ9VrNviNKtdLVAVZBbqqyqXyFWDXvpyOpdAmRPapVaJAZmwrNMArbPi0hRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJC6coAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJC6coAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C111F0089D;
	Tue,  6 Oct 2026 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330196;
	bh=1jDUSorU4kyVGRVWcaneTaZaVDiAL2DMUj9EKPVJMao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gJC6coARNpL6ZbzbQK+8BCncbJVSfFkv+GKROTrtdsIK41+Y7oZz2Q+2gNeNaPavC
	 C0WqKCzv1321mAyh0ph0+h/LfHSnWGza7oXdOVwInUbMYOcpeB3Qys6aVVTZ+cCAif
	 +qasfcl+8RmioIMBrgJ9C36/GxVhlxGAvSGzNbhxofFWiBYtJPfMRpUyfxgy2+m4yN
	 YIx3xym8xTmPd9bzu8gIHpais4bZ40G/cLPOXJtObERvn8Yiz/bSUlUyz5/MD2X7zO
	 LVGKlxzOW2kVH7vjpuXnlwq2S8RM256aEmncBwcLJvMIHfTJOUiO4NL7pTl1pC/u4C
	 LosV8LS3D2+mA==
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
Subject: [PATCH v2 02/10] perf tools: Try linked debug files for DSO debug info
Date: Tue,  6 Oct 2026 16:43:06 -0700
Message-ID: <20261006234315.920817-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261006234315.920817-1-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
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
2.56.0.rc1.315.gc6ed9934b7-goog

