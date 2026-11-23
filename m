Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476026;
	b=LTP5UgBpIriU5lV/1JWDus/+UwNZmBNa6/QJis//fmRJU9WdTep14TAoc8IhMjE5u7wI
	 zc+9hevlGY+64gwUXDfV2N7N/CQ5thL6Wzne72a2SvUnVytZ2HFba8HcsmZQyBoMtDdE2
	 5Esqxok5i+g2qtBFPzrX26WEp+PDVwTE6CU+Lq5BjPlba4Vs+1rZxmd1VXuWMA5UP4Q4q
	 fwOtClcYt78ofWC5eA/B8a6zptmWiYlaTWUe0IxxkuBWTNfN83fuqCTbhsWqOmylnHDz5
	 tygZY1gt3SrZNCBO7t+XZXO5P4ZcnQNSCr5zlnHRGlot1FMsfjP05HRdqsO/4nZyrpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476026;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yzKFAZM1cX/FruAxUljUZdnA6zwMjYlHTey0nTPHka4=;
	b=J5fCI7HxQiRC27bQZkvTSIF4QyKsHSryL+us4nJJRJJgcB7FvLb/hDrQ6MgeW8BKKTiT
	 87udeZ/nrb+waUzz9ferxGef6TzLw+cnk2gEzP4zIgAh1iSwjfsIDwZGq9sLh2pBYfeVI
	 z0zEBDAuosSf7uJyjwObPNfssNq7vh+j/sbal+kH+3FytazmMxikGiSPVoB9ckovI1bHa
	 B9Pg7tAov8gcUnhXsbjdD1NevRMa+pecrNs+bwRWmqwrfkaferUHFnDignBfenKkTEwVB
	 f2uKSjJ4AGU26RnuLgCqrR9CLaOoIzXwPLzuGEiedQZ86VXdiinpI3dUhGNP5EyH4bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/RmTvjE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F6606A321;
	Mon, 23 Nov 2026 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/RmTvjE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79A81F000C6;
	Mon, 23 Nov 2026 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476026;
	bh=yzKFAZM1cX/FruAxUljUZdnA6zwMjYlHTey0nTPHka4=;
	h=From:To:Cc:Subject:Date;
	b=k/RmTvjEh5neVX+fnQAkJYRaRbVhx+0pbFTJqNYcFDfkwCi9hVp9HFaDggia/aEXp
	 wiP3WEUJdA/wLjXn66bmesut1/118JBe5gkDvZZLm4LWJy0C5+oSxPEU3T+k5P19Wt
	 WxwxlDM11J/2Ch4lsHMB0eFGXi9C0cMItpSkd0aCNWZmHr2iq5bc6DQXNgP7T0FTDF
	 xeTC6215tGNYiN4aTNzg0wDJXOWSq8DAaPZCwZLs7ebPbTtYAWSB77HgwiYtGp9LpL
	 8PD+fmWzIcgME6OsClZKZmRJsNTb2rQpZzyHXxkzAp1sA+zY0ZzJy7iYaVG95VOVfN
	 kyJTJJudIv2Jw==
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
Subject: [PATCH v3 00/11] perf tools: Enhance namespace and chroot handling
Date: Mon, 23 Nov 2026 15:20:14 -0800
Message-ID: <20261123232025.1406560-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
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

v3 changes:

 * Guard evlist before calling evlist__session() in write_boot_id().
 * Repipe PERF_RECORD_HEADER_FEATURE events in perf-inject pipe mode
   and add a boot ID pipe-injection shell test and unit test.
 * Pin a reference-counted host /proc descriptor across
   nsinfo__mountns_enter()/exit(), access relative /proc paths via
   stack-buffered nsinfo__proc_{open,stat,readlink}() helpers instead of
   heap-allocating mntns_path, and handle ENOENT/ESRCH on ns/mnt stat.
 * Skip filename_with_chroot() chroot resolution when
   nsinfo__need_setns() is set.
 * Add compiler context-analysis lock annotations (__guarded_by,
   __must_hold, __returns_ctx_lock) for struct nsinfo, host_proc_lock,
   thread->nsinfo, and __thread__reset_nsinfo(), plus locked accessors.
 * Expand mount namespace tests to verify overmounted /proc during
   nsinfo__mountns_enter() and own a private mount namespace in
   enter_private_userns() for clean nsinfo__mountns_exit() restoration.

v2: https://lore.kernel.org/r/20261116055731.707164-1-namhyung@kernel.org

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
 tools/perf/builtin-inject.c                   |   29 +-
 tools/perf/builtin-trace.c                    |    2 +-
 tools/perf/tests/Build                        |    1 +
 tools/perf/tests/builtin-test.c               |    1 +
 tools/perf/tests/namespaces.c                 | 1188 +++++++++++++++++
 tools/perf/tests/shell/header.sh              |    9 +
 tools/perf/tests/shell/pipe_test.sh           |   21 +
 tools/perf/tests/tests.h                      |    1 +
 tools/perf/util/build-id.c                    |   15 +-
 tools/perf/util/capstone.c                    |    8 +-
 tools/perf/util/debuginfo.c                   |   19 +-
 tools/perf/util/disasm.c                      |    8 +-
 tools/perf/util/dso.c                         |   58 +-
 tools/perf/util/dso.h                         |   34 +
 tools/perf/util/dsos.c                        |   17 +-
 tools/perf/util/env.c                         |   69 +
 tools/perf/util/env.h                         |    4 +
 tools/perf/util/event.c                       |    1 +
 tools/perf/util/header.c                      |   28 +
 tools/perf/util/header.h                      |    1 +
 tools/perf/util/jitdump.c                     |    2 +-
 tools/perf/util/machine.c                     |   16 +-
 tools/perf/util/map.c                         |    2 +-
 tools/perf/util/namespaces.c                  |  439 +++++-
 tools/perf/util/namespaces.h                  |   23 +-
 tools/perf/util/session.c                     |    1 +
 tools/perf/util/symbol-minimal.c              |    4 +-
 tools/perf/util/symbol.c                      |   45 +-
 tools/perf/util/symbol.h                      |    3 +
 tools/perf/util/thread.c                      |   97 +-
 tools/perf/util/thread.h                      |   15 +-
 tools/perf/util/util.c                        |    7 +-
 33 files changed, 1998 insertions(+), 175 deletions(-)
 create mode 100644 tools/perf/tests/namespaces.c

-- 
2.56.1.809.ga0b61035b5-goog

