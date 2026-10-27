Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142963;
	b=ZlIZfa2Sj3KW5AOmoIYCMaqxNJghIShf1swLyDQP40AOC43IGR5dma9T9CswE45hN9HZ
	 McMUqivNmXVis1+q8gJTF6XRFElKnI8aUCja62RY/3OTsgDBrkPGZStsNFxytooZNUNyD
	 X9E/w38aNVS1ei6ea8eh+4M9ssMWwb/wrxl83dpIzOCIjy1Waek3Pt8FysfgwJSrNDvIo
	 1qVUNeX7dgS9Im06vtAnQiM8Wydp1XUjlcd8zrk+JxnZJGFelFBmFgveJLGFY4pgVrAoP
	 FqevIPt9XNvWLLIjKzIcazsLZDSxmype0rYWa/sfsHeEmbMK9LL/YcRPVc2XhYtw1oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QKwkg1qzp4oXx4hyfKhaMi41f0Rp67/A/aGeKrIatec=;
	b=aGbkatGm6AWbbKqPOXfbFJBk0j43c3zPQMebifn8taiN8dDvGiqmUL8c2n3WmF9P+WAF
	 7fGs44JsIBxZ/jXmkN74b+34UcG2Nx1JHtE3RduXrb/K/Y39lNTkW9S7TEYWy4SkfNEPK
	 J2Zp7tm7JsURo2NTC4764FaZHIE9WsOYtd4BKhifNQSO56WDBBB7q6BZ3Z5anZdNR32V8
	 /nGohoNaQz37C+WRHrxkKyel3MxNpw7MxKXCRkuQ6caiEu2K036VYH5jzE+Ave4q8j7Wl
	 1BiUHoQOhaK0M7r5aP8ZvU3CDfVDPb47GArfPYs3zt4aGo0Brn2rA3rCe/BywpFLfJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=REycMoRC;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD660A2624
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCAD660A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=REycMoRC
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c5aef2a74so1258340eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142962; x=1793747762; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKwkg1qzp4oXx4hyfKhaMi41f0Rp67/A/aGeKrIatec=;
        b=REycMoRCeF/xE5wpZb9fUYMW3w0YYGN3XpgnOdfA7+JIwwuzFkAWbcdgiggs2y52f5
         9Zbo4LPDL84S8RCul6eQZePKdNrwrqCe5+AcMQuiy2jYDXDXUU635QzezD+q4zHK+vF0
         +sQAM1GQCxUIme4IoPh2qrtXFt551fvsrVC727zeAv0IgPAP/76Z/Oze6qOy1kHTyo1u
         fNqiYsYjINPC9CH/bddSkuc4rkHoqTsn7c3y40SIpoI1RIDDwcatW8UNFH8mOuDy7L3H
         /7U0zT0XjB+entq0r6NcIu8Mxmu6mnHUI3+cTbj1JziLh6iMvI+dEvSZGKoMJcJDG/c6
         Dfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142962; x=1793747762;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKwkg1qzp4oXx4hyfKhaMi41f0Rp67/A/aGeKrIatec=;
        b=tVg4/wuDo8bJ2qued6RcecgkSDPUilwlYbyKnihlIxtOCjTW1SEW/q2MuOkJICXCTi
         9APdCK4VsbhCbHv8/ElF06HrZSaUplsGTuW9RI5nV3NM31foq+03UC0gAmUkL4l3XtwW
         TE4jLui3XAGujqeezmLqvNESvZ1wfYzUZnuJhdLNNAOnUyJhl2gkeCOBlLIbbZl4ROZo
         fOjQU/RRJjgwRpmfHBCW/NYFtLUEZFKJYeGKiCDvgpIoYxAoJw4alhKZWEotmibCxoCo
         3bkj7PL+AyI0BOSizhSQjvLRz0cJwEYNS7J1jl2FpZ80jQV0QqP3ObogIWtoeGSZ2u6Z
         wLQQ==
X-Forwarded-Encrypted: i=1; AKwUvBykoRSxJi3ITbJRZBuEXNBsU6z0Vadb/4aaDiH2ja7h8a1u8vSU8BWDDZSad5iTHhStakSS8Hge+JcTnJdPi0+e@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4WqFpcwSNOppsMIv+TRoAdYgCepbF9/3Pn17kZqpczYOoTt4m
	m0mXepEPIQfouBMy0klsioJKfWa3wfFYjBe5JXMZ3tSF+dce++B05SZVSCEU7CrB5JCHQ0Ap1IE
	HnEAlwNQ/qQ==
