Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700130;
	b=YO78TFd8SRn1xcAwCjJE/etDQiMO/NB6CU25hivb9lCu1oH0PcwTP06uBSdWdj9BY+ZG
	 pSS9pnVmBV5z7yaLZcosRbuSvBq1PdRTtvyJJnVbQ2SUXziHgbdTIc6GaUf4BXcCVWhpH
	 uMSg80DQyy91wOCzcFhNAcvU5/c2BxVPz53yGgiI6ZtFgSJ5QgugX/Mydg947Zk5vjqGd
	 Y1LAWQnPocSKWXZQ3fHve4p1JaMX/Zrz5jyBXVUuz3knWeZAbfSOMVGRuEAiqYapeGzlo
	 qsqdiG/enst9qPn165wB0Dfe+o+wSb3T8fOrdkHn1H981Zf7q+sVGIicNQb1jchBz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DnxUFuKhILNaqIex02bJDLwWD3shsgeaS+0XyX4ymrc=;
	b=R+/zcenv3C89ksFc5RziIMAN00WnOt6FtFkO3SXsNkyfDElVkHzNSmMwXuS4REGNRs9E
	 iV+lXo+fHSsQ9RDT2rq0+83v2vhYmXBS03OMyUkSxx1qLBV8ux8m9HbqOWJguV/OVl75s
	 nPHhEya5eKIZbkHntjvEoaVtMAuKiRQGIA36Q9TZ9X/VlKYX8C7rQ4k1hus6xuPxdITKw
	 cI6CI98+a1nrGfSzpUkrFb65rHyjaNo/Dqp85BUS9E2Rcuzn3X4oH1r4cb8dJEQWXWISd
	 hCBbK8DonDN6DvYw/umBbCFXs0UIE86GmfkBfDug2RYlROkJok/1ascT/r/KXC/qiSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PEBNHHkL;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E44606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1E44606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PEBNHHkL
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso245942c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700129; x=1793304929; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DnxUFuKhILNaqIex02bJDLwWD3shsgeaS+0XyX4ymrc=;
        b=PEBNHHkL2J/W9Yek1ZPeFdZf0+GIxrbUQSz/X3HEFkf24EgwXTnTNKZyqrc832b0nM
         jdtjm80VVLcmUZHMaPE+NgNjVbvKb+mcyLdOq+ue7Q8Ieyk13HdQhTrSbynfU0Fqn1cL
         xDOhzjksTxleZQxwbQu1cEFsRI5Fv0qYZeyv89JvumIy/gyfH/y/Paxlh7UciMBuBQaO
         MzTPDaW87LM+OCSYsxXR4KY4JJNppE8LaJ0CM4gV82DJW1Ln69wQviszBpGvzFs+AT60
         YXCJ/ccNIiN8ikADwMpq6wxeShycyu7ScrvAy2dlWdMo9pViqpnLJR5ouoc0umlSQQBQ
         uY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700129; x=1793304929;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DnxUFuKhILNaqIex02bJDLwWD3shsgeaS+0XyX4ymrc=;
        b=dmdrSbKd/fuLJQlqWuGIKdxMIekWLEKdM95FTszZ2NUSpl/VokuRUjTyLffWEmOsfx
         2i8mwVtPT4PP0ODmDcwXyOVicQLnsGPCBZpXV/HLcrKzUm3iH6InpUSLEY3UZVa7yYcB
         hU7PH5YgvhzciLwCmbwr20XIH0UJddt/NlZMOsQ0A/GVYBRIbCQqSMl/VkmMs2NACuau
         teSjQNYKmEOcKcXw40H8sNZ8SC1mk0Jq9ZkDCVw2VsZQewaiyhbalHZVR+oNao0BFp+N
         ZQ7x0BFpwzcJPyjmLn8ZdA5s1lKRr1/vRp21WtQ9/9dMx+K3swgMDbJcvXi1UBxtGVfR
         ga6g==
X-Forwarded-Encrypted: i=1; AKwUvBzPJI2bp10mt9EOI5kJyO6YhcwMNvOw9YH+Um9zjMFV6K4AwXm3P2YuL8FRJ2c5bx7WturVCiGqE6JSGm67m0lb@vger.kernel.org
X-Gm-Message-State: AFq9FYLWtpLMdrEl2/dSfkyROpJGTM6uC9300UEnehPxJ4MkLxKjSS8Z
	JiiZo/mq3sjr13jIAcyKfFxt20Oo4yIegWapYUA7a85X3INxIEz35rj6vGQY0/a3n710gIbwR0q
	KksycG2ZfIA==
