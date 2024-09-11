Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A6192D70;
	Wed, 11 Sep 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057170; cv=none; b=Aho0ol10fqC+JM4nrEpSwLpTvCMHeIWJdo2qEvpZfDldxPP4gfE5TyQY52eaAVYAe9t+ZkahX29md8LDgiRb5bBw38+w4VKJyeVydoZvNWTIXIvMblu+GIzaucxCEwuVrG1r+IijVcGN5qXsZfjK3Goe1tNKVe5a/e+BcFNwSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057170; c=relaxed/simple;
	bh=zjgTFkbhBZJgxzCKrV8cItHcbprgYE9tCUOWc6Nr870=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlCNoFoKyHodU7PWTKb98tjiujcwQ9QObKsnywupWdw4ABQt7UpZlfVrZypdZq6tlrNq/tm9rRevj2+3Se48LOkJ+YfrPORuz2Wety2ZHbIuvRZZMhP5F7v1ngCBoTPJMoBZRnrk7Ds8nxMAWiUGZt+Z3S1lPjF/j7WX+WdOaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6F90106F;
	Wed, 11 Sep 2024 05:19:57 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30F923F66E;
	Wed, 11 Sep 2024 05:19:26 -0700 (PDT)
From: Levi Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	james.clark@linaro.org,
	irogers@google.com,
	asmadeus@codewreck.org
Cc: nd@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH RESEND 2/2] perf stat: Stop repeating when ref_perf_stat() returns -1
Date: Wed, 11 Sep 2024 13:19:19 +0100
Message-Id: <20240911121919.4167483-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911121919.4167483-1-yeoreum.yun@arm.com>
References: <20240911121919.4167483-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exit when run_perf_stat() returns an error to avoid continuously
repeating the same error message. It's not expected that COUNTER_FATAL
or internal errors are recoverable so there's no point in retrying.

This fixes the following flood of error messages for permission issues,
for example when perf_event_paranoid==3:
  perf stat -r 1044 -- false

  Error:
  Access to performance monitoring and observability operations is limited.
  ...
  Error:
  Access to performance monitoring and observability operations is limited.
  ...
  (repeating for 1044 times).

Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
---
 tools/perf/builtin-stat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 954eb37ce7b8..18197ded88a7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2875,7 +2875,10 @@ int cmd_stat(int argc, const char **argv)
 			evlist__reset_prev_raw_counts(evsel_list);

 		status = run_perf_stat(argc, argv, run_idx);
-		if (forever && status != -1 && !interval) {
+		if (status == -1)
+			break;
+
+		if (forever && !interval) {
 			print_counters(NULL, argc, argv);
 			perf_stat__reset_stats();
 		}
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

