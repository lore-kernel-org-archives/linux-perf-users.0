Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33D1F131A;
	Thu, 14 May 2026 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735167; cv=none; b=XEwFGKGPx9zOstf+0mNY2p8epyDXMAqpug6SzM/QBIB4OOiCPiGCzsSUmlyZXgAtR/Idk0GVoL3M/5oHMYayg1duPFquvQybyeaRpjRwg7wtfiakpnEPTZNyTrNN0J69y5UDPZmVKzq+JAP/8i6e/4tikiFlfvYbl38H89GruDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735167; c=relaxed/simple;
	bh=j2dsDIqac90jQ0WQlQWnsokHihGVSzF8CeUhj5mROUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hb0Iee+hJx9hWzWAQq9nQFTKw6I/rejAWuOFswq5fbguRCjhmTb7z8b8fArlPOAcidjdz6S/7SzVIKhrgC7BcjMRnNNk4lJI9pUESvjFWXNcwKbYxouYugkoL0iWq+e2f+VvBzPJCWuwieAdPBhOlNMZHkC0RMuf4lpkrGM4z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mZNhI7HC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mZNhI7HC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FE4C1E5E;
	Wed, 13 May 2026 22:05:56 -0700 (PDT)
Received: from entos-yitian-01.Arm.com (unknown [10.168.197.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A2DE83F7B4;
	Wed, 13 May 2026 22:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778735161; bh=j2dsDIqac90jQ0WQlQWnsokHihGVSzF8CeUhj5mROUg=;
	h=From:To:Cc:Subject:Date:From;
	b=mZNhI7HCYS4q2+SIi+N5C08riKoYsINO3A33S7yvhol/OO6dezE+5jjYX7RKwuofA
	 bSBdYnLIFODZYDYgrxVxW8ydVuyjNLMKoL3Kx37X0fdSDRcmlIG+HBlNUH9+WbtRW3
	 N5kqDBjyqieeEi9Tu6pku5vc1UX/m+B+9AVo/5eQ=
From: Jia He <justin.he@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jia He <justin.he@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 0/7] Silence spurious warnings and crashes from kunit test suites
Date: Thu, 14 May 2026 05:04:48 +0000
Message-Id: <20260514050455.2954509-1-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running the full kunit suite on arm64 (128-core Neoverse N2) with 7.1-rc3+
produces a handful of backtraces that are not real kernel bugs but
rather test-infrastructure issues: races with boot-time code, missing
bounds checks, resource leaks, and sysfs duplicate-name splats.

This series fixes them one by one so that a clean kunit run no longer
leaves noise in dmesg:

 1. init/initramfs_test races with the async rootfs unpacker; add
    wait_for_initramfs() in suite .init.
 2. kfence kunit cases fail outright when the pool is unavailable;
    skip them instead.
 3. intlog2(0) / intlog10(0) hit a WARN_ON that is harmless; remove it.
 4. kunit_platform_device_add() triggers sysfs_warn_dup() on the
    duplicate-registration test; catch duplicates early in the kunit
    helper (best-effort; final protection remains in driver core/sysfs).
 5. misc_register() likewise hits sysfs_warn_dup(); reject duplicate
    names explicitly. misc->name is never NULL at this point since the
    existing code already dereferences it unconditionally.
 6. hw_breakpoint test_many_cpus overflows its array on machines with
    many cores; bail out at the limit.
 7. test_ratelimit stress test checks the wrong variable for kthread
    creation, leaks memory, and races on doneflag. Use goto-based
    cleanup to guarantee all started threads are stopped on failure.

All patches are independent and can be applied/reviewed separately.
Tested on arm64 Neoverse N2 (128-core arm64) with
CONFIG_KUNIT=y and CONFIG_KUNIT_ALL_TESTS=y.

Jia He (7):
  init/initramfs_test: wait_for_initramfs() before running
  kfence: kunit: skip when no pool is available
  lib/math/int_log: drop WARN_ON for value == 0
  kunit: platform: catch duplicate (name, id) in kunit_platform_device_add()
  misc: reject duplicate names in misc_register()
  hw_breakpoint_test: fix test_many_cpus failure on large systems
  lib/tests: test_ratelimit: fix stress test thread lifecycle and leak

 drivers/char/misc.c                |  22 ++++++++++++++++++
 init/initramfs_test.c              |  17 +++++++++++++-
 kernel/events/hw_breakpoint_test.c |  12 ++++++++++
 lib/kunit/platform.c               |  36 +++++++++++++++++++++++++++++
 lib/math/int_log.c                 |   8 ++-----
 lib/tests/test_ratelimit.c         |  26 ++++++++++++++++-----
 mm/kfence/kfence_test.c            |   6 +++--
 7 files changed, 115 insertions(+), 12 deletions(-)
