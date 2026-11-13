Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590303;
	b=yv8H4ZPX4AjuGhbN9Mdq2DIDHexROMTgDmBejztNpiqzA66UUVSOL2+UjwC8VNXzh5BS
	 2xiVmXb4RSpjKtzz2drY93NwZ7DnRRmL9lr9Wlv9mjztk0chJTUe44JFmFI14P+X8OhTv
	 fmRz+4063fu1xM5O2KTJb2dE57++pqUULd5PQMc2BxHMk0uRmqch62ECecxAIR/R9FG0D
	 +Wn0oIrIkRFsaBlN9+6MOdB9R+ypmrrbUAYWVoKqfP/Vm1NVtZ1vkNxUiT2IivXDgYyOq
	 12USxbBZ3+uCJWg4SpKMKb+xsCQRHr0n2FqCz2ZVbUFAU/zBzPjI3uDIpxKGpLp33OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=f2c46wkoZpI0A4I6TtUSCqfba00YGgtYxsFs1XZgxPY=;
	b=0DYBcrykEW6jbgo0BTcATQpfCCS/Ej4Zpn5k2Z5zPbra/CwRB80anHX8uLZkyPC6CV8J
	 9/hizsTPcgGaX3Bjcjr8eHf66bJtlZO8iG4VbwFl8cugvoeeQLE4FIzgBmb+Lq67gl6TR
	 IPc7r3AIrm9jmifEsP+QpQ5Em8WjbfceFW8PXaFQz212Yktus1S0BjzpgOPlknOTPa1Fy
	 iQUuaKyea2eKKX0To8kmqctsqAid4hr546Pl1XWeyx1Y9L/83Lq7VdI6Bv0LSz4gxbZMk
	 gAWIUC7mwblEjEX1ctUrAwWTAgAydpGJDPOnjTpfO5OcGOd9O/yvoDVxaat6YbCX9zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N7twQQwA;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A45607C345
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A45607C345
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N7twQQwA
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-378722fd4a3so1400443eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590302; x=1795195102; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2c46wkoZpI0A4I6TtUSCqfba00YGgtYxsFs1XZgxPY=;
        b=N7twQQwAPxF7PcrDSuPQAC3d1dj0yBiP+r97GLSOc777QDF6F1qf8QfUQ2IfwBc68i
         Lj8g73EBZBlvr5thiYZRBAil10L2wmIPsxrefeZhEtOu2PYYdTXpoQ0+/dFK3wQSCJlp
         h5+QyZPkh02YZhKnwVU/+GiMqHqiXh/1we1YmS+Xallz/Hsm8muHTo9C+4bIidQi8q7Z
         YSr711rtMoscgdRch1rEmjWUHMT702NgfoP4ocCVEW0VPO0Z17uvjYDn25Sx4BwLD11s
         SwHSnrjI/S+8vG2gFdiaLiIwzttxunWbHYtv07q6Rsrb7zSapYg1ctrm+qYH49jiYtL8
         LzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590302; x=1795195102;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2c46wkoZpI0A4I6TtUSCqfba00YGgtYxsFs1XZgxPY=;
        b=x5SZOeBy8SRbGBunxg2tlbilH8An4nrg3aNA6uMlTX5Y8kceMetdgyeJK559FwywCI
         18HPkYiBT3VlPLB5tJvPfLZ9s4W+nw9WQclUaYSsH7U+osQu0gftnJRD0hOPrcca08jM
         MrlP4uoLmVDoutN2x0A0LzNn0neDHkaNA4frojUYKaJSD2i/N/mP1N6uTERP7hhwO5KP
         009annU6gVph64s04OZp3VF1q2szSegOXzeoiPsUXw4NhNZRjSvdY/mPaLbcbi1LmxXN
         Alx3C7j/mE+dF9stexEZd2XaQF/8G1DWGUonXrtt7+bIIwOhr1qqevFQceR+gat4pHDH
         Er/Q==
X-Forwarded-Encrypted: i=1; AL+hErEzlb+pZ9mczFnbAgydOx5LJWxdF6iCe2sdrAp5Hg2A59T5DwUOSKZcICjbn5qUkqSV2qGwGtgs4y9MIzvALz4T@vger.kernel.org
X-Gm-Message-State: APuU4Z8PWcAkJpeqf4zkBjRd4n3czq0zV5z8Tmvo0Fpukv2/BZ3qL22G
	JJPdhwuW//OJZEVpr3qRyOZJ4PUKeWhevk34R7EtaLIBYlB/X1Qr/DaW+8ilEb2YSFXk7y8r5Rx
	hpHUoF5pGCA==
