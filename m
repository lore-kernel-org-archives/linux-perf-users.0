Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5381A2C12;
	Mon, 30 Sep 2024 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727711; cv=none; b=IECXjmKb4umVuPWRT8W+ua4b4NzKh15ICgbtD3dWSm4gduGsO40EO8SWm7AS7s/hUpwklXFCX4rtLJKCVLda/jNx21TYFWD5zUHFMXUNAkvvsGbmHS77JpgwLOgjbG7pbXG4+8o9dnZg6OLLPGfJ9KfQcz6NR3W93m/iqrqeSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727711; c=relaxed/simple;
	bh=jXqXcgNnUwt+jkY243np7C+vQy3arGQQ55B/TLigoVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbU9Nur82wZ3vWppdPsO5E+qMTDVuTeXlQ+pPQqoXM75DxGNcD1ylYTvHVYb8n152xmGqVxidCC7IpcWQMVCbOnyJCQxt7XEYNaQhV5ObQ2C1xud+JQq9JJ90AUYxdKXxVYJESQrarWixBS70JUxb15KVs8XpWXjBZSaF8JCbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sroRbiPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sroRbiPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A3DC4CED0;
	Mon, 30 Sep 2024 20:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727727711;
	bh=jXqXcgNnUwt+jkY243np7C+vQy3arGQQ55B/TLigoVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sroRbiPBFlbFvfzFIpGIRVrfeFxiEg7cJyFsUMF/lANT04JXkufAE25iXedPIAnRk
	 +3fe6eAwM064ehIU3nrNCm7Ifb0MBD2uoOrmiuO42r32p2qIwKRDfA7H6jHmHex0Wo
	 znTFxdw6uFbEWvTEeeKbA4sL3uUCy/90kEojiTQWleROgFw8tfxhniYpB0UCKup/iV
	 UZgxUegYRQYzXEuAA870xk3cgK7UVqNCNf7ktWBed8Ts3QHvTVWE5WKCDW+xRA1WWN
	 7coOyMPmki34GF6/XVPZHvwGR2l11U4oI7Hf8AbMyPR33AhMTR5McBkF7wg/yWBEH3
	 5fRYXa1MHmg6Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] perf tools: Cope with differences for lib/list_sort.c copy from the kernel
Date: Mon, 30 Sep 2024 17:21:36 -0300
Message-ID: <20240930202136.16904-3-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202136.16904-1-acme@kernel.org>
References: <20240930202136.16904-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With 6d74e1e371d43a7b ("tools/lib/list_sort: remove redundant code for
cond_resched handling") we need to use the newly added hunk based
exceptions when comparing the copy we carry in tools/lib/ to the
original file, do it by adding the hunks that we know will be the
expected diff.

If at some point the original file is updated in other parts, then we
should flag and check the file for update.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../check-header_ignore_hunks/lib/list_sort.c | 31 +++++++++++++++++++
 tools/perf/check-headers.sh                   |  5 ++-
 2 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/check-header_ignore_hunks/lib/list_sort.c

diff --git a/tools/perf/check-header_ignore_hunks/lib/list_sort.c b/tools/perf/check-header_ignore_hunks/lib/list_sort.c
new file mode 100644
index 0000000000000000..32d98cb34f80a987
--- /dev/null
+++ b/tools/perf/check-header_ignore_hunks/lib/list_sort.c
@@ -0,0 +1,31 @@
+@@ -1,5 +1,6 @@
+ // SPDX-License-Identifier: GPL-2.0
+ #include <linux/kernel.h>
++#include <linux/bug.h>
+ #include <linux/compiler.h>
+ #include <linux/export.h>
+ #include <linux/string.h>
+@@ -52,6 +53,7 @@
+ 			struct list_head *a, struct list_head *b)
+ {
+ 	struct list_head *tail = head;
++	u8 count = 0;
+ 
+ 	for (;;) {
+ 		/* if equal, take 'a' -- important for sort stability */
+@@ -77,6 +79,15 @@
+ 	/* Finish linking remainder of list b on to tail */
+ 	tail->next = b;
+ 	do {
++		/*
++		 * If the merge is highly unbalanced (e.g. the input is
++		 * already sorted), this loop may run many iterations.
++		 * Continue callbacks to the client even though no
++		 * element comparison is needed, so the client's cmp()
++		 * routine can invoke cond_resched() periodically.
++		 */
++		if (unlikely(!++count))
++			cmp(priv, b, b);
+ 		b->prev = tail;
+ 		tail = b;
+ 		b = b->next;
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 55aba47e5aec9292..f1080d4096663ba1 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -193,7 +193,6 @@ check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
 check include/linux/ctype.h	      '-I "isdigit("'
 check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
-check lib/list_sort.c		      '-I "^#include <linux/bug.h>"'
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/x86/entry/syscalls/syscall_32.tbl
@@ -211,6 +210,10 @@ done
 check_2 tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
 check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
 
+# Files with larger differences
+
+check_ignore_some_hunks lib/list_sort.c
+
 cd tools/perf || exit
 
 if [ ${#FAILURES[@]} -gt 0 ]
-- 
2.46.0

