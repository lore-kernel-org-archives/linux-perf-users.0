Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026487;
	b=Dvju9thOaffk/8eAZCN1VNp/4g3nMQAA4YHUVbcmfxfJ+aC59l9K5f0t24KoPVqESokq
	 AcftGPAwhlgGJU4dpQ111Yrc7C/So+3noWohhQn8+OOQ6o2Jxm+Ct2o2QPCjqfm9Ku2Jf
	 smWiHE8AduBSN1hjOPDAvUX/RJ/fn5+EsJ7jbwR8Amw/STtAUrHLBLlRtnrpJhO8XKHAR
	 GM+VNWlDyw/tnZ8iP02ZJJV9qSugYyPES00Y1zWyvRg+nMEFHzocSv8/lVtXt+V5oK2AK
	 ysC17PmMh2+mPTgbuTCETfZSdKBcm63X60pHrHnSp+6jK9/TZqrPcaLwhSfzsrIqxAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Z8FMLs2dPMkAqt/fa4VkQyxWHnbdMIqVh4NcUaI4/40=;
	b=3gBfp8ek2d+vhChHgLBfYxY/8Ey2U/og4H2xllWxNNa6uh9+1MNNJxg5tqKN/6u/8xrA
	 8p2T+s49VAkj/USQ4ROMxWKA+hA3C09xUmhH9WmtiM/9Nl1feMRfKJn9zj9g1TLJqplNL
	 oYpEbpzdGFqEcMl55Xqbw98sBIoLdE0Q77K0Y6RHMDzrz0DZF7VI5tJdBbdM5xoNVvBNz
	 D4c7QNn/IH+ppY0IxXr2wfoAjMXHQKLDfnvAbehx0ibZ4+7MkOaz0nv78hCi3tf9/gSx8
	 AVg5P/a2VdZEovPs9whUXXItGsNCBh/ZHpEEgmdY8OL/t+xT493jSQwWBMrK/ntZwow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hojnCVtj;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D3606D806
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F5D3606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hojnCVtj
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2226247eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026485; x=1794631285; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8FMLs2dPMkAqt/fa4VkQyxWHnbdMIqVh4NcUaI4/40=;
        b=hojnCVtjrC5R3AWhx3lUXxeHnRuMpOhmgiEoQE0JZCjlb50nAqnmymn8ojKnD2shRF
         BN2QI3XxtvaJaWDsViKywj4h01B9BevprTMjTvr6SIissSoXZUFjYX9aVBvxX9rDQ4a3
         /MaURFNF1pxAVj9hHjA82YEHqSOT+GV95i4zbi71J4YPw3hFKrkbzvxidElYQA73Q0hw
         w/zuKyCu4AnjmkA5Dv9n0HAedwkGDopofhvYHMfHz1ACjCrFV01I5oBryC5iuClDOtp0
         JMPc4J3h3GW+YIcj9RWUuCd6S7brtrFDdPH+aR5cr1MhIcIzod6dNU0MPHgv+GDoVwdx
         RWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026485; x=1794631285;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8FMLs2dPMkAqt/fa4VkQyxWHnbdMIqVh4NcUaI4/40=;
        b=WJXo4yEq7pzqjGPIze/8RIxMDucQ9/egrkVJgk7m/VgYbAAl+JK9jPQWbh8QFve/3R
         KsZTCI06vXd5L7nTzUtxWLz7IpHOutYWhs6qXOUotCntHJmnh+8Ecyk6Ftafldw6k+F5
         42ncQ86H+LRMFckEP0moAgwIiUfETz3wt0kKr+QsgO4BILZSft9OP4jxdjtvgUxQks59
         DYuJQtZzG5+sGxEwfwoKAjkItzkU335/xxtrIwDpQaOE4Zjh1oKEoCxj0j6EPKmZwypJ
         CSzMNMB0EF+66P4S0h9BSYF+lrUa+VYc9by78712FuxYYVxLgegfLEqpFGR4K/qyMsHV
         oD0Q==
X-Forwarded-Encrypted: i=1; AL+hErHpNW822CUuZ9/YroUJRFAZ4y2SAlYnlgMoDP8SQPF9zraCaOKrd81IcV0BeV4elLDHSJyuZHq7MTrZJRmfpJu6@vger.kernel.org
X-Gm-Message-State: APuU4Z91VtevX/pj5cRGkD9WfVRx52btKkr6E/nsYZMdFaAcytb3ECF6
	NPoig4bhD5tSQyUX+IHvHVBJtRHUYdks1uVGRVbr4arUNcX6h4K9GZvR7BthxAelXXs6i5WSniw
	e/AqpYim5FA==
X-Received: from dycnm20.prod.google.com ([2002:a05:7300:d194:b0:369:7ef0:57b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2585:b0:36e:fa91:b6e3
 with SMTP id 5a478bee46e88-36f75838d8amr5926963eec.17.1794026485167; Fri, 06
 Nov 2026 20:41:25 -0800 (PST)
Date: Fri,  6 Nov 2026 20:40:50 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-10-irogers@google.com>
Subject: [PATCH v11 09/20] perf dsos: Ensure DSOs in auxtrace, machine, and
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

