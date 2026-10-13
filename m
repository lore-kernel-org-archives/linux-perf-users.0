Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D616525A8C;
	Tue, 13 Oct 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912123; cv=none; b=DFGL6oYG78j4TZBIOhRGdrB1cP8Z1YJnV8/C3Ak0P2WVTgKnlopHO5TN+A9NNoA6WIW9JNeU2aXIoXJg1H9ynAMm7J52MKgTMJBtPpfxaZJF2p+0clmxf/b9Gzkr40CjwQ6vPMkXIJnKEakXnljRUjmeecb4e/l02mpSBPQ/jN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912123; c=relaxed/simple;
	bh=yU+IuLum0EhshCvoU2fSFEy2wdHpcbGdoVmlaIsdQRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clFISVsNfxqXHopgNp1LyHu555BmK+Kw7I0BAPd0wNR+J55pviytKjzNzVfl1RmMkVuLo2r/FQpKh8w3UU8ZccE7+nIAKwPKeafl4ndHl+W+9Evm3MueszDr1TOKD5gerUM988cM/Zwmy79GQLJ0vZLIXC+MTlB3FrL81GmAA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZzuojoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZzuojoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144A31F00893;
	Tue, 13 Oct 2026 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912121;
	bh=mIAqTHoeg8uGwxo/TJzpHP8yh7LXLsB4Unu125bcb9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZzuojoaYrdke50r8GT4TGcvmLCyp1MVijDDpJfNCJasMsayXD7C8L5t160/lwjdn
	 RIFHl37Z7xnpYNyq2AP0dc4yS0ZB/E9myHIKKI+/M7U3UNaZSpOCHnG1KkcjolcMv5
	 HTlaeHp+qMawpw2B1paSn0KlGd9ZzmJbxv4H+RIZOeyxYD0ZyLNjhI7rBTnrW9O/Qd
	 maBLo0mBKfzrUGwoYrzl4NDJYpxquOFCkR6+3Vy62CVdxLAqXs0J69WRunr8IZzSt5
	 +HC58iaT7BuB0ovLbh8EOM107HNthZJY0IjusRjAZOAi7Qru5nayylsxt5yv149aCp
	 lkEs40qKdSd+Q==
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
Subject: [PATCH v5 09/11] perf symbol: Do not set binary type from symtab type
Date: Tue, 13 Oct 2026 10:21:53 -0700
Message-ID: <20261013172155.160869-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013172155.160869-1-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
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
index 47241077ad260744..1ca4cc5ec7db027a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1491,9 +1491,10 @@ uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_
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

