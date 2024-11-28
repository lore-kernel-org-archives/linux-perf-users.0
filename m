Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C605847B;
	Thu, 28 Nov 2024 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755806; cv=none; b=E0sexGRNeQJf2ebNG6qjhpUbP8TxPmhteEdo66i5SLlvoZ/9pQLw102+5s681hx7KFIQG4FxMG17AOhDHEJIOAepXgwZnmV78wOLpAU0/jB1uZIH7p9DVEOsjZmMRA80xZiS1nFvrzqjcJU7sJd2Z7pwUBZowQ6uG++AKIIfHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755806; c=relaxed/simple;
	bh=k+4jUneAouhf8w7ycfvP0Gbm6jCVYSw81dtHzGqHtY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cV9R8OGb2UzG3+LH0yz51w6ZufaXG6nPwGLBrbzq5eJRI8PITz9DixkPELHPp7Wgt1geDVMBNeBO9KHCI/g0JC9Fg8CfXf4dI+ZtNCegrAWT45bxFmF9uOKVhBQqlZYQydvhHQc8x3RDW93YGj19TlN8K6NlPQp3A2QztfGyJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cioKCThR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cioKCThR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE01C4CECC;
	Thu, 28 Nov 2024 01:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732755806;
	bh=k+4jUneAouhf8w7ycfvP0Gbm6jCVYSw81dtHzGqHtY4=;
	h=From:To:Cc:Subject:Date:From;
	b=cioKCThRkflOqTpzusgvl8soPcXcI/rmTj65RQIVjQWY9ES6q7krgIS/imG7KIcFV
	 Yu1dXUjONX6ddSZK4kI+Ee9e/QGtJkNloCA5R/VIs/CJezqYQOobiqk94kIbeILKPw
	 4yOa9gmhvgup5rjKaSsSua+P4ijsfQOqXUlRPnI3lsAjzE6jYabpEm88dGmxpuPtxG
	 NbzDgipsmhE0NSWOGfG8Mt0hvAOyOYBv3l6nd3lp3ynOg98mBuiwZptz/jasbuZr0D
	 MVw88njNDFwtxqcnfJJOQfwUjP+Gpp7tdOVZSRy+NoJvhwMLSVlz7ZN7wuLK/4P3M/
	 SlfWQp2EtK70w==
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
Subject: [PATCH v2] perf tools: Avoid unaligned pointer operations
Date: Wed, 27 Nov 2024 17:03:25 -0800
Message-ID: <20241128010325.946897-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sample data is 64-bit aligned basically but raw data starts with
32-bit length field and data follows.  In perf_event__synthesize_sample
it treats the sample data as a 64-bit array.  And it needs some trick
to update the raw data properly.

But it seems some compilers are not happy with this and the program dies
siliently.  I found the sample parsing test failed without any messages
on affected systems.

Let's update the code to use a 32-bit pointer directly and make sure the
result is 64-bit aligned again.  No functional changes intended.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) use '%' instead of '/' to check alignment

 tools/perf/util/synthetic-events.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a58444c4aed1f1ea..6923b0d5efede4a7 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1686,12 +1686,16 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 	}
 
 	if (type & PERF_SAMPLE_RAW) {
-		u.val32[0] = sample->raw_size;
-		*array = u.val64;
-		array = (void *)array + sizeof(u32);
+		u32 *array32 = (void *)array;
+
+		*array32 = sample->raw_size;
+		array32++;
+
+		memcpy(array32, sample->raw_data, sample->raw_size);
+		array = (void *)(array32 + (sample->raw_size / sizeof(u32)));
 
-		memcpy(array, sample->raw_data, sample->raw_size);
-		array = (void *)array + sample->raw_size;
+		/* make sure the array is 64-bit aligned */
+		BUG_ON(((long)array) % sizeof(u64));
 	}
 
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
-- 
2.47.0.338.g60cca15819-goog

