Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783F3B42E0;
	Mon, 12 Oct 2026 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782772; cv=none; b=luzHhWIGmwfdVGj9vNXGMJhCsq6suLvGze9wop2ETwx/r+yvH8dzarCM40dwseqmY9eKUGHuEachWZv+IAfTc0Q/WFDrZj9zq0oBG6mNLvhJXdlv6q/ymehjUEGjhsbp14WpLkpP4qyXt6qt2iMs1SMDdtuFUtcwKoQ+G2saf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782772; c=relaxed/simple;
	bh=jXPjjtFDGSjmQK9MKm3drEDja51slSYUo3fDSRUdV9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpBh8wvKA9i8P68gboVCm2eeK4VT6ylkJLVc1weFMnElUsO2LN+zwjiLWL1dAWUOSwjxRaRtlrntpGLPdlUH2yk3kh7fz3PSkZ6cfzv+GmcBv/az3a9qYj7lw2fBGSEVOZjNx2sLiyacdHKs88WDnfe7iVQH6srL21eFi9DX5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNUbE3H6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNUbE3H6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605991F0089D;
	Mon, 12 Oct 2026 05:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782771;
	bh=p4SDLhDzphSrxzZzPsGweRpgfQvhvi1GFRUaPrEoe34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kNUbE3H6I4W+/+3JWhtYD3wO2FA807UmGxl/A9WYR8O43DR8lV8r1Bw7XxduBWsVs
	 nznJDgyD8tx4n1zDhr2wMsrwXokAI/zoEZH82eg7HWuUuF2+oMZqMQGf11jVe8M2Bt
	 rqfCGm+T2R/Xb/WzJOu+9mguiUSVB2Ztxhga0hE5pv8zYaIk1feVqla3gl7BtkLDVv
	 jD1M28n4bl9tgRLigBcgebmdl/vsVRkdW5ofYHMHpqcUWaLYWoEuFuKuI834vaVAjP
	 JUQiWaOMORYFCvRT7REYkwOpmttOcFGcleZgvo5HqnxvWCbgYGa16mrM/L4CCRf94Y
	 khG9bWLYKx+zg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 08/10] perf symbol: Do not set binary type from symtab type
Date: Sun, 11 Oct 2026 22:25:59 -0700
Message-ID: <20261012052601.13920-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DSO binary type is to access the binary (e.g. instruction) data
while symtab type is for the symbol table.  They may or may not be in
the same file.  We should track them separately and correctly.

As special binaries already set their type before loading symbols, leave
the binary type info and only update it when actually opening the DSO.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c    |  3 ++-
 tools/perf/util/symbol.c | 13 -------------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 851b39c63ec861e7..a8e531766f1b5c09 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1485,9 +1485,10 @@ uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_
 			       bool *is_big_endian)
 {
 	uint16_t e_machine = EM_NONE;
+	enum dso_binary_type dbt = dso__find_binary_type(dso);
 	int fd;
 
-	switch (dso__binary_type(dso)) {
+	switch (dbt) {
 	case DSO_BINARY_TYPE__KALLSYMS:
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__VMLINUX:
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 4a8c298039447cec..116870595f75c7dd 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1943,19 +1943,6 @@ int dso__load(struct dso *dso, struct map *map)
 
 		if (next_slot) {
 			ss_pos++;
-
-			/*
-			 * The binary type is used to find the file containing
-			 * the executed instructions, so prefer the types that
-			 * refer to the actual object over debug-only files such
-			 * as DSO_BINARY_TYPE__DEBUGLINK.
-			 */
-			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND ||
-			    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
-			    (symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
-			     dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE))
-				dso__set_binary_type(dso, symtab_type);
-
 			if (syms_ss && runtime_ss)
 				break;
 		} else {
-- 
2.55.0

