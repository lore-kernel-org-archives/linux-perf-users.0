Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20683BA222;
	Thu, 14 May 2026 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735306; cv=none; b=KlBVpWtRWCxMZdoRcJH4k+4AFxWWYIHq70muVZzjN8Wgx9bgQekeHevnBNxZ9VB3zJrygi2un0WulMqxxsD1wyki5OpYQBgoDBcUyGM7exH8vFv+vqAt15sU4VFc9pUDhUhD2P3rmYtj9Zi0UbpQ4qT6KrS0pJq5kDVIKfMk+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735306; c=relaxed/simple;
	bh=pDv1PUPolI9yQCaKV1T3osAxs2BPPEuIIJYZ+6qnyXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ueWbhY/Rr1GRwMbLA1c/HXpZiPzyXPFc7bAnQ2PK6oaqp+pPZwLrKahCNz5DVERbyRoZVcRCrVNR3z0JZ48zs+/GckvH4B9MRXjj0jYsvwi04jkgHFurNWLZSLdQ77Ei6oiaKVhyWTZjW+XKATMSgfil7s6eYmgTVSr+ew4F11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C0FOIuVq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C0FOIuVq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E208C1655;
	Wed, 13 May 2026 22:08:16 -0700 (PDT)
Received: from entos-yitian-01.Arm.com (unknown [10.168.197.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0871F3F7B4;
	Wed, 13 May 2026 22:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778735302; bh=pDv1PUPolI9yQCaKV1T3osAxs2BPPEuIIJYZ+6qnyXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0FOIuVqM3n4lVlgYpvHk8RRPKzDD5+SduOW3q83jwCz6q2il5Md6IfZb/iTGZ+os
	 oKQNS84VmZM5y6W3KgNvgdeqB3HnAzkFR8cCydg4B+9Xw5pvpjyQwls0oktpX798tq
	 tl5eo8RIyC5bwHKsuNhKjV/dYBNj9pKBlY3VZbvY=
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
Subject: [PATCH 7/7] lib/tests: test_ratelimit: fix stress test thread lifecycle and leak
Date: Thu, 14 May 2026 05:04:55 +0000
Message-Id: <20260514050455.2954509-8-justin.he@arm.com>
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

The kthread return value was checked against the wrong variable (sktp
instead of sktp[i].tp), so WARN_ON_ONCE(!sktp->tp) fired at line 87.

Replace kthread_run() with kthread_create()+wake_up_process() so the
return value can be validated before assigning to sktp[i].tp. On
creation failure, jump to a common cleanup path that signals doneflag,
stops all already-started threads, and frees sktp. This avoids leaving
orphan kthreads and leaked memory when a mid-loop failure occurs.

Also reset doneflag before spawning threads so back-to-back test
invocations don't race on stale state.

To: "Paul E. McKenney" <paulmck@kernel.org>
To: Petr Mladek <pmladek@suse.com>
To: Kees Cook <kees@kernel.org>

Signed-off-by: Jia He <justin.he@arm.com>
---
 lib/tests/test_ratelimit.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/lib/tests/test_ratelimit.c b/lib/tests/test_ratelimit.c
index 33cea5f3d28b..64f26260c0d8 100644
--- a/lib/tests/test_ratelimit.c
+++ b/lib/tests/test_ratelimit.c
@@ -105,26 +105,44 @@ static void test_ratelimit_stress(struct kunit *test)
 	const int n_stress_kthread = cpumask_weight(cpu_online_mask);
 	struct stress_kthread skt = { 0 };
 	struct stress_kthread *sktp = kzalloc_objs(*sktp, n_stress_kthread);
+	int n_started = 0;
 
-	KUNIT_EXPECT_NOT_NULL_MSG(test, sktp, "Memory allocation failure");
+	KUNIT_ASSERT_NOT_NULL_MSG(test, sktp, "Memory allocation failure");
+	WRITE_ONCE(doneflag, 0);
 	for (i = 0; i < n_stress_kthread; i++) {
-		sktp[i].tp = kthread_run(test_ratelimit_stress_child, &sktp[i], "%s/%i",
-					 "test_ratelimit_stress_child", i);
-		KUNIT_EXPECT_NOT_NULL_MSG(test, sktp, "kthread creation failure");
+		struct task_struct *tp;
+
+		tp = kthread_create(test_ratelimit_stress_child, &sktp[i],
+				    "%s/%i", "test_ratelimit_stress_child", i);
+		if (IS_ERR(tp)) {
+			KUNIT_FAIL(test, "kthread_create failed: %ld", PTR_ERR(tp));
+			goto out_stop;
+		}
+
+		sktp[i].tp = tp;
+		wake_up_process(tp);
+		n_started++;
 		pr_alert("Spawned test_ratelimit_stress_child %d\n", i);
 	}
 	schedule_timeout_idle(stress_duration);
+
+out_stop:
 	WRITE_ONCE(doneflag, 1);
-	for (i = 0; i < n_stress_kthread; i++) {
+	for (i = 0; i < n_started; i++) {
 		kthread_stop(sktp[i].tp);
 		skt.nattempts += sktp[i].nattempts;
 		skt.nunlimited += sktp[i].nunlimited;
 		skt.nlimited += sktp[i].nlimited;
 		skt.nmissed += sktp[i].nmissed;
 	}
-	KUNIT_ASSERT_EQ_MSG(test, skt.nunlimited + skt.nlimited, skt.nattempts,
-			    "Outcomes not equal to attempts");
-	KUNIT_ASSERT_EQ_MSG(test, skt.nlimited, skt.nmissed, "Misses not equal to limits");
+	if (n_started == n_stress_kthread) {
+		KUNIT_ASSERT_EQ_MSG(test, skt.nunlimited + skt.nlimited, skt.nattempts,
+				    "Outcomes not equal to attempts");
+		KUNIT_ASSERT_EQ_MSG(test, skt.nlimited, skt.nmissed,
+				    "Misses not equal to limits");
+	}
+
+	kfree(sktp);
 }
 
 static struct kunit_case ratelimit_test_cases[] = {
-- 
2.34.1

