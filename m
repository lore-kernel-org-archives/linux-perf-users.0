Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D51F63D9;
	Fri,  2 Oct 2026 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980965; cv=none; b=ElBs/lIdj2yOzGEN7uGb12eYEouk6EZmlxf0iEABt+9C7JPkQXBsBq7zLxSkuL2lBew8XwRKgFms/4F2EEbCkBcPb0BM+Vxp2EzNGdhhPsxS0Jt6TkVW6XAJD9sM/MJKcIVyVek3YvEK5qm1nZ3oOmY5n/lF2LPfaFfunyPeLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980965; c=relaxed/simple;
	bh=9Ox0KfRYeP1OFAEwUZ/SlRiSowZrzw+AoOpDwrRDmGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aT1IRy0RbqDSgvRidbG/GTZ+/hKBTFV1psXrXOCOUWXyjhkxGvdC8qR6JBQ7PB9I9SQnW/2eVVPuTS4Njifcr/UT9xS4MGGyX3ge4OSclhANWQ8fReSs9RVLIYiLjcaObp/oTK5WiEtNcUcBqU0n6/QZxjqP2dy8XwHmIAsReiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/7XB1Nk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/7XB1Nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47F91F000FF;
	Fri,  2 Oct 2026 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790980964;
	bh=C5qC/UDVgeWz7tOMTAIvLvxxQAYIkFlyQ1WgJlOpItQ=;
	h=From:To:Cc:Subject:Date;
	b=G/7XB1Nk1D6UQijxOXpG6DY0rL6Zw0dPU8oHqMfH02zK3wJz3BrmynlppW0OO1aye
	 QXRbIr5yXY4wqjX7Jaz8fb5UfjRDVtzPBf16yAxWHyYHgvYR/duk+/ganPzhJFFi1J
	 uaadUo8lI4OiXq3A+ZcnKSUifbtY/7VbBz0SOm/FybYCaW/DIbqf8ER3GHyIjqmIT3
	 9dHr79CGDQYPZbJPnn7XngJoA6op+WXdBYcwxmIFk7nzGXuL3y5arFENNgPjJSfaZv
	 z9+bnNg/Fpla0WErUq+XELhQ5BGbhmda1IGPECxy+z/utTrHIpo5TFXEVpUMTDsKFM
	 HESyluO7r5OUQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] perf dwarf-aux: Check .eh_frame section for CFA
Date: Fri,  2 Oct 2026 15:42:41 -0700
Message-ID: <20261002224242.396135-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The die_get_cfa() only calls dwarf_getcfi() which handles .debug_frame
section.  But most binaries have .eh_frame instead so it would fail.
Let's call dwarf_getcfi_elf() first to try .eh_frame section and then
fallback to .debug_frame.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 54f8b5ec74a2fe70..af3913e661fce79e 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1886,9 +1886,14 @@ int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
 	Dwarf_Op *ops = NULL;
 	size_t nops;
 
-	cfi = dwarf_getcfi(dwarf);
-	if (cfi == NULL)
-		return -1;
+	/* try to get .eh_frame section */
+	cfi = dwarf_getcfi_elf(dwarf_getelf(dwarf));
+	if (cfi == NULL) {
+		/* and then try .debug_frame section */
+		cfi = dwarf_getcfi(dwarf);
+		if (cfi == NULL)
+			return -1;
+	}
 
 	if (!dwarf_cfi_addrframe(cfi, pc, &frame) &&
 	    !dwarf_frame_cfa(frame, &ops, &nops) &&
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

