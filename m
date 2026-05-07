Received: from sg-3-111.ptr.tlmpb.com (sg-3-111.ptr.tlmpb.com [101.45.255.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989A34678C
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778137926; cv=none; b=XoB6ROsNvBN9L7yEMApR3nouezLddGxA58XEsBSoc59na7GubdxKPQsVut2e4+2+32ZddvwyNnmzowOoQGh9c/EYsXIavivPUo95iYMxIWm11b0+tZRc2ocEfWEL7YYHxGbikQqK3z25j2O9t4gEyGSwpnbUnbE2XPhaeOnZyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778137926; c=relaxed/simple;
	bh=TvxGeBXn7aWwrHgy6glXFBXDwJggeXBTVVVjKufbNlE=;
	h=In-Reply-To:References:Subject:Cc:To:Date:Message-Id:Mime-Version:
	 Content-Type:From; b=CW3szKhbtR/8XrqbcC3beBGmYbzMJDaJ032U4qD1uPDUOSPm6EdefzJR0HNJbpQTzRpaT8ES+F85/5Y8ruAB0yKJJt199Gp4xwVTpS7tTCoHTfJAU0ezQ0KGV6BRmaKGIYeXaZr+R9T5hrA9pPKbKPz3zSi+gIZEPC0T1bXRuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Iq21VF5Z; arc=none smtp.client-ip=101.45.255.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Iq21VF5Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778137880; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=KBY1210ebPwZvKMk6ItgnF2biUpZ8QVLK9P/PcdW3Ig=;
 b=Iq21VF5ZhMuY7PSWq3OM4P1thfuh90trZOOhbPBWSt7p7IUsY9qgaVqXVyysdktubUTlvB
 IWiczhQ6rQEkd8qrpDterj93xAqTx6fNyWJLnuBx3Fm6IMOsB7Aadb6ycMUPneMxZnI4rZ
 4+A/KFc51a6/nh00DnFQRewB+loleJ07dPM9lsBEa/JKpoHDSBNAClxiw43hTM9/VgcoYS
 NDK1b7Rkg3Tm0GwgdXrBTzoHj+qrALe4Rsjyi4edIyNEtkBIHWmIahkwfUm6TgrNckfQHy
 Ut91uEVBMpc8IxCR5qwVCXVkZYeeAm0A9AhzDaHejWGvFbcDEtj8saph7C7WkA==
X-Lms-Return-Path: <lba+269fc3b16+3d1faa+vger.kernel.org+qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
In-Reply-To: <20260506073820.2419087-1-qirui.001@bytedance.com>
References: <20260506073820.2419087-1-qirui.001@bytedance.com>
Subject: [PATCH v3] perf: Add is_mapping_symbol() helper for kernel mapping symbol filtering
Cc: "Mark Rutland" <mark.rutland@arm.com>, 
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, 
	"Adrian Hunter" <adrian.hunter@intel.com>, 
	"James Clark" <james.clark@linaro.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.20.1
To: "Peter Zijlstra" <peterz@infradead.org>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>
Date: Thu,  7 May 2026 15:11:03 +0800
Message-Id: <20260507071103.2772577-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
From: "Rui Qi" <qirui.001@bytedance.com>

The perf tool currently has ad-hoc logic to filter out ELF mapping
symbols scattered across multiple files. ARM, AArch64 and RISC-V each
have their own inline checks in dso__load_sym_internal(), and kallsym
processing has yet another check for ARM module symbols.

This is fragile: adding support for a new architecture or adjusting
which prefixes are considered mapping symbols requires touching
multiple places, and it is easy for the checks to diverge. It also
does not match the kernel's own is_mapping_symbol() logic, which
additionally covers x86 local symbols (".L*" and "L0*").

Introduce a single is_mapping_symbol() inline helper in symbol.h and
convert all kernel symbol handling to use it. The helper covers the
existing "$" prefix used by ARM, AArch64 and RISC-V, and also adds
the x86 local symbol prefixes so that perf stays consistent with
the kernel.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
Changes in v3:
  - Add is_mapping_symbol() check for kernel modules in dso__load_sym_internal()
  - Add is_mapping_symbol() check in machine__process_ksymbol_unregister()

Link (v2): https://lore.kernel.org/all/20260506073820.2419087-1-qirui.001@bytedance.com/

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
---
 tools/perf/util/machine.c    | 12 +++++++++++-
 tools/perf/util/symbol-elf.c |  8 ++++++++
 tools/perf/util/symbol.c     |  4 ++--
 tools/perf/util/symbol.h     | 15 +++++++++++++++
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e76f8c86e62a..4e33ba06111d 100644
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
 
@@ -790,6 +796,10 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 	struct symbol *sym;
 	struct map *map;
 
+	/* Ignore mapping symbols in ksymbol events */
+	if (is_mapping_symbol(event->ksymbol.name))
+		return 0;
+
 	map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
 	if (!map)
 		return 0;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7afa8a117139..6b12508ea58d 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1607,6 +1607,14 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				continue;
 		}
 
+		/*
+		 * For kernel modules, also reject x86 local symbols (.L* and L0*)
+		 * to match the kernel's is_mapping_symbol() logic and kallsyms
+		 * parsing behavior.
+		 */
+		if (kmodule && is_mapping_symbol(elf_name))
+			continue;
+
 		if (runtime_ss->opdsec && sym.st_shndx == runtime_ss->opdidx) {
 			u32 offset = sym.st_value - syms_ss->opdshdr.sh_addr;
 			u64 *opd = opddata->d_buf + offset;
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
