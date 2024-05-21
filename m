Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7C148843
	for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310287; cv=none; b=fIrGp5NVMRqHazhCIjm9JgczqoYZyhivjFw+fCiwUc1Ywv4sBU/RmKeiQ20VZgKLI6SXDWL7/S0VvN8RtUbukVDRFOjGcpx43FWlDr9IsYJSPUv18N/2AUN1J1yOc4/RpaXB/5nMwgzubQvCNkJTN7QIPSZtJ8A1cCkrEXlP1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310287; c=relaxed/simple;
	bh=Dhw2Jh5mBReYK2KdFz4zu0dZX2l7oWPnI/weHg4qPJE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kcFD3q8AH4XDDqfEZ4lrcCV4pHuFUkYY05JfFekUKNPPZeRc9YgxnicPQUlI1XzWur/cXLpR43J3MyOFSVNIusTpbVxIi6wSpHJNsJ9ujV11HJxDKDzFOSGvleL38zTlXItgRQGK1jhegiYmqJEGMFd3IsdNyOp/6iWojUIOj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=138cH15V; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="138cH15V"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4dc93d0d3so134899276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716310285; x=1716915085; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrE0BOJf8HvNnLMD4w6E9MqTE92sz3IiyAicOOYr1ws=;
        b=138cH15VD/8CfPyZRGzj205b1CZkhWJo/BVITisHEogHXPDXUwZyrUbE6I7nabJKnE
         wZkyzU0DVRg+CuHrbDS4z/31LNE8G4/z7AFrwdkH2pUMdGLG+HCoVAArW04dowGgx5gG
         2ua4d+lFjjiS9h3nnYtlN4sDr/erlZU4NAHt8t1SCWIJkq47CiFcTB0/5b2u5+Is5tSw
         CeDAW/xXGO7Kd+ckefinTVCrrtJOzQeC/D/mvH7wqsssGXMF8cUPnRAUkzVt5+BMyC4L
         dr4OZAZI5a32gDvTDv1cQyXGr2V0jIVKxjEsPoKQxlgYbmaVMkCVOF91JTZFFfuUu/LW
         YgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310285; x=1716915085;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrE0BOJf8HvNnLMD4w6E9MqTE92sz3IiyAicOOYr1ws=;
        b=sur/nrTq/EhtJ3uXnnC+qapEiIUG1bXGr90WY04LOniTIcIXEA3rVwdY7N2UOtXjbJ
         DzSO5s3VnzLgCpzH+UnfXMX5+F/oNqPf5prYJxhWKapnOBkik1J4BU0O0fa1lX57Xixr
         V0ZTo+uRgSoBlSukakMR3PACI+HgnlpG851hzUy5UPSVwDT4g6Gy2LRgZlvQBtqbgBHl
         iT2obal9fTfJz3ef9KdSghQrZZouH0843zPWBBpYdVdmBNlmpmwaDeqp60J8Y/NN4zjP
         4egoPe/kA0KdHLYW8mdho5al6QqSlJDg0GdL4eLIqzhmgyf1+0H3ukRji6PFdG7T/W6I
         o8CA==
X-Forwarded-Encrypted: i=1; AJvYcCX+8qzxQNXnXpkupARhLKfP+yIFpwKm1V/ums4j+7x9Gnm2UXUqBu8URcDggIjQ4+GlvXCb34l36OiB59Rqg2c2//vwzvgPRIVwIXOUxMIqrw==
X-Gm-Message-State: AOJu0YxJ1QcQJfj3HcASSEPy5vV2XX0F+f6LUiQh5mf19VO8qV1wqv3+
	X1KuOBj8J1xj0cLFvCiMN0uXTVyzNceADmanLTGyDD+FE8Xkdz7m1rWe0xOeOjhmNQxj5D5CktC
	wPL4RQw==
X-Google-Smtp-Source: AGHT+IHTBwsqs2wQ8TlnvMpoDM7P28140rp8Mfd1Iad6gC/LK63BwUOu/9UX9LlDgAfvx3yzOt1h8kHrBWwS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:6902:100b:b0:df4:9b3d:66a9 with SMTP
 id 3f1490d57ef6-df49b3d9b15mr2457254276.10.1716310284725; Tue, 21 May 2024
 09:51:24 -0700 (PDT)
Date: Tue, 21 May 2024 09:51:09 -0700
In-Reply-To: <20240521165109.708593-1-irogers@google.com>
Message-Id: <20240521165109.708593-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521165109.708593-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 3/3] perf maps: Add/use a sorted insert for fixup overlap
 and insert