X-Received: from dled1-n2.prod.google.com ([2002:a05:701b:42c1:20b0:195:98a8:914e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1213:b0:178:d38c:eafa
 with SMTP id a92af1059eb24-195c59dcb8dmr364254c88.21.1792700128457; Thu, 22
 Oct 2026 13:15:28 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:42 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-10-irogers@google.com>
Subject: [PATCH v8 09/19] perf dsos: Ensure DSOs in auxtrace, machine, and
 symbol are in dsos
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Place the DSOs created in addr_filter__resolve_syms(),
machine__process_ksymbol_register(), and maps__split_kallsyms() into a
dsos collection so that all DSOs that may have data fds opened or be
referenced by maps belong to a dsos collection.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/auxtrace.c | 16 +++++++++++++---
 tools/perf/util/machine.c  |  4 ++++
 tools/perf/util/symbol.c   |  4 ++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index f30f86156a3a..5fdbd77eb451 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -29,6 +29,7 @@
 #include "config.h"
 #include "evlist.h"
 #include "dso.h"
+#include "dsos.h"
 #include "map.h"
 #include "pmu.h"
 #include "evsel.h"
@@ -2684,7 +2685,7 @@ static int addr_filter__resolve_kernel_syms(struct addr_filter *filt)
 	return 0;
 }
 
-static struct dso *load_dso(const char *name)
+static struct dso *load_dso(const char *name, struct dsos *dsos)
 {
 	struct map *map;
 	struct dso *dso;
@@ -2693,6 +2694,11 @@ static struct dso *load_dso(const char *name)
 	if (!map)
 		return NULL;
 
+	if (dsos__add(dsos, map__dso(map))) {
+		map__put(map);
+		return NULL;
+	}
+
 	if (map__load(map) < 0)
 		pr_err("File '%s' not found or has no symbols.\n", name);
 
@@ -2794,6 +2800,7 @@ static int addr_filter__resolve_syms(struct addr_filter *filt)
 {
 	u64 start, size;
 	struct dso *dso;
+	struct dsos dsos;
 	int err = 0;
 
 	if (!filt->sym_from && !filt->sym_to)
@@ -2802,9 +2809,11 @@ static int addr_filter__resolve_syms(struct addr_filter *filt)
 	if (!filt->filename)
 		return addr_filter__resolve_kernel_syms(filt);
 
-	dso = load_dso(filt->filename);
+	dsos__init(&dsos);
+	dso = load_dso(filt->filename, &dsos);
 	if (!dso) {
 		pr_err("Failed to load symbols from: %s\n", filt->filename);
+		dsos__exit(&dsos);
 		return -EINVAL;
 	}
 
@@ -2831,13 +2840,14 @@ static int addr_filter__resolve_syms(struct addr_filter *filt)
 
 		err = check_end_after_start(filt, start, size);
 		if (err)
-			return err;
+			goto put_dso;
 
 		filt->size = start + size - filt->addr;
 	}
 
 put_dso:
 	dso__put(dso);
+	dsos__exit(&dsos);
 
 	return err;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index cb77e82ed842..5135ecfa0467 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -775,6 +775,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 				dso__set_long_name(dso, "", false);
 		}
 
+		err = dsos__add(&machine->dsos, dso);
+		if (err)
+			goto out;
+
 		map__set_start(map, event->ksymbol.addr);
 		map__set_end(map, map__start(map) + event->ksymbol.len);
 		err = maps__fixup_overlap_and_insert(machine__kernel_maps(machine), map);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b61a574ce9a3..686fc48841c6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1090,6 +1090,10 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				dso__set_symtab_type(ndso, DSO_BINARY_TYPE__KALLSYMS);
 			}
 			dso__set_loaded(ndso);
+			if (dsos__add(&machine->dsos, ndso)) {
+				dso__put(ndso);
+				return -1;
+			}
 
 			curr_map = map__new2(pos->start, ndso);
 			if (curr_map == NULL) {
-- 
2.56.0.307.g5fe7bd680c-goog

