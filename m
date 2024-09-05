Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE61B12FE;
	Thu,  5 Sep 2024 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567874; cv=none; b=aByISh1vSCd5/L+jx/S0bh2fTaJVRDC3v6JksC/+E2Hesz1GzHr7p7aDF/XvFn8DLRtgcc2MgFZrcxRDLnwfJ4OrPpXPieup3hxPklRyLwg+S3Atdybbg8vKIAdMH9Wy+zgU5Dt41y6EX0ONOIFMwKNJ2KPa/FYcb8IjYNH/llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567874; c=relaxed/simple;
	bh=29eATBDBumyqrjtaCtZNaXbHhGBs2etJ13trK8RfIoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMzOKP117YdUTl3+9VSbfB9FzqSeVTxcGjbNP4lC8kclghqANSJKei6H6gwAhtzr4oWGPJWS3naZaWEznRDVZUvKZl/6YWoDf757Ui9rkT2SbMZG3zL8N7D8lbQmY/fSUqG1nDi2A6cTjLAL10m/gZ73OGPD+Lp1quGlswcxnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR34QT0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR34QT0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0C8C4CECD;
	Thu,  5 Sep 2024 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567873;
	bh=29eATBDBumyqrjtaCtZNaXbHhGBs2etJ13trK8RfIoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fR34QT0a7F5KlkOJ06tMpuelsc9h3cPCz2pHqY2aQfGzSBkXKuIww4rvMAsssxV/2
	 6V3ZVYlAQpXyqhG7bDZ48bylMnT9Np+4v5RcwHSSUlTX7xigmmlj3fQ50Ty80Nv3A6
	 m7kSyfJiZMYuMesHLFuBlS73yx+iHNsh8REqgpw9pJIr0mKWQx1+9kaDARqWb5hEnd
	 0vfrUHl88VKFBm8r8+3quxbRQwNEI9Y6hQ93BuTD5b2mpS0VnagfwpW6GtThFe/TLx
	 GnESHl/hYEj83prPzhdlCZ9d/4jI3NJSnayk9BXT3fuu9GlqjPEQ8vUvdQeFD/dtHD
	 t+bpWPLhKd9SA==
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
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 07/10] perf tools: Separate exclude_hv fallback
Date: Thu,  5 Sep 2024 13:24:23 -0700
Message-ID: <20240905202426.2690105-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905202426.2690105-1-namhyung@kernel.org>
References: <20240905202426.2690105-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exclude_hv was added in the evsel__fallback() in the commit
4ec8d984895fef43a ("perf record: Fix priv level with branch sampling
for paranoid=2") to address branch stack samples on Intel PMUs.
As some other PMUs might not support that, let's separate the bit from
exclude_kernel to make sure it can add the bit only if required.

Technically it should change the modifier string at the end of the
event name.  ":u" is for exclude_kernel + exclude_hv, so it should be
":uh" if it has exclude_kernel only.  That means the default events for
regular users will looks like "cycles:Puh" (for perf record) or
"instructions:uh" (for perf stat).  But I'm not sure if it's worth the
trouble so I didn't touch the name in this patch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1a4f52767942e5ad..c5df45bb74dfc1b5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3389,10 +3389,20 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 		free(evsel->name);
 		evsel->name = new_name;
 		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
-			  "to fall back to excluding kernel and hypervisor "
-			  " samples", paranoid);
+			  "to fall back to excluding kernel samples", paranoid);
 		evsel->core.attr.exclude_kernel = 1;
-		evsel->core.attr.exclude_hv     = 1;
+
+		return true;
+	} else if (err == EACCES && !evsel->core.attr.exclude_hv &&
+		   (paranoid = perf_event_paranoid()) > 1) {
+		/* If event has exclude user then don't exclude hv. */
+		if (evsel->core.attr.exclude_user)
+			return false;
+
+		/* Intel branch stack requires exclude_hv */
+		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
+			  "to fall back to excluding hypervisor samples", paranoid);
+		evsel->core.attr.exclude_hv = 1;
 
 		return true;
 	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
-- 
2.46.0.469.g59c65b2a67-goog

