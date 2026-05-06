Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D92FF15B
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053243; cv=none; b=ELklvtLIfbkvrh5tyAVs3VmmHLSfPgcRk/Ee6dO+z9eo7DcVystt4VlpJRAVZvFsLQseXkKbasMlGh8ApCHLbvaN6pJ0UOdiXf2ntnNOUDV4B36Tkl//dgr5Gw7iGx48m+6O05jeCoPU40C4/1DU1VP91fkVRtWIFcTgo9DU6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053243; c=relaxed/simple;
	bh=Bdcwcgwf7Iq1knucUSPnotyRh9CIXkL/ijG+KzYzD/0=;
	h=To:Content-Type:Subject:Message-Id:Mime-Version:From:Date:Cc; b=e2jREWc6h9gAwKeVTDMyfM1MpAwZdyx21BmO3gk5jf0kc3FcmfUzaxAtCPEcOUpCNnmCSx8Bq/V0W6x8ilxsyTZglc0MGQdBYcRySan2wVjIeYmf+lb00+VCUk73OWrsLE6KSZP3C+Ieqd3/Be7Dv6scgMJmR0F2lf9ANMbhGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KWzcY5w+; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KWzcY5w+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778053114; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EGURivkkgwRTCs1hIdxw2V7IvIP59W+Y6UNy2L8CBsE=;
 b=KWzcY5w+qlR6bxwjdrG/nMiVtw5QLvX+2wbkw1QKy31mQjuIcHsLg/bpSO0wXXdKB2E9KY
 9R8XeR+33bHZKrrPmogK1l2sMAQRgZ4GeYjV1ok2jwOwz11PEBhE6cwrVERi/vRVELtau/
 VOE0aZeUIQDUfuhgr7OIbH1o7CIazm18vy/fk53phuWtCPclvaBTZOzTcfAmPeQUdAKDO6
 Uu/dGjncd6ho5V7Qc7Kmd/p83eNx5GIk/vwiRpI3diAgt0IRj5+A36a9eAyTMp826aYok5
 Z+6uQYngR4v6HVXsVGOxtDqbPvsUntHV5ZGsNMdsqb/PyaLtrodWbJXRCQ1qbg==
To: <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v2] perf: Extract is_mapping_symbol() helper for kernel mapping symbol filtering
Message-Id: <20260506073820.2419087-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+269faeff8+3c1fa6+vger.kernel.org+qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Wed,  6 May 2026 15:38:20 +0800
Cc: "Peter Zijlstra" <peterz@infradead.org>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.20.1

The perf tool currently has ad-hoc logic to filter out ELF mapping
symbols scattered across multiple files and architectures.  ARM,
AArch64 and RISC-V each have their own inline checks in
dso__load_sym_internal(), and kallsym processing in map__process_kallsym_symbol()
has yet another check for ARM module symbols.

This is fragile: adding support for a new architecture or adjusting
which prefixes are considered mapping symbols requires touching
multiple places, and it is easy for the checks to diverge.  It also
does not match the kernel's own is_mapping_symbol() logic, which
additionally covers x86 local symbols ('.L*' and 'L0*').

Introduce a single is_mapping_symbol() inline helper in symbol.h and
convert kernel symbol handling to use it.  The helper covers the
existing '$' prefix used by ARM, AArch64 and RISC-V, and also adds
the x86 local symbol prefixes so that perf stays consistent with
the kernel.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---

Changes in v2:
- Only apply is_mapping_symbol() filtering to kernel symbols (kallsyms
  and ksymbol events), not to user-space symbols from ELF files,
  BFD libraries, or perf map files.  This avoids incorrectly
  discarding valid user-space function names that start with '$',
  which is a legal character in identifiers for many languages
  (e.g., Java, Scala) and compilers (GCC).
- Move the mapping symbol check in machine__process_ksymbol_register()
  to the beginning of the function, before any map/dso allocation
  or insertion, to avoid leaving empty maps in the kernel map tree.

Link (v1): https://lore.kernel.org/all/20260504090609.1801880-1-qirui.001@bytedance.com/

 tools/perf/util/machine.c |  8 +++++++-
 tools/perf/util/symbol.c  |  4 ++--
 tools/perf/util/symbol.h  | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e76f8c86e62a..e0dcf8bfb896 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -729,9 +729,15 @@ static int machine__process_ksymbol_register(struct machine *machine,
 {
 	struct symbol *sym;
 	struct dso *dso = NULL;
-	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
+	struct map *map;
 	int err = 0;
 
+	/* Ignore mapping symbols in ksymbol events - check early before any state mutation */
+	if (is_mapping_symbol(event->ksymbol.name))
+		return 0;
+
+	map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
+
 	if (!map) {
 		dso = dso__new(event->ksymbol.name);
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fcaeeddbbb6b..af03b16c17c6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -770,8 +770,8 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	if (!symbol_type__filter(type))
 		return 0;
 
-	/* Ignore local symbols for ARM modules */
-	if (name[0] == '$')
+	/* Ignore mapping symbols in kallsyms */
+	if (is_mapping_symbol(name))
 		return 0;
 
 	/*
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index bd6eb90c8668..27fa1b43e6f1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -28,6 +28,21 @@ struct maps;
 struct option;
 struct build_id;
 
+/*
+ * Ignore kernel mapping symbols, matching kernel is_mapping_symbol() logic.
+ * This checks for '$' prefix (used by ARM, AArch64, RISC-V) and
+ * x86 local symbol prefixes (.L* and L0*).
+ * Only use this for kernel symbols (kallsyms, ksymbol events).
+ */
+static inline bool is_mapping_symbol(const char *str)
+{
+	if (str[0] == '.' && str[1] == 'L')
+		return true;
+	if (str[0] == 'L' && str[1] == '0')
+		return true;
+	return str[0] == '$';
+}
+
 /*
  * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
  * for newer versions we can use mmap to reduce memory usage:
-- 
2.20.1
