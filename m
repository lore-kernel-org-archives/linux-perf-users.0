Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164DD3B52EF;
	Fri,  2 Oct 2026 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936527; cv=none; b=Nl7n/AWZ0c/NifxUb95Nl19gbr7eOtUujaX0uJkfeCcj99ZzwfoNfb3MUsY2dWXPTJdy0R0T1eazowbfM4Wgc6UTAR9/11eG1KRP0NCvcdaF4g0ROFIJ9AWcAUT3JrP//ssDeBUnUe8la1y2m7aXFZ7UswhJHSkCK0VrKO95rpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936527; c=relaxed/simple;
	bh=1/jV/DYFh6nfJjFWVdERFwhIgob38Jou7XJO721gAz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhgHdgIFdgrKxXiBjMK983xMZjeat21hXHKn5kQJwn02x5z7rto65G2+gDyD2vVhoLDcijqrxKYNQcAM1caUa9uXCWZb1T2hK5Enmf8yS2kEqRJ6j0wUChRC6OsUqI5qJz9wM+jJpbdMyRkoWOrk7SqRA7QM3OYqAHYtS6j79dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D07SU6Ca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D07SU6Ca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9161F000FF;
	Fri,  2 Oct 2026 10:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936525;
	bh=2kP2SZcWPJ768aWyS0vyXzgJo6Adw6WVYJKQWTRUmM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D07SU6Ca1PXHJAzaD3YWk1Avq59c2aAWl00rw3yaADF5KV9F3EX/jMy/q7S5BtYiA
	 pTyCGZm0ux2o+JlQOK4erReGHGbfscJiKjmRLPX5J7i34Oo1r1WqNdxv1J5r2uVP97
	 BS2qxH+DfPxJ7vbZfw3pS9Jwb9Znmp+CYrgKBt+WugZpQ2X2WGEVMBNB33bRcv2TVW
	 1HnqyBTSEvPhPPZpsV5fgUeBOucRXzyiF1ei7UeRUOMaGPMmdV6AtQR0nzAGdS5W8z
	 A+XwgpStVdt/MaeUz++hQQoAVLihFOwwVElNPCYjnysShwG+rYzTRnkZlaGoJMBNlb
	 8kVQXFAJOhhdA==
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
Subject: [PATCH v8 4/9] perf mutex: Add DO_ONCE() for one-time initialization
Date: Fri,  2 Oct 2026 12:21:05 +0200
Message-ID: <20261002102110.27587-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002102110.27587-1-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
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

The lockless fast path reads ___done with
__atomic_load_n(..., __ATOMIC_ACQUIRE), paired with the
__atomic_store_n(..., __ATOMIC_RELEASE) store after fn(), so that its
side effects are visible to threads that take the fast path; the
__atomic builtins over the smp_load_acquire()/smp_store_release()
variants because ThreadSanitizer understands the builtins, avoiding
reports on ___done and on what fn() initialized.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mutex.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index b85a80ad60386aed..ef1ab6dd8c09556f 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -95,6 +95,30 @@ struct LOCKABLE mutex {
 /* Statically initialized mutex, for the file scope ones. */
 #define DEFINE_MUTEX(name) struct mutex name = { .lock = PTHREAD_MUTEX_INITIALIZER }
 
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

