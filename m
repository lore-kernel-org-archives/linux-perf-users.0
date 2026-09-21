Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2094BB29F;
	Mon, 21 Sep 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009310; cv=none; b=BfwFe1cPyua82c+rRYdh5eVRmtA9dBINd/TNO+l4Qo79xodwMRDUNyzx3Jpq7TycFJVGqMZ76jn88Snw0h6D4s7tmX9d357eYMfbiK9U28wDMDora0LXTnUTzrx5hw6Z12IxZtCtz2hVA/e22sDPl8VDq9J8y4x3F6UKxPiqZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009310; c=relaxed/simple;
	bh=mcl/Eoj5tO9KiO4DIwFqmJNlClp5BdNDlsBeH5djpmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVfJgUp6is2wVfH3mXaVWukL1Z2EGd+qxEV/MtAdJ29ms1whr53n2y9ZvS+YzcYx8RT6bnrvZuK3pR5Idj060mni2G3f7YsE6EatDkREPhLkvS9PAF2agCuzun2nWPaN6zOAumKUfe4zEnui6vQ2vkYev1kCzYZas8un8sh4Gac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLRStumx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLRStumx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0F91F0089A;
	Mon, 21 Sep 2026 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009309;
	bh=A9ica3QEGGYl8PVXJuX500kE3DlxUVZv/DcY06o+okY=;
	h=From:To:Cc:Subject:Date;
	b=hLRStumxD9Gvnf0XIH6iEXOR4M9vhpX1x8K9biN/pFZmXa/yZbW+1rZl37v/SQ+eA
	 DZSlKajWGj4tNQLWHnQO0wxxROuIDdDBsALC1YYzZ1aVoTlun/J1TT8yr2G7ThT+hr
	 ZGlHWQi3mVOMgC1pUY8Jf37TtGUXHWDSFxMFikbIxKnRma8GTkhEtM5/HXcfKuGJjQ
	 ciePxj31ryYA0OGFlv8POCPStMSOFmH5cfMuFEq963weepsp4SeV7JE5aBNPHKS+OP
	 K8aoSu8g0t23vL6ZtWEJe/nDKjMo7+eoHpjO+v+T4B68mZjryUoBw4DBYcCl0qDOAo
	 DPFqGCdX8GfEA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 0/7] perf annotate-data: Fix hangs on broken debug info, data type browser sample count, AMD mem record
Date: Mon, 21 Sep 2026 18:48:06 +0200
Message-ID: <20260921164813.6727-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

This originated in another patch series, 'perf tools: Annotate fixes,
stdio progress indication, debuginfo-client in more places', and is
being split off so that these fixes can be reviewed right away; the
debuginfod download feature work from it will come later, separately,
based on this series.

  - 'perf report -s type' spins forever on the dwz compressed debug info of
    zlib-ng (libz.so.1): die_collect_vars() saves a type DIE offset that is
    relative to the file the DIE lives in, the dwz alt file for types shared
    by several CUs, and resolving it in the main file parses whatever is at
    that offset, here a typedef whose DW_AT_type refers to itself, making the
    typedef/qualifier chase spin (patch 3), with the chases bounded so that
    other kinds of broken debug info don't hang perf either (patches 1, 2
    and 4);

  - the data type browser's samples view (-n) prints a local count that is
    initialized to zero and never updated, so every member has no samples
    (patch 5);

  - 'perf mem record' requests PERF_SAMPLE_CPU (patch 6) and uses the IBS
    swfilt filter when the kernel exposes it (patch 7), with the tables
    carrying the term kept in the arch/x86 code, where the knowledge that
    IBS needs it stays, as Ravi Bangoria suggested reviewing Namhyung
    Kim's v6 review remark on this patch
    (<4349c387-5b8a-4e8d-932a-5175a7598e1e@amd.com>, replying to
    <aqsRVABj23jaaiSq@google.com>).

About PATCH 6, answering Namhyung Kim's v6 review question
(<aqsPKGVUkWk6wvYA@google.com>) about the --sample-cpu default: the
data source field is about the memory hierarchy level of the access,
it has no record of which CPU issued it, and while the TID is in
every sample and in the CTF stream, a thread time-sliced on one CPU
or moved between SMT siblings is not told apart by it from cross-core
contention, so it is the CPU id that keys it, and it is what the
false-sharing detector in pahole needs.  The TID is recorded as well.

Requires elfutils 0.160 for dwarf_cu_getdwarf(), so the libdw feature test
probes for it and Makefile.config says 0.160: older versions now disable
dwarf support with that message instead of failing to link.


What changed from v1:

Bump MAX_MEMBER_DEPTH from 8 to 32, addressing a review comment from Namhyung.

Best regards,

- Arnaldo

tools/build/feature/test-libdw.c           |  13 ++-
tools/perf/Documentation/perf-mem.txt      |   4 +
tools/perf/Makefile.config                 |   2 +-
tools/perf/arch/x86/util/mem-events.c      |  24 +++++
tools/perf/arch/x86/util/mem-events.h      |   2 +
tools/perf/arch/x86/util/pmu.c             |  10 +-
tools/perf/builtin-mem.c                   |  11 ++-
tools/perf/tests/shell/test_data_symbol.sh |   6 +-
tools/perf/ui/browsers/annotate-data.c     |   2 +-
tools/perf/util/annotate-data.c            |  53 +++++++---
tools/perf/util/annotate-data.h            |   3 +
tools/perf/util/dwarf-aux.c                | 150 ++++++++++++++++++++++++-----
tools/perf/util/dwarf-aux.h                |  17 ++++
tools/perf/util/mem-events.c               |  11 ++-
14 files changed, 261 insertions(+), 47 deletions(-)

base-commit: 29f320d221c1c4c082c7eafb2251fedf8a4868ec
--
Assisted-by: LLM
