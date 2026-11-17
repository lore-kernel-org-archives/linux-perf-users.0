Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941363;
	b=kdU9NAzPbsu/WnSHwZ1k219iBgyxVUDO0tSxTS7x0ObpbEgemuqvw0woeCA0krR0jSKs
	 v5Oc5gETOp6gkL7sTlpN6XnDt7+uKwhShnXOHZPyvywqLcMFwzUFuGkT0qzi0PZ/vZ/gp
	 mVheNHaJN4TDlpVRpHh3G9+a4JGjuNIJH6PnXZyMDp40/BYN3nMo3lkKZZ9DJKZrKXLfn
	 6DDoUhEQZQuT0bmCddyL38Y8IFCLO8DiU/Ei1GWAcAIxQgarhZjwp6mudDAHH5ocqPXlB
	 SoiVAZDANmVy05A5cDSU26Uzk2f8IKL7JMV23gzc6olymvuJrMLrs9o/qnEo8yCwHsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hgRklfDHPH2ZDGZe1scZDClSfV3P8wPVDqeqp2cvAD0=;
	b=HczmMCM6dCmL7Xr4EEd426kkHCy1jI95fAjIz2nFrifnkQO7MGqNBBRay30eWI+ZUTgu
	 q260tHQCR1qWMxeLJV4GqGSrpxaWOBbIzsZxPIeGP+TF3l+8c28SGkTosALP1W+9umgbU
	 3DFpBmA8333X4c8aw2msyh8FyGiEM6asr3nrheInDg9tvBqxYVA50vK8BjrYb08XRCFkO
	 Kdrm/zA25DerbMNKLLSbtOWQVhZTKMlpFKBGRYlN7DMzTTEk1AFu0Law939cVz4ri67lI
	 LT4AXpH66yt8pppg8G1j2EvnMwUaNj9ExPaDRNU7yO96MgpfmFMzXzF9Ij7bN4enbnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jWxCBsxW;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B9606A893
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D32B9606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jWxCBsxW
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b53bfc9534so73026c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941362; x=1795546162; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgRklfDHPH2ZDGZe1scZDClSfV3P8wPVDqeqp2cvAD0=;
        b=jWxCBsxW5cpAbT1f0mCzC54OO1Tl64IDoCKE2J/fKRBY1bO7+fYHevS7LJWVxOLEE2
         Ar64p6u6EwALiSF4CfgZsr7GtgtXqMT8b8OmxGC820WlaZ4YLQbWSKq7xxbxKipwXcwK
         Cs8rmK+MxOAwEM9/fpgyxiCKD+LBg4BfJeXFd7JReNOtojONFeIUp/g9FVEkIJha8YTw
         qEMWYJp2XabReC88LP/z0/bYIhsgaVNUCAE3BqmaaTwIFibLg9s+TisHi4wu+H34u3Ha
         NSMAGWS07OxpA2BUAiwcNNy0nusGzMhTPLVHfVuq6h/fW3lCLVf04POiK6lNJQ0dSgVI
         MatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941362; x=1795546162;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgRklfDHPH2ZDGZe1scZDClSfV3P8wPVDqeqp2cvAD0=;
        b=iBHipUAM7XWkx0Be7s6nNMHk7s7mOBZHWyy4pSouxUBdJR4lVsySI3Jd9kEv2noHDv
         RO1R6FHNt2JK2kdeuaDcSyqHrTMNATlDKBbQWXktl2g4AjZu6zCq5mRTJ8j39Dcu9z6e
         qxzX5GrNRHXrXu7Sxwl2BdQyzC3si0x55ETno2IZTKQHh1DnXp45ikdfzT8AceQz3VwU
         Xe6AFX/oxJByqpdjcx1Tn0CKQqHp7mIMPH+jHc/awwzM4kScZq8rQW6dIaWwHwurKaTj
         y2toVa1miBsbKTj9996VVQIr/ZSfWSYAUvGtqYFkEcDUMupNrMOQSKGB/Xg8OuOuwRHN
         0GMA==
X-Forwarded-Encrypted: i=1; AL+hErFk6aTzIHHDbQT5LE4oeOnoxrxnpvWTwxOGwItD7D+jF1+Mm5AqjVDevBBsXGowLA40ME/ie0ARUd+djccM45cy@vger.kernel.org
X-Gm-Message-State: APuU4Z9HLgHd1PNqgbyMuMIV8Sw562Mypf+ur1+fILlRqBoSuxII9bHH
	c+SfDWkBhYFk38JKfPVJg7UPbMLItx+JCGRoXFHd0TNKghsuzxRCFzC4DZ0X7LAAahTWysXcFbP
	Nmk0v5BrKVw==
X-Received: from dlar5.prod.google.com ([2002:a05:701b:21c5:b0:195:d59a:94bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea46:20b0:15e:9126:c60f
 with SMTP id a92af1059eb24-1b543cf2943mr399741c88.29.1794941361787; Tue, 17
 Nov 2026 10:49:21 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:30 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-10-irogers@google.com>
Subject: [PATCH v14 09/23] perf dsos: Ensure DSOs in auxtrace, machine, and
 symbol are in dsos
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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
index 4a3461d79593..02711995f0b6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -797,6 +797,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
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
index dc70bbe8514f..a7079381fae1 100644
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
2.56.1.703.gf848ed807c-goog

