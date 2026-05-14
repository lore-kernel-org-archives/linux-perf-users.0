Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A06C3AD538;
	Thu, 14 May 2026 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735287; cv=none; b=GxRvlO+Tkr+zdOR9qm8W/xK/h3qrgFSTs7UYQ6exML+Ohm/bFuxXn+Jn5YsrKKmpiaGO3qrh1TjUhvCPya98FVcbknSaLIQUsRrbSMvuuYpTFe3uvvbCP/8rw+L/cUUEOLjNi6TE2fopDa/Ni9uxP7SXia+FDyK7tqNx+Dlc8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735287; c=relaxed/simple;
	bh=i4bByhR3/GFn5EdsOuSs2aNtMnt37PAf+rz4tzgOO5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUco6YYjgYweEiJlnKEKBzRQ6jIOun1TPUfC3kAEqUYiMECQ5bSc2t8ihAC9vnaI5+SU+MhViuKQpEnfXep6VTkEyIN6i8M4e5bsMe9EG6HCeP0WuN0cddJ0hoDQJEGbD8AfZuZ7Nd7U/HZltmJ+woMwBxqqUcQrx1pLJAER+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cJgfkrqj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cJgfkrqj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CCA61655;
	Wed, 13 May 2026 22:08:00 -0700 (PDT)
Received: from entos-yitian-01.Arm.com (unknown [10.168.197.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2E9F3F7B4;
	Wed, 13 May 2026 22:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778735285; bh=i4bByhR3/GFn5EdsOuSs2aNtMnt37PAf+rz4tzgOO5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cJgfkrqjF4tm9WRMUGgxzSWx/aIjRhFMv+ZZmwwkUccWMLOjzt+2qB/zt9dbgQKnT
	 VFVuNrhwmSE2wQVt7y+3ZuYXRDIB5w+f3SKI5bKovaizZe7rdeyjGhvmf0WxlXiRVm
	 U9BO0xWYArD/yhGbOFKPq0eNKZMHnjJbZ7Tn/0fM=
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
Subject: [PATCH 6/7] hw_breakpoint_test: fix test_many_cpus failure on large systems
Date: Thu, 14 May 2026 05:04:54 +0000
Message-Id: <20260514050455.2954509-7-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514050455.2954509-1-justin.he@arm.com>
References: <20260514050455.2954509-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems with many CPUs (e.g. 128 cores x 4 HW breakpoint slots =
512 = MAX_TEST_BREAKPOINTS), test_many_cpus() advances idx to
MAX_TEST_BREAKPOINTS after the last fill_bp_slots(). The subsequent
register_test_bp() call hits WARN_ON(idx >= MAX_TEST_BREAKPOINTS),
returns NULL, and the -ENOSPC expectation fails.

Bail out of the loop when idx reaches the limit. Earlier iterations
already validate the NOSPC path on other CPUs.

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org

Signed-off-by: Jia He <justin.he@arm.com>
---
 kernel/events/hw_breakpoint_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
index 2cfeeecf8de9..943d040d2224 100644
--- a/kernel/events/hw_breakpoint_test.c
+++ b/kernel/events/hw_breakpoint_test.c
@@ -137,6 +137,9 @@ static void test_many_cpus(struct kunit *test)
 	for_each_online_cpu(cpu) {
 		bool do_continue = fill_bp_slots(test, &idx, cpu, NULL, 0);
 
+		if (idx >= MAX_TEST_BREAKPOINTS)
+			break;
+
 		TEST_EXPECT_NOSPC(register_test_bp(cpu, NULL, idx));
 		if (!do_continue)
 			break;
-- 
2.34.1

