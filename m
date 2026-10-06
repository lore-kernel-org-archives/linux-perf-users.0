Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4993CB8FF;
	Tue,  6 Oct 2026 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330197; cv=none; b=aShTnQqm1Ufu60qEQllejdvM1YYe4/JrAsvD//S8t95U+jwWjFsk7jg04HuwXJZtBAZpRVD8XdcojRGoHFCS3Xon0vGOqExYBKXlU4WRpqAadeRA8uxtutl0jo1a9mTvwhYxDU4Uki9rz7dae4MwNIsKFs53ZrzLZPLjFtTDek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330197; c=relaxed/simple;
	bh=etEMPb7HoKCGBm1fnaZfQCckjg53gnPUfp3juubJLe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOjsVRVwy0dnSDRhfKggjV1YJxamp0XURRjdzV0PrYJ0V7W2qhiPLruzP1MDi4+TmKNtU8Mq+srf6huwPZFKfusDOQywQpNx2ot9gRkWKewetYcIFwu9V/1mCHMyrn2znneeSEIMfZ3Ax08ilprvqacLhjdd3JI/hM+43DD9Ndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+NVG0PV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+NVG0PV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8137E1F0089B;
	Tue,  6 Oct 2026 23:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330195;
	bh=7kFnKbtMRDqGavPAC8BJ88F/mkaTCA7JvNN3kn7lBr8=;
	h=From:To:Cc:Subject:Date;
	b=a+NVG0PVO5MLX33JbBHZoc+DzIaoJnoN/j7ekpun1VXdqf5Eep1+DKDhCiRCYXtrN
	 H8wlJ+OYxsJAyLf0P3wRG0NEJ1erh2wYlakTPHbbFoGO/HSFwO8VInv3s5m4TCCM+w
	 lne9hNN+7fW9HTHeK2h7cjAAwZ4Svp3Wot+BHPXsNbfvLSPivB++EJeqK5gNcpSN7j
	 PDjK96QqeoGTwhe2mDWjB1XPrInoczN2yBd82i/KS++epON7yu7esjoFj++FYC+uPD
	 GmweJvhaVCfiif4I+RWC4zF79Grhy6RlnpyMZyLS1TIOeU5bHioh3DrIE7tIkeOMC2
	 VBL+WjQjncJmQ==
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
Subject: [PATCH v2 00/10] perf symbol: Properly set DSO binary/symtab types
Date: Tue,  6 Oct 2026 16:43:04 -0700
Message-ID: <20261006234315.920817-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
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

v2 changes)

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
  perf symbol: Set dso symtab type for libbfd
  perf tools: Factor out dso__find_binary_type()
  perf symbol: Set binary type for JIT map DSOs
  perf symbol: Do not set binary type from symtab type
  perf annotate: Simplify symbol__disassemble() with dso binary_type
  perf test: Fix dso data tests

 tools/perf/tests/dso-data.c |   6 ++
 tools/perf/util/disasm.c    | 116 +++++-------------------------------
 tools/perf/util/dso.c       | 103 ++++++++++++++++++++++++++++----
 tools/perf/util/dso.h       |  13 ++++
 tools/perf/util/symbol.c    |  23 +++----
 5 files changed, 133 insertions(+), 128 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

