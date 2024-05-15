Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B3E15B554;
	Wed, 15 May 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807472; cv=none; b=njDWhgrt5Vr82N0oMARQ15kh0lTRgxFcPgkrF3foIpVVAlU4N4kckkzsKkMOzuGsY3mbyyqF1kbJ0oKHsHWelMF9N7qffQMFmHR/tb/HqdAmXKY0gkUK8CC5YtKqmHqUDUn386m/FACpkfeRR51Ok7gjYBTO5EHsq3ySnTPR0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807472; c=relaxed/simple;
	bh=6NiV8lMSfEqda6TLVZB7QbPpPh0hi2mYIQL4qTTbKvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XY7j9ubRNK/wEPijJkv96Kt7pelczo2gUNzD8eQU0zvLPLfpq9WSb9/LajPOF/iy9bwPl9DvETFgvnuuyNE0EpCBFx456doOpGiWQHp1yYtVTHZJjojZpfOEcquvvh2fhsJQdcqyf2x6rMYJ+Wse0hrNk3PEO7BQJcSn8zJqVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 970071042;
	Wed, 15 May 2024 14:11:34 -0700 (PDT)
Received: from PF4Q20KV.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 970F83F7A6;
	Wed, 15 May 2024 14:11:07 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 2/2] perf maps: Remove the replacement of kernel map
Date: Wed, 15 May 2024 22:10:45 +0100
Message-Id: <20240515211045.377080-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515211045.377080-1-leo.yan@arm.com>
References: <20240515211045.377080-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the kcore maps are organized in ordering, the kernel text section
will be respected when merging into the kernel maps. As a result, it is
no need to replace the kernel text section specially.

This commit removes the code for replacement of the kernel text section.
With this change, the final maps has a minor difference - it separates
the kernel map [_stext.._end] into two sections:

  [_stext.._edata] and [_edata.._end]

As result, it still keeps the intact info for the kernel regions.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/symbol.c | 67 +++++-----------------------------------
 1 file changed, 8 insertions(+), 59 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index c1513976ab6e..0712d3a6893f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1338,12 +1338,10 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
-	struct map *map_ref, *replacement_map = NULL;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
 	char kcore_filename[PATH_MAX];
-	u64 stext;
 
 	if (!kmaps)
 		return -EINVAL;
@@ -1388,52 +1386,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	maps__remove_maps(kmaps, remove_old_maps, map);
 	machine->trampolines_mapped = false;
 
-	/* Find the kernel map using the '_stext' symbol */
-	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
-		u64 replacement_size = 0;
-		struct map_list_node *new_node;
-
-		list_for_each_entry(new_node, &md.maps, node) {
-			struct map *new_map = new_node->map;
-			u64 new_size = map__size(new_map);
-
-			if (!(stext >= map__start(new_map) && stext < map__end(new_map)))
-				continue;
-
-			/*
-			 * On some architectures, ARM64 for example, the kernel
-			 * text can get allocated inside of the vmalloc segment.
-			 * Select the smallest matching segment, in case stext
-			 * falls within more than one in the list.
-			 */
-			if (!replacement_map || new_size < replacement_size) {
-				replacement_map = new_map;
-				replacement_size = new_size;
-			}
-		}
-	}
-
-	if (!replacement_map)
-		replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
-
-	/*
-	 * Update addresses of vmlinux map. Re-insert it to ensure maps are
-	 * correctly ordered. Do this before using maps__merge_in() for the
-	 * remaining maps so vmlinux gets split if necessary.
-	 */
-	map_ref = map__get(map);
-	maps__remove(kmaps, map_ref);
-
-	map__set_start(map_ref, map__start(replacement_map));
-	map__set_end(map_ref, map__end(replacement_map));
-	map__set_pgoff(map_ref, map__pgoff(replacement_map));
-	map__set_mapping_type(map_ref, map__mapping_type(replacement_map));
-
-	err = maps__insert(kmaps, map_ref);
-	map__put(map_ref);
-	if (err)
-		goto out_err;
-
 	/* Add new maps */
 	while (!list_empty(&md.maps)) {
 		struct map_list_node *new_node = list_entry(md.maps.next, struct map_list_node, node);
@@ -1441,17 +1393,14 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 		list_del_init(&new_node->node);
 
-		/* skip if replacement_map, already inserted above */
-		if (!RC_CHK_EQUAL(new_map, replacement_map)) {
-			/*
-			 * Merge kcore map into existing maps,
-			 * and ensure that current maps (eBPF)
-			 * stay intact.
-			 */
-			if (maps__merge_in(kmaps, new_map)) {
-				err = -EINVAL;
-				goto out_err;
-			}
+		/*
+		 * Merge kcore map into existing maps,
+		 * and ensure that current maps (eBPF)
+		 * stay intact.
+		 */
+		if (maps__merge_in(kmaps, new_map)) {
+			err = -EINVAL;
+			goto out_err;
 		}
 		free(new_node);
 	}
-- 
2.34.1

