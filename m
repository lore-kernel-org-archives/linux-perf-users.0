Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B626271835;
	Thu, 27 Feb 2025 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693324; cv=none; b=LMR8ZkGc1o5Man+yB5RdfXsH1bOB1MSFbJ0EjByXoym5QpC9orcW21FJ/u/p8D5mPUc9xzhb2WUOYaPvnWukP48KGY5q4UbmupBEaDzouZs2jcaHSoux9HRx1Hnb/qfWJ+v6ymsmlCSkHeRsJjyoJdevgV0YEQRLiQoCizTjTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693324; c=relaxed/simple;
	bh=h7BhvuSO4LxIjLp4A1ne8AL/fHsgrqjcSVvxLGZlXdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSXL0xnj5rRtSw6m5+g/3SZHWvXJbwxz/AqhtSDy1ifHqW5WOJLY5bn3gnOP/Vh9YQP604JRzlzkVdtzQNbufGVccEW2Zm+GDNzZO+axa6osSObweM8OkjqADBy5AzRELio3PPriUsyhvsVQ5cxorq+hgk6zRLSsmgEsYi+LMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg29myMa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg29myMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE007C4CEE5;
	Thu, 27 Feb 2025 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693323;
	bh=h7BhvuSO4LxIjLp4A1ne8AL/fHsgrqjcSVvxLGZlXdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gg29myMapylP1vu4NCyMla2QbyrTLEo7qJmu2WEaqZJymxLqEssUqUdx8+6Hcnqs9
	 7l8PCZ3Z9caEVIXaaNIPu32qiQ51XBP/fy6rl30+sTjSQ9n+s8bp+1E8qcRVYYk3PU
	 q3BVwubjn7NlRVDtFMOzYUVddg5T9RvK1GSwVHZNMIkkFZEWbV69mrEaBxdCooyvmn
	 1n609JEFfkLJ7TVAEuticJ742K/rfZCyMS6vGzxRF15Ro+fTuYB9+LG8XzNimenCWx
	 gw297zd1BzHUn1UZU7BtuSAGYjjTnWX3KSs1kzW2nS+ucIRkOU1/QJ/nj55LlElj8S
	 WqVsfHCOCQhEg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 5/6] perf maps: Add missing map__set_kmap() when replacing a kernel map
Date: Thu, 27 Feb 2025 18:54:54 -0300
Message-ID: <20250227215455.30514-6-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215455.30514-1-acme@kernel.org>
References: <20250227215455.30514-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since in this case __maps__insert_sorted() is not called and thus
doesn't have the opportunity to do the needed map__set_kmap() calls on
the new map.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/lkml/Z7-May5w9VQd5QD0@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/maps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index dffc54a8a29bf3b0..081466b3b4676044 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -948,6 +948,8 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 					maps_by_name[ni] = map__get(new);
 				}
 
+				map__set_kmap(new, maps);
+
 				check_invariants(maps);
 				return err;
 			}
-- 
2.47.0

