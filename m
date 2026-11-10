Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348553;
	b=0kI4pTKP7q9ACl64FP4gOIq9qg4f7f5XC9jelbinOU++kiHrAanmRyDNB5mkT1LD9MJS
	 MY61BeFNC+hc+EUq/bvKH22/BOghq7kUzA+D9nojEg2A1XipdN2i3LaLpMuaz11TXFGO1
	 9Gm+6X4y9jPihRrRM52ofEcLxOwDtkPUO3Ft68UJf8nMGGxjsG34T8HstvS78TfQRwTML
	 /eMWTl9KnTKirFnR1YLYA2ZGv3GrucDO+nRD5DII6kOTshTmj++7ML55BBQBliiHQVou4
	 jzoC4ITkPnBAMgACMBmjCJ0uqNBwjVi8vSV9DdLGvWffKTmi6k6S3rAZtHPuLtvUVvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MMxzKufKtGUmRX4ibReVNnYMLq+zFG/uj6zyWrIRHuY=;
	b=289Ep1GUrLc5rwjWo8vsvBADjHYuTZ/2KN3/23GufKwiGBHyfe43Pd7O236uKvsYIv+y
	 Rgv3jPfdQYwIhulAqls8P95sNiwXjf93Dzyw8y7ttKlVuSHe7dqYxLnYCABoq3OEg91MQ
	 cGdrhmtBmy4smv7v/JGQLnGpD8uac3xf35owwRoOAOLLTCJeD2rddODlhMldT6bg7F/aM
	 83fjc4v25mm5xqblQsp72Kb8gvAmwYwmoJLgbwVlP9J6jRJSUFXwm1IzCHDa67r3jIYrj
	 jiPy4CFS4BBtSMJL0DnRrjWCJC5PQXbCUbVqdIq6Bgi/hmzg2g6dpwIcKMRWtT8RNMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q7YgbDfl;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8360A2601
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D8360A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q7YgbDfl
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36efb506f29so3420498eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348552; x=1794953352; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MMxzKufKtGUmRX4ibReVNnYMLq+zFG/uj6zyWrIRHuY=;
        b=Q7YgbDfluWLMAwlH9VOKHmEcOAbXk8lWLUaZKZb2DC2j6uG/OUeGAr//LuW9ZZr1u0
         CgzeAdyvZzaBC47GHBm7Y+kMEzAfbPIa/U0jYxq9O6s/TU2/INiCpgPrJadgV1IENIUU
         FEc/ci88NM0IGh9yZp3oIqDW7VtfUZCbVtbyqYv2gQR+IsKY+7faGgSk9Avlah7sfzp9
         l1aDbt1f9sAbmm5qnYFCD0zLnQx5GLVZeUoUQXjjd9BdGp2xlZSAFbEf1r1QIk/Ml/tE
         xsbzQKMPR44sQZno6uYfxgmg28ZDxAYl+4uHW3AdlEYZsLop29/RQBz8PAeylRBV9Ic5
         V7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348552; x=1794953352;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MMxzKufKtGUmRX4ibReVNnYMLq+zFG/uj6zyWrIRHuY=;
        b=kIHcAfO61lbAt0HqdxuX4Qcuh9MP9+2R5RPCnf82lXN6EawtaQt9QuAVTXKN0A7wMQ
         /BBAvjVwa4ZL2faAJ4tkxSy/hk0vMfM91X4oqirZhf/TQquVHjvzdKFgxCZCp3NU6QNy
         sVtLp4TghVZkm9YSOUsWUgtpoeJiAd9zohjP2pv+1Zs7dsK4+VD9A36cnTtJbyh2CENI
         IDuJMSE6WnVKIkdVxVbCyKtltfURDKLoE+BoE2DGI9Ep7isACWjUAhqKn6TPGr8Y2mF2
         tig9Z7iaKnufMPz5faPjqNcRc34Id/pnfslSi3jwk/LX49O2GEbsHpchjiTK7SCMOan6
         q8Rw==
