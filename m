Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815135;
	b=SECb3syp6NOLgKGxxlutqho010FmpKsIZxalsQTsUrI0pRjUipULgmOGLxWba46BdBg/
	 3ZOfH+xJPg/yRrnNfrFRewkaNhcJ8JVVkAbVJxLdWP6NNdnO0gYxrSuqhPGvnEYGfU3oV
	 /qUgqtq7ZtIE2HqogVdeXB63GdabyANQr+aMyQPcx/QXkyEs5b6tfpeVTK3Qita44F+Yx
	 XyaUBZRiVRQC1N9vs4+esVcRmEUtEW30jXt5z+cAJyTWYJGlM4b5e+hXbe9B0NnDsBySF
	 ad+itpV0djjh2VIwptH+Kn52+489tIGUZEDNyykMHfJ43zv40OJoKfy6GvQlELE+Euw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZRbXl4Wdz0yAWyx8FYLOnZSuaMwEtIxgUPMsFEjPJ2I=;
	b=TiHgTs7vPpVnbmbbWmBH6OykrL1pFzyyYdMpmEkl+D8WF3KL5Z9zHBcyTyjMzvYNF2/g
	 S0rUGrS7HPkM8iQLed0h1G7GmN2vYRpCr0aSgei1iNmf5Qv70uiYHA8bO8oxa0zSLegY+
	 FJH+A9bMgdjVILmlIlea5yZowXwgz8MzZ5UBa2T4vvC0btDDFRBaCCqN5PZlMDtV6JY4X
	 B/bQpmX31JedjSlwCwnIcSnCXKRv+EE6RM8jjiJuV7UEPqS22XH2jEYBg7ZKVsEasOWNY
	 kMe1J70jeNBEC3zUhg8R5ZG9qs773veQvs+4X2L2HUlGWU1p2hnG+zI/6KNhFhNWUPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BFl6Ig/f";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF5606A8A5
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DCF5606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BFl6Ig/f
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so5029440eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815134; x=1795419934; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZRbXl4Wdz0yAWyx8FYLOnZSuaMwEtIxgUPMsFEjPJ2I=;
        b=BFl6Ig/fJP09XSwjcccVh9qvrD69xwP7umdx1wwdODGdW+yMcD1+zA355XcWKFRVXM
         RU+77BJJsdjDsYncMxNljqh7ke6zsvGuAPeQ2t5Y0FNmY+No7XaczhXeNnUtA93pn+yp
         aJWjtzHpgyPuustBmqL6/bCPdiCsa7uLbdGLpxfTNNoAjBfmNpz04qHdXfPKyQeb1yJJ
         lCMVBgYfxddfok31kVeY+YnABb+vAFB/+vz6+Y8EGnkcCs2ygavVjTYheZLpl0GrdCv8
         DnFhBp6+/2nxP046ftTMP+1hrxozIymuZuIEq3GQoROdMw52A8nULQ5OAtCxjIe2y3Fz
         KSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815134; x=1795419934;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZRbXl4Wdz0yAWyx8FYLOnZSuaMwEtIxgUPMsFEjPJ2I=;
        b=fWr9T1v+7upOdsN30xxTOdsqz8XSmVcTlh9PWqO6MhPHDrlQGJs4rIJJ51nmurXqTy
         Zks75npQ5Y/ylEYrz3Mcq1Xi0DyplbQZ/tsD8M8tFb0LZiyaY530HJdS/m34XwPZwMnD
         Awd3NzyZVqre6sjph0TeJGHbOWG168skDh35TLwjW2HX9/Hex45RNg2PKLzg6jZe+FSo
         Dgaf0UTfCetyY0Erp+7scOgOky0Gm0YV53J3jyUzSitEkrZBGauQ3BDYeZ+2DZL0xj3a
         6Q2U/qTaMomCupwRjyPIy8dxMEXF+x4yFzVjDRAQr6AYpW2uiKFcCa5G1xK1zMH73dMc
         bVlQ==
