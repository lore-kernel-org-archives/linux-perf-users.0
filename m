Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3B2C3251;
	Sat, 12 Sep 2026 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192031; cv=none; b=Imn4XEsuzntOLHB43j3HFHR2ERLb56X0mlI4Q6N2Tah8UDM9JiMrFEmtdn73WBUMMCm/wcR/1An8OYLmQfCx7Qvb1+eQD2lUKFLJuW0x9VDYVNGQ7lPLje8TrBBEcFs2PSnh0735XyynBvCGAMtmYsbr50dPHXwOryB/8FDfAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192031; c=relaxed/simple;
	bh=wbALB+P/n6+D5E3k+DwxJSR6GBEdaf9n0qGWy6O02hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDCyip4mFO+u7oEhaBeCKrTXMNA8dw0XCpZiWK35rmtBWydIEwSRYTzUDYVUHDhsUyXnGN/GgGO9U7gly+7wIKw4dTHpP5TC+Yj1m2SWRzdKelDWpumNkAbXjukuTDaWhXVKkK+tYunu34QBULraovTQR0O1QIHeuTJadNxqyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFf/wJKH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFf/wJKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62841F000FF;
	Sat, 12 Sep 2026 05:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789192030;
	bh=uNK9hE2bCV4rOoiH5G8sV/37BeoD+5r/+xuxjjN/A+o=;
	h=From:To:Cc:Subject:Date;
	b=GFf/wJKH9hMUFCr9Uf0AHmT7qyVY4OUfDTa9M9sgZcdw0duDDmGKd0Qal+cjwq9hq
	 ObFyRThk1r+8QabJ1YDbPSZvU4i4zIbY7sVFLUdJPHE9TPVcLnx39cb3LWrSp1vd61
	 dO/NI9DDsI6QbK7THI/9PGIhAaHv7QDJ4+D6BE62AoPWiT1G/BinE2jZVRwL5Iu5vr
	 okyq8yLjQY+rKN5qf1gaWImnUKTNo+AYRRtb1C7QHgWtrOPRdPYFenBykk1YyId8Y1
	 TdP3GxNwZKQTj+OPp2txYElLEtUcsuKsqxhv/OGhGLrCKi9yII0nzFLhAUK6Go1Bxn
	 J0rwru8tiIz0A==
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
	Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH 0/4] perf annotate-data: Support flexible array types
Date: Fri, 11 Sep 2026 22:47:02 -0700
Message-ID: <20260912054706.1475583-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The flexible arrays are dynamically allocated with different size.  So checking
with the original type size won't match and cannot match the sample.  This patch
series detects those flex-arrays and allows accesses beyond the original size.

I'm not sure what's the best way to add test codes for data type profiling as it
seems we need to add a lot more workloads for different cases.  Probably we may
want to split the workloads as separate binaries.

Thanks,
Namhyung


Cc: Zecheng Li <zli94@ncsu.edu>
Cc: Yanbo Zhao <yzhao62@ncsu.edu>
Cc: Tengda Wu <wutengda@huaweicloud.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>

Namhyung Kim (4):
  perf annotate-data: Convert type histogram to hashmap
  perf dwarf-aux: Add die_has_flex_array() helper
  perf annotate-date: Allow out-of-size access for flex-array types
  perf annotate-data: Adjust type offset for flex-array

 tools/perf/ui/browsers/annotate-data.c |  11 +-
 tools/perf/util/annotate-data.c        | 167 +++++++++++++++++++------
 tools/perf/util/annotate-data.h        |  10 +-
 tools/perf/util/dwarf-aux.c            |  57 +++++++++
 tools/perf/util/dwarf-aux.h            |   3 +
 5 files changed, 202 insertions(+), 46 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