X-Forwarded-Encrypted: i=1; AL+hErFbGrTPFePwqRtTGIIf91uCnECq1nu6vh5LN4dCF/9EcuD2n2s6E/MJHWZ5K59q5D2PdlX/PAP476+dDRDqfem1@vger.kernel.org
X-Gm-Message-State: APuU4Z+PI4ugtOBsLQWQ31hc4YshxHS5WM3Vdra/KYEDWE7vM8IPgzLW
	yE8Tq1XeBO3388JGZ6/jM1Gy4OTr30+neveInyyOTAyP91ZTwvJIMHiaeH+ByTEZC+2prKTKQWD
	0lp08fe7EYw==
X-Received: from dycam1.prod.google.com ([2002:a05:7300:fc01:b0:376:583a:e72a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:65d5:b0:36a:1f8:a5a4
 with SMTP id 5a478bee46e88-37687213f9dmr903664eec.38.1794348551171; Tue, 10
 Nov 2026 14:09:11 -0800 (PST)
Date: Tue, 10 Nov 2026 14:08:02 -0800
In-Reply-To: <20261110220803.2503416-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027231513.816148-1-irogers@google.com> <20261110220803.2503416-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110220803.2503416-20-irogers@google.com>
Subject: [PATCH v3 19/20] perf symbol: Use session allocation wrappers in
 symbol, DSO, thread, and hist paths
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Connect the session-scoped allocation wrappers (perf_session__malloc,
perf_session__zalloc, perf_session__calloc, perf_session__realloc,
perf_session__strdup) to the primary heap allocation paths during sample
and symbol processing: symbol__new(), symbols->symbols array growth,
dso__new_id(), thread__new(), and hist_entry allocation.

In normal operation when memory is available, behavior is unchanged.
When an allocation fails with NULL, these paths now invoke
perf_session__shrink() on the owning perf_session to reclaim
unreferenced DSOs and auxiliary symbol/DSO buffers and retry the
allocation once before failing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c        |  4 ++-
 tools/perf/util/dsos.c       |  7 +++++
 tools/perf/util/hist.c       | 41 ++++++++++++++++++++++++----
 tools/perf/util/machine.c    |  8 +++++-
 tools/perf/util/symbol-elf.c | 14 +++++++---
 tools/perf/util/symbol.c     | 52 +++++++++++++++++++++++-------------
 tools/perf/util/symbol.h     |  3 +++
 7 files changed, 99 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 7b71fd5e48a9..cfeed7cc3e9f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -28,6 +28,7 @@
 #include "map.h"
 #include "namespaces.h"
 #include "path.h"
+#include "session.h"
 #include "srcline.h"
 #include "string2.h"
 #include "symbol.h"
@@ -1215,10 +1216,11 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
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
index d53a8ab217e6..94f93fbf02e4 100644
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
index 566ecf4035fb..dbfaef28daeb 100644
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
 
@@ -580,14 +609,14 @@ static int hist_entry__init(struct hist_entry *he,
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
@@ -653,6 +682,8 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 		callchain_size = sizeof(struct callchain_root);
 
 	he = ops->new(callchain_size);
+	if (!he && perf_session__shrink(hist_entry__session(template)) > 0)
+		he = ops->new(callchain_size);
 	if (he) {
 		err = hist_entry__init(he, template, sample_self, callchain_size);
 		if (err) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c89f47ba16f2..489395b53c2e 100644
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
index 2c8088184568..f2a071508d2c 100644
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
@@ -700,7 +701,7 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
 		sym = symbol__new(shdr.sh_offset + i, shdr.sh_entsize, STB_GLOBAL, STT_FUNC, buf);
 		if (!sym)
 			goto out;
-		if (symbols__insert(dso__symbols(dso), sym))
+		if (symbols__insert_session(dso__symbols(dso), sym, dso__session(dso)))
 			goto out;
 	}
 	err = 0;
@@ -755,7 +756,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	plt_sym = symbol__new(shdr_plt.sh_offset, plt_header_size, STB_GLOBAL, STT_FUNC, ".plt");
 	if (!plt_sym)
 		goto out_elf_end;
-	if (symbols__insert(dso__symbols(dso), plt_sym))
+	if (symbols__insert_session(dso__symbols(dso), plt_sym, dso__session(dso)))
 		goto out_elf_end;
 
 	/* Only x86 has .plt.got */
@@ -878,7 +879,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			goto out_elf_end;
 
 		plt_offset += plt_entry_size;
-		if (symbols__insert(dso__symbols(dso), f))
+		if (symbols__insert_session(dso__symbols(dso), f, dso__session(dso)))
 			goto out_elf_end;
 		++nr;
 	}
@@ -1937,13 +1938,18 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
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
index 9d7c87bcbbea..21f012252dcd 100644
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
@@ -845,12 +846,13 @@ static void symbol__set_idle(struct symbol *sym, bool idle)
 	} while (!atomic_compare_exchange_weak(&sym->flags, &old_flags, new_flags));
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
 			symbol__delete(sym);
@@ -877,17 +879,18 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 	return 0;
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
 			symbol__delete(sym);
@@ -940,16 +943,22 @@ static int __symbols__insert_sorted(struct symbols *symbols, struct symbol *sym)
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
 static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt, u64 ip)
 {
 	int low = 0, high = (int)cnt - 1;
@@ -1143,7 +1152,7 @@ int dso__insert_symbol(struct dso *dso, struct symbol *sym)
 	int ret;
 
 	down_write(&symbols->lock);
-	ret = __symbols__insert_sorted(symbols, sym);
+	ret = __symbols__insert_sorted(symbols, sym, dso__session(dso));
 	up_write(&symbols->lock);
 	return ret;
 }
