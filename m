Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C14213235;
	Fri, 23 May 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748038919; cv=none; b=YkxIL7BOVzbHnO9zRsOB8tI8M+NxajMim2vmJm43DA5/WQPKIgpKg04bnZA8WEPl9XPJjWFDmX6mXS7K8yUw6amGhbXukeyVPBOgDwVK5KeFyTx39kFJu59r1HwOyGHhIzWshfNKuKKZGxcrR62b5iH9cPICWEsbYp+nIDsSo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748038919; c=relaxed/simple;
	bh=PvEftXP3gEm/AqF0/6fxz9CRmi5dmdQgMS8gGZ6dLd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE95WG9muLPKRoVUG7i2nsOQa2u95TD00hN208hhLCUoBNzBfvTXkTLSOntXC8h5vP84cnFBl/U4i/jaH/fZyfHj4qkwkhPekShK7lttFjB/2JIlC/7kZDT9BzeFFUoNncdSChAcD0bWqbwAkhD+Ec5x/ubBhDEunGJzS23ECP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY0ZK9oB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY0ZK9oB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C91C4CEF3;
	Fri, 23 May 2025 22:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748038918;
	bh=PvEftXP3gEm/AqF0/6fxz9CRmi5dmdQgMS8gGZ6dLd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mY0ZK9oB17ZB8QZBB4dbbfamitGDZcQIMJxoFh+ZGgELs7Auf2ViC3h/9ZmMWR0Mu
	 q9AA2j0a47l3YnBya7rY8iTzX5ERZdLtQ3SMVBkti+UqXRLuwDR9PPWtZePXJNltcM
	 9Z7pfymbMEWmTZe2A7HacTb8k0MlA0wRXM84loaL+ghbf9dFojHuysAlQ5nhbHyg5S
	 5ptGtCEwBZggJZCEV89lIQaY1bTDbto4qQLAzFpGC5dLpXYQPz1xV3Ny9wNzRoXKNg
	 dzt3dv1et/FC95XPXSsRM667lp/R5wCliDFsdu3ur2+hMdomjSTMAIkspOR3nharwL
	 Qcsh6jWDS1qMg==
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
	Leo Yan <leo.yan@arm.com>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/3] perf mem: Display sort order only if it's available
Date: Fri, 23 May 2025 15:21:56 -0700
Message-ID: <20250523222157.1259998-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523222157.1259998-1-namhyung@kernel.org>
References: <20250523222157.1259998-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOW it's not used when -F option is used alone.  Let's make it
conditional to skip printing incorrect information.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f0299c7ee0254a37..e662e1c3a7c6b6ec 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -529,7 +529,10 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 
 	if (rep->mem_mode) {
 		ret += fprintf(fp, "\n# Total weight : %" PRIu64, nr_events);
-		ret += fprintf(fp, "\n# Sort order   : %s", sort_order ? : default_mem_sort_order);
+		if (sort_order || !field_order) {
+			ret += fprintf(fp, "\n# Sort order   : %s",
+				       sort_order ? : default_mem_sort_order);
+		}
 	} else
 		ret += fprintf(fp, "\n# Event count (approx.): %" PRIu64, nr_events);
 
-- 
2.49.0.1151.ga128411c76-goog

