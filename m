Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B25349C3;
	Tue, 22 Sep 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080003; cv=none; b=uy8Vk8WILBbr4D9b4561QC+mC75aPmQG4Qa8khPB1+/6GrzE+HtCKGY2Gv8ihD5pmIvDP6s+7CDa5umohYfPXOczOzGPdoFcwNZZVh3n3PS/fIfy5QJW3GPu5GHkD23cQwURIBDXhD7yztrq22NXuxgVLTMXkp9oEuCDdSpEmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080003; c=relaxed/simple;
	bh=2XPwPe4cw32/4YFixNJKbYmWKlgmTK1A/+2SS1gaX/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvjRDle+sA86gZ5O1AMrsX0eTOqd45/hrEGBR0t6qn+NhmJKyHG0GXVtwkALuXiQbDKvpgpeIGgRsgsvcJpfL705YPeEVV+WwPq3iaZiOC9y74awtSODYahq2rDEDrza0sEY+ieMDmJygF/yoqgpHBkataYkOoSun7ELlMAPGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bk9qOqY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bk9qOqY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B62A1F000FF;
	Tue, 22 Sep 2026 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080002;
	bh=KXC8xF4chSF6dXf8Ums+XRHgQjzAkjXWJCYI/jadOeM=;
	h=From:To:Cc:Subject:Date;
	b=Bk9qOqY5Ry484GfkePSFr7n09hc+IDaLJPAwdRwV+OqbZT8gktKEnMbO64ICajWWA
	 CYXXKJ/CG6m8FrWt4OT1KTQRFtGwfmJHzvtoIYgFKZXGxc1c0gmZGVECsbYed59cwK
	 AYbvEZanOrq8En2HJAE/izgUwkFoaRx2APCP1Q11KSrmLAnVtTRWD1dgsYpIGVA83J
	 /GwKDkb/2CuJqC1zhDuxr6pqBVPpk+NgL6XQTUHh2SpHENRuZ/+o2Tp+oJGSDLUnyN
	 H99vrNHfG3YLz6sniiN6p9muoCGH7cyw8CMIk8Oa1EhibaMPeaXXTMkxrq1J136Wkx
	 88LvZyaQC4VIw==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 0/7] perf annotate-data: Fix hangs on broken debug info, data type browser sample count, AMD mem record
Date: Tue, 22 Sep 2026 14:26:16 +0200
Message-ID: <20260922122623.1029132-1-acme@kernel.org>
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

 tools/build/feature/test-libdw.c           |  13 +-
 tools/perf/Documentation/perf-mem.txt      |   4 +
 tools/perf/Makefile.config                 |   2 +-
 tools/perf/arch/x86/util/mem-events.c      |  24 ++++
 tools/perf/arch/x86/util/mem-events.h      |   2 +
 tools/perf/arch/x86/util/pmu.c             |  10 +-
 tools/perf/builtin-mem.c                   |  11 +-
 tools/perf/tests/shell/test_data_symbol.sh |   6 +-
 tools/perf/ui/browsers/annotate-data.c     |   2 +-
 tools/perf/util/annotate-data.c            |  57 ++++++--
 tools/perf/util/annotate-data.h            |   3 +
 tools/perf/util/dwarf-aux.c                | 150 ++++++++++++++++++---
 tools/perf/util/dwarf-aux.h                |  17 +++
 tools/perf/util/mem-events.c               |  11 +-
 14 files changed, 265 insertions(+), 47 deletions(-)

v2-head: accb5b700197ce2a
base-commit: 29f320d221c1c4c082c7eafb2251fedf8a4868ec
-- 
