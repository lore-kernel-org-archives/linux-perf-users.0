Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142932;
	b=1luGnfkS4VfFowAK1Xph/UdtbB42Uw8Om+G4zdxGbphA8ZUXCVvTU+G4iCJNN+ZSebLC
	 0mdgePGcwV9mVNyjAdpxNQxYxe9gqkHmR9WGX98rvL9ZgwUczIjZqPKznUFCa1c+HEhVx
	 p6oKIr0tav6sWp+5DAFUCpwxKmsZN6EcsPSeK8eSBYWZ2b5P8iiFm5JqHd1ra1h9qEL8d
	 fUcnkgylKSC8h8LPfZ5R0O6q43CI/Fq/UNCdtQyd622eWU30OivWmNr5putrj6wkbiK1q
	 J4/grrlqn1G+QlmaJ+mwbFZP1Io9DY91af7U6aRch7zuMfYm0CxwscSIimqN1+5jlYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qkh/x6AJ4XG6xEtYvsuOrN7k/via/Wfd4AyxiYzwi4o=;
	b=Sfg6BKb0xh6Y2eibc1D86s8vanRwtpF22/Ib2kNJev6pf5FUdyHoRHP6+LRwA2i6hV4l
	 tmedXNSugDXTyymmhZvBmK/bC6IFl5h8JnedqPo70c1Ns0OD44W1Ek32Sszuwb6RVWOsT
	 Ra/SlHFtb/tBh7EYBcm/8QiFNN4E2rjq1XBTZ+YGZc+6oi295fYU3ZzA9uxyFboVWI/H3
	 jPMMhLg+k5a2YaleAW0pBbsPJ2krRmxW3d/uvD0+ZVej8V24uK7hhhz2WkQZaTwKpyLZx
	 8vg//qroQ5iOObmsnWSVZvYg40DH3KhA9jN2tPV7X/DYS2UYk6CzMNbs47pnf38b+ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NG8qxuyT;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32380606A323
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32380606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NG8qxuyT
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c5aef2a74so1257112eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142931; x=1793747731; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkh/x6AJ4XG6xEtYvsuOrN7k/via/Wfd4AyxiYzwi4o=;
        b=NG8qxuyTOFvjoP56uSbTbA65/XA9dTMX5ahR9fX5jDK/TQun4+XKkdLTNu26Mro6BY
         TyLVZ5mxDxtLEaIsRRI+LJr0SHg57U4xqvgug6c++Iu1RhrfP5kpucfn6ny653kkF3xy
         p3jWemSL4OgZpvOk+DWxm7Ilw3nO0ylmy5aGj9o6YeB9NNXZjrgC2YrqMiF3myWzwZPD
         vSlOfOcGFa3x05ntd7gOLwaJV2mzKEKXZ7ZNZemFPGcSv8Ay6EwTkSABNjL5Q3+4NXNS
         GSdf6TvaBczOWEOsESz3UDW9RrgL9IPLAG2fE6WG2DAXVGouNVt8D3gonFr5r47CghiK
         L2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142931; x=1793747731;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qkh/x6AJ4XG6xEtYvsuOrN7k/via/Wfd4AyxiYzwi4o=;
        b=0GmseHeshsFbcRrTJINgZavxJg6OnE7UN7nUduUiZg6S+Fg5Gn9Mt+4BBkwi3280ea
         a24ivvhOu+i4nEDX2vCGjNdLtKhcBOca52AfJ4Xbs238+JTPry/R5ZHMEVbF5lquS53q
         k5nTZn2sTm0TdsUIfrmEFN026aN5skBikeKYx68Dw4KALA8ojANdDNCs+xt5mEEI/D4Z
         WrlWks0XkoE9CBwLScOSUBpf41B9PZp08HBOOO56GmhQEyeJmGE4JATraJrZmg9vzj7d
         EjJ+XpAMBhjZ0GlozerCLSqIhbDlZG3+RbSVFtW1ok8SVWvSCIikiVdi5/n7U6IzzHjq
         cyFQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9fZLlC+eMpk2dpBZXitbNGBxqOpLrXYqs2vAZksi9602lNQQO4RTHgpOXBV9RRQA5ZMNKFvd6kbDZzrwDZ5e1@vger.kernel.org
X-Gm-Message-State: AFq9FYIk+6FI1ELzf7zEsqFtA1bN356cCEbCvydU51j7p+FeXNBdkSVh
	tj/RU6X1Tqgg9qgWCiYjVCj7yDl2rbrN27clOUHskf6UgySy2yR1jPG8c+nfT2/+plpjSy6eyVI
	BRRUaZFolUA==
X-Received: from dybmh14.prod.google.com ([2002:a05:7301:f0e:b0:368:94e3:9219])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fc0b:b0:369:fc93:eda5
 with SMTP id 5a478bee46e88-36a20467129mr1040663eec.39.1793142930570; Tue, 27
 Oct 2026 16:15:30 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:14:59 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-6-irogers@google.com>
