Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660F3A71AA
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438401; cv=none; b=sYlbDTVSaFlxHubgI8UCiRQRhgx3VlTEj1wRVzXhEcNbtkM5Gix8Hn9x703gTI7Ut85exCF1TgPZB7XuwYZdgiNmqzdegGNsQIFvO9xNWq10v5P5yVgaDaLwa4SNbrfzlcTWOUpAWRODcGTylrwD98MZeSFtFPRUKgJ4PQWaHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438401; c=relaxed/simple;
	bh=fYeg5MTOYEEP3bfwW7O2z9k0LRolcbIkNFMsYotBOHg=;
	h=Cc:From:References:To:Mime-Version:In-Reply-To:Content-Type:
	 Subject:Date:Message-Id; b=cmvpxqsf8XVIwPzzTKjDx2JsmYggITqynXTIegGOviexx7+lZxvCRpZu1NRtsTu9GRfF8flYX003YTzJz0OOaCDl/mKpYiaOtdWLh4pLyVkS2cgJarqnVl/GOiqyc1txOwcIu2n/+a+l8irQ2xBq7dNve1c+qQ60vY9YiKaH30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g/BTKqT4; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g/BTKqT4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779438394; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/QeToWwHjCm4j+wwEu3mC7hfaKb7rk0SUmjPJl/Utu8=;
 b=g/BTKqT4ElC9dKoqrI0sTF5WRea68BQkg4QjNaMxyY8RkOoykEVNMgmOo/me4nGLbyC+n5
 OkHPzExzvkwwVyqU+9SJAwN2SzFhyT4yKvaOzPQMIgXNSYZikQL4v7qChpFQVfQ+v/c8dW
 z+yXoaP++AklSvnYaElX2cGEG3s8HE8bCBrawKYZsgaD5n/4kJnxrEv96ZjwW+rYA+1QPG
 FNkrmqlSJcrefrRpKvmPIxeDMFc7V3s+0a/JwEQ3aKMy4tRgLCt130uPt9AtOrkjCdYWNl
 U/RJRlw0IDu3SlSUGHSkCHuUWiYakegexi533fLnhfMmmLTdX07oBBwnhJDwfA==
X-Mailer: git-send-email 2.20.1
Cc: "Mark Rutland" <mark.rutland@arm.com>, 
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, 
	"Adrian Hunter" <adrian.hunter@intel.com>, 
	"James Clark" <james.clark@linaro.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
References: <20260507071103.2772577-1-qirui.001@bytedance.com> <20260522082604.89447-1-qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
To: "Peter Zijlstra" <peterz@infradead.org>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a101338+f6d50e+vger.kernel.org+qirui.001@bytedance.com>
In-Reply-To: <20260522082604.89447-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v4 1/2] perf: Extract is_ignored_kernel_symbol() for kernel mapping symbol filtering
Date: Fri, 22 May 2026 16:26:03 +0800
Message-Id: <20260522082604.89447-2-qirui.001@bytedance.com>

Mapping symbol filtering is scattered across multiple files with
inconsistent checks.  The kernel's own is_mapping_symbol() covers
x86 local symbols ('.L*' and 'L0*') on top of the '$' prefix used
by ARM/AArch64/RISC-V, but the perf tool only checks '$'.

Extract is_ignored_kernel_symbol() into symbol.h matching the kernel
definition, and convert the kallsyms and ksymbol event paths to
use it.  Add ksymbol event name validation and early mapping symbol
filtering before any state mutation.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 tools/perf/util/machine.c | 18 +++++++++++++++++-
 tools/perf/util/symbol.c  |  4 ++--
 tools/perf/util/symbol.h  | 15 +++++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e76f8c86e62a..07e4ad56d757 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -4,6 +4,7 @@
 #include <inttypes.h>
 #include <regex.h>
 #include <stdlib.h>
+#include <string.h>
 #include "callchain.h"
 #include "debug.h"
 #include "dso.h"
@@ -729,9 +730,15 @@ static int machine__process_ksymbol_register(struct machine *machine,
 {
 	struct symbol *sym;
 	struct dso *dso = NULL;
-	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
+	struct map *map;
 	int err = 0;
 
+	/* Ignore mapping symbols in ksymbol events - check early before any state mutation */
+	if (is_ignored_kernel_symbol(event->ksymbol.name))
+		return 0;
+
+	map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
+
 	if (!map) {
 		dso = dso__new(event->ksymbol.name);
 
@@ -790,6 +797,10 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 	struct symbol *sym;
 	struct map *map;
 
+	/* Ignore mapping symbols in ksymbol events */
+	if (is_ignored_kernel_symbol(event->ksymbol.name))
+		return 0;
+
 	map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
 	if (!map)
 		return 0;
@@ -814,6 +825,11 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 	if (dump_trace)
 		perf_event__fprintf_ksymbol(event, stdout);
 
+	if (event->header.size < offsetof(struct perf_record_ksymbol, name) + 2 ||
+	    !memchr(event->ksymbol.name, '\0',
+		    event->header.size - offsetof(struct perf_record_ksymbol, name)))
+		return -EINVAL;
+
 	/* no need to process non-JIT BPF as it cannot get samples */
 	if (event->ksymbol.len == 0)
 		return 0;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fcaeeddbbb6b..714b6e6048fa 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -770,8 +770,8 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	if (!symbol_type__filter(type))
 		return 0;
 
-	/* Ignore local symbols for ARM modules */
-	if (name[0] == '$')
+	/* Ignore mapping symbols in kallsyms */
+	if (is_ignored_kernel_symbol(name))
 		return 0;
 
 	/*
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index bd6eb90c8668..95592779eb77 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -28,6 +28,21 @@ struct maps;
 struct option;
 struct build_id;
 
+/*
+ * Ignore kernel mapping symbols, matching kernel is_mapping_symbol() logic.
+ * This checks for '$' prefix (used by ARM, AArch64, RISC-V) and
+ * x86 local symbol prefixes (.L* and L0*).
+ * Only use this for kernel symbols (kallsyms, ksymbol events, kernel ELF DSOs).
+ */
+static inline bool is_ignored_kernel_symbol(const char *str)
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
