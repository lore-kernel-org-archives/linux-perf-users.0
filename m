Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1F48C8C4;
	Tue,  6 Oct 2026 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298675; cv=none; b=lWUM1oUe7CZilZOZXvDaKstsR+whl77ffv5RKeT7jHq7JSdJiMCss70TUTU6/xj8vl4BZB3pWjItEyta6kBKOYRjDnS7Tjxkh2sl4EGNjz9Td2Bcafet5sDNFhkZz10wErNeoZZXIk8SN/XNs+i9mRmz5ZHQ4v9FoePSJioJ7NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298675; c=relaxed/simple;
	bh=YqEtDNP2HV0mLPxH10/gbf1H72RTgVr948823/q4Boo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOsTaxgtj6kbbBrm7LlacE1HZJqmDfYv4Z9b3uTeHKjZ5UMRbDy9eyVgXcoxgnNYMPI7zshHswkcjPJnMFfIcPGzDqPk8EpgJtvweBr/YkGQDiP7YXhZGFmBid+3zHbc7FsIbQ949pFjS6d18v/qhC0/Oz2yjgzzS5wtAznIpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMweqZoh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMweqZoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CBF1F0089B;
	Tue,  6 Oct 2026 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298674;
	bh=BgRyqkmROtB9xJY3E+pxWBtSxAVsrJ/0mFxXQxPkYng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IMweqZohtXAzytIdRZPZE53JbwUB0FqOj13hqAIZWjGSltAjFrFkhzv/GqfnqTI7q
	 1CJRNHiVt28ndrZAiA2a+mNUXrOWETWUNGbAtmQzAxgGHQ6dYnfnzvySwRGeqJqnd4
	 9tcv1mMIPVKPslxuNqQ6fZ1TtNEjNy554ZYWIDbRRjkpju8nR1y3L9yerfVVzWuxe+
	 NeOh5V28eVxE4yCCZRzf1iLkc8pIRTTV/nPUvVp0Rq3mXyVhC2088oxiZDaNODe/ms
	 9Lhplr2CzPKrTK3dK1YSEBlQUzWdpvJG0LxuJ91mjjqp9Lt/lrC6mtcys3+QGme1zp
	 nAsR1ANxJjPWQ==
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
Subject: [PATCH 4/8] perf mutex: Add DO_ONCE() for one-time initialization
Date: Tue,  6 Oct 2026 16:57:25 +0200
Message-ID: <20261006145729.3028247-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006145729.3028247-1-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For lazy init that more than one thread can race into, without
pthread_once() so that it stays within perf's locking primitives and
clang's -Wthread-safety keeps an eye on the mutexes involved.

Mirrors the kernel's include/linux/once.h DO_ONCE(), dropping its
static key fast path, unnecessary at these cold init paths: a per call
site static bool plus a statically initialized mutex, double checked.
As there, code reachable from more than one call site must go through
a common helper.

The lockless fast path reads ___done with an acquire, paired with a
release store after fn(), so that fn()'s side effects are visible to
threads taking the fast path, which the dropped static key used to
guarantee.

The __atomic builtins are used rather than smp_load_acquire()/
smp_store_release() because ThreadSanitizer understands them,
avoiding reports on ___done and on what fn() initialized.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mutex.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index fe04db21d19c5b0b..5554937675886ef3 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -104,6 +104,30 @@ struct LOCKABLE mutex {
 #endif
 #define DEFINE_MUTEX(name) struct mutex name = { .lock = __PERF_MUTEX_INITIALIZER }
 
+/*
+ * Runs fn() exactly once however many threads race to it, the rest wait
+ * for it to finish; per call site state, so multiple sites wanting the
+ * same once use a common helper, as in the kernel's DO_ONCE().
+ */
+#define DO_ONCE(fn, ...)						       \
+	({								       \
+		static bool ___done;					       \
+		static DEFINE_MUTEX(___once_lock);			       \
+		bool ___ret = false;					       \
+									       \
+		if (!__atomic_load_n(&___done, __ATOMIC_ACQUIRE)) {	       \
+			mutex_lock(&___once_lock);			       \
+			if (!___done) {					       \
+				fn(__VA_ARGS__);			       \
+				__atomic_store_n(&___done, true,	       \
+						 __ATOMIC_RELEASE);	       \
+				___ret = true;				       \
+			}						       \
+			mutex_unlock(&___once_lock);			       \
+		}							       \
+		___ret;							       \
+	})
+
 /* A wrapper around the condition variable implementation. */
 struct cond {
 	pthread_cond_t cond;
-- 
2.55.0

