Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970812E1DB;
	Sat,  3 Aug 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722719616; cv=none; b=YvY4NMjwWACDNI0ZbETCBC3OyGszIcgn6E3fa80/9r6oNyTFvYE8Q+E+rWbh+MltGJyVxrVen4zs3vWzA7SE+aLswSCx3LKZd099b5fD2mV0z5edR3NXUxJli03ctD7ZF+qhtDGQtnPFOVKmXnR5feIYD5vbI/Ek/ca3EYANJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722719616; c=relaxed/simple;
	bh=3Do5Nqsn5IpyIKiHPCwjz0+bX/709KjClVS+haHKStY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBqenpz7cfGwEeePinIG4I/d3oDC0QkBurkoS8tmxUwRUO4B35tU2CCA+rOD9wrjTxLB2PrmPahoJ/3KMSn3woLx+81D2I3I50U6NrrOY/ZJLfB9MXsa2duEMfN33E3eEZvZzMH4/WsLLDMOUgcbRa6nOCL1XKj3SpHohjzo+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFprdLxV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFprdLxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A1AC4AF60;
	Sat,  3 Aug 2024 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722719616;
	bh=3Do5Nqsn5IpyIKiHPCwjz0+bX/709KjClVS+haHKStY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFprdLxVncAKuyLzrnPSHn5Z1jDjQmXNuu94arGNPMLXvMNVWCeAOhDlSKReBpI/A
	 lyO9pb2obW3H8Jip1nX2m0Hv0jTqCOr5sUbjd+ezPZOcVGpSHfsjATjcGTBGnI9Vk8
	 ozcgcL4QBWLG8VidBTroCeTVLP44r7IH61NRHLV++b/Ap8jguaP6pALdyd24t0UHTt
	 ESbUwfhGzPQctAulrSD+WB8e+6Rbmx0yXiVOJ2WYZImqHXa+3T8Z4JO04Rx6+GEUgw
	 8O23sOc8ajdB/UjNspF8cXD4/Ga3Ywo0cY+5uTytYYnxTz4BVLsyy4mlgG1JRZGcfb
	 gmg4bWk3kR1dw==
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
Subject: [PATCH 4/5] perf annotate: Set al->data_nr using the notes->src->nr_events
Date: Sat,  3 Aug 2024 14:13:31 -0700
Message-ID: <20240803211332.1107222-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240803211332.1107222-1-namhyung@kernel.org>
References: <20240803211332.1107222-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation to support skipping empty events.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/disasm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 85fb0cfedf94..22289003e16d 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1037,10 +1037,8 @@ static size_t disasm_line_size(int nr)
 struct disasm_line *disasm_line__new(struct annotate_args *args)
 {
 	struct disasm_line *dl = NULL;
-	int nr = 1;
-
-	if (evsel__is_group_event(args->evsel))
-		nr = args->evsel->core.nr_members;
+	struct annotation *notes = symbol__annotation(args->ms.sym);
+	int nr = notes->src->nr_events;
 
 	dl = zalloc(disasm_line_size(nr));
 	if (!dl)
-- 
2.46.0.rc2.264.g509ed76dc8-goog

