Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1557191F94;
	Wed, 16 Sep 2026 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539569; cv=none; b=VSoQON+LhRfLZ8CqFjvTLFMpfBEInAe3uZgRIwyLEjHlF/Np7NJ6brabCFSJlYb/W1M8Eq4Yaea2QnKnzWDm7D5yddZOK/M845da6CslZDF8ekfxxq9+anD/kVFj756PbXIQAU1VjHQdPiFz7euGZVP5QXOzg60jNlfQUt6gxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539569; c=relaxed/simple;
	bh=WMJB9Tacr/a+ZjEE6lvRn0YKH9n/AF/iWqPpgdVM4Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNXJc1nBm9UyUWg/qgpvd+2dEMUSoTBrhToCdxxv+35NAwWSfmjOIfTrfpnLuyVyi73xsaNNa+uCAnRnCQowVHUsydwD83KnTOHuSqHxexXy4wpX7G6Lk9+19Zzb8T9SHeIpiqx9N1y9U9bKg4cLfx/laqs0LyCQkYkGmJ9TVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRWI2rv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRWI2rv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6591F000FF;
	Wed, 16 Sep 2026 06:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539568;
	bh=j1JyzVCWJuhPxGnc42l8VAE5toyWNZr1IJ5KAeq1PbA=;
	h=From:To:Cc:Subject:Date;
	b=mRWI2rv2HNvomnmc7vxg24yX1R7IgTSZqs4iXvNozWOHfpA7YkPyg/j4n5dS898s8
	 8jrDI60ubmDnvG1XCSN9/7ED4rfQRmPTdgIWSn+dIHgpxa7dtqdrFXQQ7ef7mx5VOD
	 uevtvywV3MDkqMuyIYACkJv68CRaadVlt+nAYt1gdOIIOg2YuNtXpNDrQruXj7j2tu
	 Ur/Wd+4OUAHihftNSHrz1nfU/NEZrkPGnwm5n0KpCgHAZ2Yk3OVG4+Ko8bAdXiS1ke
	 valHc10+XkKCAdm7lUsLKJW3kOY0NxgUD+YzcnMm1dRAnGEYONPwj1syEHwzly3yTk
	 dEhOh3b5XOW5A==
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
Subject: [PATCH v4 0/3] perf annotate-data: Support flexible array types
Date: Tue, 15 Sep 2026 23:19:23 -0700
Message-ID: <20260916061926.2224222-1-namhyung@kernel.org>
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
with the original type size won't match and cannot find the type if the offset
is bigger than the size.  This patch series detects those flex-arrays and allows
accesses beyong the original size.

I'm not sure what's the best way to add test codes for data type profiling as it
seems we need to add a lot more workloads for different cases.  Probably we may
want to split the workloads as separate binaries.

v4 changes)

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

Namhyung Kim (3):
  perf dwarf-aux: Add die_has_flex_array() helper
  perf annotate-date: Allow out-of-size access for flex-array types
  perf annotate-data: Adjust type offset for flex-array

 tools/perf/util/annotate-data.c | 146 ++++++++++++++++++++++++--------
 tools/perf/util/annotate-data.h |   2 +
 tools/perf/util/dwarf-aux.c     | 107 +++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h     |   3 +
 4 files changed, 221 insertions(+), 37 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

