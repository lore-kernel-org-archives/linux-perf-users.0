Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A531AABC;
	Tue, 16 Jun 2026 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638260; cv=none; b=Lm36mFUXlaNwZR2rUBdBLnDu/qkqm31tZL4voBPkLdrs+Mu9sJjgxDuWrC7J6sCY4IeFwqgFQQBC7e+n7bDAcPQBLDPsHCybvwHEHhNmSzV1xkCkJ6staF8TWHTtm3q/3Kt4C+pKlmBy24+atYycbV5E6/4wQbRZeUODgdOhxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638260; c=relaxed/simple;
	bh=/ouZAdwPNodkqdYcbLkgddbPDqEhLnZ+uZcM97iV06I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pI4OR2ePyP8Qj30yILh3S0k6QsYmbUipzrG8dWKAHPaCcHUAfzze3Y/cYn6D7xm5nlAhRlxsu1L6HJB7/sC+FzaJTPeQaFgFzvtNra8dqVckOFf3lGTrGGbyfeKENpRaWLfo/lllx0IHE2yiFo8F+6zBjzMOlR2k8qh7ycmOJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWgcxNIH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWgcxNIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF711F000E9;
	Tue, 16 Jun 2026 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781638259;
	bh=go+3OAOQAlKkBE7/7hRA2XivK9iT+vmvDtATOYjf8XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iWgcxNIHo2d++r/vJ49aTss8dRNkuNUSLEZ15nkwwCb2IO1t1n0h4n5C1SRRMo09n
	 3/BkEJG48/PddqtnAZfrdIPqymnrEMeiSZ1dE1e2zu2022JhohOUPLifuohWDV6cG2
	 GhTbVOrZx9167839K5/QoObjFglFlYWHHzlzSGSTwij/j8Z+qNmfP5f6AWHh+XvS81
	 9Vd76MPiHMad3DJsDVKkunH/mlftCIcRm+P1BzViArqjbgh5r1R4NqOx8BHBOMQeVY
	 JP22ZdKcbmTS1ZovMBUhOcxheMccak1OvtCl87fdsGa+d+NCs818SnWvXh+uqnLDd+
	 hI0LpKNqeJwYQ==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linaro.org>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 4/9] perf cs-etm: Require full global header in auxtrace_info size check
Date: Tue, 16 Jun 2026 16:30:28 -0300
Message-ID: <20260616193033.10035-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616193033.10035-1-acme@kernel.org>
References: <20260616193033.10035-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

cs_etm__process_auxtrace_info() checks that header.size covers
event_header_size + INFO_HEADER_SIZE (16 bytes total), but then
accesses ptr[CS_PMU_TYPE_CPUS] at offset 24 from the start of the
event.  A crafted 16-byte auxtrace_info event passes the size check
but reads out-of-bounds.

Include CS_ETM_HEADER_SIZE in the minimum size check so that the
global header entries (version, pmu_type_cpus, snapshot) are
guaranteed to fit within the event.

Fixes: 55c1de9973d66516 ("perf cs-etm: Print auxtrace info even if OpenCSD isn't linked")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
index 4abe416e3febd2cc..aebef71d3a0a1d7b 100644
--- a/tools/perf/util/cs-etm-base.c
+++ b/tools/perf/util/cs-etm-base.c
@@ -170,7 +170,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	u64 *ptr = NULL;
 	u64 hdr_version;
 
-	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE))
+	/* Ensure priv[] is large enough for the global header entries */
+	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE +
+					  CS_ETM_HEADER_SIZE))
 		return -EINVAL;
 
 	/* First the global part */
-- 
2.54.0

