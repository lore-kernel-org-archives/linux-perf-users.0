Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32986360;
	Mon,  6 Jan 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736193006; cv=none; b=ueMPE4vRvVGiY7lkLN8GYwOBKbOTvVk4EkG/mJHUmPkaIVnKzsgEoyKb0rgjTlipgOFIGXPawu4cdoGqzS5cWLLZI23ytfF3mbjKYvohoTZ/BMsp5sfGhvDV1Q/Ii4te+AYpeaVr6qPIuI5vEBMGMjbnT+VGTeoYQVkegGb7wKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736193006; c=relaxed/simple;
	bh=3+psvv1FW635smGcByN8Qe9wt+QETupP25WW0yqawVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unscX1zLvQC92usAkad6ASpVkn83d1LcUj3Hk0Ok5pQ9N9TisU26ySHr8okXzLgxU+0sjwuSa7x706JahCoVfj7x5j3sIcJ1wKio/Z0LF7xttRJrggIoLGooIsOIXmXGHiBl4j0eKuUmnKSEefOmyarT2CPmZrFDDkJFRF3fisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YRkxv6n3vz9sPd;
	Mon,  6 Jan 2025 20:38:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKx_Jm2wiraI; Mon,  6 Jan 2025 20:38:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YRkxv5kLsz9rvV;
	Mon,  6 Jan 2025 20:38:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D9658B783;
	Mon,  6 Jan 2025 20:38:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id mIVVP_mbHxfa; Mon,  6 Jan 2025 20:38:43 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D62328B779;
	Mon,  6 Jan 2025 20:38:42 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] libperf: Add back guard on MAX_NR_CPUS
Date: Mon,  6 Jan 2025 20:38:28 +0100
Message-ID: <8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736192308; l=1656; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=3+psvv1FW635smGcByN8Qe9wt+QETupP25WW0yqawVU=; b=yko/4Jc9hGQmfj4ORKzOpyTJ1lzmpFG2w64CVvZBdzAO9y6YMRLRrmx91G0XjmHW+FsTFOVE/ yrGP3rnx1sHDovVwX0tdcvfbR4CQ2zIleaZB+GWxNAFtM7enoK/1d1v
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Building perf with EXTRA_CFLAGS="-DMAX_NR_CPUS=1" fails:

	  CC      /home/chleroy/linux-powerpc/tools/perf/libperf/cpumap.o
	cpumap.c:16: error: "MAX_NR_CPUS" redefined [-Werror]
	   16 | #define MAX_NR_CPUS 4096
	      |
	<command-line>: note: this is the location of the previous definition

Commit e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS")
moved definition of MAX_NR_CPUS from lib/perf/include/internal/cpumap.h
to lib/perf/cpumap.c but the guard surrounding that definition got lost
in the move.

See commit 21b8732eb447 ("perf tools: Allow overriding MAX_NR_CPUS at
compile time") to see why it is needed.

Note that MAX_NR_CPUS was initialy defined in perf/perf.h and a
redundant definition was added by commit 9c3516d1b850 ("libperf:
Add perf_cpu_map__new()/perf_cpu_map__read() functions").

A cleaner fix would be to remove that duplicate but for the time
being fix the problem by bringing back the guard for when MAX_NR_CPUS
is already defined.

Fixes: e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/cpumap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index fcc47214062a..12eaa6955121 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -13,7 +13,9 @@
 #include "internal.h"
 #include <api/fs/fs.h>
 
+#ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS 4096
+#endif
 
 void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
 {
-- 
2.47.0

