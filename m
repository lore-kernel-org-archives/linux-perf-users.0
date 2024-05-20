Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8FE17582;
	Mon, 20 May 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196022; cv=none; b=Qzfk1QepbOndRGkggKfNUIoRqeXQAaiDsOFN/EwTeVUjvDGdzx3b3Ua8Fw4oxrXK/0mRp6Csu5qd+BevzWbJiJC0et7K1+8eq3GuOF/5/JASEW2rrM+EP0gJLc4dVd0RVpd0Nu764/tb7xzrjOwnP1nxF5q9nMPfwAWpmZqLVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196022; c=relaxed/simple;
	bh=WyFMRDi/bs5IDpAIMfC56d+PwBTs80Y/L12c4A53rFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDGPGu2BRnqG7RuWj5sbscl0NPMSbBI8kWgMhF7tGrH+i+w9QUSJ4ERUxHjVGh/9U6Vp+0Hn2lG2k8BKFPCZvD5RyaV4mtVMoxdcH2bTJ7DqxoTnKrPgOlGvzDj1wanPqwrIJQ4sRcozwVsp+tnRr6qHNwXNXM6FTT6byrd1lXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98EB31063;
	Mon, 20 May 2024 02:07:24 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2057E3F766;
	Mon, 20 May 2024 02:06:59 -0700 (PDT)
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
Subject: [PATCH v3 1/3] perf maps: Sort kcore maps
Date: Mon, 20 May 2024 10:06:45 +0100
Message-Id: <20240520090647.949371-2-leo.yan@arm.com>
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

When merging kcore maps into the kernel maps, it has an implicit
requirement for the kcore maps ordering, otherwise, some sections
delivered by the kcore maps will be ignored.

Let's see below example:

  Ordering 1:
  Kcore maps       | Start address      | End address
  -----------------+--------------------+--------------------
  kcore_text       | 0xffff800080000000 | 0xffff8000822f0000
  vmalloc          | 0xffff800080000000 | 0xfffffdffbf800000

  Ordering 2:
  Kcore maps       | Start address      | End address
  -----------------+--------------------+--------------------
  vmalloc          | 0xffff800080000000 | 0xfffffdffbf800000
  kcore_text       | 0xffff800080000000 | 0xffff8000822f0000

The 'kcore_text' map is a subset of the 'vmalloc' map. When merging
these two maps into the kernal maps with the maps__merge_in() function,
the ordering 1 inserts the 'kcore_text' map prior to the 'vmalloc' map,
thus the 'kcore_text' map will be respected. On the other hand, if maps
are inserted with the ordering 2, the 'vmalloc' is inserted ahead, as a
result, its subset map will be ignored afterwards.

To merge the maps in a reliable way, this commit sorts the kcore maps
before merging them. Besides sorting the maps based on the end address,
it also gives the priority to a subset map to insert it before its
superset map in the list.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/symbol.c | 50 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9e5940b5bc59..c1513976ab6e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1256,6 +1256,7 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 {
 	struct kcore_mapfn_data *md = data;
 	struct map_list_node *list_node = map_list_node__new();
+	struct map_list_node *node;
 
 	if (!list_node)
 		return -ENOMEM;
@@ -1269,8 +1270,55 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	map__set_end(list_node->map, map__start(list_node->map) + len);
 	map__set_pgoff(list_node->map, pgoff);
 
-	list_add(&list_node->node, &md->maps);
+	list_for_each_entry(node, &md->maps, node) {
+		/*
+		 * When the new map (list_node)'s end address is less than
+		 * current node, it can be divided into three cases.
+		 *
+		 * Case 1: the new map does not overlap with the current node,
+		 * as the new map's end address is less than the current node's
+		 * start address.
+		 *                      [*******node********]
+		 *    [***list_node***] `start              `end
+		 *    `start          `end
+		 *
+		 * Case 2: the new map overlaps with the current node.
+		 *
+		 *        ,start              ,end
+		 *        [*******node********]
+		 *    [***list_node***]
+		 *    `start          `end
+		 *
+		 * Case 3: the new map is subset of the current node.
+		 *
+		 *        ,start              ,end
+		 *        [*******node********]
+		 *         [***list_node***]
+		 *         `start          `end
+		 *
+		 * For above three cases, insert the new map node before the
+		 * current node.
+		 */
+		if (map__end(node->map) > map__end(list_node->map))
+			break;
+
+		/*
+		 * When the new map is subset of the current node and both nodes
+		 * have the same end address, insert the new map node before the
+		 * current node.
+		 *
+		 *        ,start              ,end
+		 *        [*******node********]
+		 *            [***list_node***]
+		 *            `start          `end
+		 */
+		if ((map__end(node->map) == map__end(list_node->map)) &&
+		    (map__start(node->map) <= map__start(list_node->map)))
+			break;
+	}
 
+	/* Insert the new node (list_node) ahead */
+	list_add_tail(&list_node->node, &node->node);
 	return 0;
 }
 
-- 
2.34.1

