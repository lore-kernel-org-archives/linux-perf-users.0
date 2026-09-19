Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F9353A77;
	Sat, 19 Sep 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789799877; cv=none; b=KNted0fvu/1doBuKnmAO+X8Hn+zIPIiW4digPuGigSB9tldIEgkIEASh86wUAspr2poQYiVgKdXu4fnNbdML47+8R4+0iopI0ECajyasZqRxfWpTfUsuxCzkYIrwunmvyh9cQo72LqiuevGtbZ1xsoYJG8dFqS6Tzpj7dIC0uNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789799877; c=relaxed/simple;
	bh=uwSeor+GxRHyFDG8v5RBQ+0GNd7HI+8O7BHFPURDeKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRMhxhBPn76WuijuolcKXHMvP84NhUlICVROlSNsMOZXQrwNTRMdJfjnuFQFX8DUQRDI8y9P/nJ3TX9cyOr/YeECJp5w4YZXPdudMrzGnwZQFVvh7rZWrxRGb8hTwr2wuqR9XY1+R2ycIgXI6AudZe2o4V9Y7IVzEXUyzLvsPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0eo1LZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0eo1LZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7974E1F000FF;
	Sat, 19 Sep 2026 06:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789799872;
	bh=g/H9Kd0jsfScLIess5rkfbljn8Wm8hYevA0AKttYwF8=;
	h=From:To:Cc:Subject:Date;
	b=F0eo1LZLp6z5yBcG5yGG5pkYhAWv5q+939ePpjVOnF0AVUEWtfWk4T19LwTQgiw/T
	 p13LVDTjSz4NbJfTKLei0z2N+LN/HnXhslQxtlm0RrUT9f1Y7cQd/NxdifCvdwDjwg
	 Svu7cyHVcl7d8eTlufgT4phNRy9X8zNMB+l/fVhLXFdxOkH314WHJ0ieCbpEnEnaiE
	 gKyXmkn0oThVPiHIHdqDLZpErJ1f7mcYrtjljm/PwPzJNFVhL3PsfVRe3Y9fHWYmYb
	 J384jwT3Q8DwUqeMiuFuhwe1L+1pRjk6Nvu3gl/io0HsXFVNqhLa8tq5d/4L851lrJ
	 bJof2mZRZ8U0Q==
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
Subject: [PATCH v5 0/4] perf annotate-data: Support flexible array types
Date: Fri, 18 Sep 2026 23:37:41 -0700
Message-ID: <20260919063745.48444-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
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

v5 changes)

 * add a cleanup patch
 * add is_union and is_flex_array fields to find member correctly

v4: https://lore.kernel.org/r/20260916061926.2224222-1-namhyung@kernel.org/

 * update last member even if the offset is same
 * handle type qualifiers in die_has_flex_array()
 * add zero-length array members as flexible arrays
 * check return value of strbuf_init() for type name

v3: https://lore.kernel.org/r/20260915064035.1970175-1-namhyung@kernel.org

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

Namhyung Kim (4):
  perf dwarf-aux: Add die_has_flex_array() helper
  perf annotate-data: A small cleanup in __add_member_cb()
  perf annotate-data: Allow out-of-size access for flex-array types
  perf annotate-data: Adjust type offset for flex-array

 tools/perf/util/annotate-data.c | 192 ++++++++++++++++++++++++--------
 tools/perf/util/annotate-data.h |   6 +
 tools/perf/util/dwarf-aux.c     | 107 ++++++++++++++++++
 tools/perf/util/dwarf-aux.h     |   3 +
 4 files changed, 262 insertions(+), 46 deletions(-)

-- 
2.55.0

