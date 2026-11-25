Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642132;
	b=c0sNxm2AeuMt1TewiRUdYh7XyYLmBqdakBt43FQrD/UdTk3YNH7kgdeeSbhNDCNb4Jtd
	 F1zvbpLKXX4wwvl/AoPWXto/K1xYwH2d0ev4KZysGWOWvZinu5oLdyI7dwFWbmL5F7MLf
	 MCM8UL06BgGh2QlNm78Fa4OHJRNoiPkxhyrsBDIMaTwbDXSHNlTgskOg+Qylp39LzAXFQ
	 voRUuZ91DypuOyFLEK64AKq6aZJQtUYIKLdzsc2kAToN6aSqo/Is7zUKGBr3oR5keNyNQ
	 X+5E13P/bqIvj1vSPuHzsLCL4KWIXNE0VxWg6NZkvtBh+efqd5BTw7MsCDyLTG7aaYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642132;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7Hmz5vySOboqHrESZPY+xq7qDyDg7gktFhkojo13Pz0=;
	b=47K6ilzPN47yY8K8y1qBoJipAjw2ylcmE8evJHBX3wTDuGR+mCGgklSRPl1OPt2te7Bt
	 5X9gNaQSv7tN4D8sdLN3wr7yD9rbN6yz96PyJpKGxPKfEWM+vjg6U3JHI4QqAxa2AyYO3
	 ptUbz7TX4fOMP2IySdYL779k+CYAfhuSXcVKrrdMiB+BvX0y++BgL8HtDJFaHHI8Igbkg
	 ue5CdQrc1KYRLtFVm9A+1GFtX8d/x5uxYOp6EgqPbbrxZohb5wdir3W3OWkcJboTbs4mq
	 itajpaTA4TEzpgF7o7o1rLRP0lfnrv9Gju8GAXAcyfSohwG6KCLhgSYlDHZo9d4hBtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gdxN4x4l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6798606A327;
	Wed, 25 Nov 2026 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gdxN4x4l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A321F0093C;
	Wed, 25 Nov 2026 21:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642132;
	bh=7Hmz5vySOboqHrESZPY+xq7qDyDg7gktFhkojo13Pz0=;
	h=From:To:Cc:Subject:Date;
	b=gdxN4x4ltjSLrRUiu7ZX5bYI8i3yfR/GkYqDQns38mwjLhgtdajRjfrLxdixVYh87
	 AdW/qQWMdkFd4bPupR2tpC86m7TQZtbGYNZzeHbZQa1KogsSj0ms0eHkWrotKk9qtz
	 iFsir8l2hOhVIuQyJwFclbOPgEQR5+S/2bE56BMCxbjcFmNiZDI85FGpOwnf5NluIr
	 dVCKZh2+7SOoyK2pw3TAP7y5YxWhLJEmoqcIsSjZ6xntdc14JoubLrJS1TjKbr+8AL
	 wfzqhmMyW32F1xouP8KTH8keCLsxTrr00J6/8NAw8wFJV5dNsvp0kazea1RmYxOSXq
	 wOXRV161DizCg==
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
Subject: [PATCH v4 00/11] perf tools: Enhance namespace and chroot handling
Date: Wed, 25 Nov 2026 13:28:40 -0800
Message-ID: <20261125212851.1792988-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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

v4 changes:

 * Fix a potential struct thread reference leak on failure in
   test__nsinfo_thread_liveness().
 * Rebase onto the latest tmp.perf-tools-next (preserving chroot
   tracking for --lazy-load-symbols in dso__load()).

v3: https://lore.kernel.org/r/20261123232025.1406560-1-namhyung@kernel.org

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
 tools/perf/tests/namespaces.c                 | 1189 +++++++++++++++++
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
 33 files changed, 1999 insertions(+), 175 deletions(-)
 create mode 100644 tools/perf/tests/namespaces.c

-- 
2.56.1.831.g720f3f5937-goog

