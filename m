Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1516C451;
	Tue,  7 May 2024 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091201; cv=none; b=tVq3Hd2lC+1mH/bEl69B4w1PgBgQvWUw4KW+R+33lFqFeRWszNTlgo+IDvClBBDUWEHXeJjz47cvZ0ylcLQ+Icayao8i9i9ccvMiuOp+LTlNqM/H3L5FoMteuWMyIdXW/Up4jkV01k5Gf3QPJD+8DSWQB28+r+jDUHljFj6PTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091201; c=relaxed/simple;
	bh=FPYdBnC0kccxQTzIc3GnR8aqAfAzYDsn2eFN0I7vXyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b36N5FPsx5JDmlFawbl3Ld800MlStSi9q7z+HH+xy8Cir/jjCXiWfKMTPgqRwH68YvKtQUqOKC6yBPbNYGaeQASVxhIqGHoMKvVwO1/zacN6dJ6zd5VvUj18j00EkhbNkYwJ4oKsToJ1hy4ffh5bKlwjv5Pv7apPhpCVRiQ5q3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E964106F;
	Tue,  7 May 2024 07:13:25 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CDB13F6A8;
	Tue,  7 May 2024 07:12:57 -0700 (PDT)
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
Subject: [PATCH 1/4] perf symbols: Remove map from list before updating addresses
Date: Tue,  7 May 2024 15:12:05 +0100
Message-Id: <20240507141210.195939-2-james.clark@arm.com>
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

Make the order of operations remove, update, add. Updating addresses
before the map is removed causes the ordering check to fail when the map
is removed. This can be reproduced when running Perf on an Arm system
with a static kernel and Perf uses kcore rather than other sources:

  $ perf record -- ls
  $ perf report

  util/maps.c:96: check_invariants: Assertion `map__end(prev) <=
    map__start(map) || map__start(prev) == map__start(map)' failed

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/symbol.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7772a4d3e66c..2d95f22d713d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1377,13 +1377,15 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		if (RC_CHK_EQUAL(new_map, replacement_map)) {
 			struct map *map_ref;
 
-			map__set_start(map, map__start(new_map));
-			map__set_end(map, map__end(new_map));
-			map__set_pgoff(map, map__pgoff(new_map));
-			map__set_mapping_type(map, map__mapping_type(new_map));
 			/* Ensure maps are correctly ordered */
 			map_ref = map__get(map);
 			maps__remove(kmaps, map_ref);
+
+			map__set_start(map_ref, map__start(new_map));
+			map__set_end(map_ref, map__end(new_map));
+			map__set_pgoff(map_ref, map__pgoff(new_map));
+			map__set_mapping_type(map_ref, map__mapping_type(new_map));
+
 			err = maps__insert(kmaps, map_ref);
 			map__put(map_ref);
 			map__put(new_map);
-- 
2.34.1

