Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B294CEE66
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350345; cv=none; b=NvZruttp0i7VNXAWFIEwLb07XCPLBTar/9Gb1SXg98NzHLomkEJ+CLWD0Ws1T2J8GEu+dEe9wrzlbo1RbDM+cWVH36Q8vfdEwI1ojVUrCHYEJGUuqDaMIoHllVOwfbGRVlHsKlq4bo98Tku6l7lLcFjWDnx1zE0PrwYrTvlRjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350345; c=relaxed/simple;
	bh=qdtxKzZT9BZZ2bPZqqQHJCD2k+8XPa/aDrr1I28Mkig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ws6Wqpn+DKCAhP0oer9hXByv7kNDY6b0J3tC8yj5DkhUQ4VXDJAB2T0MtTW/Yix0RfDV4Pql4iG+gkCJ27noxbP3uDfSp2NEHBGmOmQOKhXKWavzez/FqXbGX10BZvH6KpH87EH8SIU1fXQdznngMrE8ZiuBrG3f/A1eaVWET4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8JNQD4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8JNQD4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514081F000FF;
	Fri, 25 Sep 2026 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350342;
	bh=2xHn4L3mFmWpVAUw1jtB6BbnVdQEjmmeYQa84hzgmm8=;
	h=Date:From:To:Cc:Subject;
	b=m8JNQD4/JYcBaFGB71r+i7gqtTmGtNeUDHY8xKfXhfTNXXhacZ3S1k0P9ZeM4Fawd
	 D21kkAZjVT0mUqRyZW2+/5NgMEz9IMfmY1EW/rVDTjBLmj5qC3cBKEuoH/QlDtq1OI
	 6/DMtCuoh4KwDV5DxzoqSrmblIOpQAHvNkpQ3hmpuxMS7sqS4Uf+RsNcpeCEqrWaR8
	 Deqo3P3ktRCK/UvL3loolcohs21NgbO8YtBi0oGg0ZzjBGvv0N6oBzfXlv3EPnze5b
	 6ouCtSwoaWxKfoFgKvfvtsKNm0EeWG97f12njC0ApBIMILl87EsmIaahYQT8qIAdcw
	 f7CqjWr/0ukTw==
Date: Fri, 25 Sep 2026 17:32:18 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH 1/1] perf test workload: Use unsigned int in code_with_type
 instead of uint
Message-ID: <araUAt-S6YM_bbAf@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The declaration of the Rust helper test_rs() uses "uint", a BSD-ism
that lives in <sys/types.h>, so on glibc it is only visible by
accident: glibc's <stdlib.h> includes <sys/types.h>, where uint is
exposed under __USE_MISC, which is on by default.

musl does none of that: its <stdlib.h> doesn't include <sys/types.h>
and it typedefs uint there only when _GNU_SOURCE/_BSD_SOURCE is
defined, while nothing else in this translation unit includes
<sys/types.h>. Building it on Alpine therefore fails with:

  tests/workloads/code_with_type.c:9:21: error: unknown type name 'uint'; did you mean 'int'?
  tests/workloads/code_with_type.c:39:17: error: implicit declaration of function 'test_rs' [-Wimplicit-function-declaration]

The second error is a consequence of the first one: with the
declaration at line 9 rejected, the call at line 39 has no prototype,
which is an error since gcc 14.

The breakage is only visible when rustc is present, because
tests/workloads/Build adds code_with_type.o when CONFIG_RUST_SUPPORT
is detected, and tools/build/feature only checks for "rustc
--version". That is why alpine:3.23 and alpine:3.24 fail while
alpine:3.22 and alpine:edge, lacking rustc, build fine and hide it.

Use unsigned int, which needs no header at all.

Fixes: 2e05bb52a12d3 ("perf test workload: Add code_with_type test workload")
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/workloads/code_with_type.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/workloads/code_with_type.c b/tools/perf/tests/workloads/code_with_type.c
index 65d7be7dac24d411..d2d437b86e0c6dbd 100644
--- a/tools/perf/tests/workloads/code_with_type.c
+++ b/tools/perf/tests/workloads/code_with_type.c
@@ -6,7 +6,7 @@
 #include <linux/compiler.h>
 #include "../tests.h"
 
-extern void test_rs(uint count);
+extern void test_rs(unsigned int count);
 
 static volatile sig_atomic_t done;
 
-- 
2.55.0

