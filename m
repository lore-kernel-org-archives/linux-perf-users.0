Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9F357D08;
	Mon, 12 Oct 2026 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848818; cv=none; b=WD7lH/aChVNvhRiCb5LVrXMNXr6IYNOETBfVqBAlEP6HsuTUeyk0OrPM8HXbuKXKtWOv/Xk4kvrDUAeWzx5Pk80lp3nASu1iBwBoR5l64OUBah+J19sM1ZRCPYC/45dAwCgx4fYfGLhIbNR+6XoxPODr+Bwf961PYz8UJjpy6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848818; c=relaxed/simple;
	bh=Dxv+4glfuguzNKiD6qWzUvuDJuo4LlK9l2mf2eju9LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nggCKbs4iIeDaX3pY9S4BL3JXVH5t1oLXFQC2yK+KrK63PElioKo2liqGg9o71y3nW8aM8icL6Fc+1BIKarFvcPsjvnabGNkbiyR/+z6Rhu8qO937P7Hmdc+TjToEuWB/Bvvph7v/8YKi1JkejjhY2xyojdePwD3H0wsX6MCXmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6yqVJQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6yqVJQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6BE1F0089B;
	Mon, 12 Oct 2026 23:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848816;
	bh=SRbG10PWsTX1tIEcCXgqP95wBf9YBNSXyvWpJNvUKw4=;
	h=From:To:Cc:Subject:Date;
	b=R6yqVJQSJJSKhr9tIZs/DxpbzGXHRR6bjFw0X7FGg6zZNcwLc682LTp9OqVqIVFYP
	 TlxXGii7a5o7ck98IGKL54Baxmoj9X66VoEOGuj/RzxoQ93gwMHkUSMwe4y3yGcNpN
	 Sg+55vOox88FLlj/Ka5WaPPZwq1PPD+7sjpz1auEzackgnSUc3vLXoIADEgbBnBFc7
	 piHVnma3jtDJgcNVdtmbzqfgazmnvN3A9LCEV11EHZsDnercqnH+1ECRV7VNkEWrzb
	 wlftiRSGP06SyeflVxIycJamNVS1dpyq37LFYjUVr03Hq7s8gM0BwzuVVe/8ZFxJLk
	 Oexx3O/DL4m+A==
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
Subject: [PATCH v4 00/10] perf symbol: Properly seto DSO binary/symtab types
Date: Mon, 12 Oct 2026 16:46:44 -0700
Message-ID: <20261012234654.60666-1-namhyung@kernel.org>
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

v4 changes)

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


Namhyung Kim (10):
  perf tools: Remove redundant dso data init
  perf tools: Try linked debug files for DSO debug info
  perf symbol: Update symtab type of vmlinux from build-id cache
  perf symbol: Set binary/symtab type for split kallsyms
  perf symbol: Get rid of machine_or_dso_e_machine()
  perf tools: Factor out dso__find_binary_type()
  perf symbol: Set binary type for JIT map DSOs
  perf symbol: Do not set binary type from symtab type
  perf annotate: Simplify symbol__disassemble() with dso binary_type
  perf test: Fix dso data tests

 tools/perf/tests/dso-data.c |   7 ++
 tools/perf/util/disasm.c    | 124 ++++++-------------------------
 tools/perf/util/dso.c       | 143 ++++++++++++++++++++++++++++++++----
 tools/perf/util/dso.h       |  13 ++++
 tools/perf/util/symbol.c    |  50 ++++---------
 5 files changed, 187 insertions(+), 150 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

