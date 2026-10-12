Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFFC8D9;
	Mon, 12 Oct 2026 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782768; cv=none; b=Yi8jlXDItOn/dqknsq88wSUsX/1ASvMaIUli1HkV+8j4xezCX5FU9XYHS0B6soXBozMJXpF9P0GphP6zbEnE7G51a4YJF/5V0fFI2yRYlpVb6jw+l+kDrRlZx/X9WZBEaeDZHtHlfiZsslFjlUE4uV3Kc/5RuDXhosj6gG2uKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782768; c=relaxed/simple;
	bh=8A/qPMQDnFcsFBZQNtB/jEAND1+3+1KsQUYfehjdRl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+eSZO73KWe+xZfhM4d7vwAoEOiZ2YXWNgd39LusdREqUMJ7waxonWcKnqX6TLi5MH7vQ7rixBtSRFm1a1apjC8h4A7boIZtk7JxT0jI+IyU5APTqgzKk55tVYc+nfjdCR7co+SEMB6uwHOnqgPV50N9IAp46vhYdGjjtEJIpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GueQ+wZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GueQ+wZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212521F0089B;
	Mon, 12 Oct 2026 05:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782767;
	bh=4zTnttmWhhKlTLeHJxeWUGjxP5/8XXmSW8XRHwmiqEU=;
	h=From:To:Cc:Subject:Date;
	b=GueQ+wZMLEoCEleD4h8S7+U50fsgfyB0vpOrL/BKy0BKwClptYKZ1FzUwpAzzgY8+
	 ozMJDlyIM9FgwS2qy6oDgoQEGmZDOD9QzgOLM1YsEPlU/miRw+BYxFsXTZ/YUKw+dk
	 izlyzEIsS7mxiTLNEI7j2ubqbU2IWd0swJHy0hGOzjzN1VLmDtYq7nv4r5OSeq8ntC
	 ynZgtmImW9tvtv6kiFYvc9t9yzRdK4xF8m00ptoRuKEH5PFzclNt4TRJOgXQ5AOp8y
	 k8reimmDrMbxFV5O+RgnKG5CT2RPRKCvi7X7IAYCXBeiDGvqs5/kyhEZ9297et9DZT
	 L/T+ig/Wb69hA==
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
Subject: [PATCH v3 00/10] perf symbol: Properly set DSO binary/symtab types
Date: Sun, 11 Oct 2026 22:25:51 -0700
Message-ID: <20261012052601.13920-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
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

v3 changes)

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
 tools/perf/util/disasm.c    | 124 +++++++-------------------------
 tools/perf/util/dso.c       | 138 ++++++++++++++++++++++++++++++++----
 tools/perf/util/dso.h       |  13 ++++
 tools/perf/util/symbol.c    |  50 ++++---------
 5 files changed, 182 insertions(+), 150 deletions(-)

-- 
2.55.0

