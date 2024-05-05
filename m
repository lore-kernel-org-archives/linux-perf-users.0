Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9E56D1A8;
	Sun,  5 May 2024 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714940933; cv=none; b=I7KB4qm9mnS1/uZ6lrwj7MdydxENAzilmk8Ibi27LsR5Sz/KbvCWEw3nelFWqVcNhoiDzLDWvlk0mB2BKET9aJZN8Tyty8V3IAFsBh6b6eH44qB2HkfvdWWsHVRe8zwQF9OknKS09gK/Ps1ViF9nAfUEEwkJ34AsPK5mk8/zSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714940933; c=relaxed/simple;
	bh=uESbJ3gRnZBQpJ7WWb9YkLM+GSeZA1GW9OYoZk1ZIRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CGabTcdwGx3pL1LzBbP98dQN/qFefrtC14M1a0NxkWVZk1ScUzEgFMJIzF48p7cIFC1hen5jOFz5lSh54HIknsZrswl2f4hDuklgeMR+v49ahuiGwD0w6lws5+TtvDz4Ouax/YybhJT7w0SGZrhU8a4HCTBldSZei0MTrIPv0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 698F51007;
	Sun,  5 May 2024 13:29:10 -0700 (PDT)
Received: from PF4Q20KV.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 305723F793;
	Sun,  5 May 2024 13:28:42 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf maps: Process kcore maps in order
Date: Sun,  5 May 2024 21:28:05 +0100
Message-Id: <20240505202805.583253-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Arm64, after enabling the 'DEBUG=1' build option, the tool exits
abnormally:

  # ./perf report --itrace=Zi10ibT
  # perf: util/maps.c:42: check_invariants: Assertion `map__end(prev) <= map__start(map) || map__start(prev) == map__start(map)' failed.
    Aborted

The details for causing this error are described in below.

Firstly, machine__get_running_kernel_start() calculates the delta
between the '_stext' symbol and the '_edata' symbol for the kernel map,
alongside with eBPF maps:

  DSO              | Start address      | End address
  -----------------+--------------------+--------------------
  kernel.kallsyms    0xffff800080000000   0xffff800082229200
  bpf_prog           0xffff800082545aac   0xffff800082545c94
  ...

Then, the perf tool retrieves kcore maps:

  Kcore maps       | Start address      | End address
  -----------------+--------------------+--------------------
  kcore_text         0xffff800080000000   0xffff8000822f0000
  vmalloc            0xffff800080000000   0xfffffdffbf800000
  ...

Finally, the function dso__load_kcore() extends the kernel maps based on
the retrieved kcore info. Since it uses the inverted order for
processing the kcore maps, it extends maps for the vmalloc region prior
to the 'kcore_text' map:

  DSO              | Start address      | End address
  -----------------+--------------------+--------------------
  kernel.kallsyms    0xffff800080000000   0xffff800082229200
  kernel.kallsyms    0xffff800082229200   0xffff800082545aac -> Extended for vmalloc region
  bpf_prog           0xffff800082545aac   0xffff800082545c94
  ...

  DSO              | Start address      | End address
  -----------------+--------------------+--------------------
  kernel.kallsyms    0xffff800080000000   0xffff8000822f0000 -> Updated for kcore_text map
  kernel.kallsyms    0xffff800082229200   0xffff800082545aac
  bpf_prog           0xffff800082545aac   0xffff800082545c94
  ...

As result, the two maps [0xffff800080000000..0xffff8000822f0000) and
[0xffff800082229200..0xffff800082545aac) are overlapping and triggers
failure.

The current code processes kcore maps in inverted order. To fix it, this
patch adds kcore maps in the tail of list, afterwards these maps will be
processed in the order. Therefore, the kernel text section can be
processed prior to handling the vmalloc region, which avoids using the
inaccurate kernel text size when extending maps with the vmalloc region.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/symbol.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9ebdb8e13c0b..e15d70845488 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1266,7 +1266,24 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	map__set_end(list_node->map, map__start(list_node->map) + len);
 	map__set_pgoff(list_node->map, pgoff);
 
-	list_add(&list_node->node, &md->maps);
+	/*
+	 * Kcore maps are ordered with:
+	 *   [_text.._end): Kernel text section
+	 *   [VMALLOC_START..VMALLOC_END): vmalloc
+	 *   ...
+	 *
+	 * On Arm64, the '_text' and 'VMALLOC_START' are the same values
+	 * but VMALLOC_END (~124TiB) is much bigger then the text end
+	 * address. So '_text' region is the subset of the vmalloc region.
+	 *
+	 * Afterwards, when dso__load_kcore() adjusts kernel maps, we must
+	 * process the kernel text size prior to handling vmalloc region.
+	 * This can avoid to using any inaccurate kernel text size when
+	 * extending maps with vmalloc region. For this reason, here it
+	 * always adds kcore maps to the tail of list to make sure the
+	 * sequential handling is in order.
+	 */
+	list_add_tail(&list_node->node, &md->maps);
 
 	return 0;
 }
-- 
2.43.0

