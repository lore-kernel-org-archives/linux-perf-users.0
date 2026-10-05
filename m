Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5D353A8A;
	Mon,  5 Oct 2026 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182058; cv=none; b=ie0LrzsFm+IitWmTixDeOghxcjtmsPC1DPRFCcEcwlBI/1vV49yOi0PIyTfnKIMLJrMWFndBv5eBMBFAd1Xx+XxotUcJv+w/zJ4UiFCOuMGskJRm6WX5chMCrlN2AGuHM4qp/kcTnDtFyf86s5THJI0SRKjd3QO0gQeu3O26JYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182058; c=relaxed/simple;
	bh=t0VND/ZNi2LzgHHGr25DobYEoxL3W1E6S9XSlquf0Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFvOx0sgNf3ETevcwneOTCc2dexd1j57PAmQ7fHv8nK4/YKE+LTDVKqfwZvlOfzEAeLO1s4cjUz5sFCXPA6YXeq7I1Oa2JXRMEU0oxdiOAdupoYrEbxFL0fcvMfJ6q8im0guWKF6/wc3fW8ttEZeFh9Gxg0eCn6Xq9wZJsP/ZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWPGZUTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWPGZUTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCDC1F00893;
	Mon,  5 Oct 2026 06:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182057;
	bh=iaTGEG/jjedlnWlnKk2FZ8mYAT4nod/qch1LA6gb3Kg=;
	h=From:To:Cc:Subject:Date;
	b=SWPGZUTN6P75/I3b+SODm+Ts1BrsuAcCw2sxDak6hRtgeuJGnLEVrAmDdKyOcCJGW
	 RrBoYOC3hbBJRrkUDa6AglOf+ISmH4USW6d3sjVL8Ysz2yNSkQxY2SXkF+w4B+WuNN
	 1Grm0aaj9wr22UBa15qlQ0pobq69FiLlZtOqGnJHRZOy9RPQLbYD6O0sWoccmCA6EJ
	 RzWWMQ/hldpkoApGqQiPyPakH74VcRdMPlZNF+n3lnNo8Fvr+CE/b8W6D37G0/rDsI
	 vnLpuEfdoREiAk5XgnunIEp1KAVEt5bOo7TXUK0Mo6Gm7KfqsSIVH67KQyKikSXGPr
	 qdnakr2SoTPZw==
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
Subject: [PATCH v1 0/7] perf symbol: Properly set DSO binary/symtab types
Date: Sun,  4 Oct 2026 23:34:04 -0700
Message-ID: <20261005063411.114244-1-namhyung@kernel.org>
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

Thanks,
Namhyung


Namhyung Kim (7):
  perf tools: Remove redundant dso data init
  perf tools: Try linked debug files for DSO debug info
  perf symbol: Update symtab type of vmlinux from build-id cache
  perf symbol: Set binary/symtab type for split kallsyms
  perf symbol: Set dso symtab type for libbfd
  perf symbol: Set binary type for JIT map DSOs
  perf symbol: Do not set binary type from symtab type

 tools/perf/util/dso.c    |  3 +--
 tools/perf/util/symbol.c | 23 ++++++++---------------
 2 files changed, 9 insertions(+), 17 deletions(-)

-- 
2.55.0

