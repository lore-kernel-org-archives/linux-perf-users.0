Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567909;
	b=E0Wx7iXvuwyVekdxNQzVdcbzH3N3eAIrdreL/RC8fJOJnzq0ZtflUnPqMbQ6h1qVRGcJ
	 SLmXclWZLBNb9DAJ998cjJPyJfwvhztXjml+hOt/yFAN3N/PBRN+qJoDSZQk1Wir3VD3S
	 3xATIKeLgSgcIWnmqY7ond+yRCRMx9c93E9oBBUB6AxGSvZWMusa2LG7oWXCsWPlZ6NFh
	 1dqq1BvkLGy7k/wimNyTZ2TMJOpXXsmgOGsvezInJxg8cPV2q3pgcImvH//la8SvTigbU
	 hE4fZOD5dSVyvz99ANwfz0DvSS8u1i+R/mIw5K0g5iVuWaVeGjukEYkkTe4LrgS7Csg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=vtJSsEUQrJJTdnX0IwZhqXFmD1dO457Ik9/IV0wwyb4=;
	b=UM/Gt38qzA3/LxvSAfzy1N0ty2RRLvv3yIvosgLaXUXvEpS/3dIkkAluYuxXUprvQQ7i
	 o61h3LgkKDOcvGJFjDMgzhOk+I4IMg0Ki+iuE10c8jlJ0WYjpv3VmrGSF8a7M/oJneoT+
	 ReBkcRCJnxgSngHNtcqnBMhZMuCbdh664oXQ37MOhCgoBjhdMhjQtSB0VUwz4hYcsS+qW
	 L94ZObXfWpPKttLoQfJbdffmFPHQ6nEApSwjT4SyjAHlUo6ZXlIcIQTWL6GpUFVSqkoIe
	 zi3sl33WareDpV/eub9WvJ09diXLtqOxPngWlDxYGlxbWblEpFcTjq2T2Z3UFthDAnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Um0UyzGY;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE60606A689
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DE60606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Um0UyzGY
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b56c696405so5394583c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567908; x=1796172708; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtJSsEUQrJJTdnX0IwZhqXFmD1dO457Ik9/IV0wwyb4=;
        b=Um0UyzGY29/yeV3B8J1EKSMb1ZHfD2rX6Eaxv/Aibn/2vlfBj5zeTb7VK8Z6wyJce0
         oIHv8sayqnOo14JXFqpNp/Qs8TGIXdEFvOaC4EIZ0jOvsUwJn2XRISxUh/iKKFpXveze
         OEn7AvrduHKn+OSNJoK93SZyTw+9RVpF0aJOjpiLJWyhjCYBLzAvR4fkBzL7/8kXzats
         /5R51Kt9TiUpheJbuQqODiMmNPZ8QvTwTaZzHf1BFr4gP/5yOEJyVLtGb+xNDodMHFaH
         +1CBPrhJ2Oe/goGvPKISMfXOgQ2vGvsBSEaE+QIQvJE6fbYyTDhQVYxoEdWDGFNe8WhG
         iPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567908; x=1796172708;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtJSsEUQrJJTdnX0IwZhqXFmD1dO457Ik9/IV0wwyb4=;
        b=YSrwulWVKIb9mZ1bpyHyKF1E4iMC3v1TCtKw66mkVLCany0ETCMRFedgIXnDYvUlgt
         V0edvWXLzkn85izBbw0+xLzruy2N8bBUqvQahGf2WDuBNiZgCIIXO27uyvY9VBnLem0J
         lJTegdwb6To6ny5c86McO5PTu6Jm32QvZT0SLqtHHHf6L21FRW7oEV76Qx3INu6b2jtS
         JxjjNT1toEucXNyBHia9R2uoDV4XMgiKQhHI7hjbLLjIMOz+Nw/Zu9nXTgdE1v8EL7qN
         HdVo6p6HbZ/ND5UNH11Ji0wDYbGhVbDBLgkp/rQKf3+B8R3lQF8lnhY968MjeFb7ORFt
         t/Sg==
X-Forwarded-Encrypted: i=1; AL+hErEDyeat58I1tMGSRhSEioKxOQH24Es1sO7yuFd751a2xJG+/Ci7D8sOBVmNn21ZhShMqBmo3cz0QmRiwQJ+PYk1@vger.kernel.org
X-Gm-Message-State: APuU4Z8zTAX3kgHyp25/RWphdAmmzbhuXGjAH9MFrndQbg/OOuKRXjhY
	RXxlplwXVgpPrJyet9kIFG4euPDymUEv4Ab2gaRJ4UHGgvXoCQCJOjT53RCAwiiL84hIA21TeFZ
	OaNJyZvyF9g==
X-Received: from dlxx13.prod.google.com ([2002:a05:7022:408d:b0:1b2:4b00:1331])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:321:b0:145:287:ce91
 with SMTP id a92af1059eb24-1b5568cb6b6mr25829892c88.14.1795567907377; Tue, 24
 Nov 2026 16:51:47 -0800 (PST)
Date: Tue, 24 Nov 2026 16:51:02 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-14-irogers@google.com>
Subject: [PATCH v4 13/19] perf maps: Add dsos__find_by_build_id() and maps__find_by_build_id()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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
index 7a56577f4ec8..5dca53c5b258 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -304,6 +304,40 @@ struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
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
@@ -370,6 +404,40 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct d
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
index cc7e3a42f9cb..16b93cd5105f 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -8,6 +8,7 @@
 #include <linux/rbtree.h>
 #include "rwsem.h"
 
+struct build_id;
 struct dso;
 struct dso_id;
 struct kmod_path;
@@ -33,8 +34,13 @@ int dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short, bool write_locked)
 	__must_hold_shared(&dsos->lock);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
+struct dso *dsos__find_by_build_id(struct dsos *dsos, const struct build_id *bid,
+				   int dso_space);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id);
+struct dso *dsos__findnew_id_space(struct dsos *dsos, struct machine *machine,
+				   const char *name, const struct dso_id *id,
+				   int dso_space);
  
 bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 770ce43a4ce3..c6670fccace4 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -3,8 +3,11 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/zalloc.h>
+#include "build-id.h"
 #include "debug.h"
 #include "dso.h"
+#include "dsos.h"
+#include "machine.h"
 #include "map.h"
 #include "maps.h"
 #include "rwsem.h"
@@ -1307,6 +1310,76 @@ static int map__strcmp_name(const void *name, const void *b)
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
+	for (unsigned int i = 0, n = __maps__nr_maps(maps); i < n; i++) {
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
+			for (unsigned int i = 0, n = __maps__nr_maps(maps); i < n; i++) {
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
index 4e6eff244125..fbe5b6f47959 100644
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
2.56.1.831.g720f3f5937-goog

