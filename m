Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF3722EF0;
	Mon, 20 May 2024 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196026; cv=none; b=i5PkztlW2kpqb5pcUHe1tf52slJnwRLxhMXyRjVFFoagIxzz1s1EH5OgJsQgsCgeC6tiXRpE2GVFH8SAGFmUsQVQck3W3hwwFEm/rI3cSvKmD4bIOdZRLetFh1s9FA6KL1IQZj8+Aj2ZbRdMT0t8pS4WruTkjii924qyrxjvEis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196026; c=relaxed/simple;
	bh=eSfP27lDKsXBvxkbyHXFa4R7oLkedFcDJYbv4hCgpxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rwq+SnYZnvpeZKIkKJyETzmlvRf298XbzGMtvnUGMbq1lF+2f08hJm8DXDQsFBG1qJYf67Kuwq1Ngw7zluMEz4LOB8MW8wSBG/SDMSEtjBVU796NkhcVI/FM1NHZMZvqR9U4vIIITIPySRXhGOVNrMtBrBw8rbGF8vDCvxD0Ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10713FEC;
	Mon, 20 May 2024 02:07:28 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C8123F766;
	Mon, 20 May 2024 02:07:02 -0700 (PDT)
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
Subject: [PATCH v3 3/3] perf maps: Remove the replacement of kernel map
Date: Mon, 20 May 2024 10:06:47 +0100
Message-Id: <20240520090647.949371-4-leo.yan@arm.com>
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

The kernel text map has been removed from the kernel maps by
maps__remove_maps(), and the kcore maps are organized in order, allowing
us to achieve neat kernel maps.

As a result, it is not necessary to replace the old kernel text map.
Instead, the commit finds the latest text map, assigns it to
'machine->vmlinux_map', and releases the old map.

One concern is if a platform fails to find a kernel text map after
updating maps list with kcore, in this case, it should not happen and
reports the failure.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/symbol.c | 77 ++++++++++------------------------------
 1 file changed, 19 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 915435d55498..a4b65d868fc9 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1335,13 +1335,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
 	struct maps *kmaps = map__kmaps(map);
+	struct map *vmlinux_map;
 	struct kcore_mapfn_data md;
-	struct map *map_ref, *replacement_map = NULL;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
 	char kcore_filename[PATH_MAX];
-	u64 stext;
 
 	if (!kmaps)
 		return -EINVAL;
@@ -1386,51 +1385,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	maps__remove_maps(kmaps, remove_old_maps);
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
@@ -1438,21 +1392,28 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
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
 
+	/* Update vmlinux_map */
+	vmlinux_map = maps__find(kmaps, map__start(map));
+	if (vmlinux_map) {
+		free(machine->vmlinux_map);
+		machine->vmlinux_map = vmlinux_map;
+	} else {
+		pr_err("Failed to find vmlinux map from kcore\n");
+		goto out_err;
+	}
+
 	if (machine__is(machine, "x86_64")) {
 		u64 addr;
 
-- 
2.34.1