X-Received: from dycnr21-n1.prod.google.com ([2002:a05:7300:e9d5:10b0:369:f67f:7a43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8115:b0:36a:1008:5815
 with SMTP id 5a478bee46e88-37963372d85mr2798690eec.5.1794590301638; Fri, 13
 Nov 2026 09:18:21 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:21 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-11-irogers@google.com>
Subject: [PATCH v4 10/23] perf db-export: Store symbol database IDs in a hashmap
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently, db-export reserves sizeof(u64) bytes ahead of every allocated
struct symbol via symbol_conf.priv_size and accesses the database ID at
a negative offset via symbol__priv(). This adds 8 bytes to every loaded
symbol across all DSOs even when only a subset of symbols are exported,
and relies on negative-offset pointer arithmetic ahead of struct symbol.

Store exported symbol database IDs in an on-demand sym_db_ids hashmap in
struct db_export keyed by struct dso_symbol * instead of using
symbol__priv(), and retain exported struct dso references in db_export
until db_export__exit() so exported DSO and symbol database IDs remain
valid across the export session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/db-export.c | 126 ++++++++++++++++++++++++++++++++----
 tools/perf/util/db-export.h |  16 +++++
 2 files changed, 129 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 6a5db62cd58b..e7b807e968cf 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -4,21 +4,46 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
+#include "db-export.h"
+
 #include <errno.h>
+#include <stdbool.h>
+#include <stddef.h>
 #include <stdlib.h>
+#include <string.h>
+
+#include <linux/err.h>
+#include <linux/zalloc.h>
 
+#include "call-path.h"
+#include "callchain.h"
+#include "comm.h"
 #include "dso.h"
+#include "event.h"
 #include "evsel.h"
+#include "hashmap.h"
 #include "machine.h"
-#include "thread.h"
-#include "comm.h"
-#include "symbol.h"
 #include "map.h"
-#include "event.h"
+#include "map_symbol.h"
+#include "symbol.h"
 #include "thread-stack.h"
-#include "callchain.h"
-#include "call-path.h"
-#include "db-export.h"
+#include "thread.h"
+
+static size_t dso_sym_hash(long key, void *ctx __maybe_unused)
+{
+	const struct dso_symbol *ds = (const struct dso_symbol *)key;
+	const void *dso_ptr = ds->dso ? RC_CHK_ACCESS(ds->dso) : NULL;
+
+	return (size_t)dso_ptr ^ (size_t)ds->sym;
+}
+
+static bool dso_sym_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	const struct dso_symbol *ds1 = (const struct dso_symbol *)key1;
+	const struct dso_symbol *ds2 = (const struct dso_symbol *)key2;
+
+	return ds1->sym == ds2->sym && RC_CHK_EQUAL(ds1->dso, ds2->dso);
+}
 
 int db_export__init(struct db_export *dbe)
 {
@@ -28,6 +53,26 @@ int db_export__init(struct db_export *dbe)
 
 void db_export__exit(struct db_export *dbe)
 {
+	if (dbe->sym_db_ids) {
+		struct hashmap_entry *entry;
+		size_t bkt;
+
+		hashmap__for_each_entry(dbe->sym_db_ids, entry, bkt) {
+			struct dso_symbol *key = (void *)entry->pkey;
+
+			dso_symbol__exit(key);
+			free(key);
+		}
+		hashmap__free(dbe->sym_db_ids);
+		dbe->sym_db_ids = NULL;
+	}
+	for (size_t i = 0; i < dbe->dsos_cnt; i++) {
+		dso__set_db_id(dbe->dsos[i], 0);
+		dso__put(dbe->dsos[i]);
+	}
+	zfree(&dbe->dsos);
+	dbe->dsos_cnt = 0;
+	dbe->dsos_alloc = 0;
 	call_return_processor__free(dbe->crp);
 	dbe->crp = NULL;
 }
@@ -148,6 +193,18 @@ int db_export__dso(struct db_export *dbe, struct dso *dso,
 	if (dso__db_id(dso))
 		return 0;
 
+	if (dbe->dsos_cnt == dbe->dsos_alloc) {
+		size_t new_alloc = dbe->dsos_alloc ? dbe->dsos_alloc * 2 : 16;
+		struct dso **new_dsos = realloc(dbe->dsos,
+						new_alloc * sizeof(*new_dsos));
+
+		if (!new_dsos)
+			return -ENOMEM;
+		dbe->dsos = new_dsos;
+		dbe->dsos_alloc = new_alloc;
+	}
+
+	dbe->dsos[dbe->dsos_cnt++] = dso__get(dso);
 	dso__set_db_id(dso, ++dbe->dso_last_db_id);
 
 	if (dbe->export_dso)
@@ -156,15 +213,60 @@ int db_export__dso(struct db_export *dbe, struct dso *dso,
 	return 0;
 }
 
+/*
+ * Return the database export ID assigned to (@dso, @sym) in @dbe->sym_db_ids,
+ * or 0 if @sym has not been exported yet.
+ */
+u64 db_export__symbol_db_id(struct db_export *dbe, struct dso *dso,
+			    struct symbol *sym)
+{
+	struct dso_symbol key = {
+		.dso = dso,
+		.sym = sym,
+	};
+	long db_id = 0;
+
+	if (sym && dbe->sym_db_ids)
+		hashmap__find(dbe->sym_db_ids, &key, &db_id);
+	return (u64)db_id;
+}
+
 int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 		      struct dso *dso)
 {
-	u64 *sym_db_id = symbol__priv(sym);
+	struct dso_symbol src = {
+		.dso = dso,
+		.sym = sym,
+	};
+	struct dso_symbol *key;
+	long db_id;
 
-	if (*sym_db_id)
+	if (db_export__symbol_db_id(dbe, dso, sym))
 		return 0;
 
-	*sym_db_id = ++dbe->symbol_last_db_id;
+	if (!dbe->sym_db_ids) {
+		dbe->sym_db_ids =
+			hashmap__new(dso_sym_hash, dso_sym_equal, NULL);
+		if (IS_ERR(dbe->sym_db_ids)) {
+			int err = PTR_ERR(dbe->sym_db_ids);
+
+			dbe->sym_db_ids = NULL;
+			return err;
+		}
+	}
+
+	key = malloc(sizeof(*key));
+	if (!key)
+		return -ENOMEM;
+
+	dso_symbol__copy(key, &src);
+	db_id = dbe->symbol_last_db_id + 1;
+	if (hashmap__add(dbe->sym_db_ids, key, db_id)) {
+		dso_symbol__exit(key);
+		free(key);
+		return -ENOMEM;
+	}
+	dbe->symbol_last_db_id = db_id;
 
 	if (dbe->export_symbol)
 		return dbe->export_symbol(dbe, sym, dso);
@@ -192,12 +294,10 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 		}
 
 		if (al->sym) {
-			u64 *db_id = symbol__priv(al->sym);
-
 			err = db_export__symbol(dbe, al->sym, dso);
 			if (err)
 				return err;
-			*sym_db_id = *db_id;
+			*sym_db_id = db_export__symbol_db_id(dbe, dso, al->sym);
 			*offset = al->addr - al->sym->start;
 		}
 	}
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 1abbfd398e3a..c56037644d62 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -21,6 +21,8 @@ struct call_return_processor;
 struct call_path_root;
 struct call_path;
 struct call_return;
+struct hashmap;
+struct symbol;
 
 struct export_sample {
 	union perf_event	*event;
@@ -63,6 +65,18 @@ struct db_export {
 				     u64 th_in_id, u64 comm_in_id, int flags);
 	struct call_return_processor *crp;
 	struct call_path_root *cpr;
+	/**
+	 * @sym_db_ids: Hashmap mapping heap-allocated struct dso_symbol * keys
+	 * to their exported 64-bit database IDs, pinning each symbol's DSO.
+	 */
+	struct hashmap *sym_db_ids;
+	/**
+	 * @dsos: Exported DSOs retained so dso__db_id(dso) remains valid until
+	 * db_export__exit().
+	 */
+	struct dso **dsos;
+	size_t dsos_cnt;
+	size_t dsos_alloc;
 	u64 evsel_last_db_id;
 	u64 machine_last_db_id;
 	u64 thread_last_db_id;
@@ -90,6 +104,8 @@ int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
 			   struct thread *thread);
 int db_export__dso(struct db_export *dbe, struct dso *dso,
 		   struct machine *machine);
+u64 db_export__symbol_db_id(struct db_export *dbe, struct dso *dso,
+			    struct symbol *sym);
 int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 		      struct dso *dso);
 int db_export__branch_type(struct db_export *dbe, u32 branch_type,
-- 
2.56.1.703.gf848ed807c-goog

