Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC268271822;
	Thu, 27 Feb 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693320; cv=none; b=Vwu6GxdC/cGGW7VbPs0r/SuBQ6eo9hDbNAuuGH+bX0FM8ApJKAcgFLfPHa9aKfXmhSzwGieqN9H6KpJwUtw6T0OS7NFRyLUdHwT3GbXAZ7GO7dkdNH71LaQ3EqqaY9tKIP0s907eokCh+YVeu9fQoLIC42a5qbKogGuBmGQ/D20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693320; c=relaxed/simple;
	bh=EW+8SC3MCIrg61lmqTxa4tS5pq7iQsw1/LDMacoSSIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyPq7QCFhyEsxNoa1ndZsZ+W7UZmDb8/dNRj2X7iOL8uB/14H16ZDzOxF7vaOLTmV5pUjFVJCnS4YLjAkDbDggGOU//CWbSoOCyc8PIughd3fg/ZBpEWKmNRsW5cJ7NHHs2u+UODpZYb+eH5HspXtV0sWyTH6O44Fj6CVvj14fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+caaAWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+caaAWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C51AC4CEDD;
	Thu, 27 Feb 2025 21:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693319;
	bh=EW+8SC3MCIrg61lmqTxa4tS5pq7iQsw1/LDMacoSSIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+caaAWultGfJOASmznIZv2lG2r0Li3PQVoSyNs76F25eGOTTXfY4cLDaw4gi9qX3
	 4CG0ZJA80iKOLFltvhKLUj9QCO9HCoD2ob0a+PJ0R3VHuIrs3hyFQgpMBRPom0B9TA
	 cNNUiXjhgw2X+NBF+RxqO4ulAB7QDh65kT7f2PZxzf3EEFTVAo6BBaz1kVvQqC9sXP
	 h0UpYI9NQMkVa+OHpEzKsgr3b6aZ8of6Cdww6H4MpN6tlAFnv7aun0ooXey+6V2MtI
	 VuPvcG/xAXqJUrAnqi4b9gSdr3nPJxjxDxZIlKu5wRXJkRo0qCH+NhkpLjX1hyp85s
	 m78VERre/Oepg==
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
Date: Thu, 27 Feb 2025 18:54:53 -0300
Message-ID: <20250227215455.30514-5-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215455.30514-1-acme@kernel.org>
References: <20250227215455.30514-1-acme@kernel.org>
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
index dec2e04696c9097e..dffc54a8a29bf3b0 100644
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
2.47.0

