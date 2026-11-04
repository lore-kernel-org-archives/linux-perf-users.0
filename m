Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825978;
	b=STcfajnLofe2QKh7p/xB5runvXhu5rMe3EPV6FQd9QRlvfzrVHmazscj735g5+vSsQJy
	 2DBFoiX02gwtEjcx/7g2rHhA+ZAAz7R/VUJZ4Lv4juvk/zqKDG/5fWN6/1ApGHNXH2hKU
	 +Guhqy8BrYVmET9b6wI5RjT1HWvj/Lg2EJVT1N2oFFAP+bIzNX0+bhOUAVGYGTEA2+5lf
	 LLxBY6rFxsWQu4y5HPv7pfak6NivpuEAYjUtKxTSwkYp5XnsftTTkdekTRdBodjGoLu3j
	 JftTHbOIMLdzMsExYIdseI2jZ57Wsgu1+C2mFYc8ritsOOsr2Jssdp4sRwxA0eeeuWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Z8FMLs2dPMkAqt/fa4VkQyxWHnbdMIqVh4NcUaI4/40=;
	b=f4A2nAA1HSy6IdaCsZuDb1Z3DozBGRM7F1a2Yiri3IgKnzf05g3FuuKmAZglQqv3Z76D
	 CH+xQmr6vogGtvxGey2T60Q+0K8w158sesHslkGcfPxsu1gtIAxOnJ4AkazxjEoIsWPrb
	 4iH+IoRGHcI9MCJjpx5LZyY5yPj/8ADLv/6UO4rSG4obWW1NLn9KdTWlq0FyQaqakVKhI
	 lPBUTkeDM1ZNyfqItVl5lG4MHGie5FtlzBkF6W6zAaML1oSka6SQYs/TFR5Qmqp8em07t
	 t2k1DuAodkBu/dgtYQ2Aw53c9zALcgb6t+oNGAAzFc3PuyHpVU6fhyz1BmKuU9lsU6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lR99fMSi;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3D609ED66
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C3D609ED66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lR99fMSi
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed05900df7so9271425ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825977; x=1794430777; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8FMLs2dPMkAqt/fa4VkQyxWHnbdMIqVh4NcUaI4/40=;
        b=lR99fMSiVEyl4eYNQgSitZr29luUNETsG4OYFPuPHEXoRu9Ei1HkPLaIEVNqgcY/QP
         ZXkPztIzDIR++TrANHQsi6pVGz5mPar/DIHSpZI0fjs6iwVM7YaCPgvLbLmmP9JW3Rtn
         wtECDQRdjbtCjQH1hCQyikUMx/vJXzhNC8iUQM+UsKg4QOhRDBH/iZ2K/1ykkFGLwIxE
         1ewdtOmJSHzSCMKpDa5m9RQHFlsgOROTXW1xdQf1G5BnxqY5r8C+OB6XF9YFnlAgNENh
         yH5lmOlDyhw8CWesZEsCyEkj/gxyBkFKM5pQuzQobsPehzrunM6Ot5TxW2kf72qskG+O
         0TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825977; x=1794430777;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8FMLs2dPMkAqt/fa4VkQyxWHnbdMIqVh4NcUaI4/40=;
        b=m7LdDEBI/s+rEVri8XYuJxbTnCptHMti1O3AYLaWD8FVDJls2z2fXTgWesq0BD8+y6
         A69lVA/wZfyQxMLLfvz7S35DtVsdOVx9+7WesANURTGh601LXCN0oUenfudBsc7k5yNS
         TLwr/Vp4O8Hcry8O7Mc9G9h73L51oAg+MvuO2HTTpzKr/AuAbhwg2LEkghQv6krI1jRg
         GPXcHurgFHFLH27lIrwTci7r6hXzTt1nNo1FMHR4l/5E4JllCLou8BFuhaAFkXkW53Jj
         in03TojAsQI/l+HRGf8OMf4j5ihNSsyHzFjsi3Ow2d5S1IfTSsRB+ptbt/opTdc959Y/
         /Tsw==
X-Forwarded-Encrypted: i=1; AKwUvBwI0QmCpfi201gYyj1h7Rqwp+Sk4UA6zlBlj6TiC1nrGCJN7LLhPn+FmBBcy/S/NhQudZ0uAdpXP1Kqb8qtdBn4@vger.kernel.org
X-Gm-Message-State: APuU4Z+qOshISdM+s1/V2R5wBR+IBlIZlLbJiBcZOBbtR4Qh6Ew/Ms94
	0kcWodfVKSfygUMDokVGksfwCVzcpA9VY7MhwQWbowippfce1ES43IF7lj7ClrdEmE+vZY7xLMH
	8MTFcRRWmWQ==
X-Received: from plbbi9.prod.google.com ([2002:a17:902:bf09:b0:2e8:31af:11b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6c:b0:2e9:73db:3c78
 with SMTP id d9443c01a7336-2eb3649bef0mr161018445ad.17.1793825977087; Wed, 04
 Nov 2026 12:59:37 -0800 (PST)
Date: Wed,  4 Nov 2026 12:58:59 -0800
In-Reply-To: <20261104205909.2078411-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104205909.2078411-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-10-irogers@google.com>
Subject: [PATCH v9 09/19] perf dsos: Ensure DSOs in auxtrace, machine, and
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

