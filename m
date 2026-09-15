Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EC400E1A;
	Tue, 15 Sep 2026 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454441; cv=none; b=aPWmFj1Md/WO6FLy1KhkxQ9dhZB3UiPeARiZDLq2tNjp9zhLP//kNmWBChFK6PFvcBGyy9DzUFwxLhAvv5y0D1Vh+UiiwAr5crVTBmqrLhpRF0XGCyYs+HhcavtopHLZ34yfrwsHYBZ+FMpTIC9RRjPiCdhUcaXIMT8IulJYGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454441; c=relaxed/simple;
	bh=odMh36Hi3+sZidnwcQ/5vDdoVLrteY3kmjEOJkYEDvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBQJmsCxfyDK2YQizec1+CXHyqBvyRBS6ZcU/GPbRMIf6R4tYYdeAOr0WIWEe1LVEBt8J/E1OxWudzl57AggocW1V+pJxVwQZP1T10vtLht+PQW9CIbqgSNi0IULkq9LWYmvxXRhb00LtQvvvGmD6F8z4GMQaShKmDpYjD2lh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0czMT9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0czMT9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81AD1F000FF;
	Tue, 15 Sep 2026 06:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789454440;
	bh=BqCt//Qzq6e2iRgC4WLtg6r0GuVGsoll3LXjbWa93CQ=;
	h=From:To:Cc:Subject:Date;
	b=o0czMT9jnMqnolrWTSv0AuffmkV3Syi+2ztblvv8qDhL3QHXJ7Jz2CPQnYSTKflsw
	 dWYsGXl6MFeI6tuhwz1w6Y8YslNiiWHU5UthdCQzV4115/n5wUmgwl9P2O0rTVPnnd
	 MGb8mDPoh0zm2t0wmxipjlaJArxkp+uScd5zN4FJEIypuWinBWqexxr6ksroqGi+YS
	 s4n7ym7mwXQ8d11mlapym61hkiy1+RSVRAqSSytuntt3EWz30oylYt6X1iLMZKYt0L
	 A3Rdj065TBAkHLGnjmHEDjMUmXrh1ZvNBlSYclANXLxcT61Pz6+Vsnev8jQhuJ93p2
	 9nIV9bQuMgSrg==
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
Subject: [PATCH v3 0/3] perf annotate-data: Support flexible array types
Date: Mon, 14 Sep 2026 23:40:32 -0700
Message-ID: <20260915064035.1970175-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The flexible arrays are dynamically allocated with different size.  So checking
with the original type size won't match and cannot find the type if the offset
is bigger than the size.  This patch series detects those flex-arrays and allows
accesses beyong the original size.

I'm not sure what's the best way to add test codes for data type profiling as it
seems we need to add a lot more workloads for different cases.  Probably we may
want to split the workloads as separate binaries.

v3 changes)

 * patch 1 was merged!
 * check if last member is found
 * check member location when finding flex-array
 * ensure member typename is initiailized
 * fix a bug to pass a wrong type in check_variable()
 * fix a typo in a comment

v2: https://lore.kernel.org/r/20260914064535.1671939-1-namhyung@kernel.org

 * fix missing index increment in the histogram
 * support flex array in union types
 * add recursion check in die_has_flex_array()
 * check negative index arrays properly
 * avoid divide-by-zero when the size is unknown

v1: https://lore.kernel.org/r/20260912054706.1475583-1-namhyung@kernel.org

Thanks,
Namhyung


Cc: Zecheng Li <zli94@ncsu.edu>
Cc: Yanbo Zhao <yzhao62@ncsu.edu>
Cc: Tengda Wu <wutengda@huaweicloud.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>

Namhyung Kim (3):
  perf dwarf-aux: Add die_has_flex_array() helper
  perf annotate-date: Allow out-of-size access for flex-array types
  perf annotate-data: Adjust type offset for flex-array

 tools/perf/util/annotate-data.c | 140 ++++++++++++++++++++++++--------
 tools/perf/util/annotate-data.h |   2 +
 tools/perf/util/dwarf-aux.c     |  97 ++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h     |   3 +
 4 files changed, 206 insertions(+), 36 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

