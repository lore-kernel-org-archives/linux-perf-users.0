Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C942047A;
	Thu, 24 Sep 2026 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285301; cv=none; b=IShObzHoAhofXua9NNVNYoahpzlbQgTf4dfte0aW6NeHuwkk6OWRJI1Q4DGgN68XBEpymNm4fLTkLhNWTAZOxR7sRWQGCyxGqEQfQQvxp665gPqZklH5GHizvtKQhIr3FDs6PTWhst5jbtMRuV4wT/L+Al4wvqKyJNDb+8iEPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285301; c=relaxed/simple;
	bh=i8LR5y4Z0NOH0H7lkYQrUW0hfTp/ifNFRIcln3qc5K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRhHPmogvDtxPvvCuVUKvDVkU4nisUADtimRS6PvzEDgsrtio8JJcmBHbe4Wz2CEZDOmUDI8jfK1u4rCG1i09aXHxt4vMjgLcZ6g4coN9xMhBm9wtA3I5meA/2PFIdaUHt+E4xEE4EK3DYztHqzJ5cQpC8DYvIoRDf6UjXmhilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgRZ9sdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgRZ9sdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC261F00893;
	Thu, 24 Sep 2026 21:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285296;
	bh=xTLOjf4nifnl9ZNZ/iJh7kfKm38X01r404KevT1yFFA=;
	h=From:To:Cc:Subject:Date;
	b=fgRZ9sdwR2suqBMhUE8PQPMvo9yfR3hD9B/S9ufPyRCTmgCDC/OBhB4CsCpns7hiX
	 a/R7ZHMPMWtiyZNSacOFm7tCwn2w6vpYMRYc8m8pPhg3WbhN6wY33RJb4uuZqDQqSC
	 ShHaCgiNf07EO8dJj2wvhyvxmxclv4b5NAdTkvb5lLHQo+o5eS2inYGFdu2nLkf75l
	 vI181+vsCoGdAiSjaBr/5IaSsLPUFvsdsOJT1g+S8xwuGthzSeA+oLNDWaMRzbZByP
	 57RbxZxDo4x4D8gs9zBVBOu7Qt5KY7HfLFKFnkxGM7b22a624FntmpF6r8zyUiyAfc
	 24qRGSEMg2Log==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v4 0/6] perf annotate-data: Fix hangs on broken debug info, AMD mem record
Date: Thu, 24 Sep 2026 23:28:03 +0200
Message-ID: <20260924212809.1733663-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

  - 'perf mem record' requests PERF_SAMPLE_CPU (patch 5) and uses the IBS
    swfilt filter when the kernel exposes it (patch 6), with the tables
    carrying the term kept in the arch/x86 code, where the knowledge that
    IBS needs it stays, as Ravi Bangoria suggested reviewing Namhyung
    Kim's v6 review remark on this patch
    (<4349c387-5b8a-4e8d-932a-5175a7598e1e@amd.com>, replying to
    <aqsRVABj23jaaiSq@google.com>).

About PATCH 5, answering Namhyung Kim's v6 review question
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

What changed from v3:

- Dropped patch 5/7, "perf annotate-data: Show the sample count in the
  data-type browser": it is already in perf-tools-next as commit
  9db4e9d6cc7c, so the series is now 6 patches and the subject no longer
  mentions it.
- Rebased onto current perf-tools-next (base-commit below; v3 was based on
  29f320d221c1), patch 4 adapted to the upstream __add_member_cb() cleanup
  that dropped the member_type local, no behavior change.

What changed from v2:

Only aggregate (struct/union) members are marked as truncated when the
MAX_MEMBER_DEPTH limit is reached in the member nesting recursion (patch
4), addressing a sashiko [Medium] review finding
(<20260921165704.38DBD1F000FF@smtp.kernel.org>): the v2 check was made
before looking at the member's type, so a primitive field that merely
landed on the limit, e.g. an int in a struct nested 31 deep, was marked
as truncated and logged even though it has no children to expand.  The
limit still bounds the recursion, as only aggregates are expanded.

What changed from v1:

Bump MAX_MEMBER_DEPTH from 8 to 32, addressing a review comment from Namhyung.

 tools/build/feature/test-libdw.c           |  10 +-
 tools/perf/Documentation/perf-mem.txt      |   4 +
 tools/perf/Makefile.config                 |   2 +-
 tools/perf/arch/x86/util/mem-events.c      |  19 +++
 tools/perf/arch/x86/util/mem-events.h      |   2 +
 tools/perf/arch/x86/util/pmu.c             |  10 +-
 tools/perf/builtin-mem.c                   |   7 +-
 tools/perf/tests/shell/test_data_symbol.sh |   6 +-
 tools/perf/util/annotate-data.c            |  41 ++++--
 tools/perf/util/annotate-data.h            |   3 +
 tools/perf/util/dwarf-aux.c                | 140 +++++++++++++++++----
 tools/perf/util/dwarf-aux.h                |  13 ++
 tools/perf/util/mem-events.c               |  11 +-
 13 files changed, 226 insertions(+), 42 deletions(-)

v3-head: e2504280f5c4086e9851a758ed1bae8df7ef269e
base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
--
