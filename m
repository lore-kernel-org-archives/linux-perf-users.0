Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E635684;
	Mon, 28 Apr 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847481; cv=none; b=N03Lj94xD5bC70tvbginZ/EoQ+JmTRhlIJQv9+052lTpJAf0BT0E0dI/NMMXyvKHyUyJdby0rw4GuK2lrMDjZoXRjVDgxYHeBZP4a66TGHDggikCo5mTCnvdjse8sAb6akjVDc7EPMGWpdFDNE7zivtfqtFus04zYxHHLPM7IBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847481; c=relaxed/simple;
	bh=M6Rg0zKulNc6IXpnDsEVE7uz+vhsGFcLQO0KqpPQnCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZURX6f4PEBSoH6a0538zwf5ItvTuNkuDFd3qoj7D1F2B96Gy+D5js5E9mpH1JWuieO/1dS1Yinfa62DsnxVfdAtZncIFg8GhAhvn60EtUVVBnYJttFk6+IlTaEKyAMgi2yuyft/wqiI4xRhRyu2L2iE2aG+lqGqZP9NUHnxH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C6F71516;
	Mon, 28 Apr 2025 06:37:52 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C79D3F673;
	Mon, 28 Apr 2025 06:37:56 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] libperf: Grant write permission for user page
Date: Mon, 28 Apr 2025 14:37:45 +0100
Message-Id: <20250428133745.1435742-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf runs in overwrite mode, the ring buffer is mapped read-only.

On the other hand, the first page in the ring buffer is for user page,
which is used for exchanging parameters between the kernel and the
userspace.  The read-only permission causes Segmentation fault with
command:

  $ perf record --overwrite -a -e cs_etm//
    perf: Segmentation fault

This patch grants write permission for the mapped user page so the
userspace tool can update info properly.

Fixes: d1a177595b3a ("libperf: Adopt perf_evlist__mmap()/munmap() from tools/perf")
Reported-by: Tomas Glozar <tglozar@redhat.com>
Closes: https://lore.kernel.org/linux-perf-users/20250428124727.GE551819@e132581.arm.com/T/#t
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/perf/mmap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index c1a51d925e0e..7c0748a9d79f 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -4,6 +4,7 @@
 #include <asm/bug.h>
 #include <errno.h>
 #include <string.h>
+#include <unistd.h>
 #include <linux/ring_buffer.h>
 #include <linux/perf_event.h>
 #include <perf/mmap.h>
@@ -45,6 +46,21 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 		return -1;
 	}
 
+	/*
+	 * In overwrite mode, pages are mapped as read-only.  Fix the permission
+	 * to make the user page writable, as the tool needs to update
+	 * information (e.g., aux_offset/aux_size) into it.
+	 */
+	if (mp->prot == PROT_READ) {
+		const long page_sz = sysconf(_SC_PAGE_SIZE);
+
+		if (mprotect(map->base, page_sz, mp->prot | PROT_WRITE) < 0) {
+			munmap(map->base, perf_mmap__mmap_len(map));
+			map->base = NULL;
+			return -1;
+		}
+	}
+
 	map->fd  = fd;
 	map->cpu = cpu;
 	return 0;
-- 
2.34.1

