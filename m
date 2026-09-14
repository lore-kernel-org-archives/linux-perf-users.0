Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C213254B8;
	Mon, 14 Sep 2026 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368340; cv=none; b=lji9oxaJBjB4dnTgeuP5fKo6yP17JzzJ47hYP01qMucqDlmSGrNv3cNzKgBLvvcCrZiMPhcHlS2LnyeA+ktsDzK6PlLZ/wx863prVMGk/rnf9syQIkLKPbhHiIBnlCo4J5OigSSg4B8C7bGf39Ca2cnYmxVu8bwIm2PD0SG5S/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368340; c=relaxed/simple;
	bh=8nUy9rEnDnjxVxUN8dlsoKrm4I/IhxQzjwtrU+806SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0xn3YC9ND6H+ybrTbMqV4pGBdSmiDO6vYt0FqEY52Sq1ppTD0fOtqR6WfDfFkP8FUyijNbeE8Gw7/R0YF9cZNSgvZ9h8nSEjOj63GplyVkROuFdUODsdxHBvUvQeio/cqqia0G9S+SxYUAM0zn/CSUKFOWDe+JESIiisX0jjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evb/nVM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evb/nVM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB20D1F000FF;
	Mon, 14 Sep 2026 06:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368338;
	bh=3Ad9D0GJs055uDpqusQxbmR/Pk01kwEptH3Ir9c2VJU=;
	h=From:To:Cc:Subject:Date;
	b=Evb/nVM8MSkiqTXgC34AYvvp5ymhALJfcgZnMmlkqWecDrgzIq3Iazhqa1LrAQzyi
	 zOgCXSUc2O2waY4LE7ziRwp6ThB6CYvP7BKw41Mw4FP21+RTnLYOYq5fb+Qeybzx1L
	 kcub3n8k2QD28cp1ffcwqx22XoDnbogCOL2Md7BE5sSgIfZYbp+E+5Ay8eDMQAZpeM
	 GYUmVhOidivQwvuQf3c2LHhWqtaQqBeJ4L2IGMryDSh+lxrYTKcp3oOpvb3FxZcdsK
	 G8OG5EXmAX4igO8T9T+R62rAvd29wvSM31KmpJm78GfIOzSW2K4k7Q2qWmUB6stPT/
	 wlEO0HOZ594Rw==
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
Subject: [PATCH v2 0/4] perf annotate-data: Support flexible array types
Date: Sun, 13 Sep 2026 23:45:31 -0700
Message-ID: <20260914064535.1671939-1-namhyung@kernel.org>
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

v2 changes)
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

Namhyung Kim (4):
  perf annotate-data: Convert type histogram to hashmap
  perf dwarf-aux: Add die_has_flex_array() helper
  perf annotate-date: Allow out-of-size access for flex-array types
  perf annotate-data: Adjust type offset for flex-array

 tools/perf/ui/browsers/annotate-data.c |  10 +-
 tools/perf/util/annotate-data.c        | 209 +++++++++++++++++--------
 tools/perf/util/annotate-data.h        |  10 +-
 tools/perf/util/dwarf-aux.c            |  77 +++++++++
 tools/perf/util/dwarf-aux.h            |   3 +
 5 files changed, 241 insertions(+), 68 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

