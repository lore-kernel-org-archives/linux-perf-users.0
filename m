Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808653;
	b=O0A+izNNJ/uITn4LPg19vJ9mVRigzl1PB46zCnrDmQkLYxbC56hhzkvpoDv7TyZ12NmL
	 IqjvxSNgRm75vrMCZqiBH7Mmd3J97Xv4Udoi7LRFFiztGA7jomItkEUwxZbsvNW4tJA10
	 IoVOOAVpk1CFkU/T+Cpqd6PXR0545t7kZuHrkakzO014D1PHHae9ab0NIRvcEH7kgMmJT
	 pRpLyUDkcRZ3szwh5Ls8WyPMdkZylFaGI4MLVjR55jvqj4QCiecSkikuzpOuGhBopDKRC
	 H+mFIqmDt2D+8Eq8f97n33unYs3T6kTNt6Hc+HKPZkeyzos8esSCY/gxuS/JnNOq1Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808653;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pUkY7H2c1MzfnfTXtCUx8vT1H+3fS6TIyxEqBd2KBrc=;
	b=hg4gGCt2kiNvx+YHPzCdrBc7KdID0atQTpv1iNVg1kAnUFKXhUeYWeHrHgZhqtj+IGIB
	 20J70jUZfLOYWHcxFFV7jjQAb6pHLTlXtqcn4L/+SZRPJZ+CxMMf0eP4Shzh7p2F3dHD6
	 o6JZ0tzpv8LF+Q3WghcODbr6p9CTe0s1HaNqvUK3UIVRQMB+LIx0jAKSWh1ufCD31YU/s
	 1Lja6S2Al/jMDnuqlCzEO1vXV+YLBZM1jUKp1TsOCLCTKawMbm0nLS3Po0w6WPtKlUtvu
	 JUoE9uZhasfc16QQRdT1ZIPbEidHAejVzlRLXKgIrU+KOm6nCPImSekfijFzDObylTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0sjcmhE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CD606A323;
	Mon, 16 Nov 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0sjcmhE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4281F000C4;
	Mon, 16 Nov 2026 05:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808653;
	bh=pUkY7H2c1MzfnfTXtCUx8vT1H+3fS6TIyxEqBd2KBrc=;
	h=From:To:Cc:Subject:Date;
	b=R0sjcmhErD0xx/tUVobgJs0LLQu8NQeyhvuxlBw8rxaGcTK0Rg23TL+WFzntwE/pq
	 9bWpHjKVnQboPC/1stBBKMpe6oxcT5rMWf2qUNWWFxL1vXNPRCa/lciEXLEacksJcD
	 /cwZYpqjpeSCIyLvJA18Qu5xUSFnBbq8zyJtEazeEvnOaCWtmwGvWVZ0WI51/ZOzL6
	 /+nvTYicszk2cDM3hHhPhtgCkZdMw+zgo4IRjduZon1503ESF5q7dR86FWXJSSimpS
	 dcpEW9ruNQfiQ7q61tDJcFWS3l0UJ65KEcbAyneJwc1B5cszhwzSYR1rnuhm/uRh3q
	 mkSmsLOY4hiXQ==
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
Subject: [PATCH v2 00/11] perf tools: Enhance namespace and chroot handling
Date: Sun, 15 Nov 2026 21:57:20 -0800
Message-ID: <20261116055731.707164-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series improves namespace and chroot handling when perf accesses
files from /proc.  It defers reading /proc until namespace info is
actually needed, verifies thread liveness, matching boot IDs, and
mount namespace inodes against PID/TID recycling, and avoids entering
target mount namespaces for host-side files such as the build-id cache.

It's assisted by LLM.

v2 changes:

 * Keep dso__filename_with_chroot() (guarded by nsinfo__check_proc())
   instead of calling chroot() inside nsinfo__mountns_enter().
 * Add a mutex lock to struct nsinfo and replace thread->nsinfo safely on
   exec/namespace events rather than mutating shared instances in place.
 * Mark offline sessions explicitly, propagate exit on fork replacement
   and perf_event__exit_del_thread(), and guard sub-thread fallback in
   thread__e_machine_endian().
 * Gate mount namespace entry for debuginfo/binary probing callers,
   include distro debuginfo types, and handle build-id lookups in
   symbol-minimal's dso__load_sym().
 * Add unit and shell tests for namespace, nsinfo, chroot, and boot ID
   handling.

v1: https://lore.kernel.org/r/20261023071141.134149-1-namhyung@kernel.org

Thanks,
Namhyung


Namhyung Kim (11):
  perf tools: Add HEADER_BOOT_ID feature
  perf tools: Add perf_env__is_same_boot()
  perf tools: Add nsinfo__new_thread() to track tid
  perf tools: Add lock to struct nsinfo
  perf tools: Defer /proc lookup until nsinfo is used
  perf tools: Verify thread status and mount namespace inode
  perf tools: Check thread liveness when accessing /proc
  perf tools: Export filename__read_build_id_ns()
  perf tools: Only enter mount namespace if necessary
  perf tools: Scope mount namespace entry in dso__load()
  perf tests: Add namespace, nsinfo, and boot ID tests

 .../Documentation/perf.data-file-format.txt   |    5 +
 tools/perf/builtin-inject.c                   |   15 +-
 tools/perf/builtin-trace.c                    |    2 +-
 tools/perf/tests/Build                        |    1 +
 tools/perf/tests/builtin-test.c               |    1 +
 tools/perf/tests/namespaces.c                 | 1035 +++++++++++++++++
 tools/perf/tests/shell/header.sh              |    9 +
 tools/perf/tests/tests.h                      |    1 +
 tools/perf/util/build-id.c                    |   14 +-
 tools/perf/util/capstone.c                    |    8 +-
 tools/perf/util/debuginfo.c                   |   19 +-
 tools/perf/util/disasm.c                      |    8 +-
 tools/perf/util/dso.c                         |   59 +-
 tools/perf/util/dso.h                         |   34 +
 tools/perf/util/dsos.c                        |   17 +-
 tools/perf/util/env.c                         |   69 ++
 tools/perf/util/env.h                         |    4 +
 tools/perf/util/event.c                       |    1 +
 tools/perf/util/header.c                      |   28 +
 tools/perf/util/header.h                      |    1 +
 tools/perf/util/jitdump.c                     |    2 +-
 tools/perf/util/machine.c                     |   16 +-
 tools/perf/util/map.c                         |    2 +-
 tools/perf/util/namespaces.c                  |  273 ++++-
 tools/perf/util/namespaces.h                  |   10 +
 tools/perf/util/session.c                     |    1 +
 tools/perf/util/symbol-minimal.c              |    4 +-
 tools/perf/util/symbol.c                      |   45 +-
 tools/perf/util/symbol.h                      |    3 +
 tools/perf/util/thread.c                      |   95 +-
 tools/perf/util/thread.h                      |   13 +-
 31 files changed, 1651 insertions(+), 144 deletions(-)
 create mode 100644 tools/perf/tests/namespaces.c

-- 
2.56.0.611.g1030f0b940-goog

