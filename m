Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B005326DD;
	Wed, 23 Sep 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176923; cv=none; b=NmjfdW+Ya3tPzkFJrICyZ/YSYAqTsfwpoR20VL1fjDHVdAq8WB7xWlivvwdKTACrMtJHvmkHpjv4ddJuQp+mkXXsdi+5fA5zK8zKBWysdL9Uhg01TgUU/1xWI0/qZnRJ0wMEzJ0E0uQnamc/1BD4AqDk31AEywZ0Enko6Ktk9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176923; c=relaxed/simple;
	bh=jr6rgp9BDzG3S84HnXLYb8kzpUHgSQc0QYp/oTK+hI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBL4VIkGfB9Yj94twvGuB6GAVn4aD56Lz7Cg9DTNROlQBGN4h8HosGysakMZ+0bxILG31H3ciCp5S0QyQuS6fmYAsZKxz2f+ba1jhLgDUWqCRqepTs6r12sLwIqYsTguR2iRNGKlYT/UhTCeKdAnqWuy3i76Ms30GAloikzAMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y76lsS2v; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y76lsS2v"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53DC31713;
	Wed, 23 Sep 2026 08:21:57 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963D53F86F;
	Wed, 23 Sep 2026 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176920; bh=jr6rgp9BDzG3S84HnXLYb8kzpUHgSQc0QYp/oTK+hI0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y76lsS2vlpiBJlvAoy5NTL2bfGWEGaYAxPfGCjNUiJqHltYPezc4IUYV6cMnMKldR
	 3toCC+toUqR/IFZMOYmr5glCSL3pR03ujsmlMgEc2AqlVmu7Wm+6SfUxapUIMI+E6S
	 pcqepA1hyb2mJ54Eqy3tj4jFVGMabBrMHlmIEroM=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:42 +0100
Subject: [PATCH v2 02/14] perf intel-pt: Preserve return addresses for
 asynchronous branches
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-2-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=1356;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=jr6rgp9BDzG3S84HnXLYb8kzpUHgSQc0QYp/oTK+hI0=;
 b=/FYgfBXt1MezJNB+vTU67BSfL2iiVIcoKpoywwZv6tbuqnER+TXCPg1oaMMchEoJMPlpF9ioj
 hEmsnyAO5GoCUvJHIgQ1hjqZG660JLE1f9a85rEwIY45hyAPYpCQsvh
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Intel PT uses a zero instruction length for asynchronous branches so
the thread stack resumes at the source IP. A dlfilter can fetch the
instruction before call/return processing and replace that zero with
its opcode length, advancing the saved return address.

Set sample.ret_addr to sample.ip for asynchronous branch samples so
instruction fetching cannot change the return address. This also
covers asynchronous trace-end samples and VM exits.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/intel-pt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 8c21c9f52d572d2dd4e15b3b5c341b253ccea1b5..e8b9c8a67b0a0635e0110eda4b6ccb2511132fc7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1803,6 +1803,13 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 	perf_sample__init(&sample, /*all=*/true);
 	intel_pt_prep_b_sample(pt, ptq, event, &sample);
 
+	/*
+	 * For asynchronous branches, use the sample IP as the return address
+	 * instead of advancing it during instruction decoding.
+	 */
+	if (sample.flags & PERF_IP_FLAG_ASYNC)
+		sample.ret_addr = sample.ip;
+
 	sample.id = ptq->pt->branches_id;
 	sample.stream_id = ptq->pt->branches_id;
 

-- 
2.34.1

