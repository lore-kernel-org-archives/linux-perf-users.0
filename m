Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292832076D3
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378537; cv=none; b=lJmZEJA+1wmu8x821VFMHQBipImpkqqUPk7n2rVlyprao6pVnwmjxD7Q2nPIOqZytpaksHLbd2leYMkOVXi2+1AVGydcsUjps/waefk9RB540GZhvJg8zYrz4mK1H/HVVR7BRImIXps3JPvhGo6MyXY3nPxMxApMuV6O7iFdyn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378537; c=relaxed/simple;
	bh=WNzIMDWQdxkcsvqN3S+237dyecY9CfJTYr/6Ew976Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpZ4oe+jNBsJ5GVqBhwoyGdDWaxPUtQzdXmSyJ14/IdY7ky8n4Tt/y317kwDdioRle07VwOu7N0YNbfxJ2kGxv8WlsvSl1vzT/QgDhcXiNXTW9lnio6J2nAOVJLiV+6yplmvgFkfQFVZm0FUBjNoBdzFPTz0SrShfZOf85LGGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DcH0CnzE; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DcH0CnzE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731378529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ND5todS9J9CstKjvKk5frxUAvHZOaVKj6kMybP6v2zM=;
	b=DcH0CnzErClR0dSEkYzLHHr0JbD1GFA6aXQqwU5/TjQfdzAk+uF/vI0/qSwWfc82mU+sMY
	IQLonj1Sk2+Q3a/T6nQ3z/RTpxzQ3UA8i0ionhwUkqpdVKGUPlZd27ELxPHsHQLR3x51bH
	1TYKw/J1PePf9cISq8lI+fcq38bSzL4=
From: Hao Ge <hao.ge@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] perf bpf-filter: Return -1 directly when pfi allocation fails
Date: Tue, 12 Nov 2024 10:28:15 +0800
Message-Id: <20241112022815.191201-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Directly return -1 when pfi allocation fails,
instead of performing other operations on pfi.

Fixes: 0fe2b18ddc40 ("perf bpf-filter: Support multiple events properly")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 tools/perf/util/bpf-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index e87b6789eb9e..34c8bf7e469e 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -375,7 +375,7 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 	pfi = zalloc(sizeof(*pfi));
 	if (pfi == NULL) {
 		pr_err("Cannot save pinned filter index\n");
-		goto err;
+		return -1;
 	}
 
 	pfi->evsel = evsel;
-- 
2.25.1

