Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F33171B1
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Feb 2024 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535086; cv=none; b=d6M+IGJ9goBpUtLrMXSdhNvkt9+TdLWgLG1vm063THeZmFAIeyBrk7RN19ba5SFL+Czl601JmgcXN+U46U1Nv+DbxnliD16NHuPMIH96we6QKr6pGkfHE5cGvKKBWmHNACWRMjOJR992YhX3nuIfE8jJwoeTLm5vONJ1TBNLymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535086; c=relaxed/simple;
	bh=fCSN5N4coy81LhtSHeyCVX7q+9jL53OOSOyC3avUo8c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PNa2j/RjXj/I2mYhymJQu/cO7SEiPyXSqSujc5uqbG5bgyumr9PNvbQM86udyKuEvrxCqjQ2iSDx2hqEPE4hLu3ZZdJ9j5gEzC8g2FureBFJMa5ok+PpXK0tjLIOowGjfLeRvBoNwMkYF3T6vtn8Vxb4xIZAIvdLsJuJNu31DMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcuVmUdv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcuVmUdv"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603cbb4f06dso32588757b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Feb 2024 19:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707535083; x=1708139883; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbHwthVXSI7C3XB81guo41V7Q64jaj+9t0IxZ+P82yY=;
        b=bcuVmUdvwhlFFBVOoiVP+6DYUaC8nEg7IRS2jhyfWmDkpShyy2h8Qkgolf3DbB0L45
         eKHH3ftX1Q5QruJHDZW0rkUA8w2J6bZc0+BAJL0GqzkRCoFkDbtwdqN+vYEM/XTKdWof
         Jek9SFPi5HAtU+JzHvtmWcu+mD0DaUJwNTB9WG56AFVAol+z6neoVD4WdXTjSV6JhnqS
         QTfN3+K4vDDgUZf2UkLRzHSKG0U8kvNLE7Oe6/0iDx3nt7U2hk+FC7YFOYtzuH2Kxwsy
         HOq7Eo1u6GH2B6VPbBxVnRLGcch4G2f1bIjRozXIM1T07Merux7R4P0ma2Lt/A7RCDEv
         Nsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707535083; x=1708139883;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbHwthVXSI7C3XB81guo41V7Q64jaj+9t0IxZ+P82yY=;
        b=Se4wLoOjgMlC2xXwAcuTZiLCzAGq/9uSARSqnzmsB0x9n/WJdS/DF9aewmK/TuX4BN
         7S8jGFKH/RGEAjD5c4cY8yY29td1UoJyJnzoFYOvTk0+RfVo+tmBMvehXStLMRF/o4Bt
         J2uBzOR7VHAeDeR8/ys0aqVRJFf73+k1oVAZCHpYtyAgpMoq1Rz11t0TCi+rHvPQF4PE
         XIm7rzqu45aECsvT6GzBLbms50t7L9i/zf2cEUb+ZDZ1EvwRD/6w8fBEAEdZ2w3nEqa/
         RuBpyQN5yKJGYQ6O/zn0/owrvYnNUTfW5fLQR5Tn+56LBpev5li0ra7ZiKWJ0LfHcsZ1
         9vyg==
X-Forwarded-Encrypted: i=1; AJvYcCXM4X7fhx65ZtgEmJCFGRxIYUTIPlt827qfLvjUZMJBkW1apQXBVyFgjBhbtiqnPH+RTQTYC9beq2Q8sQ2j2u/BwGDCHgnQUtIeD+BGjhWSpQ==
X-Gm-Message-State: AOJu0YzLzIby0Z2Lg1+4DdSV+KVUwARkAcKmrFXiyJWNQC+8Q4H8ZE3T
	gHDiRrgoR/LL0HkegkEQo73ozUUDInuRTdhlzrMBXgs1sudElnqCfLxndJWq9hYWb/4SLEkHtNm
	TKMRoZg==
X-Google-Smtp-Source: AGHT+IGpMnXS3FFMqtdRh8/93XpyMWFfObpSj7BGjnjEYnZP3I5URnCflTMaL0Pu2JdJbt+4+tjuMCSAHPO3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a0d:e844:0:b0:604:a67c:7f8d with SMTP id
 r65-20020a0de844000000b00604a67c7f8dmr280224ywe.5.1707535083146; Fri, 09 Feb
 2024 19:18:03 -0800 (PST)
Date: Fri,  9 Feb 2024 19:17:43 -0800
In-Reply-To: <20240210031746.4057262-1-irogers@google.com>
Message-Id: <20240210031746.4057262-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 3/6] perf maps: Get map before returning in maps__find_by_name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Artem Savkov <asavkov@redhat.com>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	James Clark <james.clark@arm.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this. Also fix some reference counted pointer comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/vmlinux-kallsyms.c |  5 +++--
 tools/perf/util/machine.c           |  6 ++++--
 tools/perf/util/maps.c              |  6 +++---
 tools/perf/util/probe-event.c       |  1 +
 tools/perf/util/symbol-elf.c        |  4 +++-
 tools/perf/util/symbol.c            | 18 +++++++++++-------
 6 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index e808e6fc8f76..fecbf851bb2e 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -131,9 +131,10 @@ static int test__vmlinux_matches_kallsyms_cb1(struct map *map, void *data)
 	struct map *pair = maps__find_by_name(args->kallsyms.kmaps,
 					(dso->kernel ? dso->short_name : dso->name));
 
