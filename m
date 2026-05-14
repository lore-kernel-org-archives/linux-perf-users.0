Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D63B95F0;
	Thu, 14 May 2026 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735229; cv=none; b=KuY7AfiqVHQKJQFmDJ7k7NAs9cV5sIVBVluZRxCrFNsHo5BHUNPYyjdxU4N3EQ5bml+wVq5sWFDOhQQQfBVnFf5hw9KvzUUvhny1qxTzL8+2x4P0mBg+0A7dWs60f8ZHHKjOoQawim8vmS5i5cVuuJPHRUhMdgZ19ZQ35Zgm28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735229; c=relaxed/simple;
	bh=BANIRIqsq1p4Sc4QnkiivpJhCJpebYuZdrDjdfih8k8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTZ6S8/8G9A6dR1OH/hAYV3C8IBYYAi9R5S4XCPRwbEtXJ97CMJPMNKFqfRd8taz06XwMAjJbYgLKkZ3yFsYu+ebBNue7CiJ+su6B3pcf5IYl6ZFEj2uF8JzqMwFz7LwLY7Tg72svLGonLtsTSH626Q5w/+FgUha+wvECM+BuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=u6aPQJ7B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="u6aPQJ7B"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A8634FE;
	Wed, 13 May 2026 22:06:59 -0700 (PDT)
Received: from entos-yitian-01.Arm.com (unknown [10.168.197.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3BAE3F7B4;
	Wed, 13 May 2026 22:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778735224; bh=BANIRIqsq1p4Sc4QnkiivpJhCJpebYuZdrDjdfih8k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6aPQJ7BZumqfz7tiHCCZ5t+ueVed1AOrEwtNEyTCj+4NwgHp4vP4fA6JCwowBPef
	 g040pef32i4nOIkeFUYUReBkJGPP7GNHe9Ep2/337vVuPkKKUbMnw/ebiHUnzEX17l
	 UJMfvVR4OtpSKlNBiTseH8qZl1SU/yS+4JiOqAK4=
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
Subject: [PATCH 2/7] kfence: kunit: skip when no pool is available
Date: Thu, 14 May 2026 05:04:50 +0000
Message-Id: <20260514050455.2954509-3-justin.he@arm.com>
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

When KFENCE is compiled in but disabled at boot (KFENCE_SAMPLE_INTERVAL=0)
or __kfence_pool is not allocated, every kfence kunit case fails with
-EINVAL.

Use kunit_skip() so they are reported as skipped instead.

To: Alexander Potapenko <glider@google.com>
To: Marco Elver <elver@google.com>
To: Dmitry Vyukov <dvyukov@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org

Signed-off-by: Jia He <justin.he@arm.com>
---
 mm/kfence/kfence_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 5725a367246d..e376329dd621 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -822,8 +822,10 @@ static int test_init(struct kunit *test)
 	unsigned long flags;
 	int i;
 
-	if (!__kfence_pool)
-		return -EINVAL;
+	if (!__kfence_pool) {
+		kunit_skip(test, "kfence pool not allocated or kfence not enabled");
+		return 0;
+	}
 
 	spin_lock_irqsave(&observed.lock, flags);
 	for (i = 0; i < ARRAY_SIZE(observed.lines); i++)
-- 
2.34.1