X-Forwarded-Encrypted: i=1; AL+hErHErRem7Fxfy8soEgdO7goKoeUT/XzBNWivUkPdnYpAQnhl4WA1stNfzHHRqIjxQMKdC68eTupDGvELxKxr/L6l@vger.kernel.org
X-Gm-Message-State: APuU4Z9TDVI1BH2Aoe2KyNiMFNsVimFeE6R/UAiycD3lD8Z9d9/N6qed
	CcccXlUDM6uXvEO/7GCfxWRLkroLIF5JYlmH+TxpKqCKUggBldmIo/sv67NOwGZXviqOX9YRnn0
	6SKpN6N7QDw==
X-Received: from dyad24.prod.google.com ([2002:a05:693c:8358:b0:369:68b5:ef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1625:b0:36e:aa5c:7851
 with SMTP id 5a478bee46e88-37966d40c48mr10783412eec.27.1794815133465; Sun, 15
 Nov 2026 23:45:33 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:08 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-14-irogers@google.com>
Subject: [PATCH v3 13/19] perf maps: Add dsos__find_by_build_id() and maps__find_by_build_id()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add helpers to look up a DSO in struct dsos by its build ID and to find
(or lazily populate from machine->dsos or the build-id cache) a struct
map in struct maps matching a given build ID. This prepares for
resolving PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET samples without virtual-address
MMAP records.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 68 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/dsos.h |  6 ++++
 tools/perf/util/maps.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/maps.h |  2 ++
 4 files changed, 149 insertions(+)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e927e707abac..60178a093f4e 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -294,6 +294,40 @@ struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 	return res;
 }
 
+struct dsos__find_build_id_cb_args {
+	const struct build_id *bid;
+	enum dso_space_type dso_space;
+	struct dso *res;
+};
+
+static int dsos__find_build_id_cb(struct dso *dso, void *data)
+{
+	struct dsos__find_build_id_cb_args *args = data;
+
+	if (dso__kernel(dso) == args->dso_space &&
+	    dso__has_build_id(dso) && dso__build_id_equal(dso, args->bid)) {
+		args->res = dso__get(dso);
+		return 1;
+	}
+	return 0;
+}
+
+struct dso *dsos__find_by_build_id(struct dsos *dsos, const struct build_id *bid,
+				   int dso_space)
+{
+	struct dsos__find_build_id_cb_args args = {
+		.bid = bid,
+		.dso_space = dso_space,
+		.res = NULL,
+	};
+
+	if (!build_id__is_defined(bid))
+		return NULL;
+
+	dsos__for_each_dso(dsos, dsos__find_build_id_cb, &args);
+	return args.res;
+}
+
 static void dso__set_basename(struct dso *dso)
 {
 	bool allocated = false;
@@ -349,6 +383,40 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct d
 	return dso;
 }
 
+struct dso *dsos__findnew_id_space(struct dsos *dsos, struct machine *machine,
+				   const char *name, const struct dso_id *id,
+				   int dso_space)
+{
+	enum dso_space_type space = dso_space;
+	struct dso *dso;
+
+	down_write(&dsos->lock);
+	dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
+	if (dso) {
+		if (dso__kernel(dso) == space)
+			__dso__improve_id(dso, id);
+		else
+			dso__zput(dso);
+	} else {
+		dso = dso__new_id(name, id);
+		if (dso) {
+			dso__set_basename(dso);
+			if (space != DSO_SPACE__USER) {
+				struct kmod_path m = { .name = NULL };
+
+				if (!kmod_path__parse_name(&m, name) && m.kmod)
+					dso__set_module_info(dso, &m, machine);
+				dso__set_kernel(dso, space);
+				free(m.name);
+			}
+			if (__dsos__add(dsos, dso))
+				dso__zput(dso);
+		}
+	}
+	up_write(&dsos->lock);
+	return dso;
+}
+
 struct dsos__fprintf_buildid_cb_args {
 	FILE *fp;
 	bool (*skip)(struct dso *dso, int parm);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index a26774950866..6343bf96b45a 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -8,6 +8,7 @@
 #include <linux/rbtree.h>
 #include "rwsem.h"
 
+struct build_id;
 struct dso;
 struct dso_id;
 struct kmod_path;
@@ -31,8 +32,13 @@ void dsos__exit(struct dsos *dsos);
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
+struct dso *dsos__find_by_build_id(struct dsos *dsos, const struct build_id *bid,
+				   int dso_space);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id);
+struct dso *dsos__findnew_id_space(struct dsos *dsos, struct machine *machine,
+				   const char *name, const struct dso_id *id,
+				   int dso_space);
  
 bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 675fe0223faa..3ce6feb23821 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -2,8 +2,11 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <linux/zalloc.h>
+#include "build-id.h"
 #include "debug.h"
 #include "dso.h"
+#include "dsos.h"
+#include "machine.h"
 #include "map.h"
 #include "maps.h"
 #include "rwsem.h"
@@ -1252,6 +1255,76 @@ static int map__strcmp_name(const void *name, const void *b)
 	return strcmp(name, dso__short_name(dso));
 }
 
