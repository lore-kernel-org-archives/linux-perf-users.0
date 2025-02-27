Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A6271837;
	Thu, 27 Feb 2025 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693308; cv=none; b=UNWqTY6BwXxj9VPfdjbZG8fb4fgf3OiqyLsSQDqsi+cSWR56z26TgBZ85GO/Q6MRTaPQDmhN8pDOQKM6c9nykS/fYcpNR1AvyCNA5HmnjYI5h1O4f288hrpW9wd1unAGDVwc9iKIrMwCIz9IO6C1RhAaVouHu07zwBzEjSG1ThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693308; c=relaxed/simple;
	bh=LpbilOsWLoNnJGzgX003R1u3AjO7Z8GyjuWN92uWcOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRkDbQffqvoF2MKWdvuufyPDmCT5pVvRmP2WWMiejIyZXlHabz1CyrlUgjU4W2++c841O8qV+ano8IfOcPpiUtzT/0Kn837X2THXard+OBFWNFgw9WWyvWZ84meXiupF5td26l2A5VtRlDsr5ufa5rn8aCZx+hV1jrEf3gQZzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAmNIT7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAmNIT7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B83C4CEE5;
	Thu, 27 Feb 2025 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693308;
	bh=LpbilOsWLoNnJGzgX003R1u3AjO7Z8GyjuWN92uWcOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAmNIT7DKxuc80lGD13aJcVJYbvFOxaD56SZBuaXjLwzSmDB0G5ThdlBxI07xxD80
	 n8e4XP/iqzHjxRv6o8sMEZOBhVwjFE3p1C05gWj3JbCrTGauNyiW0vZNzggkwsDBgT
	 W+Yc9CprZHGggUJRWO/+LSw3DHIEcZERDXQ6L9uh+GkKibqPOWTKLRsIvaW6CNcaLj
	 fX8nnkeWKVgnTIwC0RodkfP6RQXqqcoKEJVj/xmD5iJmgItBngpuxRQAcPhFZW4eIG
	 X3cG1NXfgjzduohfQ4OBGVXXtn4FzC+aS9SsORfdGoy8BIzB4ApOIEklo7YCr9v5V5
	 MTRoLFUhFhJaw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/6] perf maps: Introduce map__set_kmap() for kernel maps
Date: Thu, 27 Feb 2025 18:54:50 -0300
Message-ID: <20250227215455.30514-2-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215455.30514-1-acme@kernel.org>
References: <20250227215455.30514-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need to set it in other places than __maps__insert(), so that we can
have access to the 'struct kmap' from a kernel 'struct map'.

When building perf with 'DEBUG=1' we can notice it failing a consistency
check done in the check_invariants() function:

  root@number:~# perf record -- perf test -w offcpu
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
  perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
  Aborted (core dumped)
  root@number:~#

The investigation on that was happening bisected to 876e80cf83d10585
("perf tools: Fixup end address of modules"), and the following patches
will plug the problems found, this patch is just legwork on that
direction.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/lkml/Z74V0hZXrTLM6VIJ@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/maps.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 09c9cc326c08d435..e21d29f5df01c6f7 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -428,11 +428,29 @@ static unsigned int maps__by_name_index(const struct maps *maps, const struct ma
 	return -1;
 }
 
+static void map__set_kmap(struct map *map, struct maps *maps)
+{
+	struct dso *dso;
+
+	if (map == NULL)
+		return;
+
+	dso = map__dso(map);
+
+	if (dso && dso__kernel(dso)) {
+                struct kmap *kmap = map__kmap(map);
+
+                if (kmap)
+                        kmap->kmaps = maps;
+                else
+                        pr_err("Internal error: kernel dso with non kernel map\n");
+        }
+}
+
 static int __maps__insert(struct maps *maps, struct map *new)
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
 	struct map **maps_by_name = maps__maps_by_name(maps);
-	const struct dso *dso = map__dso(new);
 	unsigned int nr_maps = maps__nr_maps(maps);
 	unsigned int nr_allocate = RC_CHK_ACCESS(maps)->nr_maps_allocated;
 
@@ -483,14 +501,9 @@ static int __maps__insert(struct maps *maps, struct map *new)
 	}
 	if (map__end(new) < map__start(new))
 		RC_CHK_ACCESS(maps)->ends_broken = true;
-	if (dso && dso__kernel(dso)) {
-		struct kmap *kmap = map__kmap(new);
 
-		if (kmap)
-			kmap->kmaps = maps;
-		else
-			pr_err("Internal error: kernel dso with non kernel map\n");
-	}
+	map__set_kmap(new, maps);
+
 	return 0;
 }
 
-- 
2.47.0

