Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A041BA72;
	Sun,  4 Oct 2026 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109314; cv=none; b=fHu0+fP9B/ErgBdSY15ym2xEP2PszsDrh6wtkPvRCbFbZcOsKUcPg+IyvormSuHTp6WGaXw2G9rYcD+h2ZMQ/8HUMJ2kMHSbq6Ht7n9WqHhlE6W2YlMo5qWnRqDAj2HL/ZppWl8HzVFi6JqX6/HLBe2Xjf9456pdnvEvJ0RLEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109314; c=relaxed/simple;
	bh=04nKJxb7KBkfm5qtc3Gm0+HVdy1gaDWmg5x6ec/HShA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsjPWJSsshMy/DJQQW1ju6ijyM65GL4oVQJkYaI8QRqngBiPp94u2+cSZRzi/78cSwIC0PQolqyCjgbeeQtNACGzvBjxpgA9L/dUaLvZQktbXbr4k8BJ3/nCHl3ycjrwZwOlbopFs8K5L0PWSJzuR1vnmOoSkPCqvKsDTRP+Qes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agimpmMD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agimpmMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C69F1F00893;
	Sun,  4 Oct 2026 10:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109312;
	bh=qDnbwqNz/qkKaYJQY1gH1IVgC/6lZFFcRASabjBz9q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=agimpmMDR8OWkr6Ehw5hASPKJd4Pn/JCLSi1ZfXHqjFqaEcvVcBgOwgXgGoGLV29a
	 2yDYuaogbCmJXvhTm6NZpe/stDU9xZZCRydEBib8pt8obAwF27NHl8vWeze/l0A/RG
	 a1Gr/6aiqr71CLFT/7jtXuGsUTTs5g+YOSIgFN9xkyLSsVsA+tBiu4jwuaHiNcKbJR
	 4KRVSsCVb2amIC2145wus0id8u8tNOKYfzoxMHWhZYA2LnTbT3cxD7XfQQnxgZQsl8
	 FPwjJtLo9i44UOaDndQ+k7beZSyj+GJg7xoernVogqWZvq7MlExurj3tySVYxa4WJu
	 d48QQF8XX33vg==
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
Subject: [PATCH v10 3/9] perf mutex: Add DEFINE_MUTEX() static initializer
Date: Sun,  4 Oct 2026 12:21:27 +0200
Message-ID: <20261004102133.26392-4-acme@kernel.org>
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

For file scope mutexes, so that they don't need a constructor function
to initialize them at startup, mirroring PTHREAD_MUTEX_INITIALIZER
while keeping the clang -Wthread-safety annotations of struct mutex.

DEBUG=1 builds have mutex_init() set PTHREAD_MUTEX_ERRORCHECK, making
the CHECK_ERR() paths in mutex_lock()/mutex_unlock() report relocking a
held mutex and unlocking one that isn't held.  PTHREAD_MUTEX_INITIALIZER
gives a default type mutex, so statically initialized ones would silently
lose that: use PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP, a glibc
extension, falling back to the default type in libcs that lack it.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mutex.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 70232d8d094f8bfc..fe04db21d19c5b0b 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -92,6 +92,18 @@ struct LOCKABLE mutex {
 	pthread_mutex_t lock;
 };
 
+/*
+ * Statically initialized mutex, for the file scope ones. Error checking
+ * in !NDEBUG builds, like mutex_init(); the glibc-only errorcheck
+ * initializer falls back to the default type elsewhere.
+ */
+#if !defined(NDEBUG) && defined(PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP)
+#define __PERF_MUTEX_INITIALIZER PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
+#else
+#define __PERF_MUTEX_INITIALIZER PTHREAD_MUTEX_INITIALIZER
+#endif
+#define DEFINE_MUTEX(name) struct mutex name = { .lock = __PERF_MUTEX_INITIALIZER }
+
 /* A wrapper around the condition variable implementation. */
 struct cond {
 	pthread_cond_t cond;
-- 
2.55.0

