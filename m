Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC63DB994;
	Mon, 12 Oct 2026 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848819; cv=none; b=papGhvb3w8LgGJeZdRqmSZTI1DKroFcVMgQpKuQPelC5sLpt7YaQejxxOwcnK8BhnoXzKH+E23P6IRv8Vha/1+AJJtfYbakVwQX6baYg8NpwJNiWEJOxBGDZoDp69qTU10CBuXqpivlek+fbeh3WWm9SeaccBkjtdpPx9blN94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848819; c=relaxed/simple;
	bh=6gmI8Q0aZuBxyuAXBtoMuKPpmn3ZtMEOhYspjVOcvXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUezogH7nBquVgPKuBZjUR2SlVgQwGrcuFFGpf073mDfKLn9R0f1thuryZKL/5fb6LKzQbH8sjedMasNyCDj9wyjKmW8j+1kMMHtEW+AyCqaLNa6Hw3wZpgtH1iPn4V/RcL8GS+AKbHJKDQCpQsmo0ZoAVWZpGeBeusNj76AyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFVTws8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFVTws8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371CB1F0089B;
	Mon, 12 Oct 2026 23:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848818;
	bh=jQw/qLOs9surUT5cXAats9gIV9YEuZ96sqWXoqEYWwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JFVTws8BVpARtOrg34Q9Icl+LsVuZORf9lsdGlrDVmhdIfmqRDD8WMVPJ/FLeIy3L
	 p7FoULoZMgQGYDEOoOm01JY2zSVzHba6Tpvyx/lPpq3Z+dsWQARkQEloEYlAvKENkO
	 5NS7mXn0qnPmarWSuftadpnq+QPmMsyT4IurZSjHOnXam2ZVp1xMjkIZIKkp8Z+NIX
	 c7zFb46s3spegygM2wDOOmPanYxF7U3HeCgeSQwnONNAuFurGf3VyGTexyiWIZvXfe
	 1wLXOWG/dSGMN1m3I1OYlKHL3D/PtAEX4rgHi6aBDN9aRka9c4VuVix5RIQph4Y+Zg
	 S7ZQD+XCtKkPA==
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
Subject: [PATCH v4 02/10] perf tools: Try linked debug files for DSO debug info
Date: Mon, 12 Oct 2026 16:46:46 -0700
Message-ID: <20261012234654.60666-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012234654.60666-1-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
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

