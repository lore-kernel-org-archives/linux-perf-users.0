Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590336;
	b=KQanRtiTtQ+TmZyifSOw8wxIWyQVhEO31LmYceq4gYJX7Q09FynYH3DEz669nioHKHyq
	 C5tWHDgauxoA+Yj/lW2DisHCqLh8KJ1GAGrqnrDVPVjaIOZjz1BhCFzfg1A6f1UM91tEt
	 FbqgD730lBXfzNt78gaoilTFyALyDqZoGqKCXWVW5ix2wQSxdvJoiY0HXr5nBbH5fq4By
	 T/X6kBnGaiYd6v3Qpu8a1haPk8LCVWZqM2nx5s0R6uAMJnULIxRcICVmbm33BwVu6ijte
	 CNq+bJxBrOxlQR74z9FON9fse93E+8K8YRpYkwhWeowB8BPlh/X3Y1DIi4rKDFNKZKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xAu2yy2mqRumaTFrxTyVGDckJLGy/iJBbsZ79EW/hWs=;
	b=yAli9DgxipfdYfECfxmRifB861jzS4nrSeQlD26eYqb9ILiWNhTfTXIIweI+oY1vWOyd
	 q4SjdAirDIDWPfyxmI1xDgVGRklbmcC/BJHLGyhEtNGTW4fCuReyD/QtiCH9rFibmsPL8
	 3vJ3J8MJ7I68v1Fis6LlxuVxgu4FwBWYEuObeWoEAcY4urS2OAA+GJ302u9/F2Q+IWj7n
	 ktpHQWUxAUrxyjhIaX7KUS02HLwHD+nc9FFDN8Yd06oToN1JjFzrywzOEaXjYYdRxmYwS
	 +1W8P5AEidL4KvkGn5JnzL96N6DwRgVZZLfh1TjbGOQ1msc89F55GC5OT9XQzi+DIrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fDeGdNpp;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7856606D870
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7856606D870
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fDeGdNpp
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-375bac6bd21so857989eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590335; x=1795195135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAu2yy2mqRumaTFrxTyVGDckJLGy/iJBbsZ79EW/hWs=;
        b=fDeGdNppM3pXZ+34hxh5l5/CdaSaBMctN7GNrszlpmT62d78fM+wDCEKjIMz80FhNf
         1rsOJQ+fW/4QrMTXK3w/wdJZjMKtRYomNQQyKvyU5eq/vb/9RJv28KC7sk9bjy2w251l
         IjZvkQ3px0NeZLSIrGrFJlhnuz2H2dBFQug/AcdbXZfJHLX6attlX7F9E5hrAwvEfzeD
         itcrVU1yjYJdClNj4Jqs6XS3WB7CljgEl2nKFmfqJTL08rutrka+LfUM+PFQs7Ya+m+U
         o38uugxFC1SNTvWAA1B6vCQlrbh1WypaCCg83oCRsvyyljbbr2o6yiGZ2Emn8sqJDvbW
         YKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590335; x=1795195135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xAu2yy2mqRumaTFrxTyVGDckJLGy/iJBbsZ79EW/hWs=;
        b=2A534Qd5WWKmKESrL7fBbTcTKdC2Muef7zDzjChNvExJUNzBvsoAwhBl2QYQ+BtGnx
         8cxXilCAuFsRgYTRYAm2KvUS4nQq3XZKWVtQoERCmUWaFjSMk9cmY3ANxWoCLiMDDJJf
         Z37KSavE4D9TKB4W7eHDtRCnPqmEDCbtDeoH+88iImR1BOVd3iQ1iHXYwLK06+kDppbr
         bCS6HCiKPUHkFaXFvJQ/ByZ40jty9Xpbsr4MHmzpvhVmqCpfk0/e54ZgS3HnW/wU5ka6
         EQPhvtDY+zTFEmcy3C6EHBbMVtFrJUZsciYZpwv/Z0vg6L/9atHG3/imAdhADNntsOn9
         WcGA==
X-Forwarded-Encrypted: i=1; AL+hErESScRiUkifD0R77eR+lYXLbztg+XD/xsb+QQv+Oxjqevrc0TO3btHcdobNWFD+tBR0KUTq+VtDFj2I9yoXC6yK@vger.kernel.org
X-Gm-Message-State: APuU4Z9hcju8eAgfgQJ37Fo0aKWsLHUvAwySkfHhwV/6Vm1vkI4S2jGC
	LQOe9oMOQBQwBIs+ZA0X0EHbnoU36JrRpdVl2LYzKuPM7Z6pB3VELHcPgkTO4p4QGql9SYQoZTO
	KgLOTBQjjcw==
