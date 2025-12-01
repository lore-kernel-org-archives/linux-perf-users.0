Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D014269CE7
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622544; cv=none; b=eJRA5D0bAmCkKLmJ58xzubFXqYeGCbKXZZkTvQbughw5AXidOnez4Fb1z45PiUzgCKCpcWYA3u/ExUCFEMhoD7D156jVtr3x4YV9K6jPAUyUaLNMt+OydBr5PzauhwEZRHrleLrNm05TntRB+7IKOzp+1l9+a3T5cqXVggXv5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622544; c=relaxed/simple;
	bh=/HQYxPyULLvORGSXVTG3Vsicqzs81N227w3aDCmJViU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Ure2d3Xwnlz0K9UZX3AttV5jSI8g2kC4DY8Oov9citj+wtE282PdK719QchjR2Uvfq8OIYBnIAdZ+Mf25fjViNC7QvCSJBOyb1Nq5f9YgxJf7UeQL8Oyr8CZB1JEaZBWU9nvftf7sBpZ8HngiZ5ZB+Ej9b1rNxLNc45zOB77q9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0R8R8Wjt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0R8R8Wjt"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2956a694b47so60896375ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622542; x=1765227342; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqxG4c4Ejh1cwsCwJj6cVtGyxfElTSuoVo6DlnxDj58=;
        b=0R8R8WjtsORCzY+mx/L8snPNBZubAOhcZA7Xlco9CWtz9piW33s+gUqltKxh5fbpy8
         uqbVv4EwZtjx+bROroI339a4zCNQbWn6NZMbc81i1PK62XB4dRPsRyXgN3l/g4Bjcrdp
         AHVFs1TVutz8YNERrKzRmdFPCBdbnVZ2/tVqmEERrItJqr+VnVniiBYGY40wdSac6Gub
         EnKcgi7uZk+QKoZcCXX2XGSVR8XOOqq0roqKrAal47yqXXvXkx7/ybXPVVJlMrPwEKiR
         ZqMUcbbvGl6Fg2qRhss+84rbRpeBNQlPGTQ+48uFJ9TG43nt7Ln4Cp9nLg3zeZ59c2QR
         okRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622542; x=1765227342;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqxG4c4Ejh1cwsCwJj6cVtGyxfElTSuoVo6DlnxDj58=;
        b=jf3CJir6+ihr2mETpzEtihF0Rn+79C+tArdksr9LWeXx/Ah202//DrFaKt4KlRk5el
         oMxX6JLqDJ434WI5nKi61DtwavRLvtyD1tMy42UaodSotgBgwgMc4uSqU/IP1A3mGrJX
         YnJZ2JYnrXvC891FrLXw0XM70N0TMi5wKWSqJn9Hs+ukS2DJ/jyZpbEjaFelseyn7uqD
         Jn94avFDZzFktvK5wEAEJNqD2ev2fAZMd9hRozdfEL6uHgWovhsGRqxvzs3vs1kzUSY2
         3c3XyzlRqIz4gacEVgB5wxJ9Tm2ArkkbSPdBTgnQ3GRPmUJTLj0EBvMMBStJ+2tb2iTe
         6jow==
X-Forwarded-Encrypted: i=1; AJvYcCWRe5hmvWsiUDvCS0QnTO1iwm0/KKdBRMqcZqAx8fDS+csulrhvYJPYSjeC/9ZUD+sFVDQFd68mHrWEACLRFL5Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxpvyP3jKJmkMA0CKeVXlwjrQgUL9Em9hSiPVZ2TkdTEOX0/M9k
	f8E2r9nGizvDgHUktK9PvEWz1wb7SCml0/JgZqnPhPHyoLu/N9wEyJ4uN8WBrWmsvVRNR9fdMVW
	s1+j0i/9pNQ==
X-Google-Smtp-Source: AGHT+IHxPPg1nZrMrBc6g6s28MBG/8AEGZ8L7TvRjMLuUaeyN2ppmycAcDPmZoMx3Y71gdUm1zTzeLbZv/AJ
X-Received: from dlbqy10.prod.google.com ([2002:a05:7022:ef0a:b0:119:78ff:fe16])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4186:b0:119:e55a:9bf8
 with SMTP id a92af1059eb24-11cb3ef2761mr19885364c88.20.1764622541626; Mon, 01
 Dec 2025 12:55:41 -0800 (PST)
