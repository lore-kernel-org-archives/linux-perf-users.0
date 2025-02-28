Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849123F38A;
	Fri, 28 Feb 2025 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777466; cv=none; b=Z1L7ZfnWw2MTzeegL4US80CXfo0XllOfZvOxBTLaVl3fGwY8FOniICOPlkgD96FNvJtup4GKY3+2wJYdvCC2gc+7KIaW+8fTsa8WOmyKGj3MyvaraFHo5H+bdsuoR6V/cUJPk2kFxwhu2aKoLAkLXoSmjeYqwCw8lOz3+pklEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777466; c=relaxed/simple;
	bh=Y8qIbnUvkhvjP32pb7XNv5MY+kYkOJtBc6Hdz6sbIgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMkRKVBsjNA6R/JmKckoLpvJds6a6CG803vd/STyKnRyhSXb26GmM8ROYghtpm9HC3mpEaF1qo1sXgIoyvdkqXlAiDP2DmleWp0I9wsc6hSiL1r2GD0Fyhr4+r+2gns34JeIO16GmVU7IYHW5m9/sfoboDXbCoCdCJ0VtTH+vPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/GH3PqN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/GH3PqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A51FC4CED6;
	Fri, 28 Feb 2025 21:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777465;
	bh=Y8qIbnUvkhvjP32pb7XNv5MY+kYkOJtBc6Hdz6sbIgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/GH3PqNYAIrokmI8p96m29QHuq/O60LL2Vb5HPQAAkZo+yTDleQYr7ml+733IipM
	 Bp6ASQRtKNHU7BWBOOytL+evVCIQp7SNjA7ESn37jla4cHXCQIuJt3T3rw7UamjUpE
	 opWQq3pEQNOlkc0xhU6kCtGLUEKyCqS/IrWCS9ioSLpa7E8vnesHcZq9Sy8M6b7Dik
	 54hONRqIbMAmYdj2lCKH4ojvYmeWdtlINxUGa+6r3JSg1e4lQqOQG7VhDHuM1E7kH0
	 f4e8HPpeQqwpZeD9hmRXuWWTm8KYGTYS4/marNJdYY2YEC6dfVBPi3wz0msQS1UmQN
	 0ec+OtQStB7QA==
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
Subject: [PATCH 1/6] perf maps: Introduce map__set_kmap_maps() for kernel maps
Date: Fri, 28 Feb 2025 18:17:29 -0300
Message-ID: <20250228211734.33781-2-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228211734.33781-1-acme@kernel.org>
References: <20250228211734.33781-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need to set it in other places than __maps__insert(), so that we can
have access to the 'struct maps' from a kernel 'struct map'.

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

Use the map__set_kmap_maps() name as per a review comment from Ian
Rogers, later there are further suggestions from him on getting rid of
the kmaps variable, see the thread referenced in the Link below.

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
index 09c9cc326c08d435..51b507233269d8b4 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -428,11 +428,29 @@ static unsigned int maps__by_name_index(const struct maps *maps, const struct ma
 	return -1;
 }
 
+static void map__set_kmap_maps(struct map *map, struct maps *maps)
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
+	map__set_kmap_maps(new, maps);
+
 	return 0;
 }
 
-- 
2.48.1

