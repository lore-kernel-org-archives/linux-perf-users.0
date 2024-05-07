Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE0616D32E;
	Tue,  7 May 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091213; cv=none; b=JLzbQVTh4g7WQ3NKCxqwxdaDs065pWALb3NcrpHnn46TL8f7zW1hEMaC7m7gjr6JU8MaQd30TR6TPAiYyD8iwz0XXinPoGx87xb8nXbMaeCoNZYNiVQDvOADKn7APmlna/rRj0hJ4mpgy/69UR/Zu3PvdX4UxJzD01CcSFoOw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091213; c=relaxed/simple;
	bh=j60Lp76p4GCMge0RHYRlaMeijthkr1haXgYWLgtV6oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IO6emxOByH9u6Q5Bv/0eVVneLeR4EvvE5zZhrGZjEQjwvBrQWX5lKm+K1NiJnZ1lzm7tgIPvC/W8JqbfmDYFmG+cpIePwm5T79L9sxKIz4g7HmFnF/RnNRRW941uNh54lfBHvrogx2HeOKft7rlosPJinhC4kD7u3/TNvLn2S+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498F51516;
	Tue,  7 May 2024 07:13:33 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 687C93F6A8;
	Tue,  7 May 2024 07:13:05 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	atrajeev@linux.vnet.ibm.com,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] perf symbols: Update kcore map before merging in remaining symbols
Date: Tue,  7 May 2024 15:12:07 +0100
Message-Id: <20240507141210.195939-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507141210.195939-1-james.clark@arm.com>
References: <20240507141210.195939-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When loading kcore, the main vmlinux map is updated in the same loop
that merges the remaining maps. If a map that overlaps is merged in
before kcore, the list can become unsortable when the main map addresses
are updated. This will later trigger the check_invariants() assert:

  $ perf record
  $ perf report

  util/maps.c:96: check_invariants: Assertion `map__end(prev) <=
    map__start(map) || map__start(prev) == map__start(map)' failed.
  Aborted

Fix it by moving the main map update prior to the loop so that
maps__merge_in() can split it if necessary.

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/symbol.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2d95f22d713d..e98dfe766da3 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1289,7 +1289,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
-	struct map *replacement_map = NULL;
+	struct map *map_ref, *replacement_map = NULL;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1367,6 +1367,24 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	if (!replacement_map)
 		replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
 
+	/*
+	 * Update addresses of vmlinux map. Re-insert it to ensure maps are
+	 * correctly ordered. Do this before using maps__merge_in() for the
+	 * remaining maps so vmlinux gets split if necessary.
+	 */
+	map_ref = map__get(map);
+	maps__remove(kmaps, map_ref);
+
+	map__set_start(map_ref, map__start(replacement_map));
+	map__set_end(map_ref, map__end(replacement_map));
+	map__set_pgoff(map_ref, map__pgoff(replacement_map));
+	map__set_mapping_type(map_ref, map__mapping_type(replacement_map));
+
+	err = maps__insert(kmaps, map_ref);
+	map__put(map_ref);
+	if (err)
+		goto out_err;
+
 	/* Add new maps */
 	while (!list_empty(&md.maps)) {
 		struct map_list_node *new_node = list_entry(md.maps.next, struct map_list_node, node);
@@ -1374,24 +1392,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 		list_del_init(&new_node->node);
 
-		if (RC_CHK_EQUAL(new_map, replacement_map)) {
-			struct map *map_ref;
-
-			/* Ensure maps are correctly ordered */
-			map_ref = map__get(map);
-			maps__remove(kmaps, map_ref);
-
-			map__set_start(map_ref, map__start(new_map));
-			map__set_end(map_ref, map__end(new_map));
-			map__set_pgoff(map_ref, map__pgoff(new_map));
-			map__set_mapping_type(map_ref, map__mapping_type(new_map));
-
-			err = maps__insert(kmaps, map_ref);
-			map__put(map_ref);
-			map__put(new_map);
-			if (err)
-				goto out_err;
-		} else {
+		/* skip if replacement_map, already inserted above */
+		if (!RC_CHK_EQUAL(new_map, replacement_map)) {
 			/*
 			 * Merge kcore map into existing maps,
 			 * and ensure that current maps (eBPF)
-- 
2.34.1

