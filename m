Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9D5187F3;
	Tue, 13 Oct 2026 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912118; cv=none; b=hClo10dy6C4S5A7Una9fc/3b3MI1kndyOwi1R083RrC0C3Y2/I9LfW33PrYiUhLDFy6cwZPySuP+R0Tc/b/HCAwJSdkvR0Zo8BBAWNqR+HL1Z7NcPMNJD7Gcvx4kH0YEvS2cx1ONJz6dQn5kB/zDeGI4yFWMkW4qLDfznE20U8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912118; c=relaxed/simple;
	bh=h2j9cdyCalzptlI9fywQQWTHEudkQc6Gy0ew04rRn2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTGWLotp7R9xzrnrTR99rvixrCZostEXh6SDqM+VOSa7ZME49Uz55DhFYBGGcXU4wj+WWU0EQdMKWa8r5M80YAqzJwt0FIJBotekTLeBFih4lGiTa4EHXOLVT/CcfYg4rq53imMF02u5YeUWchv2YzuYaTcdrajfYkPgfo14ZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmdkMT53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmdkMT53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F711F000FF;
	Tue, 13 Oct 2026 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912116;
	bh=MMZSJiTNLJpppWBHzjLGwa4PYqwp+jaksqe3VF/qBLQ=;
	h=From:To:Cc:Subject:Date;
	b=EmdkMT53xrmRvo2eq+7fqTtTy4vlZWGR/BRGVoVP5bAUQ5ggIlFZ2zyK3FXgVdnX0
	 s5qMX2fB/xkNWZs0ndNml+f7Zkd0JEsiusWSfhZ049WYtyuf7bKOk5JT3tBlA4aHho
	 DSRHaXtgZnIYMAFJ/dovDxRh6N0JQMsF6Wbhiv6BZJKAfRQwg+v87+qa2JfSIh/fH2
	 sXnvJb0J/t583g3PhfCxkpLFpl37RvMKARxHcve5CC8WDQ/GNKgF22ZDdGjewxJB+e
	 ep73xH5o59uBrmzeW7ulFgkpQEPztpo5OluLabIRtbkZHMTxd6iS+8bC3ihl9BxQdJ
	 cpcbyHbOh7WLw==
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
Subject: [PATCH v5 00/11] perf symbol: Properly seto DSO binary/symtab types
Date: Tue, 13 Oct 2026 10:21:44 -0700
Message-ID: <20261013172155.160869-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Currently we have 3 types for a DSO.

* binary type: determines where to read binary instruction or data of the
  DSO.  Basically used by annotate.  Some (special) DSOs like kallsyms or
  JIT may not have the data though.

* symtab type: determines where to read symbol tables.  Set when symbols
  in the DSO are loaded.

* debug info type: determines where to read debug info.  Used by srcline,
  DWARF unwinding, data type profiling and so on.  Often debug info is
  saved in a separate file.

Some DSOs may have the same type for 3 and others can have all different.
Previously it generally assumed binary type would be same as symtab type
but now I think we should not and only set the binary type as it's used.

Also it should make sure that symtab type is set properly after loading
symbols in the DSO.

Probably this patchset won't make any practical difference in runtime
behaviors but I think it's good to track them accurately.

v5 changes)

 * reset errno before dso__get_filename()
 * check ELF section type being SHT_PROGBITS

v4: https://lore.kernel.org/r/20261012234654.60666-1-namhyung@kernel.org

 * add Ian's Reviewed-by tags
 * make sure to grab _dso__data_open_lock only once
 * check open file count before closing the cache
 * clear errno so that it won't have a stale value

v3: https://lore.kernel.org/r/20261012052601.13920-1-namhyung@kernel.org

 * set KALLSYM type for split kallsyms DSOs
 * take dso lock in dso__find_binary_type()
 * handle EMFILE failures in dso__find_binary_type()
 * drop the libbfd change as it need a separate patchset
 * lookup binary type in dso__e_machine_endian()
 * get rid of machine_or_dso_e_machine() due to a lock problem
 * fixed a bug symbol__disassemble() for BPF and kcore

v2: https://lore.kernel.org/r/20261006234315.920817-1-namhyung@kernel.org

 * add dso__find_binary_type() for checking ".text" section
 * make perf annotate use the dso's binary type directly

v1: https://lore.kernel.org/r/20261005063411.114244-1-namhyung@kernel.org

Thanks,
Namhyung


Namhyung Kim (11):
  perf tools: Remove redundant dso data init
  perf tools: Check ELF section type with name
  perf tools: Try linked debug files for DSO debug info
  perf symbol: Update symtab type of vmlinux from build-id cache
  perf symbol: Set binary/symtab type for split kallsyms
  perf symbol: Get rid of machine_or_dso_e_machine()
  perf tools: Factor out dso__find_binary_type()
  perf symbol: Set binary type for JIT map DSOs
  perf symbol: Do not set binary type from symtab type
  perf annotate: Simplify symbol__disassemble() with dso binary_type
  perf test: Fix dso data tests

 tools/perf/tests/dso-data.c  |   7 ++
 tools/perf/util/disasm.c     | 124 ++++++------------------------
 tools/perf/util/dso.c        | 144 +++++++++++++++++++++++++++++++----
 tools/perf/util/dso.h        |  13 ++++
 tools/perf/util/symbol-elf.c |   3 +-
 tools/perf/util/symbol.c     |  50 ++++--------
 6 files changed, 190 insertions(+), 151 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

