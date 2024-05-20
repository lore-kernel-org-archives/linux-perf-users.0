Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA77224F2;
	Mon, 20 May 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196025; cv=none; b=BLhLf+tioIFLiM+yLCFPjNACjm+Oz2bh9Z5jlf2Kl/AY/A2HoeWtY+EC/v7YCoorGRlp9R9ZKhlUJO6gefnEQd3R3nhGSkY8iqgepdcAsQx7Z2Klr1ZgSVjWAhQsfAChEs+atkgVXOCKZFg530BVFTrw21CGRy08vg1K//EH+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196025; c=relaxed/simple;
	bh=r6vs6WErprHBEORgYPyY9YEewKPOmyeTkEiYvvWNVDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bn+cfoi/8sF2Q21mb60tBZ1d5McWq0xJW+LhD3UYTTeoQRzvcA5wBAhdCV+ISgj4+V1ZoSwPnkMhys1TlhkEGtfsIb2NsofHRKo7eruEk03jj6H6OAnfgiG2xUyxN3mUbyATz6Bjw+QpO0LwXWG3uC06kZAGBufEF/6mBfJ0PtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55A2912FC;
	Mon, 20 May 2024 02:07:26 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0D1B3F766;
	Mon, 20 May 2024 02:07:00 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 2/3] perf maps: Remove the kernel text map with maps__remove_maps()
Date: Mon, 20 May 2024 10:06:46 +0100
Message-Id: <20240520090647.949371-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520090647.949371-1-leo.yan@arm.com>
References: <20240520090647.949371-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maps__remove_maps() removes all kernel maps except the text map and eBPF
maps. Afterwards, the kernel text map is removed from the list and
added again with updated information to the maps list.

This commit refactors maps__remove_maps() for deleting the 'map'
parameter, resulting in the removal of all kernel maps from the list.
Thus, the dso__load_kcore() function no longer needs to remove the kernel
text map.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/maps.c   | 4 ++--
 tools/perf/util/maps.h   | 2 +-
 tools/perf/util/symbol.c | 9 +++------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 16b39db594f4..4ddd0d50ac2c 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -589,7 +589,7 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 	return ret;
 }
 
-void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data)
+void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map))
 {
 	struct map **maps_by_address;
 
@@ -597,7 +597,7 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
 
 	maps_by_address = maps__maps_by_address(maps);
 	for (unsigned int i = 0; i < maps__nr_maps(maps);) {
-		if (cb(maps_by_address[i], data))
+		if (cb(maps_by_address[i]))
 			__maps__remove(maps, maps_by_address[i]);
 		else
 			i++;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index d9aa62ed968a..90a1ff8b39c5 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -40,7 +40,7 @@ bool maps__equal(struct maps *a, struct maps *b);
 /* Iterate over map calling cb for each entry. */
 int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data);
 /* Iterate over map removing an entry if cb returns true. */
-void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
+void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map));
 
 struct machine *maps__machine(const struct maps *maps);
 unsigned int maps__nr_maps(const struct maps *maps); /* Test only. */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index c1513976ab6e..915435d55498 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1322,15 +1322,13 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	return 0;
 }
 
-static bool remove_old_maps(struct map *map, void *data)
+static bool remove_old_maps(struct map *map)
 {
-	const struct map *map_to_save = data;
-
 	/*
 	 * We need to preserve eBPF maps even if they are covered by kcore,
 	 * because we need to access eBPF dso for source data.
 	 */
-	return !RC_CHK_EQUAL(map, map_to_save) && !__map__is_bpf_prog(map);
+	return !__map__is_bpf_prog(map);
 }
 
 static int dso__load_kcore(struct dso *dso, struct map *map,
@@ -1385,7 +1383,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	maps__remove_maps(kmaps, remove_old_maps, map);
+	maps__remove_maps(kmaps, remove_old_maps);
 	machine->trampolines_mapped = false;
 
 	/* Find the kernel map using the '_stext' symbol */
@@ -1422,7 +1420,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	 * remaining maps so vmlinux gets split if necessary.
 	 */
 	map_ref = map__get(map);
-	maps__remove(kmaps, map_ref);
 
 	map__set_start(map_ref, map__start(replacement_map));
 	map__set_end(map_ref, map__end(replacement_map));
-- 
2.34.1