From: Ian Rogers <irogers@google.com>
To: "Steinar H . Gunderson" <sesse@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Data may have lots of overlapping mmaps. The regular insert adds at
the end and relies on a later sort. For data with overlapping mappings
the sort will happen during a subsequent maps__find or
__maps__fixup_overlap_and_insert, there's never a period where the
inserted maps buffer up and a single sort happens. To avoid back to
back sorts, maintain the sort order when fixing up and
inserting. Previously the first_ending_after search was O(log n) where
n is the size of maps, and the insert was O(1) but because of the
continuous sorting was becoming O(n*log(n)). With maintaining sort
order, the insert now becomes O(n) for a memmove.

For a perf report on a perf.data file containing overlapping mappings
the time numbers are:

Before:
real    0m5.894s
user    0m5.650s
sys     0m0.231s

After:
real    0m0.675s
user    0m0.454s
sys     0m0.196s

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 65 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f6b6df82f4cf..432399cbe5dd 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -735,6 +735,60 @@ static unsigned int first_ending_after(struct maps *maps, const struct map *map)
 	return first;
 }
 
+static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_index,
+				 struct map *new1, struct map *new2)
+{
+	struct map **maps_by_address = maps__maps_by_address(maps);
+	struct map **maps_by_name = maps__maps_by_name(maps);
+	unsigned int nr_maps = maps__nr_maps(maps);
+	unsigned int nr_allocate = RC_CHK_ACCESS(maps)->nr_maps_allocated;
+	unsigned int to_add = new2 ? 2 : 1;
+
+	assert(maps__maps_by_address_sorted(maps));
+	assert(first_after_index == nr_maps ||
+	       map__end(new1) <= map__start(maps_by_address[first_after_index]));
+	assert(!new2 || map__end(new1) <= map__start(new2));
+	assert(first_after_index == nr_maps || !new2 ||
+	       map__end(new2) <= map__start(maps_by_address[first_after_index]));
+
+	if (nr_maps + to_add > nr_allocate) {
+		nr_allocate = !nr_allocate ? 32 : nr_allocate * 2;
+
+		maps_by_address = realloc(maps_by_address, nr_allocate * sizeof(new1));
+		if (!maps_by_address)
+			return -ENOMEM;
+
+		maps__set_maps_by_address(maps, maps_by_address);
+		if (maps_by_name) {
+			maps_by_name = realloc(maps_by_name, nr_allocate * sizeof(new1));
+			if (!maps_by_name) {
+				/*
+				 * If by name fails, just disable by name and it will
+				 * recompute next time it is required.
+				 */
+				__maps__free_maps_by_name(maps);
+			}
+			maps__set_maps_by_name(maps, maps_by_name);
+		}
+		RC_CHK_ACCESS(maps)->nr_maps_allocated = nr_allocate;
+	}
+	memmove(&maps_by_address[first_after_index+to_add],
+		&maps_by_address[first_after_index],
+		(nr_maps - first_after_index) * sizeof(new1));
+	maps_by_address[first_after_index] = map__get(new1);
+	if (maps_by_name)
+		maps_by_name[nr_maps] = map__get(new1);
+	if (new2) {
+		maps_by_address[first_after_index + 1] = map__get(new2);
+		if (maps_by_name)
+			maps_by_name[nr_maps + 1] = map__get(new2);
+	}
+	RC_CHK_ACCESS(maps)->nr_maps = nr_maps + to_add;
+	maps__set_maps_by_name_sorted(maps, false);
+	check_invariants(maps);
+	return 0;
+}
+
 /*
  * Adds new to maps, if new overlaps existing entries then the existing maps are
  * adjusted or removed so that new fits without overlapping any entries.
@@ -743,6 +797,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 {
 	int err = 0;
 	FILE *fp = debug_file();
+	unsigned int i;
 
 	if (!maps__maps_by_address_sorted(maps))
 		__maps__sort_by_address(maps);
@@ -751,7 +806,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	 * Iterate through entries where the end of the existing entry is
 	 * greater-than the new map's start.
 	 */
-	for (unsigned int i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
+	for (i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
 		struct map **maps_by_address = maps__maps_by_address(maps);
 		struct map *pos = maps_by_address[i];
 		struct map *before = NULL, *after = NULL;
@@ -824,9 +879,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				 * 'pos' mapping and therefore there are no
 				 * later mappings.
 				 */
-				err = __maps__insert(maps, new);
-				if (!err)
-					err = __maps__insert(maps, after);
+				err = __maps__insert_sorted(maps, i, new, after);
 				map__put(after);
 				check_invariants(maps);
 				return err;
@@ -839,7 +892,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			 */
 			map__put(maps_by_address[i]);
 			maps_by_address[i] = map__get(new);
-			err = __maps__insert(maps, after);
+			err = __maps__insert_sorted(maps, i + 1, after, NULL);
 			map__put(after);
 			check_invariants(maps);
 			return err;
@@ -869,7 +922,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 		}
 	}
 	/* Add the map. */
-	err = __maps__insert(maps, new);
+	err = __maps__insert_sorted(maps, i, new, NULL);
 out_err:
 	return err;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

