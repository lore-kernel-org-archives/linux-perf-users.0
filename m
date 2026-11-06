Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948650;
	b=4v0fK39NFtZpMed8aRv1BvsqNtzY/edwizegCG/Tlz3P39TYq2zToBxMyZhu/T3zy8y4
	 v1/RNPoPxUQLMKJLdgAcvmCW/4pgHTo90Eywau9Oo8kohoX+bBmE1fA5cGugt6i4l0oa0
	 jxPbA//lud76lQeX78dYIiW1l6vNKyTAuPs+p6wFZS59TcwgoikyWq9JZt2170cDwLZpB
	 jDT3Ehyoz5c0KaPaZQSio6c/no0dcgyiZV4gJLdx2ldHTPJbXU6mg9WrblDF9XhKcMJEU
	 IBiaM52wt8qIR+DpYie/tFopE1GRkU/ArENSfLiCTH8RZY15Aq7m6jJIelSpE1bfZcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Z8FMLs2dPMkAqt/fa4VkQyxWHnbdMIqVh4NcUaI4/40=;
	b=zlU4Kt3YX43yRdpgMatAzxRXqrTwoHZN5B0bjdBozTqTAPKcUb0DFSm6ml/fcOJ/+aqz
	 OY45n9xbCd+/Ulvk+SqT0EfxZRrFsFOVBf+Nh4QoUD6ohTyghEOClAASU1pgVnsQSVXVd
	 2waic3w5e9CWFPZygW7X3EuLUswOQuzxr79NuQvx6ko8KE8//V4N2ZsC/3pzDcXeXbbVk
	 nnsbQQQvJZiMxuxZbR06cg/5vzj2Sv/0aqB+RtRX6xpzbkrcwj1DfUpoU1IHAZIeTCiRZ
	 KEVMwRf6/h1m0MkVVEEW4GTWha5wrWxFz8kCt3H4jS7g9lN50HM+aX7cuZI8TIObUUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WkRqJcVS;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89357606D818
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89357606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WkRqJcVS
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3425098ae4bso2399434eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948650; x=1794553450; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8FMLs2dPMkAqt/fa4VkQyxWHnbdMIqVh4NcUaI4/40=;
        b=WkRqJcVSkPQQyYzcK1NoskmYEch0tdGUkvhCFtWmpgy20nQk9YpZU19q4RDo0rJUH/
         fTNEBBw1Je83hAeQeNNg0JQ9a8hVMWc6/tU8PiI0Xn+ny/x+Bu7kVUF/Q2K9GOGfgH9N
         ZfPYIeCncGP8311KfFzzF/Fsk0enkYqE/NqS67cCP+qm7ecx5x85jmv5McSaFBdKImQs
         RY9jrbwpQa7q0ALpPo7b/B7/fKsXF7YN0q/VUCij6OlhLJ19oA+RC8jyBHpof1u+6orh
         SJUwWgAnmEtv8C07STg3yS6t1blXjpayxyzTMvrBSJvaqYHh3QY80fVfpkPgJv9x2hOt
         6pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948650; x=1794553450;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8FMLs2dPMkAqt/fa4VkQyxWHnbdMIqVh4NcUaI4/40=;
        b=Jnakluk8R1yWcZ5wJxXlw+jHw2ApaUKnRt+mLLJ48vOVnAQYaHv3w/3lAAEZj+HhYH
         VW8RI9567nmBnOC9jsu32i1WNJ2xHVuw70acInvdfsub4BHb21gzKTO39hFGt5QOKDd6
         ZieKPncsX9jhdgJ3MhjzIgdO9qbTI/oVh0Aotso8T5QGDrUoRXqe9mmGeIipErOD+iXa
         Da/xG6LCw6R5+g2WxkBHPS15nMF/DQWlNUyi63v5t86/M7Ur2zHxLtv/54uuIj/P08NQ
         dnrZA2YW287scjqyCDwgCIWOccGvU3q19/ysC5BUVjAogMKqfg2Is4QUi++9dgnhISWs
         Kq+A==
X-Forwarded-Encrypted: i=1; AKwUvBxiqjFcKRj7svBqZ4L+W9weU8fdMQtlaXm0Kfez/EJcE6QDbFBZarVYWrcpzFC50RomeSDs300CS53ORcRcEsiU@vger.kernel.org
X-Gm-Message-State: APuU4Z/T7bNqRGeE5l7nsUYAQDvE21ObLFvhfDNOsKO8RDN/Wvq+JI0k
	lwDyDXDGASZ70Va9aT38Mou0AQ1wVujoNxK7oD6ahBE9KJVB88Sti0cdBjKMZmIqrfwqUAGBSEB
	vyNnGYQT9Ow==
X-Received: from dldz2-n2.prod.google.com ([2002:a05:701b:4182:20b0:1ac:2245:a27b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:260d:b0:1b2:459d:331f
 with SMTP id a92af1059eb24-1b24f4d01b2mr5780989c88.16.1793948649455; Thu, 05
 Nov 2026 23:04:09 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:33 -0800
In-Reply-To: <20261106070344.329897-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106070344.329897-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106070344.329897-10-irogers@google.com>
Subject: [PATCH v10 09/20] perf dsos: Ensure DSOs in auxtrace, machine, and
 symbol are in dsos
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
index 8bb491d389a2..1451de019df0 100644
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
index b958c6935a56..0044ea046aca 100644
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
2.56.0.455.g6c5a503b38-goog

