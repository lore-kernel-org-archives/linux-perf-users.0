Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A653DB960;
	Mon, 12 Oct 2026 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848819; cv=none; b=HjQ52J4nAioJ8roYfD6x3hLjg/HP4kvPxGNVoIlSZq+1mCVkMRD/wkLwSYuvXgOHD1bG4iqTWmuWV3Kg58cD8O6lYmNtghSXJx+omfLDCumbh9XDqArk6uLb3R+oGrQjNZavj+mDwMB1XSNt0gg3AiDwMAsHVKlmyfC1Srof+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848819; c=relaxed/simple;
	bh=s36LHh8gKa9HmJq5UT53os6RPOEgo0Yu9yMYdcbU14Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0shz96GyRnpJgOgenQrZGvve8LD2LQkzg7/BAa+Yri+tEZ7WXIETcTZ259XYez+LdiItA3B1ji2qm2S8iMAZ8ZulzPijvzW9rDTKYgGvMUsjtCR/9IAuTA302BRXS39cvlDoznxfI+vzYA3UgGvaiafKqoKNlMbYIt1kbrKFZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VadAOUFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VadAOUFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DBE1F008A1;
	Mon, 12 Oct 2026 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848818;
	bh=EvfKAlmfLmTZWjmnC1MQzCa9C3gTY0EOiVM6ZpYM8Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VadAOUFA6Odo5nKJIA66XaYO2n/iNr3imwfYIwHQFHTEfC9/yEfadpUnKPf0EzTjX
	 r3GcCeoFw6FK5y8MNOXJGQeCSxumh69cv2GMWHZtkLXa0sj2LGKdBfli39HgiD8ZKu
	 tJzmbmbTh+0rwkusqH3oRbiCAmd+g2rf1MFqzHdp3u33YVZkVF+AqZ01zR/J985Awq
	 g0JggKvvfSruPBtWRO5ADow3n4PAn4l4oXLa6ggNMQG2WVMYiidpEv4D/JaGCDJZPQ
	 RdkDqrJjHPZRve48K2rvH/yv73Ivj9KKT6gMYjJyeiS+NyV6NzkSDDSEdfbxBXVfHm
	 Vx7NLSGJ+OZsg==
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
Subject: [PATCH v4 01/10] perf tools: Remove redundant dso data init
Date: Mon, 12 Oct 2026 16:46:45 -0700
Message-ID: <20261012234654.60666-2-namhyung@kernel.org>
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

The fd and status are initialized later with cache.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d3017c82ffb5f4b1..df03f84c9723560e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1722,8 +1722,6 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->srclines = RB_ROOT_CACHED;
 		dso->data_types = RB_ROOT;
 		dso->global_vars = RB_ROOT;
-		dso->data.fd = -1;
-		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
-- 
2.56.0.385.gd3acb90ef8-goog

