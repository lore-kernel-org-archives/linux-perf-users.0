Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588140;
	b=lstUUfZx7hWKLjP/E5bCmOkGbYUwV5yE3qBplwgDRSAHOCxdPtQuaqX7cTbtF7Nozffz
	 mm1mW/y0PKa8HbBi9+l7siQciq8NGkDo+Fxf+TmCqp6WmRXk6E9G9bekKkT+MVpf5o/YB
	 tyYPP8+9tWV10A9OJa5UXMVKRmv4gbIBN0mZUe5ZVKdRRvNNSf2MrMx9k4tSdgKIlCr8U
	 oLc/mMpRUWyCK2jzLzvyLegCpKI5U+8gybbleTOEhm8XDUE+k88QvuBtEGXnLa7d0GwA6
	 oPtIT34w8klzyU6bbjBkYscj6iFKcCkiQxNfDRGr0U9n3OnKAnlSqJ/Y26wd5ZXYzOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RfLu9tkRN1kJwRk3/VYq7SNcEmQDBBjwxB6gBcjpGs4=;
	b=cmnpih5UtFKcFVcLUFxHw0N4CO0ezGozeT6C8XbrfXZ/AX9qRlDbFuRCfGYVgh2Qj/zC
	 8iEoObfILk3EAqOlN0OW2Fzf+P5svYfbCJMyGneP14cD5/Oc1qVMjAVH6LKV2GT8xJ4Ld
	 4NB8nZTAgcFdlisroeMNfARvjtUvprByL88SrYg61FnzNWI3ZyhxGHYtcjjQYtfGIyrYm
	 ixnVcIWtqHMKNY+ngUJgGJztgSC6jRoID3ZORcf7xU3A+L60xsFMqUUD54ibJyUL4+yGO
	 d6AiS0n+e1QlKtNOd2C5QIS29coaHU2Vm8fn3UEfasd6a07mJCUIL6jnWSHYTUir22w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kN7wwvRd;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0560A260C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FC0560A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kN7wwvRd
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so4486730c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588139; x=1795192939; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RfLu9tkRN1kJwRk3/VYq7SNcEmQDBBjwxB6gBcjpGs4=;
        b=kN7wwvRdnk6IcjRMsYuItAefz6vE3PynzUfpiWJGWKt2bnlP/F+cB8JShjaBEDRDuv
         5xWeYo15Rh966iCCL9l0FSKfObB1/26/biWQf1ZkeeuqYQVagv3lAxLriJ7fdtdWztm+
         TmucM0YXuan8fHAosDUDFWKWPaUdXDNw0Gh/dAv6XCKcDtI5pmD3lqUg2x5CMZNQKqT/
         RkYesh1ENYRgf6QrHJKvwtPYU7Lb5n+x50eE6fGDfQRFd6d9rD126VfuwJEfUjiOIDXP
         K3ka1I9/tVYTKeZ3xNigubVwked9hxbU7pqqSIawj0RXmr6h6/W88d4NlxUDjR51f0yK
         gx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588139; x=1795192939;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RfLu9tkRN1kJwRk3/VYq7SNcEmQDBBjwxB6gBcjpGs4=;
        b=mgojlSxz2FOKmLAWGxd6gnnkF9qCxWdJi4TXmQSVJ7Auy/DX/otRd/lCqV+RxWfU61
         f9cKRU5f9CpsJ87bfQuZeuXt6x6gHjWM3SJqsOc+eqRJMw8ap3XRpgSov85/UYpt7lh2
         Tx8WOawUMd8Hg67dYpAO7rIpYkinnm+EHu7G0+EmV7KzXRypcJdjIJkChK4Tawe2yHWr
         Ift2k4l1mgUxcSC2s+WP/a8rdIsVclsNX3mE9KasvYFpaJurTbxr7qf2L+vMifLlku5f
         SV1dF502XCH+uFv1QbQzsnLbMoeAW2tqPOtjhNLfGjG6eR/eYew+rtX2wlfmT7fClLT/
         0dPw==
X-Forwarded-Encrypted: i=1; AL+hErFzEylrm9pQVLnO4O4M/i1nBCdOoK6WKDPDg51zGzxjmwCtUm+1igR3sR8XNz8dlArdBcgvvpk6NfqJXMp0Swbq@vger.kernel.org
X-Gm-Message-State: APuU4Z/4N0w2kKFP52yUTXeCeGwnMQmzfmqPqlAHF0VA2gm/vlqvYXMp
	0XD/D/f+qGwMY+/fuihcpHaRN6QhBLD5h9HB/kWrUlGDcfHvTs99/8kyjI6HweetjV8mfjH8Sxo
	/Lpj8rqGXpQ==
X-Received: from dlbrc1-n2.prod.google.com ([2002:a05:7022:ea81:20b0:1b2:490b:6fe9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:170a:b0:1b3:b3de:9232
 with SMTP id a92af1059eb24-1b503115668mr2454073c88.9.1794588138437; Fri, 13
 Nov 2026 08:42:18 -0800 (PST)
Date: Fri, 13 Nov 2026 08:41:40 -0800
In-Reply-To: <20261113164152.2095566-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164152.2095566-10-irogers@google.com>
Subject: [PATCH v13 09/21] perf dsos: Ensure DSOs in auxtrace, machine, and
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
index afb95b64bec4..12bb095aa9a9 100644
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
2.56.1.703.gf848ed807c-goog

