Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6B13775E
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jul 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721495815; cv=none; b=kAzgljgU0TuXMiOex5GArXRLAzM7IOKRpjS+DrkMLtuZit8CpVjfoQZ1XE2YWkw6R5ko/kVEANXeRIWYScfkSM4md/vo/EurDJHG0JCZQOoYY3ip9zgsaX+h14ERzkBrc5V33gbSv5Oi5n5gXhEovQOvA4P2meALaflFOxVJGOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721495815; c=relaxed/simple;
	bh=MSkj1FU95Vj8NE4p6a1G3EOVDESOU7DWFPD9xcsyy5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSLx0/RGSsZUUVtfhJmi2cSczqaEAisiFeFuKjHZ20rrcclnP3S9VY63vSNywVS0hvjp0ujPbsuqcyT6emnE98io+izH8SBS849lpq5lQxwCqRYTCHu5aecDz082E5aPQfVQ/c2mSfBEHdUBMQGmyplBk9KZlhD++QMcE1NKfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ktpaRkaD; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ktpaRkaD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721495804; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ijaBbm+sLjyFLd06Is/ZAeSnXD6WcOWo8+Qqu1Q2gkM=;
	b=ktpaRkaDAIKXjj3OGGQ/yZ1ZnbsmUC2a6dTe4Sd3oQsXA5ej/nDU2XHnZm0am6wBXrdWhpG6A3dFlgHWUmzB1cVhEFLHgde0HSZC9hzBpN3QnJoVLqnS38yiqRdrO5J+pCqdyLyJ82+ryksBv60hXAXdLnhyvDZnFbGCO6mU0JM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAuswhj_1721495795;
Received: from localhost.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WAuswhj_1721495795)
          by smtp.aliyun-inc.com;
          Sun, 21 Jul 2024 01:16:43 +0800
From: cp0613@linux.alibaba.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com
Cc: linux-perf-users@vger.kernel.org,
	"Chen Pei" <cp0613@linux.alibaba.com>
Subject: [PATCH] perf test: Fix perf-record on Yocto
Date: Sun, 21 Jul 2024 01:16:29 +0800
Message-ID: <20240720171629.716-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chen Pei" <cp0613@linux.alibaba.com>

There is a perf test case: PERF_RECORD_* events & perf_sample fields,
which will fail on the system built by Yocto, and the log is as follows:

  # perf test -v 5
    5: PERF_RECORD_* events & perf_sample fields                       :
  --- start ---
  test child forked, pid 2341
  Using CPUID 0x5b7-0x0-0x0
  mmap size 1052672B
  2095118675900 0 PERF_RECORD_COMM exec: sleep:2342/2342
  2095119056100 0 PERF_RECORD_MMAP2 ...: r-xp /bin/sleep.coreutils
  2095119387900 0 PERF_RECORD_MMAP2 ...: r-xp /lib/ld-2.33.so
  2095119814200 0 PERF_RECORD_MMAP2 ...: r-xp [vdso]
  2095122676300 0 PERF_RECORD_MMAP2 ...: r-xp /lib/libc-2.33.so
  2096139253600 0 PERF_RECORD_EXIT(2342:2342):(2341:2341)
  PERF_RECORD_MMAP for sleep missing!
  test child finished with -1
  ---- end ----
  PERF_RECORD_* events & perf_sample fields: FAILED!

This is because the sleep command provided by coreutils in the Yocto
environment is actually sleep.coreutils, that is:

  # which sleep
  /bin/sleep
  # ls -l /bin/sleep
  lrwxrwxrwx 1 root root 20 Mar  9  2018 /bin/sleep -> /bin/sleep.coreutils

So, just add the condition of sleep.coreutils to found_coreutils_mmap.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/perf/tests/perf-record.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 1c4feec1adff..7b189723d3cf 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -259,7 +259,8 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 						if (!found_cmd_mmap)
 							found_cmd_mmap = !strcmp(bname + 1, cmd);
 						if (!found_coreutils_mmap)
-							found_coreutils_mmap = !strcmp(bname + 1, "coreutils");
+							found_coreutils_mmap = !strcmp(bname + 1, "coreutils") ||
+												   !strcmp(bname + 1, "sleep.coreutils");
 						if (!found_libc_mmap)
 							found_libc_mmap = !strncmp(bname + 1, "libc", 4);
 						if (!found_ld_mmap)
-- 
2.17.1