Date: Mon,  1 Dec 2025 12:55:04 -0800
In-Reply-To: <20251201205509.195451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-6-irogers@google.com>
Subject: [PATCH v2 05/10] perf symbol: Move dso__load_bfd_symbols out of symbol.h
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move into libbfd.h where the code is and to make it clear that
symbol.h and symbol.c are generic code. Add libbfd.h to symbol.c
includes and organize the includes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pe-file-parsing.c |  5 ++--
 tools/perf/util/libbfd.h           |  7 ++++++
 tools/perf/util/symbol.c           | 38 +++++++++++++++++-------------
 tools/perf/util/symbol.h           |  4 ----
 4 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 30c7da79e109..e97c7662664e 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -11,10 +11,11 @@
 #include <unistd.h>
 #include <subcmd/exec-cmd.h>
 
-#include "debug.h"
 #include "util/build-id.h"
-#include "util/symbol.h"
+#include "util/debug.h"
 #include "util/dso.h"
+#include "util/libbfd.h"
+#include "util/symbol.h"
 
 #include "tests.h"
 
diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
index 953886f3d62f..086c5f12cc34 100644
--- a/tools/perf/util/libbfd.h
+++ b/tools/perf/util/libbfd.h
@@ -21,6 +21,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
 
 void dso__free_a2l_libbfd(struct dso *dso);
+int dso__load_bfd_symbols(struct dso *dso, const char *debugfile);
 
 int symbol__disassemble_libbfd(const char *filename, struct symbol *sym,
 			     struct annotate_args *args);
@@ -51,6 +52,12 @@ static inline void dso__free_a2l_libbfd(struct dso *dso __always_unused)
 {
 }
 
+static inline int dso__load_bfd_symbols(struct dso *dso __always_unused,
+					const char *debugfile __always_unused)
+{
+	return -1;
+}
+
 static inline int symbol__disassemble_libbfd(const char *filename __always_unused,
 					struct symbol *sym __always_unused,
 					struct annotate_args *args __always_unused)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d8fc5ea77f84..f8c6a37464ca 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1,47 +1,51 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dirent.h>
 #include <errno.h>
-#include <stdlib.h>
+#include <fcntl.h>
+#include <inttypes.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
-#include <linux/capability.h>
-#include <linux/kernel.h>
-#include <linux/mman.h>
-#include <linux/string.h>
-#include <linux/time64.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/param.h>
-#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
 #include <unistd.h>
-#include <inttypes.h>
+
 #include "annotate.h"
 #include "build-id.h"
 #include "cap.h"
 #include "cpumap.h"
 #include "debug.h"
+#include "debug.h"
 #include "demangle-cxx.h"
 #include "demangle-java.h"
 #include "demangle-ocaml.h"
 #include "demangle-rust-v0.h"
 #include "dso.h"
-#include "util.h" // lsdir()
-#include "debug.h"
 #include "event.h"
+#include "header.h"
+#include "intlist.h"
+#include "libbfd.h"
 #include "machine.h"
 #include "map.h"
-#include "symbol.h"
 #include "map_symbol.h"
 #include "mem-events.h"
 #include "mem-info.h"
-#include "symsrc.h"
-#include "strlist.h"
-#include "intlist.h"
 #include "namespaces.h"
-#include "header.h"
 #include "path.h"
+#include "perf-libelf.h"
+#include "strlist.h"
+#include "symbol.h"
+#include "symsrc.h"
+#include "util.h" // lsdir()
+
+#include <linux/capability.h>
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/mman.h>
+#include <linux/string.h>
+#include <linux/time64.h>
 #include <linux/zalloc.h>
 
 #include <elf.h>
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 2b2bbb5914b9..e265e1f028be 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -153,10 +153,6 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 
 struct symsrc;
 
-#ifdef HAVE_LIBBFD_SUPPORT
-int dso__load_bfd_symbols(struct dso *dso, const char *debugfile);
-#endif
-
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule);
 int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
-- 
2.52.0.158.g65b55ccf14-goog