Subject: [PATCH v2 05/18] perf db-export: Store symbol database IDs in a hashmap
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently, db-export reserves sizeof(u64) bytes ahead of every allocated
struct symbol via symbol_conf.priv_size and accesses the database ID at
a negative offset via symbol__priv(). This adds 8 bytes to every loaded
symbol across all DSOs even when only a subset of symbols are exported,
and negative-offset pointer arithmetic ahead of struct symbol is
incompatible with wrapping struct symbol in DECLARE_RC_STRUCT(symbol).

Store exported symbol database IDs in an on-demand sym_db_ids hashmap in
struct db_export instead of using symbol__priv().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/db-export.c | 68 ++++++++++++++++++++++++++++++-------
 tools/perf/util/db-export.h |  8 +++++
 2 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 732369fe0046..6ebc060bdb8f 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -4,21 +4,37 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
+#include "db-export.h"
+
 #include <errno.h>
+#include <stdbool.h>
+#include <stddef.h>
 #include <stdlib.h>
 
+#include <linux/err.h>
+
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
+#include "symbol.h"
 #include "thread-stack.h"
-#include "callchain.h"
-#include "call-path.h"
-#include "db-export.h"
+#include "thread.h"
+
+static size_t sym_ptr_hash(long key, void *ctx __maybe_unused)
+{
+	return hash_bits((size_t)key, 16);
+}
+
+static bool sym_ptr_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
 
 int db_export__init(struct db_export *dbe)
 {
@@ -28,6 +44,8 @@ int db_export__init(struct db_export *dbe)
 
 void db_export__exit(struct db_export *dbe)
 {
+	hashmap__free(dbe->sym_db_ids);
+	dbe->sym_db_ids = NULL;
 	call_return_processor__free(dbe->crp);
 	dbe->crp = NULL;
 }
@@ -156,15 +174,41 @@ int db_export__dso(struct db_export *dbe, struct dso *dso,
 	return 0;
 }
 
+/*
+ * Return the database export ID assigned to @sym in @dbe->sym_db_ids, or 0
+ * if @sym has not been exported yet.
+ */
+u64 db_export__symbol_db_id(struct db_export *dbe, struct symbol *sym)
+{
+	long db_id = 0;
+
+	if (sym && dbe->sym_db_ids)
+		hashmap__find(dbe->sym_db_ids, (long)sym, &db_id);
+	return (u64)db_id;
+}
+
 int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 		      struct dso *dso)
 {
-	u64 *sym_db_id = symbol__priv(sym);
+	long db_id;
 
-	if (*sym_db_id)
+	if (db_export__symbol_db_id(dbe, sym))
 		return 0;
 
-	*sym_db_id = ++dbe->symbol_last_db_id;
+	if (!dbe->sym_db_ids) {
+		dbe->sym_db_ids =
+			hashmap__new(sym_ptr_hash, sym_ptr_equal, NULL);
+		if (IS_ERR(dbe->sym_db_ids)) {
+			int err = PTR_ERR(dbe->sym_db_ids);
+
+			dbe->sym_db_ids = NULL;
+			return err;
+		}
+	}
+
+	db_id = ++dbe->symbol_last_db_id;
+	if (hashmap__set(dbe->sym_db_ids, (long)sym, db_id, NULL, NULL))
+		return -ENOMEM;
 
 	if (dbe->export_symbol)
 		return dbe->export_symbol(dbe, sym, dso);
@@ -192,12 +236,10 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 		}
 
 		if (al->sym) {
-			u64 *db_id = symbol__priv(al->sym);
-
 			err = db_export__symbol(dbe, al->sym, dso);
 			if (err)
 				return err;
-			*sym_db_id = *db_id;
+			*sym_db_id = db_export__symbol_db_id(dbe, al->sym);
 			*offset = al->addr - symbol__start(al->sym);
 		}
 	}
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 1abbfd398e3a..2e0cf2dfa281 100644
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
@@ -63,6 +65,11 @@ struct db_export {
 				     u64 th_in_id, u64 comm_in_id, int flags);
 	struct call_return_processor *crp;
 	struct call_path_root *cpr;
+	/**
+	 * @sym_db_ids: Hashmap mapping struct symbol pointers to their
+	 * exported 64-bit database IDs.
+	 */
+	struct hashmap *sym_db_ids;
 	u64 evsel_last_db_id;
 	u64 machine_last_db_id;
 	u64 thread_last_db_id;
@@ -90,6 +97,7 @@ int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
 			   struct thread *thread);
 int db_export__dso(struct db_export *dbe, struct dso *dso,
 		   struct machine *machine);
+u64 db_export__symbol_db_id(struct db_export *dbe, struct symbol *sym);
 int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 		      struct dso *dso);
 int db_export__branch_type(struct db_export *dbe, u32 branch_type,
-- 
2.56.0.313.g2479322e68-goog