X-Received: from dyad23.prod.google.com ([2002:a05:693c:8357:b0:369:7ef0:57b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4104:b0:36d:dcdb:70c5
 with SMTP id 5a478bee46e88-377e15f06femr8048264eec.20.1794590334334; Fri, 13
 Nov 2026 09:18:54 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:33 -0800
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
Message-ID: <20261113171734.2188066-23-irogers@google.com>
Subject: [PATCH v4 22/23] perf symbol: Use session allocation wrappers in
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
 tools/perf/util/hist.c       | 41 +++++++++++++++++++++---
 tools/perf/util/machine.c    |  8 ++++-
 tools/perf/util/symbol-elf.c | 19 ++++++++---
 tools/perf/util/symbol.c     | 61 +++++++++++++++++++++++++-----------
 tools/perf/util/symbol.h     |  3 ++
 7 files changed, 113 insertions(+), 30 deletions(-)

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
index d8187a374987..0a79b252e375 100644
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
@@ -599,7 +600,12 @@ static struct thread *__machine__findnew_thread(struct machine *machine,
 
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
index 2c8088184568..99cb8be326cd 100644
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
@@ -1639,6 +1640,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 {
 	struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
 	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
+	struct perf_session *session;
 	struct dso *curr_dso = NULL;
 	Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
 	uint32_t nr_syms;
@@ -1659,6 +1661,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	if (kmap && !kmaps)
 		return -1;
 
+	session = dso__session(dso);
+	if (!session && kmaps && maps__machine(kmaps))
+		session = machine__session(maps__machine(kmaps));
+
 	elf = syms_ss->elf;
 	ehdr = syms_ss->ehdr;
 	if (dynsym) {
@@ -1937,13 +1943,18 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		f = symbol__new(sym.st_value, sym.st_size,
 				GELF_ST_BIND(sym.st_info),
 				GELF_ST_TYPE(sym.st_info), elf_name);
+		if (!f && perf_session__shrink(session) > 0) {
+			f = symbol__new(sym.st_value, sym.st_size,
+					GELF_ST_BIND(sym.st_info),
+					GELF_ST_TYPE(sym.st_info), elf_name);
+		}
 		free(demangled);
 		if (!f)
 			goto out_elf_end;
 
 		arch__sym_update(f, &sym);
 
-		if (symbols__insert(dso__symbols(curr_dso), f))
+		if (symbols__insert_session(dso__symbols(curr_dso), f, session))
 			goto out_elf_end;
 		nr++;
 	}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ce6596de49a4..9533d9faa943 100644
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
@@ -859,12 +860,13 @@ static void symbol__set_idle(struct symbol *sym, bool idle)
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
@@ -891,17 +893,18 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
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
@@ -954,16 +957,22 @@ static int __symbols__insert_sorted(struct symbols *symbols, struct symbol *sym)
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
 static inline bool symbol__covers(const struct symbol *s, u64 ip)
 {
 	u64 start = symbol__start(s);
@@ -1181,7 +1190,7 @@ int dso__insert_symbol(struct dso *dso, struct symbol *sym)
 	int ret;
 
 	down_write(&symbols->lock);
-	ret = __symbols__insert_sorted(symbols, sym);
+	ret = __symbols__insert_sorted(symbols, sym, dso__session(dso));
 	up_write(&symbols->lock);
 	return ret;
 }
@@ -1516,7 +1525,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	return symbols__insert(root, sym);
+	return symbols__insert_session(root, sym, dso__session(dso));
 }
 
 /*
@@ -1531,6 +1540,8 @@ static int dso__load_all_kallsyms(struct dso *dso, const char *filename)
 
 static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 {
+	struct machine *machine;
+	struct perf_session *session;
 	struct symbol *pos;
 	int count = 0;
 	struct symbols *root = dso__symbols(dso);
@@ -1540,6 +1551,11 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	if (!kmaps)
 		return -1;
 
+	machine = maps__machine(kmaps);
+	session = dso__session(dso);
+	if (!session && machine)
+		session = machine__session(machine);
+
 	down_write(&root->lock);
 	symbols__sort_locked(root);
 	old_symbols = root->symbols;
@@ -1579,7 +1595,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			symbol__set_end(pos, symbol__end(pos) -
 					(map__start(curr_map) - map__pgoff(curr_map)));
 		}
-		if (symbols__insert(dso__symbols(curr_map_dso), pos) == 0)
+		if (symbols__insert_session(dso__symbols(curr_map_dso), pos, session) == 0)
 			++count;
 		map__put(curr_map);
 	}
@@ -1601,6 +1617,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				struct map *initial_map)
 {
 	struct machine *machine;
+	struct perf_session *session;
 	struct map *curr_map = map__get(initial_map);
 	struct symbol *pos;
 	int count = 0, moved = 0;
@@ -1615,6 +1632,9 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		return -1;
 
 	machine = maps__machine(kmaps);
+	session = dso__session(dso);
+	if (!session && machine)
+		session = machine__session(machine);
 	e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
 
 	down_write(&root->lock);
@@ -1755,7 +1775,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		if (!RC_CHK_EQUAL(curr_map, initial_map)) {
 			struct dso *curr_map_dso = map__dso(curr_map);
 
-			if (symbols__insert(dso__symbols(curr_map_dso), pos) == 0)
+			if (symbols__insert_session(dso__symbols(curr_map_dso), pos, session) == 0)
 				++moved;
 		} else {
 			old_symbols[write_idx++] = pos;
@@ -1777,7 +1797,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
-			__symbols__insert(root, old_symbols[j]);
+			__symbols__insert(root, old_symbols[j], session);
 	}
 	zfree(&root->symbols_by_name);
 	root->num_by_name = 0;
@@ -1807,7 +1827,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
-			__symbols__insert(root, old_symbols[j]);
+			__symbols__insert(root, old_symbols[j], session);
 		root->sorted_cnt = 0;
 		root->sorted = false;
 	}
@@ -2377,7 +2397,7 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 		if (sym == NULL)
 			goto out_delete_line;
 
-		if (symbols__insert(dso__symbols(dso), sym))
+		if (symbols__insert_session(dso__symbols(dso), sym, dso__session(dso)))
 			goto out_delete_line;
 		nr_syms++;
 	}
@@ -2543,7 +2563,7 @@ int dso__load(struct dso *dso, struct map *map)
 	if (machine)
 		root_dir = machine->root_dir;
 
-	name = malloc(PATH_MAX);
+	name = perf_session__malloc(dso__session(dso), PATH_MAX);
 	if (!name)
 		goto out;
 
@@ -2619,8 +2639,11 @@ int dso__load(struct dso *dso, struct map *map)
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
2.56.1.703.gf848ed807c-goog

