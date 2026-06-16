Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B4450911;
	Tue, 16 Jun 2026 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624702; cv=none; b=sx/3l8Ac/b4xEV+Fe0zufn2GfF49a0I/OThoFHyN2MCN7ztNw0iMEzn4zRala6H3tHRlPy00OtUgN7suphwot+bV2qLj4vn+KODBpHmpOyd3XgO4TT1dyYYU2ySSP+E1tVTai9lR7EJhXgRbFIHMkUIOxmDCsMnXFFXFXXOoo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624702; c=relaxed/simple;
	bh=T/Mu13zdV4DjS2WdIhdeC9UY++R8kmGc0o41kLv5qME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmZpc/Jc8XfhyYGUJDwY+1YdQzzgx/WNPml8DOOMVZuMFPDZH6Nf/uIm05D2mSkfSUGUVimC1lRzPfMt+N7Wz4Z8ZdxX+shklP24USMKQxauViQilWzCyK/yREfpsbErPCZ7DTu5yE6sc5T3y7OPQXwWBz10Gn/IxUa5mSpC3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnziFGJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnziFGJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEF71F00A3A;
	Tue, 16 Jun 2026 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624699;
	bh=ja6HFfIID+G9AN89mM0NtD+HNlbq940B7f7OpakyXKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QnziFGJ/leAVHeOqvdqVoOiBc3+8GsDZ9ydcfqAa9Uxcn6ho2HLgOPIIMkvCbOFWN
	 PgPrXhPPZ2O0ZlVrEHPdzYp9G/2L/sXi74K+SRekNDCF2TysAeCcGZFkI5ofK3nBJ9
	 Y5uEpxRSU7IVgFuRhOu3Rw5rSNBhhI8ulr7Ealt7juw1SLKevxZKvwQ5iT5XKbhBQc
	 5qtzVixtJRamNbkgGG1G12x5NuWtZ1KkyMTXKVO28CWoZDLRdNn+BpByAo5Y6a6VSS
	 fbS2aNYMlhrJn7zmKjR/ewj9HyRAVprQGguwRVd+Nz9EqSkcxwF6RqdF+x6YnPlOTS
	 keCpJ0DvDVFXA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 2/2] perf trace: Guard __probe_ip suppression with evsel__is_probe()
Date: Tue, 16 Jun 2026 12:44:46 -0300
Message-ID: <20260616154446.7206-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616154446.7206-1-acme@kernel.org>
References: <20260616154446.7206-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

trace__fprintf_tp_fields() compares every field name against
"__probe_ip" for all tracepoint events, but this field is only
implicitly added by the Ftrace subsystem to bare dynamic probes.

Add an evsel__is_probe() check before the strcmp so the string
comparison is skipped entirely for non-probe events.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a8492da23a9cc178..57f3f14c5d435805 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3267,7 +3267,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 		 * If verbose mode is enabled, ensure it is formatted as a
 		 * hexadecimal memory address rather than a signed integer.
 		 */
-		if (!strcmp(field->name, "__probe_ip")) {
+		if (evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip")) {
 			if (!verbose)
 				continue;
 
-- 
2.54.0