-	if (pair)
+	if (pair) {
 		map__set_priv(pair, 1);
-	else {
+		map__put(pair);
+	} else {
 		if (!args->header_printed) {
 			pr_info("WARN: Maps only in vmlinux:\n");
 			args->header_printed = true;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e8eb9f0b073f..7031f6fddcae 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1537,8 +1537,10 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 		return 0;
 
 	long_name = strdup(path);
-	if (long_name == NULL)
+	if (long_name == NULL) {
+		map__put(map);
 		return -ENOMEM;
+	}
 
 	dso = map__dso(map);
 	dso__set_long_name(dso, long_name, true);
@@ -1552,7 +1554,7 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 		dso->symtab_type++;
 		dso->comp = m->comp;
 	}
-
+	map__put(map);
 	return 0;
 }
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 2547c9074b3a..ea8fa684e8c6 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -905,7 +905,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 			struct dso *dso = map__dso(maps__maps_by_name(maps)[i]);
 
 			if (dso && strcmp(dso->short_name, name) == 0) {
-				result = maps__maps_by_name(maps)[i]; // TODO: map__get
+				result = map__get(maps__maps_by_name(maps)[i]);
 				done = true;
 			}
 		}
@@ -917,7 +917,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 					sizeof(*mapp), map__strcmp_name);
 
 			if (mapp) {
-				result = *mapp; // TODO: map__get
+				result = map__get(*mapp);
 				i = mapp - maps__maps_by_name(maps);
 				RC_CHK_ACCESS(maps)->last_search_by_name_idx = i;
 			}
@@ -942,7 +942,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 					struct dso *dso = map__dso(pos);
 
 					if (dso && strcmp(dso->short_name, name) == 0) {
-						result = pos; // TODO: map__get
+						result = map__get(pos);
 						break;
 					}
 				}
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a1a796043691..be71abe8b9b0 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -358,6 +358,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 		map = maps__find_by_name(machine__kernel_maps(host_machine), module_name);
 		if (map) {
 			dso = map__dso(map);
+			map__put(map);
 			goto found;
 		}
 		pr_debug("Failed to find module %s.\n", module);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 95773c32796d..0b91f813c4fa 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1535,8 +1535,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		dso__set_loaded(curr_dso);
 		*curr_mapp = curr_map;
 		*curr_dsop = curr_dso;
-	} else
+	} else {
 		*curr_dsop = map__dso(curr_map);
+		map__put(curr_map);
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1710b89e207c..0785a54e832e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -814,7 +814,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				struct map *initial_map)
 {
 	struct machine *machine;
-	struct map *curr_map = initial_map;
+	struct map *curr_map = map__get(initial_map);
 	struct symbol *pos;
 	int count = 0, moved = 0;
 	struct rb_root_cached *root = &dso->symbols;
@@ -858,13 +858,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 					dso__set_loaded(curr_map_dso);
 				}
 
+				map__zput(curr_map);
 				curr_map = maps__find_by_name(kmaps, module);
 				if (curr_map == NULL) {
 					pr_debug("%s/proc/{kallsyms,modules} "
 					         "inconsistency while looking "
 						 "for \"%s\" module!\n",
 						 machine->root_dir, module);
-					curr_map = initial_map;
+					curr_map = map__get(initial_map);
 					goto discard_symbol;
 				}
 				curr_map_dso = map__dso(curr_map);
@@ -888,7 +889,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			 * symbols at this point.
 			 */
 			goto discard_symbol;
-		} else if (curr_map != initial_map) {
+		} else if (!RC_CHK_EQUAL(curr_map, initial_map)) {
 			char dso_name[PATH_MAX];
 			struct dso *ndso;
 
@@ -899,7 +900,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			}
 
 			if (count == 0) {
-				curr_map = initial_map;
+				map__zput(curr_map);
+				curr_map = map__get(initial_map);
 				goto add_symbol;
 			}
 
@@ -913,6 +915,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 					kernel_range++);
 
 			ndso = dso__new(dso_name);
+			map__zput(curr_map);
 			if (ndso == NULL)
 				return -1;
 
@@ -926,6 +929,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 
 			map__set_mapping_type(curr_map, MAPPING_TYPE__IDENTITY);
 			if (maps__insert(kmaps, curr_map)) {
+				map__zput(curr_map);
 				dso__put(ndso);
 				return -1;
 			}
@@ -936,7 +940,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			pos->end -= delta;
 		}
 add_symbol:
-		if (curr_map != initial_map) {
+		if (!RC_CHK_EQUAL(curr_map, initial_map)) {
 			struct dso *curr_map_dso = map__dso(curr_map);
 
 			rb_erase_cached(&pos->rb_node, root);
@@ -951,12 +955,12 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		symbol__delete(pos);
 	}
 
-	if (curr_map != initial_map &&
+	if (!RC_CHK_EQUAL(curr_map, initial_map) &&
 	    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 	    machine__is_default_guest(maps__machine(kmaps))) {
 		dso__set_loaded(map__dso(curr_map));
 	}
-
+	map__put(curr_map);
 	return count + moved;
 }
 
-- 
2.43.0.687.g38aa6559b0-goog

