Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2DD1D61B9;
	Fri, 28 Feb 2025 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777477; cv=none; b=Usnsot4Ri7kZkqj1j2y8H+wm7/VI/KZMwRaWhBIxwFzpa9bCYS72YW7CHeXXbw6/1XrCxm37N51MlZ4G/ynjujo/pCeORGwUyiEaiRcS0EEhUENSZcQVpALdJeTYXAR+szFaXQtoXtACYix74qq6DjR59wEteDbp+idSVjV4Yds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777477; c=relaxed/simple;
	bh=R4l8L1c/nV72ALGwDhWP+iUKUkvQXfkGKJnJpjuBik8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlKwifiappWzsErgz4Uqc+bk/8LVq0aYrnnuKEfQE8XJxGNBE2r8aDrdo/jrWwt5dgpF0rktKpU6IcPPXbeSonl0oncbq1ay0yfEE6CPggVlH/PrEvqxCtEwePegb4dVumetJNJJyFsbeN/PPnAHEk1DLvo+nCLkqQxJ0KMpzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwRNgQtz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwRNgQtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119C3C4CEE2;
	Fri, 28 Feb 2025 21:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777477;
	bh=R4l8L1c/nV72ALGwDhWP+iUKUkvQXfkGKJnJpjuBik8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwRNgQtz/WF23o3J+mxNqeUjMnDYZX8Quv8DjnMEZumhfq+TMYx3WlGmc2yVTkL4a
	 AblLI0RIROQxxK7JEkjo69FL116sog4Uv0jdJzMK4qEXpmp+qxmFPljep0BOpQxhRc
	 i5iT/WiEoc8SV3QmGgrxIyt3roMzOPxN0g7J+vKeN76v155TFCRs0N6gnoD7iJKtmW
	 uGJmp9bO3jg0tkUSv4w0lhLiyGq94jwBfZtciLWMXuayBrzIsjtpTNwYD/2hudHfE0
	 FJCzGiPgU1l/kqicC1BS5J8MS/KwShY70M32S9I1uwrStTMcvN/gwRqhF8WZ2Ihuyo
	 GmOtxxfQYqWaw==
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
Subject: [PATCH 4/6] perf maps: Fixup maps_by_name when modifying maps_by_address
Date: Fri, 28 Feb 2025 18:17:32 -0300
Message-ID: <20250228211734.33781-5-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228211734.33781-1-acme@kernel.org>
References: <20250228211734.33781-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Namhyung Kim <namhyung@kernel.org>

We can't just replacing the map in the maps_by_address and not touching
on the maps_by_name, that would leave the refcount as 1 and thus trip
another consistency check, this one:

  perf: util/maps.c:110: check_invariants:
  	Assertion `refcount_read(map__refcnt(map)) > 1' failed.

  106         /*
  107          * Maps by name maps should be in maps_by_address, so
  108          * the reference count should be higher.
  109          */
  110         assert(refcount_read(map__refcnt(map)) > 1);

Committer notice:

Initialize the newly added 'ni' variable, that really can't be
accessed unitialized trips some gcc versions, like:

  12    20.00 archlinux:base                : FAIL gcc version 13.2.1 20230801 (GCC)
    util/maps.c: In function ‘__maps__fixup_overlap_and_insert’:
    util/maps.c:896:54: error: ‘ni’ may be used uninitialized [-Werror=maybe-uninitialized]
      896 |                                 map__put(maps_by_name[ni]);
          |                                                      ^
    util/maps.c:816:25: note: ‘ni’ was declared here
      816 |         unsigned int i, ni;
          |                         ^~
    cc1: all warnings being treated as errors
    make[3]: *** [/git/perf-6.14.0-rc1/tools/build/Makefile.build:138: util] Error 2

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/lkml/Z79std66tPq-nqsD@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/maps.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 8c5f5d79cd24a6bc..77df9701d5ad7de3 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -813,7 +813,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 {
 	int err = 0;
 	FILE *fp = debug_file();
-	unsigned int i;
+	unsigned int i, ni = INT_MAX; // Some gcc complain, but depends on maps_by_name...
 
 	if (!maps__maps_by_address_sorted(maps))
 		__maps__sort_by_address(maps);
@@ -824,6 +824,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	 */
 	for (i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
 		struct map **maps_by_address = maps__maps_by_address(maps);
+		struct map **maps_by_name = maps__maps_by_name(maps);
 		struct map *pos = maps_by_address[i];
 		struct map *before = NULL, *after = NULL;
 
@@ -843,6 +844,9 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			map__fprintf(pos, fp);
 		}
 
+		if (maps_by_name)
+			ni = maps__by_name_index(maps, pos);
+
 		/*
 		 * Now check if we need to create new maps for areas not
 		 * overlapped by the new map:
@@ -887,6 +891,12 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 		if (before) {
 			map__put(maps_by_address[i]);
 			maps_by_address[i] = before;
+
+			if (maps_by_name) {
+				map__put(maps_by_name[ni]);
+				maps_by_name[ni] = map__get(before);
+			}
+
 			/* Maps are still ordered, go to next one. */
 			i++;
 			if (after) {
@@ -908,6 +918,12 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			 */
 			map__put(maps_by_address[i]);
 			maps_by_address[i] = map__get(new);
+
+			if (maps_by_name) {
+				map__put(maps_by_name[ni]);
+				maps_by_name[ni] = map__get(new);
+			}
+
 			err = __maps__insert_sorted(maps, i + 1, after, NULL);
 			map__put(after);
 			check_invariants(maps);
@@ -926,6 +942,12 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				 */
 				map__put(maps_by_address[i]);
 				maps_by_address[i] = map__get(new);
+
+				if (maps_by_name) {
+					map__put(maps_by_name[ni]);
+					maps_by_name[ni] = map__get(new);
+				}
+
 				check_invariants(maps);
 				return err;
 			}
-- 
2.48.1