@@ -1478,7 +1487,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	return symbols__insert(root, sym);
+	return symbols__insert_session(root, sym, dso__session(dso));
 }
 
 /*
@@ -1541,7 +1550,8 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			symbol__set_end(pos, symbol__end(pos) -
 					(map__start(curr_map) - map__pgoff(curr_map)));
 		}
-		if (symbols__insert(dso__symbols(curr_map_dso), pos) == 0)
+		if (symbols__insert_session(dso__symbols(curr_map_dso), pos,
+					    dso__session(curr_map_dso)) == 0)
 			++count;
 		map__put(curr_map);
 	}
@@ -1717,7 +1727,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		if (!RC_CHK_EQUAL(curr_map, initial_map)) {
 			struct dso *curr_map_dso = map__dso(curr_map);
 
-			if (symbols__insert(dso__symbols(curr_map_dso), pos) == 0)
+			if (symbols__insert_session(dso__symbols(curr_map_dso), pos,
+						    dso__session(curr_map_dso)) == 0)
 				++moved;
 		} else {
 			old_symbols[write_idx++] = pos;
@@ -1739,7 +1750,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
-			__symbols__insert(root, old_symbols[j]);
+			__symbols__insert(root, old_symbols[j], dso__session(dso));
 	}
 	zfree(&root->symbols_by_name);
 	root->num_by_name = 0;
@@ -1769,7 +1780,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
-			__symbols__insert(root, old_symbols[j]);
+			__symbols__insert(root, old_symbols[j], dso__session(dso));
 		root->sorted_cnt = 0;
 		root->sorted = false;
 	}
@@ -2339,7 +2350,7 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 		if (sym == NULL)
 			goto out_delete_line;
 
-		if (symbols__insert(dso__symbols(dso), sym))
+		if (symbols__insert_session(dso__symbols(dso), sym, dso__session(dso)))
 			goto out_delete_line;
 		nr_syms++;
 	}
@@ -2505,7 +2516,7 @@ int dso__load(struct dso *dso, struct map *map)
 	if (machine)
 		root_dir = machine->root_dir;
 
-	name = malloc(PATH_MAX);
+	name = perf_session__malloc(dso__session(dso), PATH_MAX);
 	if (!name)
 		goto out;
 
@@ -2581,8 +2592,11 @@ int dso__load(struct dso *dso, struct map *map)
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
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index e68248be38c5..003b9cc57e5e 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -32,6 +32,7 @@ struct maps;
 struct option;
 struct build_id;
 struct perf_env;
+struct perf_session;
 
 /*
  * Ignore local labels and mapping symbols, matching kernel is_ignored_kernel_symbol() logic.
@@ -347,6 +348,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
 int symbols__insert(struct symbols *symbols, struct symbol *sym);
+int symbols__insert_session(struct symbols *symbols, struct symbol *sym,
+			    struct perf_session *session);
 void symbols__fixup_duplicate(struct symbols *symbols);
 void symbols__fixup_end(struct symbols *symbols, bool is_kallsyms);
 
-- 
2.56.0.542.g3ef89b7020-goog

