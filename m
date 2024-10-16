Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A11BBBC8;
	Wed, 16 Oct 2024 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059847; cv=none; b=O/tWLXsPZQVfUQ9of3kmRYoNNqxkJFSFBOBIkH9M3/ATK8DHwWrFTzewsWkq4DrasKjZAJs/N1c3/rk8zArlVhOtKo4h3McYALgvbP3DO6IaqFKJxmvH0HPrqouJPRJGnvgrZLEaLhF3pFMwnWhapkQHEHks7h2LL0TVq2FlD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059847; c=relaxed/simple;
	bh=YduFT+h2EYjPQi9RMbXm5/YsBmtNRq8tS/1Xljb0YZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEyZ7QuyZICwbeWwAOzAVHHoaGd65PcQ1fogDz1gWG6CTW5jGaPDfXmz2Ws9cf2CfaLc9v9P5J9WSIi7F0ysaFdKylVa7xZmoxZQB8ZaNon5P+9KU8ecSu9E8zsMw6AyQGKldFvaxpPtemeJ+0zIu+hyyrcPsZ+dHQBlSYDVZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnfM4iAb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnfM4iAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693CEC4AF0D;
	Wed, 16 Oct 2024 06:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059847;
	bh=YduFT+h2EYjPQi9RMbXm5/YsBmtNRq8tS/1Xljb0YZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnfM4iAbkoaUIgyh5gSZ5Hn57ueylPwic4tvZdeiXbWpSFCGjpkjAentiAoCW41Jj
	 /GAgLKgRpNQbQ2YQWR8sYsN1QuPr9mN56RAnhucROVeB6WWjGgw6K3pd5L8+FIgnJU
	 ZAHIaY5XKj9YhBC3cZRf4etRHi69YvSMnid/4eWKw/pXr93K8fWefWhd5Ztk2wAiYD
	 zGZcVYmXOUPN7K+Qi/+FsOo3L9PPbhw1GTHeLw+GAJWwKXotC/X8ImYxlFYvf+WTGW
	 cHyHy+7/wgeVv6BjGt5s+bYFRnVAcxxnX9LC0AfLrTIBN0b4LNM2moo8jzujSYPp/x
	 7i2+nH0FEKt9Q==
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
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v5 8/9] perf record: Just use "cycles:P" as the default event
Date: Tue, 15 Oct 2024 23:23:58 -0700
Message-ID: <20241016062359.264929-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241016062359.264929-1-namhyung@kernel.org>
References: <20241016062359.264929-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fallback logic can add ":u" modifier if needed.

Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c1f4c..f8325247292112d7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4157,9 +4157,7 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-
-		err = parse_event(rec->evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		err = parse_event(rec->evlist, "cycles:P");
 		if (err)
 			goto out;
 	}
-- 
2.47.0.rc1.288.g06298d1525-goog

