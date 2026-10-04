Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377F39CCF2;
	Sun,  4 Oct 2026 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109317; cv=none; b=Ifv9myu0xzMkJ7gcM3UVYrpzsnFXuTjKVHHB7HAlXMmdLIKV97M/KQsyirGLtCrz3Wcp6CHjHxTWKsvCqoL09Eovp7fmxn/RcXmEA3zFmhhGWAD9jzV4SSxxXsu8890qyAMm2C5jaJZkIRnTdpUhCOPOScC4iMSoYQa+jIqrg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109317; c=relaxed/simple;
	bh=YqEtDNP2HV0mLPxH10/gbf1H72RTgVr948823/q4Boo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECvqS6e84ST7jwtThHT0mvCX0uRHCXqsPwU4Qtl0Zm1ituWknIPCX5e0m5VzBzXCUFucVxBVQF2SS89x3iBkqg0Gq0HzG5tU5xWbnSC2jMxhXtRWuFzwq5U/ola2eg7KsPp+WFH/5Oq/dumG5fr5ItkxJpfgPeSqm0UIwB8e8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioNPsJmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioNPsJmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2D11F000FF;
	Sun,  4 Oct 2026 10:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109316;
	bh=BgRyqkmROtB9xJY3E+pxWBtSxAVsrJ/0mFxXQxPkYng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ioNPsJmQPlCR9Q6PQkrab84xgVAPa7sVKi6BwfTdrd4sJgKpe7++aiO/3r4NdsBXK
	 pyP8LZeJI1k/rWFtgF/i6fApneqTi7FBsgUEbbwoxWepEggq9dMNZnhSj6MgnJLLNC
	 xmqAGrQWiKyqjZAH7pZUfA0rcNN0b1CHFmQrfA4DRfbCVh6m2Ew0/ilSPlM32KpQSm
	 WlGKjAJ7IkP9+RXYBIZLbg1dsQ3nsXO06Tuq8Wu/7RhctrZAYRXP7n/ggx5v2YqPWz
	 FW3vI2LwtceowmawWeIXB9JAsRh8/gZa0g5C7Ih/kG7wSfF9QJLDkhlIDP7PjEp66d
	 Zm0IKFE9kcE7Q==
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
Subject: [PATCH v10 4/9] perf mutex: Add DO_ONCE() for one-time initialization
Date: Sun,  4 Oct 2026 12:21:28 +0200
Message-ID: <20261004102133.26392-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004102133.26392-1-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
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

