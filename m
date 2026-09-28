Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEB4ACC61
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596966; cv=none; b=B/ww5XgSuJo8P7o3k5nH2jq4t086n6j4zf/0oz2UX/dtP8TsMOUoK5b5f/ASUnBJXjcQDSS32eE8w6bnRpO8dy0pfUUQsL6ZERwxSTPoNFyfeCy/1h69L0qGVsWN2bTN/VmBz7+ADJhcg2vCLK0+Zn6wLVzHYVO/RO3PLBKHjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596966; c=relaxed/simple;
	bh=3c7j06e54Ei02r4oldQW5omlP8sS/cdvCd6EjNFc+QY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=scxYGT9R7BUqoA3homO1402wwA+nDXatIFCon7iSnv1KBKMq20GQ7XSYfx+ADZb6j3ZkutlPEbJgVZqQ36EyzOQSd6I/81UyNFkHUlUhwgtNGI5Mx6x4gt0i5SfeuCaZufBWF3Ylon3NjdCmBlZfbsV5usfOyy0KyrfKr7AUvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXT9YfsJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXT9YfsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDE71F000FF;
	Mon, 28 Sep 2026 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790596964;
	bh=BSdIfyVcwSjOe8VMw+KJxNXldOLLrD6XfhF/bBlcgzk=;
	h=Date:From:To:Cc:Subject;
	b=hXT9YfsJRsET1JK+Xw5ZYl9Lt5ik6axg2TXom/78vguFldqUKv8U5uIlyF+bhFPqR
	 I95BVWhxW0f78nzUrNUvwXHfG+9PDh/Sr/vwm83sUmup13pRmeDhaiRTGXEVF5Da2B
	 7uyOnwiLGs2Xivc/bELnVELtPzrptnC6espw4eVZoAnMyJKMGOG97QBHDD8qeVymA3
	 t0BIxYAZQzYD3ZC7iLbk2YfV6bGgj9TKVRzG+dxpRLSnvYNOwX2hL8SLGmmzf6ojn0
	 uPJdHaE0rKihAwnvHQhDJvrYesAYl/0VE/biWkBG6zsixV97RBOBnzlZCSHJCd/qko
	 jHCjnLOWfDvxQ==
Date: Mon, 28 Sep 2026 14:02:41 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools feature gettid: Undef _GNU_SOURCE before defining
 it
Message-ID: <arpXYeRUu3B-ouqB@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since most of tools/build/feature/test-*.c feature tests are included in
tools/build/feature/test-all.c, we can't just define _GNU_SOURCE as it
may already been defined and this will break the build with:

  acme@alta:~$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
  In file included from test-all.c:26:
  test-gettid.c:3:9: error: "_GNU_SOURCE" redefined [-Werror]
      3 | #define _GNU_SOURCE
        |         ^~~~~~~~~~~
  In file included from /usr/include/python3.13/pyconfig.h:9,
                   from /usr/include/python3.13/Python.h:14,
                   from test-python-module.c:2,
                   from test-all.c:14:
  /usr/include/aarch64-linux-gnu/python3.13/pyconfig.h:1810:10: note: this is the location of the previous definition
   1810 | # define _GNU_SOURCE 1
        |          ^~~~~~~~~~~
  cc1: all warnings being treated as errors
  acme@alta:~$

I.e. pyconfig.h is included by the new test-python-module.c, that is at
the start of test-all.c, defines _GNU_SOURCE, noticed on Debian 13
(/usr/include/aarch64-linux-gnu/python3.13/pyconfig.h, libpython
3.13.5-2+deb13u5), and then test-all.c includes test-gettid.c that was
defining it as well, undef it first as does several other tests.

Fixes: 1b7e0280e247b93d ("perf Makefile: Update Python script installation path")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-gettid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/build/feature/test-gettid.c b/tools/build/feature/test-gettid.c
index ef24e42d3f1b877d..a8fdb26196697b66 100644
--- a/tools/build/feature/test-gettid.c
+++ b/tools/build/feature/test-gettid.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#undef _GNU_SOURCE
 #define _GNU_SOURCE
 #include <unistd.h>
 
-- 
2.55.0

