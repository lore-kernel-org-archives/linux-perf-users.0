Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBB3F23D0;
	Mon, 12 Oct 2026 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848822; cv=none; b=kOsCWkY16n7+yljf7y0GkYV1x3RN7I/jBb+6XMeTk0rI52L79Nprl+U4DFOY9nvyxxnpm6MbLOe1ByhkRdK75DPpySfr9+dZIcXE8BsjEoaWAjb8JZbjKxZtz+fDJwzrmmcVHL80nDOhNDgeySWBfYgFABu2gXnHWzhP7gDPIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848822; c=relaxed/simple;
	bh=CapgN5dsj7ULc0xbx1zWo4lDJn6ZPVb3qyRWRuQ+Xcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UY4Ijt62nz6KYKMy56+22nYytLboQtMLvDqD9hQ5dcr1jXewqQVTSlziP2YauX3J2zAmcMIk/hHA1/bJNv6E9dq/kx6KnlbPezyq6978bFl1IUxa9ASkorxzkeO/q78UKDXxwuRUgZ8SNwMDzQ+syPCxDfzvuKNpB21RemGd8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERCFkJB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERCFkJB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C944A1F008A1;
	Mon, 12 Oct 2026 23:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848821;
	bh=vwlc+p26EqOTZqEgS82w79n8JbeEh/y3CKFHmQJ4kLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ERCFkJB2ojwqVHpXE6TlxsoOGJ5DqtCT0wktdGeL+ogplhpm780QNe7slA+UZZVec
	 67b973OPVDjOCOleIv72rmZRZdgpOm6kohg+oE9NrMPB3L7fcj6E/rKZfrDe6wbp+v
	 o2Qc+5nkHkWkfscTXdSwATnxuZw68X4z96FZOq+pMJsSMPZPFAXewIHon6ZySd5Yu7
	 dHlWczndgN1AkUuEfjb63zbPIrINl4KROlzl/dRV5zBjdyRk2H+EpF1xXpJ60y7LzM
	 6rhKEgjq0FtgMKrI7pN+Onu7nu/EYAVHPY+B2OE6ZUJ18sNURb6i05Z+vbZYfDtK7S
	 Egb/h6zY1ixnQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v4 08/10] perf symbol: Do not set binary type from symtab type
Date: Mon, 12 Oct 2026 16:46:52 -0700
Message-ID: <20261012234654.60666-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012234654.60666-1-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c    |  3 ++-
 tools/perf/util/symbol.c | 13 -------------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index c42ad0c5c66a7bcd..5d25f766172b1fcb 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1490,9 +1490,10 @@ uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_
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
2.56.0.385.gd3acb90ef8-goog