X-Received: from dycoh9.prod.google.com ([2002:a05:7301:da09:b0:369:dee2:2b37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:df49:b0:36a:1e0c:e28d
 with SMTP id 5a478bee46e88-36a202bdba8mr1212267eec.4.1793142961509; Tue, 27
 Oct 2026 16:16:01 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:11 -0700
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
Message-ID: <20261027231513.816148-18-irogers@google.com>
Subject: [PATCH v2 17/18] perf symbol: Use session allocation wrappers in
 symbol, DSO, thread, and hist paths
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Connect the session-scoped allocation wrappers (perf_session__malloc,
perf_session__zalloc, perf_session__calloc, perf_session__realloc,
perf_session__strdup) to the primary heap allocation paths during sample
and symbol processing: symbol__new(), symbols->symbols array growth,
dso__new_id(), thread__new(), and hist_entry allocation.

In normal operation when memory is available, behavior is unchanged.
When an allocation fails with NULL, these paths now invoke
perf_session__shrink() on the owning perf_session to reclaim
unreferenced symbols and DSOs and retry the allocation once before
failing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c        |  4 ++-
 tools/perf/util/dsos.c       |  7 +++++
 tools/perf/util/hist.c       | 41 +++++++++++++++++++++---
 tools/perf/util/machine.c    |  8 ++++-
 tools/perf/util/symbol-elf.c | 14 ++++++---
 tools/perf/util/symbol.c     | 60 +++++++++++++++++++++++-------------
 tools/perf/util/symbol.h     |  3 ++
 7 files changed, 104 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index c19de9ab4b24..de694e119a6e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -27,6 +27,7 @@
 #include "map.h"
 #include "namespaces.h"
 #include "path.h"
+#include "session.h"
 #include "srcline.h"
 #include "string2.h"
 #include "symbol.h"
@@ -1214,10 +1215,11 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
 					     u64 offset, ssize_t *ret)
 {
 	u64 cache_offset = offset & DSO__DATA_CACHE_MASK;
+	struct perf_session *session = machine ? machine__session(machine) : dso__session(dso);
 	struct dso_cache *cache;
 	struct dso_cache *old;
 
-	cache = zalloc(sizeof(*cache) + DSO__DATA_CACHE_SIZE);
+	cache = perf_session__zalloc(session, sizeof(*cache) + DSO__DATA_CACHE_SIZE);
 	if (!cache) {
 		*ret = -ENOMEM;
 		return NULL;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 8f3e3f3c6ce3..374e1c5d2c32 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -2,6 +2,8 @@
 #include "debug.h"
 #include "dsos.h"
 #include "dso.h"
+#include "machine.h"
+#include "session.h"
 #include "util.h"
 #include "vdso.h"
 #include "namespaces.h"
@@ -350,6 +352,11 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct d
 	down_write(&dsos->lock);
 	dso = __dsos__findnew_id(dsos, name, id);
 	up_write(&dsos->lock);
+	if (!dso && dsos->machine && perf_session__shrink(machine__session(dsos->machine)) > 0) {
+		down_write(&dsos->lock);
+		dso = __dsos__findnew_id(dsos, name, id);
+		up_write(&dsos->lock);
+	}
 	return dso;
 }
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index badae244638c..4242d3f6f955 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -524,16 +524,45 @@ struct hist_entry *hists__get_entry(struct hists *hists, int idx)
  * histogram, sorted on item, collects periods
  */
 
+static struct perf_session *hist_entry__session(const struct hist_entry *he)
+{
+	struct maps *maps;
+
+	if (!he)
+		return NULL;
+
+	if (he->ms.map) {
+		struct dso *dso = map__dso(he->ms.map);
+		struct perf_session *session = dso__session(dso);
+
+		if (session)
+			return session;
+	}
+
+	maps = he->thread ? thread__maps(he->thread) : NULL;
+	if (maps) {
+		struct machine *machine = maps__machine(maps);
+		struct perf_session *session = machine__session(machine);
+
+		if (session)
+			return session;
+	}
+
+	return NULL;
+}
+
 static int hist_entry__init(struct hist_entry *he,
 			    struct hist_entry *template,
 			    bool sample_self,
 			    size_t callchain_size)
 {
+	struct perf_session *session = hist_entry__session(template);
+
 	*he = *template;
 	he->callchain_size = callchain_size;
 
 	if (symbol_conf.cumulate_callchain) {
-		he->stat_acc = malloc(sizeof(he->stat));
+		he->stat_acc = perf_session__malloc(session, sizeof(he->stat));
 		if (he->stat_acc == NULL)
 			return -ENOMEM;
 		memcpy(he->stat_acc, &he->stat, sizeof(he->stat));
@@ -551,7 +580,7 @@ static int hist_entry__init(struct hist_entry *he,
 		 * sample__resolve_bstack() and will be freed after
 		 * adding new entries.  So we need to save a copy.
 		 */
-		he->branch_info = malloc(sizeof(*he->branch_info));
+		he->branch_info = perf_session__malloc(session, sizeof(*he->branch_info));
 		if (he->branch_info == NULL)
 			goto err;
 
@@ -582,14 +611,14 @@ static int hist_entry__init(struct hist_entry *he,
 	}
 
 	if (he->srcline && he->srcline != SRCLINE_UNKNOWN) {
-		he->srcline = strdup(he->srcline);
+		he->srcline = perf_session__strdup(session, he->srcline);
 		if (he->srcline == NULL)
 			goto err_rawdata;
 	}
 
 	if (symbol_conf.res_sample) {
-		he->res_samples = calloc(symbol_conf.res_sample,
-					sizeof(struct res_sample));
+		he->res_samples = perf_session__calloc(session, symbol_conf.res_sample,
+						       sizeof(struct res_sample));
 		if (!he->res_samples)
 			goto err_srcline;
 	}
@@ -655,6 +684,8 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 		callchain_size = sizeof(struct callchain_root);
 
 	he = ops->new(callchain_size);
+	if (!he && perf_session__shrink(hist_entry__session(template)) > 0)
+		he = ops->new(callchain_size);
 	if (he) {
 		err = hist_entry__init(he, template, sample_self, callchain_size);
 		if (err) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3e0d68fd5efe..f45befc35a7f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -20,6 +20,7 @@
 #include "mem-events.h"
 #include "mem-info.h"
 #include "path.h"
+#include "session.h"
 #include "srcline.h"
 #include "symbol.h"
 #include "synthetic-events.h"
@@ -598,7 +599,12 @@ static struct thread *__machine__findnew_thread(struct machine *machine,
 
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid)
 {
-	return __machine__findnew_thread(machine, pid, tid, /*create=*/true);
+	struct thread *th = __machine__findnew_thread(machine, pid, tid, /*create=*/true);
+
+	if (!th && perf_session__shrink(machine__session(machine)) > 0)
+		th = __machine__findnew_thread(machine, pid, tid, /*create=*/true);
+
+	return th;
 }
 
 struct thread *machine__find_thread(struct machine *machine, pid_t pid,
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 946a2426933c..75139fab0748 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -15,6 +15,7 @@
 #include "symbol.h"
 #include "symsrc.h"
 #include "machine.h"
+#include "session.h"
 #include "vdso.h"
 #include "debug.h"
 #include "util/copyfile.h"
@@ -701,7 +702,7 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
 		sym = symbol__new(shdr.sh_offset + i, shdr.sh_entsize, STB_GLOBAL, STT_FUNC, buf);
 		if (!sym)
 			goto out;
-		if (symbols__insert(dso__symbols(dso), sym))
+		if (symbols__insert_session(dso__symbols(dso), sym, dso__session(dso)))
 			goto out;
 	}
 	err = 0;
@@ -757,7 +758,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	plt_sym = symbol__new(shdr_plt.sh_offset, plt_header_size, STB_GLOBAL, STT_FUNC, ".plt");
 	if (!plt_sym)
 		goto out_elf_end;
-	if (symbols__insert(dso__symbols(dso), plt_sym))
+	if (symbols__insert_session(dso__symbols(dso), plt_sym, dso__session(dso)))
 		goto out_elf_end;
 
 	/* Only x86 has .plt.got */
@@ -880,7 +881,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			goto out_elf_end;
 
 		plt_offset += plt_entry_size;
-		if (symbols__insert(dso__symbols(dso), f))
+		if (symbols__insert_session(dso__symbols(dso), f, dso__session(dso)))
 			goto out_elf_end;
 		++nr;
 	}
@@ -1939,13 +1940,18 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		f = symbol__new(sym.st_value, sym.st_size,
 				GELF_ST_BIND(sym.st_info),
 				GELF_ST_TYPE(sym.st_info), elf_name);
+		if (!f && perf_session__shrink(dso__session(curr_dso)) > 0) {
+			f = symbol__new(sym.st_value, sym.st_size,
+					GELF_ST_BIND(sym.st_info),
+					GELF_ST_TYPE(sym.st_info), elf_name);
+		}
 		free(demangled);
 		if (!f)
 			goto out_elf_end;
 
 		arch__sym_update(f, &sym);
 
-		if (symbols__insert(dso__symbols(curr_dso), f))
+		if (symbols__insert_session(dso__symbols(curr_dso), f, dso__session(curr_dso)))
 			goto out_elf_end;
 		nr++;
 	}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e5338c8e03dc..6bba489ff535 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -41,6 +41,7 @@
 #include "namespaces.h"
 #include "header.h"
 #include "path.h"
+#include "session.h"
 #include <linux/ctype.h>
 #include <linux/log2.h>
 #include <linux/zalloc.h>
@@ -938,12 +939,13 @@ static void symbol__set_idle(struct symbol *sym, bool idle)
 	} while (!atomic_compare_exchange_weak(&RC_CHK_ACCESS(sym)->flags, &old_flags, new_flags));
 }
 
-static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
+static int __symbols__insert(struct symbols *symbols, struct symbol *sym,
+			     struct perf_session *session)
 {
 	if (symbols->cnt == symbols->allocated) {
 		unsigned int to_allocate = symbols->allocated ? symbols->allocated * 2 : 32;
-		struct symbol **temp = realloc(symbols->symbols,
-					       sizeof(struct symbol *) * to_allocate);
+		struct symbol **temp = perf_session__realloc(session, symbols->symbols,
+							     sizeof(struct symbol *) * to_allocate);
 
 		if (!temp) {
 			symbol__put(sym);
@@ -1008,7 +1010,8 @@ static void symbols__restore_retained(struct symbols *symbols,
 
 static void symbols__merge_retained(struct symbols *symbols,
 				    struct symbol **retained,
-				    unsigned int retained_cnt)
+				    unsigned int retained_cnt,
+				    struct perf_session *session)
 {
 	unsigned int fresh_cnt;
 	bool need_sort = false;
@@ -1064,7 +1067,7 @@ static void symbols__merge_retained(struct symbols *symbols,
 				symbol__set_ifunc_alias(ret_sym, true);
 			symbols->symbols[match_idx] = ret_sym;
 			symbol__put(fresh_sym);
-		} else if (__symbols__insert(symbols, ret_sym) == 0) {
+		} else if (__symbols__insert(symbols, ret_sym, session) == 0) {
 			need_sort = true;
 		}
 	}
@@ -1080,17 +1083,18 @@ static void symbols__merge_retained(struct symbols *symbols,
 	free(retained);
 }
 
-static int __symbols__insert_sorted(struct symbols *symbols, struct symbol *sym)
+static int __symbols__insert_sorted(struct symbols *symbols, struct symbol *sym,
+				    struct perf_session *session)
 {
 	unsigned int idx;
 
 	if (!symbols->sorted)
-		return __symbols__insert(symbols, sym);
+		return __symbols__insert(symbols, sym, session);
 
 	if (symbols->cnt == symbols->allocated) {
 		unsigned int to_allocate = symbols->allocated ? symbols->allocated * 2 : 32;
-		struct symbol **temp = realloc(symbols->symbols,
-					       sizeof(struct symbol *) * to_allocate);
+		struct symbol **temp = perf_session__realloc(session, symbols->symbols,
+							     sizeof(struct symbol *) * to_allocate);
 
 		if (!temp) {
 			symbol__put(sym);
@@ -1118,16 +1122,22 @@ static int __symbols__insert_sorted(struct symbols *symbols, struct symbol *sym)
 	return 0;
 }
 
-int symbols__insert(struct symbols *symbols, struct symbol *sym)
+int symbols__insert_session(struct symbols *symbols, struct symbol *sym,
+			    struct perf_session *session)
 {
 	int ret;
 
 	down_write(&symbols->lock);
-	ret = __symbols__insert(symbols, sym);
+	ret = __symbols__insert(symbols, sym, session);
 	up_write(&symbols->lock);
 	return ret;
 }
 
+int symbols__insert(struct symbols *symbols, struct symbol *sym)
+{
+	return symbols__insert_session(symbols, sym, NULL);
+}
+
 /*
  * Binary search @symbols->symbols for a symbol covering @ip. Lazily sorts
  * @symbols under @symbols->lock if unsorted.
@@ -1288,7 +1298,7 @@ int dso__insert_symbol(struct dso *dso, struct symbol *sym)
 	int ret;
 
 	down_write(&symbols->lock);
-	ret = __symbols__insert_sorted(symbols, sym);
+	ret = __symbols__insert_sorted(symbols, sym, dso__session(dso));
 	up_write(&symbols->lock);
 	return ret;
 }
@@ -1633,7 +1643,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	return symbols__insert(root, sym);
+	return symbols__insert_session(root, sym, dso__session(dso));
 }
 
 /*
@@ -1697,7 +1707,8 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			symbol__set_end(pos, symbol__end(pos) -
 					(map__start(curr_map) - map__pgoff(curr_map)));
 		}
-		if (symbols__insert(dso__symbols(curr_map_dso), pos) == 0)
+		if (symbols__insert_session(dso__symbols(curr_map_dso), pos,
+					    dso__session(curr_map_dso)) == 0)
 			++count;
 		map__put(curr_map);
 	}
@@ -1873,7 +1884,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		if (!RC_CHK_EQUAL(curr_map, initial_map)) {
 			struct dso *curr_map_dso = map__dso(curr_map);
 
-			if (symbols__insert(dso__symbols(curr_map_dso), pos) == 0)
+			if (symbols__insert_session(dso__symbols(curr_map_dso), pos,
+						    dso__session(curr_map_dso)) == 0)
 				++moved;
 		} else {
 			old_symbols[write_idx++] = pos;
@@ -1895,7 +1907,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
-			__symbols__insert(root, old_symbols[j]);
+			__symbols__insert(root, old_symbols[j], dso__session(dso));
 	}
 	zfree(&root->symbols_by_name);
 	root->num_by_name = 0;
@@ -1926,7 +1938,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
-			__symbols__insert(root, old_symbols[j]);
+			__symbols__insert(root, old_symbols[j], dso__session(dso));
 		root->sorted_cnt = 0;
 		root->sorted = false;
 	}
@@ -2497,7 +2509,7 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 		if (sym == NULL)
 			goto out_delete_line;
 
-		if (symbols__insert(dso__symbols(dso), sym))
+		if (symbols__insert_session(dso__symbols(dso), sym, dso__session(dso)))
 			goto out_delete_line;
 		nr_syms++;
 	}
@@ -2674,7 +2686,7 @@ int dso__load(struct dso *dso, struct map *map)
 	if (machine)
 		root_dir = machine->root_dir;
 
-	name = malloc(PATH_MAX);
+	name = perf_session__malloc(dso__session(dso), PATH_MAX);
 	if (!name)
 		goto out;
 
@@ -2750,8 +2762,11 @@ int dso__load(struct dso *dso, struct map *map)
 		if (!syms_ss && symsrc__has_symtab(ss)) {
 			syms_ss = ss;
 			next_slot = true;
-			if (!dso__symsrc_filename(dso))
-				dso__set_symsrc_filename(dso, strdup(name));
+			if (!dso__symsrc_filename(dso)) {
+				dso__set_symsrc_filename(dso,
+							 perf_session__strdup(dso__session(dso),
+									      name));
+			}
 		}
 
 		if (!runtime_ss && symsrc__possibly_runtime(ss)) {
@@ -2805,7 +2820,8 @@ int dso__load(struct dso *dso, struct map *map)
 out:
 	if (was_shrunk) {
 		if (ret > 0) {
-			symbols__merge_retained(dso__symbols(dso), retained, retained_cnt);
+			symbols__merge_retained(dso__symbols(dso), retained, retained_cnt,
+						dso__session(dso));
 		} else {
 			dso__set_adjust_symbols(dso, saved_adjust_symbols);
 			symbols__restore_retained(dso__symbols(dso), retained,
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 7d6469d6a976..2db5eb84b268 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -33,6 +33,7 @@ struct maps;
 struct option;
 struct build_id;
 struct perf_env;
+struct perf_session;
 
 /*
  * Ignore kernel mapping symbols, matching kernel is_mapping_symbol() logic.
@@ -376,6 +377,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
 int symbols__insert(struct symbols *symbols, struct symbol *sym);
+int symbols__insert_session(struct symbols *symbols, struct symbol *sym,
+			    struct perf_session *session);
 void symbols__fixup_duplicate(struct symbols *symbols);
 void symbols__fixup_end(struct symbols *symbols, bool is_kallsyms);
 
-- 
2.56.0.313.g2479322e68-goog

