Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255E2222B2
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865160; cv=none; b=nvI1Lb6qOxL0iR21WVomGKPJ8EW55RNcInfGcrajMl6rNjE/vxzLCZ/VddhCjkawIsF0HMQRQsZ/hxoVm0BSsbAKesz3+rsgiaeiow2rBY+x1Z+57VJkkqp5ScTRdxviP8NsXwT4t+CaopWMTcFdDrdKSSZGME9MRti19ezuv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865160; c=relaxed/simple;
	bh=7PuQ+2QfZxjWPqMiWzFq8W4TadqStCpGBbZ5HXyMZoo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=G6spaqdWlriYYWGWh9DLK8U6RIR/yjLHaBKJXR4QFq3EFTO5sBeSiONWzpfzn76y8IL54DXRUP/noEIM2cszZeBmb1hf3SbpW14i5Um+3yZ4NW4I13WnejRbNb08oGW7ZkOZvpq8Wr14lkNe0WalsWvZodzGtdCv6QExTe8lVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auI7rHlj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auI7rHlj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso6100738a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 18:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763865158; x=1764469958; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3SPglcuk3Z0Bx6JNwPMJEe2HFAseXrWXU/S0ehemlo=;
        b=auI7rHlj9Ia0YI223PoAV9SeqRbbXD4GhubKScfpPGfe97CKB+iESLzoCaFWV4gzV/
         k58ocy/VMDHTF9aruYIyA+o5L/0kjOuvCEGH1u1/JEFhNGUP0etIVNi50jC8jzKl++UI
         gUjtC/0f/TllrnwDxNbqw97niCD2/9r+9Jze4Qg+LkFt4TkMqcopempnR/IRrxsD493E
         sHZA4h5OPd7epJvcgPrSPZ0S8xq/ScENFtxQAIUcKMB5YdLg0SR/R1mbBqMHU1/AujjS
         I9cnyipF1NqSwGYYkgBjRIxaNiOQEdyx6XQnptk3IT8CbacCoLtX9Dl+jly7lcm6kpfG
         nzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865158; x=1764469958;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3SPglcuk3Z0Bx6JNwPMJEe2HFAseXrWXU/S0ehemlo=;
        b=vK5fzfVR9ffQcCccQ0ExL9b7B4EcXMYFN0kKb2tZF3nlAvQ6eXigT+mBXVYCwgZPP3
         8N/d1eWA6DK3NGQNPJI5eUQXP//j3FgSbTDGzpIpa89i9U7SXSIUTG60jeHfXBudOBKn
         pY8FsB0IclTU+NM7mUA7P938Y9goFXLVeGkaFLAvjPRrNJCKkfxCgDYh5DM0sjBqqcBR
         SIzFGvvveQG+rW2sx9+FGBHV+zb4uuT5qSpo93eoMzXKUWfCKCv7FvRqQJd7u7wwkHEY
         NdHhZljM3SIbtNGjM+h+LPvOesIlQWFzMp+ZdGpNlU7ULwlrvWsb3By40rHsphC6oYOR
         2XKw==
X-Forwarded-Encrypted: i=1; AJvYcCWUjL5T0TteIiw5O05kkESp7tjrqf496z6jg41GTwI0dxVDHMYXGdDTrIN4J3D8swXlMAjTayU9wX6RjFSyXobZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyCRGGMi8e62kJ6w8Xjnqi4051n9QC2U/KA1ctFtHWZqY4uQgMI
	HDl5SnhudjLM+fCypr4QBvz6+AT+GvKe5g38+yryR9Axn1VoMqIRol4U7oxQcJty7ii/6dTsqlA
	soTfA0Le4SA==
X-Google-Smtp-Source: AGHT+IHpnscFt0RbrixTCI6wfRaiIvfhemxe2TZOMx4yN/HHuYTJZo/qUbwepJRnIOjTYXKPTGPuVzfgMBsW
X-Received: from dlnn37.prod.google.com ([2002:a05:7022:61a5:b0:11a:2020:acaf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:c085:b0:119:e56c:18b3
 with SMTP id a92af1059eb24-11c9d8480b1mr3697387c88.27.1763865158103; Sat, 22
 Nov 2025 18:32:38 -0800 (PST)
Date: Sat, 22 Nov 2025 18:32:21 -0800
In-Reply-To: <20251123023225.8069-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123023225.8069-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251123023225.8069-6-irogers@google.com>
Subject: [PATCH v1 5/9] perf symbol: Move dso__load_bfd_symbols out of symbol.h
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
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
index 8b31d1d05f90..2459656b01ac 100644
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
index e300f171d1bd..5b5149516f1a 100644
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
index cc26b7bf302b..638015651547 100644
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
index 42d8e3fd1d01..d37d5a97bc6f 100644
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
2.52.0.rc2.455.g230fcf2819-goog

