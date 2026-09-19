Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23162E0B5C;
	Sat, 19 Sep 2026 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850444; cv=none; b=iG5EdW+ev4ubGyqvsyKvHFPOw+5C7y0I14zJYbEj87akygI4/da3eStvuWHrq5CTbpa+RF7P2/jflaV6TPy7FlbiUrrGv41UQNJNfdv7UKujDWejzW8YDb2QFAEQnW5puwTMC1b2MixPq+taZyKn3Ss+hxfoc/IwmgrgY6/chAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850444; c=relaxed/simple;
	bh=t0QEehI+e/J8lbn6HrAOnRvDcMpKBsYx/wA/rHZYryM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pN1o7rUD5pMS+vMxjHN2wgO2Q2rXsoWKjRNrH8hvfooBEL43PkqrRDb/6ZGd4C5+ztfB27VuZ2pSvONWPJEg1AFYw9mTT4EtrVlp2p9CgmNQofWk2iVexNKudlvgPWjJqddIqxK4FEfN4xiPwW2hDGvoUk3ELmZwHZdxy5BCs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkgZVBJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkgZVBJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA721F000FF;
	Sat, 19 Sep 2026 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850442;
	bh=IsD/mW/05Vk0gPxkXk04e1AFOyLide5/uBY7gqXwquY=;
	h=From:To:Cc:Subject:Date;
	b=bkgZVBJ56AS0C0aXBpNwFwhkJH+Kh8n2SqA2oL/Xoh2uS+GWnrnIH1mShsJezlaxX
	 3yUsLCFS3UwHXfFxr09wyErN7r8ZmeRQjIi6TGZoir71EUE5IeinZErrITAM8pOnt5
	 g1k8Zp+ZjuDRBEjwrKRF/tzEKYW/Wbdun2uIXT4rUVVtQDr6chIReMa3bpSXhhLI1W
	 xssrZbhakJHT/k9fP6xztHc/Uf7TzsX4tXocNE3CH2hgOLSloMDnDMiF969ojBym+u
	 Pc8CeMCnTO5rUttYM1XIssr/jGSeeiKKN9b482Kk3ctRm4/pUo5PdAqZBPA6HNIjiL
	 w5ea2Pm77DC1g==
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
Subject: [PATCH 0/7] perf annotate-data: Fix hangs on broken debug info, data type browser sample count, AMD mem record
Date: Sat, 19 Sep 2026 17:40:20 -0300
Message-ID: <20260919204027.8504-1-acme@kernel.org>
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