+struct map *maps__find_by_build_id(struct maps *maps, struct build_id *bid)
+{
+	struct machine *machine = maps__machine(maps);
+	bool is_kmaps = RC_CHK_EQUAL(maps, machine__kernel_maps(machine));
+	enum dso_space_type dso_space = is_kmaps
+		? (machine__is_host(machine) ? DSO_SPACE__KERNEL : DSO_SPACE__KERNEL_GUEST)
+		: DSO_SPACE__USER;
+	struct map *result = NULL;
+
+	if (!build_id__is_defined(bid))
+		return NULL;
+
+	down_read(maps__lock(maps));
+	for (unsigned int i = 0, n = maps__nr_maps(maps); i < n; i++) {
+		struct map *map = maps__maps_by_address(maps)[i];
+		struct dso *dso = map__dso(map);
+
+		if (dso && dso__kernel(dso) == dso_space &&
+		    dso__has_build_id(dso) &&
+		    dso__build_id_equal(dso, bid)) {
+			result = map__get(map);
+			break;
+		}
+	}
+	up_read(maps__lock(maps));
+
+	if (!result) {
+		struct dso *dso = dsos__find_by_build_id(&machine->dsos, bid, dso_space);
+
+		if (!dso) {
+			char sbuild_id[SBUILD_ID_SIZE];
+			char *origname;
+
+			build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
+			origname = build_id_cache__origname(sbuild_id);
+			if (origname) {
+				struct dso_id id = { .build_id = *bid };
+
+				dso = dsos__findnew_id_space(&machine->dsos, machine,
+							     origname, &id, dso_space);
+				free(origname);
+			}
+		}
+		if (dso) {
+			down_write(maps__lock(maps));
+			for (unsigned int i = 0, n = maps__nr_maps(maps); i < n; i++) {
+				struct map *map = maps__maps_by_address(maps)[i];
+				struct dso *map_dso = map__dso(map);
+
+				if (map_dso && dso__kernel(map_dso) == dso_space &&
+				    dso__has_build_id(map_dso) &&
+				    dso__build_id_equal(map_dso, bid)) {
+					result = map__get(map);
+					break;
+				}
+			}
+			if (!result) {
+				result = map__new2(0, dso);
+				if (result && __maps__insert(maps, result)) {
+					map__put(result);
+					result = NULL;
+				}
+			}
+			up_write(maps__lock(maps));
+			dso__put(dso);
+		}
+	}
+	return result;
+}
+
 struct map *maps__find_by_name(struct maps *maps, const char *name)
 {
 	struct map *result = NULL;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4ec9b7453a3b..6f1791457068 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -11,6 +11,7 @@ struct ref_reloc_sym;
 struct machine;
 struct map;
 struct maps;
+struct build_id;
 
 #define KMAP_NAME_LEN 256
 
@@ -76,6 +77,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
 int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new);
 
 struct map *maps__find_by_name(struct maps *maps, const char *name);
+struct map *maps__find_by_build_id(struct maps *maps, struct build_id *bid);
 
 struct map *maps__find_next_entry(struct maps *maps, struct map *map);
 
-- 
2.56.1.703.gf848ed807c-goog

